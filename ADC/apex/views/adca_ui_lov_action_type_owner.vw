create or replace editionable view adca_ui_lov_action_type_owner
as 
select cato_id d, cato_id r, cato_active
  from adc_action_type_owners_v;
