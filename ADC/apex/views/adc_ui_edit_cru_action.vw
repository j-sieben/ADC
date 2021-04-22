create or replace view adc_ui_edit_cru_action
as 
with params as(
       select v('P5_CRU_ID') cru_id,
              v('P5_CRU_CGR_ID') cru_cgr_id,
              'fa-check' flg_yes,
              'fa-times' flg_no,
              utl_apex.c_true c_true,
              utl_apex.c_false c_false
         from dual)
select /*+ no_merge(p) */
       max(cra_id) over () + 1 seq_id,
       cra_id,
       cra_cgr_id,
       cra_cru_id,
       cra_cat_id,
       cra_cpi_id,
       coalesce(item_name, 'Dokument') item_name,
       cat_name,
       cra_sort_seq,
       cra_param_1,
       cra_param_2,
       cra_param_3,
       cra_comment,
       case cra_on_error when p.c_true then flg_yes else flg_no end cra_on_error,
       case cra_raise_recursive when p.c_true then flg_yes else flg_no end cra_raise_recursive,
       case cra_active when p.c_true then flg_yes else flg_no end cra_active,
       -- Change logic to allow for "is_valid" flag
       case cra_has_error when p.c_true then flg_no else flg_yes end cra_has_error
  from adc_ui_edit_cra
  join adc_action_types_v
    on cra_cat_id = cat_id
  join adc_rule_groups
    on cra_cgr_id = cgr_id
  left join adc_bl_page_items
    on cgr_app_id = app_id
   and cgr_page_id = page_id
   and cra_cpi_id = item_id
  join params p
    on cra_cgr_id = cru_cgr_id
   and (cra_cru_id = cru_id or cra_cru_id is null);

comment on table adc_ui_edit_cru_action is 'UI-View for page ADC_UI_EDIT_CRU, report ACTION';