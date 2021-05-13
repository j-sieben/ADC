
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
    p_cgr_page_id => 5);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 5,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(584),
    p_cru_cgr_id => adc_admin.map_id(582),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = 1|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(586),
    p_cra_cru_id => adc_admin.map_id(584),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'R5_ACTION',
    p_cra_cat_id => 'HIDE_IR_IG_FILTER',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(588),
    p_cra_cru_id => adc_admin.map_id(584),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'R5_ACTION',
    p_cra_cat_id => 'DIALOG_CLOSED',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(590),
    p_cru_cgr_id => adc_admin.map_id(582),
    p_cru_name => 'eine Aktion editiert hat',
    p_cru_condition => q'|dialog_closed = 'R5_ACTION'|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(592),
    p_cra_cru_id => adc_admin.map_id(590),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'R5_ACTION',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(594),
    p_cru_cgr_id => adc_admin.map_id(582),
    p_cru_name => 'einen neuen Anwendungsfall erstellt',
    p_cru_condition => q'|P5_CRU_ID is null and initializing = 1|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_TRUE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(596),
    p_cra_cru_id => adc_admin.map_id(594),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'P5_CRU_SORT_SEQ',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.get_cru_sort_seq|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(598),
    p_cra_cru_id => adc_admin.map_id(594),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'P5_CRU_ACTIVE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_ui.c_true|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(600),
    p_cru_cgr_id => adc_admin.map_id(582),
    p_cru_name => 'die technische Bedingung ändert',
    p_cru_condition => q'|P5_CRU_CONDITION is not null|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(602),
    p_cra_cru_id => adc_admin.map_id(600),
    p_cra_cgr_id => adc_admin.map_id(582),
    p_cra_cpi_id => 'P5_CRU_CONDITION',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.validate_rule_condition;|',
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
