create or replace force view adca_ui_list_action_type
as
with params as(
       select /*+ no_merge */ p_crg_id,
              ':' p_del,
              case when crg_app_id = utl_apex.get_application_id then adc_util.c_true else adc_util.c_false end p_is_adca,
              adc_util.c_true c_true,
              adc_util.c_false c_false
         from adc_rule_groups
         join (select utl_apex.get_number('CRG_ID') p_crg_id
                 from dual)
           on crg_id = p_crg_id),
     exclude_list as(
       select column_value cat_excluded
         from table(
                utl_text.string_to_table(
                  param.get_string('ADC_EXCLUDE_ACTION_TYPES', 'ADC'), ':')))
select cat_name || case cat_active when adc_util.C_FALSE then ' (deprecated)' end d, cat_id r, catg_description grp
  from adc_action_types_v
 cross join params
  join adc_action_type_groups_v
    on cat_catg_id = catg_id
  left join exclude_list
    on cat_id = cat_excluded
 where ( -- Actiontypes must not be on the exclude list
       (p_is_adca = c_false and cat_excluded is null) 
       -- Action types for ADCA need to be internal action types
    or (p_is_adca = c_true and cat_cato_id = 'ADC'))
   and ( -- non command action types must reference an item type that exists on the page
       exists(
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
    or (-- command must be used on the actual page
       cat_caif_id = 'COMMAND'
   and exists(
       select null
         from adc_apex_actions
         join params
           on caa_crg_id = p_crg_id)));
        
comment on table adca_ui_list_action_type is 'List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.';