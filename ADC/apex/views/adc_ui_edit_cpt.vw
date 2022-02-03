create or replace view adc_ui_edit_cpt as
select cpt_id, cpt_name, cpt_display_name, cpt_description, 
       cpt_cpv_id, cpt_select_list_query, cpt_select_view_comment, 
       cpt_active, cpt_sort_seq
  from adc_action_param_types_v;
    
comment on table adc_ui_edit_cpt is 'View for APEX page EDIT_CPT';
