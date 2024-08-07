create or replace force  view adca_ui_lov_item_types as 
select distinct pti_name d, replace(replace(pti_id, 'ITEM_TYPE_'), 'CPIT_') r
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC'
   and pti_id like 'CPIT%';

comment on table adca_ui_lov_item_types  is 'LOV view for the different item types';
