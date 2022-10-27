create or replace force view adca_ui_lov_action_param_type
as 
select capt_name d, capt_id r, capt_active, capt_sort_seq
  from adc_action_param_types_v;
