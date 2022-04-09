declare
  l_exists binary_integer;
begin
  if '&1.' is not null then
    -- Workspace must exist
    select count(*)
      into l_exists
      from dual
     where exists(
           select null
             from apex_workspaces
            where workspace = upper('&1.'));
            
    if l_exists = 0 then
      raise_application_error(-20000, 'The workspace &1. is not available for user ' || user);
    end if;
  end if;
  
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
  
  dbms_output.put_line('&s1.Checked.');
end;
/