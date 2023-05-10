create or replace force view adc_standard_messages_v
as 
select pti_id csm_id, pti_name csm_message, pti_description csm_description
  from pit_translatable_item_v
 where pti_id like 'CSM%'
   and pti_pmg_name = 'ADC';

comment on table adc_standard_messages_v is 'Transated view on ADC_standard_messages';