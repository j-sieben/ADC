begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADCA',
    p_pmg_description => q'^Messages for the ADC administration application^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_AUTO_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Will be executed when initializing the page if the condition is met^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_FORCE_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Will be executed additionally when initializing the page if the condition is met^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_NO_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Executed if the condition is met and the use case is sorted first on the list.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_UNSAVED_ITEM_TITLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Note^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_WARNING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Warning^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Title element for dialog box^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_CREATE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Create page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_DELETE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Delete page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Page command</h2><p>A page command is an action that can be triggered by different actions. It is used to centralize dynamic activities.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_SAVE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Save page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CANCEL_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Cancel^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^All action types^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_SYSTEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^All action types supplied^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_USER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^All self-created action types^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_CREATE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Create action^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_DELETE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Delete action^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_NO_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^No help available, please select an action type.^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_SAVE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Save action^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRG_EXPORT_LABEL_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Export application #1#^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRG_EXPORT_LABEL_NO_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Please select application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRG_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Dynamic Page</h2><p>A dynamic page is an APEX application page that is to be dynamically controlled by ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_CREATE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Create use case^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_DELETE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Delete use case^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Use case</h2><p>A use case represents an activity of the application user that should be responded to by ADC.</p><p>In order to detect an activity of the application user, a technical condition is required that must evaluate to TRUE.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_SAVE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Save use case^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLG_CREATE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Create workflow^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLG_DELETE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Delete workflow^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLS_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Workflow</h2><p>A workflow is a visualization of a workflow based on BPMN.</p><p>An identifier, a version and a status can be recorded for a workflow.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLS_SAVE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Save workflow^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CRG_ALL_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^All Dynamic Application Pages of all applications^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CRG_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^APEX application incl. dynamic application pages^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CRG_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^All dynamic application pages of an application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'NO_DELETE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Delete^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'NO_SAVE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Save^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADCA^',
    p_pti_name => q'^Select application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/