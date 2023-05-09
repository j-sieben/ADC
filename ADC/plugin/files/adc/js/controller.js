var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
   <p>This file implements the client-side controller component of APEX Dynamic Controller.<br>
    Its task is to
      <ul>
        <li>create the necessary event handlers when the page is rendered>li><li>collect the relevant data from the page when an event occurs and send it to the server>li><li>implement the returned response with instructions to modify the application page.>li>
      >ul>
    >p>
    <p>The controller works on the server side with a decision tree that computes a list of action instructions for a given situation.<br>
    During the calculation, the state of the application page can be changed by actions, which leads to a recursive check of the changed page state against the decision tree. The response includes all change instructions for the application page, including the recursive change instructions.>p>
    <p>The ADC response is delivered in the form of a script with an ID and inserted on the page by this component. Thus, all included actions are executed directly. Afterwards, the plugin removes the server's response, as it is no longer needed.>p>
    <p>Change instructions to application page partly depend on APEX version used and especially on theme used. The plugin starts from Theme 42, however, all theme-specific implementations of the activities are swapped out into a separate file, which is linked as a namespace object when parameterizing the plugin as a component parameter. As per default, this is <de.condes.plugin.adc.apex_42_5_1>, implementent in file <adcApex.js>, but it can be easily replaced by a client specific implementation.>p>
    <p>To work, this plugin must only be called during page load, no administration or parameterization is required.>p>
   */
