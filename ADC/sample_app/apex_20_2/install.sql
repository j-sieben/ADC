
prompt &h3.Install APEX-application from folder &APEX_PATH.
prompt &s1.Prepare installation
@&apex_version_dir.prepare_apex_import.sql

prompt &s1.Install application
@&app_dir.sadc.sql

prompt &s1.Install ADC rules
&app_dir.scripts/merge_rule_group_sadc_useadc.sql
&app_dir.scripts/merge_rule_group_sadc_adact.sql
&app_dir.scripts/merge_rule_group_sadc_adadc.sql
&app_dir.scripts/merge_rule_group_sadc_adanf.sql
&app_dir.scripts/merge_rule_group_sadc_adrep.sql
&app_dir.scripts/merge_rule_group_sadc_adsta.sql
&app_dir.scripts/merge_rule_group_sadc_adval.sql
&app_dir.scripts/merge_rule_group_sadc_adval2.sql
&app_dir.scripts/merge_rule_group_sadc_cat_page_item.sql
&app_dir.scripts/merge_rule_group_sadc_doc.sql
&app_dir.scripts/merge_rule_group_sadc_edemp.sql
&app_dir.scripts/merge_rule_group_sadc_extended_initialization.sql
&app_dir.scripts/merge_rule_group_sadc_home.sql
&app_dir.scripts/merge_rule_group_sadc_menu_cat.sql
&app_dir.scripts/merge_rule_group_sadc_pseudo.sql
&app_dir.scripts/merge_rule_group_sadc_tutorial.sql
&app_dir.scripts/merge_rule_group_sadc_unittest.sql