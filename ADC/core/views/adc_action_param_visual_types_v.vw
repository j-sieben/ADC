create or replace editionable view adc_action_param_visual_types_v as 
select cpv_id, pti_name cpv_name, pti_display_name cpv_display_name, to_char(pti_description) cpv_description, cpv_sort_seq, cpv_active
  from adc_action_param_visual_types
  join pit_translatable_item_v
    on cpv_pti_id = pti_id
   and cpv_pmg_name = pti_pmg_name;

comment on table adc_action_param_visual_types_v is 'Wrapper with with translated column values';
