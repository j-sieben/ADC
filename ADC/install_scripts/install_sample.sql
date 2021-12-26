-- Parameters:
-- 1: APEX workspace name
-- 2: Optional APP_ID
define tool_dir=tools/
clear screen

prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) Sample Application Installation

@&tool_dir.init_apex.sql &1. &2. SADC

@&tool_dir.set_compiler_flags.sql
prompt
prompt &section.
prompt &h1.APEX Dynamic Controller (ADC) APEX Sample Application Installation
@sample_app/install.sql

prompt &h1.Finished Sample ADC-Installation

exit
