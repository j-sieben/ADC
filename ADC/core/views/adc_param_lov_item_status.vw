create or replace view adc_param_lov_item_status as
select pti_name d, substr(pti_id, 15) r, null crg_id
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC'
   and pti_id like 'ITEM_STATUS_%';
   
comment on table adc_param_lov_item_status is 'List of translatable items of for that parameter type';