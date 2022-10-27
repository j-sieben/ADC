create or replace view adca_ui_admin_capt as
select capt_id, capt_name, 
       case capt_active when adc_util.C_TRUE then 'fa-check' else 'fa-cross' end capt_active, capvt_name capt_parameter_type
  from adc_action_param_types_v
  join adc_action_param_visual_types_v
    on capt_capvt_id = capvt_id;

comment on table adca_ui_admin_capt is 'View for APEX report page ADMIN_CAPT';