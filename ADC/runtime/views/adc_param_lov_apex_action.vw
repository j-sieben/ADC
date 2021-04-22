create or replace view adc_param_lov_apex_action
as 
select caa_name d, caa_id r, caa_cgr_id cgr_id
  from adc_apex_actions;
