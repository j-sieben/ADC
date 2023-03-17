create or replace view adc_bl_bind_items as
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
 where cpit_cet_id is not null
   and (cpi_is_required = adc_util.C_TRUE
    or cgs_cpi_id is not null)
   and crg_active = adc_util.C_TRUE
 union all
       -- List of items which have to be bound due to dynamic validation
select cra_crg_id, cra_cpi_id, cet_id, adc_util.C_TRUE, to_char(cra_param_2)
  from adc_rule_actions
  join adc_event_types
    on cet_id member of utl_text.string_to_table(cra_param_1, ':')
 where cra_cat_id = 'VALIDATE_ITEMS'
 union all
       -- List of items which have to be bound to custom specific events
select cra_crg_id, cra_cpi_id, cet_id, adc_util.C_FALSE, to_char(cra_param_2)
  from adc_rule_actions
  join adc_event_types
    on cet_id member of utl_text.string_to_table(cra_param_1, ':')
 where cra_cat_id = 'MONITOR_EVENT';