create or replace editionable view adca_ui_lov_page_item_type_group
as 
select cpitg_id d, cpitg_id r 
  from adc_page_item_type_groups;


comment on table adca_ui_lov_page_item_type_group is 'LOV-Views for page item types';