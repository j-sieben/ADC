create or replace editionable view adc_action_param_types_v as 
select cpt_id, pti_name cpt_name, pti_display_name cpt_display_name, to_char(pti_description) cpt_description, 
       cpt_cpv_id, text_vc cpt_select_list_query, comments cpt_select_view_comment, cpt_sort_seq, cpt_active
  from adc_action_param_types
  join pit_translatable_item_v
    on cpt_pti_id = pti_id
   and cpt_pmg_name = pti_pmg_name
  left join (
       select view_name, text_vc, comments
         from user_views
         join user_tab_comments
           on view_name = table_name)
    on 'ADC_PARAM_LOV_' || cpt_id = view_name;

comment on table adc_action_param_types_v is 'Wrapper with with translated column values';
