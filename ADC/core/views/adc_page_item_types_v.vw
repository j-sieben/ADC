create or replace  view adc_page_item_types_v
as 
select cit_id, pti_name cit_name, cit_cig_id, cig_has_value cit_has_value, cig_include_in_view cit_include_in_view, cit_event, cit_col_template, cit_init_template, cit_is_custom_event
  from adc_page_item_types
  join adc_page_item_type_groups
    on cit_cig_id = cig_id
  join pit_translatable_item_v
    on cit_pti_id = pti_id
   and cit_pmg_name = pti_pmg_name;

comment on table adc_page_item_types_v is 'Transated view on ADC_PAGE_ITEM_TYPES';