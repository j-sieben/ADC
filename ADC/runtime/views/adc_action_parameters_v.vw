create or replace editionable view adc_action_parameters_v as 
  select cap_cat_id, cap_cpt_id, pti_name cap_display_name, to_char(pti_description) cap_description, cap_sort_seq, cap_default, cap_mandatory, cap_active
  from adc_action_parameters
  join pit_translatable_item_v
    on cap_pti_id = pti_id
   and cap_pmg_name = pti_pmg_name;
