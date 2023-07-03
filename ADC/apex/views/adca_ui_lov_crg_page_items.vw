create or replace force view adca_ui_lov_crg_page_items
as
  with params as(
       select utl_apex.get_number('CRG_ID') p_crg_id,
              utl_apex.get_string('CRA_CAT_ID') p_cat_id
         from dual)
select /*+ no_merge (p) */
       distinct lpi.item_name d, lpi.item_id r, cpit_name grp
  from adc_bl_page_items lpi
  join adc_bl_page_targets lpt
    on lpi.item_id = lpt.cpi_id
  join adc_rule_groups cgr
    on lpi.app_id = cgr.crg_app_id
   and lpi.page_id = cgr.crg_page_id
  join adc_action_item_focus
    on instr(':' || caif_item_types || ':', ':' || lpt.cpi_cpitg_id || ':') > 0
    or instr(':' || caif_item_types || ':', ':' || lpt.cpi_cpit_id || ':') > 0
  join adc_action_types
    on caif_id = cat_caif_id
  join adc_page_item_types_v
    on cpi_cpit_id = cpit_id
  join params p
    on crg_id = p_crg_id
   and cat_id = p_cat_id;
    
comment on table adca_ui_lov_crg_page_items is 'Collection of all page items that are usable for the selected ADC action type';
