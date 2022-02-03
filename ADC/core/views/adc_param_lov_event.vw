create or replace view adc_param_lov_event as
select cit_name d, cit_id r, null cgr_id
  from adc_page_item_types_v
 where cit_is_custom_event = (select adc_util.c_true from dual)
 order by cit_id;
 
comment on table adc_param_lov_event is 'Parameterview to display all custom events';