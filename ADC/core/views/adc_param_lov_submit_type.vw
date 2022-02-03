create or replace view adc_param_lov_submit_type as
select pti_name d, substr(pti_id, 15) r, null cgr_id
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC'
   and pti_id like 'SUBMIT_TYPE%'
 order by pti_id;
  
comment on table adc_param_lov_submit_type is 'List of translatable items of for that parameter type';