set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
/*
whenever sqlerror continue
alter session set plsql_implicit_conversion_bool = true;

whenever sqlerror exit
*/
set termout off
col default_language new_val DEFAULT_LANGUAGE format a30
col apex_path new_val APEX_PATH format a20
col with_flows new_val WITH_FLOWS format a20

define MIN_UT_VERSION=3.1

-- Common directory paths
define core_dir=core/
define plugin_dir=plugin/

select pit.get_default_language default_language,       
       case 
         when utl_apex.get_apex_version >= 23.1 then 'apex_23_1'
         when utl_apex.get_apex_version >= 20.2 then 'apex_20_2'
       end apex_path
  from dual;
  
@settings.sql
  
declare
  l_version number;
  x_old_Version exception;
begin
  -- Dynamic PL/SQL to avoid compilation errors
  execute immediate 'begin :x := pit.version; end' using out l_version;
  if l_version < 1.2 then
   raise x_old_version;
  end if;
exception
  when others then
    raise_application_error(-20000, 'PIT in version 1.2 or greater is required to install ADC');
end;
/
   
col ora_name_type new_val ORA_NAME_TYPE format a30
select 'varchar2(' || data_length || ' byte)' ora_name_type
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';
   
-- Copy boolean value type from PIT
col FLAG_TYPE  new_val FLAG_TYPE format a128
col C_FALSE  new_val C_FALSE format a128
col C_TRUE  new_val C_TRUE format a128

select lower(data_type) ||    
         case when data_type in ('CHAR', 'VARCHAR2') then '(' || data_length || case char_used when 'B' then ' byte)' else ' char)' end
         when data_type in ('NUMBER') then '(' || data_precision || ', ' || data_scale || ')'
         else null
       end FLAG_TYPE,
       case when data_type in ('CHAR', 'VARCHAR2') then dbms_assert.enquote_literal(pit_util.c_true) else to_char(pit_util.c_true) end C_TRUE, 
       case when data_type in ('CHAR', 'VARCHAR2') then dbms_assert.enquote_literal(pit_util.c_false) else to_char(pit_util.c_false) end C_FALSE
  from all_tab_columns
 where table_name = 'PARAMETER_LOCAL'
   and column_name = 'PAL_BOOLEAN_VALUE';
   

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout on
