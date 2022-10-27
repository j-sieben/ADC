create or replace editionable view adc_rule_group_status
as 
select to_number(replace(collection_name, 'ADC_CRG_STATUS_')) cgs_crg_id,
       seq_id cgs_id,
       c001 cgs_cpi_id,
       c002 cgs_cpi_label,
       c003 cgs_cpi_mandatory_message
  from apex_collections
 where collection_name like 'ADC_CRG_STATUS%';
  
comment on table adc_rule_group_status is 'Wrapper view around the apex collection containing the list of mandatory items';
comment on column adc_rule_group_status.cgs_crg_id is 'CRG_ID of the mandatory items list';
comment on column adc_rule_group_status.cgs_id is 'Collection PK (SEQ_ID)';
comment on column adc_rule_group_status.cgs_cpi_id is 'ID of the page item';
comment on column adc_rule_group_status.cgs_cpi_label is 'Label of the page item';
comment on column adc_rule_group_status.cgs_cpi_mandatory_message is 'Message to display if the page item violates the mandatory rule';