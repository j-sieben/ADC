a-- Parameters:
-- 1: Owner of ADC, schema into which ADC will be installed
-- 2: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of ADC
-- 3: ALIAS of the APEX-application. 
-- 4: APP_ID of the APEX-application.
-- 5: Default language of the messages
define tool_dir=tools/
@&tool_dir.init_apex.sql &1. &2. &3. &4. &5.

alter session set current_schema=sys;
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@&tool_dir.check_users_exist.sql

prompt &h2.grant user rights
@set_grants.sql

alter session set current_schema=&INSTALL_USER.;
@&tool_dir.set_compiler_flags.sql
prompt
prompt &section.
prompt &h1.State Chart Toolkit (ADC)) APERX Application Installation at user &INSTALL_USER.
@apex/install.sql

prompt
prompt &section.
prompt &h1.Finalize installation
prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished ADC-Installation

exit
