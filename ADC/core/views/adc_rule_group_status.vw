create or replace editionable view adc_rule_group_status
as 
select to_number(replace(collection_name, 'ADC_CGR_STATUS_')) cgs_cgr_id,
       seq_id cgs_id,
       c001 cgs_cpi_id,
       c002 cgs_cpi_label,
       c003 cgs_cpi_mandatory_message
  from apex_collections;
  
comment on table adc_rule_group_status is 'Wrapper view around the apex collection containing the list of mandatory items';