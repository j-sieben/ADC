prompt &s1.Install action types
--@&script_dir.merge_action_types.sql

prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.adca.sql

set verify off

prompt &s1.Add rule groups
@&script_dir.merge_rule_group_adca_admin_cat
@&script_dir.merge_rule_group_adca_designer
@&script_dir.merge_rule_group_adca_edit_capt