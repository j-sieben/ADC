prompt &s1.Install action types
--@&script_dir.merge_action_types.sql

prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.adc.sql

prompt &s1.Add rule groups
@&script_dir.merge_rule_group_adc_admin_cat
@&script_dir.merge_rule_group_adc_designer
@&script_dir.merge_rule_group_adc_edit_cpt
@&script_dir.merge_rule_group_adc_export_cat
@&script_dir.merge_rule_group_adc_export_cgr
