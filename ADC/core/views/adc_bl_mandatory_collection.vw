create or replace editionable view adc_bl_mandatory_collection
as
select to_number(replace(collection_name, 'ADC_CGR_STATUS_')) cgr_id, 
       c001 cpi_id, c002 cpi_label, c003 cpi_mandatory_message
  from apex_collections
 where collection_name like 'ADC_CGR_STATUS%'