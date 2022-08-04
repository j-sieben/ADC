create or replace force view adc_ui_designer_rule_action
as 
select cra_id, cra_cgr_id, cra_cru_id, cra_cpi_id, cra_cat_id, cra_on_error,
       cra_param_1, 
       cra_param_1 cra_param_lov_1,
       cra_param_1 cra_param_area_1,
       cra_param_1 cra_param_switch_1,
       cra_param_2, 
       cra_param_2 cra_param_lov_2,
       cra_param_2 cra_param_area_2,
       cra_param_2 cra_param_switch_2,
       cra_param_3,
       cra_param_3 cra_param_lov_3,
       cra_param_3 cra_param_area_3,
       cra_param_3 cra_param_switch_3, 
       cra_comment, cra_raise_recursive, cra_raise_on_validation, cra_sort_seq, cra_active
  from adc_rule_actions;
  
comment on table adc_ui_designer_rule_action is 'Actual parameter values for a rule action, divided for the visualization types SELEWCT_LIST, TEXT_AREA, TEXT and SWITCH';