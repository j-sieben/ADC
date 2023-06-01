create or replace force view adca_ui_admin_caif
as 
select caif_id, caif_name, caif_description, a.d caif_actual_page_only, b.d caif_active
  from adc_action_item_focus_v
  join adca_ui_lov_yes_no a
    on caif_actual_page_only = a.r
  join adca_ui_lov_yes_no b
    on caif_active = b.r;

comment on table adca_ui_admin_caif is 'View for APEX report page ADMIN_CIF';