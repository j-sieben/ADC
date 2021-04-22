// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.0
 * @classdesc
 * <p>This plugion delegates the maintenance of the visual state of the page items and all JavaScript related
 * activity of the form to a rule set within the database. To achieve this goal, the database offers a rule
 * set of business rules. These business rules control rule actions which fire if the respective rule is selected.
 * Selection of rules is based on the actual status of the user data entry.</p>
 * <p>ADC calculates a response consisting of JavaScript actions which are performed on the page.<br>
 * A rule within the database may cause recursive rules to be executed based on the action they take. Therefore, 
 * even complex validations and processing can be done with a single round trip to the database.</p>
 * <p>To work, this plugin only requires one (optionally two) parameters:
 * <ul><li>The name of the rule group that is related to this APEX page</li>
 * <li>Optionally a list of page items which shall be deactivated if ADC recognizes any error on the page, based on user data input</li></ul></p>
 */
(function (adc, $, server) {
  "use strict";

  /**
   * @typedef {Object} error
   * @description
   * <p>An error is a JSON object representing an error. It contains information about the error message, the affected page item and additional
   * information that shows only if the page is rendered in debug mode.</p>
   * @type Object
   * 
   * @property {string} item Page item that is affected by this error
   * @property {string} message Error message
   * @property {string} additionalInfo Developer information, normally call stack and internal error name
   */

  /**
   * @typedef {Object} errorList
   * @desc
   * <p>An errorList is a collection of errors that occurred on the page. It also contains arrays for error dependent items (i.e. items that 
   * have to be disabled if an error occurred on the page) and firingItems. Firing items provide information about page items that have been
   * "touched" by executed rules. Intention is to remove any error that is related to a firing item from the collection of errors on the page
   * and replace it with the newly provided error message, if any. This way, error messages which don't apply are removed, but errors relating
   * to other page items on the page stay on page.</p>
   * @type Object
   * 
   * @property {string} count Amount of errors
   * @property {string[]} firingItems Array of page items that are affected by the executed rules. Used to remove errors that
   *                                  refer to these page items before adding new errors
   * @property {error[]} errors Array of error instances
   * @param {Object} adc This code
   * @param {Object} $ jQuery instance of APEX
   * @param {Object} server apex.server instance
   */

  
  var
    eventData = { 'ajaxIdentifier': adc.ajaxIdentifier, 'pageItems': adc.pageItems },
    triggeringElement = { 'id': '', 'event': '', 'data': '', 'isClick': false },
    C_CHANGE_EVENT = 'change',
    C_CLICK_EVENT = 'click',
    C_KEYPRESS_EVENT = 'keypress',
    C_ENTER_EVENT = 'enter',
    C_APEX_REFRESH = 'apexrefresh',
    C_APEX_BEFORE_REFRESH = 'apexbeforerefresh',
    C_APEX_AFTER_REFRESH = 'apexafterrefresh',
    C_APEX_AFTER_CLOSE_DIALOG = 'apexafterclosedialog',
	C_IG_SELECTION_CHANGE = 'interactivegridselectionchange',
    C_NO_TRIGGERING_ITEM = 'DOCUMENT',
    C_BODY = 'body',
    C_BUTTON = 'button',
    C_APEX_BUTTON = 't-Button';

  /** APEX unique identifier for the dynamic action
   * @public
   */
  adc.ajaxIdentifier = {};

  /** List of page items that received changes lately
   * @public
   */
  adc.lastItemValues = {};


  /** Locks a button to prevent a second click before the action is processed completely
   * @private
   */
  function lockButton() {
    if (triggeringElement.isClick) {
      apex.item(triggeringElement.id).disable();
      // Clear event queue to prevent multiple clicks before the dynamic action has returned
      $(C_BODY).clearQueue();
    };
  };


  /** Callback method for a change event
   * Any event is pushed to a queue to process them one by one, depending on the outcome of the predecessor.
   * As an example, if a page item is focussed and the user clicks on a button, two events occur:
   * <ol><li>change event on the page item</li><li>click event on the button</li></ol>
   * If the change event triggers a computation that returns an error (such as a page item validation), in many cases the click event
   * of the button must not be processed anymore. But because these events appear so quickly, ADC is unable to respond before the 
   * click event is handled. Therefore, these events a queued. If ADC returns with an error, the queue is cleared and the next events
   * will not be processed.
   * @private
   */
  function changeCallback(e, data) {
    getTriggeringElement(e);

    $(C_BODY).queue(function () {
      adc.execute(e, data);
    });
  };


  /** Wraps the call to the database in a confirmation dialog to enable the user to surpress this event
   * @param {event} e Event that occured
   * @private
   */
  function confirmCallback(e) {
    getTriggeringElement(e);

    $(C_BODY).queue(function () {

      lockButton();
      // Handle event only after confirmation from the user
      adc.ApexJS.confirmRequest(e, changeCallback);
    });
  };


  /**
   * Method adds a page item to a list of page items to be sent to the server with every call
   * @param {string} itemName Name of the page item that ahould be added
   * @private
   */
  function addPageItem(itemName) {
    if ($.inArray(itemName, adc.pageItems) === -1) {
      adc.pageItems.push(itemName);
    };
  };

  /**
   * Binds an event to a page item
   * @param {string} item Name of the element to bind
   * @param {string} event Event that is bound.
   * @param {function} action Optional callback method. Overrides default behaviour of calling changeCallback()
   */
  function bindEvent(item, event, action) {
    if (item.search(/[\.# :\[\]]+/) < 0) {
      item = `#${item}`;
    }

    var $this = $(item);

    if ($this.length > 0) {
      // Check whether element exists on page (could be missing due to a server condition)
      var eventList = $._data($this.get(0), 'events');
      var callback = typeof action != 'undefined' && action.length > 0 ? new Function(action) : changeCallback;
	  
	  // ADC unbinds event handlers bound to this item to prevent problems between the different handlers
	  $this
	    .off(event)
	    .on(event, eventData, callback);
	  if (event == C_CHANGE_EVENT) {
	    // CHANGE event should not be called after APEXREFRESH, so pause it until apexafterrefresh
	    $this
	    .on(C_APEX_BEFORE_REFRESH, function (e) {
		  $(this).off(C_CHANGE_EVENT);
		  apex.debug.info(`Event "${C_CHANGE_EVENT}" paused at ${item}`);
		})
		.on(C_APEX_AFTER_REFRESH, function (e) {
		  $(this).on(C_CHANGE_EVENT, eventData, callback);
		  apex.debug.info(`Event "${C_CHANGE_EVENT}" re-established at ${item}`);
		});
	  };
    };
  };


  /**
   * Binds all events that are requested by the plugin via adc.bindItems. 
   * Upon initialization, all relevant page items are collected along with the required events.
   * This method then binds all items with the respective event.
   * As per default, changeCallback is bound as the callback method which in turn sends a request to the database ruleset
   */
  function bindEvents() {
    $.each(adc.bindItems, function () {
      bindEvent(this.id, this.event, this.action);
      if (this.event == C_CHANGE_EVENT) {
        addPageItem(this.id);
      }
    });
  };


  /**
   * Method identifies all elements whose values shall be sent to the database with any request.
   * Two possible ways exist to add an item to this observer list: 
   * <ul><li>Initialization code of the plugin that automatically detects items that have a value and are referenced by page rules</li>
   * <li>Explicit observation as requested by a ADC rule action</li></ul>
   * The second option calls this method
   * @param {string} selector jQuery selector to identify the item(s) that shall be observed explicitly
   * @private
   */
  function bindObserverElements(selector) {
    var selectorList;
    if (selector) {
      selectorList = selector.split(',');
      $.each(selectorList, function (idx, element) {
        if (this.substring(0, 1) == '.') {
          $(element).each(function (idx, element) {
            addPageItem($(element).attr('id'));
          });
        }
        else {
          if ($.inArray(element, adc.pageItems) === -1) {
            adc.pageItems.push(element);
          };
        };
      });
    };
  }


  /**
   * Method to persist the value of a page item
   * When a call to refres a page item is issued, the value of this item is reset to NULL by APEX.
   * This method allows to store the value of the item before refreshing it and to reset it to this value after refresh.
   * @param {string} item ID of the page item. Perceived to be unique
   * @private
   */
  function findItemValue(item) {
    var result = $.grep(adc.lastItemValues, function (e) {
      return e.id == item;
    });

    if (result.length > 0) {
      return result[0].value;
    }
  };


  /**
   * Method to cast a hex-string representation created with UTL_RAW.CAST_TO_RAW back to String
   * @param {hexString} rawString 
   * @returns Converted String
   * @private
   */

  function hexToChar(rawString) {
    var code = '';
    var hexString;
    if (rawString) { }
    hexString = rawString.toString();
    for (var i = 0; i < hexString.length; i += 2) {
      code += String.fromCharCode(parseInt(hexString.substr(i, 2), 16));
    };
    return code;
  }

  /**
   * Method to describe the event and calling item after an event has occured
   * @param {event} e 
   * @private
   */
  function getTriggeringElement(e) {

    // Copy event data to a local variable to allow for tayloring
    triggeringElement.id = C_NO_TRIGGERING_ITEM;
    triggeringElement.event = e.type;
    triggeringElement.data = e.data;

    if (typeof e.target != 'undefined') {
      switch (triggeringElement.event) {
        case C_CLICK_EVENT:
          // Flag is used to clear the event queue to prevent multiple clicks
          triggeringElement.isClick = true;
          //TODO: Ursache dafür finden, dass target.id für Buttons manchmal leer ist. WA: currentTarget.id nutzten
          triggeringElement.id = e.target.id != '' ? e.target.id : e.currentTarget.id;

          if (triggeringElement.id == '') {
            // Some browsers send accessKey-span instead of triggering element in response to a click
            // Get the parent elemnt in these cases
            triggeringElement.id = e.target.parentElement.id;
          };
          var $button = $(`#${triggeringElement.id}`);
          // Depending on how a click event was raised (mouse or code), a different item is addressed
          if (!$button.hasClass(C_APEX_BUTTON)) {
            $button = $(`#${triggeringElement.id}`).parent(C_BUTTON);
          };
          break;
        case C_APEX_AFTER_CLOSE_DIALOG:
          // CloseDialog is bound to currentTarget to allow for delegate events.
          triggeringElement.id = e.currentTarget.id;
          break;
        case C_KEYPRESS_EVENT:
          triggeringElement.id = e.target.id;
          // If the ENTER-key was pressed, the event type is change to "enter" to allow for easy detection within ADC
          switch (e.keyCode) {
            case 13:
              triggeringElement.event = C_ENTER_EVENT;
            // add other key codes here if necessary
          }
        case C_CHANGE_EVENT:
          triggeringElement.id = e.target.id;

          var $element = $(`#${triggeringElement.id}`);
          if ($element.attr('type') == 'radio' || $element.attr('type') == 'checkbox') {
            // In case of a radio group or a checkbox, the id has to be taken from the parent fieldset
            triggeringElement.id = $element.parents('fieldset').attr('id');
          }
        default:
          triggeringElement.id = e.target.id;
      };
      apex.debug.info(`Event "${triggeringElement.event}" raised at Triggering element "${triggeringElement.id}"`);
    }
  };

  /**
   * Method to execute all JavaScript code passed in with the response of ADC
   * The code is added to the document using $.append which immediately executes any JavaScript.
   * After appending, the response can be deleted because it does not make any sense to store it on the page any further
   * After deleting, the execute method raises the next event on the queue (if any)
   * @param {string} code JavaScript code to execute
   * @private
   */
  function executeCode(code) {
    if (code) {
      console.log('Response received: \n' + code);
      $(C_BODY).append(code);
	  var ScriptSelector = '#' + $(code).attr('id');
      $(ScriptSelector).remove();
    };
    $(C_BODY).dequeue();
  };


  /**
   * Helper to identify page items to apply callback to
   * @param {string} item jQuery selector to identify page items
   * @param {function} callback Action to execute on the found page items
   * @private
   */
  function forEach(item, callback) {
    if (!($.isArray(item) || item.search(/[\.# :\[\]]+/) >= 0)) {
      // übergebenes ITEM ist Elementname, um # erweitern
      item = `#${item}`;
    }
    $(item).each(callback);
  };


  /**
   * 
   */
  // Funktionen, die durch Script aus Response aufgerufen werden.
  adc.setRuleName = function (ruleName) {
    apex.debug.info(`Rule used: ${ruleName}`);
    // TODO: Verwendete Regel auf Seitenelement kopieren? Eventuell zusätzlicher Parameter für diesen Zweck
  };


  /**
   * Takes an object with page items and their actual value as stored in the session state and harmonizes them with the page
   * @param {Object} pageItems Array of objects of the form {"id":"ID of the page item","value":"session state value"}
   */
  adc.setItemValues = function (pageItems) {
    // Store the object for later reference by asynchronous calls
    adc.lastItemValues = pageItems;
    // harmonize the session state with the page items
    $.each(pageItems, function () {
      if ((this.value || 'FOO') != ($v(this.id) || 'FOO')) {
        // third attribute surpresses the change event if set to true
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.info(`Item "${this.id}" set to "${this.value}"`);
      };
    });
  };

  /**
   * Wrapper around apex.item().setValue() that allows to set the same value to many items using a jQuery selector
   * @param {string} item jQuery selector to identify the page items to set the value
   * @param {string} value Value of the page item
   */
  adc.setItemValue = function (item, value) {
    forEach(item, function () {
      var itemId = $(this).attr('id');
      apex.item(itemId).setValue(value, value, true);
    }); 
  };

  /**
   * Set the item of a page item
   * @param {string} itemId ID of the page item to set the label of
   * @param {string} label  New item label
   * @public
   */
  adc.setItemLabel = function (itemID, label){
    adc.ApexJS.setItemLabel(itemID, label);
  };

  /**
   * Shows an error message on the screen. Delegates implementation to adc.ApexJS
   * An error does not necessarily indicate a misbehaviour of ADC but is a normal response fi. when a validation fails
   * @param {Array} errorList List of error objects that occurred during processing
   * @public
   */
  adc.setErrors = function (errorList) {
    if (errorList.errors.length > 0) {
      // If errors have occured, no further events shall be processed.
      $(C_BODY).clearQueue();
    };
    adc.ApexJS.maintainErrors(errorList);
  };


  /**
   * Bind a confirmation dialog to a button to prevent unwanted event execution
   * @param {string} item ID of the button to bind the event to
   * @param {string} message Confirmation message
   * @param {string} title Title of the confirmation dialog box
   * @public
   */
  adc.bindConfirmation = function (item, message, title) {
    var $this = $(`#${item}`);

    if ($this.length > 0) {
      // Element ist auf Seite auch vorhanden (könnte durch Condition fehlen)
      var eventList = $._data($this.get(0), 'events');
      if (typeof eventList != 'undefined' && eventList[C_CLICK_EVENT]) {
        $this.off(C_CLICK_EVENT);
      };
      // Click-Event mit Confirmation-Handler binden
      $this.on(C_CLICK_EVENT, { 'ajaxIdentifier': adc.ajaxIdentifier, 'pageItems': adc.pageItems, 'message': message, 'title': title }, confirmCallback);
    };
  };

  /**
   * Submits the page. Delegates implementation to adc.ApexJS
   * If the page still contains unsolved errors, the page will not be submitted, but a dialog is shown to the user.
   * @param {string} request REQUEST that is passed to the server
   * @param {string} message Message that is shown to the user if the page still contains unsolved errors.
   */
  adc.submit = function (request, message) {
    adc.ApexJS.submitPage(request, message);
  };


  /**
   * Renders a field as mandatory or optional, based on parameter mandatory. Delegates implementation to adc.ApexJS
   * Setting an item mandatory is a two step process. First, ADC has registered this item to be mandatory, secondly, the page representation must
   * be change to represent the status. This is done using this method.
   * @param {string} item jQuery selector of the items that shall be set to mandatory
   * @param {boolean} mandatory Flag to indicate whether the items are mandatory (TRUE) or  not (FALSE)
   * @public
   */
  adc.setMandatory = function (item, mandatory) {
    forEach(item, function () {
      var itemId = $(this).attr('id').replace('_CONTAINER', '');
      if (mandatory) {
        bindEvent(itemId, C_CHANGE_EVENT);
        adc.pageItems.push(itemId);
      }
      adc.ApexJS.setFieldMandatory(itemId, mandatory);
    });
  };


  /**
   * Method to show a notification to the user. Delegates implementation to adc.ApexJS.
   * A notification is a message that is shown as a success message to the user.
   * @param {string} message Message that is shown to the user. Replaces any existing messages.
   * @public
   */
  adc.notify = function (message) {
    adc.ApexJS.setNotification(message);
  };


  /**
   * Refreshes an item (region, page item etc.). Triggers apesrefresh event and enables the page item.
   * @param {string} item ID of the page item to refresh
   * @public
   */
  adc.refresh = function (item) {
	if(apex.region(item)){
		apex.region(item).refresh();
	}
	else{
		var $this = $(`#${item}`);
		adc.enable(item);
		$this.trigger(C_APEX_REFRESH);
	}
  };


  /**
   * Refreshes an item (region, page item etc.) and sets the item value afterwards.
   * The following flow of actions are taken:<ul>
   * <li>Gets the actual value of the page item persists it</li>
   * <li>Binds a one time apexafterrefresh handler to set the page item value to the persisted value after refresh</li>
   * <li>Triggers apexrefresh event</li>
   * <li>enables the page item.</li></ul>
   * @param {string} item ID of the page item to refresh and set the value
   * @public
   */
  adc.refreshAndSetValue = function (item) {
    var itemValue = arguments[1] || findItemValue(item) || apex.item(item).getValue();
    $(`#${item}`)
      .one(C_APEX_AFTER_REFRESH, function (e) {
        $(this).off(C_CHANGE_EVENT);
        $s(item, itemValue);
        $(this).on(C_CHANGE_EVENT, eventData, changeCallback);
      })
      .trigger(C_APEX_REFRESH);
    adc.enable(item);
  };


  /**
   * Disables page items. Delegates implementation to adc.ApexJS.
   * Normal flow is to disable any item that is found using the item jQuery selector.
   * A special case occurs if an input item had focus and a button was clicked. In this case, two events occur: change and click.
   * If the change event results in a disable action, the queue has to be cleaned to precent the click event from occuring.
   * Because of this, this method will clear the event queue anyway.
   * @param {string} item jQuery selector of the items that shall be disabled
   * @public
   */
  adc.disable = function (item) {
    forEach(item, function () {
      var itemId = $(this).attr('id');
      adc.ApexJS.disableElement(itemId);
      $(C_BODY).clearQueue();
    });
  };


  /**
   * Disables page items. Delegates implementation to adc.ApexJS.
   * @param {string} item jQuery selector of the items that shall be enabled
   * @public
   */
  adc.enable = function (item) {
    forEach(item, function () {
      var itemId = $(this).attr('id');
      adc.ApexJS.enableElement(itemId);
    });
  };


  /**
   * Shows page items.
   * @param {string} item jQuery selector of the items that shall be shown
   * @public
   */
  adc.show = function (item) {
    forEach(item, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).show();
    });
  };


  /**
   * Hides page items.
   * @param {string} item jQuery selector of the items that shall be hidden
   * @public
   */
  adc.hide = function (item) {
    forEach(item, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).hide();
    });
  };


  /**
   * Hides filter panels from IR and IG and sets vertical alignment to top.
   * @param {string} item jQuery selector of the regions that contain a filter panel to hide
   * @public
   */
  adc.hideFilterPanel = function (item) {
    forEach(item, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      adc.ApexJS.hideFilterPanel(itemId);
    });
  };
  
  
  /**
   * Installs an event handler on interactive grid passed in and saves actual selection to item passed in
   * @param {string} ID of the interactive grid
   * @param {string} ID of the page item to save the selection to
   * @public
   */
  adc.persistIGSelection = function(ig, item, column){
	  var id = item;
	  $(`#${ig}`).on(C_IG_SELECTION_CHANGE, function(e, data){
		  if(data.selectedRecords.length){
			apex.item(id).setValue(data.selectedRecords[0][Math.max(column - 1, 0)]);
		  };
	  });
  };

  /**
   * Central event handler, calls ADC asynchronously and handles ADC response
   * @public
   */
  adc.execute = function () {

    lockButton();
    apex.debug.info(`ADC handles event ${triggeringElement.event}`);
    apex.debug.info(`ADC sends PageItems ${adc.pageItems.join()}`);
    server.plugin(
      adc.ajaxIdentifier,
      {
        'x01': triggeringElement.id,
        'x02': triggeringElement.event,
        'x03': JSON.stringify(triggeringElement.data),
        'pageItems': adc.pageItems
      },
      {
        'dataType': 'html',
        'success': function (code) {
          if (triggeringElement.isClick) {
            apex.item(triggeringElement.id).enable();
          }
          executeCode(code);
        }
      }
    );
  };


  /**
   * Initialization method
   * @param {Object} me Json object passed in during initialization
   * me.action contains the following parameters:<ul>
   * <li>me.action.attribute_01: JSON object containing all page items and their events which are bound by the plugin</li>
   * <li>me.action.attribute_02: JSON obejct of elements that have changed during ADC processing along with their actual values</li>
   * <li>me.action.attribute_03: Namespace of the adc.ApexJS object used to render the visual effects of ADC</li>
   * <li>me.action.attribute_04: JavaScript code to be executed on the page</li>
   * <li>me.action.attribute_05: jQuery selector or Array of objects that shall be observed additionally to the required and bound page items</li>
   * @public
   */
  adc.init = function (me) {
    // bind all page items deemed to be reuired by ADC
    adc.bindItems = $.parseJSON(me.action.attribute01.replace(/~/g, '"'));
    adc.pageItems = [];
    if (me.action.attribute02) {
      apex.debug.info('Required PageItems: ' + me.action.attribute02);
      adc.pageItems = me.action.attribute02.split(',');
    };

    bindObserverElements(me.action.attribute05);

    // register adc.ApexJS namespace object and Ajax identifier
    adc.ApexJS = eval(me.action.attribute03);
    adc.ajaxIdentifier = me.action.ajaxIdentifier;

    // Prepare page for ADC usage
    bindEvents();
    apex.debug.info('ADC initialized');

    // exceute initial JavaScript code passed in from the server
    executeCode(hexToChar(me.action.attribute04));
  }

})(de.condes.plugin.adc, apex.jQuery, apex.server);


// Interface to APEX plugin mechanism. 
// For some reason I don't really understand, it is impossible to tell APEX to directly use a namespace object here.
function de_condes_plugin_adc() {
  de.condes.plugin.adc.init(this);
}