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
           from all_objects
          where object_name = 'UT'
            and object_type = 'PACKAGE');
  if l_pkg_exists = 1 then
    :with_ut := 'true';
  else
    :script_name := C_NULL_SCRIPT;
    :comments := '&s1.utplsql not installed, skipping installation of unit tests.';
    :with_ut := 'false';
  end if;
exception
  when others then
    dbms_output.put_line(sqlerrm);
    :comments := '&s1.utplsql not installed, skipping installation of unit tests.';
    :script_name := C_NULL_SCRIPT;
    :with_ut := 'false';
end;
/

column script new_value SCRIPT
select :script_name script
  from dual;
  
column with_ut new_value with_ut
select :with_ut with_ut
  from dual;

set termout on

begin
  if :comments is not null then
    dbms_output.put_line(:comments);
  end if;
end;
/


@&script.