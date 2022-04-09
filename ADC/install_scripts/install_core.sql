-- Parameters:
-- None
clear screen

define tool_dir=tools/
@&tool_dir.init.sql


prompt
prompt &section.
prompt &h1.Checking prerequisites
@&tool_dir.set_compiler_flags.sql
@install_scripts/check_prerequisites.sql

prompt
prompt &section.
prompt &h1.Removing existing installation
@&plugin_dir.uninstall.sql
@core/uninstall.sql

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Installation
@&core_dir.install.sql

prompt
prompt &section.
prompt &h1.PLUGIN ADC
@&plugin_dir.install.sql

prompt
prompt &section.
prompt &h1.Optional unit test package installation
@&tool_dir.check_unit_test_exists.sql "unit_test/uninstall.sql" "clean up"
@&tool_dir.check_unit_test_exists.sql "unit_test/install.sql" "installation"

prompt &h1.Finished ADC-Installation

exit