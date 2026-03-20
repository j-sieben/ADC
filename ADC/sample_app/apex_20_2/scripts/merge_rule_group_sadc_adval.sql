
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_config.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_config.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 5);

  adc_config.merge_rule_group(
    p_crg_id => adc_config.map_id(135),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 5,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(137),
    p_cru_crg_id => adc_config.map_id(135),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(139),
    p_cra_cru_id => adc_config.map_id(137),
    p_cra_crg_id => adc_config.map_id(135),
    p_cra_cpi_id => 'P5_REQUIRED',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(141),
    p_cru_crg_id => adc_config.map_id(135),
    p_cru_name => 'ein Datum in der Vergangenheit eingibt',
    p_cru_condition => q'|P5_DATE < sysdate|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(143),
    p_cra_cru_id => adc_config.map_id(141),
    p_cra_crg_id => adc_config.map_id(135),
    p_cra_cpi_id => 'P5_DATE',
    p_cra_cat_id => 'SHOW_ERROR',
    p_cra_param_1 => q'|Das Datum muss in der Zukunft liegen.|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(145),
    p_cru_crg_id => adc_config.map_id(135),
    p_cru_name => 'eine nicht erlaubte Zahl eingibt',
    p_cru_condition => q'|P5_NUMBER not between 100 and 1000|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_config.merge_rule_action(
    p_cra_id => adc_config.map_id(147),
    p_cra_cru_id => adc_config.map_id(145),
    p_cra_crg_id => adc_config.map_id(135),
    p_cra_cpi_id => 'P5_NUMBER',
    p_cra_cat_id => 'SHOW_ERROR',
    p_cra_param_1 => q'|Die Zahl muss zwischen 100 und 1000 liegen.|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_config.propagate_rule_change(adc_config.map_id(135));

  commit;
end;
/

set define on
