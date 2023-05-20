
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 8);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(1245),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 8,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(1247),
    p_cru_crg_id => adc_admin.map_id(1245),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = C_TRUE|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1249),
    p_cra_cru_id => adc_admin.map_id(1247),
    p_cra_crg_id => adc_admin.map_id(1245),
    p_cra_cpi_id => 'P8_INCLUDE_APP',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|adc_util.C_FALSE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1251),
    p_cra_cru_id => adc_admin.map_id(1247),
    p_cra_crg_id => adc_admin.map_id(1245),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui.set_action_export_crg;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(1253),
    p_cru_crg_id => adc_admin.map_id(1245),
    p_cru_name => 'eine Anwendung wählt',
    p_cru_condition => q'|firing_item = 'P8_CRG_APP_ID'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1255),
    p_cra_cru_id => adc_admin.map_id(1253),
    p_cra_crg_id => adc_admin.map_id(1245),
    p_cra_cpi_id => 'B8_EXPORT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui.set_action_export_crg;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(1257),
    p_caa_crg_id => adc_admin.map_id(1245),
    p_caa_caat_id => 'ACTION',
    p_caa_name => 'export-rule-group',
    p_caa_confirm_message_name => '',
    p_caa_label => 'Dynamische Seite exportieren',
    p_caa_context_label => 'Dynamische Seite exportieren',
    p_caa_icon => 'fa-download',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Dynamische Seite exportieren',
    p_caa_shortcut => 'Alt+E',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_caai_caa_id => adc_admin.map_id(1257),
    p_caai_cpi_crg_id => adc_admin.map_id(1245),
    p_caai_cpi_id => 'B8_EXPORT',
    p_caai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(1245));

  commit;
end;
/

set define on
