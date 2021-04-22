// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};
de.condes.plugin.adc.apex_42_5_0 = {};

/**
 * Interface between the ADC plugin and the APEX uiser interface
 */
/** 
 * @namespace de.condes.plugin.adc
 * @since 5.0
 * @desc
 * <p>ADC needs to interact with the APEX UI to achieve the visual effects requested by the page rules. APEX on the other hand
 * comes in different versions and themes, making it difficult for on central code to take care of all the different strategies
 * used to show content</p>
 * <p>ADC caters for this by delegating the UI specific methods into a separate file, implementing the visual code for a specific
 * combination of APEX version and theme. The required file may be chosen by utilizing a component parameter of the plugin. There,
 * the namespace of the required UI code implementation can be set.</p>
 * <p>This object implements the visual effects of version 5.0, Theme 42. If you use the same version but a different template or
 * if you extended your theme by addressing specific needs for your company, you may have to add or overwrite functionality of this object.</p>
 * <p>To provide your own version, it is recommended to create a new object that inherits from this object and overwrite the functionality
 * you need. How this is achieved can be explored by looking at the other objects within this file, dealing with later apex versions.</p>
 * <p>For a description of the structure of the objects passed in see the documentation of adc.js</p>
 */
 
/** IIFE for the root object, version 5.0, Theme 42
 * @namespace de.condes.plugin.adc.apex_42_5_0
 * @desc
 * <p>This object forms the basic implementation and indicates the minuimum supported apex version of ADC. Later releases may decide to remove support 
 * for this version and base it's functionality on a more recent APEX version.</p>
 * @param {Object} adc Namespace object to adpot ADC to the given APEX version and theme
 */
