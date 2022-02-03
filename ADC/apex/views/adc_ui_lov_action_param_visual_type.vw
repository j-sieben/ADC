create or replace force view adc_ui_lov_action_param_visual_type
as 
select cpv_name d, cpv_id r, cpv_active, cpv_sort_seq
  from adc_action_param_visual_types_v;

comment on table adc_ui_lov_action_param_visual_type is 'LOV-View for ADC_ACTION_PARAM_VISUAL_TYPE';