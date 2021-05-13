
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
    p_cgr_page_id => 11);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 11,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(568),
    p_cru_cgr_id => adc_admin.map_id(566),
    p_cru_name => 'eine neue Aktion erfasst',
    p_cru_condition => q'|initializing = 1 and P11_CRA_ID is null|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(570),
    p_cra_cru_id => adc_admin.map_id(568),
    p_cra_cgr_id => adc_admin.map_id(566),
    p_cra_cpi_id => 'P11_CRA_SORT_SEQ',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.get_cra_sort_seq|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(572),
    p_cra_cru_id => adc_admin.map_id(568),
    p_cra_cgr_id => adc_admin.map_id(566),
    p_cra_cpi_id => 'P11_CRA_ACTIVE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.C_TRUE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(574),
    p_cra_cru_id => adc_admin.map_id(568),
    p_cra_cgr_id => adc_admin.map_id(566),
    p_cra_cpi_id => 'P11_CRA_RAISE_RECURSIVE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.C_TRUE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(576),
    p_cra_cru_id => adc_admin.map_id(568),
    p_cra_cgr_id => adc_admin.map_id(566),
    p_cra_cpi_id => 'P11_CRA_CAT_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.configure_edit_cra;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(578),
    p_cru_cgr_id => adc_admin.map_id(566),
    p_cru_name => 'den Aktionstyp ändert',
    p_cru_condition => q'|P11_CRA_CAT_ID is not null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_TRUE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(580),
    p_cra_cru_id => adc_admin.map_id(578),
    p_cra_cgr_id => adc_admin.map_id(566),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.configure_edit_cra;|',
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
