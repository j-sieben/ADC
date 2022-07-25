-- Parameters:
-- None
-- clear screen

define tool_dir=tools/
@&tool_dir.init.sql


prompt
prompt &section.
prompt &h1.Checking prerequisites
@&tool_dir.set_compiler_flags.sql
@install_scripts/check_unit_test_prerequisites.sql

prompt
prompt &section.
prompt &h1.Removing existing installation
@unit_test/uninstall.sql

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Unit Test Installation
@unit_test/install.sql

prompt &h1.Finished ADC Unit Test Installation

exit