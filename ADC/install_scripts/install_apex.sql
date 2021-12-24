-- Parameters:
-- 1: Name of the APEX workspace
-- 2: Optional APP-ID

define tool_dir=tools/

@&tool_dir.init_apex.sql &1. &2. ADC

prompt
prompt &section.
prompt &h1.Checking prerequisites
@&tool_dir.set_compiler_flags.sql
@install_scripts/check_prerequisites.sql &1.

prompt
prompt &section.
prompt &h1.Removing existing installation
--@apex/uninstall.sql
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

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) APEX Application Installation
@apex/install.sql

prompt &h1.Finished ADC-Installation

exit
