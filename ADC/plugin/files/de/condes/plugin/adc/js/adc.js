
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
   <p>This file implements the client-side component of APEX Dynamic Controller.<br>
    Its task is to
      <ul>
        <li>create the necessary event handlers when the page is rendered</li><li>collect the relevant data from the page when an event occurs and send it to the server</li><li>implement the returned response with instructions to modify the application page.</li>
      </ul>
    </p>
    <p>The controller works on the server side with a decision tree that computes a list of action instructions for a given situation.<br>
    During the calculation, the state of the application page can be changed by actions, which leads to a recursive check of the changed page state against the decision tree. The response includes all change instructions for the application page, including the recursive change instructions.</p>
    <p>The ADC response is delivered in the form of a script with an ID and inserted on the page by this component. Thus, all included actions are executed directly. Afterwards, the plugin removes the server's response, as it is no longer needed.</p>
    <p>Change instructions to application page partly depend on APEX version used and especially on theme used. The plugin starts from Theme 42, however, all theme-specific implementations of the activities are swapped out into a separate file, which is linked as a namespace object when parameterizing the plugin as a component parameter. As per default, this is <code>de.condes.plugin.adc.apex_42_5_1</code>, implementent in file <code>adcApex.js</code>, but it can be easily replaced by a client specific implementation.</p>
    <p>To work, this plugin must only be called during page load, no administration or parameterization is required.</p>
   */
