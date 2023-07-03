create or replace force view adca_ui_list_action_type
as
with params as(
       select /*+ no_merge */ utl_apex.get_number('CRG_ID') p_crg_id,
              ':' p_del
         from dual)
select cat_name || case cat_active when adc_util.C_FALSE then ' (deprecated)' end d, cat_id r, catg_description grp
  from adc_action_types_v
  join adc_action_type_groups_v
    on cat_catg_id = catg_id
 where exists(
       select null
         from adc_action_item_focus
         join adc_page_item_types
           on instr(':' || caif_item_types || ':', ':' || cpit_id || ':') > 0
           or instr(':' || caif_item_types || ':', ':' || cpit_cpitg_id || ':') > 0
           or instr(':' || caif_item_types || ':', ':DOCUMENT:') > 0
         join adc_page_items
           on cpi_cpit_id = cpit_id
         join params
           on cpi_crg_id = p_crg_id
        where cpi_id not in ('COMMAND')
          and caif_id = cat_caif_id)
    or (cat_caif_id = 'COMMAND'
   and exists(
       select null
         from adc_apex_actions
         join params
           on caa_crg_id = p_crg_id));
        
comment on table adca_ui_list_action_type is 'List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.';