-- Parameters:
-- None
define tool_dir=tools/
@&tool_dir.init_apex.sql SADC

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) APEX Sample Application De-Installation
@sample_app/uninstall.sql

prompt &h1.Finished Sample ADC Application De-Installation

exit
