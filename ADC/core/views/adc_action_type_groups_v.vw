create or replace editionable view adc_action_type_groups_v as 
  select catg_id, pti_name catg_name, to_char(pti_description) catg_description, catg_active
  from adc_action_type_groups
  join pit_translatable_item_v
    on catg_pti_id = pti_id
   and catg_pmg_name = pti_pmg_name;
