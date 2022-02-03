create or replace force view adc_ui_lov_action_param_type
as 
select cpt_name d, cpt_id r, cpt_active, cpt_sort_seq
  from adc_action_param_types_v;
