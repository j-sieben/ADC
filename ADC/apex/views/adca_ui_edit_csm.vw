create or replace force view adca_ui_edit_csm
as 
select csm_id, csm_message, csm_description
  from adc_standard_messages_v;

comment on table adca_ui_edit_csm is 'View for APEX page EDIT_CSM';