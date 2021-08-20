create or replace editionable view adc_ui_lov_export_types
as 
select pti_name d, substr(pti_id, 16) r,
       case substr(pti_id, 16)
       when 'ALL_CGR' then 1
       when 'APP' then 2
       when 'PAGE' then 3
       else 4 end sort_seq
  from pit_translatable_item_v
 where pti_pmg_name = 'ADC_UI'
   and pti_id like 'LOV_EXPORT_CGR%';
