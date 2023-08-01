
prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.sadc.sql

set verify off
define script_dir=&APP_SCRIPT_DIR.
prompt &s1.Install ADC rules
@&tool_dir.run_script merge_rule_group_sadc_adact
@&tool_dir.run_script merge_rule_group_sadc_adadc
@&tool_dir.run_script merge_rule_group_sadc_adanf
@&tool_dir.run_script merge_rule_group_sadc_adrep
@&tool_dir.run_script merge_rule_group_sadc_adsta
@&tool_dir.run_script merge_rule_group_sadc_adval
@&tool_dir.run_script merge_rule_group_sadc_adval2
@&tool_dir.run_script merge_rule_group_sadc_caaex
@&tool_dir.run_script merge_rule_group_sadc_catpi
@&tool_dir.run_script merge_rule_group_sadc_doc
@&tool_dir.run_script merge_rule_group_sadc_edemp
@&tool_dir.run_script merge_rule_group_sadc_einit
@&tool_dir.run_script merge_rule_group_sadc_elems
@&tool_dir.run_script merge_rule_group_sadc_home
@&tool_dir.run_script merge_rule_group_sadc_menu_cat
@&tool_dir.run_script merge_rule_group_sadc_pseudo
@&tool_dir.run_script merge_rule_group_sadc_tutorial
@&tool_dir.run_script merge_rule_group_sadc_unittest
@&tool_dir.run_script merge_rule_group_sadc_useadc