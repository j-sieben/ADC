create or replace force view adca_ui_lov_action_item_focus
as 
select caif_name d, caif_id r, caif_active
  from adc_action_item_focus_v;
