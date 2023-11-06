declare
  l_exists binary_integer;
  l_missing_privs varchar2(1000 byte);
begin
  
  -- PIT must be available
  select count(*)
    into l_exists
    from dual
   where exists(
         select null
           from all_objects
          where object_name = 'PIT');
          
  if l_exists = 0 then
    raise_application_error(-20000, 'PIT is required to install ADC.');
  end if;  
  
  -- UTL_APEX must be available
  select count(*)
    into l_exists
    from dual
   where exists(
         select null
           from user_objects
          where object_name = 'UTL_APEX');
          
  if l_exists = 0 then
    raise_application_error(-20000, 'UTL_APEX is required to install ADC.');
  end if;
  
  with required_privs as(
         select 'CREATE PROCEDURE' p_privilege
           from dual
          union all
         select 'CREATE VIEW' from dual)
  select listagg(p_privilege, ', ') within group (order by p_privilege) missing_privs
    into l_missing_privs
    from required_privs
    left join user_sys_privs
      on p_privilege = privilege
   where privilege is null;
  
  if l_missing_privs is not null then
    dbms_output.put_line('ATTENTION: The owner of ADC lacks the directly granted privilege(s) ' || l_missing_privs || ', the functionality is reduced.');
  end if;
  
  dbms_output.put_line('&s1.Checked.');
end;
/

set termout off

col util_owner new_val UTIL_OWNER format a128
select owner util_owner
  from all_objects
 where object_name = 'PIT'
   and object_type = 'PACKAGE'
   and rownum = 1;
   
set termout on
