create or replace editionable view adca_ui_lov_apex_action_type
as 
select caat_name d, caat_id r
  from adc_apex_action_types_v
 where caat_active = utl_apex.C_TRUE;
