
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 8);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(83),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 8,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(85),
    p_cru_crg_id => adc_admin.map_id(83),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(87),
    p_cra_cru_id => adc_admin.map_id(85),
    p_cra_crg_id => adc_admin.map_id(83),
    p_cra_cpi_id => 'R8_EMPLOYEES',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(89),
    p_cru_crg_id => adc_admin.map_id(83),
    p_cru_name => 'einen Mitarbeiter auswählt',
    p_cru_condition => q'|selection_changed = 'R8_EMPLOYEES'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(91),
    p_cra_cru_id => adc_admin.map_id(89),
    p_cra_crg_id => adc_admin.map_id(83),
    p_cra_cpi_id => 'B8_EDIT_EMP',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|sadc_ui.adact_control_action;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(93),
    p_caa_crg_id => adc_admin.map_id(83),
    p_caa_caat_id => 'ACTION',
    p_caa_name => 'edit-employee',
    p_caa_confirm_message_name => '',
    p_caa_label => 'Mitarbeiter bearbeiten',
    p_caa_context_label => '',
    p_caa_icon => '',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_caai_caa_id => adc_admin.map_id(93),
    p_caai_cpi_crg_id => adc_admin.map_id(83),
    p_caai_cpi_id => 'B8_EDIT_EMP',
    p_caai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(83));

  commit;
end;
/

set define on
