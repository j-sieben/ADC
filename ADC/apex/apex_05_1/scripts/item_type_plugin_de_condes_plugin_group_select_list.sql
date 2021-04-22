prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>2990503753058468
,p_default_application_id=>120
,p_default_owner=>'APEX_BUCH'
);
end;
/
prompt --application/shared_components/plugins/item_type/de_condes_plugin_group_select_list
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(32304421110053548)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'DE.CONDES.PLUGIN.GROUP_SELECT_LIST'
,p_display_name=>'Group Select List'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_cpi_version=>1
,p_render_function=>'plugin_group_select_list.render'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:SESSION_STATE:READONLY:ESCAPE_OUTPUT:QUICKPICK:SOURCE:ELEMENT:WIDTH:HEIGHT:ELEMENT_OPTION:PLACEHOLDER:ENCRYPT:LOV:LOV_DISPLAY_NULL:CASCADING_LOV'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(5530620842614878)
,p_plugin_id=>wwv_flow_api.id(32304421110053548)
,p_name=>'LOV'
,p_sql_min_column_count=>3
,p_sql_max_column_count=>3
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
