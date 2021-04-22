create or replace editionable view adc_ui_lov_page_items_p11
as
with params as (
       select v('P11_CRA_CGR_ID') p_cgr_id,
              v('P11_CRA_CAT_ID') p_cat_id
         from dual)
select item_name d, item_id r
  from adc_bl_page_items
  join adc_rule_group
    on app_id = cgr_app_id
   and page_id = cgr_page_id
  join adc_action_item_focus
    on instr(':' || cif_item_types || ':', ':' || item_type || ':') > 0
  join adc_action_types
    on cif_id = cat_cif_id
  join params p
    on cgr_id = p_cgr_id
   and cat_id = p_cat_id;