create or replace force view adc_ui_list_action_type
as
with params as(
       select /*+ no_merge */ utl_apex.get_number('CGR_ID') p_cgr_id,
              ':' p_del
         from dual)
select cat_name || case cat_active when adc_util.C_FALSE then ' (deprecated)' end d, cat_id r, ctg_description grp
  from adc_action_types_v
  join adc_action_type_groups_v
    on cat_ctg_id = ctg_id
 where exists(
       select null
         from adc_action_item_focus
         join adc_page_item_types
           on instr(':' || cif_item_types || ':', ':' || cit_id || ':') > 0
           or instr(':' || cif_item_types || ':', ':' || cit_cig_id || ':') > 0
         join adc_page_items
           on cpi_cit_id = cit_id
         join params
           on cpi_cgr_id = p_cgr_id
        where cpi_id not in ('COMMAND')
          and cif_id = cat_cif_id)
    or (cat_cif_id = 'COMMAND'
   and exists(
       select null
         from adc_apex_actions
         join params
           on caa_cgr_id = p_cgr_id));
        
comment on table adc_ui_list_action_type is 'List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.';