
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_config.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_config.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 14);

  adc_config.merge_rule_group(
    p_crg_id => adc_config.map_id(321),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 14,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_config.merge_rule(
    p_cru_id => adc_config.map_id(323),
    p_cru_crg_id => adc_config.map_id(321),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  

  adc_config.propagate_rule_change(adc_config.map_id(321));

  commit;
end;
/

set define on
