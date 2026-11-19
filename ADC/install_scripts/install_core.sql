-- Parameters:
-- 1: APEX workspace (reserved), 2: ADC version, 3: full Git commit
-- clear screen

-- Capture product data before nested scripts replace positional arguments.
set define on
set scan on
@install_scripts/version.sql "&2." "&3."

define tool_dir=tools/
@&tool_dir.init.sql


prompt
prompt &section.
prompt &h1.Checking prerequisites
@&tool_dir.set_compiler_flags.sql
@install_scripts/check_prerequisites.sql

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
-- @&tool_dir.check_unit_test_exists.sql "unit_test/uninstall.sql" "clean up"
-- @&tool_dir.check_unit_test_exists.sql "unit_test/install.sql" "installation"

@&tool_dir.recompile.sql

prompt &h1.Finished ADC Core Installation

@install_scripts/verify_version.sql

exit