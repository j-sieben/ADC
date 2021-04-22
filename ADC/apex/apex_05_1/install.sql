define apex_dir=apex/
define apex_version_dir=&apex_dir.&APEX_PATH./
define app_dir=&apex_version_dir.application/
define script_dir=&apex_version_dir.scripts/

prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package PLUGIN_GROUP_SELECT_LIST
@&script_dir.plugin_group_select_list.pks
show errors

prompt &s1.Create package Body PLUGIN_GROUP_SELECT_LIST
@&script_dir.plugin_group_select_list.pkb
show errors

prompt &s1.Install action types
@&script_dir.merge_action_types.sql

prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.adc.sql
@&app_dir.adc_manual.sql

prompt &s1;install Group Select List plugin
@&script_dir.item_type_plugin_de_condes_plugin_group_select_list.sql

