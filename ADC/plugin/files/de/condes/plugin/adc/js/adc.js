
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
 * <p>This file implements the client-side component of APEX Dynamic Controller. Its task is to </p><ul><li>create the necessary event handlers when the page is rendered</li><li>collect the relevant data from the page when an event occurs and send it to the server</li><li>implement the returned response with instructions to modify the application page.</li></ul>
 * <p>The controller works on the server side with a decision tree that computes a list of action instructions for a given situation. During the calculation, the state of the application page can be changed by actions, which leads to a recursive check of the changed page state against the decision tree. The response includes all change instructions for the application page, including the recursive change instructions.</p>
 <p>The ADC response is delivered in the form of a script with an ID and inserted on the page by this component. Thus, all included actions are executed directly. Afterwards, the plugin removes the server's response, as it is no longer needed.</p>
 * <p>Change instructions to application page partly depend on APEX version used and especially on theme used. The plugin starts from Theme 42, however, all theme-specific implementations of the activities are swapped out into a separate file, which is linked as a namespace object when parameterizing the plugin as a component parameter. As per default, this is <code>de.condes.plugin.adc.apex_42_5_1</code>, implementent in file <code>adcApex.js</code>, but it can be easily replaced by a client specific implementation.</p>
 * <p>To work, this plugin must only be called during page load, no administration or parameterization is required.</p>
 */
