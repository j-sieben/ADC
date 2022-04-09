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
col with_flows new_val WITH_FLOWS format a20

define MIN_UT_VERSION=3.1

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

select pit.get_default_language default_language,
       case when utl_apex.get_apex_version >= 20.2 then 'apex_20_2' end apex_path
  from dual;
  
@settings.sql
  
select case count(*) when 0 then 'false' else 'true' end with_flows
  from all_objects
 where object_name = 'FLOW_API'
   and object_type = 'PACKAGE';
   
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
