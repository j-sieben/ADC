set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^messages for the ADC plugin^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_SHOW_MESSAGE_CONFIRM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Confirmation message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Confirmation dialogue that must be confirmed with OK or CANCEL^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_SHOW_MESSAGE_ERROR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Error message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Error message displayed as an error on the element or document^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_SHOW_MESSAGE_INFO',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Information message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Information message displayed as pop-up dialogue^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_SHOW_MESSAGE_SUCCESS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^success message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Success message displayed as a floating message^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_SHOW_MESSAGE_WARN',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Warning message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Warning message displayed as an error on the element or document^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_ACTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^command/reference^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript or PL/SQL command, alternatively reference^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_RADIO_GROUP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^option group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^selection list, radio buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_TOGGLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^selector switch (YES|NO)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page commands^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements of the application^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_COMMAND',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic pages that have page commands^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Only existing page commands are displayed^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DATE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page element (date)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>All application and page elements of the current application page with date format masek</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^The action is not assigned to a specific page element^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ELEMENT_AND_FORM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements and form regions^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Page elements and form regions are displayed^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ENABLE_DISABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can be activated and deactivated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can be activated and deactivated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FOCUSABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can receive a focus^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can receive focus^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FORM_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Form region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Region used as form (no interactive grid)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page element or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements or a jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_MODAL_DIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Modal application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^The application page is displayed as a modal dialogue^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_NONE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^No page elements^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAIF_NUMBER_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page element (number)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>All application and page elements of the current application page with number format mask</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page elements of the current page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements of the current application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^buttons of the current page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All buttons on the current application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page element or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Enables the selection of a page element or the specification of a jQuery selector to select multiple page elements.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page_element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>All application and page elements of the current application page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^input field or document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All input fields or no specific information^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^input field or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All input fields or a jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regions of the current page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All regions of the current application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_REFRESHABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can be updated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can be updated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_SELECTABLE_REPORT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Reports that can report a selected line^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^reports that can report a selected line^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CANCEL_MODAL_DIALOG_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^triggering element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional specification of a page element that is to receive the apexaftercanceldialogue event. Only needs to be set if several modal dialogues are open or the element was not defined when it was called.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CANCEL_MODAL_DIALOG_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^check for change^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If set, this parameter checks whether there are any unsaved changes on the page. If yes, a confirmation dialogue is shown to close the dialogue anyway&nbsp;</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CLOSE_MODAL_DIALOG_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^triggering element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Element on which the event <span style="font-family:'Courier New', Courier, monospace;">apexafterclosedialogue&nbsp;</span>is to be triggered. Only needs to be specified if several modal windows are overlapping or if the triggering element was not specified when creating the link to open the modal window.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAP_CLOSE_MODAL_DIALOG_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Return elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Determines which element values are returned to the calling page when the modal dialogue is closed. The element values can be determined on the calling page via <span style="font-family:'Courier New', Courier, monospace;">adc_api.get_event_data</span>.</p><p>Element names must be transferred as a comma-separated character string. Example:<span style="font-family:'Courier New', Courier, monospace;"> "P5_EMP_ID", "P5_EMP_JOB_ID"</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CLOSE_MODAL_DIALOG_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^check for change^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If set, the action type checks whether input fields have been changed on the application page. If not, a message is displayed and the page is closed without saving.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^confirmation request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the confirmation prompt that is to be displayed before the button is executed. Inverted commas do not have to be included.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Title of the dialogue window^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Specify which title should be displayed in the confirmation request dialogue window.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional specification of a page command. If an entry is selected, this command is executed after positive confirmation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONTROL_MODAL_DIALOG_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Trigger event on^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Element on which the event <span style="font-family:'Courier New', Courier, monospace;">apexafterclosedialog</span>&nbsp;is to be triggered. Only needs to be specified if several modal windows are arranged overlapping or if the triggering element was not specified when creating the link to open the modal window.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONTROL_MODAL_DIALOG_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^check for change^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>defines whether the system should check for changes before closing. If there are no changes, a message is displayed and the data is not processed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_DYNAMIC_JAVASCRIPT_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL function that outputs a JavaScript statement.<br>Without using "javascript:", only output the JavaScript code</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_EXECUTE_COMMAND_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of page commands defined for this page&nbsp;</p><p>You can create your own page commands in the "Page commands" tab in the ADC Designer and then use them here.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_EXECUTE_JAVASCRIPT_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>JavaScript code to be executed. Please use double inverted commas to avoid problems when submitting the code. No complex expressions should be executed, but preferably function names with parameters.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name of the page element in which the IG selection is to be saved. If this parameter is not set, the SELECTION_CHANGED event is triggered and the primary key value is returned to ADC as EVENT_DATA content.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ordinal number of the value column^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>1- based ordinal number of the column to be stored in the stored element. The order depends on the order on the APEX application page.</p><p>If this value is not specified, the column that was parameterised as the primary key column on the APEX application page is used. Please note that only one primary key column is currently supported.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Error message can be passed optionally, otherwise a standard message is used.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionally defines the display status. If the element is made a mandatory field, this parameter has no effect; the element is displayed in any case. If the element is optional, you can specify here whether the element should be active, deactivated or hidden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_OPTIONAL_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_OPTIONAL_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls the display status of the element. If a field is made optional, it can also be hidden or deactivated.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_MONITOR_EVENT_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of stored JavaScript events that can also be monitored by ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_MONITOR_EVENT_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOTIFY_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOTIFY_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^message text^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Text of the message.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOTIFY_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^dialogue title^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Title of the dialogue window</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^list of page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Comma-separated list of element names or CSS classes that identify the fields that are combined into a group. Within this group, at least one field must have a <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span> value when checking the values.</p><p>A possible error message is displayed for the element that is selected as the page element for this action.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be displayed if the check fails. Must be a PIT message name in the form <span style="font-family:'Courier New', Courier, monospace;">MSG.[message name]</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_PLSQL_CODE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL code to be executed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REFRESH_AND_SET_VALUE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Value to be set.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REFRESH_ITEM_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^element value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If set, the value of the element is set to this value after updating. In the case of a region, the row that has the transferred element value as a key value is selected.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REFRESH_ITEM_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set focus^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls whether the element receives the focus</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REGISTER_OBSERVER_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REMEMBER_PAGE_STATE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JSON or jQuery expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>&nbsp;</p><p>The parameter expects a JSON array &nbsp;without surrounding inverted commas or curly brackets, or a jQuery expression with one or more ID or class selectors.</p><p>If no expression is used and "Document" is specified as the page focus, all input elements of the application page are monitored.</p><p>Examples:</p><ul><li>JSON: ["P1_ENAME", "P1_JOB"...]</li><li>jQuery class selector: .adc-remember</li><li>jQuery ID selector: #P1_ENAME,#P1_JOB</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REMEMBER_PAGE_STATE_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message text to be displayed when checking for changes at a later date.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REMEMBER_PAGE_STATE_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Title^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Dialogue title of the message for a detected, unsaved change</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_REGION_ENTRY_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ID of the line^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>ID of the line to be selected. Can be #EVENT_DATA#, for example, if the ID is supplied via an observation of a region.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_REGION_ENTRY_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set focus^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls whether the row is only selected or whether the focus is also set to the first column.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_REGION_ENTRY_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Suppress event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If this switch is set, selecting a line does not trigger an event. This is useful if reports would otherwise end up in an endless loop of mutually triggering events.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAP_SELECT_TAB_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ID of the tabulator region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the ID of the region containing the tabulator entry here.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Determines the transmission mode. A combination of validate and submit can be selected.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>References a message if the validation failed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_BUTTON_ACCESSKEY_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Position^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Position of the letter</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_BUTTON_TOOLTIP_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Tooltip^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Tooltip for button</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ELEMENT_FROM_STMT_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>SQL statement that returns one or more values<br>The column identifiers must correspond to element names, the query results are set in the corresponding page elements</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The element value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls how the page element should be displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_MODAL_DIALOG_TITLE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Tiel^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Title to be displayed on the modal dialogue.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_REGION_CONTENT_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^HTML-Code^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>HTML code to be used as the content of the region.</p><p>Used primarily from PL/SQL to allow the new content to be calculated by a PL/SQL procedure.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_VISUAL_STATE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the display status of the page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_VISUAL_STATE_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_ERROR_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Error message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Enter the error message here. This can also be determined using a PL/SQL function.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to be displayed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements to be displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to be hidden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements to be hidden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_MESSAGE_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>message text</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_MESSAGE_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^dialogue title^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Title of the dialogue window</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_SUCCESS_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_APEX_ACTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^APEX-Action^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Existing APEX action of the rule group.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_DIALOG_TYPE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^dialogue type^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Determines which type the message should have</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_EVENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Additional JavaScript events^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of JavaScript events that can be monitored by ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL function or a package function<br>No terminating semicolon needs to be specified.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_INPUT_FIELDS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^input elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>List of all input elements of the current page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_ITEM_STATUS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^display_status^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Option to display a page element on the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Executable JavaScript expression, no function definition</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name of a JavaScript function or anonymous function definition/IIFE</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JQUERY_SELECTOR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery expression to edit multiple elements. If this parameter is used, <code>DOCUMENT</code> must be entered as the triggering element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page_element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Page element or region of the current page</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAPT_PIT_MESSAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^name of the message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>identifier of a PIT message in the form msg.NAME or 'NAME', must be an existing message.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PROCEDURE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Procedure^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL procedure or a package procedure<br>No terminating semicolon needs to be specified.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SEQUENCE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^sequence^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name of an existing sequence</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SQL_STATEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^SQL statement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Executable SELECT statement, the entry is made as usual in the SQL developer, no semicolon is required.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Simple character string.<br>The character string is surrounded by inverted commas, so it is not necessary to enter these characters.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_ON_PARAMETER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String, based on parameter value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The parameter value must be created as a string parameter of the ADC group, the parameter ID is used as the key</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Can contain the following values:</p><ul><li>A constant. The specification must be in inverted commas or be a number</li><li>A PL/SQL function call that is calculated at runtime</li><li>String ITEM_VALUE, without inverted commas. In this case, the value of ITEM is used in the session state (this can be calculated in advance)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or JS expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Can contain the following values:</p><ul><li>A constant. The specification must be in inverted commas or be a number</li><li>A JavaScript expression that is calculated at runtime</li><li>String ITEM_VALUE, without inverted commas. In this case, the value of ITEM is used in the session state (this can be calculated in advance)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_PIT_MESSAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If not enclosed in inverted commas, a PIT message name of the form msg.NAME</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SUBMIT_TYPE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Submit and/or validation^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Types of page redirection</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SWITCH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Truth value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_VALIDATE_ITEMS_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Checkbox list of all input fields on the current page. Allows multiple selection of input elements.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_VALIDATE_ITEMS_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^validation method^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Validation method. Must be implemented as a procedure that registers errors in ADC.<br>The method must have an optional parameter to which the attribute value #ITEM# is passed. This value is used to filter the error messages. (Example: <span style="font-family:'Courier New', Courier, monospace;">my_pkg.my_function(p_filter =&gt; '#ITEM#')</span>)</p><p>If this parameter is the only parameter of the function, it does not need to be specified.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_CONTROL_LIST',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^checkbox^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for selecting multiple options^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_SELECT_LIST',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for the selection of a calculated set of options^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_STATIC_LIST',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Static selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used to select a given set of options^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_SWITCH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for yes/no or on/off decisions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_TEXT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Textfield^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for shorter free texts^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPVT_TEXT_AREA',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^text_area^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for large amounts of text^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_WARN_BEFORE_CLICK_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Warning^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message text that is displayed if unsaved changes exist on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^list of page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Comma-separated list of element names or CSS classes that identify the fields that are combined into a group. Within this group, when checking the values, either exactly one field must have a <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span> value, or all values must be empty if the "<i>Null is allowed</i>" switch is set.</p><p>A possible error message is displayed for the element that is selected as the page element for this action.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be displayed if the check fails. Must be a PIT message name in the form <span style="font-family:'Courier New', Courier, monospace;">MSG.[message name]</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Null is allowed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Determines whether or not a value may be included.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CANCEL_MODAL_DIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^cancel modal dialogue^',
    p_pti_display_name => q'^<p><strong>cancel dialogue</strong> <strong>ab</strong>#PARAM_1| and trigger event on "|"|#.</p>^',
    p_pti_description => q'^<p>Cancels the display of the modal dialogue. If several modal windows are used overlapping, the triggering element must be specified.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAT_CLOSE_MODAL_DIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^close modal dialogue^',
    p_pti_display_name => q'^<p><strong>close modal dialogue</strong></p>^',
    p_pti_description => q'^<p>closes the modal dialogue and triggers the event <span style="font-family:'Courier New', Courier, monospace;">apexafterclosedialogue</span>.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONFIRM_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Bind button to confirmation question^',
    p_pti_display_name => q'^<p><strong>bind</strong> button "#ITEM#" and <strong>confirmation query</strong></p>^',
    p_pti_description => q'^<p>Ensures that a confirmation message is displayed when a button is clicked.<br>Only if this request is confirmed, the event is reported to ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONTROL_MODAL_DIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^close modal dialogue^',
    p_pti_display_name => q'^<p>close modal dialogue</p>^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DYNAMIC_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute dynamic JavaScript^',
    p_pti_display_name => q'^<p><strong>calculate JavaScript </strong>using "#PARAM_1#" and execute it</p>^',
    p_pti_description => q'^<p>Executes the passed JavaScript on the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_COMMAND',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute page command^',
    p_pti_display_name => q'^<p><strong>execute page command</strong> "#PARAM_1#" <strong>out</strong></p>^',
    p_pti_description => q'^<p>Executes a page command. This action type ensures that a page command is executed recursively within the database. Page commands without reference to a page element, such as a button, can only be executed via this function (or via custom JavaScript on the page).</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^execute JavaScript code^',
    p_pti_display_name => q'^<p><strong>execute JavaScript code</strong> "#PARAM_1#" <strong>out</strong>.</p>^',
    p_pti_description => q'^<p>Executes the entered JavaScript code on the application page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ADC',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^General actions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltlfäche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_GET_REPORT_SELECTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Report selected line ID or save in element^',
    p_pti_display_name => q'^<p>#PARAM_2|<strong>column </strong>|<strong>primary key</strong># from report "#ITEM#" #PARAM_1|<strong>store in field</strong> "|"|report to ADC#</p>^',
    p_pti_description => q'^<p>Stores the currently selected row IDs in the specified field if an element is specified, or reports the key value to ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_IG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for the Interactive Grid^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for general page elements^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_JAVA_SCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript functions and events^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CATG_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^input fields^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for input fields^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_PL_SQL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^PL/SQ-functions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_REPORT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^reports^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for reports (classic and interactive)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_IG_FILTER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hide filter bank from IR/IG^',
    p_pti_display_name => q'^<p><strong>hide filter bank</strong> from IR/IG "#ITEM#"</p>^',
    p_pti_description => q'^<p>Hides the filter bank of Interactive Report/Grid.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_REPORT_FILTER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^blend filter bank off^',
    p_pti_display_name => q'^<p><strong>blend filter bank</strong> from IR/REPORT "#ITEM#"</p>^',
    p_pti_description => q'^<p>Hides the filter bank of Interactive Report/Grid.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IG_ALIGN_VERTICAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Format table cells vertically at the top^',
    p_pti_display_name => q'^<p><strong>align cell content </strong>from "#ITEM#" <strong>vertically at the top</strong></p>^',
    p_pti_description => q'^<p>Changes the formatting of an interactive grid/report so that the table cells are aligned vertically at the top.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_INITIALIZE_FORM_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialise form region^',
    p_pti_display_name => q'^<p><strong>initialise form</strong> #PARAM_1#</p>^',
    p_pti_description => q'^<p>Analyses the data source of a form region and initialises the current data.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_MANDATORY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Field is mandatory^',
    p_pti_display_name => q'^<p><strong>make </strong>#PARAM_2|<strong>Selector </strong>"||<strong>Field </strong>"^ITEM^#" the <strong>mandatory field</strong></p>^',
    p_pti_description => q'^<p>Makes a page element a mandatory field including validation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_OPTIONAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Field is optional^',
    p_pti_display_name => q'^<p><strong>make </strong>#PARAM_2|<strong>Selector </strong>"||<strong>Field </strong>"^ITEM^#" <strong>optional</strong></p>^',
    p_pti_description => q'^<p>Makes a page element optional and disables mandatory field validation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_MONITOR_EVENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Monitor JavaScript event^',
    p_pti_display_name => q'^<p><strong>monitor event</strong> "#PARAM_1#" on page element "#ITEM#" and #PARAM_2|<strong>execute function</strong> "|"|<strong>report event</strong> to ADC#</p>^',
    p_pti_description => q'^<p>The action type integrates an additional event handler for events that are not monitored by ADC by default on the selected page element.</p><p>This action type makes it possible to react to special events, such as closing a modal dialogue or pressing the <span style="font-family:'Courier New', Courier, monospace;">ENTER</span> key. If no JavaScript function is specified, ADC is informed about the event. In this case, the associated pseudo column contains the ID of the triggering element. When closing a modal dialogue, care must be taken to ensure that the page element specified here receives the event. This is ensured via a parameter when generating the URL.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOOP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^do nothing^',
    p_pti_display_name => q'^<p><strong>do nothing</strong>. </p>^',
    p_pti_description => q'^<p>This action type allows you to formulate a technical condition where nothing else should happen. Sometimes this is useful if, for example, a more specialised case should do nothing, but a more general case should. In this case, a use case for the more specific case would only be taken into account if an action is also stored, and this would then be "do nothing".</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOTIFY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^display message^',
    p_pti_display_name => q'^<p><strong>display message </strong>"#PARAM_2#", type #PARAM_1#</p>^',
    p_pti_description => q'^<p>Displays a message on the application page. When the dialogue is closed, the focus is set to the element that was selected as the page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_NULL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select at least one value^',
    p_pti_display_name => q'^<p>select <strong>at least one value</strong> from "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Makes sure that at least one of the elements from attribute "<i>List of page elements</i>" contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_PLSQL_CODE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL code execution^',
    p_pti_display_name => q'^<p>execute <strong>PL/SQL code</strong> "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Executes the PL/SQL code passed as a parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_RAISE_ITEM_EVENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Trigger field event^',
    p_pti_display_name => q'^<p><strong>execute use cases </strong>of the "#ITEM#" element</p>^',
    p_pti_description => q'^<p>Triggers the associated event on the specified page element and ensures that the associated rules are processed</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_AND_SET_VALUE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Update field and set value^',
    p_pti_display_name => q'^<p><strong>update</strong> field "#ITEM#" and <strong>set field value </strong>to #PARAM_1|value "|"|current session state#</p>^',
    p_pti_description => q'^<p>Updates a page element and sets the field to the session state</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Refresh destination^',
    p_pti_display_name => q'^<p><strong>refresh page element </strong>"#ITEM#"</p>^',
    p_pti_description => q'^<p>Triggers an APEX refresh on the referenced page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_OBSERVER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Watch field^',
    p_pti_display_name => q'^<p><strong>observe field </strong>"#ITEM#"</p>^',
    p_pti_description => q'^<p>Watch a field, even if no use case references it in the technical condition. This means that its current value is transferred to the session state.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REMEMBER_PAGE_STATE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^save current page status^',
    p_pti_display_name => q'^<p><strong>save</strong> the current <strong>page status</strong></p>^',
    p_pti_description => q'^<p>Memorises the current value of the input fields to be monitored. This action type is required to dynamically recognise changes to the page and to issue a warning message when the currently entered values are left or overwritten.</p><p>The following element focuses are available:</p><ul><li>Document: The page elements to be monitored are defined in more detail in the "JSON or jQuery expression" parameter</li><li>Page element: Only the selected page element is monitored</li><li>Form region: All page elements in the form region are monitored.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REMOVE_ALL_ERRORS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^remove all errors^',
    p_pti_display_name => q'^<p><strong>remove all errors</strong> from the application page.</p>^',
    p_pti_description => q'^<p>Removes all error messages from the current application page. This function is required if, for example, a form is reinitialised after cancellation and all existing error messages are to be removed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SELECT_REGION_ENTRY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^select line in region^',
    p_pti_display_name => q'^<p><strong>select row</strong> '#PARAM_1#' <strong>in report</strong> #ITEM#</p>^',
    p_pti_description => q'^<p>Select a row in a report (classic, interactive region or interactive grid) or a tree.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SELECT_TAB',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^activate tabulator^',
    p_pti_display_name => q'^<p><strong>enable</strong> tab<strong> #ITEM#</strong></p>^',
    p_pti_description => q'^<p>Makes a tabulator active in a tabulator widget.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SEND_VALIDATE_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^request processing of the page^',
    p_pti_display_name => q'^<p><strong>request processing</strong> of the page in mode "#PARAM_1#" <strong>on.</strong> #PARAM_2| Request: ||#</p>^',
    p_pti_description => q'^<p>Validates and/or sends the page.</p><p>The mode determines which actions are performed. If the page is to be validated, a message text can be defined that is displayed if validation is unsuccessful. If this message is omitted, only the error messages of the validation logic are displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_BUTTON_ACCESSKEY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set keyboard shortcut for a button^',
    p_pti_display_name => q'^<p><strong>set keyboard shortcut</strong> of the button "#ITEM#" to the #PARAM_1#. letters</p>^',
    p_pti_description => q'^<p>By default, the access key of a button is assigned the first letter of the button label during page loading. This can be changed with this action type. To do this, the position of the new letter (keyboard shortcut) must be transferred.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_BUTTON_TOOLTIP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set tooltip on button^',
    p_pti_display_name => q'^<p><strong>set tooltip</strong> for button "#ITEM#" to "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>By default, the tooltip of a button is assigned the button label during page loading. This can be changed with this action type. To do this, the new text (tooltip) must be transferred. The corresponding keyboard shortcut is added automatically.</p><p><strong>Note:</strong> Setting the tooltip is only supported for buttons, as all other elements receive a standard tooltip.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ELEMENT_FROM_STMT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set element value with SQL statement^',
    p_pti_display_name => q'^<p><strong>set field value </strong>from SQL statement</p>^',
    p_pti_description => q'^<p>Sets an element value based on an SQL statement that returns a single value...</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_FOCUS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set focus in field^',
    p_pti_display_name => q'^<p><strong>set focus</strong> in field "#ITEM#"</p>^',
    p_pti_description => q'^<p>set focus in input field of the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set field to value^',
    p_pti_display_name => q'^<p><strong>set </strong>#PARAM_2|<strong>Selector </strong>"||<strong>Field </strong>"^ITEM^#" to #PARAM_1|Value "|"|NULL#, Status #PARAM_3#</p>^',
    p_pti_description => q'^<p>Sets the referenced page element to the value passed as parameter and controls the display status.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM_LABEL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set field identifier to value^',
    p_pti_display_name => q'^<p><strong>set field identifier</strong> to "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Sets the identifier of the referenced page element to the value passed as a parameter. </p><p>A mandatory field is always made visible and active to enable the user to make an entry.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_MODAL_DIALOG_TITLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^set title of the modal dialogue^',
    p_pti_display_name => q'^<p><strong>set the title</strong> of the modal dialogue to "#PARAM_1#".</p>^',
    p_pti_description => q'^<p>Sets the title of a modal dialogue to the desired value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_REGION_CONTENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set HTML content of a region^',
    p_pti_display_name => q'^<p><strong>set content of region</strong> "#ITEM#" to calculated value</p>^',
    p_pti_description => q'^<p>Sets the HTML content of a static region to a calculated value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_VISUAL_STATE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Check display status of a page element^',
    p_pti_display_name => q'^<p><strong>set the visibility</strong> of the page element "#ITEM#" <strong>to status </strong>"#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Controls the visibility (<span style="font-family:'Courier New', Courier, monospace;">SHOW/HIDE</span>) and status (<span style="font-family:'Courier New', Courier, monospace;">ENABLED/DISABLED</span>) of a page element. Only meaningful combinations are possible.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ERROR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Display error^',
    p_pti_display_name => q'^<p><strong>display error </strong>"#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Displays the error message passed as a parameter on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_HIDE_ITEMS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show and hide page elements^',
    p_pti_display_name => q'^<p><strong>show</strong> selectors "#PARAM_1#" <strong>on and</strong> '#PARAM_2#" <strong>off</strong></p>^',
    p_pti_description => q'^<p>Controls the display of multiple page elements by showing the page elements identified by the first jQuery expression and hiding the page elements identified by the second jQuery expression</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_MESSAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^display a message and set focus^',
    p_pti_display_name => q'^<p><strong>display &nbsp;message </strong>"#PARAM_1#" , then <strong>focus</strong> on "#ITEM#"</p>^',
    p_pti_description => q'^<p>Displays a message in a message window.</p><p>The action must be linked to a specific element. This element receives the focus after confirmation of the message.</p><p>DEPRECATED: Use action type "show message" instead. RENDER method may need to be overwritten.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_SUCCESS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^display success message^',
    p_pti_display_name => q'^<p><strong>display success message</strong> #PARAM_1#</p>^',
    p_pti_description => q'^<p>shows a success message.</p><p>DEPRECATED: Use &nbsp; "show message" instead and select type "success message".</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_STOP_RULE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Stop rule^',
    p_pti_display_name => q'^<p><strong>stop</strong> use case</p>^',
    p_pti_description => q'^<p>Stops the currently running rule and does not allow recursive execution of further rules.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_VALIDATE_ITEMS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^validate input fields dynamically^',
    p_pti_display_name => q'^<p><strong>validate input fields</strong> "#PARAM_1#" <strong>dynamic</strong></p>^',
    p_pti_description => q'^<p>Registers input fields when initialising the application page for dynamic validation.<br>The stored code is executed when a change is made.</p>^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CAT_WARN_BEFORE_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Put out confirmation message if changes have been made^',
    p_pti_display_name => q'^<p><strong>show a warning message</strong> if <strong>unsaved changes</strong> exist before the button triggers</p>^',
    p_pti_description => q'^<p>Provides a check before triggering a button that shows a warning if unsaved changes exist on the page. Assumes that the current page status has been saved in advance with "save current page status".</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select an exact value^',
    p_pti_display_name => q'^<p>select <strong>exactly one value</strong> from "#PARAM_1#"</p>^',
    p_pti_description => q'^<p>Makes sure that exactly one of the elements from attribute "<i>List of elements</i>" contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_ADCSELECTIONCHANGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^selection changed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERCANCELDIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialogue aborted^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERCLOSEDIALOG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialogue closed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_APEXAFTERREFRESH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Refresh completed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_CHANGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Change^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Click^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_COMMAND',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page_command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_DBLCLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^doubleclick^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_ENTER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter key^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CET_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialisation^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_AFTER_REFRESH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^After Refresh^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_APP_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^application element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_COMMAND',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^page_command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CPIT_DATE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Datum)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DIALOG_CLOSED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog geschlossen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOCUMENT_MODAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Modaler Dialog^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOUBLE_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Doppelklick^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ELEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ENTER_KEY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter-Taste^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_EVENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ereignis^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FIRING_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Firing Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FORM_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Formularregion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INITIALIZING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialize Flag^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INTERACTIVE_GRID_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interaktives Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INTERACTIVE_REPORT_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interaktiver Bericht^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_NUMBER_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Zahl)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_REPORT_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Klassischer Bericht^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ROWID_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeilen-ID (RowID)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_SELECTION_CHANGED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeile in Bericht gewählt^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_TREE_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hierarchie^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'CSM_CANCEL_HAS_CHANGES',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^There are changes on the page. Would you still like to close the dialogue?^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^If changes exist on a modal application page and a check for changes has been requested.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CSM_CLOSE_WO_CHANGES',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No data has been changed on the application page. The data is not saved ^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^If there are no changes on a modal dialogue page, but processing has been requested, this is output.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'DIALOG_TYPE_ALERT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^warning message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'DIALOG_TYPE_CONFIRM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Confirmation message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'DIALOG_TYPE_INFO',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Note^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'DIALOG_TYPE_SUCCESS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^success message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_A_SHOW_ENABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^visible and active^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_B_SHOW_DISABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^visible, but deactivated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_C_HIDE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^hidden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_A_VALIDATE_AND_SUBMIT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Validate and forward page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_B_VALIDATE_ONLY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Validate page, do not forward^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_C_SUBMIT_ONLY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Do not validate page, but forward^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'T1002_ALERT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Warning^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'T1004_SUCCESS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^success message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'T1006_CONFIRMATION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Confirmation message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SELECT_LIST',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamic selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for the selection of a calculated set of options^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_STATIC_LIST',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Static selection list^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used to select a given set of options^'
  );

  pit_admin. merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SWITCH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Switch^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for yes/no or on/off decisions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Textfield^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for shorter free texts^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT_AREA',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^text_area^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Used for large amounts of text^'
  );

  commit;
end;
/

set define on