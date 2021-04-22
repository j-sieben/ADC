create or replace editionable view adc_ui_lov_action_item_focus
as 
select cif_name d, cif_id r, cif_active
  from adc_action_item_focus_v;
