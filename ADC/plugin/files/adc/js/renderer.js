// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};
de.condes.plugin.adc.apex_42_20_2 = {};

/**
  Function: ADC Theme adapter
    Interface between the ADC plugin actions and the APEX user interface for Theme 42 in Version 20.2

    ADC needs to interact with the APEX UI to achieve the visual effects requested by the page rules. APEX on the other hand
    comes in different versions and themes, making it difficult for generic code to take care of all the different strategies
    used to display content.
    
    ADC caters for this by delegating the UI specific methods into a separate renderer, implementing the visual code for a specific
    combination of APEX version and theme. The required renderer is selected by a component parameter of the plugin where 
    the namespace of the required renderer code implementation can be set.
    
    This file implements the visual effects of version 20.2, Theme 42. If you use the same version but a different template or
    if you extended your theme by addressing specific needs for your company, you may have to add or overwrite functionality of this object.
    
    To provide your own version, it is recommended to create a new object that inherits from this object and overwrites the functionality you need.
 
    For a description of the structure of the objects passed in see the documentation of adc.js

  Parameters:
    adc - Namespace object to adopt ADC to the given APEX version and theme
    msg - Message object provided by APEX, instance of apex.message
 */
(function(renderer, msg){

  const C_APEX_ERROR_CLASS_SEL = 'div.a-Notification--error';
  const C_VISIBLE = 'u-visible';
  const C_HIDDEN = 'u-hidden';
  const C_ADC_DISABLED = 'adc-disabled';
  const C_APEX_DISABLED = 'apex_disabled';

  const C_REGION_CR = 'ClassicReport';
  const C_REGION_IR = 'InteractiveReport';
  const C_REGION_IG = 'InteractiveGrid';
  const C_REGION_TREE = 'Tree';
  const C_REGION_TAB = 'Tab';

  // Class constants
  const C_REQUIRED_CLASS = 'is-required';

  // Selector constants
  const C_REGION_BODY_SELECTOR = ' .t-Region-body,.t-ContentBlock-body';
  const C_REGION_TITLE_SELECTOR = ' .t-Region-title';
  const C_MODAL_DIALOG_TITLE_SELECTOR = ' .ui-dialog-title';
  const C_POPUP_LOV_SELECTOR = '.a-Button--popupLOV';

  // Attribute constants
  const C_READONLY_PROP = 'readonly';
  const C_DISABLED_PROP = 'disabled';

  // Event constants
  const C_IG_SELECTION_CHANGE = 'interactivegridselectionchange';
  const C_TREE_SELECTION_CHANGE = 'treeviewselectionchange';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_CLICK = 'click';
  


  /**
    Function: alignReportVerticalTop
      Method adjusts report cells vertically to top

    Parameter:
      pReportId - Static ID of the report to adjust
   */
  renderer.alignReportVerticalTop = function(pReportId){
    var $report = $(`#${pReportId}`);
	  $report.find('td').addClass('u-alignTop');
	  
	  $report.on(C_APEX_AFTER_REFRESH), function(){
	    alignReportVerticalTop(pReportId);
    }		
  }; // alignReportVerticalTop

  
  /**
    Function: clearErrors
      Removes all messages in the notification region
   */
  renderer.clearErrors = function(){
    gErrors = [];
    gWarnings = [];
    msg.clearErrors();
  }; //clearErrors

  
  /**
    Function: clearNotification
      Removes all messages in the notification region
   */
  renderer.clearNotification = function(){
    msg.hidePageSuccess();
  }; // clearNotification

  /**
    Function: confirmRequest
      Shows a confirmation dialog to the user before calling the intended functionality.

    Parameters:
      pEventOrMessage - Event to extract the message text from or a plain message
      pCallback - Method to be called if the user confirmes this dialog
      pFocusItem - Item to set the focus to if no confirmation is given
   */
  renderer.confirmRequest = function(pEventOrMessage, pCallback, pFocusItem){
    let message;
    let dialogTitle;
    
    if(typeof(pEventOrMessage) === "string"){
      message = pEventOrMessage;
    }else{
      message = pEventOrMessage.data.message;
      dialogTitle = pEventOrMessage.data.title;

    }
    apex.message.confirm(message, function (pAnswer) {
      if(pAnswer){
        pCallback(pEventOrMessage);
      }
      else {
        apex.item(pFocusItem).setFocus();
      };
    });
    renderer.setModalDialogTitle(dialogTitle);
  }; // clearNotification
  

  /**
    Function: disableElement
      Disables a page item. Handles deactivation of 

      - page items with values to allow to include them in a submit
      - select lists
      - buttons

    Parameter
      pItemId - ID of the page item to disable
   */
  renderer.disableElement = function (pItemId){
    var $item = $('#' + pItemId);
    var $itemLabel = $('#' + pItemId + '_LABEL');
    apex.item(pItemId).show();

    // Normal element, do not disable, otherwise sessionstate will not be filled.
    // Instead, set readonly and CSS class so that it looks like disabled.
    $item
      .prop(C_READONLY_PROP, true)
      .addClass(C_APEX_DISABLED)
      .attr('aria-disabled', 'true')
      .attr('tabindex', "-1");

    // if the page element is a selection list, readonly must be added differently
    if ($item.hasClass("selectlist")) {
      $item.attr(C_READONLY_PROP, C_READONLY_PROP);
      // in selection lists also provide the label with this class, so that when clicking on the label
      // the selection list does not become active and another value can be selected via keyboard
      $itemLabel.addClass(C_ADC_DISABLED);
    }

    // if the page element is a CKEDITOR, readonly can be done savely with the built in APEX method
    if ($item.parent('div').find('div.ck').length){
      apex.item(pItemId).disable();
    }

    // if the page element is a date field, then also deactivate the button for the date selection
    if ($item.hasClass("hasDatepicker") || $item.hasClass("color_picker") || $item.hasClass("popup_lov")) {
      $item.parent().find("button").prop(C_DISABLED_PROP, true);
    }
  }; // disableElement

  
  /**
    Function: enableElement
      Enables a page item. Handles activation of 

      - page items with values to allow to include them in a submit
      - select lists
      - buttons

    Parameter:
      pItemId - ID of the page item to disable
   */
  renderer.enableElement = function (pItemId){
    var $item = $(`#${pItemId}`);
    $item
      .prop(C_READONLY_PROP, false)
      .removeClass(C_ADC_DISABLED)
      .removeAttr('tabindex');

    if ($item.is('select')){
      $(`#${pItemId}:not(:selected)`)
        .prop(C_READONLY_PROP, false);
    }
    apex.item(pItemId).show();
    apex.item(pItemId).enable();
    
    // if page item is a date picker, enable button as well
    if ($item.hasClass("hasDatepicker") || $item.hasClass("color_picker") || $item.hasClass("popup_lov")) {
      $item.parent().find("button")
        .prop(C_DISABLED_PROP, false)
        .removeClass(C_ADC_DISABLED)
        .removeAttr('tabindex');
    }

    // if page item is a colour picker, enable button as well
    else if ($item.hasClass("color_picker")) {
      $('#' + pItemId + '_fieldset')
        .prop(C_READONLY_PROP, false)
        .removeClass(C_ADC_DISABLED)
        .removeAttr('tabindex');
    }

    // if page item is a popup list, enable button as well
    else if ($item.hasClass("popup_lov")) {
      $item.closest('#' + pItemId + '_fieldset')
        .find(C_POPUP_LOV_SELECTOR)
        .prop(C_READONLY_PROP, false)
        .removeClass(C_ADC_DISABLED)
        .removeAttr('tabindex');
    };
  }; // enableElement
  

  /**
    Function: hideReportFilterPanel
      Removes filter area from interactive report or interactive grid.

    Parameters:
      pRegionId - Static id of the interactive report or grid
      pRegionType - Type of the report
   */
  renderer.hideReportFilterPanel = function(pRegionId, pRegionType){
    switch(pRegionType){
      case C_REGION_IR:
        $(`#${pRegionId}_conrol_panel`).hide(); // interactive report
        break;
      case C_REGION_IG:
        $(`#${pRegionId} .a-MediaBlock`).hide(); // interactive grid
        break;
    }
    
    $(`#${pRegionId}`).on(C_APEX_AFTER_REFRESH, function(){
      renderer.hideReportFilterPanel(pRegionId, pRegionType);
    });
  }; // hideReportFilterPanel
  
  
  /**
    Function: highlightRow
      Method to optically select a row in a report
     
    Parameters:
      pRow - jQuery object pointing to the data row to highlight
      pSetFocus - Flag to indicate whether the row has to be focussed
   */
  renderer.highlightRow = function(pRow, pSetFocus){
    pRow.addClass("adc-selected-row").siblings().removeClass("adc-selected-row");
    
    if (pSetFocus){
      pRow.find('td:first-child a').focus();
    };
  }; // highlightRow

  
  /**
    Function: showErrors
      Maintains the error list on the page.

    Parameter:
      pErrors - Array of errors, instances of <error>
   */
  renderer.showErrors = function(pErrors){
      
      msg.clearErrors();
      // Remove warning markup
      $('.t-Form-warning')
        .removeClass('apex-page-item-warning')
        .parents('.t-Form-inputContainer').find('.t-Form-warning')
        .removeClass('t-Form-warning');
          
      msg.showErrors(pErrors);
      // Change markup of warnings
      $.each(pErrors, function(index, pError){
        if (pError.type == 'warning'){
          $(`#${pError.pageItem}`)
            .removeClass('apex-page-item-error').addClass('apex-page-item-warning')
            .parents('.t-Form-inputContainer').find('.t-Form-error')
            .removeClass('t-Form-error').addClass('t-Form-warning');
        }
      });
  }; // showErrors

  
  /**
    Function: setItemLabel
      Sets the label of a page item.

    Parameters:
      pItemId - ID of the page item to set the label of
      pItemLabel - New item label
   */
  renderer.setItemLabel = function(pItemId, pItemLabel){
	  $(`#${pItemId}_LABEL`).text(pItemLabel);
  }; // setItemLabel

    
  /**
    Function: setItemMandatory
      Controls the mandatory status of a page item.

    Parameters:
      pItemId - Page item ID of the item to set mandatory or optional
      pIsMandatory - Flag to set a page item mandatory (true) or optional (false)
   */
  renderer.setItemMandatory = function(pItemId, pIsMandatory){

    var $mandatoryItem = $(`#${pItemId}_CONTAINER`);

    $mandatoryItem.removeClass(C_REQUIRED_CLASS);
    
    if(pIsMandatory){
      $mandatoryItem.addClass(C_REQUIRED_CLASS);
    }
  }; // setItemMandatory

  
  /**
    Function: setModalDialogTitle
      Sets the title of a modal dialog window.

    Parameter:
      pItemLabel - New item label
   */
  renderer.setModalDialogTitle = function(pTitle){
    parent.$(C_MODAL_DIALOG_TITLE_SELECTOR).last().html(pTitle);
  }; // setModalDialogTitle

  
  /**
    Function: showDialog
      Shows a message on the page

    Parameter:
      pStyle - One of the predefined styles information|warning|sucess|error
      pMessage - Message of the dialog
      pTitle - Optional title of the dialog
      pFocusItem - Flag to indicate whether this dialog is a confirmation dialog
   */
  renderer.showDialog = function(pStyle, pMessage, pTitle, pFocusItem){
    if (pFocusItem === undefined){
      pFocusItem  = $('.t-Body').find('input, button').not(':hidden').first().attr('id');
    };
    const callback = function(){
      $(`#${pFocusItem}`).focus();
    };
    const options = {
      "modern":true,
      "title":pTitle,
      "callback":callback};
    switch (pStyle){
      case 'ALERT':
        options.style = 'error';
        msg.showDialog("" + pMessage, options);
        break;
      case 'SUCCESS':
        msg.showPageSuccess(pMessage);
        $('.t-Button--closeAlert').one('click', function(){
          $(`#${pFocusItem}`).focus();
        });
        break;
      case 'WARNING':
        options.style = 'warning';
        msg.showDialog("" + pMessage, options);
        break;
      case 'INFO':
        options.style = 'information';
        msg.showDialog("" + pMessage, options);
        break;
    };
    
  }; // showDialog

  
  /**
    Function: showSuccess
      Shows a success message on the page

    Parameter:
      pMessage - Message to display
   */
  renderer.showSuccess = function(pMessage, pTitle, pStyle, pConfirm){
    msg.showPageSuccess(pMessage);
  }; // showSuccess


  /**
    Function setRegionContent
      Method to set the content of a static region

    Parameter:
      pRegionId - Static ID of the region to set the context of
      pContent - Content of the region
   */
  renderer.setRegionContent = function(pRegionId, pContent){
    $('#' + pRegionId + C_REGION_BODY_SELECTOR).html(pContent);
  }; // setRegionContent
  
  
  /**
    Function: setRegionHeader
      Method to adjust the region header. Works with normal regions and tab regions.
      
    Parameters:
      pRegionId - ID of the region
      pHeader - Header of the region
      pRegionType - Type of the Region (Tab- or plain region)
   */
  renderer.setRegionHeader = function(pRegionId, pHeader, pRegionType){
    switch(pRegionType){
      case C_REGION_TAB:
        $(`#SR_${pRegionId}_tab a span`).html(pHeader)
        break;
      default:
        $('#' + pRegionId + C_REGION_TITLE_SELECTOR).html(pHeader);
        break;
    }
  }; // setRegionHeader

  
  /**
    Function: showWaitSpinner
      Shows a wait spinner on the page

    Parameter:
      pFlag - Flag to indicate whether to show (true) a wait spinner or not (false)
   */
  renderer.showWaitSpinner = function(pFlag){
    if(pFlag){
      apex.util.showSpinner();
    }
    else{
      $("#apex_wait_overlay").remove();
      $(".u-Processing").remove();
    };
  }; // showWaitSpinner

  
  /** 
    Function: submitPage
      Method submits page with the given request if no errors are on the page.

    Parameters:
      pRequest - Request for the server
      pMessage - Alert message warning the user if submit couldn't be executed due to errors on page
   */
  renderer.submitPage = function(pRequest, pMessage){
    if ($(C_APEX_ERROR_CLASS_SEL).length == 0 && pMessage.length == 0) {
      apex.page.submit({
        "request" : pRequest,
        "showWait" : true
      });
    }
    else{
      msg.alert(pMessage);
    }
  }; // submitPage

})(de.condes.plugin.adc.apex_42_20_2, apex.message);