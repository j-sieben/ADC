-- Parameters:
-- None

@tools/init_apex.sql &1. &2. ADCA
clear screen

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC)Deinstallation

prompt &h2.Deinstall Sample Application
@sample_app/uninstall.sql

prompt &h2.Deinstall Administration Application
@apex/uninstall.sql

prompt &h2.Deinstall PLUGIN
@plugin/uninstall.sql

prompt &h2.Deinstall CORE Functionality
@core/uninstall.sql

@tools/check_unit_test_exists.sql "unit_test/uninstall.sql" "de-installation"

prompt &h1.Finished ADC Deinstallation

exit