(function (adc, $, server) {
  "use strict"

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
   * @description
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

  /**
   * @typedef {Object} triggeringElement
   * @description
   * <p>An object to collect informations about the triggering item</p>
   * @type Object
   * 
   * @property {string} id ID of the page element that triggered the event.
   * @property {string} event Name of the event that was raised. May be a different event than originally raised, 
   *                          fi. an <code>enter</code> that is raised if a <code>keypress</code> event was found for the Enter-key.
   * @property {string} isClick Flag to indicate whether the event was some kind of click event
   * @property {string} data Optional data that is passed with the event. May be a simple string or a JSON object.
   */
   
  /**
   * @typedef {Object} pAction
   * @description
   * <p>An answer object of the plugin framework containing attributes to control further processing</p>
   * @type Object
   *
   * @property {string} attribute_01 JSON object containing all page items and their events which are bound by the plugin
   * @property {string} attribute_02 JSON obejct of elements that have changed during ADC processing along with their actual values
   * @property {string} attribute_03 Namespace of the <code>adc.ApexJS</code> object used to render the visual effects of ADC
   * @property {string} attribute_04 JavaScript code to be executed on the page. Sets the initial visual state of the page
   * @property {string} attribute_05 jQuery selector or Array of additional page items which are not bound to event handlers but their value is passed to ADC
   */

  // Constants
  var 
    C_CHANGE_EVENT = 'change',
    C_CLICK_EVENT = 'click',
    C_KEYPRESS_EVENT = 'keypress',
    C_ENTER_EVENT = 'enter',
    C_APEX_REFRESH = 'apexrefresh',
    C_APEX_BEFORE_REFRESH = 'apexbeforerefresh',
    C_APEX_AFTER_REFRESH = 'apexafterrefresh',
    C_APEX_AFTER_CLOSE_DIALOG = 'apexafterclosedialog',
    C_IG_SELECTION_CHANGE = 'interactivegridselectionchange',
    C_SELECTION_CHANGE = 'adcselectionchange',
    C_NO_TRIGGERING_ITEM = 'DOCUMENT',
    C_BODY = 'body',
    C_BUTTON = 'button',
    C_APEX_BUTTON = 't-Button';
  
  // Global
  var
    eventData = { 'ajaxIdentifier': adc.ajaxIdentifier, 'pageItems': adc.pageItems },
    triggeringElement = { 'id': '', 'event': '', 'data': '', 'isClick': false };
  
  /* ++++++++++ PRIVATE +++++++++ */

  /** Locks a button to prevent a second click before the action is processed completely.<br>
   * Refers to the button as set in triggeringElement.
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


  /** Wraps the call to the database in a confirmation dialog to enable the user to surpress this event.<br>
   * Delegates showing the confirmation dialog to <code>adc.ApexJS</code>.
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
   * Method adds a page item to a list of page items to be sent to the server with every call.
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
   * Method identifies all elements whose values must be sent to the database with any request.
   * Two possible ways exist to add an item to this observer list: 
   * <ul><li>Initialization code of the plugin that automatically detects items that have a value and are referenced by page rules</li>
   * <li>Explicit observation as requested by a ADC rule action</li></ul>
   * The second option calls this method
   * @param {string} selector jQuery selector to identify the item(s) that must be observed explicitly
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
   * When a call to refresh a page item is issued, the value of this item is reset to NULL by APEX.
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
   * The code is added to the document using <code>$.append</code> which immediately executes any JavaScript.<br>
   * After appending, the response can be deleted because it does not make any sense to store it on the page any further
   * After deleting, the execute method raises the next event on the queue (if any)
   * @param {string} pCode JavaScript code to execute
   * @private
   */
  function executeCode(pCode) {
    if (pCode) {
      console.log('Response received: \n' + pCode);
      $(C_BODY).append(pCode);
	    var ScriptSelector = '#' + $(pCode).attr('id');
      $(ScriptSelector).remove();
    };
    $(C_BODY).dequeue();
  };


  /**
   * Helper to identify page items to apply <code>pAction</code> to
   * @param {string} pSelector jQuery selector to identify page items
   * @param {function} pAction Action to execute on the found page items
   * @private
   */
  function forEach(pSelector, pAction) {
    if (!($.isArray(pSelector) || pSelector.search(/[\.# :\[\]]+/) >= 0)) {
      // übergebenes ITEM ist Elementname, um # erweitern
      pSelector = `#${pSelector}`;
    }
    $(pSelector).each(pAction);
  };
  
  /* +++++ END PRIVATE  ++++++++ */

  /* ++++++++++ CORE FUNCTIONALITY ++++++++++ */

  /** APEX unique identifier for the dynamic action
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.ajaxIdentifier = {};

  /** List of page items that received changes lately
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.lastItemValues = {};

  /**
   * Central event handler, calls ADC asynchronously and handles ADC response
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.execute = function(){

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
   * Initialization method.<br>
   * This method is called upon rendering of the APEX page. It installs the plugin on the page and creates the necessary event handler.
   * To achive this, parameter <code>pAction</code> with the necessary attributes is passed in and evaluated.<br>
   * @param {pAction} pAction Json object passed in during initialization
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.init = function (pAction) {
    // bind all page items required by ADC
    adc.bindItems = $.parseJSON(pAction.attribute01.replace(/~/g, '"'));
    adc.pageItems = [];
    if (pAction.attribute02) {
      apex.debug.info('Required PageItems: ' + pAction.attribute02);
      adc.pageItems = pAction.attribute02.split(',');
    };
    
    bindObserverElements(pAction.attribute05);

    // register adc.ApexJS namespace object and Ajax identifier
    adc.ApexJS = eval(pAction.attribute03);
    adc.ajaxIdentifier = pAction.ajaxIdentifier;

    // Prepare page for ADC usage
    bindEvents();
    apex.debug.info('ADC initialized');

    // exceute initial JavaScript code passed in from the server
    executeCode(hexToChar(pAction.attribute04));
  }
  
  /* +++++++++ END CORE FUNCTIONALITY +++++++++++ */

  /* +++++++++ SYSTEM ACTION TYPES +++++++++++ */

  /**
   * Sets vertical alignment of IR and IG to top. Delegates aligning to <code>adc.ApexJS</code>.
   * @param {string} pSelector jQuery selector of the regions to adjust vertical alignment
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.alignReportVerticalTop = function (pSelector) {
    forEach(pSelector, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      adc.ApexJS.alignReportVerticalTop(itemId);
    });
  };

  /**
   * Bind a confirmation dialog to a button to show a confirmation dialog before an event is raised
   * @param {string} pItemId ID of the button to bind the event to
   * @param {string} pMessage Confirmation message
   * @param {string} pDialogTitle Title of the confirmation dialog box
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.bindConfirmation = function (pItemId, pMessage, pDialogTitle) {
    var $this = $(`#${pItemId}`);

    if ($this.length > 0) {
      // Element is also present on page (could be missing due to condition)
      var eventList = $._data($this.get(0), 'events');
      if (typeof eventList != 'undefined' && eventList[C_CLICK_EVENT]) {
        $this.off(C_CLICK_EVENT);
      };
      // bind confirmation handler to the click event
      $this.on(C_CLICK_EVENT, { 'ajaxIdentifier': adc.ajaxIdentifier, 'pageItems': adc.pageItems, 'message': pMessage, 'title': pDialogTitle }, confirmCallback);
    };
  };
  
  /**
   * Disables page items. Delegates implementation to <code>adc.ApexJS</code>.<br>
   * Normal flow is to disable any item that is found using the item jQuery selector.<br>
   * A special case occurs if an input item had focus and a button was clicked. In this case, two events occur: change and click.
   * If the change event results in a disable action, the queue has to be cleaned to prevent the click event from occuring.
   * Because of this, this method will clear the event queue anyway.
   * @param {string} pSelector jQuery selector of the items that shall be disabled
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.disable = function (pSelector) {
    forEach(pSelector, function () {
      var itemId = $(this).attr('id');
      adc.ApexJS.disableElement(itemId);
      $(C_BODY).clearQueue();
    });
  };
  
  /**
   * Enables page items. Delegates implementation to <code>adc.ApexJS</code>.<br>
   * @param {string} pSelector jQuery selector of the items that shall be enabled
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.enable = function (pSelector) {
    forEach(pSelector, function () {
      var itemId = $(this).attr('id');
      adc.ApexJS.enableElement(itemId);
    });
  };
  
  /**
   * Wrapper around <code>adc.execute</code> that raises a command event along with the necessary data.<br>
   * This method is used as the standard action for a command object to make sure that ADC is informed that
   * an ADC maintained APEX action was invoked.
   * @see {@link adc.execute}
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.executeCommand = function(pCommand){
	  triggeringElement.event = 'command';
	  triggeringElement.id = 'COMMAND';
	  triggeringElement.isClick = false;
	  triggeringElement.data = pCommand;
	  
	  adc.execute();
  };
  
  /**
   * Recognizes selection changes on Interactive reports, interactive grids or classic reports.
   * To gather access to the primary key value, it is necessary to obey the following conventions:
   * <ul><li>In interactive and classic reports, a visible column must contain a html expression with a <code>data-id</code> attribute
   *         containing the PK value: <code>&lt;span data-id="#PK_COLUMN#"&gt;#VISIBLE_COLUMN#&lt;/span&gt;</code></li>
   *     <li>In interactive grid, it is possible to either identify a single column of the report as the primary key column 
   *         (ADC does not support multiple key columns yet) or by passing an ordinal number (1 based) pointing to the column
   *         containing the primary key. The order is defined by the order of the SQL query or the column order respectively.</li></ul>
   * If no page item to store the primary key value is provided, this method raises event <code>adcselectionchange</code> which can be detected in ADC by querying 
   * the pseudo column <code>SELECTION_CHANGED</code>. The column contains the report ID on which the event was fired. The primary key value
   * is provided via the event data property and can be read from PL/SQL by using adc.get_event_data or in JavaScript with the replacement Anchor
   * <code>#EVENT_DATA#</code> (within ADC only).
   * @param {string} pReportId ID of the report to observe 
   * @param {string} pItemId ID of the page item to save the selection to. If set, the value of the page item will be changed
   *                 to the ID of the selected row. If not set, the method will raise event <code>adcselectionchange</code> with the ID as data.
   * @param {number} pColumn Optional ordinary number of the column containing the PK information (IG only and necessary only if no single primary key column is administered)
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.getReportSelection = function(pReportId, pItemId, pColumn){
	  var C_IG_SELECTOR = `#${pReportId}_ig`,
        C_IR_SELECTOR = `#${pReportId}_ir`,
        C_CR_SELECTOR = `#report_table_${pReportId}`,
        report$ = $(`#${pReportId}`),
        pkValue;

    var persistOrReport = function(pValue){
      if(pItemId){
        apex.item(pItemId).setValue(pValue);
      }
      else{
        // No item present, submit ID with event C_SELECTION_CHANGE
        triggeringElement.id = pReportId;
        triggeringElement.event = C_SELECTION_CHANGE;
        triggeringElement.isClick = false;
        triggeringElement.data = pkValue;
        adc.execute();
      };
    };
    
    // Examine type of report and bind click handler
    if(report$.find(C_IG_SELECTOR).length > 0){
      // Report type Interactive Grid
      report$.on(C_IG_SELECTION_CHANGE, function(e, data){
        if(data.selectedRecords.length){
          // Try to get the primary key information from the identity column. If none exists, get it from the column index passed in
          if(pColumn){
            pkValue = data.selectedRecords[0][Math.max(pColumn - 1, 0)];
          }else{
            pkValue = data.model.getRecordId(data.selectedRecords[0])
          }
          persistOrReport(pkValue);
        };
      });
    }
    else if(report$.find(C_IR_SELECTOR).length > 0){
      // Report type Interactive Report
      report$.on("click", ".a-IRR-table tr:not(:first-child)", function(){
        pkValue = $(this).find('td [data-id]').data('id');
        persistOrReport(pkValue);
      });
    }
    else if(report$.find(C_CR_SELECTOR).length > 0){
      // Report type Classic Report
      report$.on("click", ".t-Report-report tbody tr", function(){
        pkValue = $(this).find('td [data-id]').data('id');
        persistOrReport(pkValue);
      });
    };    
  };

  /**
   * Hides page items.
   * @param {string} pSelector jQuery selector of the items that shall be hidden
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.hide = function (pSelector) {
    forEach(pSelector, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).hide();
    });
  };

  /**
   * Hides filter panels from IR and IG. Delegates hiding the filter panel to <code>adc.ApexJS</code>.
   * @param {string} pSelector jQuery selector of the regions that contain a filter panel to hide
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.hideReportFilterPanel = function (pSelector) {
    forEach(pSelector, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      adc.ApexJS.hideReportFilterPanel(itemId);
    });
  };
  
  /**
   * Method to show a notification to the user. Delegates implementation to <code>adc.ApexJS</code>.<br>
   * A notification is a message that is shown as a success message to the user.
   * @param {string} pMessage Message that is shown to the user. Replaces any existing messages.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.notify = function (pMessage) {
    adc.ApexJS.setNotification(pMessage);
  };

  /**
   * Refreshes an item (region, page item etc.). Triggers apexrefresh event and enables the page item.
   * @param {string} pItemId ID of the page item to refresh
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.refresh = function (pItemId) {
    if(apex.region(pItemId)){
      apex.region(pItemId).refresh();
    }
    else{
      var $this = $(`#${item}`);
      adc.enable(pItemId);
      $this.trigger(C_APEX_REFRESH);
    }
  };
  
  /**
   * Refreshes an item (region, page item etc.) and sets the item value afterwards.
   * The following flow of actions are taken:<ul>
   * <li>Persist the actual value of the page item</li>
   * <li>Bind one time apexafterrefresh handler to set the page item value to the persisted value after refresh</li>
   * <li>Trigger apexrefresh event</li>
   * <li>enable the page item</li></ul>
   * @param {string} pItem ID of the page item to refresh and set the value
   * @param {string} pValue Optional value. If not set, method looks for actual item value in cache or on page.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.refreshAndSetValue = function (pIitem, pValue) {
    var itemValue = pValue || findItemValue(pIitem) || apex.item(pIitem).getValue(),
	      $item = $(`#${pIitem}`);
		
    adc.enable(item);
    if(itemValue){
      $item
        .on(C_APEX_AFTER_REFRESH, function (e) {
          apex.item(pIitem).setValue(itemValue, itemValue, true);
          apex.debug.info(`Setting value "${itemValue}" at "${pIitem}"`);
        })
        .trigger(C_APEX_REFRESH);
    }
    else{
      $item.trigger(C_APEX_REFRESH);
    };
  };

  /**
   * Shows an error message on the screen.<br>
   * An error does not necessarily indicate a misbehaviour of ADC but is a normal response fi. when a validation fails.<br>
   * Delegates showing the errors to <code>adc.ApexJS</code>.<br>
   * This method will clear the event queue if an error is passed in. Reasoning behind this is:
   * If a value is entered in an input field but the field is not left using a tab key or a mouse click, but instead you click on a button
   * while the focus is still in the input field, two events will be raised: <code>change</code> on the input field and <code>click</code> on the button.<br>
   * Now, ADC may validate then input field and the <code>click</code> event should only be processed if the validation passes. 
   * As both events are raised (almost) concurrently and handled asynchronously, there is no possibility for ADC to prevent the <code>click</code> event from happening.
   * To cater for this, all events are queued within ADC and therefore serialized. Using this technique, the <code>click</code> event can be surpressed by clearing the queue.
   * @param {errorList} pErrorList List of error objects that occurred during processing
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setErrors = function (pErrorList) {
    if (pErrorList.errors.length > 0) {
      // If errors have occured, no further events must be processed.
      $(C_BODY).clearQueue();
    };
    adc.ApexJS.maintainErrors(pErrorList);
  };

  /**
   * Set the label of a page item. Delegates changing the label to <code>adc.ApexJS</code>.
   * @param {string} pItemID ID of the page item to set the label of
   * @param {string} label  New item label
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setItemLabel = function (pItemID, pLabel){
    adc.ApexJS.setItemLabel(pItemID, pLabel);
  };

  /**
   * Wrapper <code>around apex.item().setValue()</code> that allows to set the same value to many items using a jQuery selector.
   * It also surpresses a change event when setting the values to avoid ADC loops.
   * @param {string} pSelector jQuery selector to identify the page items to set the value
   * @param {string} pValue Value of the page item
   * @public
   * @memberof de.condes.plugin.adc
   */
  adc.setItemValue = function (pSelector, pValue) {
    forEach(pSelector, function () {
      var itemId = $(this).attr('id');
      apex.item(itemId).setValue(pValue, pValue, true);
    }); 
  };
  
  /**
   * Takes an object with page items and their actual value as stored in the session state and harmonizes them with the page.
   * @param {Object} pPageItems Array of objects of the form <code>{"id":"pageItemID","value":"itemValue"}</code>.
   */
  adc.setItemValues = function (pPageItems) {
    // Store the object for later reference by asynchronous calls
    adc.lastItemValues = pPageItems;
    // harmonize the session state with the page items
    $.each(pPageItems, function () {
      if ((this.value || 'FOO') != (apex.item(this.id).getValue() || 'FOO')) {
        // third attribute surpresses the change event if set to true
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.info(`Item "${this.id}" set to "${this.value}"`);
      };
    });
  };

  /**
   * Renders a field as mandatory or optional, based on parameter <code>pIsMandatory</code>.
   * Setting an item mandatory is a two step process. <ol><li>ADC regsiters a change handler and observes it, if not yet done</li><li>the page representation must
   * be changed to represent the status.</li></ol>
   * Controling the page representation is delegated to <code>adc.ApexJS</code>.
   * @param {string} pSelector jQuery selector of the items that shall be set to mandatory
   * @param {boolean} pIsMandatory Flag to indicate whether the items are mandatory (TRUE) or  not (FALSE)
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setMandatory = function (pSelector, pIsMandatory) {
    forEach(pSelector, function () {
      var itemId = $(this).attr('id').replace('_CONTAINER', '');
      if (pIsMandatory) {
        if ($.inArray(itemId, adc.pageItems) === -1) {
          adc.pageItems.push(itemId);
          bindEvent(itemId, C_CHANGE_EVENT);
        };
      }
      adc.ApexJS.setItemMandatory(itemId, pIsMandatory);
    });
  };

  /**
   * Shows page items.
   * @param {string} pSelector jQuery selector of the items that shall be shown
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.show = function (pSelector) {
    forEach(pSelector, function () {
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).show();
    });
  };

  /**
   * Submits the page. Delegates implementation to <code>adc.ApexJS</code>.
   * If the page still contains unsolved errors, the page will not be submitted, but a dialog is shown to the user.
   * @param {string} pRequest REQUEST that is passed to the server
   * @param {string} pMessage Message that is shown to the user if the page still contains unsolved errors.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.submit = function (pRequest, pMessage) {
    adc.ApexJS.submitPage(pRequest, pMessage);
  };
  
  /* +++++++++ END SYSTEM ACTION TYPES +++++++++++ */

})(de.condes.plugin.adc, apex.jQuery, apex.server);


// Interface to APEX plugin mechanism. 
// For some reason I don't really understand, it is impossible to tell APEX to directly use a namespace object here.
function de_condes_plugin_adc() {
  de.condes.plugin.adc.init(this.action);
}