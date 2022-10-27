create or replace editionable view adc_bl_page_items
as 
  with pti as(
       select pti_id, pti_name, replace(pti_id, 'CPIT_') item_type
         from pit_translatable_item_v
        where pti_pmg_name = 'ADC'
          and pti_id like 'CPIT%')
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
  join pti on item_type in ('FORM_REGION', 'REGION')
 where static_id is not null
union all
select ' ' || pti_name, item_type,
       application_id, page_id, item_type || case page_mode when 'Modal Dialog' then '_MODAL' end
  from apex_application_pages
  join pti on item_type = 'DOCUMENT';


comment on table adc_bl_page_items is 'View to collect metadata from the APEX dictionary for all ADC supported kinds of page items';
comment on column adc_bl_page_items.item_name is 'Name of the page item, along with its translated item type';
comment on column adc_bl_page_items.item_id is 'Static ID of the page item';
comment on column adc_bl_page_items.app_id is 'APEX application ID';
comment on column adc_bl_page_items.page_id is 'APEX application page ID';
comment on column adc_bl_page_items.item_type is 'Type of the page ITEM';
