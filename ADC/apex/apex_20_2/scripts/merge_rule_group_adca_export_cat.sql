
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 12);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(91),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 12,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(93),
    p_cru_crg_id => adc_admin.map_id(91),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = C_TRUE|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(95),
    p_cra_cru_id => adc_admin.map_id(93),
    p_cra_crg_id => adc_admin.map_id(91),
    p_cra_cpi_id => 'P12_EXPORT_TYPE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'CAT_EXPORT_USER'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(97),
    p_cra_cru_id => adc_admin.map_id(93),
    p_cra_crg_id => adc_admin.map_id(91),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(99),
    p_cru_crg_id => adc_admin.map_id(91),
    p_cru_name => 'keine Exportoption wählt',
    p_cru_condition => q'|P12_EXPORT_TYPE is null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(101),
    p_cra_cru_id => adc_admin.map_id(99),
    p_cra_crg_id => adc_admin.map_id(91),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(103),
    p_cru_crg_id => adc_admin.map_id(91),
    p_cru_name => 'eine Exportauswahl trifft',
    p_cru_condition => q'|P12_EXPORT_TYPE is not null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(105),
    p_cra_cru_id => adc_admin.map_id(103),
    p_cra_crg_id => adc_admin.map_id(91),
    p_cra_cpi_id => 'B12_EXPORT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_ENABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(91));

  commit;
end;
/

set define on
