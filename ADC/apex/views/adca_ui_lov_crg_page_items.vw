create or replace force view adca_ui_lov_crg_page_items
as
with params as(
       select /*+ no_merge */
              utl_apex.get_number('CRG_ID') p_crg_id,
              utl_apex.get_string('CRA_CAT_ID') p_cat_id
         from dual),
       items as(
         select cpit_name || ' ' || cpi_id d, cpi_id r, cpit_name grp, cpi_crg_id, cpit_cpitg_id, cpit_id
           from adc_page_items
           join adc_page_item_types_v
             on cpi_cpit_id = cpit_id
         union all
         select cpit_name || ' ' || caa_name, caa_name, cpit_name, caa_crg_id, cpit_cpitg_id, cpit_id
           from adc_apex_actions
           join adc_page_item_types_v
             on cpit_id = 'COMMAND'
       )
select distinct d, r, grp
  from items
  join params
    on cpi_crg_id = p_crg_id
  join adc_action_item_focus
    on instr(':' || caif_item_types || ':', ':' || cpit_cpitg_id || ':') > 0
    or instr(':' || caif_item_types || ':', ':' || cpit_id || ':') > 0
  join adc_action_types
    on caif_id = cat_caif_id
   and cat_id = p_cat_id;
    
comment on table adca_ui_lov_crg_page_items is 'Collection of all page items that are usable for the selected ADC action type';
