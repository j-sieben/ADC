create or replace editionable view adc_ui_edit_rule_action
as 
select cra_id,
       cra_cgr_id,
       cra_cru_id,
       cra_cpi_id,
       cra_cat_id,
       cra_sort_seq,
       cra_param_1,
       cra_param_2,
       cra_param_3,
       cra_comment,
       cra_on_error,
       cra_raise_recursive,
       cra_active,
       cra_has_error
  from adc_rule_actions;
