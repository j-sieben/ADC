
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 50);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(163),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 50,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(165),
    p_cru_crg_id => adc_admin.map_id(163),
    p_cru_name => 'Initialisierung',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(167),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'|.ek-deaktiv|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(169),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.ek-pflicht|',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(171),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'B50_SCHALTFLAECHE_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(173),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'P50_JA_NEIN_DEAKTIV',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'Y'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_DISABLE|',
    p_cra_sort_seq => 70,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(175),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'P50_OPTION',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'10'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(177),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'P50_OPTION_DEAKTIV',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'20'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_DISABLE|',
    p_cra_sort_seq => 50,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(179),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'P50_TEXT',
    p_cra_cat_id => 'SET_FOCUS',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 60,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(181),
    p_cra_cru_id => adc_admin.map_id(165),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'P50_TEXT_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|SHOW_ENABLE|',
    p_cra_sort_seq => 80,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
    
    
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(183),
    p_cru_crg_id => adc_admin.map_id(163),
    p_cru_name => 'Seite absenden',
    p_cru_condition => q'|B50_SPEICHERN = click|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(185),
    p_cra_cru_id => adc_admin.map_id(183),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SEND_VALIDATE_PAGE',
    p_cra_param_1 => q'|VALIDATE_AND_SUBMIT|',
    p_cra_param_2 => q'|SUBMIT|',
    p_cra_param_3 => q'|msg.ADC_INVALID_DATE|',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(187),
    p_cra_cru_id => adc_admin.map_id(183),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'STOP_RULE',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_TRUE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(189),
    p_cru_crg_id => adc_admin.map_id(163),
    p_cru_name => 'Schaltfläche "Meldung anzeigen" auswählen',
    p_cru_condition => q'|B50_MLD = click|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(191),
    p_cra_cru_id => adc_admin.map_id(189),
    p_cra_crg_id => adc_admin.map_id(163),
    p_cra_cpi_id => 'B50_MLD',
    p_cra_cat_id => 'NOTIFY',
    p_cra_param_1 => q'|Das ist eine Hinweismeldung.|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(163));

  commit;
end;
/

set define on
