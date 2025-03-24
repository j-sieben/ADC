create or replace force view adc_bl_bind_items as
with params as (
       select /*+ no_mere */ adc_util.c_true c_true,
              adc_util.c_false c_false
         from dual)
select crg_id, cpi_id, cpit_cet_id, cpit_has_value, to_char(null) static_action
  from adc_page_items
  join adc_page_item_types_v
    on cpi_cpit_id = cpit_id
  join adc_rule_groups
    on cpi_crg_id = crg_id
       -- List of mandatory items
  left join adc_rule_group_status
    on crg_id = cgs_crg_id
   and cpi_id = cgs_cpi_id
  join params  
    on cpit_cet_id is not null
   and (cpi_is_required = C_TRUE
    or cgs_cpi_id is not null)
   and crg_active = C_TRUE
 union all
       -- List of items which have to be bound due to dynamic validation
select cra_crg_id, cra_cpi_id, cet_id, C_TRUE, to_char(cra_param_2)
  from adc_rule_actions
  join adc_event_types
    on cet_id member of utl_text.string_to_table(cra_param_1, ':')
 cross join params
 where cra_cat_id = 'VALIDATE_ITEMS'
 union all
       -- List of items which have to be bound to custom specific events
select cra_crg_id, cra_cpi_id, cet_id, C_FALSE, to_char(cra_param_2)
  from adc_rule_actions
  join adc_event_types
    on cet_id member of utl_text.string_to_table(cra_param_1, ':')
 cross join params
 where cra_cat_id = 'MONITOR_EVENT';