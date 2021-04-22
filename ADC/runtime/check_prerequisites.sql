
declare
  l_is_installed pls_integer;
begin
  select count(*)
    into l_is_installed
	from all_objects
   where object_type = 'PACKAGE'
	 and object_name in ('PIT', 'UTL_TEXT', 'UTL_APEX');
  if l_is_installed < 3 then
    raise_application_error(-20000, 'Installation of PIT/UTL_TEXT/UTL_APEX is required to install ADC. Please make sure that these packages are installed.');
  else
    dbms_output.put_line('&s1.Installation prerequisites checked succesfully.');
  end if;
end;
/
