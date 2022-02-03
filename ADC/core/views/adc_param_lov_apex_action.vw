create or replace view adc_param_lov_apex_action
as 
select caa_name d, caa_id r, caa_cgr_id cgr_id
  from adc_apex_actions;

comment on table adc_param_lov_item_status is 'List of page commands, groupt by CGR_ID';