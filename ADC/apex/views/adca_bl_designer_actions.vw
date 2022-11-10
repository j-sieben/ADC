
create or replace force view adca_bl_designer_actions as
with session_state as(
       select /*+ no_merge */
              utl_apex.get_application_id p_app_id,
              utl_apex.get_page_id p_page_id,
              utl_apex.get_page_prefix p_page_prefix,
              replace(utl_apex.get_page_prefix, 'P', 'R') p_region_prefix
         from dual),
     confirm_message as(
       select apex_escape.json(pit.get_message_text(replace(caa_confirm_message_name, 'msg.'))) amda_delete_confirm_message
         from adc_apex_actions
         join adc_rule_groups
           on caa_crg_id = crg_id
         join session_state
           on crg_app_id = p_app_id
          and crg_page_id = p_page_id
        where caa_name = 'delete-action'),
     pti as (
       select pti_id, pti_name
         from pit_translatable_item_v
        where pti_pmg_name = 'ADCA')
select amda_aldm_id amda_actual_mode, amda_alda_id amda_actual_id, amda_comment,
       case when amda_id_value is not null then utl_apex.get_number(p_page_prefix || amda_id_value) end amda_id_value, 
       p_region_prefix || amda_aldm_id || '_FORM' amda_form_id, 
       amda_remember_page_state,
       amda_create_button_visible, c.pti_name amda_create_button_label, amda_create_target_mode,
       amda_update_button_visible, u.pti_name amda_update_button_label, amda_aldm_id amda_update_target_mode,
       case when amda_id_value is not null then utl_apex.get_number(p_page_prefix || amda_id_value) end amda_update_value,
       amda_delete_button_visible, d.pti_name amda_delete_button_label, amda_delete_mode, amda_delete_target_mode, amda_delete_confirm_message,
       case when amda_delete_target_mode is not null then utl_apex.get_number(p_page_prefix || amda_delete_target_mode || '_ID') end amda_delete_value,
       amda_cancel_button_active, amda_cancel_target_mode, 
       case when amda_cancel_target_mode is not null then utl_apex.get_number(p_page_prefix || amda_cancel_target_mode || '_ID') end amda_cancel_value
  from adca_map_designer_actions
 cross join session_state
 cross join confirm_message
  left join pti c
    on coalesce(amda_create_target_mode, 'NO') || '_CREATE_BUTTON' = c.pti_id
  left join pti u
    on amda_aldm_id  || '_SAVE_BUTTON' = u.pti_id
  left join pti d
    on amda_aldm_id || '_DELETE_BUTTON' = d.pti_id;
    
    
comment on table adca_bl_designer_actions is '    This view enriches the data from the decision table <Tables.ADCA_MAP_DESIGNER_ACTIONS> with translated label data and
    session state information, such as the actual page and region prefix.    
    The decision is based on a mode the ADC Designer is actually in and the command to execute. As an example, if the
    designer shows a rule group, because the user clicked on a dynamic page in the tree control, The mode is CGR and the
    command is SHOW. Based on this information, this view is queried and the status and labels of the respective buttons
    are taken and sent to the page. The decision table also defines the target mode to switch to if a button is clicked.    
    If the user decides to click the CREATE button in the ADC Designer, this then is interpreted as target mode CRU and
    the command is CREATE-ACTION. This again filters this view, controling the state of the buttons and labels as well
    as the target modes of the buttons.';
comment on column adca_bl_designer_actions.amda_actual_mode is 'Mode the designer has to move to, fi. when showing a rule, the mode is CRU.';
comment on column adca_bl_designer_actions.amda_actual_id is 'Name of the command that was executed (either an apex action name or SHOW) Together with AMDA_ACTUAL_MODE, this decides on the row to execute.';
comment on column adca_bl_designer_actions.amda_comment is 'Comment explaining the use case of the specific row.';
comment on column adca_bl_designer_actions.amda_id_value is 'Actual ID of the asset shown.';
comment on column adca_bl_designer_actions.amda_form_id is 'ID of the form to show next.';
comment on column adca_bl_designer_actions.amda_remember_page_state is 'Flag to indicate whether the form to show next needs to survey element changes.';
comment on column adca_bl_designer_actions.amda_create_button_visible is 'Flag to indicate whether the create button is visible.';
comment on column adca_bl_designer_actions.amda_create_button_label is 'Label fo the create button, translated.';
comment on column adca_bl_designer_actions.amda_create_target_mode is 'Mode to enter if the create button is pressed.';
comment on column adca_bl_designer_actions.amda_update_button_visible is 'Flag to indicate whether the upddate button is visible.';
comment on column adca_bl_designer_actions.amda_update_button_label is 'Label fo the update button, translated.';
comment on column adca_bl_designer_actions.amda_update_target_mode is 'Mode to enter if the update button is pressed.';
comment on column adca_bl_designer_actions.amda_update_value is 'ID of the asset to update.';
comment on column adca_bl_designer_actions.amda_delete_button_visible is 'Flag to indicate whether the delete button is visible.';
comment on column adca_bl_designer_actions.amda_delete_button_label is 'Label fo the delete button, translated.';
comment on column adca_bl_designer_actions.amda_delete_mode is 'Actual mode when the delete button was pressed.';
comment on column adca_bl_designer_actions.amda_delete_target_mode is 'Mode to enter if the delete button is pressed.';
comment on column adca_bl_designer_actions.amda_delete_value is 'ID of the asset to delete.';
comment on column adca_bl_designer_actions.amda_delete_confirm_message is 'Translated message for the confirm dialog of the delete action';
comment on column adca_bl_designer_actions.amda_cancel_button_active is 'Flag to indicate whether the cancel button is visible.';
comment on column adca_bl_designer_actions.amda_cancel_target_mode is 'Mode to enter if the cancel button is pressed.';
comment on column adca_bl_designer_actions.amda_cancel_value is 'ID of the asset to return to after the dialog was canceled.';