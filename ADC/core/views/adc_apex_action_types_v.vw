create or replace editionable view adc_apex_action_types_v as 
  select cty_id, pti_name cty_name, to_char(pti_description) cty_description, cty_active
  from adc_apex_action_types
  join pit_translatable_item_v
    on cty_pti_id = pti_id
   and cty_pmg_name = pti_pmg_name;
