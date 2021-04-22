create or replace editionable view adc_action_types_v as 
  select cat_id, cat_ctg_id, cat_cif_id, pti_name cat_name, to_char(pti_description) cat_description, cat_pl_sql, cat_js, cat_is_editable, cat_raise_recursive, cat_active
  from adc_action_types
  join pit_translatable_item_v
    on cat_pti_id = pti_id
   and cat_pmg_name = pti_pmg_name;

comment on table adc_action_types_v is 'Wrapper with with translated column values';