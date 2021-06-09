define apex_dir=apex/
define apex_version_dir=&apex_dir.&APEX_PATH./
define seq_dir=&apex_dir.sequences/
define table_dir=&apex_dir.tables/
define type_dir=&apex_dir.types/
define view_dir=&apex_dir.views/
define pkg_dir=&apex_dir.packages/
define script_dir=&apex_dir.scripts/
define msg_dir=&apex_dir.messages/&DEFAULT_LANGUAGE./

prompt &h2.Remove existing installation
@&apex_dir.clean_up_install.sql

prompt &h2.Create database objects
prompt &h3.Create views

prompt &s1.Create view ADC_UI_LOV_ACTION_ITEM_FOCUS
@&view_dir.adc_ui_lov_action_item_focus.vw

prompt &s1.Create view ADC_UI_LOV_ACTION_PARAM_TYPE
@&view_dir.adc_ui_lov_action_param_type.vw

prompt &s1.Create view ADC_UI_LOV_ACTION_TYPE_GROUP
@&view_dir.adc_ui_lov_action_type_group.vw

prompt &s1.Create view ADC_UI_LOV_APEX_ACTION_ITEMS
@&view_dir.adc_ui_lov_apex_action_items.vw

prompt &s1.Create view ADC_UI_LOV_APEX_ACTION_TYPE
@&view_dir.adc_ui_lov_apex_action_type.vw

prompt &s1.Create view ADC_UI_LOV_APEX_ACTION
@&view_dir.adc_ui_lov_apex_action.vw

prompt &s1.Create view ADC_UI_LOV_APPLICATIONS
@&view_dir.adc_ui_lov_applications.vw

prompt &s1.Create view ADC_UI_LOV_APP_PAGES
@&view_dir.adc_ui_lov_app_pages.vw

prompt &s1.Create view ADC_UI_LOV_CGR_APPLICATIONS
@&view_dir.adc_ui_lov_cgr_applications.vw

prompt &s1.Create view ADC_UI_LOV_CGR_APP_PAGES
@&view_dir.adc_ui_lov_cgr_app_pages.vw

prompt &s1.Create view ADC_UI_LOV_CGR_PAGE_ITEMS
@&view_dir.adc_ui_lov_cgr_page_items.vw

prompt &s1.Create view ADC_UI_LOV_EXPORT_CAT
@&view_dir.adc_ui_lov_export_cat.vw

prompt &s1.Create view ADC_UI_LOV_EXPORT_TYPES
@&view_dir.adc_ui_lov_export_types.vw

prompt &s1.Create view ADC_UI_LOV_PAGE_ITEM_TYPE
@&view_dir.adc_ui_lov_page_item_type.vw

prompt &s1.Create view ADC_UI_LOV_PAGE_ITEMS_P11
@&view_dir.adc_ui_lov_page_items_p11.vw

prompt &s1.Create view ADC_UI_LOV_PAGE_ITEMS
@&view_dir.adc_ui_lov_page_items.vw

prompt &s1.Create view ADC_UI_LOV_YES_NO
@&view_dir.adc_ui_lov_yes_no.vw

prompt &s1.Create view ADC_UI_ADMIN_CAT
@&view_dir.adc_ui_admin_cat.vw

prompt &s1.Create view ADC_UI_ADMIN_CGR_COMMANDS
@&view_dir.adc_ui_admin_cgr_commands.vw

prompt &s1.Create view ADC_UI_ADMIN_CGR_MAIN
@&view_dir.adc_ui_admin_cgr_main.vw

prompt &s1.Create view ADC_UI_ADMIN_CGR_OVERVIEW
@&view_dir.adc_ui_admin_cgr_overview.vw

prompt &s1.Create view ADC_UI_ADMIN_CGR_RULES
@&view_dir.adc_ui_admin_cgr_rules.vw

prompt &s1.Create view ADC_UI_ADMIN_CIF
@&view_dir.adc_ui_admin_cif.vw

prompt &s1.Create view ADC_UI_EDIT_CAA
@&view_dir.adc_ui_edit_caa.vw

prompt &s1.Create view ADC_UI_EDIT_CAT
@&view_dir.adc_ui_edit_cat.vw

prompt &s1.Create view ADC_UI_EDIT_CGR
@&view_dir.adc_ui_edit_cgr.vw

prompt &s1.Create view ADC_UI_EDIT_CGR_APEX_ACTION
@&view_dir.adc_ui_edit_cgr_apex_action.vw

prompt &s1.Create view ADC_UI_EDIT_CIF
@&view_dir.adc_ui_edit_cif.vw

prompt &s1.Create view ADC_UI_EDIT_CRA
@&view_dir.adc_ui_edit_cra.vw

prompt &s1.Create view ADC_UI_EDIT_CRU
@&view_dir.adc_ui_edit_cru.vw

prompt &s1.Create view ADC_UI_EDIT_CRU_ACTION
@&view_dir.adc_ui_edit_cru_action.vw

prompt &s1.Create view ADC_UI_EDIT_CTG
@&view_dir.adc_ui_edit_ctg.vw

prompt &s1.Create view ADC_UI_EDIT_RULE
@&view_dir.adc_ui_edit_rule.vw

prompt &s1.Create view ADC_UI_EDIT_RULE_ACTION
@&view_dir.adc_ui_edit_rule_action.vw

prompt &s1.Create view ADC_UI_LIST_ACTION_TYPE
@&view_dir.adc_ui_list_action_type.vw

prompt &s1.Create view ADC_UI_LIST_PAGE_ITEMS
@&view_dir.adc_ui_list_page_items.vw


prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_ADC.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package ADC_UI
@&pkg_dir.adc_ui.pks
show errors

prompt &s1.Create package Body ADC_UI
@&pkg_dir.adc_ui.pkb
show errors

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql
