create or replace view adc_ui_admin_cpt as
select cpt_id, cpt_name, 
       case cpt_active when adc_util.C_TRUE then 'fa-check' else 'fa-cross' end cpt_active, cpv_name cpt_parameter_type
  from adc_action_param_types_v
  join adc_action_param_visual_types_v
    on cpt_cpv_id = cpv_id;

comment on table adc_ui_admin_cpt is 'View for APEX report page ADMIN_CPT';