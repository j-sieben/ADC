create or replace editionable view adc_action_type_groups_v as 
  select ctg_id, pti_name ctg_name, to_char(pti_description) ctg_description, ctg_active
  from adc_action_type_groups
  join pit_translatable_item_v
    on ctg_pti_id = pti_id
   and ctg_pmg_name = pti_pmg_name;
