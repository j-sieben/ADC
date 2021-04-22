create or replace editionable view adc_ui_admin_cif
as 
select cif_id, cif_name, cif_description, a.d cif_actual_page_only, b.d cif_active
  from adc_action_item_focus_v
  join adc_ui_lov_yes_no a
    on cif_actual_page_only = a.r
  join adc_ui_lov_yes_no b
    on cif_active = b.r;

comment on table adc_ui_admin_cif is 'View for APEX report page ADMIN_SIF';