(function (adc, $, server) {
  "use strict";

  /**
   * @typedef {Object} error
   * @description
     <p>An error is a JSON object representing an error. It contains information about the error message, the affected page item and additional information that shows only if the page is rendered in debug mode.</p>
   * @type Object
   * @property {string} item Page item that is affected by this error
   * @property {string} message Error message
   * @property {string} additionalInfo Developer information,
                        normally call stack and internal error name
   */

  /**
   * @typedef {Object} errorList
   * @description
     <p>An errorList is a collection of errors that occurred on the page. It also contains arrays for error dependent items (i.e. items that have to be disabled if an error occurred on the page) and firingItems.<br>
     Firing items provide information about page items that have been 'touched' by executed rules. Intention is to remove any error that is related to a firing item from the collection of errors on the page and replace it with the newly provided error message, if any. This way, error messages which don't apply are removed, but errors relating to other page items on the page stay on page.</p>
   * @type Object
   * @property {string} count Amount of errors
   * @property {string[]} firingItems Array of page items that are
        affected by the executed rules. Used to remove errors that
        refer to these page items before adding new errors
   * @property {error[]} errors Array of error instances
   * @param {Object} adc This code
   * @param {Object} $ jQuery instance of APEX
   * @param {Object} server apex.server instance
   */

  /**
   * @typedef {Object} triggeringElement
   * @description <p>An object to collect informations about the triggering item</p>
   * @type Object
   *
   * @property {string} id ID of the page element that triggered the event.
   * @property {string} event Name of the event that was raised. May be a different event than originally raised,fi. an <code>enter</code> that is raised if a <code>keypress</code> event was found for the Enter-key.
   * @property {string} isClick Flag to indicate whether the event was some kind of click event
   * @property {string} data Optional data that is passed with the event. May be a simple string or a JSON object.
   */

  /**
   * @typedef {Object} pAction
   * @description <p>An answer object of the plugin framework containing attributes to control further processing</p>
   * @type Object
   *
   * @property {string} attribute_01 JSON object containing all page items and their events which are bound by the plugin
   * @property {string} attribute_02 JSON obejct of elements that have changed during ADC processing along with their actual values
   * @property {string} attribute_03 Namespace of the <code>adc. ApexJS</code> object used to render the visual effects of ADC
   * @property {string} attribute_04 JavaScript code to be executed on the page. Sets the initial visual state of the page
   * @property {string} attribute_05 jQuery selector or Array of additional page items which are not bound to event handlers but their value is passed to ADC
   */

  /**
   * @typedef {Object} eventData
   * @description <p>A Json object containting data for the server call such as the ajaxIdentifier and the page items to submit</p>
   * @type Object
   *
   * @property {string} ajaxIdentifier Reference to adc.ajaxIdentifier
   * @property {string} pageItems reference to adc.pageItems
   */

  /**
   * @typedef {Object} commandData
   * @description <p>A Json object containting data describing a command object which is based on @link{apex.action}</p>
   * @type Object
   *
   * @property {string} command Name of the command to execute
   * @property {string} event Event object that raised the action
   * @property {string} focusItem ID of the item that gets focus if the execution of a command returns true
   * @property {string} additionalPageItems Array of page item IDs which have to be passed in addition to the normal pageItems collection.
   * @property {string} data Additional information that is passed along with the command, fi. for values
   */

  // Constants
  const C_CHANGE_EVENT = 'change';
  const C_CLICK_EVENT = 'click';
  const C_DBLCLICK_EVENT = 'dblclick';
  const C_ENTER_EVENT = 'enter';
  const C_KEYPRESS_EVENT = 'keypress';
  const C_APEX_REFRESH = 'apexrefresh';
  const C_APEX_BEFORE_REFRESH = 'apexbeforerefresh';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_APEX_AFTER_CLOSE_DIALOG = 'apexafterclosedialog';
  const C_IG_SELECTION_CHANGE = 'interactivegridselectionchange';
  const C_TREE_SELECTION_CHANGE = 'treeviewselectionchange';
  const C_SELECTION_CHANGE = 'adcselectionchange';
  const C_NO_TRIGGERING_ITEM = 'DOCUMENT';
  const C_LOCK_LENGTH = 200;
  const C_PROTECTED_EVENTS = [C_CLICK_EVENT, C_DBLCLICK_EVENT, C_ENTER_EVENT];
  const C_BODY = 'body';
  const C_BUTTON = 'button';
  const C_APEX_BUTTON = 't-Button';
  const C_REGION_CR = 'ClassicReport';
  const C_REGION_IR = 'InteractiveReport';
  const C_REGION_IG = 'InteractiveGrid';
  const C_REGION_TREE = 'Tree';
  const C_INPUT_SELECTOR = ':input:visible:not(button)';

  // Global
  var quarantineList = [];
  var eventData = {
          "ajaxIdentifier": adc.ajaxIdentifier,
          "pageItems": adc.pageItems};
  var triggeringElement = {
          "id": "",
          "data": "",
          "event": "",
          "isClick": false};
  var pageStatus = new Map();

  /* ++++++++++ PRIVATE +++++++++ */
  /** Callback method for a change event
   * Any event is pushed to a queue to process them one by one, depending on the outcome of the predecessor.
   * As an example, if a page item is focussed and the user clicks on a button, two events occur:
   * <ol><li>change event on the page item</li><li>click event on the button</li></ol>
   * If the change event triggers a computation that returns an error (such as a page item validation), in many cases the click event
   * of the button must not be processed anymore. But because these events appear so quickly, ADC is unable to respond before the
   * click event is handled. Therefore, these events a queued. If ADC returns with an error, the queue is cleared and the next events
   * will not be processed.
   * @param {event} pEvent Event that occured
   * @param {event} pEventData Additional event data that is passed with the event. May be accessed by ADC.GET_EVENT_DATA within the database
   * @param {event} pWait Flag to indicate whether a wait spinner should be shown during processing
   * @private
   */
  function changeCallback(pEvent, pEventData, pWait) {
    getTriggeringElement(pEvent);

    $(C_BODY).queue(function () {
      maintainAndCheckEventLock();
      adc.showWaitSpinner(pWait);
      adc.execute(pEvent, pEventData);
    });
  }
  

  /** Wraps the call to the database in a confirmation dialog to enable the user to surpress this event.<br>
   * Delegates showing the confirmation dialog to <code>adc.ApexJS</code>.
   * @param {event} pEvent Event that occured
   * @param {event} pWait Flag to indicate whether a wait spinner should be shown during processing
   * @private
   */
  function confirmCallback(pEvent, pWait) {
    getTriggeringElement(pEvent);

    $(C_BODY).queue(function () {
      maintainAndCheckEventLock();
      adc.showWaitSpinner(pWait);
      // Handle event only after confirmation from the user
      adc.ApexJS.confirmRequest(pEvent, changeCallback);
    });
  }

  /** Wraps the call to the database in a confirmation dialog that is shown if the page contains unsaved changes.<br>
   * Delegates showing the confirmation dialog to <code>adc.ApexJS</code>.
   * @param {event} pEvent Event that occured
   * @param {event} pWait Flag to indicate whether a wait spinner should be shown during processing
   * @private
   */
  function unsavedCallback(pEvent, pWait) {
    getTriggeringElement(pEvent);

    $(C_BODY).queue(function () {
      maintainAndCheckEventLock();
      adc.showWaitSpinner(pWait);
      if(hasUnsavedChanges()){
        // Handle event only after confirmation from the user
        adc.ApexJS.confirmRequest(pEvent, changeCallback);
      }
      else{
        // No changes on the page, continue
        changeCallback(pEvent);
      };
    });
  }

  /** Method to reject the same event for a certain amount of time to prevent double execution of ADC requests.<br>
   * Events, such as ENTER key or click may be raised quicker than ADC is able to consume then, leading to a double
   * request and a double execution of rules. This may lead to a modal dialog to be shown twice or a double insert into
   * a table, raising unique errors etc.<br>
   * To cater for this, an event is put on a quarantineList for a certain amount of time. This method administers this
   * quarantine list and checks whether it is ok to raise an event.
   * @private
   */
  function maintainAndCheckEventLock(){
    var isOkToRaiseEvent = true;

    if (C_PROTECTED_EVENTS.indexOf(triggeringElement.event) > -1){
      if(quarantineList.indexOf(triggeringElement.event) > -1){
        // Ignore event as it is on quarantineList
        apex.debug.info(`Ignoring Event '${triggeringElement.event}', on quarantine list`);
        isOkToRaiseEvent = false;
      }
      else{
        // Remove any existing events from the queue
        apex.debug.info(`Clear event queue after locking an event`);
        $('body').clearQueue();

        // Put event on quarantineList to prevent double execution
        quarantineList.push(triggeringElement.event);
        apex.debug.info(`Event '${triggeringElement.event}' pushed on quarantine`);

        // Pop event after C_LOCK_LENGTH from quarantine
        setTimeout(
          function(){
           quarantineList = [];
           apex.debug.info(`Event '${triggeringElement.event}' popped from quarantine`);
          },
          C_LOCK_LENGTH
        );

        // Additionally disable button to prevent double click. Will be enabled by the response of ADC
        if (triggeringElement.isClick){
          apex.debug.info(`Locking button '${triggeringElement.id}'`);
          apex.item(triggeringElement.id).disable();
        }
      }
    }
    return isOkToRaiseEvent;
  }

  /**
   * Binds an event to a page item
   * @param {string} pItemId Name of the element to bind
   * @param {string} pEvent Event that is bound.
   * @param {function} pAction Optional callback method. Overrides default behaviour of calling changeCallback()
   */
  function bindEvent(pItemId, pEvent, pAction) {
    var $this;
    var eventList;
    var callback;

    if (pItemId.search(/[\.#\u0020:\[\]]+/) < 0) {
      pItemId = `#${pItemId}`;
    }
    $this = $(pItemId);

    if ($this.length > 0) {
      // Check whether element exists on page (could be missing due to a server condition)
      eventList = $._data($this.get(0), 'events');
      callback = ((typeof pAction !== 'undefined' && pAction.length > 0) ? new Function(pAction) : changeCallback);

      // ADC unbinds event handlers bound to this item to prevent problems between the different handlers
      $this
        .off(pEvent)
        .on(pEvent, eventData, callback);
      if (pEvent === C_CHANGE_EVENT) {
        // CHANGE event should not be called after APEXREFRESH, so pause it until apexafterrefresh
        $this
        .on(C_APEX_BEFORE_REFRESH, function (e) {
          $(this).off(C_CHANGE_EVENT);
          apex.debug.info(`Event '${C_CHANGE_EVENT}' paused at ${pItemId}`);
        })
        .on(C_APEX_AFTER_REFRESH, function (e) {
          $(this).on(C_CHANGE_EVENT, eventData, callback);
          apex.debug.info(`Event '${C_CHANGE_EVENT}' re-established at ${pItemId}`);
        });
      }
    }
  }

  /**
   * Binds all events that are requested by the plugin via adc.bindItems.
   * Upon initialization, all relevant page items are collected along with the required events.
   * This method then binds all items with the respective event.
   * As per default, changeCallback is bound as the callback method which in turn sends a request to the database ruleset
   */
  function bindEvents() {
    $.each(adc.bindItems, function () {
      bindEvent(this.id, this.event, this.action);
      if (this.event === C_CHANGE_EVENT) {
        addPageItem(this.id);
      }
    });
  }

  /**
   * Method identifies all elements whose values must be sent to the database with any request.
   * Two possible ways exist to add an item to this observer list:
   * <ul><li>Initialization code of the plugin that automatically detects items that have a value and are referenced by page rules</li>
   * <li>Explicit observation as requested by a ADC rule action</li></ul>
   * The second option calls this method
   * @param {string} pSelector jQuery selector to identify the item(s) that must be observed explicitly
   * @private
   */
  function bindObserverItems(pSelector) {
    var selectorList;
    if (pSelector) {
      selectorList = pSelector.split(',');
      $.each(selectorList, function (idx, element) {
        if (this.substring(0, 1) === '.') {
          $(element).each(function (idx, element) {
            addPageItem($(element).attr('id'));
          });
        }
        else {
          if ($.inArray(element, adc.pageItems) === -1) {
            adc.pageItems.push(element);
          }
        }
      });
    }
  }

  /**
   * Method adds a page item to a list of page items to be sent to the server with every call.
   * @param {string} pItemId ID of the page item that ahould be added
   * @private
   */
  function addPageItem(pItemId) {
    if ($.inArray(pItemId, adc.pageItems) === -1) {
      adc.pageItems.push(pItemId);
    }
  }

  /**
   * Method to persist the value of a page item
   * When a call to refresh a page item is issued, the value of this item is reset to NULL by APEX.
   * This method allows to store the value of the item before refreshing it and to reset it to this value after refresh.
   * @param {string} pItemId ID of the page item. Perceived to be unique
   * @private
   */
  function findItemValue(pItemId) {
    var result = $.grep(adc.lastItemValues, function (e) {
      return e.id === pItemId;
    });

    if (result.length > 0) {
      return result[0].value;
    }
  }


  /**
   * Method to cast a hex-string representation created with UTL_RAW.CAST_TO_RAW back to String.<br>
   * ADC submits its response as a hex string to circumvent escaping issues between JSON, JavaScript and JavaScript containing JSON.
   * As a consequence, the hex string must be converted back to a normal string in order to append it to the page.
   * @param {hexString} pRawString  Hex-encoded string to convert back to a normal string
   * @returns Converted String
   * @private
   */

  function hexToChar(pRawString) {
    var code = '';
    var hexString;

    if (pRawString) {
      hexString = pRawString.toString();
      for (let i = 0; i < hexString.length; i += 2) {
        code += String.fromCharCode(parseInt(hexString.substr(i, 2), 16));
      }
    }
    return code;
  }

  /**
   * Method to describe the event and calling item after an event has occured
   * @param {event} e
   * @private
   */
  function getTriggeringElement(e) {
    var $element;
    var $button;

    // Copy event data to a local variable to allow for tayloring
    triggeringElement.id = C_NO_TRIGGERING_ITEM;
    triggeringElement.event = e.type;
    triggeringElement.data = e.data;

    if (typeof e.target != 'undefined') {
      switch (triggeringElement.event) {
        case C_APEX_AFTER_CLOSE_DIALOG:
          // CloseDialog is bound to currentTarget to allow for delegated events.
          triggeringElement.id = e.currentTarget.id;
          break;
        case C_CHANGE_EVENT:
          triggeringElement.id = e.target.id;

          $element = $(`#${triggeringElement.id}`);
          if ($element.attr('type') === 'radio' || $element.attr('type') === 'checkbox') {
            // In case of a radio group or a checkbox, the id has to be taken from the parent fieldset
            triggeringElement.id = $element.parents('fieldset').attr('id');
          }
          if (triggeringElement.id.match(/oj.*/)){
            // item is Oracle Jet item group, traverse up
            triggeringElement.id = $(`#${triggeringElement.id}`).closest('div.apex-item-group').attr('id');
          }
          break;
        case C_CLICK_EVENT:
          // Flag is used to clear the event queue to prevent multiple clicks
          triggeringElement.isClick = true;
          triggeringElement.id = ((e.target.id !== '') ? e.target.id : e.currentTarget.id);

          if (triggeringElement.id === '') {
            // Some browsers send accessKey-span instead of triggering element in response to a click
            // Get the parent element in these cases
            triggeringElement.id = e.target.parentElement.id;
          }
          $button = $(`#${triggeringElement.id}`);
          // Depending on how a click event was raised (mouse or code), a different item is addressed
          if (!$button.hasClass(C_APEX_BUTTON)) {
            $button = $(`#${triggeringElement.id}`).parent(C_BUTTON);
          }
          break;
        case C_KEYPRESS_EVENT:
          triggeringElement.id = e.target.id;
          // If the ENTER-key was pressed, the event type is changed to 'enter' to allow for easy detection within ADC
          switch (e.keyCode) {
            case 13:
              triggeringElement.event = C_ENTER_EVENT;
              break;
            // add other key codes here if necessary
          }
          break;
        default:
          triggeringElement.id = e.target.id;
      }
      apex.debug.info(`Event '${triggeringElement.event}' raised at Triggering element '${triggeringElement.id}'`);
    }
  }

  /**
   * Method to execute all JavaScript code passed in with the response of ADC
   * The code is added to the document using <code>$.append</code> which immediately executes any JavaScript.<br>
   * After appending, the response can be deleted because it does not make any sense to store it on the page any further
   * After deleting, the execute method raises the next event on the queue (if any)
   * @param {string} pCode JavaScript code to execute
   * @private
   */
  function executeCode(pCode) {
    var ScriptSelector;
    if (pCode) {
      console.log('Response received: \n' + pCode);
      $(C_BODY).append(pCode);
      ScriptSelector = '#' + $(pCode).attr('id');
      $(ScriptSelector).remove();
    }
    $(C_BODY).dequeue();
  }


  /**
   * Helper to identify page items to apply <code>pAction</code> to
   * @param {string} pSelector jQuery selector to identify page items
   * @param {function} pAction Action to execute on the found page items
   * @private
   */
  function forEach(pSelector, pAction) {
    if (!($.isArray(pSelector) || pSelector.search(/[\.#\u0020:\[\]]+/) >= 0)) {
      // übergebenes ITEM ist Elementname, um # erweitern
      pSelector = `#${pSelector}`;
    }

    if (pSelector.match(/oj.*/)){
      // item is Oracle Jet item group, traverse up
      pSelector = $(`#${pSelector}`).closest('div.apex-item-group').attr('id');
    }
    $(pSelector).each(pAction);
  }

  /** Method to determine the type a region has
   * @param {string} pRegionId Id to identify the region.
   * @return One of the constants C_REGION_...
   * @private
   */
  function getRegionType(pRegionId){
    var C_CR_SELECTOR = `#report_table_${pRegionId}`;
    var C_IR_SELECTOR = `#${pRegionId}_ir`;
    var C_IG_SELECTOR = `#${pRegionId}_ig`;
    var C_TREE_SELECTOR = `#${pRegionId}_tree`;
    var report$ = $(`#${pRegionId}`);
    var reportType;

    if(report$.find(C_IG_SELECTOR).length > 0){
      reportType = C_REGION_IG;
    }
    else if(report$.find(C_IR_SELECTOR).length > 0){
      reportType = C_REGION_IR;
    }
    else if(report$.find(C_CR_SELECTOR).length > 0){
      reportType = C_REGION_CR;
    }
    else if(report$.find(C_TREE_SELECTOR).length > 0){
      reportType = C_REGION_TREE;
    }

    return reportType;
  }
  
  /** Method to detect unsaved changes on the page
   *  Is used in conjunction with {@see: rememberPageItemStatus} which has saved the initial page status before.
   *  Compares the actual values against pageStatus and returns true if at least one value has changed.
   * @param {Array} pPageItems Optional array of all page item ids to capture. If empty, all page items are captured.
   * @private
   */
  function hasUnsavedChanges(pPageItems){
    var itemList;
    var itemValue;
    var isDifferent = false;
    
    // Initialize
    Array.isArray(pPageItems) ? itemList = pPageItems : itemList = $(C_INPUT_SELECTOR);
    
    $.each(itemList, function(item){
      item = itemList[item];
      if(item.id){
        item = item.id;
      };
      apex.debug.info(`Comparing ${item}`);
      if (pageStatus.has(item) && pageStatus.get(item) != apex.item(item).getValue()){
        isDifferent = true;
        return false;
      }
    });
    return isDifferent;
  }
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

    if(maintainAndCheckEventLock()){
      var additionalPageItems = triggeringElement.data.additionalPageItems || []; 
      var pageItems = new Set([...adc.pageItems, ...additionalPageItems]);
      pageItems = Array.from(pageItems);
      
      apex.debug.info(`ADC handles event ${triggeringElement.event}`);
      apex.debug.info(`ADC sends PageItems ${adc.pageItems.join()}`);
      server.plugin(
        adc.ajaxIdentifier,
        {
          "x01": triggeringElement.id,
          "x02": triggeringElement.event,
          "x03": JSON.stringify(triggeringElement.data),
          "pageItems": pageItems
        },
        {
          "dataType": "html",
          "success": function (pADCResponse) {
            if (triggeringElement.isClick) {
              apex.item(triggeringElement.id).enable();
            }
            executeCode(pADCResponse);
          }
        }
      );
      // reset additional one time page items
      adc.additionalItems = [];
    }
  };


  /**
   * Initialization method.<br>
   * This method is called during rendering of the APEX page. It installs the plugin on the page and creates the necessary event handler.
   * To achive this, parameter <code>pAction</code> with the necessary attributes is passed in and evaluated.<br>
   * @param {pAction} pAction Json object passed in during initialization
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.init = function (pAction) {
    // bind all page items required by ADC
    adc.bindItems = $.parseJSON(pAction.attribute01.replace(/~/g, '"'));
    
    // register all required items (the actual value of those items will be included in any ADC call)
    adc.pageItems = [];
    adc.additionalItems = [];
    if (pAction.attribute02) {
      apex.debug.info('Required PageItems: ' + pAction.attribute02);
      adc.pageItems = pAction.attribute02.split(',');
    }

    bindObserverItems(pAction.attribute05);

    // register adc.ApexJS namespace object and Ajax identifier
    adc.ApexJS = eval(pAction.attribute03);
    adc.ajaxIdentifier = pAction.ajaxIdentifier;

    // Prepare page for ADC usage
    bindEvents();
    apex.debug.info('ADC initialized');

    // exceute initial JavaScript code passed in from the server
    executeCode(hexToChar(pAction.attribute04));
  };
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
      var pItemId = $(this).attr('id');
      adc.ApexJS.alignReportVerticalTop(pItemId);
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
      var eventList;

    if ($this.length > 0) {
      // Element is also present on page (could be missing due to condition)
      eventList = $._data($this.get(0), 'events');
      if (typeof eventList != 'undefined' && eventList[C_CLICK_EVENT]) {
        $this.off(C_CLICK_EVENT);
      }
      // bind confirmation handler to the click event
      $this.on(C_CLICK_EVENT,
               { "ajaxIdentifier": adc.ajaxIdentifier,
                 "message": pMessage,
                 "pageItems": adc.pageItems,
                 "title": pDialogTitle
               },
               confirmCallback);
    }
  };

  /**
   * Bind a confirmation dialog to a button to show a confirmation dialog before an event is raised
   * @param {string} pItemId ID of the button to bind the event to
   * @param {string} pMessage Confirmation message
   * @param {string} pDialogTitle Title of the confirmation dialog box
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.bindUnsavedWarning = function (pItemId, pMessage, pDialogTitle) {
    var $this = $(`#${pItemId}`);
      var eventList;

    if ($this.length > 0) {
      // Element is also present on page (could be missing due to condition)
      eventList = $._data($this.get(0), 'events');
      if (typeof eventList != 'undefined' && eventList[C_CLICK_EVENT]) {
        $this.off(C_CLICK_EVENT);
      }
      // bind confirmation handler to the click event
      $this.on(C_CLICK_EVENT,
               { "ajaxIdentifier": adc.ajaxIdentifier,
                 "message": pMessage,
                 "pageItems": adc.pageItems,
                 "title": pDialogTitle
               },
               unsavedCallback);
    }
  };

  /**
   * Wrapper around <code>adc.execute</code> that raises a command event along with the necessary data.<br>
   * This method is used as the standard action for a command object to make sure that ADC is informed that
   * an ADC maintained APEX action was invoked.
   * @param {commandData} pData Name of the command to execute or a JSON instance containing the command name and additional information.
   * @see {@link apex.action}
   * @see {@link adc.execute}
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.executeCommand = function(pData){
    var data;
    if(typeof pData == 'string'){
      data = {"command":pData,"additionalPageItems":[]};
    }
    else{
      data = pData;
      data.additionalPageItems = data.additionalPageItems || [];
    }
    
    triggeringElement = {
      "event":"command",
      "id":"COMMAND",
      "isClick":false,
      "data":data
    };
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
    var report$ = $(`#${pReportId}`);
    var tree$;
    var selectedNodes;
    var idList;
    var pkValue;

    var persistOrReport = function(pValue){
      if(pItemId){
        apex.item(pItemId).setValue(pValue);
      }
      else{
        // No item present, submit ID with event C_SELECTION_CHANGE
        triggeringElement.id = pReportId;
        triggeringElement.event = C_SELECTION_CHANGE;
        triggeringElement.isClick = false;
        triggeringElement.data = pValue;
        adc.execute();
      }
    };

    // Examine type of report and bind click handler
    switch(getRegionType(pReportId)){
      case C_REGION_CR:
        report$.on('click', '.t-Report-report tbody tr', function(){
          pkValue = $(this).find('td [data-id]').data('id');
          persistOrReport(pkValue);
        });
        break;
      case C_REGION_IG:
        report$.on(C_IG_SELECTION_CHANGE, function(e, data){
          if(data.selectedRecords.length){
            // Try to get the primary key information from the identity column.
            // If none exists, get it from the column index passed in
            if(pColumn){
              pkValue = data.selectedRecords[0][Math.max(pColumn - 1, 0)];
            }else{
              pkValue = data.model.getRecordId(data.selectedRecords[0]);
            }
            persistOrReport(pkValue);
          }
        });
        break;
      case C_REGION_IR:
        report$.on('click', '.a-IRR-table tr:not(:first-child)', function(){
          pkValue = $(this).find('td [data-id]').data('id');
          persistOrReport(pkValue);
        });
        break;
      case C_REGION_TREE:
        tree$ = $(`#${pReportId}_tree`);
        tree$.on(C_TREE_SELECTION_CHANGE, function(){
          selectedNodes = tree$.treeView('getSelectedNodes');
          idList = selectedNodes
                   .map(function(item){return item.id;})
                   .join(':');
          persistOrReport(idList);
        });
        break;
    }
  };
  
  /**
   * Hides filter panels from IR and IG. Delegates hiding the filter panel to <code>adc.ApexJS</code>.
   * @param {string} pSelector jQuery selector of the regions that contain a filter panel to hide
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.hideReportFilterPanel = function (pSelector) {
    forEach(pSelector, function () {
      var pItemId = $(this).attr('id');
      adc.ApexJS.hideReportFilterPanel(pItemId);
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

  function pauseChangeEventDuringRefresh(pItem, pItemValue){
    var $item = $(`#${pItem}`);
    var node = $item.get(0);
    var itemEvents;
    var temporalEvents;

    if ($item.length > 0){
      // Refresh throws a change event which can lead to unwanted MANDATORY checks prior to setting the value
      // change events are therefore removed and reattached after setting the value.
      // persist actually assigned event handlers
      itemEvents = $._data(node, 'events');
      
      // Make a deep copy of events, remove change and assign it to the item
      temporalEvents = $.extend(true, [], itemEvents);
      delete temporalEvents.change;
      $._data(node, 'events', temporalEvents);
      
      $item
      .one(C_APEX_AFTER_REFRESH, function(e){
        if (pItemValue){
          apex.item(pItem).setValue(pItemValue, pItemValue, true);
        }; 
        // restore original events
        $._data(node, 'events', itemEvents);
      });
    };
  };
  
  /** Method to register a list of page items that are to be additionally sent to the server during the next ADC event
   * @param {JSON} pItemList Array of page item names
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.registerPageItemsOnce = function(pItemList){
    adc.additionalItems = pItemList;
  };
  
  /** Method to persist the status of all page items or only the items provided as pPageItems
   *  This is the basis for "unsaved changes" messages in a dynamic environment
   * @param {Array} pPageItems Optional array of all page item ids to capture. If empty, all page items are captured.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.rememberPageItemStatus = function(pPageItems){
    var itemList;
    var itemValue;
    
    // Initialize
    pageStatus.clear();    
    Array.isArray(pPageItems) ? itemList = pPageItems : itemList = $(C_INPUT_SELECTOR);
    
    $.each(itemList, function(item){
        item = itemList[item];
        if(item.id){
          item = item.id;
        };
        itemValue = apex.item(item).getValue();
        pageStatus.set(item, itemValue);
        apex.debug.info(`Saving ${item} with value ${itemValue}`);
      }
    );
  };

  /**
   * Refreshes an item (region, page item etc.). Triggers apexrefresh event and enables the page item.
   * @param {string} pItemId ID of the page item to refresh
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.refresh = function (pItemId) {
   if($(`div#${pItemId}.js-apex-region`).length > 0){
     apex.region(pItemId).refresh();
   }
   else{
     apex.item(pItemId).show();
     apex.item(pItemId).enable();
     apex.item(pItemId).refresh();
     pauseChangeEventDuringRefresh(pItemId);
   };
  };

  /**
   * Refreshes an item (region, page item etc.) and sets the item value afterwards.
   * The following flow of actions are taken:<ul>
   * <li>Persist the actual value of the page item</li>
   * <li>Bind one time apexafterrefresh handler to set the page item value to the persisted value after refresh</li>
   * <li>Trigger apexrefresh event</li>
   * <li>enable the page item</li></ul>
   * @param {string} pItemId ID of the page item to refresh and set the value
   * @param {string} pValue Optional value. If not set, method looks for actual item value in cache or on page.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.refreshAndSetValue = function (pItemId, pValue) {
   var itemValue = pValue || apex.item(pItemId).getValue() || findItemValue(pItemId);
   var $item = $(`#${pItemId}`);
   var node = $item.get(0);

   apex.item(pItemId).show();
   apex.item(pItemId).enable();
   apex.item(pItemId).refresh();
   pauseChangeEventDuringRefresh(pItemId, itemValue);
  };

  /** Method to select an entry in an IR, IG or TREE. So far, only Tree and Interactive Grid are implemented
   * @param {string} pRegionId  ID of the region to select an entry in
   * @param {string} pEntryId   ID of the entry to select
   * @param {boolean} pNoNotify If true the treeView#event:selectionChange event will be suppressed.
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.selectEntry = function(pRegionId, pEntryId, pNoNotify){
    const C_CR_SELECTOR = `#report_table_${pRegionId}`;
    const C_IR_SELECTOR = `#${pRegionId}_ir`;
    const C_IG_SELECTOR = `#${pRegionId}_ig`;
    const C_TREE_SELECTOR = `#${pRegionId}_tree`;

    var region$;
    var entry;

    switch(getRegionType(pRegionId)){
      case C_REGION_CR:
        break;
      case C_REGION_IG:
        region$ = $(C_IG_SELECTOR);
        entry = region$
                .interactiveGrid('getViews', 'grid')
                .model
                .getRecord(pEntryId);
        if(entry){
          region$.interactiveGrid('setSelectedRecords', entry, true, pNoNotify);
        }
        break;
      case C_REGION_IR:
        break;
      case C_REGION_TREE:
        region$ = $(C_TREE_SELECTOR);
        entry = region$.treeView(
                  "find",
                  {"depth": -1,
                   "match": function(n){
                              return n.id === pEntryId;
                            }
                  }
                );
        region$.treeView('collapseAll');
        region$.treeView('expand', entry);
        region$.treeView('setSelection', entry, true, pNoNotify);
        break;
    }
  };


  /** Method makes an APEX action shortcut visible by adding a CSS class around the access key letter.<br>
   * This method finds the first letter that matches the shortcut key and surrounds it with a span element and a CSS class.<br>
   * <strong>IMPORTANT</strong>: This method only supports simple shortcuts like <code>Alt-T</code>!
   * @param {string} pAction Name of the APEX action on the page
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setApexActionAccessKey = function (pAction){
    const C_SHORTCUT_CLASS = 'accesskey';
    const C_DATA_SHORTCUT_CLASS = 'data-accesskey';
    const C_BUTTON_LABEL_CLASS = 't-Button-label';

    var re;
    var $this;
    var $label = $this.find(`.${C_BUTTON_LABEL_CLASS}`);
    var label = $label.html();
    var shortcut = re.exec(label);

    var $buttons = $(`[data-action="${pAction}"]`);
    var accesskey = apex.actions.lookup(pAction).shortcut;

    if(accesskey !== "") {
      accesskey = accesskey.slice(-1);
    }
    if(accesskey.length > 0){
      re = new RegExp(accesskey, "i");
      $buttons.each(function(){
        $this = $(this);

        if(!$this.find(`.${C_BUTTON_LABEL_CLASS}`)[0]){
          $this.html(`<span class="${C_BUTTON_LABEL_CLASS}">${$this.html()}</span>`);
        }

        $label.html(
            label.replace(re,
                          `<span class="${C_SHORTCUT_CLASS}">${shortcut}</span>`));

        $this.attr('accesskey', shortcut);
        $this.attr('data-accesskey', label.search(re));
      });
    }
  };

  /**
   * Sets this visible aspects of a page items.
   * @param {string} pSelector jQuery selector of the items that shall be shown
   * @param {string} pVisibleState One of the constants HIDE | SHOW_DISABLE | SHOW_ENABLE
   * @param {string} pLabel If set, controls the label of the page items
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setDisplayState = function (pSelector, pVisibleState, pLabel) {
    forEach(pSelector, function () {
      var pItemId = $(this).attr('id');
      const C_HIDE = 'HIDE';
      const C_SHOW_DISABLE = 'SHOW_DISABLE';
      const C_SHOW_ENABLE = 'SHOW_ENABLE';
      
      switch(pVisibleState){
        case C_HIDE:
          apex.item(pItemId).hide();
          break;
        case C_SHOW_DISABLE:
          apex.item(pItemId).show();
          adc.ApexJS.disableElement(pItemId);
          // Beside disabling the item, all events from the queue must be removed
          // to assure that a disabled button can not raise a click event
          $(C_BODY).clearQueue();
          break;
        case C_SHOW_ENABLE:
          apex.item(pItemId).show();
          adc.ApexJS.enableElement(pItemId);
          break;
        default:
          apex.debug.info(`Visual State ${pVisibleState} not supported`);
      }

      if(pLabel){
        adc.ApexJS.setItemLabel(pItemId, pLabel);
      }
    });
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
    }
    adc.ApexJS.maintainErrors(pErrorList);
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
      var pItemId = $(this).attr('id');
      apex.item(pItemId).setValue(pValue, pValue, true);
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
      if ((this.value || 'FOO') !== (apex.item(this.id).getValue() || 'FOO')) {
        // third attribute surpresses the change event if set to true
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.info(`Item '${this.id}' set to '${this.value}'`);
      }
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
      var pItemId = $(this).attr('id').replace('_CONTAINER', '');
      if (pIsMandatory) {
        if ($.inArray(pItemId, adc.pageItems) === -1) {
          adc.pageItems.push(pItemId);
          bindEvent(pItemId, C_CHANGE_EVENT);
        }
      }
      adc.ApexJS.setItemMandatory(pItemId, pIsMandatory);
    });
  };
  
  /**
   * Sets the title of a modal dialog window
   * @param pTitle Title of the modal window
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.setModalDialogTitle = function(pTitle){
    adc.ApexJS.setModalDialogTitle(pTitle);
  };

  /** Shows or hides a waiting spinner
   * @param {boolean} pFlag Flag to indicate whether
   *                        to show (true) a wait spinner or not (false)
   * @memberof de.condes.plugin.adc
   * @public
   */
  adc.showWaitSpinner = function(pFlag){
    adc.ApexJS.showWaitSpinner(pFlag);
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

}(de.condes.plugin.adc, apex.jQuery, apex.server));


// Interface to APEX plugin mechanism.
// For some reason I don"t really understand, it is impossible
// to tell APEX to directly use a namespace object here.
function de_condes_plugin_adc() {
  de.condes.plugin.adc.init(this.action);
}