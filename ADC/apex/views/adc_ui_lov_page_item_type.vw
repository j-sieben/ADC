create or replace editionable view adc_ui_lov_page_item_type
as 
select cit_name d, cit_id r, cit_include_in_view is_event
  from adc_page_item_types_v;

comment on table adc_ui_lov_page_item_type is 'LOV view for all page item types.';