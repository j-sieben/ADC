create or replace editionable view adca_ui_lov_action_type_group
as 
select catg_name d, catg_id r, catg_active
  from adc_action_type_groups_v;
