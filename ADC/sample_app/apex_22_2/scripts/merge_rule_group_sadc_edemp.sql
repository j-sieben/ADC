
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 9);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(303),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 9,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(305),
    p_cru_crg_id => adc_admin.map_id(303),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(344),
    p_cra_cru_id => adc_admin.map_id(305),
    p_cra_crg_id => adc_admin.map_id(303),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.sadc-mandatory|',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(341),
    p_cra_cru_id => adc_admin.map_id(305),
    p_cra_crg_id => adc_admin.map_id(303),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'VALIDATE_ITEMS',
    p_cra_param_1 => q'|P9_EMP_EMAIL:P9_EMP_HIRE_DATE:P9_EMP_SALARY|',
    p_cra_param_2 => q'|sadc_ui.edemp_validate('#ITEM#');|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(303));

  commit;
end;
/

set define on
