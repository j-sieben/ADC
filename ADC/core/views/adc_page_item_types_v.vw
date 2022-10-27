create or replace  view adc_page_item_types_v
as 
select cpit_id, pti_name cpit_name, cpit_cpitg_id, cpitg_has_value cpit_has_value, cpitg_include_in_view cpit_include_in_view, cpit_cet_id, cpit_col_template, cpit_init_template
  from adc_page_item_types
  join adc_page_item_type_groups
    on cpit_cpitg_id = cpitg_id
  join pit_translatable_item_v
    on cpit_pti_id = pti_id
   and cpit_pmg_name = pti_pmg_name;

comment on table adc_page_item_types_v is 'Transated view on ADC_PAGE_ITEM_TYPES';