(function (adc, $, server) {
  "use strict";

  /**
   * @typedef {Object} error
   * @description
     <p>An error is a JSON object representing an error. It contains information about the error message, the affected page item and additional information that shows only if the page is rendered in debug mode.>p>
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
     Firing items provide information about page items that have been 'touched' by executed rules. Intention is to remove any error that is related to a firing item from the collection of errors on the page and replace it with the newly provided error message, if any. This way, error messages which don't apply are removed, but errors relating to other page items on the page stay on page.>p>
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
   * @typedef {Object} props.triggeringElement
   * @description <p>An object to collect informations about the triggering item>p>
   * @type Object
   *
   * @property {string} id ID of the page element that triggered the event.
   * @property {string} event Name of the event that was raised. May be a different event than originally raised,fi. an <enter> that is raised if a <keypress> event was found for the Enter-key.
   * @property {string} isClick Flag to indicate whether the event was some kind of click event
   * @property {string} data Optional data that is passed with the event. May be a simple string or a JSON object.
   */

  /**
   * @typedef {Object} pAction
   * @description <p>An answer object of the plugin framework containing attributes to control further processing>p>
   * @type Object
   *
   * @property {string} attribute_01 JSON object containing all page items and their events which are bound by the plugin
   * @property {string} attribute_02 JSON obejct of elements that have changed during ADC processing along with their actual values
   * @property {string} attribute_03 Namespace of the <adc. ApexJS> object used to render the visual effects of ADC
   * @property {string} attribute_04 JavaScript code to be executed on the page. Sets the initial visual state of the page
   * @property {string} attribute_05 jQuery selector or Array of additional page items which are not bound to event handlers but their value is passed to ADC
   */

  /**
   * @typedef {Object} props.eventData
   * @description <p>A Json object containting data for the server call such as the ajaxIdentifier and the page items to submit>p>
   * @type Object
   *
   * @property {string} ajaxIdentifier Reference to props.ajaxIdentifier
   * @property {string} props.pageItems reference to <props.pageItems>
   */

  /**
   * @typedef {Object} commandData
   * @description <p>A Json object containting data describing a command object which is based on @link{apex.action}>p>
   * @type Object
   *
   * @property {string} command Name of the command to execute
   * @property {string} event Event object that raised the action
   * @property {string} focusItem ID of the item that gets focus if the execution of a command returns true
   * @property {string} additionalPageItems Array of page item IDs which have to be passed in addition to the normal props.pageItems collection.
   * @property {string} data Additional information that is passed along with the command, fi. for values
   */

  /**
    Group: Constants
   */
  const C_CHANGE_EVENT = 'change';
  const C_CLICK_EVENT = 'click';
  const C_DBLCLICK_EVENT = 'dblclick';
  const C_ENTER_EVENT = 'enter';
  const C_KEYPRESS_EVENT = 'keypress';
  const C_APEX_BEFORE_REFRESH = 'apexbeforerefresh';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_APEX_AFTER_CLOSE_DIALOG = 'apexafterclosedialog';
  const C_NO_TRIGGERING_ITEM = 'DOCUMENT';
  const C_LOCK_LENGTH = 200;
  const C_PROTECTED_EVENTS = [C_CLICK_EVENT, C_DBLCLICK_EVENT, C_ENTER_EVENT];
  const C_BODY = 'body';
  const C_BUTTON = 'button';
  const C_APEX_BUTTON = 't-Button';
  const C_INPUT_SELECTOR = ':input:visible:not(button)';

  // Global
  adc.controller = {};
  var ctl = adc.controller;
  var props = {
    "ajaxIdentifier":"",
    "quarantineList":[],
    "triggeringElement":{
      "id": "",
      "data": "",
      "event": "",
      "isClick": false
    },
    "eventData":{
      "ajaxIdentifier":"",
      "pageItems":""},
    "pageState":{
      "itemMap":new Map()
    },
    "pageItems":[],
    "bindItems":[],
    "lastItemValues":[],
    "additionalItems":[]
  };

  /**
    Group: Internal Callback methods
   */
  /** 
    Function: changeCallback  
      Callback method for a change event
      
      Any event is pushed to a queue to process them one by one, depending on the outcome of the predecessor.
      As an example, if a page item is focussed and the user clicks on a button, two events occur:
      
        - change event on the page item
        - click event on the button
        
      If the change event triggers a computation that returns an error (such as a page item validation), in many cases the click event
      of the button must not be processed anymore. But because these events appear so quickly, ADC is unable to respond before the
      click event is handled. Therefore, these events a queued. If ADC returns with an error, the queue is cleared and the next events will not be processed.
      
    Parameters:
      pEvent - Event that occured
      props.eventData - Additional event data that is passed with the event. May be accessed by ADC.GET_EVENT_DATA within the database
      pWait - Flag to indicate whether a wait spinner should be shown during processing
   */
  const changeCallback = function(pEvent, pEventData, pWait) {
    getTriggeringElement(pEvent);

    $(C_BODY).queue(function () {
      adc.actions.showWaitSpinner(pWait);
      ctl.execute(pEvent, pEventData);
    });
  }; // changeCallback
      
    
  /** 
    Function: enterCallback
      Wraps the call to the database in a confirmation dialog to enable the user to surpress this event.
      
    Parameters:
      pEvent - Event that occured
      pEventData - <props.eventData> instance that goes along with the event
    */
  const enterCallback = function (pEvent, pEventData, pWait){
    getTriggeringElement(pEvent);

    // Place request in queue to process multiple events in sequence
    if (props.triggeringElement.event === C_ENTER_EVENT){
      apex.debug.info(`Enqueueing Event '${C_ENTER_EVENT}'`);
      $('body').queue(function(){
        
        adc.actions.showWaitSpinner(pWait);
        ctl.execute(pEventData);
      });
    }
  }; // enterCallback
      
    
  /** 
    Function: unsavedCallback
      Wraps the call to the database in a confirmation dialog that is shown if the page contains unsaved changes.
      
    Parameters:
      pEvent - Event that occured
      pWait - Flag to indicate whether a wait spinner should be shown during processing
    */
  const unsavedCallback = function (pEvent, pWait) {
    getTriggeringElement(pEvent);

    $(C_BODY).queue(function () {
      
      adc.actions.showWaitSpinner(pWait);
      if(ctl.hasUnsavedChanges()){
        // Handle event only after confirmation from the user
        adc.renderer.confirmRequest(pEvent, changeCallback);
      }
      else{
        // No changes on the page, continue
        changeCallback(pEvent);
      };
    });
  }; // unsavedCallback


  /**
    Group: Interal Helper methods
   */
  /**
    Function: bindEvent
      Binds an event to a page item
      
    Parameters:
      pItemId - ID of the element to bind
      pEvent - Nmae of the event to bind.
      pAction - Optional callback method. Overrides default behaviour of calling <changeCallback>
   */
  const bindEvent = function (pItemId, pEvent, pAction) {
    var $this;
    var callback;

    if (pItemId.search(/[\.#\u0020:\[\]]+/) < 0) {
      pItemId = `#${pItemId}`;
    }
    $this = $(pItemId);

    // Check whether element exists on page (could be missing due to a server condition)
    if ($this.length > 0) {
      if (typeof pAction == 'function'){
        callback = pAction;
      }
      else if(typeof pAction != 'undefined' && pAction.length > 0){
        callback = new Function(pAction);
      }
      else {
        callback = changeCallback;
      }

      // ADC unbinds event handlers bound to this item to prevent problems between the different handlers
      $this
        .off(pEvent)
        .on(pEvent, props.eventData, callback);
      if (pEvent === C_CHANGE_EVENT) {
        // CHANGE event should not be called after APEXREFRESH, so pause it until apexafterrefresh
        $this
        .on(C_APEX_BEFORE_REFRESH, function (e) {
          $(this).off(C_CHANGE_EVENT);
          apex.debug.info(`Event '${C_CHANGE_EVENT}' paused at ${pItemId}`);
        })
        .on(C_APEX_AFTER_REFRESH, function (e) {
          $(this).on(C_CHANGE_EVENT, props.eventData, callback);
          apex.debug.info(`Event '${C_CHANGE_EVENT}' re-established at ${pItemId}`);
        });
      }
    }
  }; // bindEvent
  

  /**
    Function: bindEvents
      Binds all events that are requested by the plugin via <props.bindItems>.

      Upon initialization, all relevant page items are collected along with the required events.
      This method then binds all items with the respective event.
   */
  const bindEvents = function () {
    $.each(props.bindItems, function () {
      if(this.event == C_ENTER_EVENT){
        bindEvent(this.id, C_KEYPRESS_EVENT, this.action || enterCallback);
      }
      else{
        bindEvent(this.id, this.event, this.action);
        if (this.event === C_CHANGE_EVENT) {
          addPageItem(this.id);
        }
      }
    });
  }; // bindEvents
  

  /**
    Function: bindObserverItems
      Method identifies all elements whose values must be sent to the database with any request.
      Two possible ways exist to add an item to this observer list:
      
      - Initialization code of the plugin that automatically detects items that have a value and are referenced by page rules
      - Explicit observation as requested by a ADC rule action
      
      The second option calls this method.
    
    Parameter:
      pSelector - jQuery selector to identify the item(s) that must be observed explicitly
   */
  const bindObserverItems = function (pSelector) {
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
          if ($.inArray(element, props.pageItems) === -1) {
            props.pageItems.push(element);
          }
        }
      });
    }
  }; // bindObserverItems


  /**
    Function: addPageItem
      Method adds a page item to a list of page items to be sent to the server with every call.
      
    Parameter:
      pItemId - ID of the page item that ahould be added
   */
  const addPageItem = function (pItemId) {
    if ($.inArray(pItemId, props.pageItems) === -1) {
      props.pageItems.push(pItemId);
    }
  }; // addPageItem
  

  /**
    Function: executeCode
      Method to execute all JavaScript code passed in with the response of ADC.
      
      The code is added to the document using <$.append> which immediately executes any JavaScript.
      After appending, the response can be deleted because it does not make any sense to store it on the page any further.
      After deleting, the execute method raises the next event on the queue (if any).
      
    Parameter:
      pCode - JavaScript code to execute
   */
  const executeCode = function (pCode) {
    var ScriptSelector;
    if (pCode) {
      console.log('Response received: \n' + pCode);
      $(C_BODY).append(pCode);
      ScriptSelector = '#' + $(pCode).attr('id');
      $(ScriptSelector).remove();
    }
    $(C_BODY).dequeue();
  }; // executeCode
  

  /**
    Function: getTriggeringElement
      Method to describe the event and calling item after an event has occured.
      
    Parameter:
      e - Event to get the triggering element for
   */
  const getTriggeringElement =function (pEvent) {
    var $element;
    var $button;

    // Copy event data to a local variable to allow for tayloring
    props.triggeringElement.id = C_NO_TRIGGERING_ITEM;
    props.triggeringElement.event = pEvent.type;
    props.triggeringElement.data = pEvent.data;
    props.triggeringElement.isClick = false; // reset status to known default

    if (typeof pEvent.target != 'undefined') {
      switch (props.triggeringElement.event) {
        case C_APEX_AFTER_CLOSE_DIALOG:
          // CloseDialog is bound to currentTarget to allow for delegated events.
          props.triggeringElement.id = pEvent.currentTarget.id;
          break;
        case C_CHANGE_EVENT:
          props.triggeringElement.id = pEvent.target.id;

          $element = $(`#${props.triggeringElement.id}`);
          if ($element.attr('type') === 'radio' || $element.attr('type') === 'checkbox') {
            // In case of a radio group or a checkbox, the id has to be taken from the parent fieldset
            props.triggeringElement.id = $element.parents('.radio_group,.checkbox_group').attr('id');
          }
          if (props.triggeringElement.id.match(/oj.*/)){
            // item is Oracle Jet item group, traverse up
            props.triggeringElement.id = $(`#${props.triggeringElement.id}`).closest('div.apex-item-group').attr('id');
          }
          break;
        case C_CLICK_EVENT:
          // Flag is used to clear the event queue to prevent multiple clicks
          props.triggeringElement.isClick = true;
          props.triggeringElement.id = ((pEvent.target.id !== '') ? pEvent.target.id : pEvent.currentTarget.id);

          if (props.triggeringElement.id === '') {
            // Some browsers send accessKey-span instead of triggering element in response to a click
            // Get the parent element in these cases
            props.triggeringElement.id = pEvent.target.parentElement.id;
          }
          $button = $(`#${props.triggeringElement.id}`);
          // Depending on how a click event was raised (mouse or code), a different item is addressed
          if (!$button.hasClass(C_APEX_BUTTON)) {
            $button = $(`#${props.triggeringElement.id}`).parent(C_BUTTON);
          }
          break;
        case C_KEYPRESS_EVENT:
          props.triggeringElement.id = pEvent.target.id;
          // If the ENTER-key was pressed, the event type is changed to 'enter' to allow for easy detection within ADC
          switch (pEvent.keyCode) {
            case 13:
              props.triggeringElement.event = C_ENTER_EVENT;
              break;
            // add other key codes here if necessary
          }
          break;
        default:
          props.triggeringElement.id = pEvent.target.id;
      }
      apex.debug.info(`Event '${props.triggeringElement.event}' raised at Triggering element '${props.triggeringElement.id}'`);
    }
  }; // getTriggeringElement


  /**
    Function: hexToChar
      Method to cast a hex-string representation created with UTL_RAW.CAST_TO_RAW back to String.
      
      ADC submits its response as a hex string to circumvent escaping issues between JSON, JavaScript and JavaScript containing JSON.
      As a consequence, the hex string must be converted back to a normal string in order to append it to the page.
      
    Parameter:
      pRawString - Hex-encoded string to convert back to a normal string.
      
    Returns:
      Converted String
   */
  const hexToChar = function (pRawString) {
    var code = '';
    var hexString;

    if (pRawString) {
      hexString = pRawString.toString();
      for (let i = 0; i < hexString.length; i += 2) {
        code += String.fromCharCode(parseInt(hexString.substr(i, 2), 16));
      }
    }
    return code;
  }; //hexToChar
  

  /** 
    Function: maintainAndCheckEventLock
      Method to reject the same event for a certain amount of time to prevent double execution of ADC requests.
      
      Events, such as ENTER key or click may be raised quicker than ADC is able to consume then, leading to a double
      request and a double execution of rules. This may lead to a modal dialog to be shown twice or a double insert into
      a table, raising unique errors etc.
      
      To cater for this, an event is put on a props.quarantineList for a certain amount of time. This method administers this
      quarantine list and checks whether it is ok to raise an event.
   */
  const maintainAndCheckEventLock = function (){
    var isOkToRaiseEvent = true;
    var e = props.triggeringElement;

    if (C_PROTECTED_EVENTS.indexOf(e.event) > -1){
      if(props.quarantineList.indexOf(e.event) > -1){
        // Ignore event as it is on props.quarantineList
        apex.debug.info(`Ignoring Event '${e.event}', on quarantine list`);
        isOkToRaiseEvent = false;
      }
      else{
        // Remove any existing events from the queue
        apex.debug.info(`Clear event queue after locking an event`);
        $('body').clearQueue();

        // Put event on props.quarantineList to prevent double execution
        props.quarantineList.push(e.event);
        apex.debug.info(`Event '${e.event}' pushed on quarantine`);

        // Pop event after C_LOCK_LENGTH from quarantine
        setTimeout(
          function(){
           props.quarantineList = [];
           apex.debug.info(`Event '${e.event}' popped from quarantine`);
          },
          C_LOCK_LENGTH
        );

        // Additionally disable button to prevent double click. Will be enabled by the response of ADC
        if (e.isClick){
          apex.debug.info(`Locking button '${e.id}'`);
          apex.item(e.id).disable();
        }
      }
    }
    return isOkToRaiseEvent;
  }; // maintainAndCheckEventLock


  /**
    Function: addButtonHandler
      Binds a confirmation or unsavedConfirmation callback to a button

    Parameters:
      pTarget - jQuery item representing the page item to bind to
      pMessage - Message to show within the confirmation
      pDialogTitle - Title of the dialog
   */
  const addButtonHandler = function (pTarget, pMessage, pDialogTitle, pCallback){
    let eventList;
    // Element is also present on page (could be missing due to condition)
    eventList = $._data(pTarget.get(0), 'events');
    if (typeof eventList != 'undefined' && eventList[C_CLICK_EVENT]) {
      pTarget.off(C_CLICK_EVENT);
    }
    pTarget.on(C_CLICK_EVENT,
      { "ajaxIdentifier": props.ajaxIdentifier,
        "message": pMessage,
        "props.pageItems": props.pageItems,
        "title": pDialogTitle
      },
      pCallback);
  }; // addButtonHandler


  /* +++++ END PRIVATE  ++++++++ */

  /* ++++++++++ CORE FUNCTIONALITY ++++++++++ */
  
  /** 
    Function: bindConfirmationHandler
      Shows a confirmation dialog prior to raising the ADC event notification.
      
    Parameters:
      pTarget - jQuery item representing the page item to bind to
      pMessage - Message to show within the confirmation
      pDialogTitle - Title of the dialog
      pApexAction - Optional Apex action command name
   */
  ctl.bindConfirmationHandler = function(pTarget, pMessage, pDialogTitle, pApexAction){
    let innerCallback;
    let callback;
    // Handle event only after confirmation from the user
    if (pApexAction){
      innerCallback = function() {apex.actions.invoke(pApexAction);};
    } else {
      innerCallback = changeCallback;
    }
    callback = function(pEvent) {adc.renderer.confirmRequest(pEvent, innerCallback, pTarget.attr('id'));};
    addButtonHandler(pTarget, pMessage, pDialogTitle, callback);
  }; // bindConfirmationHandler

  
  /** 
    Function: bindUnsavedConfirmationHandler
      Shows a confirmation dialog prior to raising the ADC event notification if unsaved changes exist on page.
      
    Parameters:
      pTarget - jQuery item representing the page item to bind to
      pMessage - Message to show within the confirmation
      pDialogTitle - Title of the dialog
   */
  ctl.bindUnsavedConfirmationHandler = function(pTarget, pMessage, pDialogTitle){
    addButtonHandler(pTarget, pMessage, pDialogTitle, unsavedCallback);
  }; // bindUnsavedConfirmationHandler
  

  /**
    Function: findItemValue
      Method to persist the value of a page item.
      
      When a call to refresh a page item is issued, the value of this item is reset to NULL by APEX.
      This method allows to store the value of the item before refreshing it and to reset it to this value after refresh.
      
    Parameter:
      pItemId - ID of the page item. Perceived to be unique
   */
  ctl.findItemValue = function(pItemId) {
    var result = $.grep(props.lastItemValues, function (e) {
      return e.id === pItemId;
    });

    if (result.length > 0) {
      return result[0].value;
    }
  }; // findItemValue
  

  /**
    Function: getPageState
      Method to retrieve the actually valid page state
   */
  ctl.getPageState = function() {
    return props.pageState;
  }; // getPageState
  

  /**
    Function: setPageState
      Method to set the actually valid page state.

    Parameter:
      pPageState - Instance of the actually valid page state
   */
  ctl.setPageState = function(pPageState) {
    props.pageState = pPageState;
  }; // getPageState


  /**
    Function: pushPageItem
      Push a page item onto the props.pageItems property. 

    Parameter:
      pItemId - ID of the page item to push
   */
  ctl.pushPageItem = function(pItemId){
    if ($.inArray(pItemId, props.pageItems) === -1) {
      props.pageItems.push(pItemId);
      bindEvent(pItemId, C_CHANGE_EVENT);
    }
  }; // pushPageItem
  
  
  /** 
    Function: hasUnsavedChanges
      Method to detect unsaved changes on the page.
      
      Is used in conjunction with {@see: rememberprops.pageItemstatus} which has saved the initial page status before.
      Compares the actual values against props.pageState and returns true if at least one value has changed.
      
    Parameter:
      pPageItems - Optional array of all page item ids to capture. If empty, all page items are captured.
   */
  ctl.hasUnsavedChanges = function(pPageItems){
    var itemList;
    var isDifferent = false;
    
    // Initialize
    Array.isArray(pPageItems) ? itemList = pPageItems : itemList = $(C_INPUT_SELECTOR);
    
    $.each(itemList, function(item){
      item = itemList[item];
      if(item.id){
        item = item.id;
      };
      apex.debug.info(`Comparing ${item}`);
      if (props.pageState.itemMap.has(item) && props.pageState.itemMap.get(item) != apex.item(item).getValue()){
        isDifferent = true;
        return false;
      }
    });
    return isDifferent;
  }; // hasUnsavedChanges


  /**
    Function: pauseChangeEventDuringRefresh
      Refresh throws a change event which can lead to unwanted MANDATORY checks prior to setting the value
      change events are therefore removed and reattached after setting the value.

    Parameters:
      pItemId - ID of the page item that gets refreshed
      pItemValue - Actual value of the page item
   */
  ctl.pauseChangeEventDuringRefresh = function(pItemId, pItemValue){
    var $item = $(`#${pItemId}`);
    var node = $item.get(0);
    var itemEvents;
    var temporalEvents;

    if ($item.length > 0){
      // persist actually assigned event handlers
      itemEvents = $._data(node, 'events');
      
      // Make a deep copy of events, remove change and assign it to the item
      temporalEvents = $.extend(true, [], itemEvents);
      delete temporalEvents.change;
      $._data(node, 'events', temporalEvents);
      
      $item
      .one(C_APEX_AFTER_REFRESH, function(e){
        var pageState = ctl.getPageState();
        if (pItemValue){
          apex.item(pItemId).setValue(pItemValue, pItemValue, true);
          // if we are observing this item for changes, update the value to prevent false true change messages
          if (pageState.itemMap.has(pItemId)){
            pageState.itemMap.set(pItemId, pItemValue);
            ctl.setPageState(pageState);
          };
        }; 
        // restore original events
        $._data(node, 'events', itemEvents);
      });
    };
  }; // pauseChangeEventDuringRefresh


  /**
    Function: setAdditionalItems
      Method to extend the list of items to include in the page state. 

    Paarmeters:
      pItemList - Array of item names to add to the page state
   */
  ctl.setAdditionalItems = function(pItemList){
    props.additionalItems = pItemList;
  } // setAdditionalItems


  /**
    Function: setTriggeringElement
      Method to overwrite the props.triggeringElement. Allows for custom ADC event handling. 

    Paarmeters:
      pId - ID of the triggering page element. Not necessarily a page item
      pData - Optional event data to pass to ADC
      pEvent - Event that has to be raised. Not necessarily a browser or APEX event
      pIsClick - Flag to indicate whether a click event has to be bound. Controls handling of event protection
   */
  ctl.setTriggeringElement = function(pId, pEvent, pData, pIsClick){
    props.triggeringElement.id = pId;
    props.triggeringElement.event = pEvent;
    props.triggeringElement.data = pData;
    props.triggeringElement.isClick = pIsClick || false;
  } // setTriggeringElement


  /**
    Function: setLastItemValues
      Sets the list of page items that received changes lately
   */
  ctl.setLastItemValues = function(pPageItems){
    props.lastItemValues = pPageItems;
  };

  
  /**
    Function: execute
      Central event handler, calls ADC asynchronously and handles ADC response
   */
  ctl.execute = function(){

    if(maintainAndCheckEventLock()){
      if(props.triggeringElement.data && props.triggeringElement.data.additionalPageItems){
        props.pageItems = new Set([...props.pageItems, ...props.triggeringElement.data.additionalPageItems]);
        props.pageItems = Array.from(props.pageItems);
      }
      
      apex.debug.info(`ADC handles event ${props.triggeringElement.event}`);
      apex.debug.info(`ADC sends pageItems ${props.pageItems.join()}`);
      server.plugin(
        props.ajaxIdentifier,
        {
          "x01": props.triggeringElement.id,
          "x02": props.triggeringElement.event,
          "x03": JSON.stringify(props.triggeringElement.data),
          "pageItems": props.pageItems
        },
        {
          "dataType": "html",
          "success": function (pADCResponse) {
            if (props.triggeringElement.isClick) {
              apex.item(props.triggeringElement.id).enable();
            }
            executeCode(pADCResponse);
          }
        }
      );
      // reset additional one time page items
      props.additionalItems = [];
    }
  }; // execute

  
  /**
    Function: init
      Initialization method.
      
      This method is called during rendering of the APEX page. It installs the plugin on the page and creates the necessary event handler.
      To achive this, parameter <pAction> with the necessary attributes is passed in and evaluated.

    Parameter:
      pAction - Json object passed in during initialization
   */
  adc.init = function (pAction) {

    // bind all page items required by ADC
    props.bindItems = $.parseJSON(pAction.attribute01.replace(/~/g, '"'));

    // register adc.renderer namespace object and Ajax identifier
    adc.renderer = eval(pAction.attribute03);
    props.ajaxIdentifier = pAction.ajaxIdentifier;
    props.eventData.ajaxIdentifier = props.ajaxIdentifier;
    props.eventData.pageItems = props.pageItems;

    if (pAction.attribute02) {
      apex.debug.info('Required pageItems: ' + pAction.attribute02);
      props.pageItems = pAction.attribute02.split(',');
    }

    bindObserverItems(pAction.attribute05);

    // Prepare page for ADC usage
    bindEvents();
    apex.debug.info('ADC initialized');

    // execute initial JavaScript code passed in from the server
    executeCode(hexToChar(pAction.attribute04));
  }; // init

  /* +++++++++ END CORE FUNCTIONALITY +++++++++++ */

}(de.condes.plugin.adc, apex.jQuery, apex.server));


// Interface to APEX plugin mechanism.
// For some reason I don"t really understand, it is impossible
// to tell APEX to directly use a namespace object here.
function de_condes_plugin_adc() {
  de.condes.plugin.adc.init(this.action);
}