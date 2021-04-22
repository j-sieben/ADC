create or replace force view adc_ui_list_page_items
as 
select cpi_id d, cpi_id r, cpi_cgr_id
  from adc_page_items
 where cpi_id != 'DOCUMENT';
