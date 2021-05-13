
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
    p_cgr_page_id => 12);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 12,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(606),
    p_cru_cgr_id => adc_admin.map_id(604),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = 1|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(608),
    p_cra_cru_id => adc_admin.map_id(606),
    p_cra_cgr_id => adc_admin.map_id(604),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'DISABLE_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(610),
    p_cra_cru_id => adc_admin.map_id(606),
    p_cra_cgr_id => adc_admin.map_id(604),
    p_cra_cpi_id => 'P12_EXPORT_TYPE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'CAT_EXPORT_USER'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(612),
    p_cru_cgr_id => adc_admin.map_id(604),
    p_cru_name => 'keine Exportoption wählt',
    p_cru_condition => q'|P12_EXPORT_TYPE is null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(614),
    p_cra_cru_id => adc_admin.map_id(612),
    p_cra_cgr_id => adc_admin.map_id(604),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'DISABLE_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(616),
    p_cru_cgr_id => adc_admin.map_id(604),
    p_cru_name => 'eine Exportauswahl trifft',
    p_cru_condition => q'|P12_EXPORT_TYPE is not null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(618),
    p_cra_cru_id => adc_admin.map_id(616),
    p_cra_cgr_id => adc_admin.map_id(604),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'ENABLE_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(#CGR_ID#));

  commit;
end;
/

set define on
