create or replace editionable view adca_ui_lov_export_cat
as
select pti_name d, pti_id r
  from pit_translatable_item_v
 where pti_pmg_name = 'ADCA'
   and pti_id like 'CAT_EXPORT%';
