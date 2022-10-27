create or replace editionable view adca_ui_admin_cat
as 
with params as (
       select  /*+ NO_MERGE */ utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin,
              adc_util.c_false c_false,
              'EDIT_CAT' target_page,
              'P3_CAT_ID' target_item
         from dual)
select g.catg_name,
       a.cat_id,
       a.cat_name || case a.cat_active when C_FALSE then ' (deprecated)' end cat_name,
       a.cat_is_editable,
       replace(a.cat_pl_sql, chr(13), '<br>') cat_pl_sql,
       replace(a.cat_js, chr(13), '<br>') cat_js,
       a.cat_description,
       case 
         when is_adc_admin = c_false and a.cat_is_editable = c_false then 'fa-lock'
         else 'fa-edit'
       end link_icon,
       case 
         when is_adc_admin = c_false and a.cat_is_editable = c_false then '#'
         else utl_apex.get_page_url(
                p_page => target_page,
                p_param_items => target_item,
                p_value_list => a.cat_id,
                p_triggering_element => 'R2_ACTION_TYPE')
       end link_target
  from adc_action_types_v a
  join adc_action_type_groups_v g
    on a.cat_catg_id = g.catg_id
 cross join params p;


comment on table adca_ui_admin_cat is 'View for page ADMIN_CAT';