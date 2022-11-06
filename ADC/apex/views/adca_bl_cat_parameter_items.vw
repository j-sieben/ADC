create or replace view adca_bl_cat_parameter_items as
with params as(
       select /*+ no_merge */ 
              adc_util.c_true c_active,
              utl_apex.get_page_prefix p_page_prefix
         from dual)
select cat_id, cra_id, cat_caif_id, 
       capt_id, capt_capvt_id, cap_sort_seq, cap_mandatory, 
       coalesce(
         case cap_sort_seq
           when 1 then cra_param_1
           when 2 then cra_param_2
           when 3 then cra_param_3
         end, cap_default) cap_value,
       coalesce(cap_display_name, capt_name) capt_name,
       p_page_prefix || 'CRA_PARAM_' || 
       case capt_capvt_id
         when 'SELECT_LIST' then 'LOV_'
         when 'STATIC_LIST' then 'LOV_'
         when 'CONTROL_LIST' then 'CB_'
         when 'TEXT_AREA' then 'AREA_'
         when 'SWITCH' then 'SWITCH_'
       end || cap_sort_seq cap_page_item
  from adc_action_types_v
  join params
    on cat_active = c_active
  left join adc_action_parameters_v
    on cat_id = cap_cat_id
   and c_active = cap_active
  left join adc_action_param_types_v
    on cap_capt_id = capt_id
   and c_active = capt_active
  left join (
       select *
         from adca_ui_designer_rule_action)
    on cat_id = cra_cat_id
 where cap_sort_seq is not null;