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

prompt &h1.Finished ADC-Installation

exit