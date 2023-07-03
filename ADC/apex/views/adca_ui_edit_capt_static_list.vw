create or replace force view adca_ui_edit_capt_static_list as
with params as (
       select /*+ no_merge */
              utl_apex.get_string('CAPT_ID') c_capt_id
         from dual)
select capt_id csl_capt_id, substr(pti_id, length(capt_id) + 2) csl_pti_id, pti_name csl_name
  from pit_translatable_item_v
  join adc_action_param_types
    on pti_id like capt_id || '%'
  join params p
    on capt_id = c_capt_id
 where pti_pmg_name = 'ADC';
    
comment on table adca_ui_edit_capt_static_list is 'View for APEX page EDIT_CPT, Static values for a list';