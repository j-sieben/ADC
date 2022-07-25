create or replace view adc_ui_lov_item_types as
select distinct pti_name d, replace(replace(pti_id, 'ITEM_TYPE_'), 'CIT_') r
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC'
   and pti_id like 'ITEM_TYPE%'
    or pti_id like 'CIT%';
   
comment on table adc_ui_lov_item_types is 'LOV View for the item types referenced in ADC_ACTION_ITEM_FOCUS';