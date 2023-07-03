create or replace force view adca_ui_lov_apex_action_type
as 
select caat_name d, caat_id r
  from adc_apex_action_types_v
 where caat_active = (select adc_util.C_TRUE from dual);
