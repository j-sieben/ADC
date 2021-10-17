create or replace view adc_bl_designer_action_v as
with session_state as(
       select utl_apex.get_page_prefix p_page_prefix,
              replace(utl_apex.get_page_prefix, 'P', 'R') p_region_prefix
         from dual),
     pti as (
       select pti_id, pti_name
         from pit_translatable_item_v
        where pti_pmg_name = 'ADC_UI')
select mda_alm_id mda_actual_mode, mda_ald_id mda_actual_id, mda_comment,
       case when mda_id_value is not null then utl_apex.get_number(p_page_prefix || mda_id_value) end mda_id_value, 
       p_region_prefix || mda_alm_id || '_FORM' mda_form_id, 
       mda_remember_page_state,
       mda_create_button_visible, c.pti_name mda_create_button_label, mda_create_target_mode,
       mda_update_button_visible, u.pti_name mda_update_button_label, mda_alm_id mda_update_target_mode,
       utl_apex.get_number(p_page_prefix || mda_id_value) mda_update_value,
       mda_delete_button_visible, d.pti_name mda_delete_button_label, mda_delete_mode, mda_delete_target_mode, 
       utl_apex.get_number(p_page_prefix || mda_delete_target_mode || '_ID') mda_delete_value,
       mda_cancel_button_active, mda_cancel_target_mode, 
       utl_apex.get_number(p_page_prefix || mda_cancel_target_mode || '_ID') mda_cancel_value
  from adc_ui_map_designer_actions
 cross join session_state
  left join pti c
    on case mda_create_button_visible when adc_util.C_TRUE then mda_create_target_mode else 'NO' end || '_CREATE_BUTTON' = c.pti_id
  left join pti u
    on case mda_update_button_visible when adc_util.C_TRUE then mda_alm_id else 'NO' end || '_SAVE_BUTTON' = u.pti_id
  left join pti d
    on case mda_delete_button_visible when adc_util.C_TRUE then mda_alm_id else 'NO' end || '_DELETE_BUTTON' = d.pti_id;
    
    