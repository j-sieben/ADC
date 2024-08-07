create or replace force view adc_action_types_v as 
select cat_id, cat_catg_id, cat_caif_id, cat_cato_id,
       pti_name cat_name, pti_display_name cat_display_name, to_char(pti_description) cat_description, 
       cat_pl_sql, cat_js, cat_is_editable, cat_raise_recursive, cat_active
  from adc_action_types
  join pit_translatable_item_v
    on cat_pti_id = pti_id
   and cat_pmg_name = pti_pmg_name;

comment on table adc_action_types_v is 'Wrapper with with translated column values';