
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
    p_cgr_page_id => 13);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(67),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 13,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(69),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = C_TRUE|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(71),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'R13_RULES',
    p_cra_cat_id => 'IG_ALIGN_VERTICAL',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(73),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'R13_RULES',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(75),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|HIDE|',
    p_cra_param_2 => q'|.adc-hide, .t-TabsRegion-items .apex-rds-slider|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(77),
    p_cra_cru_id => adc_admin.map_id(69),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'R13_HIERARCHY',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(79),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'eine Anwendung wählt',
    p_cru_condition => q'|firing_item = 'P13_CGR_APP_ID'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_TRUE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(81),
    p_cra_cru_id => adc_admin.map_id(79),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P13_CGR_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(83),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'einen Eintrag in der Hierarchie wählt',
    p_cru_condition => q'|selection_changed = R13_HIERARCHY|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(85),
    p_cra_cru_id => adc_admin.map_id(83),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.handle_activity|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(87),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'einen Anwendungsfall aus der Übersicht wählt',
    p_cru_condition => q'|selection_changed = R13_RULES|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(89),
    p_cra_cru_id => adc_admin.map_id(87),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(91),
    p_cra_cru_id => adc_admin.map_id(87),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'R13_HIERARCHY',
    p_cra_cat_id => 'SELECT_REGION_ENTRY',
    p_cra_param_1 => q'|adc_api.get_event_data;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(93),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'den Aktionstyp ändert',
    p_cru_condition => q'|firing_item = 'P13_CRA_CAT_ID'|',
    p_cru_sort_seq => 50,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(95),
    p_cra_cru_id => adc_admin.map_id(93),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P13_CRA_CAT_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.handle_cat_changed;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(97),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'eine dynamische Seite aktiviert oder deaktiviert',
    p_cru_condition => q'|command = 'toggle-cgr-active'|',
    p_cru_sort_seq => 60,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(99),
    p_cra_cru_id => adc_admin.map_id(97),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.toggle_cgr_active|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(101),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'die technische Bedingung ändert',
    p_cru_condition => q'|P13_CRU_CONDITION is not null|',
    p_cru_sort_seq => 70,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(103),
    p_cra_cru_id => adc_admin.map_id(101),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.validate_rule_condition|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(105),
    p_cru_cgr_id => adc_admin.map_id(67),
    p_cru_name => 'ein Seitenkommando auslöst',
    p_cru_condition => q'|command in ('cancel-action', 'create-action', 'delete-action', 'update-action')|',
    p_cru_sort_seq => 80,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(107),
    p_cra_cru_id => adc_admin.map_id(105),
    p_cra_cgr_id => adc_admin.map_id(67),
    p_cra_cpi_id => 'P13_CGR_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adc_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(109),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'cancel-action',
    p_caa_label => 'Abbrechen',
    p_caa_context_label => 'Abbrechen',
    p_caa_icon => 'fa-undo-arrow',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Aktion abbrechen',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(109),
    p_cai_cpi_cgr_id => adc_admin.map_id(67),
    p_cai_cpi_id => 'B13_CANCEL',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(111),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'update-action',
    p_caa_label => 'Speichern',
    p_caa_context_label => '',
    p_caa_icon => '',
    p_caa_icon_type => '',
    p_caa_title => '',
    p_caa_shortcut => 'Alt+W',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(111),
    p_cai_cpi_cgr_id => adc_admin.map_id(67),
    p_cai_cpi_id => 'B13_SAVE',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(113),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'delete-action',
    p_caa_label => 'Löschen',
    p_caa_context_label => 'Löschen',
    p_caa_icon => 'fa-trash-o',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Daten löschen',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(113),
    p_cai_cpi_cgr_id => adc_admin.map_id(67),
    p_cai_cpi_id => 'B13_DELETE',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(115),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'toggle-cgr-active',
    p_caa_label => 'Aktiv',
    p_caa_context_label => 'Aktiv',
    p_caa_icon => '',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  

  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(117),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'create-action',
    p_caa_label => 'Erstellen',
    p_caa_context_label => 'Erstellen',
    p_caa_icon => 'fa-plus',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Datensatz erstellen',
    p_caa_shortcut => '',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(117),
    p_cai_cpi_cgr_id => adc_admin.map_id(67),
    p_cai_cpi_id => 'B13_CREATE',
    p_cai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(119),
    p_caa_cgr_id => adc_admin.map_id(67),
    p_caa_cty_id => 'ACTION',
    p_caa_name => 'export-rule-group',
    p_caa_label => 'Dynamische Seite exportieren',
    p_caa_context_label => 'Dynamische Seite exportieren',
    p_caa_icon => 'fa-download',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Dynamische Seite exportieren',
    p_caa_shortcut => 'Alt+E',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_cai_caa_id => adc_admin.map_id(119),
    p_cai_cpi_cgr_id => adc_admin.map_id(67),
    p_cai_cpi_id => 'B13_EXPORT_CGR',
    p_cai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(67));

  commit;
end;
/

set define on
