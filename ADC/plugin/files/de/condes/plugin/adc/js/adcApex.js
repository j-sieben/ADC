// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};
de.condes.plugin.adc.apex_42_5_1 = {};

/**
 * Interface between the ADC plugin and the APEX user interface for Version 5.1, Theme 42
 * @namespace de.condes.plugin.adc.apex_42_5_1
 * @since 5.1
 * @description
 * <p>ADC needs to interact with the APEX UI to achieve the visual effects requested by the page rules. APEX on the other hand
 * comes in different versions and themes, making it difficult for on central code to take care of all the different strategies
 * used to show content</p>
 * <p>ADC caters for this by delegating the UI specific methods into a separate file, implementing the visual code for a specific
 * combination of APEX version and theme. The required file may be chosen by utilizing a component parameter of the plugin. There,
 * the namespace of the required UI code implementation can be set.</p>
 * <p>This object implements the visual effects of version 5.1, Theme 42. If you use the same version but a different template or
 * if you extended your theme by addressing specific needs for your company, you may have to add or overwrite functionality of this object.</p>
 * <p>To provide your own version, it is recommended to create a new object that inherits from this object and overwrites the functionality
 * you need.</p>
 * <p>For a description of the structure of the objects passed in see the documentation of adc.js</p>
 * @param {Object} adc Namespace object to adopt ADC to the given APEX version and theme
 * @param {apex.message} Message object provided by APEX
 */
