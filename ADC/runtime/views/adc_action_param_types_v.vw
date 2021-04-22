create or replace editionable view adc_action_param_types_v as 
  select cpt_id, pti_name cpt_name, pti_display_name cpt_display_name, to_char(pti_description) cpt_description, cpt_item_type, cpt_active
  from adc_action_param_types
  join pit_translatable_item_v
    on cpt_pti_id = pti_id
   and cpt_pmg_name = pti_pmg_name;

comment on table adc_action_param_types_v is 'Wrapper with with translated column values';