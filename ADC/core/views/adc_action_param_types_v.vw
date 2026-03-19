create or replace force view adc_action_param_types_v as 
select capt_id, pti_name capt_name, pti_display_name capt_display_name, to_char(pti_description) capt_description, 
       capt_capvt_id, capt_select_list_query, capt_select_view_comment, capt_sort_seq, capt_active
  from adc_action_param_types
  join pit_translatable_item_v
    on capt_pti_id = pti_id
   and capt_pmg_name = pti_pmg_name;

comment on table adc_action_param_types_v is 'Wrapper with with translated column values';
