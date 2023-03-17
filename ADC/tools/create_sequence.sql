col script new_value SCRIPT format a30
col msg new_value MSG format a30

set termout off

select case when count(*) = 0
         then '&seq_dir.&1..seq'
         else '&tool_dir.null.sql'
       end script,
       case when count(*) = 0 
         then '&s1.Create sequence &1.'
         else '&s1.Sequence &1. already exists'
       end msg
  from user_sequences
 where sequence_name = upper('&1.');
 
set termout on

prompt &MSG.
@&SCRIPT.
