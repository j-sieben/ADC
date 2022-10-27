create or replace editionable view adc_action_item_focus_v as 
  select caif_id, pti_name caif_name, to_char(pti_description) caif_description, caif_actual_page_only, caif_item_types, caif_default, caif_active
  from adc_action_item_focus
  join pit_translatable_item_v
    on caif_pti_id = pti_id
   and caif_pmg_name = pti_pmg_name;
   
comment on table adc_action_item_focus_v is 'Wrapper with with translated column values';
