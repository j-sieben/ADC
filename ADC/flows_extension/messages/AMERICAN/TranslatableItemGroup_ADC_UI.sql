set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^');
    
    
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
    p_pti_id => 'LOV_EXPORT_CRG_ALL_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All dynamic use cases of all applications^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CRG_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^APEX applications incl. dynamic use cases^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CRG_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All dynamic use cases of an application^',
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
    p_pti_id => 'ADC_AUTO_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Will be executed when initializing the page if the condition is met^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_FORCE_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Will be executed additionally when initializing the page if the condition is met^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_NO_INITIALIZE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Will be executed if the condition is met and the use case is sorted first on the list.^'
  );

  commit;
end;
/

set define on