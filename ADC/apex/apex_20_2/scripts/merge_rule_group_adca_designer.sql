
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  adc_admin.prepare_rule_group_import(
    p_crg_app_id => l_app_id,
    p_crg_page_id => 13);

  adc_admin.merge_rule_group(
    p_crg_id => adc_admin.map_id(13),
    p_crg_app_id => l_app_id,
    p_crg_page_id => 13,
    p_crg_with_recursion => adc_util.C_TRUE,
    p_crg_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(15),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = C_TRUE|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(782),
    p_cra_cru_id => adc_admin.map_id(15),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'EXECUTE_JAVASCRIPT',
    p_cra_param_1 => q'|adca.hideNavigationMenu();|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 40,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(19),
    p_cra_cru_id => adc_admin.map_id(15),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'R13_RULES',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(21),
    p_cra_cru_id => adc_admin.map_id(15),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|HIDE|',
    p_cra_param_2 => q'|.adc-hide, .t-TabsRegion-items .apex-rds-slider|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(23),
    p_cra_cru_id => adc_admin.map_id(15),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'R13_HIERARCHY',
    p_cra_cat_id => 'GET_REPORT_SELECTION',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(25),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'eine Anwendung wählt',
    p_cru_condition => q'|firing_item = 'P13_CRG_APP_ID'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(27),
    p_cra_cru_id => adc_admin.map_id(25),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'P13_CRG_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(29),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'einen Eintrag in der Hierarchie wählt',
    p_cru_condition => q'|selection_changed = R13_HIERARCHY|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(31),
    p_cra_cru_id => adc_admin.map_id(29),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.handle_activity|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(35),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'einen Anwendungsfall aus der Übersicht wählt',
    p_cru_condition => q'|selection_changed = R13_RULES|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(37),
    p_cra_cru_id => adc_admin.map_id(35),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(41),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'den Aktionstyp ändert',
    p_cru_condition => q'|firing_item = 'P13_CRA_CAT_ID'|',
    p_cru_sort_seq => 50,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(43),
    p_cra_cru_id => adc_admin.map_id(41),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'P13_CRA_CAT_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.handle_cat_changed;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(45),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'eine dynamische Seite aktiviert oder deaktiviert',
    p_cru_condition => q'|command = 'toggle-cgr-active'|',
    p_cru_sort_seq => 60,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(47),
    p_cra_cru_id => adc_admin.map_id(45),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.toggle_crg_active|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(49),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'die technische Bedingung ändert',
    p_cru_condition => q'|P13_CRU_CONDITION is not null|',
    p_cru_sort_seq => 70,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(51),
    p_cra_cru_id => adc_admin.map_id(49),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.validate_rule_condition|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(53),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'ein Seitenkommando auslöst',
    p_cru_condition => q'|command in ('cancel-action', 'create-action', 'delete-action', 'update-action')|',
    p_cru_sort_seq => 80,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(55),
    p_cra_cru_id => adc_admin.map_id(53),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'P13_CRG_ID',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.handle_activity;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(297),
    p_cru_crg_id => adc_admin.map_id(13),
    p_cru_name => 'einen Aktionsparameter ändert',
    p_cru_condition => q'|adc.firing_item_has_class('adc-param') = C_TRUE|',
    p_cru_sort_seq => 90,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(301),
    p_cra_cru_id => adc_admin.map_id(297),
    p_cra_crg_id => adc_admin.map_id(13),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|adca_ui_designer.check_parameter_value;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_raise_on_validation => adc_util.C_FALSE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(57),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
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
    p_caai_caa_id => adc_admin.map_id(57),
    p_caai_cpi_crg_id => adc_admin.map_id(13),
    p_caai_cpi_id => 'B13_CANCEL',
    p_caai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(59),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
    p_caa_name => 'update-action',
    p_caa_label => 'Speichern',
    p_caa_context_label => '',
    p_caa_icon => '',
    p_caa_icon_type => 'fa',
    p_caa_title => '',
    p_caa_shortcut => 'Alt+W',
    p_caa_initially_disabled => adc_util.C_FALSE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_caai_caa_id => adc_admin.map_id(59),
    p_caai_cpi_crg_id => adc_admin.map_id(13),
    p_caai_cpi_id => 'B13_SAVE',
    p_caai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(61),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
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
    p_caai_caa_id => adc_admin.map_id(61),
    p_caai_cpi_crg_id => adc_admin.map_id(13),
    p_caai_cpi_id => 'B13_DELETE',
    p_caai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(63),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
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
    p_caa_id => adc_admin.map_id(65),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
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
    p_caai_caa_id => adc_admin.map_id(65),
    p_caai_cpi_crg_id => adc_admin.map_id(13),
    p_caai_cpi_id => 'B13_CREATE',
    p_caai_active => adc_util.C_TRUE);


  adc_admin.merge_apex_action(    
    p_caa_id => adc_admin.map_id(67),
    p_caa_crg_id => adc_admin.map_id(13),
    p_caa_caat_id => 'ACTION',
    p_caa_name => 'export-rule-group',
    p_caa_label => 'Dynamische Seiten exportieren',
    p_caa_context_label => 'Exportiert Metadaten der dynamische Seiten',
    p_caa_icon => 'fa-download',
    p_caa_icon_type => 'fa',
    p_caa_title => 'Exportiert Metadaten der dynamische Seiten',
    p_caa_shortcut => 'Alt+E',
    p_caa_initially_disabled => adc_util.C_TRUE,
    p_caa_initially_hidden => adc_util.C_FALSE,
    p_caa_href => '',
    p_caa_action => '');
  
  adc_admin.merge_apex_action_item(
    p_caai_caa_id => adc_admin.map_id(67),
    p_caai_cpi_crg_id => adc_admin.map_id(13),
    p_caai_cpi_id => 'B13_EXPORT_CRG',
    p_caai_active => adc_util.C_TRUE);



  adc_admin.propagate_rule_change(adc_admin.map_id(13));

  commit;
end;
/

set define on
