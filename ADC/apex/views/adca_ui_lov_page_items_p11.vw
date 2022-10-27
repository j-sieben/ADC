create or replace editionable view adca_ui_lov_page_items_p11
as
with params as (
       select v('P11_CRA_CRG_ID') p_crg_id,
              v('P11_CRA_CAT_ID') p_cat_id
         from dual)
select item_name d, item_id r
  from adc_bl_page_items
  join adc_rule_groups
    on app_id = crg_app_id
   and page_id = crg_page_id
  join adc_action_item_focus
    on instr(':' || caif_item_types || ':', ':' || item_type || ':') > 0
  join adc_action_types
    on caif_id = cat_caif_id
  join params p
    on crg_id = p_crg_id
   and cat_id = p_cat_id;