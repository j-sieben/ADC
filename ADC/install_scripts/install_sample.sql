-- Parameters:
-- 1: APEX workspace name
-- 2: Optional APP_ID
define tool_dir=tools/
clear screen

@&tool_dir.init_apex.sql &1. &2. SADC

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Sample Application Installation

@&tool_dir.set_compiler_flags.sql

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) APEX Sample Application Installation
@sample_app/install.sql


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
prompt &h1.Finished ADC Sample Installation

exit
