begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^ADC Plugin messages^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => '_ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_ACTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Command/Link^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript or PL/SQL command, alternatively reference^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_RADIO_GROUP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Option group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Select list, radio buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_TOGGLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Toggle (YES/NO)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page commands^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items of the application^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_COMMAND',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic pages that have page commands^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Only existing page commands are displayed^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DATE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (date)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items that contain a date^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^The action is not assigned to a specific page element^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ENABLE_DISABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page items that can be activated and deactivated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items that can be activated and deactivated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FOCUSABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can receive a focus^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can receive a focus^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FORM_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Form region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Region used as form (no Editable Grid)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items or jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_MODAL_DIALOG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Modal application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^The application page is displayed as a modal dialog^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_NONE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^No page items^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_NUMBER_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (number)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items containing a number^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page items of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items of the application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All buttons of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All buttons of the actual application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page element or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Allows you to select a page element or specify a jQuery selector to select multiple page elements.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>All application and page elements of the current application page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All input fields or no specific entry^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items or jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regions of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All regions of the actual application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_REFRESHABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can be updated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can be updated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_SELECTABLE_REPORT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Reports that can report a selected row^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Reports that can report a selected row^'
  );  

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_APEX_ACTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>existing page commands of the rule group.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_EVENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Additional JavaScript events^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of JavaScript events that can be monitored by ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL function or package function<br>No need to specify a terminating semicolon.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_ITEM_STATUS',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Display status^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Option to display a page element on the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Java Script expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executable JavaScript expression, no function definition</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>name of a JavaScript function or anonymous function definition/IIFE</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JQUERY_SELECTOR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery expression to handle multiple elements. If this parameter is used, <code>DOCUMENT</code> must be entered as the outgoing element.</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>page item or region of the current page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PIT_MESSAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Identifier of a PIT message in the form msg.NAME or 'NAME', must be an existing message.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PROCEDURE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL procedure^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL procedure or package procedure<br>No need to specify a terminating semicolon.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SEQUENCE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Sequence^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>name of an existing sequence</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SQL_STATEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^SQL statement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executable SELECT-statement, no semicolon required.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Simple character string.<br>The character string is surrounded by quotation marks, so it is not necessary to enter these characters.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If the value is passed with single quotation marks, it is output as constant text.<br>If the parameter is passed without quotation marks, it is interpreted as a PL/SQL function that returns a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or JavaScript-expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Can contain the following values:</p><ul><li>A constant. It must be enclosed in quotation marks or be a number</li><li>A JavaScript expression that is calculated at runtime</li><li>Empty string. In this case the value of the session state is used (this can be calculated in advance)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_PIT_MESSAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If not enclosed with quotation marks, a PIT message name of the form msg.NAME</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SUBMIT_TYPE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Submit and/or validation^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Page forwarding types</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SWITCH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Truth value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_CONTROL_LIST',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Check box^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used to select multiple options.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_SELECT_LIST',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for selecting a calculated set of options.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_STATIC_LIST',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Static selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for selecting a given set of options.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_SWITCH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for the Yes/No or On/Off decisions.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_TEXT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Text field^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for shorter free texts.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_TEXT_AREA',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Text area^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for large amounts of text.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Confirmation request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the confirmation prompt to be displayed before the button is executed. Can be either a message text (then enter it with quotation marks), or a message name.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog box title^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Specify which title should be displayed in the confirmation request dialog box.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional specification of a page command. If an entry is selected, this command is executed after positive confirmation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_DYNAMIC_JAVASCRIPT_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL function that outputs a JavaScript statement.<br>Use without "javascript:", output only the JavaScript code.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_EXECUTE_COMMAND_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of page commands defined for this page.&nbsp;</p><p>You can create your own page commands in the "Page Commands" tab in ADC Designer and then use them here.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_EXECUTE_JAVASCRIPT_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>JavaScript code that is to be executed. Please use double quotes to avoid problems when submitting the code. No complex expressions should be executed, but preferably function names with parameters.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name of the page element where the REPORT selection should be stored. If this parameter is not set, the SELECTION_CHANGED event is triggered and the primary key value is returned to ADC as EVENT_DATA content.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ordinal number of the value column^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>1- based ordinal number of the column to be stored in the deposited element. The order will be based on the order on the APEX application page.</p><p>If this value is not specified, the column will be used which has been parameterized as primary key column on the APEX application page. Please note that currently only one primary key column is supported.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Error message can be passed optionally, otherwise a default message is used.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionally sets the display status. If the element is made mandatory, this parameter has no effect, the element will be displayed in any case. If the element is made optional, it is possible to specify here whether the element should be active, deactivated or hidden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_OPTIONAL_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls the display status of the element. If a field is made optional, it can also be hidden or disabled.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_MONITOR_EVENT_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of stored JavaScript events that can be additionally monitored by ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOTIFY_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The message text</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^List of page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte mindestens ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form <span style="font-family:'Courier New', Courier, monospace;">MSG.[Meldungsname]</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_PLSQL_CODE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL code to be executed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REFRESH_AND_SET_VALUE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Value to be set.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REMEMBER_PAGE_STATE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Array of the input fields^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional array of the IDs of the input fields whose status is to be captured. If this parameter is empty, all visible input fields will be captured. This parameter can be used to limit the list of input fields to be captured.</p><p>The parameter expects a JSON array of the form ["P1_ENAME", "P1_JOB"...] without surrounding apostrophes or curly braces.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_REGION_ENTRY_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ID of the row^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>ID of the row to be selected. Can be e.g. #EVENT_DATA# if the ID is supplied via an observation of a region.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_TAB_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ID of the tabulator region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the ID of the region containing the tab entry here.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the mode of submission. A combination of Validate and Submit can be selected.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>References a message if the validation failed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ELEMENT_FROM_STMT_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>SQL statement that returns one or more values<br>The column identifiers must correspond to element names, the query results are set in the associated page elements.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The element value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls how the page element should be displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_MODAL_DIALOG_TITLE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Tiel^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Title to be displayed on the modal dialog.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_REGION_CONTENT_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^HTML code^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>HTML code to be used as the content of the region.</p><p>Used mainly from PL/SQL to be able to have the new content calculated by a PL/SQL procedure.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_VISUAL_STATE_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the display status of the page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_ERROR_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Error message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the error message here. This can also be determined by a PL/SQL function.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to be displayed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements to be shown.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to be hidden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements that should be hidden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_WARN_BEFORE_CLICK_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Warning^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message text displayed if unsaved changes exist on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^List of page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen, oder alle Werte müssen leer sein, falls der Schalter “<i>Null ist erlaubt</i>” gesetzt ist.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be output if the check fails. Must be a PIT message name, in the form <span style="font-family:'Courier New', Courier, monospace;">MSG.[Message name].</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zero is allowed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Defines whether no value may be included or not.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ADC',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Generic actions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for input fields^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_JAVA_SCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript methods and events^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for all page element^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_PL_SQL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^PL/SQL methods^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_REPORT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Reports^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for reports (classic and interactive)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CANCEL_MODAL_DIALOG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^break modal dialog^',
    p_pti_display_name => q'^<p><strong>cancel dialog</strong> #ITEM|"|" |#</p>^',
    p_pti_description => q'^<p>Cancels the display of the modal dialog. If several modal windows are used overlapping, the triggering element must be specified.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONFIRM_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^confirm button action^',
    p_pti_display_name => q'^<p><strong>confirm button action</strong> for &nbsp;“#ITEM#”</p>^',
    p_pti_description => q'^<p>Ensures that a confirmation message is shown when a button is clicked.<br>Only when this request is confirmed is the event reported to ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DYNAMIC_JAVASCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^calculate JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Executes the calculated JavaScript on the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_COMMAND',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute page command^',
    p_pti_display_name => q'^<p><strong>execute page command</strong> "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Executes a page command. This action type ensures that a page command is executed recursively within the database. Page commands without reference to a page element, such as a button, can only be executed via this function (or via custom JavaScript on the page).</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_JAVASCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute JavaScript code^',
    p_pti_display_name => q'^<p><strong>execute JavaScript code</strong> "#PARAM_1#".</p>^',
    p_pti_description => q'^<p>Executes the entered JavaScript code on the application page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_GET_REPORT_SELECTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^determine selected line^',
    p_pti_display_name => q'^<p><strong>determine</strong> #PARAM_2|<strong>column </strong>||<strong>primary key</strong># of report “#ITEM#” and #PARAM_1|store ID <strong>at field</strong> “|”|report ID to ADC#</p>^',
    p_pti_description => q'^<p>Stores the currently selected row IDs in the specified field if an element is specified, or reports the key value to ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_REPORT_FILTER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hide filter bank^',
    p_pti_display_name => q'^<p><strong>Hide filter bank</strong> of IR/REPORT “#ITEM#”</p>^',
    p_pti_description => q'^<p>Hides the filter bank of Interactive Report/Grid.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_INITIALIZE_FORM_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^initialize form^',
    p_pti_display_name => q'^<p><strong>initialize form</strong> #PARAM_1#</p>^',
    p_pti_description => q'^<p>Analyzes the data source of a form region and initializes the current data.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_MANDATORY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^make field mandatory^',
    p_pti_display_name => q'^<p><strong>make </strong>#PARAM_2|<strong>xelector </strong>“||<strong>field </strong>“^ITEM^#” <strong>mandatory</strong></p>^',
    p_pti_description => q'^<p>Makes a page element a mandatory field incl. validation. A mandatory field is always also made visible and active to allow user input.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_OPTIONAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^makes field optional^',
    p_pti_display_name => q'^<p><strong>make </strong>#PARAM_2|<strong>selector </strong>“||<strong>field </strong>“^ITEM^#” <strong>optional</strong></p>^',
    p_pti_description => q'^<p>Makes a page element optional and sets mandatory field validation off.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_MONITOR_EVENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Watch event^',
    p_pti_display_name => q'^<p><strong>watches event</strong> “#PARAM_1#” on page item “#ITEM#” and #PARAM_2|<strong>execute function</strong> “|”|<strong>report event</strong> to ADC#</p>^',
    p_pti_description => q'^<p>The action type integrates an additional event handler for events that are not monitored by ADC by default on the selected page element.</p><p>Through this action type it is possible to react to special events, like closing a modal dialog or pressing the <span style="font-family:'Courier New', Courier, monospace;">ENTER</span> key. If no JavaScript function is specified, ADC is informed about the event. In this case, the corresponding pseudocolumn contains the ID of the triggering element. When closing a modal dialog, care must be taken that the page element specified here receives the event. This is ensured via a parameter when generating the URL.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOOP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^do nothing^',
    p_pti_display_name => q'^<p><strong>do nothing</strong>.</p>^',
    p_pti_description => q'^<p>This action type allows to formulate a technical condition where nothing else should happen. Sometimes this is useful if, for example, a more specific case should do nothing, but a more general case should. In this case, a use case for the more specific case would only be considered if an action is also stored, and this would then be "do nothing".</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOTIFY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^show hint^',
    p_pti_display_name => q'^<p><strong>show hint </strong>“#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Shows a message on the application page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_NULL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^choose at least one value^',
    p_pti_display_name => q'^<p>choose at least one value</strong> of “#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Ensures that at least one of the elements from attribute "<i>List of page elements</i>" contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_PLSQL_CODE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute PL/SQL code^',
    p_pti_display_name => q'^<p><strong>run PL/SQL code</strong> “#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Executes the PL/SQL code passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_RAISE_ITEM_EVENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute use case^',
    p_pti_display_name => q'^<p><strong>execute use cases </strong> of field “#ITEM#”</p>^',
    p_pti_description => q'^<p>Triggers the associated event on the specified page element and ensures the processing of the associated rules</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_AND_SET_VALUE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^refresh page item and set value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Updates a page element and sets the field to session state</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^refresh target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>initiates APEX-refresh on the referenced page item.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_OBSERVER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^observe page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Action observes a field or class and registers the elements so that the corresponding element values are copied to the session state at each event on the page.<br>Required only if no ADC rule contains this item or class.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REMEMBER_PAGE_STATE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^save page status^',
    p_pti_display_name => q'^<p><strong>save page status</strong></p>^',
    p_pti_description => q'^<p>Remembers the current value of the input fields to be monitored. This action type is needed to dynamically detect changes to the page and give a warning message when leaving or overwriting the currently captured values.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SELECT_REGION_ENTRY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^select row in report^',
    p_pti_display_name => q'^<p><strong>select row</strong> ‘#PARAM_1#' <strong>in report</strong> #ITEM#</p>^',
    p_pti_description => q'^<p>Selects a row in a report (classic, interactive region or interactive grid) or a tree.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SELECT_TAB',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^activate tab^',
    p_pti_display_name => q'^<p><strong>activate tab<strong> #ITEM#</p>^',
    p_pti_description => q'^<p>Makes a tab active in a tab widget.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SEND_VALIDATE_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^request processing of the page^',
    p_pti_display_name => q'^<p><strong>request processing of the page</strong> in mode “#PARAM_1#”. #PARAM_2| Request: ||#</p>^',
    p_pti_description => q'^<p>Validates and/or submits the page.</p><p>The mode determines which actions are performed. If the page is to be validated, a message text can be defined which will be displayed in case of an unsuccessful validation. If this message is omitted, only the error messages of the validation logic are displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ELEMENT_FROM_STMT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set element value with SQL statement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets an element value based on an SQL statement that returns a single value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_FOCUS',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set focus in page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>set focus in input field of the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set page item to value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page item to the value passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM_LABEL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set field label^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the label of the referenced page element to the value passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_MODAL_DIALOG_TITLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set title of the modal dialog^',
    p_pti_display_name => q'^<p><strong>set title of the modal dialog</strong> to “#PARAM_1#”.</p>^',
    p_pti_description => q'^<p>Sets the title of a modal dialog to the desired value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_VISUAL_STATE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set the visibility of an element^',
    p_pti_display_name => q'^<p><strong>set the visibility of element</strong> “#ITEM#” <strong> to </strong>“#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Controls visibility (<span style="font-family:'Courier New', Courier, monospace;">SHOW/HIDE</span>) and status (<span style="font-family:'Courier New', Courier, monospace;">ENABLED/DISABLED</span>) of a page element. Only meaningful combinations are possible.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ERROR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^show error^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Shows the error message passed as parameter on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_HIDE_ITEMS',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^hide and show side elements^',
    p_pti_display_name => q'^<p><strong>show</strong> page items "#PARAM_1#” <strong>and hide page items</strong> '#PARAM_2#".</p>^',
    p_pti_description => q'^<p>Controls the display of multiple page elements by showing the page elements identified by the first jQuery expression and hiding the page elements identified by the second jQuery expression.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_STOP_RULE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^stop rule^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Terminates the currently running rule and does not allow recursive execution of further rules.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_WARN_BEFORE_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^warn on suaved changes^',
    p_pti_display_name => q'^<p><strong>warn on suaved changes</strong> before executing the action</p>^',
    p_pti_description => q'^<p>Provides a check before triggering a button that shows a warning if unsaved changes exist on the page. Requires that the current page state has been saved in advance with "save current page state".</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^choose exactly one value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Makes sure that exactly one of the elements from attribute 1 contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR_NN',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^select exactly one value, NOT_NULL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Makes sure that exactly one of the elements from attribute 1 contains a value. NULL is not allowed</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_ADCSELECTIONCHANGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Selection changed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERCANCELDIALOG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog canceled^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERCLOSEDIALOG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog closed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERREFRESH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Refresh completed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_CHANGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Change^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Click^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_COMMAND',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_DBLCLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Double click^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_ENTER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter key^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialization^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_AFTER_REFRESH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^After refresh^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_APP_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Application item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_COMMAND',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Apge command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DATE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (date)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DIALOG_CLOSED',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog closed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOCUMENT_MODAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Modal dialog^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOUBLE_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Double click^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ENTER_KEY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter key^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_EVENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FIRING_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Firing Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FORM_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Form region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INITIALIZING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialize Flag^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INTERACTIVE_GRID_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INTERACTIVE_REPORT_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Report^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_NUMBER_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (number)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_REPORT_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Classic Report^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ROWID_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Row ID^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_SELECTION_CHANGED',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Row selected in report^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_TREE_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hierarchy^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_NO_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No help available, please select an action type.^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRG_REGION_HEADING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Rule overview »#1#« (#2#)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_INITIAL_RULE_NAME',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^opens the page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Name of the initially created use case^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_A_SHOW_ENABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^visible and active^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_B_SHOW_DISABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^visible but deactivated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_C_HIDE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^hidden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_PAGE_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_A_VALIDATE_AND_SUBMIT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Validate and forward page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_B_VALIDATE_ONLY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Validate page, do not forward^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_C_SUBMIT_ONLY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Do not validate page, but forward it^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SELECT_LIST',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for selecting a calculated set of options.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_STATIC_LIST',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Static selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for selecting a given set of options.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SWITCH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for the Yes/No or On/Off decisions.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Text field^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for shorter free texts.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT_AREA',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Text area^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for large amounts of text.^'
  );

  commit;
end;
/