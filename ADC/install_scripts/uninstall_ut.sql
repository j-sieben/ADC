-- Parameters:
-- None

@tools/init.sql
clear screen

prompt &h1.State Chart Toolkit (ADC) Unit Test Deinstallation

prompt &h2.Deinstall PLUGIN
@unit_test/uninstall.sql

prompt &h1.Finished ADC Unit Test Deinstallation

exit