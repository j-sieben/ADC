-- Parameters:
-- None

@tools/init_apex.sql ADC
clear screen

prompt &h1.State Chart Toolkit (ADC) Deinstallation

prompt &h2.Deinstall PLUGIN
@plugin/uninstall.sql

prompt &h2.Deinstall CORE Functionality
@core/uninstall.sql

@tools/check_unit_test_exists.sql "unit_test/uninstall.sql" "de-installation"

prompt &h1.Finished ADC Deinstallation

exit