create or replace editionable view adc_ui_lov_apex_action_type
as 
select cty_name d, cty_id r
  from adc_apex_action_types_v;
