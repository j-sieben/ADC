set termout off

variable script_name varchar2(100);
variable with_ut varchar2(5);
variable comments varchar2(1000);


declare
  l_pkg_exists pls_integer;
  C_NULL_SCRIPT constant varchar2(100) := '&tool_dir.null.sql';
begin
  select count(*)
    into l_pkg_exists
    from dual
   where exists (
         select null
           from user_objects
          where object_name = 'ADC'
            and object_type = 'TYPE');
  if l_pkg_exists = 0 then
    execute immediate q'^select '&type_dir.&1..tps' from dual^' into :script_name;
  else
    :script_name := C_NULL_SCRIPT;
    :comments := '&s1.Type ADC exists already, skipping overwrite.';
    :with_ut := 'false';
  end if;
end;
/

column script new_value SCRIPT
select :script_name script
  from dual;

set termout on

begin
  if :comments is not null then
    dbms_output.put_line(:comments);
  end if;
end;
/


@&script.