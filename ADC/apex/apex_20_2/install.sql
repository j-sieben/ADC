define apex_dir=apex/
define apex_version_dir=&apex_dir.&APEX_PATH./
define app_dir=&apex_version_dir.application/
define script_dir=&apex_version_dir.scripts/

prompt &s1.Install action types
--@&script_dir.merge_action_types.sql

prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.adc.sql
--@&app_dir.adc_manual.sql
