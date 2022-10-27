create or replace  view adc_event_types_v
as 
select cet_id, pti_name cet_name, cet_cpitg_id, cet_column_name, cet_is_custom_event
  from adc_event_types
  join pit_translatable_item_v
    on cet_pti_id = pti_id
   and cet_pmg_name = pti_pmg_name;

comment on table adc_event_types_v is 'Transated view on ADC_EVENT_TYPES';