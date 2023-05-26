
prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.sadc.sql

set verify off
prompt &s1.Install ADC rules
@&app_script_dir.merge_rule_group_sadc_adact
@&app_script_dir.merge_rule_group_sadc_adadc
@&app_script_dir.merge_rule_group_sadc_adanf
@&app_script_dir.merge_rule_group_sadc_adrep
@&app_script_dir.merge_rule_group_sadc_adsta
@&app_script_dir.merge_rule_group_sadc_adval
@&app_script_dir.merge_rule_group_sadc_adval2
@&app_script_dir.merge_rule_group_sadc_caaex
@&app_script_dir.merge_rule_group_sadc_catpi
@&app_script_dir.merge_rule_group_sadc_doc
@&app_script_dir.merge_rule_group_sadc_edemp
@&app_script_dir.merge_rule_group_sadc_einit
@&app_script_dir.merge_rule_group_sadc_elems
@&app_script_dir.merge_rule_group_sadc_home
@&app_script_dir.merge_rule_group_sadc_menu_cat
@&app_script_dir.merge_rule_group_sadc_pseudo
@&app_script_dir.merge_rule_group_sadc_tutorial
@&app_script_dir.merge_rule_group_sadc_unittest
@&app_script_dir.merge_rule_group_sadc_useadc