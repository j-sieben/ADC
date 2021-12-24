-- Parameters:
-- None
define tool_dir=tools/

@&tool_dir.init.sql

prompt
prompt &section.
prompt &h1.Checking prerequisites
@install_scripts/check_prerequisites.sql

@&tool_dir.set_compiler_flags.sql

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Installation at user &INSTALL_USER.
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
