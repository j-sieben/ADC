create or replace editionable view adc_action_item_focus_v as 
  select cif_id, pti_name cif_name, to_char(pti_description) cif_description, cif_actual_page_only, cif_item_types, cif_default, cif_active
  from adc_action_item_focus
  join pit_translatable_item_v
    on cif_pti_id = pti_id
   and cif_pmg_name = pti_pmg_name;
   
comment on table adc_action_item_focus_v is 'Wrapper with with translated column values';
