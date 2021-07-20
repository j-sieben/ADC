
prompt &h3.Grant SYSTEM privileges
prompt &s1.create session, create procedure, create table, create type, create view to &INSTALL_USER.
grant create session, create procedure, create table, create type, create view to &INSTALL_USER.;

prompt &h3.Grant OBJECT privileges

begin
  dbms_output.put_line('&s1.INHERIT PRIVILEGES from ' || user || ' to PUBLIC granted');
  execute immediate 'grant inherit privileges on user ' || user || ' to PUBLIC';
end;
/
