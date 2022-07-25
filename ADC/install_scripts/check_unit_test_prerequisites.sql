declare
  l_pkg_exists pls_integer;
  l_ut_version varchar2(20 byte);
begin
  select count(*)
    into l_pkg_exists
    from dual
   where exists (
         select null
           from all_objects
          where object_name = 'UT'
            and object_type = 'PACKAGE');
  if l_pkg_exists = 1 then
    execute immediate q'^select ut.version
      from dual^' into l_ut_version;
            
    if l_ut_version < '&MIN_UT_VERSION.' then
      raise_application_error(-20000, 'utPLSQL must be installed in version >= >= &MIN_UT_VERSION., but is ');
    end if;
  else
    raise_application_error(-20000, 'utPLSQL must be installed in version >= &MIN_UT_VERSION., but is not.' );
  end if;
  
  dbms_output.put_line('&s1.Checked.');
exception
  when others then
    dbms_output.put_line(sqlerrm);
            
    if l_pkg_exists = 0 then
      raise_application_error(-20000, 'utPLSQL must be installed in version >= &MIN_UT_VERSION., but is not.' );
    end if;
end;
/
