create or replace force view adc_param_lov_apex_action
as 
select caa_name d, caa_id r, caa_crg_id crg_id
  from adc_apex_actions;

comment on table adc_param_lov_apex_action is 'List of page commands, groupt by CRG_ID';