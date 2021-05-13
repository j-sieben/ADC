
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
    p_cgr_page_id => 1);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 1,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(486),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'eine Anwendung wählt',
    p_cru_condition => q'|P1_CGR_APP_ID is not null|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(488),
    p_cra_cru_id => adc_admin.map_id(486),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_ID',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(490),
    p_cra_cru_id => adc_admin.map_id(486),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_PAGE_ID',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(494),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'keine Anwendung gewählt hat',
    p_cru_condition => q'|P1_CGR_APP_ID is null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(496),
    p_cra_cru_id => adc_admin.map_id(494),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_ID',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(498),
    p_cra_cru_id => adc_admin.map_id(494),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_PAGE_ID',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(502),
    p_cra_cru_id => adc_admin.map_id(494),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_PAGE_ID',
    p_cra_cat_id => 'DISABLE_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(504),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = 1|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(965),
    p_cra_cru_id => adc_admin.map_id(504),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_PAGE_COMMAND',
    p_cra_cat_id => 'DIALOG_CLOSED',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(508),
    p_cra_cru_id => adc_admin.map_id(504),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.set_action_admin_cgr;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(512),
    p_cra_cru_id => adc_admin.map_id(504),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_RULE_OVERVIEW',
    p_cra_cat_id => 'DIALOG_CLOSED',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(516),
    p_cra_cru_id => adc_admin.map_id(504),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_RULE_OVERVIEW',
    p_cra_cat_id => 'HIDE_IR_IG_FILTER',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(518),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'eine dynamische Seite wählt',
    p_cru_condition => q'|firing_item = 'P1_CGR_ID'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(749),
    p_cra_cru_id => adc_admin.map_id(518),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_RULE_OVERVIEW',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(520),
    p_cra_cru_id => adc_admin.map_id(518),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.set_action_admin_cgr;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(824),
    p_cra_cru_id => adc_admin.map_id(518),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_PAGE_COMMAND',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(830),
    p_cra_cru_id => adc_admin.map_id(518),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_OVERVIEW',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(522),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'eine dynamische Seite wählt',
    p_cru_condition => q'|P1_CGR_PAGE_ID is not null|',
    p_cru_sort_seq => 60,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(524),
    p_cra_cru_id => adc_admin.map_id(522),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui.set_cgr_id;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(528),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'keine dynamische Seite gewählt hat',
    p_cru_condition => q'|P1_CGR_PAGE_ID is null|',
    p_cru_sort_seq => 50,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(532),
    p_cra_cru_id => adc_admin.map_id(528),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'P1_CGR_ID',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(534),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'den Anwendungsfall bearbeitet hat',
    p_cru_condition => q'|dialog_closed ='R1_RULE_OVERVIEW'|',
    p_cru_sort_seq => 70,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(536),
    p_cra_cru_id => adc_admin.map_id(534),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_RULE_OVERVIEW',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(957),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'ein Seitenkommando bearbeitet hat',
    p_cru_condition => q'|dialog_closed = 'R1_PAGE_COMMAND'|',
    p_cru_sort_seq => 80,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(959),
    p_cra_cru_id => adc_admin.map_id(957),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_PAGE_COMMAND',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(1021),
    p_cru_cgr_id => adc_admin.map_id(484),
    p_cru_name => 'Dynamische Seite aktiv oder deaktiv schalten',
    p_cru_condition => q'|command = 'toggle-cgr-active'|',
    p_cru_sort_seq => 90,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1144),
    p_cra_cru_id => adc_admin.map_id(1021),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'R1_OVERVIEW',
    p_cra_cat_id => 'REFRESH_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1023),
    p_cra_cru_id => adc_admin.map_id(1021),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => '',
    p_cra_cat_id => 'NOTIFY',
    p_cra_param_1 => q'|Aktion gewählt|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(1027),
    p_cra_cru_id => adc_admin.map_id(1021),
    p_cra_cgr_id => adc_admin.map_id(484),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|Aktion gewählt|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(1005),
    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'toggle-cgr-active',
    p_caa_label => 'Dynamische Seite aktivieren oder deaktivieren',
    p_caa_context_label => 'Aktiviert oder deaktiviert ADC für die Seite',
    p_caa_icon => '',
    p_caa_icon_type => '',
    p_caa_title => '',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(1005),
    p_cai_cpi_cgr_id => adc_admin.map_id(484),
    p_cai_cpi_id => 'B1_CGR_ACTIVE',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(544),
    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'export-rulegroup',
    p_caa_label => 'Dynamische Seite(n) exportieren',
    p_caa_context_label => 'Öffnet Anwendungsseite EXPORT_CGR',
    p_caa_icon => 'fa-server-arrow-down',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => 'Alt+E',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(544),
    p_cai_cpi_cgr_id => adc_admin.map_id(484),
    p_cai_cpi_id => 'B1_EXPORT_CGR',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(546),
    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'create-rule',
    p_caa_label => 'Anwendungsfall erzeugen',
    p_caa_context_label => 'Öffnet Anwendungsseite EDIT_CRU',
    p_caa_icon => 'fa-window-new',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => 'Alt+R',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(546),
    p_cai_cpi_cgr_id => adc_admin.map_id(484),
    p_cai_cpi_id => 'B1_CREATE_CRU',
    p_cai_active => adc_util.C_TRUE);

  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(546),
    p_cai_cpi_cgr_id => adc_admin.map_id(484),
    p_cai_cpi_id => 'B1_CREATE_CRU_1',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(548),
    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'create-apex-action',
    p_caa_label => 'Seitenkommando erstellen',
    p_caa_context_label => 'Öffnet Anwendungsseite EDIT_CAA',
    p_caa_icon => 'fa-server-new',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => 'Alt+C',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(548),
    p_cai_cpi_cgr_id => adc_admin.map_id(484),
    p_cai_cpi_id => 'B1_CREATE_CAA',
    p_cai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(#CGR_ID#));

  commit;
end;
/

set define on