(function(adc){
  "use strict";

  /**
   * APEX error handling
   * In APEX 5.0 the standard error region is not part of the normal page rendering process, as validating the page
   * is implemented in a round trip to the server. If errors occur, the page is rendered again, this time with the error regions.
   * ADC follows an AJAX based approach and therefore needs to add the missing error regions onto the page to be able to show the 
   * error messages as APEX itself does.
   */
  var C_APEX_ERROR_CLASS = 'apex-page-item-error';
  var C_APEX_ERROR_CLASS_SEL = `.${C_APEX_ERROR_CLASS}, .DOCUMENT`;
  
  var C_MESSAGE_TITLE_SEL = '.t-Alert-title';    
  var C_ERROR_CLASS_SEL =  '.t-Body-alert';
  var C_ERROR_UL_SEL = `${C_ERROR_CLASS_SEL} ul.htmldbUlErr`;
  var C_ERROR_REGION_POSITION_SEL = '.t-Body-content';
  var C_ERROR_DIALOG_POSITION_SEL = '.t-Dialog-body';
  
  var C_CAROUSEL_SEL = '.a-Region-carouselItem';
  var C_CAROUSEL_ERROR_CLASS = 'adc-carousel-hasError';
  
  var C_APEX_ERROR_ID_SEL = '#t_Alert_Notification';

  // Standard APEX error region
  var C_PAGE_ERROR_TEMPLATE = 
  `<div class="t-Body-alert">
    <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG is-visible" id="t_Alert_Notification" role="alert">
      <div class="t-Alert-wrap">
        <div class="t-Alert-icon">
          <span class="t-Icon"></span>
        </div>
        <div class="t-Alert-content">
          <div class="t-Alert-header">
            <h2 class="t-Alert-title"></h2>
          </div>
          <div class="t-Alert-body">
            <ul class="htmldbUlErr"></ul>
          </div>
        </div>
        <div class="t-Alert-buttons">
          <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="Schließen"><span class="t-Icon icon-close"></span></button>
        </div>
      </div>
    </div>
  </div>`;
    
  // Standard APEX error messages inline
  var C_ELEMENT_ERROR_TEMPLATE = '<span class="t-Form-error">#MESSAGE#</span>';
  var C_ELEMENT_ERROR_SEL = ' .t-Form-error';

  // Notifications
  var C_APEX_NOTIFICATION_ID_SEL = '#t_Alert_Success';
  var C_PAGE_NOTIFICATION_TEMPLATE = 
  `<div class="t-Body-alert">
    <div id="t_Alert_Success" class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG is-visible" role="alert">
      <div class="t-Alert-wrap">
        <div class="t-Alert-icon">
          <span class="t-Icon"></span>
        </div>
        <div class="t-Alert-content">
          <div class="t-Alert-header">
            <h2 class="t-Alert-title"></h2>
          </div>
        </div>
          <div class="t-Alert-body"></div>
        <div class="t-Alert-buttons">
          <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="Schließen"><span class="t-Icon icon-close"></span></button>
        </div>
      </div>
    </div>
  </div>`;
  
  // Mandatory items
  var C_REQUIRED_SPAN_SEL = 'span.t-Form-required';
  var C_FIELD_REQUIRED_TEMPLATE = '<span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span>';
  var errorCount;

  // Helpers
  /** 
   * Helper method to adjust the introducing message sentence according to the amount of errors
   * @private
   */
  function setMessage() {
    var $messageTitle = $(C_MESSAGE_TITLE_SEL);
    errorCount = $(C_APEX_ERROR_CLASS_SEL).length;
    apex.debug.log(`Anzahl Fehler: ${errorCount}`);
   
    switch (errorCount){
	    case 0:
        $messageTitle.text(`Keine Fehler`);
        break;
	   
	    case 1:
        $messageTitle.text(`Es ist 1 Fehler aufgetreten`);
        break;
	   
	    default:
      $messageTitle.text(`Es sind ${errorCount} Fehler aufgetreten`);
    };
  };
  
  
  /** 
   * Method to remove error messages
   * @private
   */
  function removeErrors(errorList) {
    var firingItems = errorList.firingItems.split(',');
    
    $.each(firingItems, function(){
      $(`#${this}${C_APEX_ERROR_CLASS_SEL}`)
      .removeClass(C_APEX_ERROR_CLASS)
      .siblings('span')
      .remove();

      errorCount = $(C_APEX_ERROR_CLASS_SEL).length;
      if (errorCount == 0){
        $(C_ERROR_CLASS_SEL).remove();
      }
      else{
        $(`${C_ERROR_CLASS_SEL} .${this}`).remove();
      }
      
      // Remove error notifications from all tabs if present
      var carouselID = $(`#${this}`).closest(C_CAROUSEL_SEL).attr('id');
      if ((carouselID) && ($(`#${carouselID} ${C_APEX_ERROR_CLASS_SEL}`).length == 0)) {
        $(`a.a-Region-carouselLink[href="#${carouselID}"]`).removeClass(C_CAROUSEL_ERROR_CLASS);
      };
    });
  };


  /**
   * Adds an error region on the page if it is not present
   * @private
   */
  function createErrorRegion(){	   
    if ($(`${C_ERROR_CLASS_SEL} ${C_APEX_ERROR_ID_SEL}`).length == 0){
      // No error region exists on page, add. Distinguish between modal and normal page
      if ($(C_ERROR_DIALOG_POSITION_SEL).length){ 
        $(C_ERROR_DIALOG_POSITION_SEL).prepend(C_PAGE_ERROR_TEMPLATE);
      }
      else{
        $(C_ERROR_REGION_POSITION_SEL).prepend(C_PAGE_ERROR_TEMPLATE);
      }
    }
  };

  
  /**
   * Method iterates over all errors from errorList, removes existing error messages for any of the items
   * which are marked as firing items by this roundtrip and adds new errors contained in the errorList.
   * If the page item that has received an error is placed in a tabular region, a marker is added to the tab of that region
   * to indicate that this tab contains an erroneus page item.
   * @param {errorList} Error list
   * @private
   */
  function setErrors(errorList) {
    
    if (errorList.count > 0){
      apex.debug.log(`Anzahl Fehler PlugIn: ${errorList.count}`);

      createErrorRegion();
      
      // show any error
      $.each(errorList.errors, function() {
        var itemID = this.item;
        var $item = $(`#${this.item}`);
        var itemLabel = $(`#${itemID}_LABEL`).text();
        var linkTarget;
        var linkText;
        
        // Show inline error
        $item
        .addClass(C_APEX_ERROR_CLASS)
        .siblings('span').remove();
        $item.parent().append(`<span class='t-Form-error'>${this.message}</span>`);
        
        // Update error region, including link to page item
        linkTarget = `javascript: apex.item('${itemID}').setFocus();void(0);`;
        linkText = `Gehe zu Fehler: <span class='ek-itemLabelText'>${itemLabel}</span>`;
        
        // If page item is placed within a tabular region, add marker to the tab
        var $carousel = $item.closest(C_CAROUSEL_SEL);
        if ($carousel.length){
          var carouselId = $carousel.attr('id');
          var carouselName = $carousel.children('div[data-label]').data('label');
          $(`a.a-Region-carouselLink[href="#${carouselID}"]`).addClass(C_CAROUSEL_ERROR_CLASS);
          linkTarget.replace('javascript: ', `javascript: $("a.a-Region-carouselLink[href='#${carouselId}']").click();`);
          linkText += ` im Register: ${carouselName}`;
        }
        
        // Add error message
        $(C_ERROR_UL_SEL).append(`<li class='htmldbStdErr ${itemID}'>${this.message} (<a href=${linkTarget}>${linkText}</a>)</li>`);
	    });
    };
  };  

  
  /** 
   * Method submits page with the given request if no errors are on the page
   * @param {string} request Request for the server
   * @param {string} message Alert message warning the user if submit couldn't be executed due to errors on page
   * @public
   */
  adc.submitPage = function(request, message){
    if ($(C_APEX_ERROR_CLASS_SEL).length == 0) {
      apex.submit(request);
    }
    else{
      alert(message);
    }
  };
  
  
  /**
   * Controls the mandatory status of a page item
   * @param {string} item Page item ID of the item to set mandatory or optional
   * @param {boolean} mandatory Flag to set a page item mandatory (true) or optional (false)
   * @public
   */
  adc.setFieldMandatory = function(item, mandatory){
    var $mandatoryItem = $(`#${item}_LABEL`);
    // clean any existing mandatory markup upfront
    $mandatoryItem.siblings(C_REQUIRED_SPAN_SEL).remove();
    
    if(mandatory){
      $mandatoryItem.parent().append(C_FIELD_REQUIRED_TEMPLATE);
    }
  };
  
  
  /**
   * Maintains the error list on the page
   * @param {errorList} List of errors
   * @public
   */
  adc.maintainErrors = function(errorList){
    if (errorList.firingItems != '' || errorList.firingItems != ''){      
      removeErrors(errorList);
      setErrors(errorList);
      setMessage();
    }
    else {
      if ($(C_ERROR_CLASS_SEL).length > 0){
        // On page load we try to find any existing errors and enrich them with IDs of the referenced items
        // If those errors are present, they can only be created by the render process of APEX
        $(`${C_ERROR_CLASS_SEL} li.htmldbStdErr a`).each(function(){
          var itemLink = $(this).attr('href');
          var itemName = itemLink.match('apex.item(.*).setFocus')[1].replace(/('\(\))/g, '');
          $(this).closest('li').addClass(itemName);
        });
      };
    };
  };
  
  
  /**
   * Shows a message on the page
   * @param {string} message Message text to show
   * @public
   */
  adc.setNotification = function(message){
    adc.clearNotification;
    createErrorRegion();
    $(C_MESSAGE_TITLE_SEL).text(message);    
    $('.t-Button--closeAlert').on('click', adc.clearNotification);
  };
  
  
  /**
   * Shows a confirmation dialog to the user before calling the intended rfunctionality
   * @param {event} e Event that was raised by the user
   * @param {callback} callback Method to be called if the user confirmes this dialog
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
   * @param {string} itemId ID of the page item to disable
   * @public
   */
  adc.disableElement = function (itemId){
    // Normales Element, nicht deaktivieren, da ansonsten Sessionstate nicht gefüllt wird.
    // Stattdessen readonly und CSS-Klasse setzen, so dass es wie deaktiviert aussieht
    var $this = $(`#${itemId}`);
    $this.prop('readonly', true).addClass('adc-disabled');

    if ($this.is('select')){
      // Select-Liste, deaktiviere alle Einträge außer dem gewählten
      $(`#${itemId}:not(:selected)`).prop('disabled', false);
    }
    else if ($this.is('button')){
      // Button, wird »normal« aktiviert
      apex.item(itemId).disable();
    }
    else if ($this.is('input')){
      apex.item(itemId).disable();
    };
    apex.item(itemId).show();
  };
  
  
  /**
   * Enables a page item. Handles deactivation of 
   * - page items with values to allow to include them in a submit
   * - select lists
   * - buttons
   * @param {string} itemId ID of the page item to disable
   * @public
   */
  adc.enableElement = function (itemId){
    var $this = $(`#${itemId}`);
    $this.prop('readonly', false).removeClass('adc-disabled');

    if ($this.is('select')){
      $(`#${itemId}:not(:selected)`).prop('disabled', false);
    }
    else if ($this.is('button')){
      apex.item(itemId).enable();
    }
    else if ($this.is('input')){
      apex.item(itemId).enable();
    };
    apex.item(itemId).show();
    apex.item(itemId).enable();
    
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
   * Removes all messages in the notification region
   * @public
   */
  adc.clearNotification = function(){
    $(`${C_ERROR_CLASS_SEL} ${C_APEX_NOTIFICATION_ID_SEL}`).parent().remove();     
  };
  
  
  /**
   * Removes filter area from interactive report
   * @param {string} region static id of the interactive report
   * @public
   * @override
   */
  adc.hideFilterPanel = function(id){
    $(`#${id}_conrol_panel`).hide();
    $(`#${id} tr`).attr('style', 'vertical-align:top');
  };
  
  
  /**
   * Seet the label of a page item
   * @param {string} itemId ID of the page item to set the label of
   * @param {string} label  New item label
   * @public
   * @override
   */
  adc.setItemLabel = function(itemID, label){
	  $(`#${itemID}_LABEL`).text(label);
  };
  
})(de.condes.plugin.adc.apex_42_5_0);



de.condes.plugin.adc.apex_42_5_1 = Object.create(de.condes.plugin.adc.apex_42_5_0);
/**
 * IIFE for Version 5.1, Theme 42
 * @namespace de.condes.plugin.adc.apex_42_5_1
 * @since 5.1
 * @desc
 * Main difference in version 5.1 is that the APEX team changed the validation process to an AJAX-based approach because of the
 * invention of editable grids. As a consequence, the error regions are now present on the page upon normal rendering and need not
 * to be included by this logic. Additionally, APEX 5.1 offers a new apex.message namespace, making the notification process even easier.
 * @param {Object} adc Namespace object to adopt ADC to the given APEX version and theme
 * @param {apex.message} New message object provided by APEX
 */
(function(adc, msg){

  var C_APEX_ERROR_CLASS_SEL = 'div.a-Notification--error';

  /**
   * Maintain errors
   * @param {errorList} errorList List of errors
   * @override
   */
  function setErrors(errorList) {

    // Map errors to apex.message.errorObject
    apex.debug.log(`Anzahl Fehler PlugIn: ${errorList.count}`);
    msg.clearErrors();
	
    if (errorList.errors.count > 0){
      msg.showErrors(errorList.errors);
    }
  };

  /** 
   * Method submits page with the given request if no errors are on the page
   * @param {string} request Request for the server
   * @param {string} message Alert message warning the user if submit couldn't be executed due to errors on page
   * @public
   * @override
   */
  adc.submitPage = function(request, message){

    if ($(C_APEX_ERROR_CLASS_SEL).length == 0) {
      apex.page.submit({
        "request" : request,
        "showWait" : true
      });
    }
    else{
      msg.alert(message);
    }
  };
  
  
  /**
   * Controls the mandatory status of a page item
   * @param {string} item Page item ID of the item to set mandatory or optional
   * @param {boolean} mandatory Flag to set a page item mandatory (true) or optional (false)
   * @public
   * @override
   */
  adc.setFieldMandatory = function(item, mandatory){

    var $mandatoryItem = $(`#${item}_CONTAINER`);
    var C_REQUIRED_CLASS = 'is-required';

    $mandatoryItem.removeClass(C_REQUIRED_CLASS);
    
    if(mandatory){
      $mandatoryItem.addClass(C_REQUIRED_CLASS);
    }
  };
  
  
  /**
   * Maintains the error list on the page
   * @param {errorList} List of errors
   * @public
   * @override
   */
  adc.maintainErrors = function(errorList){
    msg.clearErrors()
    if(errorList.count > 0){
      msg.showErrors(errorList.errors);
    }
  };
  
  
  /**
   * Shows a message on the page
   * @param {string} message Message text to show
   * @public
   * @override
   */
  adc.setNotification = function(message){
    msg.hidePageSuccess();
    msg.showPageSuccess(message);
  };
  
  
  /**
   * Removes all messages in the notification region
   * @public
   * @override
   */
  adc.clearNotification = function(){
    msg.hidePageSuccess();
  };
  
  /**
   * Removes filter area from interactive report or interactive grid
   * @param {string} region static id of the interactive report or grid
   * @public
   * @override
   */
  adc.hideFilterPanel = function(id){
    $(`#${id}_conrol_panel`).hide(); // interactive report
    $(`#${id}_ig_report_settings`).hide(); // interactive grid
  };

})(de.condes.plugin.adc.apex_42_5_1, apex.message);


de.condes.plugin.adc.apex_42_20_2 = Object.create(de.condes.plugin.adc.apex_42_5_1);
/**
 * IIFE for Version 18.2, Theme 42
 * @namespace de.condes.plugin.adc.apex_42_20_2
 * @since 5.1
 * @desc
 * 
 * @param {Object} adc Namespace object to adpot ADC to the given APEX version and theme
 * @param {apex.message} New message object provided by APEX
 */
(function(adc, msg){

})(de.condes.plugin.adc.apex_20_2, apex.message);