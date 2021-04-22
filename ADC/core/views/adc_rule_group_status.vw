create or replace editionable view adc_rule_group_status
as 
select collection_name,
       seq_id srs_id,
       c001 srs_cpi_id,
       c002 srs_cpi_label,
       c003 srs_cpi_mandatory_message
  from apex_collections;
  
comment on table adc_rule_group_status is 'Wrapper view around the apex collection containing the list of mandatory items';