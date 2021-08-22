create or replace editionable view adc_bl_page_items
as 
  with pti as(
       select pti_id, pti_name, replace(pti_id, 'ITEM_TYPE_') item_type
         from pit_translatable_item_v
        where pti_pmg_name = 'ADC'
          and pti_id like 'ITEM_TYPE%')
select pti_name || ' ' || item_name item_name, item_name item_id,
       application_id app_id, page_id, item_type
  from apex_application_page_items
  join pti on item_type = 'ELEMENT'
union all
select pti_name || ' ' || item_name, item_name,
       application_id, 0, item_type
  from apex_application_items
  join pti on item_type = 'APP_ELEMENT'
union all
select pti_name || ' ' || button_static_id, button_static_id,
       application_id, page_id, item_type
  from apex_application_page_buttons
  join pti on item_type = 'BUTTON'
 where button_static_id is not null
union all
select pti_name || ' ' || static_id, static_id,
       application_id, page_id, item_type
  from apex_application_page_regions
  join pti on item_type = 'REGION'
 where static_id is not null
union all
select ' ' || pti_name, item_type,
       application_id, page_id, item_type
  from apex_application_pages
  join pti on item_type = 'DOCUMENT';
