set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

set termout off
col sys_user new_val SYS_USER format a30
col install_user new_val INSTALL_USER format a30
col app_id new_val APP_ID format a30
col apex_ws new_val APEX_WS format a30
col apex_alias new_val APEX_ALIAS
col apex_sample_alias new_val APEX_SAMPLE_ALIAS
col pit_owner new_val PIT_OWNER format a30
col apex_path new_val APEX_PATH format a20

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

   
select user sys_user,
       upper('&1.') install_user,
       upper('&2.') apex_ws,
       upper('&3.') apex_alias,
       upper('&4.') apex_sample_alias
  from dual;
 
select application_id app_id
  from apex_applications
 where workspace = '&APEX_WS.'
   and alias = '&APEX_ALIAS.';
   
   
select owner pit_owner
  from dba_tab_privs
 where grantee = '&INSTALL_USER.'
   and table_name = 'PIT'
 fetch first 1 row only;

-- Apex Pfad anhand von installiertem APEX-Benutzer ermitteln
select case 
       when &INSTALL_USER..utl_apex.get_apex_version != 20.2 then 'apex_20_2' end apex_path
  from dual;
  
@settings.sql
   
col ora_name_type new_val ORA_NAME_TYPE format a30
select 'varchar2(' || data_length || ' byte)' ora_name_type
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout on

begin
  if '&APEX_PATH.' is null then
    raise_application_error(-20000, 'APEX 20.2 or higher not found');
  end if;
end;
/