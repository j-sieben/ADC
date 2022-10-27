create or replace force view adca_ui_lov_action_param_visual_type
as 
select capvt_name d, capvt_id r, capvt_active, capvt_sort_seq
  from adc_action_param_visual_types_v;

comment on table adca_ui_lov_action_param_visual_type is 'LOV-View for ADC_ACTION_PARAM_VISUAL_TYPE';