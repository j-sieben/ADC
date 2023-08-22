-- Parameters:
-- None
-- clear screen

define tool_dir=tools/
@&tool_dir.init.sql


prompt
prompt &section.
prompt &h1.Checking prerequisites
@&tool_dir.set_compiler_flags.sql
@install_scripts/check_prerequisites_runtime.sql

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Installation
@&core_dir.install.sql

prompt
prompt &section.
prompt &h1.PLUGIN ADC
@&plugin_dir.install.sql


prompt &h1.Recompiling invalid objects
declare
  l_invalid_objects binary_integer;
begin
  dbms_utility.compile_schema(
    schema => user,
    compile_all => false);
    
  select count(*)
    into l_invalid_objects
    from user_objects
   where status = 'INVALID';
   
  dbms_output.put_line(l_invalid_objects || ' invalid objects found');
end;
/
prompt &h1.Finished ADC Runtime Installation

exit