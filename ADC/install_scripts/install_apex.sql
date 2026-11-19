-- Parameters:
-- 1: Name of the APEX workspace
-- 2: Optional APP-ID
-- 3: ADC version, 4: full Git commit

-- Capture product data before nested scripts replace positional arguments.
set define on
set scan on
define ADC_INSTALL_WORKSPACE = "&1."
define ADC_INSTALL_APP_ID = "&2."
@install_scripts/version.sql "&3." "&4."

define tool_dir=tools/

@&tool_dir.init_apex.sql "&ADC_INSTALL_WORKSPACE." "&ADC_INSTALL_APP_ID." ADCA

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) APEX Application Installation
@apex/install.sql

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

prompt &h1.Finished ADC APEX Installation

@install_scripts/verify_version.sql

exit
