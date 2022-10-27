create or replace editionable view adca_ui_lov_page_item_type
as 
select cpit_name d, cpit_id r, cpit_include_in_view is_event
  from adc_page_item_types_v;

comment on table adca_ui_lov_page_item_type is 'LOV view for all page item types.';