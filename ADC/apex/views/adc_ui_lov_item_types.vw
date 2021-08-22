create or replace view adc_ui_lov_item_types as
select pti_name d, replace(pti_id, 'ITEM_TYPE_') r
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC'
   and pti_id like 'ITEM_TYPE%';
   
comment on table adc_ui_lov_item_types is 'LOV View for the item types referenced in ADC_ACTION_ITEM_FOCUS';