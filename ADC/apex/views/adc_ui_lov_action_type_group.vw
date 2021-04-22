create or replace editionable view adc_ui_lov_action_type_group
as 
select ctg_name d, ctg_id r, ctg_active
  from adc_action_type_groups_v;
