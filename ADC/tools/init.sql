set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

set termout off
col default_language new_val DEFAULT_LANGUAGE format a30
col apex_path new_val APEX_PATH format a20

define MIN_UT_VERSION=3.1

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

select pit.get_default_language default_language
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
