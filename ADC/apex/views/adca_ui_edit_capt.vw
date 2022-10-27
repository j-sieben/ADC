create or replace view adca_ui_edit_capt as
select capt_id, capt_name, capt_display_name, capt_description, 
       capt_capvt_id, capt_select_list_query, capt_select_view_comment, 
       capt_active, capt_sort_seq
  from adc_action_param_types_v;
    
comment on table adca_ui_edit_capt is 'View for APEX page EDIT_CAPT';
