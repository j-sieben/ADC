-- Parameters:
-- None

@tools/init_apex.sql ADC
clear screen

prompt &h1.APEX Dynamic Controller (ADC) Deinstallation

prompt &h2.Deinstall PLUGIN
@plugin/uninstall.sql

prompt &h2.Deinstall CORE Functionality
@core/uninstall.sql

@unit_test/uninstall.sql "de-installation"

prompt &h1.Finished ADC Deinstallation

exit