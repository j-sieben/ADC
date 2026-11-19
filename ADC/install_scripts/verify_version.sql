-- SQL invocation deliberately checks static functions without a type instance.
set define on
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
set serveroutput on

declare
  l_invalid number;
  l_version varchar2(4000);
  l_commit varchar2(4000);
begin
  select count(*) into l_invalid
    from user_objects
   where (object_name = 'ADC_BASIC' and object_type in ('TYPE', 'TYPE BODY')
          or object_name in (
            select name from user_dependencies
             start with referenced_owner = user and referenced_name = 'ADC_BASIC'
             connect by nocycle prior name = referenced_name
                    and prior type = referenced_type and referenced_owner = user))
     and status <> 'VALID';
  if l_invalid > 0 then
    raise_application_error(-20000, 'ADC: ADC_BASIC or dependent objects are invalid. See USER_ERRORS.');
  end if;
  execute immediate 'select adc_basic.get_version(), adc_basic.get_git_commit() from dual'
    into l_version, l_commit;
  if l_version is null or l_commit is null
     or l_version <> '&ADC_VERSION.' or l_commit <> '&ADC_GIT_COMMIT.' then
    raise_application_error(-20000, 'ADC: Installed version/commit differs from installer data.');
  end if;
  dbms_output.put_line('ADC version ' || l_version || ', Git commit ' || l_commit || ' verified (SQL).');
end;
/
