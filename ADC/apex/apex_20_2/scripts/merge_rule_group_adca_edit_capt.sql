
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 5);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(67),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 5,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(69),
    p_cru_crg_id => adc_admin.map_id(67),
    p_cru_name => 'einen neuen Parametertyp anlegen möchte',
    p_cru_condition => q'|initializing = c_true and P5_CAPT_ID is null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_TRUE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(71),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P5_CAPT_ID',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(73),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|HIDE|',
    p_cra_param_2 => q'|#R5_EDIT_CAPT_SELECT_LIST,#R5_EDIT_CAPT_STATIC_LIST_FORM|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(75),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P5_CAPT_ACTIVE',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_util.C_TRUE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(77),
    p_cru_crg_id => adc_admin.map_id(67),
    p_cru_name => 'den Parametertyp ändert',
    p_cru_condition => q'|firing_item = 'P5_CAPT_CAPVT_ID'|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(79),
    p_cra_cru_id => adc_admin.map_id(77),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.handle_capvt_changed;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(81),
    p_cru_crg_id => adc_admin.map_id(67),
    p_cru_name => 'einen Parametertyp bearbeiten möchte',
    p_cru_condition => q'|initializing = c_true and P5_CAPT_ID is not null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_TRUE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(83),
    p_cra_cru_id => adc_admin.map_id(81),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.handle_capvt_changed;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(85),
    p_cra_cru_id => adc_admin.map_id(81),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P5_CAPT_ID',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(87),
    p_cru_crg_id => adc_admin.map_id(67),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(89),
    p_cra_cru_id => adc_admin.map_id(87),
    p_cra_crg_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.adc-required|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(67));

  commit;
end;
/

set define on
