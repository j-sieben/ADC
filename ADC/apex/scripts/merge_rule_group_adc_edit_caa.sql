
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup #CGR_NAME#');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 9);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(#CGR_ID#),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 9,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(637),
    p_cru_cgr_id => adc_admin.map_id(635),
    p_cru_name => 'Initialisierung',
    p_cru_condition => q'|initializing = 1|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(639),
    p_cra_cru_id => adc_admin.map_id(637),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'P9_CAA_CTY_ID',
    p_cra_cat_id => 'SET_ITEM',
    p_cra_param_1 => q'|'ACTION'|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(641),
    p_cra_cru_id => adc_admin.map_id(637),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'P9_CAA_CTY_ID',
    p_cra_cat_id => 'DISABLE_ITEM',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(643),
    p_cru_cgr_id => adc_admin.map_id(635),
    p_cru_name => 'Aktionstyp ACTION gewählt',
    p_cru_condition => q'|P9_CAA_CTY_ID = 'ACTION'|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(645),
    p_cra_cru_id => adc_admin.map_id(643),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.adc-ui-action-mandatory|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 30,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(647),
    p_cra_cru_id => adc_admin.map_id(643),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SHOW_HIDE_ITEMS',
    p_cra_param_1 => q'|.adc-ui-action|',
    p_cra_param_2 => q'|.adc-ui-hide|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(649),
    p_cra_cru_id => adc_admin.map_id(643),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'P9_CAA_CAI_LIST',
    p_cra_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(651),
    p_cru_cgr_id => adc_admin.map_id(635),
    p_cru_name => 'Aktionstyp TOGGLE gewählt',
    p_cru_condition => q'|P9_CAA_CTY_ID = 'TOGGLE'|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(653),
    p_cra_cru_id => adc_admin.map_id(651),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SHOW_HIDE_ITEMS',
    p_cra_param_1 => q'|.adc-ui-toggle|',
    p_cra_param_2 => q'|.adc-ui-hide|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(655),
    p_cra_cru_id => adc_admin.map_id(651),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'P9_CAA_CAI_LIST',
    p_cra_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(657),
    p_cru_cgr_id => adc_admin.map_id(635),
    p_cru_name => 'Aktionstyp RADIO_GROUP gewählt',
    p_cru_condition => q'|P9_CAA_CTY_ID = 'RADIO_GROUP'|',
    p_cru_sort_seq => 40,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(659),
    p_cra_cru_id => adc_admin.map_id(657),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'SHOW_HIDE_ITEMS',
    p_cra_param_1 => q'|.adc-ui-list|',
    p_cra_param_2 => q'|.adc-ui-hide|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(661),
    p_cra_cru_id => adc_admin.map_id(657),
    p_cra_cgr_id => adc_admin.map_id(635),
    p_cra_cpi_id => 'P9_CAA_CAI_LIST',
    p_cra_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  

  adc_admin.propagate_rule_change(adc_admin.map_id(#CGR_ID#));

  commit;
end;
/

set define on
