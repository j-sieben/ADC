create or replace force view adc_ui_list_action_type
as
with params as(
       select utl_apex.get_number('CGR_ID') c_cgr_id
         from dual)
select cat_name || case cat_active when adc_util.C_FALSE then ' (deprecated)' end d, cat_id r, ctg_description grp
  from adc_action_types_v
  join adc_action_type_groups_v
    on cat_ctg_id = ctg_id
 where exists(
       select /*+ no_merge(p) */ null
         from adc_action_item_focus
         join adc_page_items
           on instr(cif_item_types, case when instr(cpi_cit_id, 'ITEM') > 0 then 'ELEMENT' else cpi_cit_id end) > 0
         join params p
           on (cpi_cgr_id = c_cgr_id or c_cgr_id is null)
        where cif_id = cat_cif_id);
        
comment on table adc_ui_list_action_type is 'List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.';