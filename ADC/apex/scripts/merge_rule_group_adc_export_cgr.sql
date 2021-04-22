
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup #CGR_NAME#');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 8);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 8,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(622),
    p_cru_cgr_id => adc_admin.map_id(620),
    p_cru_name => 'Initialisierung',
    p_cru_condition => q'|initializing = 1|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(624),
    p_cra_cru_id => adc_admin.map_id(622),
    p_cra_cgr_id => adc_admin.map_id(620),
    p_cra_cpi_id => 'P8_EXPORT_TYPE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.get_export_type|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(626),
    p_cru_cgr_id => adc_admin.map_id(620),
    p_cru_name => 'Einstellungen geÃ¤ndert',
    p_cru_condition => q'|firing_item in ('P8_EXPORT_TYPE', 'P8_CGR_APP_ID', 'P8_CGR_PAGE_ID', 'P8_CGR_ID')|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(628),
    p_cra_cru_id => adc_admin.map_id(626),
    p_cra_cgr_id => adc_admin.map_id(620),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.set_action_export_cgr;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(630),
    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'export-rulegroup',
    p_caa_label => 'Regelgruppe(n) exportieren',
    p_caa_context_label => '',
    p_caa_icon => '',
    p_caa_icon_type => '',
    p_caa_title => 'Exportiert die gewÃ¤hlten Regelgruppen',
    p_caa_shortcut => 'Alt+E',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(630),
    p_cai_cpi_cgr_id => adc_admin.map_id(620),
    p_cai_cpi_id => 'B8_EXPORT',
    p_cai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(#CGR_ID#));

  commit;
end;
/

set define on
