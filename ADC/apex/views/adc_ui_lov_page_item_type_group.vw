create or replace editionable view adc_ui_lov_page_item_type_group
as 
select cig_id d, cig_id r 
  from adc_page_item_type_groups;


comment on table adc_ui_lov_page_item_type_group is 'LOV-Views for page item types';