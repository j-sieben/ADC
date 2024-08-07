
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc
 * @since 5.1
 * @description
   <p>This file implements the client-side component of APEX Dynamic adc.controller.<br>
    Its task is to
      <ul>
        <li>create the necessary event handlers when the page is rendered>li>
        <li>collect the relevant data from the page when an event occurs and send it to the server>li>
        <li>implement the returned response with instructions to modify the application page.>li>
      >ul>
    >p>
    <p>The adc.controller works on the server side with a decision tree that computes a list of action instructions for a given situation.<br>
    During the calculation, the state of the application page can be changed by actions, which leads to a recursive check of the changed 
    page state against the decision tree. The response includes all change instructions for the application page, 
    including the recursive change instructions.>p>
    <p>The ADC response is delivered in the form of a script with an ID and inserted on the page by this component. 
    Thus, all included actions are executed directly. Afterwards, the plugin removes the server's response, as it is no longer needed.>p>
    <p>Change instructions to application page partly depend on APEX version used and especially on theme used. 
    The plugin starts from Theme 42, however, all theme-specific implementations of the activities are swapped out into a separate file, 
    which is linked as a namespace object when parameterizing the plugin as a component parameter. 
    As per default, this is <de.condes.plugin.adc.apex_42_20_2>, implementent in file <renderer.js>, but it can be easily replaced by a client specific implementation.>p>
    <p>To work, this plugin must only be called during page load, no administration or parameterization is required.>p>
   */
