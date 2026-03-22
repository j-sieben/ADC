
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_config.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_config.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 99);

  adc_config.merge_rule_group(
    p_crg_id => adc_config.map_id(219),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 99,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(221),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(223),
    p_cra_cru_id => adc_config.map_id(221),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.sadc-mandatory|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1073),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'eine Testaktion ausführen möchte',
    p_cru_condition => q'|firing_item = 'P99_FIRST_NAME'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1075),
    p_cra_cru_id => adc_config.map_id(1073),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|ut_adc_internal.execute_ut_scenario;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1077),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'eine relevante Zustandsänderung auslöst',
    p_cru_condition => q'|P99_FIRST_NAME = 'RELEVANT'|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1079),
    p_cra_cru_id => adc_config.map_id(1077),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_LAST_NAME',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'RELEVANT'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1081),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'eine relevante Folgeaktion ausführt',
    p_cru_condition => q'|P99_LAST_NAME = 'RELEVANT'|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1083),
    p_cra_cru_id => adc_config.map_id(1081),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_EMAIL',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'FOLLOW_UP'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1085),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'eine irrelevante Zustandsänderung auslöst',
    p_cru_condition => q'|P99_FIRST_NAME = 'IRRELEVANT'|',
    p_cru_sort_seq => 50,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1087),
    p_cra_cru_id => adc_config.map_id(1085),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_PHONE_NUMBER',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'IRRELEVANT'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1089),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'bei Fehler ohne Handler abbricht',
    p_cru_condition => q'|P99_FIRST_NAME = 'ERROR'|',
    p_cru_sort_seq => 60,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1091),
    p_cra_cru_id => adc_config.map_id(1089),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|raise_application_error(-20000, 'UT_ERROR');|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1093),
    p_cra_cru_id => adc_config.map_id(1089),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_LAST_NAME',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'AFTER_ERROR'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(1095),
    p_cru_crg_id => adc_config.map_id(219),
    p_cru_name => 'bei Fehler mit Handler fortsetzt',
    p_cru_condition => q'|P99_FIRST_NAME = 'HANDLER'|',
    p_cru_sort_seq => 70,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1097),
    p_cra_cru_id => adc_config.map_id(1095),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|raise_application_error(-20001, 'UT_HANDLER');|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1099),
    p_cra_cru_id => adc_config.map_id(1095),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_LAST_NAME',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'AFTER_ERROR'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(1101),
    p_cra_cru_id => adc_config.map_id(1095),
    p_cra_crg_id => adc_config.map_id(219),
    p_cra_cpi_id => 'P99_EMAIL',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'HANDLED'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_TRUE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_config.propagate_rule_change(adc_config.map_id(219));

  commit;
end;
/

set define on
