create or replace force view sadc_ui_adpti as
select pti_id, pti_pmg_name, pti_name, pti_display_name, pti_description
  from pit_translatable_item_v
 where pti_pmg_name = 'SADC';