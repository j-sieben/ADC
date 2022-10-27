create or replace editionable view adc_action_param_visual_types_v as 
select capvt_id, pti_name capvt_name, pti_display_name capvt_display_name, to_char(pti_description) capvt_description, capvt_sort_seq, capvt_active
  from adc_action_param_visual_types
  join pit_translatable_item_v
    on capvt_pti_id = pti_id
   and capvt_pmg_name = pti_pmg_name;

comment on table adc_action_param_visual_types_v is 'Wrapper with with translated column values';