(function (adc, $){
  'use strict';

  /**
    Group: Constants
   */
  const C_BODY = 'body';
  const C_INPUT_SELECTOR = ':input:visible:not(button)';
  const C_DOCUMENT = 'DOCUMENT';
  const C_DATEI_NAME = 'de.condes.plugin.adc.actions.js';

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
  const C_REGION_IR_ROW_SELECTOR = '.t-fht-tbody .a-IRR-table tr';
  const C_REGION_IR_FIRST_ROW_SELECTOR = `${C_REGION_IR_ROW_SELECTOR}:nth-child(2)`;
  const C_ACTION_LINK_SELECTOR = 'a[data-action]';
  
  // Command constants
  const C_COMMAND = 'COMMAND';
  const C_COMMAND_NAME = 'command';
  
  // Visual State constants
  const C_HIDE = 'HIDE';
  const C_SHOW_DISABLE = 'SHOW_DISABLE';
  const C_SHOW_ENABLE = 'SHOW_ENABLE';
  
  // Event constants
  const C_CLICK_EVENT = 'click';
  const C_DOUBLE_CLICK_EVENT = 'dblclick';
  const C_KEYDOWN_EVENT = 'keydown';
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

  // Global vars
  adc.actions = adc.actions || {};
  var actions = adc.actions;
  var gErrors = []; // Interim solution required until <code>apex.message</code> supports removing a single error
  var gWarnings = []; // Interim solution required until <code>apex.message</code> supports more error styles

  /*++++++++ HELPER START ++++++++++++*/
  /**
    Function: forEach
      Helper to identify page items to apply <pAction> to
      
    Parameters: 
      pSelector - jQuery selector to identify page items
      pAction - Action to execute on the found page items
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
    Function: getRegionType
      Method to determine the type a region has
      
    Parameter:
      pRegionId - Id to identify the region.
      
    Returns:
      One of the constants <C_REGION_IG>,  <C_REGION_IR>, <C_REGION_CR>, <C_REGION_TREE>, <C_REGION_TAB>
   */
  const getRegionType = function (pRegionId){
    const $report = $(`#${pRegionId}`);
    const C_CR_SELECTOR = `#report_table_${pRegionId}`;
    const C_IR_SELECTOR = `#${pRegionId}_ir`;
    const C_IG_SELECTOR = `#${pRegionId}_ig`;
    const C_TREE_SELECTOR = `#${pRegionId}_tree`;
    const C_TAB_SELECTOR = `#SR_${pRegionId}`;
    var reportType;

    if($report.find(C_IG_SELECTOR).length > 0){
      reportType = C_REGION_IG;
    }
    else if($report.find(C_IR_SELECTOR).length > 0){
      reportType = C_REGION_IR;
    }
    else if($report.find(C_CR_SELECTOR).length > 0){
      reportType = C_REGION_CR;
    }
    else if($report.find(C_TREE_SELECTOR).length > 0){
      reportType = C_REGION_TREE;
    }
    else if($report.parent(C_TAB_SELECTOR).length > 0){
      reportType = C_REGION_TAB;
    }

    return reportType;
  }; // getRegionType

  /*++++++++ HELPER END ++++++++++++*/

 
  /* +++++++++ SYSTEM ACTION TYPES +++++++++++ */

  /**
    Function: alignReportVerticalTop
      Sets vertical alignment of IR and IG to top. Delegates aligning to <adc.renderer>.
    
    Parameter:
      pSelector - jQuery selector of the regions to adjust vertical alignment
   */
  actions.alignReportVerticalTop = function (pSelector){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      adc.renderer.alignReportVerticalTop(pItemId);
    });
  }; // alignReportVerticalTop


  /**
    Function: bindConfirmation
      Bind a confirmation dialog to a button to show a confirmation dialog before an event is raised

    Parameters:
      pButtonId - ID of the button to bind the event to
      pMessage - Confirmation message
      pDialogTitle - Title of the confirmation dialog box
      pApexAction - Name of the apex action to execute if the dialog is confirmed
   * @memberof de.condes.plugin.adc
   * @public
   */
  actions.bindConfirmation = function (pButtonId, pMessage, pDialogTitle, pApexAction){
    var $button = $(`#${pButtonId}`);
    const dialogTitle = pDialogTitle ? pDialogTitle : adc.controller.getStandardMessage('CSM_DIALOG_CONFIRM_TITLE');
    
    if ($button.length > 0){
        adc.controller.bindConfirmationHandler($button, pMessage, dialogTitle, pApexAction);
    }
  }; // bindConfirmation


  /**
    Function: bindUnsavedWarning
      Bind a confirmation dialog to a button to show a confirmation dialog before an event is raised

    Parameters:
      pButtonId - ID of the button to bind the event to
      pMessage - Confirmation message
      pDialogTitle - Title of the confirmation dialog box
   */
  actions.bindUnsavedWarning = function (pButtonId, pMessage, pDialogTitle){
    var $button = $(`#${pButtonId}`);

    if ($button.length > 0){
      adc.controller.bindUnsavedConfirmationHandler($button, pMessage, pDialogTitle);
    }
  }; // bindUnsavedWarning


  /**
    Function: cancelModalDialog
      Method to trigger the aftercanceldialog event when exiting a modal dialog.

    Parameter:  
      pTriggeringItemId - Optional triggering element is set when multiple modal windows are used overlappingly
   */
  actions.cancelModalDialog = function(pTriggeringItemId, pCheckChanges){
    const cancelDialog = function(pTriggeringItemId){
      if (typeof pTriggeringItemId != 'undefined' && pTriggeringItemId != ''){
        parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CANCEL_EVENT);
      }
      else{
        if (pTriggeringItemId == ''){
          pTriggeringItemId = parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.attr('id');
          parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.trigger(C_MODAL_DIALOG_CANCEL_EVENT);
        }
        else{
          pTriggeringItemId = parent.triggeringElement.id;
          parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CANCEL_EVENT);
        };
      };
    
      apex.debug.info('cancelModalDialog - triggeringElement:' + pTriggeringItemId);
      apex.navigation.dialog.cancel(true);
    };
    
    if (pCheckChanges && adc.controller.hasUnsavedChanges()){
        apex.message.confirm(
          adc.controller.getStandardMessage('CSM_CANCEL_HAS_CHANGES'),
          function(okPressed){
            if(okPressed){
                cancelDialog(pTriggeringItemId);
            }
          });
    }
    else{
      cancelDialog(pTriggeringItemId);
    };
  }; // cancelModalDialog


  /**
    Function: closeModalDialog
      Method to trigger the aftercanceldialog event when exiting a modal dialog.

    Parameter:  
      pTriggeringItemId - Optional triggering element is set when multiple modal windows are used overlappingly
   */
  actions.closeModalDialog = function(pTriggeringItemId, pPageItems, pCheckChanges){
    const closeDialog = function(pTriggeringItemId, pPageItems){
      if (typeof pTriggeringItemId != 'undefined' && pTriggeringItemId != ''){
        parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CLOSE_EVENT);
      }
      else{
        if (typeof pTriggeringItemId == 'undefined' || pTriggeringItemId == ''){
          pTriggeringItemId = parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.attr('id');
          parent.$(C_MODAL_DIALOG_SELECTOR).data(C_MODAL_DIALOG_CLASS).opener.trigger(C_MODAL_DIALOG_CLOSE_EVENT);
        }
        else{
          pTriggeringItemId = parent.triggeringElement.id;
          parent.$('#' + pTriggeringItemId).trigger(C_MODAL_DIALOG_CLOSE_EVENT);
        };
      };
    
      apex.debug.info('closeModalDialog - triggeringElement:' + pTriggeringItemId);
      apex.navigation.dialog.close(true, pPageItems);
    };
      
    if (pCheckChanges && !adc.controller.hasUnsavedChanges()){
        apex.message.alert(
          adc.controller.getStandardMessage('CSM_CLOSE_WO_CHANGES'),
          function(pTriggeringItemId, pPageItems){
            closeDialog(pTriggeringItemId, pPageItems)
          });
    }
    else{
      closeDialog(pTriggeringItemId, pPageItems);
    };
    
  }; // closeModalDialog


  /**
    Function: confirmCommand
      Method to confirm that a command has to be executed.

      Wrapper around actions.executeCommand that extends this functionality with a
      confirmation dialog.

    Parameters:
      pMessage - Message text for the confirmation dialog
      pData - Instance of type <commandData>, Name of the command to execute or a JSON
              instance containing the command name and additional information.
      
   */
  actions.confirmCommand = function(pMessage, pData){
    adc.renderer.confirmRequest(pMessage, function(){actions.executeCommand(pData)});
  }; // confirmCommand

  
  /**
    Function: confirmRequest
      Method show a confirmation dialog before passing an action to ADC.
      
    Parameters:
      pEvent - Event object that was raised.
      pCallback - Callback method to execute in case of confirmation
   */
  actions.confirmRequest = function (pEvent, pCallback){
    adc.renderer.confirmRequest(pEvent, pCallback);
  };  // confirmRequest


  /**
    Function: executeCommand
      Wrapper around <controller.execute> that raises a command event along with the necessary data.
      
      This method is used as the standard action for a command object to make sure that ADC is informed that
      an ADC maintained APEX action was invoked.
      
    Parameters:
      pData - Instance of type <commandData>, Name of the command to execute or a JSON
              instance containing the command name and additional information.
   */
  actions.executeCommand = function(pData){
    var data;
    var event = {};
    
    if(typeof pData === 'string'){
      data = {
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
    
    adc.controller.setTriggeringElement(C_COMMAND, C_COMMAND_NAME, data);
    
    if(pData.monitorChanges && adc.controller.hasUnsavedChanges()){
      // Unsaved changes among the observed page items, check with user
      var pageState = adc.controller.getPageState();
      event.data = pData;
      event.data.message = pageState.message;
      event.data.title = pageState.title;
      adc.renderer.confirmRequest(event, adc.controller.execute);      
    }else{
      adc.controller.execute();
    }
  }; // executeCommand

  
  /**
    Function: focus
      Method to explicitly set the focus to the requested item
    
    Parameter:
      pItemId - ID of the item to set thte focus to
   */
  actions.focus = function(pItemId){
    $(`#${pItemId}`).focus();
  }; // focus


  /**
    Function: getReportSelection
      Recognizes selection changes on Interactive reports, interactive grids or classic reports.
      To gather access to the primary key value, it is necessary to obey the following conventions:
      
      - In interactive and classic reports, a visible column must contain a html expression with a <data-id> attribute
        containing the PK value: <&lt;span data-id='#PK_COLUMN#'&gt;#VISIBLE_COLUMN#&lt;/span&gt;>>li>
      - In interactive grid, it is possible to either identify a single column of the report as the primary key column
        (ADC does not support multiple key columns yet) or by passing an ordinal number (1 based) pointing to the column
        containing the primary key. The order is defined by the order of the SQL query or the column order respectively.
       
      If no page item to store the primary key value is provided, this method raises event <adcselectionchange> which 
      can be detected in ADC by querying the pseudo column <SELECTION_CHANGED>. 
      The column contains the report ID on which the event was fired. The primary key value
      is provided via the event data property and can be read from PL/SQL by using <adc.get_event_data> or in JavaScript 
      with the replacement Anchor <#EVENT_DATA#> (within ADC only).
      
      Interactive reports are extended by support for tab keys and row highlighting. Also, tab key navigation is extended 
      to continue working when leaving the last or entering the first row.
      
      If a report is observed by ADC, it also looks for link entries which point to apex actions using a href entry like
      href="#action$name-of-action?param=value&param2=value"
      If it finds it, it informs ADC that the command was invoked and passes the parameters as event data
      
    Parameters:
      pReportId - ID of the report to observe
      pItemId - ID of the page item to save the selection to. If set, the value of the page item will be changed
                to the ID of the selected row. If not set, the method will raise event <adcselectionchange> with the ID as data.
      pColumn - Optional ordinary number of the column containing the PK information 
                (IG only and necessary only if no single primary key column is administered)
      pSetFocus - Flag to indicate whether selecting a row upon initializitaion or refresh also sets the focus to the selected row.
   */
  actions.getReportSelection = function(pReportId, pItemId, pColumn, pSetFocus){
    const $report = $(`#${pReportId}`);
    const reportType = getRegionType(pReportId);
    let callback;
    let pkValue;
    
    if(pItemId){
      callback = function(pValue){
        apex.item(pItemId).setValue(pValue);
      };
      // connect target item to report to enable later reference of the selected node.
      // also, this items needs to be observered to harmonize its value with the page state.
      $(`#${pItemId}`).attr(C_REGION_DATA_ITEM, pReportId);
      adc.controller.bindObserverItems(pItemId);
    }
    else{
      // No item present, submit ID with event C_SELECTION_CHANGE_EVENT
      callback = function(pValue){
        if (pValue){
          adc.controller.setTriggeringElement(pReportId, C_SELECTION_CHANGE_EVENT, pValue);
          adc.controller.execute();
        }
      };
    };

    // Examine type of report and bind click handler
    switch(reportType){
      case C_REGION_CR:
        $report.on(C_CLICK_EVENT, C_REGION_CR_SELECTOR, function(){
          pkValue = $(this).find('td [data-id]').data('id');
          adc.renderer.highlightRow($(this), pSetFocus);
          callback(pkValue);
        });
        break;
      case C_REGION_IG:
        $report.on(C_IG_SELECTION_CHANGE, function(e, data){
          if(data.selectedRecords.length){
            // Try to get the primary key information from the identity column.
            // If none exists, get it from the column index passed in
            if(pColumn){
              pkValue = data.selectedRecords[0][Math.max(pColumn - 1, 0)];
            }else{
              pkValue = data.model.getRecordId(data.selectedRecords[0]);
            }
            callback(pkValue);
          };
        });
        break;
      case C_REGION_IR:
        $report
          .on(C_CLICK_EVENT, C_REGION_IR_SELECTOR, function(){
            pkValue = $(this).find('td [data-id]').data('id');
            actions.selectEntry(pReportId, pkValue, true, false);
            callback(pkValue);
          })
          .on(C_DOUBLE_CLICK_EVENT, C_REGION_IR_SELECTOR, function(e){
            $(this).find('a')[0].click();
          })
          .on(C_KEYDOWN_EVENT, C_REGION_IR_ROW_SELECTOR, function(e){
              // tab forward
              if (e.which === C_TABKEY && e.shiftKey === false){
                $(this).next().click();
                if ($(this).is(':last-child')){
                  apex.debug.info(`${C_DATEI_NAME} - tab key from last row leaves IR`);
                } else{
                  return false;
                };
             }
              else if (e.which === C_TABKEY && e.shiftKey === true){
                // tab backwards
                $(this).prev().click();
                if ($(this).is(':nth-child(2)')){
                  apex.debug.info(`${C_DATEI_NAME} - tab key backwards from first row leaves IR`);
                } else{
                  return false;
                };
              };
          })
          .on(C_KEYDOWN_EVENT, '.t-fht-thead .a-IRR-table th.a-IRR-header a:last', function(e){
              apex.debug.info(`${C_DATEI_NAME} - tab key from last header row enters IR`);
              if (e.which === C_TABKEY && e.shiftKey === false){
                $(C_REGION_IR_FIRST_ROW_SELECTOR).click();
                return false;
              };
          })
          .on(C_APEX_AFTER_REFRESH, function(e){
            apex.debug.log(`${C_DATEI_NAME} - apexafterrefresh detected`);
            if(pItemId){
              apex.item(pItemId).setValue();
            };
            actions.selectEntry(pReportId, '', pSetFocus, false);
          });
        break;
      case C_REGION_TREE:
        let $tree = $(`#${pReportId}_tree`);
        $tree.on(C_TREE_SELECTION_CHANGE, function(){
          let selectedNodes;
          let idList;
          selectedNodes = $tree.treeView('getSelectedNodes');
          idList = selectedNodes
                   .map(function(item){return item.id;})
                   .join(':');
          callback(idList);
        });
        break;
    }
    
    actions.selectEntry(pReportId, '', pSetFocus, true);
  }; // getReportSelection

  
  /**
    Function: hideReportFilterPanel
      Hides filter panels from IR and IG. Delegates hiding the filter panel to <adc.renderer>.
      
    Parameters:
      pSelector jQuery selector of the regions that contain a filter panel to hide.
   */
  actions.hideReportFilterPanel = function (pSelector){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      adc.renderer.hideReportFilterPanel(pItemId, getRegionType(pItemId));
    });
  }; // hideReportFilterPanel


  /**
    Function: notify
      Method to show a notification. Delegates implementation to <adc.renderer>.
      A notification is a message that is shown to the user in a small dialog.

    Parameter:
      pStyle - One of the predefined styles INFO|WARNING|SUCCESS
      pMessage - Message that is shown to the user. Replaces any existing messages.
      pTitle - Optional title of the dialog
      pFocusItem - Item that gets focus after closing the dialog
   */
  actions.notify = function (pStyle, pMessage, pTitle, pFocusItem){
    let title;
    if (pTitle){
      title = pTitle;
    }
    else{
      // Only INFO or WARNING messages are shown in a dialog, adjust title settings.
      switch(pStyle){
        case 'INFO':
          title = adc.controller.getStandardMessage('CSM_DIALOG_INFO_TITLE');
          break;
        case 'WARNING':
          title = adc.controller.getStandardMessage('CSM_DIALOG_WARNING_TITLE');
          break;
      }
    }
    
    adc.renderer.showDialog(pStyle, pMessage, title, pFocusItem);
  }; // notify


  /**
    Function: clearErrors
      Method to remove all errors shown on the page. Is used in case of cancel activities
      to remove to a clean state on the page without showing any errors over and over again.

   */
  actions.clearErrors = function (){
    adc.renderer.showErrors([]);
  }; // clearErrors


  /**
    Function: showSuccess
      Method to shows a page success message

    Parameter:
      pMessage - Message that is shown to the user.
   */
  actions.showSuccess = function (pMessage){
    adc.renderer.showSuccess(pMessage);
  }; // showSuccess


  /**
    Function: hideMessage
      Generic action to hide success or error messages

    Parameter:
      pType - One of the constants success|error|both to decide what to hide
   */
  actions.hideMessage = function (pType){
    switch(pType){
      case 'success':
        adc.renderer.clearNotification();
        break;
      case 'error':
        adc.renderer.clearErrors();
        break;
      case 'both':
        adc.renderer.clearNotification();
        adc.renderer.clearErrors();
        break;
    }
  }; // hideMessage

  
  /** 
    Function: registerPageItemsOnce
      Method to register a list of page items that are to be additionally sent to the server during the next ADC event

    Parameter:
      pItemList - Array of page item names
   */
  actions.registerPageItemsOnce = function(pItemList){
    adc.controller.setAdditionalItems(pItemList);
  }; // registerPageItemsOnce

  
  /** 
    Function: rememberPageItemStatus
      Method to persist the status of all page items or only the items provided as <pPageItems>.
      This is the basis for 'unsaved changes' messages in a dynamic environment.

    Parameters:
      pPageItems - Array of all page item ids to capture. If empty, all page items are captured.
      pMessage - Optional message to show if unsaved changes exist on the page
      pTitle - Optional title of the dialog that is shown if unsaved changes are detected
   */
  actions.rememberPageItemStatus = function(pPageItems, pMessage, pTitle){
    var itemList;
    var itemValue;
    var pageState;
    
    // Initialize
    pageState = adc.controller.getPageState();
    pageState.itemMap.clear();
    pageState.message = pMessage;
    pageState.title = pTitle;
    itemList = $(C_INPUT_SELECTOR);
    
    if (Array.isArray(pPageItems)){
      if (pPageItems.count > 0){
        itemList = pPageItems;
      }
    }
    
    $.each(itemList, function(item){
        item = itemList[item];
        if(item.id){
          item = item.id;
        };
        itemValue = apex.item(item).getValue();
        pageState.itemMap.set(item, itemValue);
        apex.debug.info(`Saving ${item} with value ${itemValue}`);
      }
   );
    adc.controller.setPageState(pageState);
  }; // rememberPageItemStatus


  /**
    Function: refresh
      Refreshes an item (region, page item etc.). Triggers apexrefresh event and enables the page item.

    Parameter:
      pItemId - ID of the page item to refresh
      pValue - Optional value to set the item to after refresh. If a region is refreshed, this represents the row to select
      pSetFocus - Optional item to set the focus to after refresh
   */
  actions.refresh = function (pItemId, pValue, pSetFocus){
    if($(`div#${pItemId}.js-apex-region`).length > 0){
      if (pItemId){        
        $(`#${pItemId}`)
        .one(C_APEX_AFTER_REFRESH, function(e){
          actions.selectEntry(pItemId, pValue, pSetFocus);
        });
      }
      apex.region(pItemId).refresh();
    }
    else{
      adc.controller.pauseChangeEventDuringRefresh(pItemId, pValue);
      apex.item(pItemId).show();
      apex.item(pItemId).enable();
      apex.item(pItemId).refresh();
    };
  }; // refresh


  /**
    Function: refreshAndSetValue
      Refreshes an item (region, page item etc.) and sets the item value afterwards.
      
      The following flow of actions are taken:
      
      - Persist the actual value of the page item
      - Bind one time apexafterrefresh handler to set the page item value to the persisted value after refresh
      - Trigger apexrefresh event
      - enable the page item

    Parameters:
      pItemId - ID of the page item to refresh and set the value
      pValue - Optional value. If not set, method looks for actual item value in cache or on page.
   */
  actions.refreshAndSetValue = function (pItemId, pValue){
    var itemValue = pValue || apex.item(pItemId).getValue() || adc.controller.findItemValue(pItemId);

    adc.controller.pauseChangeEventDuringRefresh(pItemId, itemValue);
    apex.item(pItemId).show();
    apex.item(pItemId).enable();
    apex.item(pItemId).refresh();
  }; // refreshAndSetValue


  /** 
    Function: selectEntry
      Method to select an entry in an CR, IR, IG or TREE. 
      For IR and CR, a data-id attribute must be present to create a selection target.

    Parameters:
      pRegionId - ID of the region to select an entry in
      pEntryId - ID of the entry to select
      pSetFocus - If true the selected row will get focus
      pNoinform - If true the treeView#event:selectionChange event will be suppressed.
   */
  actions.selectEntry = function(pRegionId, pEntryId, pSetFocus, pNoinform){
    let $region;
    let entry;
    const C_CR_SELECTOR = `#report_table_${pRegionId}`;
    const C_IR_SELECTOR = `#${pRegionId}_ir`;
    const C_IG_SELECTOR = `#${pRegionId}_ig`;
    const C_TREE_SELECTOR = `#${pRegionId}_tree`;
    const C_IR_FIRST_ROW_SELECTOR = ' .a-IRR-table tbody tr:nth-child(2)';
    const C_CR_FIRST_ROW_SELECTOR = ' > tbody > tr:nth-child(1)';
    const $reportDataItem = $(`input[${C_REGION_DATA_ITEM}=${pRegionId}]`);
    
    if(!pEntryId){
      if ($reportDataItem.length > 0){
        pEntryId = apex.item($reportDataItem.attr('id')).getValue();
      };
    };
    const C_DATA_ID_SELECTOR = ` span[data-id='${pEntryId}']`;

    switch(getRegionType(pRegionId)){
      case C_REGION_CR:
        if(!pEntryId){
          entry = $(C_CR_SELECTOR + C_CR_FIRST_ROW_SELECTOR);
        }
        else{
          entry = $(C_CR_SELECTOR + C_DATA_ID_SELECTOR).parent('td').parent('tr');
        };
        adc.renderer.highlightRow(entry, pSetFocus);
        break;
      case C_REGION_IG:
        $region = $(C_IG_SELECTOR);
        if(!pEntryId){
          pEntryId = $region.find('tbody tr').data('id');
        };
        if(pEntryId){
          entry = $region
                  .interactiveGrid('getViews', 'grid')
                  .model
                  .getRecord(pEntryId);
          if(entry){
            $region.interactiveGrid('setSelectedRecords', entry, pSetFocus, pNoinform);
          };
        }
        break;
      case C_REGION_IR:
        if(pEntryId){
          entry = $(C_IR_SELECTOR + C_DATA_ID_SELECTOR).parent('td').parent('tr');
        }
        if(pEntryId == '' || entry.length == 0){
          entry = $(C_IR_SELECTOR + C_IR_FIRST_ROW_SELECTOR);
          if ($reportDataItem.length > 0){
            pEntryId = entry.find('[data-id]').data('id');
          };
        };
        apex.item($reportDataItem.attr('id')).setValue(pEntryId);
        adc.renderer.highlightRow(entry, pSetFocus);
        break;
      case C_REGION_TREE:
        $region = $(C_TREE_SELECTOR);
        entry = $region.treeView(
                  'find',
                 {'depth': -1,
                   'match': function(n){
                              return n.id === pEntryId;
                            }
                  }
               );
        $region.treeView('collapseAll');
        $region.treeView('expand', entry);
        $region.treeView('setSelection', entry, pSetFocus, pNoinform);
        break;
    }
  }; // selectEntry


  /** 
    Function: setApexActionAccessKey
      Method makes an APEX action shortcut visible by adding a CSS class around the access key letter.      
      This method finds the first letter that matches the shortcut key and surrounds it with a span element and a CSS class.
      
      IMPORTANT: This method only supports simple shortcuts like <Alt-T>!

    Paramter:
      pAction - Name of the APEX action on the page
   */
  actions.setApexActionAccessKey = function (pAction){
    const C_SHORTCUT_CLASS = 'accesskey';
    const C_DATA_SHORTCUT_CLASS = 'data-accesskey';
    const C_BUTTON_LABEL_CLASS = 't-Button-label';

    var re;
    var $this;
    var $label = $this.find(`.${C_BUTTON_LABEL_CLASS}`);
    var label = $label.html();
    var shortcut = re.exec(label);

    var $buttons = $(`[data-action='${pAction}']`);
    var accesskey = apex.actions.lookup(pAction).shortcut;

    if(accesskey !== ''){
      accesskey = accesskey.slice(-1);
    }
    if(accesskey.length > 0){
      re = new RegExp(accesskey, 'i');
      $buttons.each(function(){
        $this = $(this);

        if(!$this.find(`.${C_BUTTON_LABEL_CLASS}`)[0]){
          $this.html(`<span class='${C_BUTTON_LABEL_CLASS}'>${$this.html()}>span>`);
        }

        $label.html(
            label.replace(re,
                          `<span class='${C_SHORTCUT_CLASS}'>${shortcut}>span>`));

        $this.attr('accesskey', shortcut);
        $this.attr('data-accesskey', label.search(re));
      });
    }
  }; // setApexActionAccessKey


  /**
    Function: setDisplayState
      Sets this visible aspects of a page items.

    Parameters:
      pSelector - jQuery selector of the items that should be shown
      pVisibleState - One of the constants HIDE | SHOW_DISABLE | SHOW_ENABLE
      pLabel - If set, controls the label of the page items
   */
  actions.setDisplayState = function (pSelector, pVisibleState, pLabel){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      
      switch(pVisibleState){
        case C_HIDE:
          apex.item(pItemId).hide();
          break;
        case C_SHOW_DISABLE:
          apex.item(pItemId).show();
          adc.renderer.disableElement(pItemId);
          // Beside disabling the item, all events from the queue must be removed
          // to assure that a disabled button can not raise a click event
          $(C_BODY).clearQueue();
          break;
        case C_SHOW_ENABLE:
          apex.item(pItemId).show();
          adc.renderer.enableElement(pItemId);
          break;
        default:
          apex.debug.info(`Visual State ${pVisibleState} not supported`);
      }

      if(pLabel){
        adc.renderer.setItemLabel(pItemId, pLabel);
      }
    });
  }; // setDisplayState


  /**
    Function setErrors
      Shows an error message on the screen.
      
      An error does not necessarily indicate a misbehaviour of ADC but is a normal response fi. when a validation fails.
      This method will clear the event queue if an error is passed in. Reasoning behind this is:
      If a value is entered in an input field but the field is not left using a tab key or a mouse click, but instead you click on a button
      while the focus is still in the input field, two events will be raised: <change> on the input field and <click> on the button.

      Now, ADC may validate the input field and the <click> event should only be processed if the validation passes.
      As both events are raised (almost) concurrently and handled asynchronously, there is no possibility for ADC 
      to prevent the <click> event from happening.

      To cater for this, some events (like click or enter) are queued within ADC and therefore serialized. Using this technique,
      the <click> event can be surpressed by clearing the queue.
   */
  actions.setErrors = function (pErrorList){
    
    if (pErrorList){
      // If errors have occured, no further events must be processed.
      if (pErrorList.errors.length > 0){
        $(C_BODY).clearQueue();
      }
      // Remove errors and warnings for all touched items from our gErrors copy
      $.each(pErrorList.firingItems, function(index, pItemId){
        // remove the error from gErrors
        gErrors = $.grep(gErrors, function(e){
          return e.pageItem != pItemId && e.pageItem != C_DOCUMENT;
        });
      });
    
      // Add new errors to our gErrors copy
      for (let i = 0; i < pErrorList.errors.length; i++){
        const err = pErrorList.errors[i]
        gErrors.push(err);
      };
    }
    else{
      // No error object passed in, remove all errors
      gErrors = [];
    }
    
    adc.renderer.showErrors(gErrors);
  }; // setErrors
  
  
  /**
    Function: setFocus
      Method to set the focus to a given item. The method analyzes the type of the item and acts accordingly.
      Supported item types: PAGE_ITEMS REPORTS
      
     Parameters:
       pItemId - ID of the item to set the focus to
   */
  actions.setFocus = function(pItemId){
    if (pItemId){        
     if($(`div#${pItemId}.js-apex-region`).length > 0){
        actions.selectEntry(pItemId, null, true, true);
      }
      else{
        $(`#${pItemId}`).focus();
      }
    }
  }; // setFocus


  /**
    Function: setItemValues
      Wrapper <around apex.item().setValue()> that allows to set the same value to many items using a jQuery selector.
      It also surpresses a change event when setting the values to avoid ADC loops.

    Parameters:
      pSelector - jQuery selector to identify the page items to set the value
      pValue - Value of the page item
   */
  actions.setItemValue = function (pSelector, pValue){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id');
      apex.item(pItemId).setValue(pValue, pValue, true);
    });
  }; // setItemValue


  /**
    Function: setItemValues
      Takes an object with page items and their actual value as stored in the session state and harmonizes them with the page.

    Parameter:
      pPageItems - Array of objects of the form <{'id':'pageItemID','value':'itemValue'}>.
   */
  actions.setItemValues = function (pPageItems){
    // Store the object for later reference by asynchronous calls
    adc.controller.setLastItemValues(pPageItems);

    // harmonize the session state with the page items
    $.each(pPageItems, function (){
      if ((this.value || 'FOO') !== (apex.item(this.id).getValue() || 'FOO')){
        // third attribute surpresses the change event if set to true
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.info(`Item '${this.id}' set to '${this.value}'`);
      }
    });
  }; // setItemValues


  /**
    Function: setMandatory
      Renders a field as mandatory or optional, based on parameter <pIsMandatory>.
      
      Setting an item mandatory is a two step process. 
      
      - ADC regsiters a change handler and observes it, if not yet done
      - the page representation must be changed to represent the status.
      
    Parameters:
      pSelector - jQuery selector of the items that should be set to mandatory
      pIsMandatory - Flag to indicate whether the items are mandatory (TRUE) or  not (FALSE)
      pVisualState - Optional visual state. If an item is set optional, set state may differ,
                     whereas if an item is mandatory, it will allways be visible and active.
   */
  actions.setMandatory = function (pSelector, pIsMandatory, pVisualState){
    forEach(pSelector, function (){
      var pItemId = $(this).attr('id').replace('_CONTAINER', '');
      if (pIsMandatory){
        adc.controller.pushPageItem(pItemId);
        actions.setDisplayState(pSelector, C_SHOW_ENABLE);
      } 
      else{
        actions.setDisplayState(pSelector, pVisualState);
      }
      adc.renderer.setItemMandatory(pItemId, pIsMandatory);
    });
  }; // setMandatory

  
  /**
    Function: setModalDialogTitle
      Sets the title of a modal dialog window.

    Parameter:
      pTitle - Title of the modal window
   */
  actions.setModalDialogTitle = function(pTitle){
    adc.renderer.setModalDialogTitle(pTitle);
  }; // setModalDialogTitle
  
  
  /**
    Function: setRegionContent
      Method to set the actual region content of a static region
      
    Parameters:
      pRegionId - ID of the region
      pContent - HTML content of the region
   */
  actions.setRegionContent = function(pRegionId, pContent){
    adc.renderer.setRegionContent(pRegionId, pContent);
  }; // setRegionContent
  
  
  /**
    Function: setRegionHeader
      Method to adjust the region header. Works with normal regions and tab regions.
      
    Parameters:
      pRegionId - ID of the region
      pHeader - Header of the region
   */
  actions.setRegionHeader = function(pRegionId, pHeader){
    adc.renderer.setRegionHeader(pRegionId, pHeader, getRegionType(pRegionId));
  }; // setRegionHeader

  /*
    Function: selectTab
      Method to select and activate a tab in a tabulator region

    Parameters:
      pTabRegionId - ID of the tabulator region
      pTabId - ID of the tab to activate
   */
  actions.selectTab = function(pTabRegionId, pTabId){
    apex.region(pTabRegionId).widget().aTabs('getTabs')[`#${pTabId}`].makeActive();
  }; // selectTab


  /** Shows or hides a waiting spinner
    Function: showWaitSpinner
      Displays or removes a wait spinner animation for long running operations

    Parameter:
      pFlag - Flag to indicate whether to show (true) a wait spinner or not (false)
   */
  actions.showWaitSpinner = function(pFlag){
    adc.renderer.showWaitSpinner(pFlag);
  }; // showWaitSpinner


  /**
    Function: submit
      Submits the page. 
      If the page still contains unsolved errors, the page will not be submitted, but a dialog is shown to the user.

    Parameters:
      pRequest - REQUEST value that is passed to the server
      pMessage - Message that is shown to the user if the page still contains unsolved errors.
   */
  actions.submit = function (pRequest, pMessage){
    adc.renderer.submitPage(pRequest, pMessage);
  }; // submit

  /* +++++++++ END SYSTEM ACTION TYPES +++++++++++ */

}(de.condes.plugin.adc, apex.jQuery));
