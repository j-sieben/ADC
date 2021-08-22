create or replace editionable view adc_ui_lov_cgr_page_items
as
select distinct lpi.item_name d, lpi.item_id r, cgr.cgr_id, cat_id, cit_name grp
  from adc_bl_page_items lpi
  join adc_bl_page_targets lpt
    on lpi.item_id = lpt.cpi_id
  join adc_rule_groups cgr
    on lpi.app_id = cgr.cgr_app_id
   and lpi.page_id = cgr.cgr_page_id
  join adc_action_item_focus
    on instr(cif_item_types, lpt.item_type) > 0
  join adc_action_types
    on cif_id = cat_cif_id
  join adc_page_item_types_v
    on cpi_cit_id = cit_id;