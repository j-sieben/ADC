create or replace view adc_param_lov_pit_message
as 
select pms_name d, 'msg.' || pms_name r, null cgr_id
  from pit_message
  join pit_message_language_v
    on pms_pml_name = pml_name
 where pml_default_order = 10;
 
comment on table adc_param_lov_pit_message is 'List of PIT messages';