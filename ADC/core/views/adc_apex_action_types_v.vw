create or replace editionable view adc_apex_action_types_v as 
  select caat_id, pti_name caat_name, to_char(pti_description) caat_description, caat_active
  from adc_apex_action_types
  join pit_translatable_item_v
    on caat_pti_id = pti_id
   and caat_pmg_name = pti_pmg_name;
