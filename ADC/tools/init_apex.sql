set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

set termout off
col apex_ws new_val APEX_WS format a30
col apex_path new_val APEX_PATH format a20
col app_id new_val APP_ID format a30
col default_language new_val DEFAULT_LANGUAGE format a30

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

select upper('&1.') apex_ws, 
       coalesce((select application_id from apex_applications where alias = '&3.'), &2.) app_id,
       pit.get_default_language default_language,
       case when utl_apex.get_apex_version >= 20.2 then 'apex_20_2' end apex_path
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
    raise_application_error(-20000, 'APEX 20.2 or higher is required to install APC');
  end if;
end;
/
