column script new_value script
column msg new_value msg
set termout off

select case when count(*) = 0
         then '&tool_dir.add_column.sql &1. &2. "&3."'
         else '&tool_dir.null.sql'
       end script,
       case when count(*) = 0
         then '&s1.Add column &2. at &1.'
         else '&s1.Column &2. already exists at &1.'
       end msg
  from user_tab_columns
 where table_name = upper('&1.')
   and column_name = upper('&2.');
set termout on

prompt &MSG.
@&script.
