
prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.sadc.sql

set verify off
prompt &s1.Install ADC rules
@&app_script_dir.merge_rule_group_sadc_adact.sql
@&app_script_dir.merge_rule_group_sadc_adanf.sql
@&app_script_dir.merge_rule_group_sadc_adrep.sql
@&app_script_dir.merge_rule_group_sadc_adsta.sql
@&app_script_dir.merge_rule_group_sadc_adval.sql
@&app_script_dir.merge_rule_group_sadc_adval2.sql
@&app_script_dir.merge_rule_group_sadc_elems.sql
@&app_script_dir.merge_rule_group_sadc_cat_page_item.sql
@&app_script_dir.merge_rule_group_sadc_doc.sql
@&app_script_dir.merge_rule_group_sadc_edemp.sql
@&app_script_dir.merge_rule_group_sadc_extended_initialization.sql
@&app_script_dir.merge_rule_group_sadc_menu_cat.sql
@&app_script_dir.merge_rule_group_sadc_unittest.sql