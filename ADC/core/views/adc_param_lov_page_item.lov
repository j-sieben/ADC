create or replace force view adc_param_lov_page_item
as 
select case cpi_id when 'ALL' then ' Document' else cpi_id end d, cpi_id r, cpi_crg_id crg_id
  from adc_page_items
 where cpi_cpit_id in ('DATE_ITEM', 'ITEM', 'NUMBER_ITEM');

comment on table adc_param_lov_page_item is 'List of page items, limited to input fields, grouped by CRG_ID';