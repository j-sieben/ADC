// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};
de.condes.plugin.adc.base_renderer = de.condes.plugin.adc.base_renderer || {};
de.condes.plugin.adc.apex_theme_42 = Object.create(de.condes.plugin.adc.base_renderer);

/**
 * ADC base renderer plus Theme 42 specializations.
 *
 * `baseRenderer` contains the stable renderer contract shared by all concrete
 * renderers. `renderer` inherits from it and overrides Theme- and
 * APEX-version-specific behavior only.
 *
 * @param {Object} adc ADC namespace.
 * @param {Object} baseRenderer Shared renderer defaults.
 * @param {Object} renderer Renderer namespace object.
 * @param {Object} msg `apex.message` facade.
 */
(function(adc, baseRenderer, renderer, msg){
  const C_FILE_NAME = 'adc.js.renderer.js';

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
  const C_BUTTON_FOCUS_SELECTOR = '.t-Body-main button.t-Button, .t-Dialog button.t-Button';
  const C_BUTTON_SELECTOR = 't-Button';
  const C_REGION_NO_DATA_MSG_SELECTOR = '.a-IRR-noDataMsg-text';

  // Attribute constants
  const C_READONLY_PROP = 'readonly';
  const C_DISABLED_PROP = 'disabled';

  // Event constants
  const C_IG_SELECTION_CHANGE = 'interactivegridselectionchange';
  const C_TREE_SELECTION_CHANGE = 'treeviewselectionchange';
  const C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  const C_CLICK = 'click';
  
  // private class selector
  const C_REPORT_LAST_REFRESH_TIME_CLASS = 'adc-last-refresh-time';
  const C_REPORT_LAST_REFRESH_TIME_CLASS_SELECTOR = `.${C_REPORT_LAST_REFRESH_TIME_CLASS}`;


    /**
     * Set focus to a selector or item ID if it exists.
     *
     * @param {string} pSelector Selector or item ID.
     */
    setFocus = function(pSelector){
        const anchors = ['.', '#'];
        if ($.trim(pSelector).length !== 0) {
            if (!anchors.includes($.trim(pSelector).charAt(0))){
                pSelector = `#${pSelector}`;
            }
            $(pSelector).focus();
        };
    }; //setFocus

    /**
     * Keep report cells vertically aligned to the top.
     *
     * @param {string} pReportId Report region ID.
     */
    baseRenderer.alignReportVerticalTop = function(pReportId){
        var $report = $(`#${pReportId}`);
        if ($report.length > 0){
            $report.find('td').addClass('u-alignTop');
            // also add function call after refresh to keep the state
            $report.on(C_APEX_AFTER_REFRESH, function(){
                renderer.alignReportVerticalTop(pReportId);
            });
        }
    }; // alignReportVerticalTop
    
    
    /**
     * Extract a dialog options object from a raw options object or event wrapper.
     *
     * @param {Object} pOptions Options object or event wrapper.
     * @returns {Object}
     */
    function getOptions(pOptions){
      let options;
      if (adc.utils.isNotEmpty(pOptions.data)){
        options = pOptions.data.options;
      } else {
        options = pOptions;
      }
      return options;
    }

    /**
     * Determine the supported ADC region type for a region container.
     *
     * This logic is APEX- and DOM-specific and therefore belongs in the
     * renderer layer rather than the action facade.
     *
     * @param {string} pRegionId Region ID.
     * @returns {string|undefined} One of the supported region type constants.
     */
    renderer.getRegionType = function(pRegionId){
        const $report = $(`#${pRegionId}`);
        const crSelector = `#report_table_${pRegionId}`;
        const irSelector = `#${pRegionId}_ir`;
        const igSelector = `#${pRegionId}_ig`;
        const treeSelector = `#${pRegionId}_tree`;
        const tabSelector = `#SR_${pRegionId}`;
        let reportType;

        if($report.find(igSelector).length > 0){
            reportType = C_REGION_IG;
        }
        else if($report.find(irSelector).length > 0){
            reportType = C_REGION_IR;
        }
        else if($report.find(crSelector).length > 0){
            reportType = C_REGION_CR;
        }
        else if($report.find(treeSelector).length > 0){
            reportType = C_REGION_TREE;
        }
        else if($report.parent(tabSelector).length > 0){
            reportType = C_REGION_TAB;
        }

        return reportType;
    };


    /**
     * Clear all renderer-visible ADC and APEX error markup.
     */
    baseRenderer.clearErrors = function(){
        msg.clearErrors();
    }; //clearErrors


    /**
     * Clear page-level success notifications.
     */
    baseRenderer.clearNotification = function(){
        msg.hidePageSuccess();
    }; // clearNotification


    /**
     * Show a confirmation dialog before executing a callback.
     *
     * @param {Object} pEvent Event or options wrapper.
     * @param {function} pCallback Callback executed on confirmation.
     * @param {string} pFocusItem Item to focus if the dialog is cancelled.
     */
    baseRenderer.confirmRequest = function(pEvent, pCallback, pFocusItem){
      const options = getOptions(pEvent);

      apex.message.confirm(options.message, function (pAnswer) {
          if (pAnswer){
              pCallback(pEvent);
          }
          else {
              setFocus(pFocusItem);
          };
      }, options);
      renderer.setModalDialogTitle(options.title);
    }; // confirmRequest


    /**
     * Decorate UI controls maintained by `apex.actions`.
     *
     * @param {Object} pAction APEX action object.
     * @param {*} pArgs Optional arguments from APEX.
     */
    baseRenderer.decorateApexAction = function (pAction, pArgs){
        let $buttons, accesskey, shortcuts, shortcut;

        // decorate button access key
        shortcuts = apex.actions.listShortcuts();
        shortcut = shortcuts.filter(function(shortcut){
            return shortcut.actionName.indexOf(pAction.name) > -1;
        });
        if (shortcut.length > 0){
            shortcut = shortcut[0].shortcut;
            accesskey = shortcut.slice(-1);
            if (adc.utils.isNotEmpty(accesskey)){
                // Try to find buttons that are connected to this action
                $buttons = $(`[data-action='${pAction.name}']`);
                if(accesskey.length > 0){
                    $($buttons).each(function(){
                        highlightButtonAccessKey($(this), accesskey);
                        maintainButtonAccessTitle($(this), shortcut);
                    });
                }
            }
        }
    }; // decorateApexAction


    /**
     * Disable a page item while keeping its value available for submission.
     *
     * @param {string} pItemId Page item ID.
     */
    baseRenderer.disableElement = function (pItemId){
        const $item = $(`#${pItemId}`);
        const $container = $(`#${pItemId}_CONTAINER`);

        if ($container.length){
            $container.removeClass(C_APEX_DISABLED)
        };

        if ($item.length){
            let $itemLabel = $(`#${pItemId}_LABEL`);
            apex.item(pItemId).show();

            // Normal element, do not disable, otherwise session state will not be filled.
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

            // if the page item is a CKEDITOR, the built in APEX method can savely be used
            else if ($item.parent('div').find('div.ck').length){
                apex.item(pItemId).disable();
            }

            // if the page element is a date field, then also deactivate the button for the date selection
            else if ($item.hasClass("hasDatepicker") || $item.hasClass("color_picker") || $item.hasClass("popup_lov")) {
                $item.parent().find("button").prop(C_DISABLED_PROP, true);
            }

            else if ($item.hasClass(C_BUTTON_SELECTOR)){
                // Tastaturkuerzel deaktivieren
                $item.prop(C_DISABLED_PROP, true);
            }

            else if (($item.hasClass("radio_group")) || ($item.hasClass("checkbox_group"))){
                // einzelne Radiobuttons von Bearbeitung mit Tastatur ausschliessen
                $(`#${pItemId} input`).attr('disabled', '');
            }

            else if ($item.is("a-autocomplete")){
                $(`#${pItemId} input`).addClass(C_APEX_DISABLED);
            }
            
            else if ($item.is("a-date-picker")){
                $(`#${pItemId} input`).addClass(C_APEX_DISABLED);
                $item.parent().find("button").prop(C_DISABLED_PROP, true);
            };
        };
    }; // disableElement

  
    /**
     * Re-enable a previously disabled page item.
     *
     * @param {string} pItemId Page item ID.
     */
    baseRenderer.enableElement = function (pItemId){
        var $item = $(`#${pItemId}`);
        const $container = $(`#${pItemId}_CONTAINER`);

        if ($container.length){
            $container.removeClass(C_APEX_DISABLED)
        };
        
        $item
            .prop(C_READONLY_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('aria-disabled')
            .removeAttr('tabindex');

        if ($item.is('select')){
            $(`#${pItemId}:not(:selected)`)
            .prop(C_READONLY_PROP, false);
        }
        apex.item(pItemId).show();
        apex.item(pItemId).enable();

        // if page item has a button, enable button as well
        if ($item.hasClass("hasDatepicker") || $item.hasClass("color_picker")) {
            $item.parent().find("button")
            .prop(C_DISABLED_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('tabindex');
        }
        
        else if ($item.hasClass("color_picker")) {
            $(`#${pItemId}_fieldset`)
            .prop(C_READONLY_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('tabindex');
        }

        // if page item is a popup list, enable button as well
        else if ($item.hasClass("popup_lov")) {
            $item.closest(`#${pItemId}_fieldset`)
            .find(C_POPUP_LOV_SELECTOR)
            .prop(C_READONLY_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('tabindex');
            
            $item.parent().find("button")
            .prop(C_DISABLED_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('tabindex');
        }

        else if ($item.hasClass(C_BUTTON_SELECTOR)){
            // Tastaturkuerzel aktivieren
            $item.prop(C_DISABLED_PROP, false);
        }

        else if (($item.hasClass("radio_group")) || ($item.hasClass("checkbox_group"))){
            // einzelne Radiobuttons zur Bearbeitung mit Tastatur freigeben
            $(`#${pItemId} input`).removeAttr('disabled');
            $(`#${pItemId}`).removeClass(C_APEX_DISABLED);
        }
        
        else if ($item.is('a-autocomplete')){
            // fokussierbar machen
            $(`#${pItemId} input`).removeAttr('tabindex');
            $(`#${pItemId} input`).removeClass(C_APEX_DISABLED);
        }

        else if ($item.is("a-date-picker")){
            // fokussierbar machen
            $(`#${pItemId} input`).removeAttr('tabindex');
            $(`#${pItemId} input`).removeClass(C_APEX_DISABLED);
            // button behind
            $item.parent().find("button")
            .prop(C_DISABLED_PROP, false)
            .removeClass(C_ADC_DISABLED)
            .removeAttr('tabindex');
        };

;
    }; // enableElement
  

    /**
     * Hide filter UI for supported report types.
     *
     * @param {string} pRegionId Region ID.
     * @param {string} pRegionType Region type.
     */
    renderer.hideReportFilterPanel = function(pRegionId, pRegionType){
        switch(pRegionType){
            case C_REGION_IR:
                $(`#${pRegionId}_control_panel`).hide(); // interactive report
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
     * Visually highlight an action shortcut inside a button label.
     *
     * @param {jQuery} pButton Button element.
     * @param {string} pShortcut Shortcut key.
     */
    function highlightButtonAccessKey(pButton, pShortcut){
        const C_SHORTCUT_CLASS = 'adc-accesskey',
              C_BUTTON_LABEL_CLASS = 't-Button-label';

        let label, accesskey, re;
        let $label = pButton.find(`.${C_BUTTON_LABEL_CLASS}`);

        if(!$label[0]){
            pButton.html(`<span class='${C_BUTTON_LABEL_CLASS}'>${pButton.html()}</span>`);
            $label = pButton.find(`.${C_BUTTON_LABEL_CLASS}`);
        }

        label = $label.text();
        re = new RegExp(`(^| )${pShortcut}`, 'i')
        accesskey = re.exec(label);
        if (adc.utils.isEmpty(accesskey)){
            re = new RegExp(pShortcut, 'i');
            accesskey = re.exec(label);
        }
        if (adc.utils.isNotEmpty(accesskey)){
          if (accesskey.length > 1){
            label = label.replace(re, ` <span class='${C_SHORTCUT_CLASS}'>${accesskey[0].trim()}</span>`);
          }else {
            label = label.replace(re, `<span class='${C_SHORTCUT_CLASS}'>${accesskey[0]}</span>`);
          }
          pButton.attr('accesskey', pShortcut);
          $label.html(label);
        }
    }; // highlightButtonAccessKey
    

    /**
     * Highlight a selected report row and optionally move focus to it.
     *
     * @param {string} pRegionId Region ID.
     * @param {jQuery} pRow Selected row.
     * @param {boolean} pSetFocus Whether focus should move to the row.
     */
    baseRenderer.highlightRow = function(pRegionId, pRow, pSetFocus){
        if (pRow.length){
            pRow.siblings().removeClass("adc-selected-row");
            pRow.addClass("adc-selected-row");

            if (pSetFocus) {
                if (pRow.length > 0){
                pRow.find('td:first-child a').focus();
                }
                else {
                    let lastTriggeringElement = adc.controller.getLastTriggeringItem();
                    if (lastTriggeringElement != ''){
                        $(`#${lastTriggeringElement}`).focus();
                    }
                    else {
                        $(`${C_BUTTON_FOCUS_SELECTOR}`).first().focus();
                    };
                };
            }
        } else {
            const actTime = apex.date.format(new Date(), `HH24:MI:SS`);
            
            $(`#${pRegionId} ${C_REGION_NO_DATA_MSG_SELECTOR} ${C_REPORT_LAST_REFRESH_TIME_CLASS_SELECTOR}`).remove();
            $(`#${pRegionId} ${C_REGION_NO_DATA_MSG_SELECTOR}`).append(`<div class="${C_REPORT_LAST_REFRESH_TIME_CLASS}"><br>(letzte Aktualisierung um ${actTime})</div>`);
        };
    }; // highlightRow
    
    
    /**
     * Show an unchanged-data notification in modal and non-modal contexts.
     *
     * @param {Object} pOptions Event or options wrapper.
     * @param {string} pFocusItem Item to focus afterwards.
     */
    baseRenderer.informUnchanged = function (pOptions, pFocusItem){
        const isModalDialog = parent.$('.ui-dialog').length > 0;
        const options = getOptions(pOptions);
        let message  = options.message;
        if(isModalDialog){
            if(!message.includes(adc.utils.getStandardMessage('CSM_CLOSE_MODAL_DIALOG'))){
                options.message = message + adc.utils.getStandardMessage('CSM_CLOSE_MODAL_DIALOG');
            };
            const callback = function(){apex.navigation.dialog.cancel(true);};
            renderer.confirmRequest(pOptions, callback, pFocusItem);
        } else {
            renderer.showDialog('WARNING', options, pFocusItem);
        };      
    }; // informUnchanged


    /**
     * Add shortcut information to a button title attribute.
     *
     * @param {jQuery} pButton Button element.
     * @param {string} pShortcut Shortcut key.
     */
    function maintainButtonAccessTitle(pButton, pShortcut){
        // initially, set a data-title attribute to the title without any shortcut information
        if (adc.utils.isEmpty(pButton.attr('data-title'))){
            const label = pButton.attr('title');
            const end = label.indexOf(`, ${pShortcut}`);
            if (end > 0){
              label = label.substring(0, end);
            }
            pButton.attr('data-title', label);
        }
        pButton.attr('title', `${pButton.attr('data-title')}, (${pShortcut})`);
    }; // maintainButtonAccessTitle

  
    /**
     * Render the current ADC error list using APEX error markup.
     *
     * @param {Object[]} pErrors Error entries.
     */
    baseRenderer.showErrors = function(pErrors){
        
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
     * Set the label text of a page item.
     *
     * @param {string} pItemId Page item ID.
     * @param {string} pItemLabel New label text.
     */
    baseRenderer.setItemLabel = function(pItemId, pItemLabel){
        if (adc.utils.isNotEmpty(pItemId)){
            $(`#${pItemId}_LABEL`).text(pItemLabel);
        };
    }; // setItemLabel

    
    /**
     * Toggle the mandatory styling of a page item.
     *
     * @param {string} pItemId Page item ID.
     * @param {boolean} pIsMandatory Whether the item is mandatory.
     */
    baseRenderer.setItemMandatory = function(pItemId, pIsMandatory){
        var $mandatoryItem = $(`#${pItemId}`);

        if ($mandatoryItem.length){
            $mandatoryItem.removeClass(C_REQUIRED_CLASS);

            if(pIsMandatory){
                $mandatoryItem.addClass(C_REQUIRED_CLASS);
            }
        }
    }; // setItemMandatory


    /**
     * Set the title of the current modal dialog.
     *
     * @param {string} pTitle Dialog title.
     */
    baseRenderer.setModalDialogTitle = function(pTitle){
        parent.$(C_MODAL_DIALOG_TITLE_SELECTOR).last().html(pTitle);
    }; // setModalDialogTitle


    /**
     * Show a renderer-managed dialog or page success message.
     *
     * @param {string} pStyle Dialog style.
     * @param {Object} pOptions Dialog options.
     * @param {string} pFocusItem Item to focus after closing.
     */
    baseRenderer.showDialog = function(pStyle, pOptions, pFocusItem){
      let options = getOptions(pOptions);
      
      if (adc.utils.isEmpty(pFocusItem)){
        pFocusItem  = $('.t-Body').find('input, button').not(':hidden').first().attr('id');
      };

      const callback = function(){
        setFocus(pFocusItem);
      };

      options.returnFocusTo = pFocusItem;
      options.callback = callback;
      switch (pStyle){
        case 'ALERT':
          options.style = 'error';
          msg.showDialog("" + options.message, options);
          break;
        case 'SUCCESS':
          msg.showPageSuccess(options.message);
          $('.t-Button--closeAlert').one('click', function(){
              setFocus(pFocusItem);
          });
          break;
        case 'WARNING':
          options.style = 'warning';
          msg.showDialog("" + options.message, options);
          break;
        case 'INFO':
          options.style = 'information';
          msg.showDialog("" + options.message, options);
          break;
      };
    }; // showDialog


    /**
     * Show a page-level success message.
     *
     * @param {string} pMessage Success message.
     */
    baseRenderer.showSuccess = function(pMessage){
        msg.showPageSuccess(pMessage);
    }; // showSuccess


    /**
     * Replace the content and accent styling of a static region.
     *
     * @param {string} pRegionId Region ID.
     * @param {string} pContent Region content.
     * @param {string} pHeader Region header.
     * @param {string} pCSS Accent class.
     */
    renderer.setRegionContent = function(pRegionId, pContent, pHeader, pCSS){
        const $region = $(`#${pRegionId}`);

        if ($region.length){
            $region.find(C_REGION_BODY_SELECTOR).html(pContent);
            $(`#${pRegionId}_heading`).html(pHeader);
            $region.removeClass (function (index, className) {
                return (className.match (/(^|\s)t-Region--accent\S+/g) || []).join(' ');
            });
            $region.addClass(pCSS);
        }
    }; // setRegionContent
  
  
    /**
     * Update the header of a plain or tab region.
     *
     * @param {string} pRegionId Region ID.
     * @param {string} pHeader Header text.
     * @param {string} pRegionType Region type.
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
     * Show or hide the APEX wait spinner.
     *
     * @param {boolean} pFlag Whether the spinner should be visible.
     */
    baseRenderer.showWaitSpinner = function(pFlag){
        if(pFlag){
            apex.util.showSpinner();
        }
        else{
            $("#apex_wait_overlay").remove();
            $(".u-Processing").remove();
        };
    }; // showWaitSpinner


    /**
     * Submit the page if no blocking errors are present.
     *
     * @param {string} pRequest Request value.
     * @param {string} pMessage Alert message shown if submission is blocked.
     */
    baseRenderer.submitPage = function(pRequest, pMessage){
        if ($(C_APEX_ERROR_CLASS_SEL).length == 0 && adc.utils.isEmpty(pMessage)) {
            apex.page.submit({
                "request" : pRequest,
                "showWait" : false
            });
        }
        else{
            msg.alert(pMessage);
        }
    }; // submitPage

})(de.condes.plugin.adc, de.condes.plugin.adc.base_renderer, de.condes.plugin.adc.apex_theme_42, apex.message);
