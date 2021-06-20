-- Parameters:
-- 1: Owner of ADC
-- 2: APEX workspace name that contains the 
-- 3: ALIAS of the APEX-application. 
-- 4: ALIAS of the APEX-Sample application, if installed

@tools/init_uninstall.sql &1. &2. &3. &4.

alter session set current_schema=&INSTALL_USER.;

prompt &h1.State Chart Toolkit (ADC) Deinstallation

prompt &h2.Deinstall ADC sample application
@sample_app/clean_up_install.sql

prompt &h2.Deinstall ADC administration application
@apex/clean_up_install.sql

prompt &h2.Deinstall PLUGIN
@plugin/clean_up_install.sql

prompt &h2.Deinstall CORE Functionality
@core/clean_up_install.sql

@tools/check_unit_test_exists.sql "unit_test/uninstall.sql" "de-installation"
