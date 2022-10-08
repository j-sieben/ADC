
set define ~

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := 118;--coalesce(apex_application_install.get_application_id, ~APP_ID.);

  --dbms_output.put_line('~s1.Rulegroup App 505 Page 51');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 51);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(12961),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 51,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(12962),
    p_cru_cgr_id => adc_admin.map_id(12961),
    p_cru_name => q'|Initialisierung|',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  /*adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12963),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'B51_BUTTON',
    p_cra_cat_id => 'SET_BUTTON_ACCESSKEY',
    p_cra_param_1 => q'|6|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 190,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);*/
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12965),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'B51_SCHALTFLAECHE_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 100,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129651),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_AUSWAHL_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12969),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_AUSWAHL_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 60,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129511),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_DATUM_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129513),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_DATUM_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 510,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129515),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_FARBE_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 150,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1295151),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_FARBE_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 160,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129519),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_JA_NEIN_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 120,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12981),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_JA_NEIN_DEAKTIV',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|0|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|1|',
    p_cra_sort_seq => 110,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_FALSE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12983),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_KONTROLLE_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12985),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_LISTE_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 1510,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129851),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_LISTE_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 180,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12989),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_OPTION_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12991),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_TEXT',
    p_cra_cat_id => 'SET_FOCUS',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 90,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12993),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_TEXT_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 50,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12995),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_TEXT_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 80,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(129951),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_ZAHL_DEAKTIV',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 140,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(12999),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_ZAHL_PFLICHT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|0|',
    p_cra_sort_seq => 130,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13001),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_OPTION_DEAKTIV',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'Return2'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|1|',
    p_cra_sort_seq => 210,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13003),
    p_cra_cru_id => adc_admin.map_id(12962),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'P51_OPTION',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'l'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'|1|',
    p_cra_sort_seq => 200,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(13005),
    p_cru_cgr_id => adc_admin.map_id(12961),
    p_cru_name => q'|Seite absenden|',
    p_cru_condition => q'|B51_SPEICHERN = c_clicked|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
 /* adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13006),
    p_cra_cru_id => adc_admin.map_id(13005),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'B51_ZURUECK',
    p_cra_cat_id => 'ENABLECLICK',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);*/
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13008),
    p_cra_cru_id => adc_admin.map_id(13005),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|null;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13010),
    p_cra_cru_id => adc_admin.map_id(13005),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'STOP_RULE',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(13012),
    p_cra_cru_id => adc_admin.map_id(13005),
    p_cra_cgr_id => adc_admin.map_id(12961),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SEND_VALIDATE_PAGE',
    p_cra_param_1 => q'|VALIDATE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.propagate_rule_change(adc_admin.map_id(12961));

  commit;
end;
/

set define &
