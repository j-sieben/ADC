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
col default_language new_val DEFAULT_LANGUAGE format a30
col pit_owner new_val PIT_OWNER format a30
col apex_path new_val APEX_PATH format a20

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

select user sys_user,
       upper('&1.') install_user,
       upper('&2.') default_language
  from V$NLS_VALID_VALUES
 where parameter = 'LANGUAGE'
   and value = upper('&2.');
   
select owner pit_owner
  from dba_tab_privs
 where grantee = '&INSTALL_USER.'
   and table_name = 'PIT'
 fetch first 1 row only;

-- Apex Pfad anhand von installiertem APEX-Benutzer ermitteln
select case 
       when max(username) >= 'APEX_200200' then 'apex_20_2'
       when max(username) >= 'APEX_190100' then 'apex_19_1'
       else 'apex_05_1' end apex_path
  from all_users
 where username like 'APEX_______';

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