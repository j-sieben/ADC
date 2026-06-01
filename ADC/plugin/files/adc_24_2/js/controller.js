var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
 * Central client-side controller for ADC.
 *
 * Responsibilities:
 * - bind configured DOM and APEX events
 * - normalize browser events into ADC event context
 * - serialize protected events through the internal ADC queue
 * - submit current page state to the server
 * - execute the JavaScript response returned by ADC
 */
(function (adc, $) {
  "use strict";

  /**
   * @typedef {Object} error
   * @description Error payload returned by ADC for a single page item.
   * @property {string} item Page item affected by the error.
   * @property {string} message Error message shown to the user.
   * @property {string} additionalInfo Optional developer information for debug mode.
   */

  /**
   * @typedef {Object} errorList
   * @description Collection of validation errors returned by ADC for a request.
   * @property {string} count Number of errors in the payload.
   * @property {string[]} firingItems Items touched by the processed rules.
   * @property {error[]} errors Error instances to merge into the client-side collection.
   */

  /**
   * @typedef {Object} state.currentEvent
   * @description Normalized ADC event context for the currently processed trigger.
   * @property {string} id ID of the page element that triggered the event.
   * @property {string} event ADC event name derived from the browser event.
   * @property {string} isClick Flag indicating whether the trigger is click-like.
   * @property {*} data Optional event payload passed along with the trigger.
   */

  /**
   * @typedef {Object} pAction
   * @description Initialization payload passed to the plugin callback by APEX.
   * @type Object
   *
   * @property {string} ajaxIdentifier Ajax identifier used for subsequent ADC roundtrips.
   * @property {string} attribute_01 JSON payload containing ADC bind items and their configured events.
   * @property {string} attribute_02 Comma-separated list of page items submitted with ADC requests.
   * @property {string} attribute_03 Namespace of the renderer implementation selected for this plugin instance.
   * @property {string} attribute_04 Base64-encoded UTF-8 JavaScript initialization response returned by ADC.
   * @property {string} attribute_05 Comma-separated selector or item list of additional submitted items.
   * @property {string} attribute_06 JSON object containing localized standard messages.
   */

  /**
   * @typedef {Object} commandData
   * @description Command payload used for ADC-managed APEX actions.
   * @property {string} command Name of the command to execute.
   * @property {string} event Event object that raised the action.
   * @property {string} focusItem Item that should regain focus after successful execution.
   * @property {string[]} additionalPageItems Additional page items permanently added to ADC requests.
   * @property {*} data Optional command-specific payload.
   */

  const C_FILE_NAME = 'adc.js.controller.js';

  const C_CHANGE_EVENT = 'change';
  const C_CLICK_EVENT = 'click';
  const C_CLICK_EVENT_NAMESPACE = 'click.adc';
  const C_COMMAND_EVENT = 'command';
  const C_DBLCLICK_EVENT = 'dblclick';
                                    
  const C_ENTER_EVENT = 'enter';
  const C_KEYPRESS_EVENT = 'keypress';
  const C_APEX_BEFORE_REFRESH = 'apexbeforerefresh';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_APEX_AFTER_CLOSE_DIALOG = 'apexafterclosedialog';
  const C_APEX_AFTER_CANCEL_DIALOG = 'apexaftercanceldialog';
  const C_NO_TRIGGERING_ITEM = 'DOCUMENT';
  const C_LOCK_LENGTH = 500;
  const C_PROTECTED_EVENTS = [C_CLICK_EVENT, C_COMMAND_EVENT, C_DBLCLICK_EVENT, C_ENTER_EVENT, C_APEX_AFTER_CLOSE_DIALOG, C_APEX_AFTER_CANCEL_DIALOG];
  const C_BODY = 'body';
  const C_BUTTON = 'button';
  const C_APEX_BUTTON = 't-Button';
  const C_INPUT_SELECTOR = ':input:visible:not(button)';

  /**
   * Controller-local configuration and binding metadata.
   *
   * `props` intentionally contains only static or semi-static controller data.
   * Runtime state lives in `adc.state`.
   */
  adc.controller = {};
  var ctl = adc.controller;
  adc.callbacks = adc.callbacks || {};
  adc.state = adc.state || {
    errors: [],
    warnings: [],
    pendingEvents: [],
    isProcessingEvent: false,
    quarantineList: [],
    currentEvent: {
      id: "",
      data: "",
      event: "",
      isClick: false
    },
    pageItems: [],
    lastTriggeringElement: "",
    lastItemValues: [],
    additionalItems: [],
    transientPageItems: [],
    autoRefreshIntervals: {},
    standardMessages: {},
    pageState: {
      itemMap: new Map()
    }
  };
  const callbackRegistry = adc.callbacks.registry || {};
  adc.callbacks.registry = callbackRegistry;
  var state = adc.state;
  var props = {
    "ajaxIdentifier":"",
    "bindItems":[]
  };

  /**
   * Public callback registry used by ADC event bindings.
   *
   * External code may register named callbacks that can then be referenced
   * declaratively by ADC configuration.
   */
  adc.callbacks.register = function(pName, pCallback) {
    if (typeof pName === 'string' && pName.length > 0 && typeof pCallback === 'function') {
      callbackRegistry[pName] = pCallback;
    }
  };

  adc.callbacks.resolve = function(pName) {
    if (!pName) {
      return null;
    }

    if (typeof pName === 'function') {
      return pName;
    }

    return callbackRegistry[pName] || adc.utils.resolveNamespace(pName, window);
  };

  /**
   * Internal FIFO queue for ADC events.
   *
   * The queue serializes protected events and stores normalized event snapshots
   * in `adc.state.pendingEvents`.
   */
  const eventQueue = {
    cloneTriggeringElement: function() {
      return {
        id: state.currentEvent.id,
        data: state.currentEvent.data,
        event: state.currentEvent.event,
        isClick: state.currentEvent.isClick
      };
    },
    processNext: function() {
      let nextEvent;

      if (state.isProcessingEvent || state.pendingEvents.length === 0) {
        return;
      }

      nextEvent = state.pendingEvents.shift();
      state.isProcessingEvent = true;
      state.currentEvent = nextEvent.triggeringElement;
      adc.actions.showWaitSpinner(nextEvent.wait);
      ctl.execute();
    },
    enqueue: function(pWait) {
      state.pendingEvents.push({
        wait: pWait,
        triggeringElement: eventQueue.cloneTriggeringElement()
      });
      eventQueue.processNext();
    },
    clear: function() {
      state.pendingEvents = [];
    },
    maintainLock: function (){
      var isOkToRaiseEvent = true;
      var e = state.currentEvent;

      if (C_PROTECTED_EVENTS.indexOf(e.event) > -1){
        if(state.quarantineList.indexOf(e.event) > -1){
          apex.debug.info(`${C_FILE_NAME} - Ignoring Event '${e.event}', on quarantine list`);
          isOkToRaiseEvent = false;
        }
        else{
          apex.debug.info(`${C_FILE_NAME} - Clear event queue after locking an event`);
          eventQueue.clear();
          state.quarantineList.push(e.event);
          apex.debug.info(`${C_FILE_NAME} - Event '${e.event}' pushed on quarantine`);
        }
      }

      return isOkToRaiseEvent;
    },
    release: function() {
      state.isProcessingEvent = false;
      state.lastTriggeringElement = state.currentEvent.id;
      eventQueue.processNext();
    }
  };

  /**
   * DOM event binding helpers for ADC-managed elements.
   */
  const eventRegistry = {
    addPageItem: function (pItemId) {
      if ($.inArray(pItemId, state.pageItems) === -1) {
        state.pageItems.push(pItemId);
      }
    },
    resolveCallback: function (pItemId, pEvent, pAction) {
      var callback;

      if (typeof pAction == 'function'){
        callback = pAction;
      }
      else if(adc.utils.isNotEmpty(pAction)){
        callback = adc.callbacks.resolve(pAction);
        if (typeof callback !== 'function'){
          apex.debug.error(`${C_FILE_NAME} - Callback '${pAction}' could not be resolved for event '${pEvent}' on '${pItemId}'`);
        }
      }
      else {
        callback = changeCallback;
      }

      return callback;
    },
    bindChangeRefreshHandlers: function ($item, pItemId, pCallback) {
      $item
        .on(C_APEX_BEFORE_REFRESH, function () {
          $(this).off(C_CHANGE_EVENT);
          apex.debug.info(`${C_FILE_NAME} - Event '${C_CHANGE_EVENT}' paused at ${pItemId}`);
        })
        .on(C_APEX_AFTER_REFRESH, function () {
          $(this).on(C_CHANGE_EVENT, pCallback);
          apex.debug.info(`${C_FILE_NAME} - Event '${C_CHANGE_EVENT}' re-established at ${pItemId}`);
        });
    },
    bindButtonHandler: function (pTarget, pOptions, pCallback){
      pTarget.off(C_CLICK_EVENT_NAMESPACE);
      pTarget.on(C_CLICK_EVENT_NAMESPACE, { options: pOptions }, pCallback);
    }
  };

  /**
   * Server transport helpers for ADC roundtrips.
   */
  const transport = {
    scheduleLockReset: function() {
      setTimeout(
        function(){
         state.quarantineList = [];
        },
        C_LOCK_LENGTH
      );
    },
    getRequestPageItems: function() {
      return Array.from(new Set([
        ...state.pageItems,
        ...state.additionalItems,
        ...state.transientPageItems
      ]));
    },
    clearTransientPageItems: function() {
      state.transientPageItems = [];
    },
    executeResponse: function (pCode) {
      var ScriptSelector;
      if (pCode) {
        console.log(`${C_FILE_NAME} - Response received`, pCode);
        $(C_BODY).append(pCode);
        ScriptSelector = '#' + $(pCode).attr('id');
        $(ScriptSelector).remove();
      };
      
      transport.scheduleLockReset();
      
      eventQueue.release();
    },
    send: function() {
      const requestPageItems = transport.getRequestPageItems();

      transport.clearTransientPageItems();
      apex.debug.info(`${C_FILE_NAME} - ADC handles event ${state.currentEvent.event}`);
      apex.debug.info(`${C_FILE_NAME} - ADC sends pageItems ${requestPageItems.join()}`);
      apex.server.plugin(
        props.ajaxIdentifier,
        {
          "x01": state.currentEvent.id,
          "x02": state.currentEvent.event,
          "x03": JSON.stringify(state.currentEvent.data),
          "pageItems": requestPageItems
        },
        {
          "dataType": "html",
          "success": function (pADCResponse) {
            if (state.currentEvent.isClick) {
              apex.item(state.currentEvent.id).enable();
            }
            transport.executeResponse(pADCResponse);
          },
          "error": function (jqXHR, textStatus, errorThrown) {
            apex.debug.error(`${C_FILE_NAME} - ADC request failed: ${textStatus}`, errorThrown);
            if (state.currentEvent.isClick && adc.utils.isNotEmpty(state.currentEvent.id)) {
              apex.item(state.currentEvent.id).enable();
            }
            transport.scheduleLockReset();
            eventQueue.release();
          }
        }
      );
    }
  };

  /**
   * Enqueue a normalized change event for ADC processing.
   *
   * @param {Event} pEvent Browser event.
   * @param {*} pEventData Optional ADC event payload.
   * @param {boolean} pWait Whether a wait indicator should be shown.
   */
  const changeCallback = function(pEvent, pEventData, pWait) {
    getTriggeringElement(pEvent, pEventData);

    if (state.currentEvent.id){
      eventQueue.enqueue(pWait);
    }
  }; // changeCallback
      
    
  /**
   * Handle keypress-based enter events and enqueue them only for the Enter key.
   *
   * @param {Event} pEvent Browser event.
   * @param {*} pEventData Optional ADC event payload.
   * @param {boolean} pWait Whether a wait indicator should be shown.
   */
  const enterCallback = function (pEvent, pEventData, pWait){
    getTriggeringElement(pEvent, pEventData);

    if (state.currentEvent.event === C_ENTER_EVENT && state.currentEvent.id){
      // Place request in queue to process multiple events in sequence
      apex.debug.info(`${C_FILE_NAME} - Enqueueing Event '${C_ENTER_EVENT}'`);
      eventQueue.enqueue(pWait);
    }
  }; // enterCallback
      
    
  /**
   * Ask for confirmation before continuing when unsaved changes exist.
   *
   * @param {Event} pEvent Browser event.
   * @param {*} pEventData Optional ADC event payload.
   */
  const unsavedCallback = function (pEvent, pEventData) {
    getTriggeringElement(pEvent, pEventData);

    if (state.currentEvent.id) {
        if(ctl.hasUnsavedChanges()){
          // Handle event only after confirmation from the user
          adc.renderer.confirmRequest(pEvent, changeCallback, state.currentEvent.id);
        }
        else{
          // No changes on the page, continue
          changeCallback(pEvent);
        };
    }
  }; // unsavedCallback
      
    
  /**
   * Prevent save-like actions when no observed changes exist on the page.
   *
   * @param {Event} pEvent Browser event.
   * @param {*} pEventData Optional ADC event payload.
   */
  const unchangedCallback = function (pEvent, pEventData) {
    getTriggeringElement(pEvent, pEventData);

    if (state.currentEvent.id) {        
        if(! ctl.hasUnsavedChanges()){
          // Show message that no change exists on the page
          adc.renderer.informUnchanged(pEvent, state.currentEvent.id);
        }
        else{
          // Changes exist on the page, continue
          changeCallback(pEvent);
        };
    }
  }; // unchangedCallback


  /**
   * Bind one ADC-relevant event to a page item.
   *
   * @param {string} pItemId Item ID or selector.
   * @param {string} pEvent ADC or DOM event name.
   * @param {function|string} [pAction] Optional callback function or callback registry key.
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
      callback = eventRegistry.resolveCallback(pItemId, pEvent, pAction);
      if (typeof callback !== 'function') {
        return;
      }

      // ADC unbinds event handlers bound to this item to prevent problems between the different handlers
      $this
        .on(pEvent, callback);
      if (pEvent === C_CHANGE_EVENT) {
        // CHANGE event should not be called after APEXREFRESH, so pause it until apexafterrefresh
        eventRegistry.bindChangeRefreshHandlers($this, pItemId, callback);
      }
    }
  }; // bindEvent
  

  /**
   * Bind all configured ADC events for the current page.
   */
  const bindEvents = function () {
    $.each(props.bindItems, function () {
      if(this.event == C_ENTER_EVENT){
        bindEvent(this.id, C_KEYPRESS_EVENT, this.action || enterCallback);
      }
      else{
        bindEvent(this.id, this.event, this.action);
        if (this.event === C_CHANGE_EVENT) {
          eventRegistry.addPageItem(this.id);
        }
      }
    });
  }; // bindEvents


  /**
   * Add a page item to the ADC submit list.
   *
   * @param {string} pItemId Page item ID.
   */
  const addPageItem = function (pItemId) {
    eventRegistry.addPageItem(pItemId);
  }; // addPageItem
  

  /**
   * Execute the JavaScript response returned by ADC.
   *
   * @param {string} pCode JavaScript response markup.
   */
  const executeCode = function (pCode) {
    transport.executeResponse(pCode);
  }; // executeCode
  

  /**
   * Normalize a browser event into the current ADC event context.
   *
   * @param {Event} pEvent Browser event.
   * @param {*} pEventData Optional ADC event payload.
   */
  const getTriggeringElement = function (pEvent, pEventData) {
    var $element;
    var $button;

    // Copy event data to a local variable to allow for tayloring
    state.currentEvent.id = C_NO_TRIGGERING_ITEM;
    state.currentEvent.event = pEvent.type;
    state.currentEvent.data = pEventData;
    state.currentEvent.isClick = false; // reset status to known default

    if (typeof pEvent.target != 'undefined') {
      switch (state.currentEvent.event) {
        case C_APEX_AFTER_CLOSE_DIALOG:
          // CloseDialog is bound to currentTarget to allow for delegated events.
          state.currentEvent.id = pEvent.currentTarget.id;
          break;
        case C_CHANGE_EVENT:
          state.currentEvent.id = pEvent.target.id;
          if (typeof state.currentEvent.id !== 'undefined') {
            state.currentEvent.id = state.currentEvent.id.replace(/_input/, '');
          }

          $element = $(`#${state.currentEvent.id}`);
          if ($element.attr('type') === 'radio' || $element.attr('type') === 'checkbox') {
            // In case of a radio group or a checkbox, the id has to be taken from the parent fieldset
            const selectId = $element.parents('.apex-item-radio,.apex-item-checkbox').attr('id');
            if(selectId){
              // In case of a switch, the type is checkbox but the ID is already set correctly
              state.currentEvent.id = selectId;
            }
          }
          if (state.currentEvent.id && state.currentEvent.id.match(/oj.*/)){
            // item is Oracle Jet item group, traverse up
            state.currentEvent.id = $(`#${state.currentEvent.id}`).closest('div.apex-item-group').attr('id');
          }
          break;
        case C_CLICK_EVENT:
          // Flag is used to clear the event queue to prevent multiple clicks
          state.currentEvent.isClick = true;
          state.currentEvent.id = ((pEvent.target.id !== '') ? pEvent.target.id : pEvent.currentTarget.id);
          if (typeof state.currentEvent.id !== 'undefined') {
            state.currentEvent.id = state.currentEvent.id.replace(/_input/, '');
          }

          if (state.currentEvent.id === '') {
            // Some browsers send accessKey-span instead of triggering element in response to a click
            // Get the parent element in these cases
            state.currentEvent.id = pEvent.target.parentElement.id;
          }
          $button = $(`#${state.currentEvent.id}`);
          // Depending on how a click event was raised (mouse or code), a different item is addressed
          if (!$button.hasClass(C_APEX_BUTTON)) {
            $button = $(`#${state.currentEvent.id}`).parent(C_BUTTON);
          }
          break;
        case C_KEYPRESS_EVENT:
          state.currentEvent.id = pEvent.target.id;
          if (typeof state.currentEvent.id !== 'undefined') {
            state.currentEvent.id = state.currentEvent.id.replace(/_input/, '');
          }
          // If the ENTER-key was pressed, the event type is changed to 'enter' to allow for easy detection within ADC
          switch (pEvent.keyCode) {
            case 13:
              state.currentEvent.event = C_ENTER_EVENT;
              break;
            // add other key codes here if necessary
          }
          break;
        default:
          state.currentEvent.id = pEvent.target.id;
          if (typeof state.currentEvent.id !== 'undefined') {
            state.currentEvent.id = state.currentEvent.id.replace(/_input/, '');
          }
      }
      if (state.currentEvent.id){
        apex.debug.info(`${C_FILE_NAME} - Event '${state.currentEvent.event}' raised at Triggering element '${state.currentEvent.id}'`);}
      else {
        apex.debug.warn(`${C_FILE_NAME} - Could not determine triggering element ID`, pEvent.target);
      }
    }
  }; // getTriggeringElement
  

  /**
   * Check and maintain the protected-event lock before a request is sent.
   *
   * @returns {boolean} `true` if the event may be processed, otherwise `false`.
   */
  const maintainAndCheckEventLock = function (){
    return eventQueue.maintainLock();
  }; // maintainAndCheckEventLock


  /**
   * Bind a controller-managed click handler to a button.
   *
   * @param {jQuery} pTarget Target button.
   * @param {Object} pOptions Dialog options associated with the handler.
   * @param {function} pCallback Click callback.
   */
  const addButtonHandler = function (pTarget, pOptions, pCallback){
    eventRegistry.bindButtonHandler(pTarget, pOptions, pCallback);
  }; // addButtonHandler

  /* +++++ END PRIVATE  ++++++++ */

  /* ++++++++++ CORE FUNCTIONALITY ++++++++++ */  

  /**
   * Add extra submitted items to the ADC request list.
   *
   * @param {string} pSelector Comma-separated selector or item list.
   */
  ctl.bindObserverItems = function (pSelector) {
    var selectorList;
    if (pSelector) {
      selectorList = pSelector.split(',');
      $.each(selectorList, function (idx, element) {
        if (this.substring(0, 1) === '.') {
          $(element).each(function (idx, element) {
            eventRegistry.addPageItem($(element).attr('id'));
          });
        }
        else {
          if ($.inArray(element, state.pageItems) === -1) {
            state.pageItems.push(element);
          }
        }
      });
      apex.debug.info(`${C_FILE_NAME} - Additional submitted items: ${pSelector}`);
    }
  }; // bindObserverItems
  
  /**
   * Bind a confirmation dialog to a button before continuing with ADC processing.
   *
   * @param {jQuery} pTarget Target button.
   * @param {Object} pOptions Dialog options.
   * @param {string} [pIdItem] Optional item containing the affected row ID.
   */
  ctl.bindConfirmationHandler = function(pTarget, pOptions, pIdItem, pApexAction){
    const innerCallback = pApexAction ? function() { apex.actions.invoke(pApexAction); } : changeCallback;
    const targetId = pTarget.attr('id');
    const options = (typeof pOptions === 'string')
      ? { message: pOptions, title: pIdItem, noDataMessage: null }
      : $.extend({}, pOptions);
    const message = options.message;
    
    const callback = function(pEvent) {
      // persists message as a fallback solution if the event handler is called several times
      // and the status of pIdItem changes inbetween.
      if(adc.utils.isNotEmpty(pIdItem) && options.noDataMessage && adc.utils.isEmpty(apex.item(pIdItem).getValue())){
        options.message = options.noDataMessage;
        options.title = adc.utils.getStandardMessage(`CSM_DIALOG_TYPE_INFO`);
        adc.renderer.showDialog('INFO', options, targetId);
      } else {
        options.message = message;
        if (adc.utils.isEmpty(options.title)) {
          options.title = adc.utils.getStandardMessage(`CSM_DIALOG_TYPE_WARNING`);
        }
        adc.renderer.confirmRequest(pEvent, innerCallback, targetId);
      };
   };
    addButtonHandler(pTarget, options, callback);
  }; // bindConfirmationHandler

  
  /**
   * Bind an unsaved-changes confirmation handler to a button.
   *
   * @param {jQuery} pTarget Target button.
   * @param {Object} pOptions Dialog options.
   */
  ctl.bindUnsavedConfirmationHandler = function(pTarget, pOptions){
    addButtonHandler(pTarget, pOptions, unsavedCallback);
  }; // bindUnsavedConfirmationHandler

  
  /**
   * Bind a no-change guard to a button.
   *
   * @param {jQuery} pTarget Target button.
   * @param {Object} pOptions Dialog options.
   */
  ctl.bindUnchangedConfirmationHandler = function(pTarget, pOptions){
    addButtonHandler(pTarget, pOptions, unchangedCallback);
  }; // bindUnchangedConfirmationHandler


  /**
   * Remove all queued ADC events that have not yet been processed.
   */
  ctl.clearPendingEvents = function(){
    eventQueue.clear();
  }; // clearPendingEvents
  

  /**
   * Look up a cached item value by item ID.
   *
   * @param {string} pItemId Page item ID.
   * @returns {*} Cached value or `undefined`.
   */
  ctl.findItemValue = function(pItemId) {
    var result = $.grep(state.lastItemValues, function (e) {
      return e.id === pItemId;
    });

    if (result.length > 0) {
      return result[0].value;
    }
  }; // findItemValue
  

  /**
   * Helper to persist a locally unique identifier across APEX sessions
   */
  ctl.getClientId = function (){
    const CLIENT_ID= "adc.client.id";
    let clientId = localStorage.getItem(CLIENT_ID);

    if (!clientId) {
        clientId = "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c => (+c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> +c / 4).toString(16));
        localStorage.setItem(CLIENT_ID, clientId);

        console.log("client id generated:", clientId);
    } else {
        console.log("client id found:", clientId);
    }
    state.pageState.itemMap.set(CLIENT_ID, clientId);
    return clientId;
  }


  /**
   * Get the last successfully processed triggering element ID.
   *
   * @returns {string}
   */
  ctl.getLastTriggeringItem = function() {
    return state.lastTriggeringElement;
  }; // getLastTriggeringItem
  

  /**
   * Get the current ADC page-state snapshot.
   *
   * @returns {adcPageState}
   */
  ctl.getPageState = function() {
    return state.pageState;
  }; // getPageState
  

  /**
   * Replace the current ADC page-state snapshot.
   *
   * @param {adcPageState} pPageState Page-state snapshot.
   */
  ctl.setPageState = function(pPageState) {
    state.pageState = pPageState;
  }; // setPageState


  /**
   * Add a page item to ADC state and bind its change event if needed.
   *
   * @param {string} pItemId Page item ID.
   */
  ctl.pushPageItem = function(pItemId){
    if ($.inArray(pItemId, state.pageItems) === -1) {
      state.pageItems.push(pItemId);
      bindEvent(pItemId, C_CHANGE_EVENT);
    }
  }; // pushPageItem
  
  
  /**
   * Compare current item values with the remembered page state.
   *
   * @returns {boolean} `true` if at least one observed item changed.
   */
  ctl.hasUnsavedChanges = function(){
    let isDifferent = false;
   
    state.pageState.itemMap.forEach(function(itemValue, item, map){
      apex.debug.info(`${C_FILE_NAME} - Comparing ${item}`);
      if (itemValue != adc.utils.getValueAsString(item)){
        isDifferent = true;
        return true;
      };
    });
    return isDifferent;
  }; // hasUnsavedChanges


  /**
   * Temporarily suppress `change` handlers during an item refresh.
   *
   * @param {string} pItemId Item ID.
   * @param {*} pItemValue Value to restore after refresh.
   */
  ctl.pauseChangeEventDuringRefresh = function(pItemId, pItemValue){
    const $item = $(`#${pItemId}`),
          node = $item.get(0),
          C_EVENTS = 'events';
    let itemEvents, temporalEvents;

    if ($item.length > 0){
      // persist actually assigned event handlers
      itemEvents = $._data(node, C_EVENTS);
      
      // Make a deep copy of events, remove change and assign it to the item
      temporalEvents = $.extend(true, [], itemEvents);
      delete temporalEvents.change;
      $._data(node, C_EVENTS, temporalEvents);
      
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
        $._data(node, C_EVENTS, itemEvents);
      });
    };
  }; // pauseChangeEventDuringRefresh


  /**
   * Add persistent page items to the ADC submit list.
   *
   * @param {string[]} pItemList Item IDs to add.
   */
  ctl.setAdditionalItems = function(pItemList){
    state.additionalItems = Array.from(new Set(
      (state.additionalItems || []).concat(pItemList || [])
    ));
  }; // setAdditionalItems

  /**
   * Register page items that should only be submitted with the next ADC request.
   *
   * @param {string[]} pItemList Item IDs to add for one request.
   */
  ctl.setTransientPageItems = function(pItemList){
    state.transientPageItems = Array.from(new Set(
      (state.transientPageItems || []).concat(pItemList || [])
    ));
  }; // setTransientPageItems


  /**
   * Overwrite the current ADC event context for custom JavaScript-triggered events.
   *
   * @param {string} pId Triggering element ID.
   * @param {string} pEvent ADC event name.
   * @param {*} pData Optional ADC event payload.
   * @param {boolean} [pIsClick] Whether the event should be treated as click-like.
   */
  ctl.setTriggeringElement = function(pId, pEvent, pData, pIsClick){
    state.currentEvent.id = pId;
    state.currentEvent.event = pEvent;
    state.currentEvent.data = pData;
    state.currentEvent.isClick = pIsClick || false;
  } // setTriggeringElement


  /**
   * Cache item values returned from ADC for later refresh handling.
   *
   * @param {Array<{id: string, value: *}>} pPageItems Cached page items.
   */
  ctl.setLastItemValues = function(pPageItems){
    state.lastItemValues = pPageItems || [];
  };
  
  
  /**
   * Resolve a localized standard message by message ID.
   *
   * @param {string} pMessageID Message key.
   * @returns {string|undefined}
   */
  ctl.getStandardMessage = function(pMessageID){
    return state.standardMessages[pMessageID];
  };

  
  /**
   * Execute the current ADC event against the server.
   */
  ctl.execute = function(){

    if(maintainAndCheckEventLock()){
      transport.send();
    }
    else {
      executeCode();
    };
  }; // execute

  
  /**
   * Initialize the ADC plugin on page load.
   *
   * @param {pAction} pAction Initialization payload supplied by APEX.
   */
  adc.init = function (pAction) {

    // bind all page items required by ADC
    props.bindItems = $.parseJSON(pAction.attribute01.replace(/~/g, '"'));

    // register adc.renderer namespace object and Ajax identifier
    adc.renderer = adc.utils.resolveRenderer(pAction.attribute03);
    props.ajaxIdentifier = pAction.ajaxIdentifier;

    if (pAction.attribute02) {
      apex.debug.info(`${C_FILE_NAME} - Required pageItems: ${pAction.attribute02}`);
      state.pageItems = pAction.attribute02.split(',');
    }
    
    if (pAction.attribute06) {
      state.standardMessages = JSON.parse(pAction.attribute06);
    }

    ctl.bindObserverItems(pAction.attribute05);

    // Prepare page for ADC usage
    bindEvents();
    apex.debug.info(`${C_FILE_NAME} - ADC initialized`);

    // execute initial JavaScript code passed in from the server
    executeCode(adc.utils.base64ToUtf8(pAction.attribute04));
  }; // init

  /* +++++++++ END CORE FUNCTIONALITY +++++++++++ */

}(de.condes.plugin.adc, apex.jQuery));


// Interface to APEX plugin mechanism.
// For some reason I don"t really understand, it is impossible
// to tell APEX to directly use a namespace object here.
function de_condes_plugin_adc() {
  de.condes.plugin.adc.init(this.action);
}
