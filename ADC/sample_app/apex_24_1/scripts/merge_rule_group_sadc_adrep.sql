
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 10);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(205),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 10,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(207),
    p_cru_crg_id => adc_admin.map_id(205),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(209),
    p_cra_cru_id => adc_admin.map_id(207),
    p_cra_crg_id => adc_admin.map_id(205),
    p_cra_cpi_id => 'R10_EMPLOYEES_IG',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'|P10_EMP_ID_IG|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(211),
    p_cra_cru_id => adc_admin.map_id(207),
    p_cra_crg_id => adc_admin.map_id(205),
    p_cra_cpi_id => 'R10_EMPLOYEE_IR',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'|P10_EMP_ID_IR|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(213),
    p_cra_cru_id => adc_admin.map_id(207),
    p_cra_crg_id => adc_admin.map_id(205),
    p_cra_cpi_id => 'R10_EMPLOYEE_CR',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|1|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(215),
    p_cru_crg_id => adc_admin.map_id(205),
    p_cru_name => 'eine Zeile im klassischen Bericht wählt',
    p_cru_condition => q'|selection_changed = 'R10_EMPLOYEE_CR'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(217),
    p_cra_cru_id => adc_admin.map_id(215),
    p_cra_crg_id => adc_admin.map_id(205),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'NOTIFY',
    p_cra_param_1 => q'|adc_api.get_event_data|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(205));

  commit;
end;
/

set define on