(function(adc, msg){

  var C_APEX_ERROR_CLASS_SEL = 'div.a-Notification--error',
      C_VISIBLE = "u-visible",
      C_HIDDEN = "u-hidden",
      C_ITEM_ERROR = "apex-page-item-error",
      C_FORM_ERROR = "a-Form-error",
      C_STANDARD_ERROR_SEL = ".htmldbStdErr";

  var A_DESCRIBEDBY = "aria-describedby",
      A_INVALID = "aria-invalid";
      
  var D_OLD_A_DESCRIBEDBY = "data-old-aria-describedby";
  
  // Globals
  var gErrors = []; // Interim solution required until <code>apex.message</code> supports removing a single error
  
  adc.alignReportVerticalTop = function(id){
	  $(`#${id} td`).attr('style', 'vertical-align:top');
	  
	  $(`#${id}`).on('apexafterrefresh'), function(){
	    alignReportVerticalTopU(id);
    }		
  };
  
  /**
   * Removes all messages in the notification region
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.clearNotification = function(){
    msg.hidePageSuccess();
  };

  /**
   * Shows a confirmation dialog to the user before calling the intended rfunctionality
   * @param {event} e Event that was raised by the user
   * @param {callback} callback Method to be called if the user confirmes this dialog
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   */
  adc.confirmRequest = function(e, callback){
    apex.dialog.confirm(e.data.message,e.data.title).then(function (answer) {
      if(answer == "true"){
         callback(e);
      };
    });
  };
  
  /**
   * Disables a page item. Handles deactivation of 
   * - page items with values to allow to include them in a submit
   * - select lists
   * - buttons
   * @param {string} pItemId ID of the page item to disable
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   */
  adc.disableElement = function (pItemId){
    // Normal element, do not disable, otherwise sessionstate will not be filled.
    // Instead, set readonly and CSS class so that it looks like disabled.
    var $this = $(`#${pItemId}`);
    $this.prop('readonly', true).addClass('adc-disabled');

    if ($this.is('select')){
      // Select list, deactivate all entries except the selected one
      $(`#${pItemId}:not(:selected)`).prop('disabled', false);
    }
    else if ($this.is('button')){
      // button, is deactivated "normally"
      apex.item(pItemId).disable();
    }
    else if ($this.is('input')){
      apex.item(pItemId).disable();
    };
    // Disabling an item means that it is visible. Make sure it is.
    apex.item(pItemId).show();
  };
  
  /**
   * Enables a page item. Handles activation of 
   * - page items with values to allow to include them in a submit
   * - select lists
   * - buttons
   * @param {string} pItemId ID of the page item to disable
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   */
  adc.enableElement = function (pItemId){
    var $this = $(`#${pItemId}`);
    $this.prop('readonly', false).removeClass('adc-disabled');

    if ($this.is('select')){
      $(`#${pItemId}:not(:selected)`).prop('disabled', false);
    }
    apex.item(pItemId).show();
    apex.item(pItemId).enable();
    
    // if page item is a date picker, enable button as well
    if ($this.hasClass("hasDatepicker")) {
      $this.parent().find("button").prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
    }

    // if page item is a colour picker, enable button as well
    else if ($this.hasClass("color_picker")) {
      $('#' + pItem + '_fieldset').prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
    }

    // if page item is a popup list, enable button as well
    else if ($this.hasClass("popup_lov")) {
      $this.closest('#' + pItem + '_fieldset').find('.a-Button--popupLOV')
         .prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
    };
  };
  
  /**
   * Removes filter area from interactive report or interactive grid
   * @param {string} pRegionId static id of the interactive report or grid
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.hideReportFilterPanel = function(pRegionId){
    $(`#${pRegionId}_conrol_panel`).hide(); // interactive report
    $(`#${pRegionId} .a-MediaBlock`).hide(); // interactive grid
    
    $(`#${pRegionId}`).on('apexafterrefresh', function(){
      hideReportFilterPanel(pRegionId);
    });
  };
  
  /**
   * Maintains the error list on the page
   * @param {errorList} List of errors
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.maintainErrors = function(pErrorList){
    
    // Map errors to apex.message.errorObject
    apex.debug.log(`Error amount PlugIn: ${pErrorList.count}`);
       
    // Remove errors for all touched items from our gErrors copy
    $.each(pErrorList.firingItems, function(index, pItemId){
      // remove the error from gErrors
      gErrors = $.grep(gErrors, function(e){
        return e.pageItem != pItemId;
      });
    });
  
    // Add new errors to our gErrors copy
    for (i = 0; i < pErrorList.errors.length; i++){
        gErrors.push(pErrorList.errors[i]);
    };
    
    msg.clearErrors();
    msg.showErrors(gErrors);
    
  };
    
  /**
   * Controls the mandatory status of a page item
   * @param {string} pItemId Page item ID of the item to set mandatory or optional
   * @param {boolean} pIsMandatory Flag to set a page item mandatory (true) or optional (false)
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.setItemMandatory = function(pItemId, pIsMandatory){

    var $mandatoryItem = $(`#${pItemId}_CONTAINER`);
    var C_REQUIRED_CLASS = 'is-required';

    $mandatoryItem.removeClass(C_REQUIRED_CLASS);
    
    if(pIsMandatory){
      $mandatoryItem.addClass(C_REQUIRED_CLASS);
    }
  };
  
  /**
   * Sets the label of a page item
   * @param {string} pItemId ID of the page item to set the label of
   * @param {string} pItemLabel  New item label
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.setItemLabel = function(pItemId, pItemLabel){
	  $(`#${pItemId}_LABEL`).text(pItemLabel);
  };
  
  /**
   * Shows a message on the page
   * @param {string} pMessage Message text to show
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.setNotification = function(pMessage){
    msg.hidePageSuccess();
    msg.showPageSuccess(pMessage);
  };
  
  /** 
   * Method submits page with the given request if no errors are on the page
   * @param {string} pRequest Request for the server
   * @param {string} pMessage Alert message warning the user if submit couldn't be executed due to errors on page
   * @memberof de.condes.plugin.adc.apex_42_5_1
   * @public
   * @override
   */
  adc.submitPage = function(pRequest, pMessage){

    if ($(C_APEX_ERROR_CLASS_SEL).length == 0) {
      apex.page.submit({
        "request" : pRequest,
        "showWait" : true
      });
    }
    else{
      msg.alert(pMessage);
    }
  };

})(de.condes.plugin.adc.apex_42_5_1, apex.message);