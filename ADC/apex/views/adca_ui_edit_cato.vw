create or replace editionable view adca_ui_edit_cato
as 

select cato_id, cato_description, cato_active
  from adc_action_type_owners_v;

comment on table adca_ui_edit_cato is 'View for APEX page EDIT_CATO';