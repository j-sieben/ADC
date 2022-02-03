create or replace view adc_ui_edit_cpt_static_list as
with params as (
       select pit.get_default_language c_default_language,
              utl_apex.get_string('CPT_ID') c_cpt_id
         from dual)
select /*+ no_merge (p) */
       cpt_id csl_cpt_id, substr(pti_id, length(cpt_id) + 2) csl_pti_id, pti_name csl_name
  from pit_translatable_item
  join adc_action_param_types
    on pti_id like cpt_id || '%'
  join params p
    on cpt_id = c_cpt_id
   and pti_pml_name = c_default_language
 where pti_pmg_name = 'ADC';
    
comment on table adc_ui_edit_cpt_static_list is 'View for APEX page EDIT_CPT, Static values for a list';