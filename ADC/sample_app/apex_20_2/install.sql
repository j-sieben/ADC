define sample_dir=sample_app/
define apex_version_dir=&sample_dir.&APEX_PATH./
define app_dir=&apex_version_dir.application/
define script_dir=&apex_version_dir.scripts/


prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.sadc.sql
