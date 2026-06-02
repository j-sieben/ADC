
var de = de ||{};
de.condes = de.condes ||{};
de.condes.plugin = de.condes.plugin ||{};
de.condes.plugin.adc = de.condes.plugin.adc ||{};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
 * Client-side ADC action facade.
 *
 * Responsibilities:
 * - expose the public JavaScript action API used by ADC responses
 * - delegate orchestration to `adc.controller`
 * - delegate UI-specific behavior to `adc.renderer`
 * - keep action-specific helper logic local to this file
 */
(function (adc, $){
  'use strict';

  const C_BODY = 'body';
  const C_INPUT_SELECTOR = ':input:visible:not(button)';
  const C_DOCUMENT = 'DOCUMENT';
  const C_FILE_NAME = 'adc.js.actions.js';

  // Region Type constants
  const C_REGION_CR = 'ClassicReport';
  const C_REGION_IR = 'InteractiveReport';
  const C_REGION_IG = 'InteractiveGrid';
  const C_REGION_TREE = 'Tree';
  const C_REGION_TAB = 'Tab';
  const C_REGION_DATA_ITEM = 'data-item-for-region';
  
  // Selector constants
  const C_REGION_CR_SELECTOR = '.t-Report-report tbody tr';
  const C_REGION_IR_SELECTOR = '.a-IRR-table tr:not(:first-child)';
  const C_REGION_IR_ROW_SELECTOR = '.t-fht-tbody .a-IRR-table tr:not(:first-child)';
  const C_REGION_IR_FIRST_ROW_SELECTOR = '.t-fht-tbody .a-IRR-table tr:nth-child(2)';
  const C_REGION_IR_LAST_ROW_SELECTOR = '.t-fht-tbody .a-IRR-table tr:last-child';
  
  // Command constants
  const C_COMMAND = 'COMMAND';
  const C_COMMAND_NAME = 'command';
  const C_NOTIFICATION = 'NOTIFICATION';
  const C_NOTIFICATION_EVENT = 'notification';
  
  // Visual State constants
  const C_HIDE = 'HIDE';
  const C_SHOW_DISABLE = 'SHOW_DISABLE';
  const C_SHOW_ENABLE = 'SHOW_ENABLE';
  
  // Event constants
  const C_CLICK_EVENT = 'click';
  const C_DOUBLE_CLICK_EVENT = 'dblclick';
  const C_KEYDOWN_EVENT = 'keydown';
  const C_FOCUS_EVENT = 'focusin';
  const C_SELECTION_CHANGE_EVENT = 'adcselectionchange';
  const C_IG_SELECTION_CHANGE = 'interactivegridselectionchange';
  const C_TREE_SELECTION_CHANGE = 'treeviewselectionchange';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_MODAL_DIALOG_CANCEL_EVENT = 'apexaftercanceldialog';
  const C_MODAL_DIALOG_CLOSE_EVENT = 'apexafterclosedialog';
  
  const C_TABKEY = 9;

  // Modal dialog constants
  const C_MODAL_DIALOG_CLASS = 'ui-dialog';
  const C_MODAL_DIALOG_SELECTOR = '.ui-dialog-content';
  
  // Process mode Constants
  const C_MODE_SAVE = 'A_SAVE';
  const C_MODE_DELETE = 'B_DELETE';
  const C_MODE_CANCEL = 'C_CANCEL';


  // Global vars
  adc.actions = adc.actions ||{};
  var actions = adc.actions;
  var state = adc.state;
  
  var gFocusAfterRefresh = {};

  /*++++++++ HELPER START ++++++++++++*/
  /**
   * Iterate over one or more item selectors and normalize simple item names to IDs.
   *
   * @param {string|string[]} pSelector Selector, item name or selector list.
   * @param {function} pAction Callback executed for each matched element.
   */
  const forEach = function (pSelector, pAction){
    if (!($.isArray(pSelector) || pSelector.search(/[\.#\u0020:\[\]]+/) >= 0)){
      // passed ITEM is element name, extend by #.
      pSelector = `#${pSelector}`;
    }

    if (pSelector.match(/oj.*/)){
      // item is Oracle Jet item group, traverse up
      pSelector = $(`#${pSelector}`).closest('div.apex-item-group').attr('id');
    }
    $(pSelector).each(pAction);
  }; // forEach

  /**
   * Prepopulate a confirmation dialog options object for an ADC process mode.
   *
   * @param {string} pMode Process mode constant.
   * @param {string} pMessage Optional custom message.
   * @param {Object} [pOptions] Existing options object to extend.
   * @returns {Object} Normalized dialog options.
   */
  function setConfirmationOptions(pMode, pMessage, pOptions){
    let options = pOptions || {};
    options.message = pMessage;
    switch (pMode){
      case C_MODE_SAVE:
        options.style = 'information'
        options.title = adc.utils.getStandardMessage('CSM_DIALOG_WARNING_TITLE');
        options.confirmLabel = adc.utils.getStandardMessage('CSM_DIALOG_NO_CHANGE_OK_BUTTON');
        options.message = pMessage ? pMessage : adc.utils.getStandardMessage('CSM_DIALOG_NO_CHANGE_MESSAGE');
        break;
      case C_MODE_DELETE:
        options.style = 'warning'
        options.title = adc.utils.getStandardMessage('CSM_DIALOG_CONFIRM_TITLE');
        options.cancelLabel = adc.utils.getStandardMessage('CSM_DIALOG_DELETE_CANCEL_BUTTON');
        options.confirmLabel = adc.utils.getStandardMessage('CSM_DIALOG_DELETE_OK_BUTTON');
        options.noDataMessage = adc.utils.getStandardMessage('CSM_DIALOG_NOTHING_TO_DELETE_MESSAGE');
        options.message = pMessage ? pMessage : adc.utils.getStandardMessage('CSM_DIALOG_DELETE_MESSAGE');
        break;
      case C_MODE_CANCEL:
        options.style = 'warning'
        options.title = adc.utils.getStandardMessage('CSM_DIALOG_CONFIRM_TITLE');
        options.cancelLabel = adc.utils.getStandardMessage('CSM_DIALOG_UNSAVED_CANCEL_BUTTON');
        options.confirmLabel = adc.utils.getStandardMessage('CSM_DIALOG_UNSAVED_OK_BUTTON');
        options.message = pMessage ? pMessage : adc.utils.getStandardMessage('CSM_DIALOG_UNSAVED_MESSAGE');
        break;
    };
    
    return options;
  }; // setConfirmationOptions

  /**
   * Resolve a button element by item ID.
   *
   * @param {string} pButtonId Button ID.
   * @returns {jQuery} Matching button element.
   */
  const getButton = function(pButtonId) {
    return $(`#${pButtonId}`);
  };

  /**
   * Bind a controller-managed confirmation handler to a button if it exists.
   *
   * @param {string} pButtonId Button ID.
   * @param {function} pBinder Controller binding function.
   */
  const bindButtonHandler = function (pButtonId, pBinder) {
    const $button = getButton(pButtonId);
    const binderArgs = Array.prototype.slice.call(arguments, 2);

    if ($button.length > 0){
      pBinder.apply(adc.controller, [$button].concat(binderArgs));
    }
  };

  /**
   * Create and execute an ADC event through the controller.
   *
   * @param {string} pId Triggering element ID.
   * @param {string} pEvent ADC event name.
   * @param {*} pData Optional ADC event payload.
   * @param {string} [pMode] Optional confirmation mode.
   */
  const executeAdcEvent = function(pId, pEvent, pData, pMode){
    if (pData && Array.isArray(pData.additionalPageItems) && pData.additionalPageItems.length > 0) {
      registerAdditionalPageItems(pData.additionalPageItems);
    }

    adc.controller.setTriggeringElement(pId, pEvent, pData);

    switch(pMode){
      case C_MODE_CANCEL:
        if(adc.controller.hasUnsavedChanges()){
          let pageState = adc.controller.getPageState();
          let options = setConfirmationOptions(C_MODE_CANCEL, pageState.message);
          adc.renderer.confirmRequest(options, adc.controller.execute);
        }else{
          adc.controller.execute();
        }
        break;
      default:
        adc.controller.execute();
    }
  };

  /**
   * Resolve the best available value for an item that may be refreshed.
   *
   * @param {string} pItemId Item ID.
   * @param {*} pValue Optional explicit value.
   * @returns {*} The explicit value, current item value or cached refresh value.
   */
  const getTrackedItemValue = function(pItemId, pValue){
    if (typeof pValue !== 'undefined' && pValue !== null) {
      return pValue;
    }

    return adc.utils.coalesce([
      apex.item(pItemId).getValue(),
      adc.controller.findItemValue(pItemId)
    ]);
  };

  /**
   * Refresh a single page item while preserving its value and suppressing spurious change events.
   *
   * @param {string} pItemId Item ID.
   * @param {*} pItemValue Value to restore after refresh.
   */
  const refreshPageItem = function(pItemId, pItemValue){
    adc.controller.pauseChangeEventDuringRefresh(pItemId, pItemValue);
    apex.item(pItemId).show();
    apex.item(pItemId).enable();
    apex.item(pItemId).refresh();
  };

  const getPageState = function() {
    return adc.controller.getPageState();
  };

  const storePageState = function(pPageState) {
    adc.controller.setPageState(pPageState);
  };

  const resolvePageStateItems = function(pPageItems) {
    if (Array.isArray(pPageItems) && pPageItems.length > 0){
      return pPageItems;
    }

    return $(C_INPUT_SELECTOR);
  };

  const rememberItemState = function(pPageState, pItem){
    let itemId = pItem;
    let itemValue;

    if(itemId.id){
      itemId = itemId.id;
    }

    itemValue = adc.utils.getValueAsString(itemId);
    pPageState.itemMap.set(itemId, itemValue);
    apex.debug.info(`${C_FILE_NAME} - Saving ${itemId} with value ${itemValue}`);
  };

  const updateTargetItemValue = function(pItemId, pValue){
    if (pItemId){
      apex.item(pItemId).setValue(pValue);
    }
  };

  const executeSelectionChange = function(pReportId, pValue, pSetFocus){
    if (adc.utils.isNotEmpty(pValue)){
      actions.selectEntry(pReportId, pValue, pSetFocus);
      executeAdcEvent(pReportId, C_SELECTION_CHANGE_EVENT, pValue);
    }
  };

  const configureReportSelectionTarget = function(pItemId, pReportId){
    $(`#${pItemId}`).attr(C_REGION_DATA_ITEM, pReportId);
    adc.controller.bindObserverItems(pItemId);
  };

  /**
   * Build the selection callback for a report depending on whether a target item exists.
   *
   * @param {string} pReportId Region ID.
   * @param {string} pItemId Target item ID.
   * @param {string} pReportType Region type constant.
   * @param {boolean} pSetFocus Whether the selected row should receive focus.
   * @returns {function(string): void} Selection callback.
   */
  const createSelectionHandler = function(pReportId, pItemId, pReportType, pSetFocus){
    if(pItemId){
      configureReportSelectionTarget(pItemId, pReportId);
      return function(pValue){
        if(pReportType == C_REGION_TREE){
          updateTargetItemValue(pItemId, pValue);
        }
        else{
          actions.selectEntry(pReportId, pValue, pSetFocus);
        }
      };
    }

    return function(pValue){
      executeSelectionChange(pReportId, pValue, pSetFocus);
    };
  };

  const bindClassicReportSelection = function($report, pItemId, pCallback){
    $report.on(C_CLICK_EVENT, C_REGION_CR_SELECTOR, function(){
      const pkValue = $(this).find('td [data-id]').data('id');
      pCallback(pkValue);
      updateTargetItemValue(pItemId, pkValue);
    });
  };

  const bindInteractiveGridSelection = function($report, pItemId, pColumn, pCallback){
    $report.on(C_IG_SELECTION_CHANGE, function(e, data){
      let pkValue;

      if(data.selectedRecords.length){
        if(pColumn){
          pkValue = data.selectedRecords[0][Math.max(pColumn - 1, 0)];
        }else{
          pkValue = data.model.getRecordId(data.selectedRecords[0]);
        }
        pCallback(pkValue);
        updateTargetItemValue(pItemId, pkValue);
      }
    });
  };

  /**
   * Bind IR-specific mouse, keyboard and refresh selection handling.
   *
   * @param {jQuery} $report Interactive report root.
   * @param {string} pReportId Region ID.
   * @param {string} pItemId Target item ID.
   * @param {function(string): void} pCallback Selection callback.
   * @param {boolean} pSetFocus Whether selection should focus the row.
   */
  const bindInteractiveReportSelection = function($report, pReportId, pItemId, pCallback, pSetFocus){
    $report
      .on(C_CLICK_EVENT, C_REGION_IR_SELECTOR, function(){
        apex.debug.info(`${C_FILE_NAME} - ${C_CLICK_EVENT} detected`);
        const pkValue = $(this).find('td [data-id]').data('id');
        pSetFocus = true;
        pCallback(pkValue);
      })
      .on(C_DOUBLE_CLICK_EVENT, C_REGION_IR_SELECTOR, function(){
        apex.debug.info(`${C_FILE_NAME} - ${C_DOUBLE_CLICK_EVENT} detected`);
        $(this).find('a')[0].click();
      })
      .on(C_FOCUS_EVENT, C_REGION_IR_LAST_ROW_SELECTOR, function(){
        apex.debug.log(`${C_FILE_NAME} - focuses on the last row in the IR`);
        const pkValue = $(this).find('td [data-id]').data('id');
        pSetFocus = false;
        pCallback(pkValue);
      })
      .on(C_KEYDOWN_EVENT, C_REGION_IR_ROW_SELECTOR, function(e){
          if (e.which === C_TABKEY && e.shiftKey === false){
            $(this).next().click();
            if ($(this).is(':last-child')){
              apex.debug.log(`${C_FILE_NAME} - tab key from last row leaves IR`);
            } else{
              return false;
            };
         }
          else if (e.which === C_TABKEY && e.shiftKey === true){
            $(this).prev().click();
            if ($(this).is(':nth-child(2)')){
              apex.debug.log(`${C_FILE_NAME} - tab key backwards from first row leaves IR`);
            } else{
              return false;
            };
          };
      })
      .on(C_SELECTION_CHANGE_EVENT, function(e, pkValue){
        apex.debug.log(`${C_FILE_NAME} - ${C_SELECTION_CHANGE_EVENT} detected`);
        if(adc.utils.isNotEmpty(pkValue)){
          if(apex.item(pItemId).getValue() != pkValue){
            apex.item(pItemId).setValue(pkValue);
          };
        }
        else if(pItemId){
          if (apex.item(pItemId).getValue().length > 0){
            apex.item(pItemId).setValue();
          };
        };
      })
      .on(C_APEX_AFTER_REFRESH, function(){
        apex.debug.log(`${C_FILE_NAME} - ${C_APEX_AFTER_REFRESH} detected`);
        actions.selectEntry(pReportId, apex.item(pItemId).getValue(), gFocusAfterRefresh[pReportId]);
        gFocusAfterRefresh[pReportId] = false;
      });

    gFocusAfterRefresh[pReportId] = pSetFocus;
    actions.selectEntry(pReportId, '', gFocusAfterRefresh[pReportId]);
  };

  const bindTreeSelection = function(pReportId, pCallback){
    const $tree = $(`#${pReportId}_tree`);

    $tree.on(C_TREE_SELECTION_CHANGE, function(){
      const idList = $tree.treeView('getSelectedNodes')
                   .map(function(item){return item.id;})
                   .join(':');
      pCallback(idList);
    });
  };

  /**
   * Drop queued ADC events that have not been processed yet.
   */
  const clearEventQueue = function() {
    adc.controller.clearPendingEvents();
  };

  const storeLastItemValues = function(pPageItems) {
    adc.controller.setLastItemValues(pPageItems);
  };

  const syncItemValue = function(pPageItem) {
    apex.item(pPageItem.id).setValue(pPageItem.value, null, true);
    if ((pPageItem.value || 'FOO') !== (apex.item(pPageItem.id).getValue() || 'FOO')){
      apex.debug.info(`${C_FILE_NAME} - Item '${pPageItem.id}' set to '${pPageItem.value}'`);
    }
  };

  const registerMandatoryItem = function(pItemId) {
    adc.controller.pushPageItem(pItemId);
  };

  const registerAdditionalPageItems = function(pItemList) {
    adc.controller.setAdditionalItems(pItemList);
  };

  const registerTransientPageItems = function(pItemList) {
    adc.controller.setTransientPageItems(pItemList);
  };

  /**
   * Access the mutable client-side error collection.
   *
   * @returns {Object[]} Current managed errors.
   */
  const getManagedErrors = function() {
    return state.errors;
  };

  const setManagedErrors = function(pErrors) {
    state.errors = pErrors;
  };

  const clearManagedErrors = function() {
    setManagedErrors([]);
  };

  const hasTouchedErrors = function(pErrorList) {
    let errorListWillChange = false;

    $.each(getManagedErrors(), function(index, pError){
      if(pErrorList.firingItems.indexOf(pError.pageItem) > -1){
        errorListWillChange = true;
      };
    });

    return errorListWillChange;
  };

  const removeTouchedErrors = function(pFiringItems) {
    $.each(pFiringItems, function(index, pItemId){
      setManagedErrors($.grep(getManagedErrors(), function(e){
        return e.pageItem != pItemId && e.pageItem != C_DOCUMENT;
      }));
    });
  };

  const appendManagedErrors = function(pErrors) {
    for (let i = 0; i < pErrors.length; i++){
      getManagedErrors().push(pErrors[i]);
    };
  };

  /**
   * Render the currently managed error collection via the active renderer.
   */
  const renderManagedErrors = function() {
    adc.renderer.showErrors(getManagedErrors());
  };

  /*++++++++ HELPER END ++++++++++++*/

 
  /* +++++++++ SYSTEM ACTION TYPES +++++++++++ */

  /**
   * Set the vertical alignment of supported reports to top.
   *
   * @param {string|string[]} pSelector Region selector or selector list.
   */
  actions.alignReportVerticalTop = function (pSelector){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      adc.renderer.alignReportVerticalTop(pItemId);
    });
  }; // alignReportVerticalTop
  
  
  /**
   * Bind a confirmation dialog to a button before an APEX action executes.
   *
   * @param {string} pButtonId Button ID.
   * @param {string} pMessage Confirmation message.
   * @param {string} pDialogTitle Dialog title.
   * @param {string} pApexAction APEX action name executed after confirmation.
   */
  actions.bindConfirmation = function (pButtonId, pMessage, pDialogTitle, pApexAction){
    const options = {
      message: pMessage,
      title: pDialogTitle ? pDialogTitle : adc.utils.getStandardMessage('CSM_DIALOG_CONFIRM_TITLE')
    };

    bindButtonHandler(pButtonId, adc.controller.bindConfirmationHandler, options, null, pApexAction);
  }; // bindConfirmation
  

  /**
   * Bind a mode-specific confirmation handler to a button.
   *
   * `SAVE` checks for changed items, `DELETE` always confirms and `CANCEL`
   * warns about unsaved changes.
   *
   * @param {string} pButtonId Button ID.
   * @param {string} pMode Confirmation mode.
   * @param {string} pMessage Optional custom dialog message.
   * @param {string} pIdItem Optional page item holding a processed record ID.
   */
  actions.bindConfirmationMessage = function(pButtonId, pMode, pMessage, pIdItem){
    let options = setConfirmationOptions(pMode, pMessage)

    switch (pMode){
      case C_MODE_SAVE:
        bindButtonHandler(pButtonId, adc.controller.bindUnchangedConfirmationHandler, options, pIdItem);
        break;
      case C_MODE_DELETE:
        bindButtonHandler(pButtonId, adc.controller.bindConfirmationHandler, options, pIdItem);
        break;
      case C_MODE_CANCEL:
        bindButtonHandler(pButtonId, adc.controller.bindUnsavedConfirmationHandler, options, pIdItem);
        break;
    };
  }; // bindConfirmationMessage
  

  /**
   * Bind an unsaved-changes warning dialog to a button.
   *
   * @param {string} pButtonId Button ID.
   * @param {string} pMessage Confirmation message.
   * @param {string} pDialogTitle Dialog title.
   */
  actions.bindUnsavedWarning = function (pButtonId, pMessage, pDialogTitle){
    const options = {
      message: pMessage,
      title: pDialogTitle ? pDialogTitle : adc.utils.getStandardMessage('CSM_DIALOG_CONFIRM_TITLE')
    };

    bindButtonHandler(pButtonId, adc.controller.bindUnsavedConfirmationHandler, options);
  }; // bindUnsavedWarning


  /**
   * Cancel the current modal dialog and notify its opener.
   *
   * @param {string} [pTriggeringItemId] Explicit opener item ID for nested dialogs.
   */
  actions.cancelModalDialog = function(pTriggeringItemId){
    const cancelDialog = function(pTriggeringItemId){
      if (adc.utils.isNotEmpty(pTriggeringItemId)){
        parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CANCEL_EVENT);
      }
      else{
        pTriggeringItemId = parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.attr('id');
        parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.trigger(C_MODAL_DIALOG_CANCEL_EVENT);
      };
    
      apex.debug.info(`${C_FILE_NAME} - cancelModalDialog - triggeringElement: ${pTriggeringItemId}`);
      apex.navigation.dialog.cancel(true);
    };
    cancelDialog(pTriggeringItemId);
  }; // cancelModalDialog


  /**
   * Close the current modal dialog and optionally pass page items back to its opener.
   *
   * @param {string} [pTriggeringItemId] Explicit opener item ID for nested dialogs.
   * @param {*} pPageItems Dialog close payload.
   */
  actions.closeModalDialog = function(pTriggeringItemId, pPageItems){
    const closeDialog = function(pTriggeringItemId, pPageItems){
      if (typeof pTriggeringItemId != 'undefined' && pTriggeringItemId != ''){
        parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CLOSE_EVENT);
      }
      else{
        pTriggeringItemId = parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.attr('id');
        parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.trigger(C_MODAL_DIALOG_CLOSE_EVENT);
      };

      apex.debug.info(`${C_FILE_NAME} - closeModalDialog - triggeringElement: ${pTriggeringItemId}`);
      apex.navigation.dialog.close(true, pPageItems);
    };

    closeDialog(pTriggeringItemId, pPageItems);
    
  }; // closeModalDialog


  /**
   * Confirm a command before delegating to `executeCommand`.
   *
   * @param {string} pMessage Confirmation message.
   * @param {commandData|string} pData Command payload or command name.
   * @param {string} pFocusItem Item focused after confirmation.
   * @param {string} [pMode] Optional dialog mode override.
   */
  actions.confirmCommand = function(pMessage, pData, pFocusItem, pMode){
    let options = setConfirmationOptions(pMode || C_MODE_DELETE, pMessage);
    adc.renderer.confirmRequest(options, function(){actions.executeCommand(pData)}, pFocusItem);
  }; // confirmCommand
  
  
  /**
   * Show a confirmation dialog before executing a callback.
   *
   * @param {*} pEvent Confirmation event or options object.
   * @param {function} pCallback Callback executed after confirmation.
   */
  actions.confirmRequest = function (pEvent, pCallback){
    adc.renderer.confirmRequest(pEvent, pCallback);
  };  // confirmRequest


  /**
   * Raise a command event through ADC.
   *
   * @param {commandData|string} pData Command payload or command name.
   * @param {string} [pMode] Optional confirmation mode.
   */
  actions.executeCommand = function(pData, pMode){
    var data;
    
    if(typeof pData === 'string'){
      data ={
        'command':pData, 
        'additionalPageItems':[], 
        'monitorChanges': false
      };
    }
    else{
      data = pData;
      data.additionalPageItems = data.additionalPageItems || [];
      data.monitorChanges = data.monitorChanges || false;
    }

    executeAdcEvent(C_COMMAND, C_COMMAND_NAME, data, pMode);
  }; // executeCommand

  
  /**
   * Set browser focus to the requested item.
   *
   * @param {string} pItemId Item ID.
   */
  actions.focus = function(pItemId){
    $(`#${pItemId}`).focus();
  }; // focus


  /**
   * Bind selection handling for supported report and tree regions.
   *
   * Classic and interactive reports must expose the primary key in a visible
   * column through a `data-id` attribute. Interactive grids may alternatively
   * identify the key column by ordinal position.
   *
   * If `pItemId` is omitted, ADC raises `adcselectionchange` and passes the
   * selected key in the event payload instead of writing to a page item.
   *
   * @param {string} pReportId Region ID to observe.
   * @param {string} pItemId Optional target item for the selected key.
   * @param {number} pColumn Optional IG key column position.
   * @param {boolean} pSetFocus Whether the selected row should receive focus.
   */
  actions.getReportSelection = function(pReportId, pItemId, pColumn, pSetFocus){
    const $report = $(`#${pReportId}`),
          reportType = adc.renderer.getRegionType(pReportId);
    const callback = createSelectionHandler(pReportId, pItemId, reportType, pSetFocus);

    // Examine type of report and bind click handler
    switch(reportType){
      case C_REGION_CR:
        bindClassicReportSelection($report, pItemId, callback);
        break;
      case C_REGION_IG:
        bindInteractiveGridSelection($report, pItemId, pColumn, callback);
        break;
      case C_REGION_IR:
        bindInteractiveReportSelection($report, pReportId, pItemId, callback, pSetFocus);
        break;
      case C_REGION_TREE:
        bindTreeSelection(pReportId, callback);
        break;
    }
   }; // getReportSelection

   
  /**
   * Forward a client-side notification to ADC as an event payload.
   *
   * @param {*} pMessage Notification payload.
   */
  actions.handleNotification = function(pMessage){
    executeAdcEvent(C_NOTIFICATION, C_NOTIFICATION_EVENT, pMessage);
  }

  
  /**
   * Hide report filter panels for the selected regions.
   *
   * @param {string|string[]} pSelector Region selector or region list.
   */
  actions.hideReportFilterPanel = function (pSelector){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      adc.renderer.hideReportFilterPanel(pItemId, adc.renderer.getRegionType(pItemId));
    });
  }; // hideReportFilterPanel


  /**
   * Open a websocket and forward incoming messages to ADC or a custom callback.
   *
   * @param {string} pRoom Room identifier.
   * @param {string} pURL Websocket endpoint URL.
   * @param {function} [pAction] Optional message callback.
   */
  actions.initWebsocket = function(pRoom, pURL, pAction){
    return adc.handler.initWebsocket({
      room: pRoom,
      url: pURL,
      clientId: function(){ return apex.item('pInstance').getValue(); },
      callback: typeof pAction === 'function' ? pAction : actions.handleNotification
    });
  };


  /**
   * Subscribe to a server-sent events endpoint.
   *
   * @param {string} pRoom Room identifier.
   * @param {string} pURL SSE endpoint URL.
   * @param {function} [pAction] Optional message callback.
   */
  actions.initServerSentEvents = function(pRoom, pURL, pAction){
    return adc.handler.initServerSentEvents({
      room: pRoom,
      url: pURL,
      clientId: adc.controller.getClientId,
      callback: typeof pAction === 'function' ? pAction : actions.handleNotification
    });
  };


  /**
   * Show a renderer-managed notification dialog or success message.
   *
   * @param {string} pStyle Notification style.
   * @param {string} pMessage Message text.
   * @param {string} [pTitle] Optional dialog title.
   * @param {string} [pFocusItem] Optional focus target.
   */
  actions.notify = function (pStyle, pMessage, pTitle, pFocusItem){
    let options = {};
    if (adc.utils.isNotEmpty(pTitle)){
      options.title = pTitle;
    }
    else{
      options.title = adc.utils.getStandardMessage(`CSM_DIALOG_TYPE_${pStyle}`);
    }
    
    options.message = pMessage;
    
    adc.renderer.showDialog(pStyle, options, pFocusItem);
  }; // notify


  /**
   * Clear all renderer-visible errors from the page.
   */
  actions.clearErrors = function (){
    clearManagedErrors();
    renderManagedErrors();
  }; // clearErrors


  /**
   * Show a page-level success message.
   *
   * @param {string} pMessage Success message.
   */
  actions.showSuccess = function (pMessage){
    adc.renderer.showSuccess(pMessage);
  }; // showSuccess


  /**
   * Hide success messages, error messages or both.
   *
   * @param {string} pType `success`, `error` or `both`.
   */
  actions.hideMessage = function (pType){
    switch(pType){
      case 'success':
        adc.renderer.clearNotification();
        break;
      case 'error':
        actions.clearErrors();
        break;
      case 'both':
        adc.renderer.clearNotification();
        actions.clearErrors();
        break;
    }
  }; // hideMessage

  
  /**
   * Register extra page items for the next ADC request only.
   *
   * @param {string[]} pItemList Page item IDs.
   */
  actions.registerPageItemsOnce = function(pItemList){
    registerTransientPageItems(pItemList);
  }; // registerPageItemsOnce

  
  /**
   * Snapshot current page item values for unsaved-change detection.
   *
   * @param {string[]} [pPageItems] Optional item list to capture.
   * @param {string} [pMessage] Optional unsaved-changes message.
   * @param {string} [pTitle] Optional dialog title.
   */
  actions.rememberPageItemStatus = function(pPageItems, pMessage, pTitle){
    var pageState;
    var itemList;

    pageState = getPageState();
    pageState.itemMap.clear();
    pageState.message = pMessage;
    pageState.title = pTitle;
    itemList = resolvePageStateItems(pPageItems);

    $.each(itemList, function(index, item){
      rememberItemState(pageState, item);
    });

    storePageState(pageState);
  }; // rememberPageItemStatus


  /**
   * Refresh a region or page item and preserve its logical value.
   *
   * @param {string} pItemId Region or item ID.
   * @param {*} [pValue] Optional value to restore after refresh.
   * @param {boolean} [pSetFocus] Whether focus should be restored.
   * @param {boolean} [pPreventChange] Whether item value updates should suppress change events.
   */
  actions.refresh = function (pItemId, pValue, pSetFocus, pPreventChange){
    const itemValue = getTrackedItemValue(pItemId, pValue);
    if($(`div#${pItemId}.js-apex-region`).length > 0){
      const $region = $(`#${pItemId}`);
      let regionItem = $(`[${C_REGION_DATA_ITEM}="${pItemId}"]`);

      if (regionItem.length > 0) {
        apex.item(regionItem.attr(`id`)).setValue(itemValue, null, pPreventChange);
      }
      
      if (pSetFocus){
        gFocusAfterRefresh[pItemId] = true;
      };

      apex.region(pItemId).refresh();
    }
    else{
      refreshPageItem(pItemId, itemValue);
    };
  }; // refresh 


  /**
   * Refresh one or more regions automatically in a fixed interval.
   *
   * Repeated registration for the same region replaces the previous timer.
   *
   * @param {string|string[]} pSelector Region selector or region list.
   * @param {number|string} pIntervalSeconds Refresh interval in seconds.
   */
  actions.refreshAutomatically = function(pSelector, pIntervalSeconds){
    const intervalMs = Number(pIntervalSeconds) * 1000;

    if (!Number.isFinite(intervalMs) || intervalMs <= 0){
      apex.debug.error(`${C_FILE_NAME} - Invalid auto-refresh interval '${pIntervalSeconds}'`);
      return;
    }

    forEach(pSelector, function(){
      const regionId = $(this).attr('id');

      if (adc.utils.isEmpty(regionId)){
        return;
      }

      if (state.autoRefreshIntervals[regionId]){
        window.clearInterval(state.autoRefreshIntervals[regionId]);
      }

      state.autoRefreshIntervals[regionId] = window.setInterval(function(){
        apex.region(regionId).refresh();
      }, intervalMs);
    });
  }; // refreshAutomatically


  /**
   * Refresh a page item and restore its value afterwards.
   *
   * @param {string} pItemId Item ID.
   * @param {*} [pValue] Optional value override.
   */
  actions.refreshAndSetValue = function (pItemId, pValue){
    var itemValue = getTrackedItemValue(pItemId, pValue);
    refreshPageItem(pItemId, itemValue);
  }; // refreshAndSetValue


  /**
   * Select an entry in a supported report or tree region.
   *
   * @param {string} pRegionId Region ID.
   * @param {string} pEntryId Entry ID.
   * @param {boolean} pSetFocus Whether focus should move to the selected entry.
   */
  actions.selectEntry = function(pRegionId, pEntryId, pSetFocus){
    let $region;
    let $entry;
    const C_CR_SELECTOR = `#report_table_${pRegionId}`;
    const C_IR_SELECTOR = `#${pRegionId}_ir`;
    const C_IG_SELECTOR = `#${pRegionId}_ig`;
    const C_TREE_SELECTOR = `#${pRegionId}_tree`;
    const C_IR_FIRST_ROW_SELECTOR = ' .a-IRR-table tbody tr:nth-child(2)';
    const C_CR_FIRST_ROW_SELECTOR = ' > tbody > tr:nth-child(1)';
    const C_DATA_ID_SELECTOR = ` span[data-id='${pEntryId}']`;

    switch(adc.renderer.getRegionType(pRegionId)){
      case C_REGION_CR:
        if(adc.utils.isEmpty(pEntryId)){
          $entry = $(C_CR_SELECTOR + C_CR_FIRST_ROW_SELECTOR);
        }
        else{
          $entry = $(C_CR_SELECTOR + C_DATA_ID_SELECTOR).parent('td').parent('tr');
        };
        adc.renderer.highlightRow(pRegionId, $entry, pSetFocus);
        break;
      case C_REGION_IG:
        $region = $(C_IG_SELECTOR);
        if(adc.utils.isEmpty(pEntryId)){
          pEntryId = $region.find('tbody tr').data('id');
        }else{
          $entry = $region
                  .interactiveGrid('getViews', 'grid')
                  .model
                  .getRecord(pEntryId);
          if($entry){
            $region.interactiveGrid('setSelectedRecords', $entry, pSetFocus, true);
          };
        }
        break;
      case C_REGION_IR:
        if(adc.utils.isNotEmpty(pEntryId)){
          $entry = $(C_IR_SELECTOR + C_DATA_ID_SELECTOR).parent('td').parent('tr');
        };

        if(adc.utils.isEmpty(pEntryId) || $entry.length == 0){
          $entry = $(C_IR_SELECTOR + C_IR_FIRST_ROW_SELECTOR);
          if ($entry.length > 0){
            pEntryId = $entry.find('[data-id]').data('id');
          };
        };
        adc.renderer.highlightRow(pRegionId, $entry, pSetFocus);
        if ($entry.length != 0){
          $entry.trigger(C_SELECTION_CHANGE_EVENT, pEntryId);
        }
        else {
          $(`#${pRegionId}`).trigger(C_SELECTION_CHANGE_EVENT, null);
        };
        break;
      case C_REGION_TREE:
        $region = $(C_TREE_SELECTOR);
        
        let idList;
        let selectedNodes = $region.treeView('getSelectedNodes');
          idList = selectedNodes
                   .map(function(item){return item.id;})
                   .join(':');
        
        if (pEntryId != idList){
          $entry = $region.treeView(
                     'find',
                    {'depth': -1,
                      'match': function(n){
                                 return n.id === pEntryId;
                               }
                     }
                   );
          $region.treeView('collapseAll');
          $region.treeView('expand', $entry);
          $region.treeView('setSelection', $entry, pSetFocus, true);
        };
        break;
    }
  }; // selectEntry


  /**
   * Make an APEX action shortcut visible on associated controls.
   *
   * @param {string} pAction APEX action name.
   * @param {string} pShortcut Shortcut to assign.
   */
  actions.setApexActionAccessKey = function (pAction, pShortcut){
    let shortcuts = apex.actions.listShortcuts();

    shortcuts = shortcuts.filter(function(shortcut){
        return shortcut.actionName.indexOf(pAction) > -1;
    });
    $(shortcuts).each(function(idx, shortcut){
        apex.actions.removeShortcut(shortcut.shortcut, pAction);
    });
    const $buttons = $(`[data-action='${pAction}']`);
    if ($buttons.length > 0){
        $buttons.each(function(){
            apex.actions.addShortcut(pShortcut, pAction);
            apex.actions.update(pAction);
            adc.renderer.decorateApexAction(apex.actions.lookup(pAction));
        });
    }
  }; // setApexActionAccessKey


  /**
   * Set the visible and enabled state of one or more items.
   *
   * @param {string|string[]} pSelector Item selector or selector list.
   * @param {string} pVisibleState Display state constant.
   * @param {string} [pLabel] Optional replacement label.
   */
  actions.setDisplayState = function (pSelector, pVisibleState, pLabel){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      
      switch(pVisibleState){
        case C_HIDE:
          adc.renderer.disableElement(pItemId);                                     
          apex.item(pItemId).hide();
          break;
        case C_SHOW_DISABLE:
          apex.item(pItemId).show();
          adc.renderer.disableElement(pItemId);
          //setTimeout(function(){adc.renderer.disableElement(pItemId);}, 500);
          
          // Beside disabling the item, all events from the queue must be removed
          // to assure that a disabled button can not raise a click event
          clearEventQueue();
          break;
        case C_SHOW_ENABLE:
          apex.item(pItemId).show();
          adc.renderer.enableElement(pItemId);
          break;
        default:
          apex.debug.info(`${C_FILE_NAME} - Visual State ${pVisibleState} not supported`);
      }

      if(pLabel){
        adc.renderer.setItemLabel(pItemId, pLabel);
      }
    });
  }; // setDisplayState


  /**
   * Merge ADC validation errors into the managed client-side error collection.
   *
   * @param {?Object} pErrorList Error payload returned by ADC.
   */
  actions.setErrors = function (pErrorList){
    let errorListWillChange = false;
    
    if (pErrorList){
      if (pErrorList.count > 0){
        // If errors have occured, no further events must be processed.
        clearEventQueue();
        errorListWillChange = true;
      }
      else{
        errorListWillChange = hasTouchedErrors(pErrorList);
      };
      
      if(errorListWillChange){
        removeTouchedErrors(pErrorList.firingItems);
        appendManagedErrors(pErrorList.errors);
      };
    }
    else{
      // No error object passed in, remove all errors
      clearManagedErrors();
      errorListWillChange = true;
    }
    
    if (errorListWillChange){
      renderManagedErrors();
    };
  }; // setErrors
  
  
  /**
   * Set focus to a page item or selected report row.
   *
   * @param {string} pItemId Target item ID.
   */
  actions.setFocus = function(pItemId){
    if (adc.utils.isNotEmpty(pItemId)){    
      const selector = `#${pItemId}`;
      if($(`div${selector}.js-apex-region`).length > 0){
        $(`${selector}_ir .adc-selected-row a`).focus();
      }
      // wait for the register content to load
      else if ($(`.t-TabsRegion ${selector}`).length > 0){
        setTimeout(function(){
            $(selector).focus();
        }, 300);
      }
      else{
        $(selector).focus();
      }
    }
  }; // setFocus


  /**
   * Set the same value on one or more page items without raising ADC loops.
   *
   * @param {string|string[]} pSelector Item selector or selector list.
   * @param {*} pValue Item value.
   */
  actions.setItemValue = function (pSelector, pValue){
    forEach(pSelector, function (){
      const pItemId = $(this).attr('id');
      if (adc.utils.isNotEmpty(pItemId)){
        apex.item(pItemId).setValue(pValue, pValue, true);
      };
    });
  }; // setItemValue


  /**
   * Harmonize item values returned by ADC with the page state.
   *
   * @param {Array<{id: string, value: *}>} pPageItems Page item/value pairs.
   */
  actions.setItemValues = function (pPageItems){
    // Store the object for later reference by asynchronous calls
    storeLastItemValues(pPageItems);

    // harmonize the session state with the page items
    $.each(pPageItems, function (){
      syncItemValue(this);
    });
  }; // setItemValues


  /**
   * Toggle mandatory state and visibility for one or more items.
   *
   * @param {string|string[]} pSelector Item selector or selector list.
   * @param {boolean} pIsMandatory Whether items are mandatory.
   * @param {string} [pVisualState] Optional fallback display state.
   */
  actions.setMandatory = function (pSelector, pIsMandatory, pVisualState){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id').replace('_CONTAINER', '');
      if (adc.utils.isNotEmpty(pItemId)){
        if (pIsMandatory){
            registerMandatoryItem(pItemId);
            actions.setDisplayState(pSelector, C_SHOW_ENABLE);
        } 
        else{
            actions.setDisplayState(pSelector, pVisualState);
        }
        adc.renderer.setItemMandatory(pItemId, pIsMandatory);
      }
    });
  }; // setMandatory

  
  /**
   * Set the title of the current modal dialog.
   *
   * @param {string} pTitle Dialog title.
   */
  actions.setModalDialogTitle = function(pTitle){
    adc.renderer.setModalDialogTitle(pTitle);
  }; // setModalDialogTitle
  
  
  /**
   * Replace the content of a static region.
   *
   * @param {string} pRegionId Region ID.
   * @param {string} pContent HTML content.
   * @param {string} pHeader Region header.
   * @param {string} pCSS Accent class.
   */
  actions.setRegionContent = function(pRegionId, pContent, pHeader, pCSS){
    adc.renderer.setRegionContent(pRegionId, pContent, pHeader, pCSS);
  }; // setRegionContent
  
  
  /**
   * Set the header text of a region.
   *
   * @param {string} pRegionId Region ID.
   * @param {string} pHeader Header text.
   */
  actions.setRegionHeader = function(pRegionId, pHeader){
    adc.renderer.setRegionHeader(pRegionId, pHeader, adc.renderer.getRegionType(pRegionId));
  }; // setRegionHeader


  /**
   * Dierctly sets a session state value
   * @param {*} pItemName Name of the item to set 
   * @param {*} pValue Value to set the item to
   */
  actions.setSessionState = function(pItemName, pValue) {
    adc.controller.setSessionState(pItemName, pValue);
  };

  /**
   * Select and activate a tab in a tabs region.
   *
   * @param {string} pTabRegionId Tab region ID.
   * @param {string} pTabId Tab ID.
   */
  actions.selectTab = function(pTabRegionId, pTabId){
    apex.region(pTabRegionId).widget().aTabs('getTabs')[`#${pTabId}`].makeActive();
  }; // selectTab


  /**
   * Show or hide the wait spinner for long-running operations.
   *
   * @param {boolean} pFlag Whether the spinner should be visible.
   */
  actions.showWaitSpinner = function(pFlag){
    adc.renderer.showWaitSpinner(pFlag);
  }; // showWaitSpinner


  /**
   * Submit the page through the renderer if no blocking errors remain.
   *
   * @param {string} pRequest Submit request value.
   * @param {string} pMessage Message shown when submission is blocked.
   */
  actions.submit = function (pRequest, pMessage){
    adc.renderer.submitPage(pRequest, pMessage);
  }; // submit

  /* +++++++++ END SYSTEM ACTION TYPES +++++++++++ */

}(de.condes.plugin.adc, apex.jQuery));
