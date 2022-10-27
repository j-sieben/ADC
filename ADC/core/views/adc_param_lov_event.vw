create or replace view adc_param_lov_event as
select cet_name d, cet_id r, null crg_id
  from adc_event_types_v
 where cet_is_custom_event = (select adc_util.c_true from dual)
 order by cet_id;
 
comment on table adc_param_lov_event is 'Parameterview to display all custom events';