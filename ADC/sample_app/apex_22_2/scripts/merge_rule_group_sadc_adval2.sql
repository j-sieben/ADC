
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 6);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(251),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 6,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(253),
    p_cru_crg_id => adc_admin.map_id(251),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(255),
    p_cra_cru_id => adc_admin.map_id(253),
    p_cra_crg_id => adc_admin.map_id(251),
    p_cra_cpi_id => 'P6_REQUIRED',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(257),
    p_cru_crg_id => adc_admin.map_id(251),
    p_cru_name => 'eine Zahl eingibt',
    p_cru_condition => q'|P6_NUMBER is not null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(259),
    p_cra_cru_id => adc_admin.map_id(257),
    p_cra_crg_id => adc_admin.map_id(251),
    p_cra_cpi_id => 'P6_NUMBER',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|sadc_ui.validate_p6_number|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(261),
    p_cru_crg_id => adc_admin.map_id(251),
    p_cru_name => 'ein Datum eingibt',
    p_cru_condition => q'|P6_DATE is not null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(263),
    p_cra_cru_id => adc_admin.map_id(261),
    p_cra_crg_id => adc_admin.map_id(251),
    p_cra_cpi_id => 'P6_DATE',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|sadc_ui.validate_p6_date;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(251));

  commit;
end;
/

set define on
