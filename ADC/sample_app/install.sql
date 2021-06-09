define sample_dir=sample_app/
define apex_version_dir=&sample_dir.&APEX_PATH./
define seq_dir=&sample_dir.sequences/
define table_dir=&sample_dir.tables/
define type_dir=&sample_dir.types/
define view_dir=&sample_dir.views/
define pkg_dir=&sample_dir.packages/
define script_dir=&sample_dir.scripts/
define msg_dir=&sample_dir.messages/&DEFAULT_LANGUAGE./

prompt &h2.Remove existing installation
@&sample_dir.clean_up_install.sql

prompt create HR tables
@?/demo/schema/human_resources/hr_cre.sql

prompt populate HR data
@?/demo/schema/human_resources/hr_popul.sql

prompt modify HR schema
@&script_dir.modify_hr_schema.sql

prompt &h2.Create database objects
prompt &h3.Create views

prompt &s1.Create view SADC_LOV_DEPARTMENT
@&view_dir.sadc_lov_department.vw

prompt &s1.Create view SADC_LOV_JOB
@&view_dir.sadc_lov_job.vw

prompt &s1.Create view SADC_UI_ADACT
@&view_dir.sadc_ui_adact.vw

prompt &s1.Create view SADC_UI_ADPTI
@&view_dir.sadc_ui_adpti.vw

prompt &s1.Create view SADC_UI_ADSTA
@&view_dir.sadc_ui_adsta.vw

prompt &s1.Create view SADC_UI_EDEMP
@&view_dir.sadc_ui_edemp.vw

prompt &s1.Create view SADC_UI_HOME
@&view_dir.sadc_ui_home.vw


prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_SADC.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package SADC_UI
@&pkg_dir.sadc_ui.pks
show errors

prompt &s1.Create package Body SADC_UI
@&pkg_dir.sadc_ui.pkb
show errors

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql

prompt &h3.Install SADC rules
prompt &s1.Create action types
--@&script_dir.action_types_system.sql

prompt &s1.Create page rules

