create or replace view adc_ui_designer_tree as
with session_state as(
       select cgr_id p_cgr_id,
              adc_util.C_TRUE c_true,
              '' color_deactive,
              ' u-danger-bg' color_error_handler,
              ' u-color-16-bg' color_cgr,
              ' u-color-18-bg' color_cag,
              ' u-color-18-bg' color_caa,
              ' u-color-21-bg' color_cru,
              ' u-color-20-bg' color_cra,
              'fa-server-play' icon_cgr,
              'fa-bookmark' icon_cag,
              'fa-bookmark-o' icon_caa,
              'fa-user-graduate' icon_cru,
              'fa-arrow-circle-o-right' icon_cra
         from adc_rule_groups
        where cgr_app_id = 117),--(select utl_apex.get_number('CGR_APP_ID') from dual)),
     data as(
       select /*+ no_merge (session_state) */
              'CGR_' || cgr_id node_id, 'P_' || cgr_page_id node_parent_id, cgr_page_id || ': ' || page_name || ' (' || page_alias || ')' node_name, cgr_page_id node_sort_seq, icon_cgr || color_cgr node_icon, 'RULE_GROUP' node_type,
              '' menu_action_list
         from adc_rule_groups
         join apex_application_pages
           on cgr_app_id = application_id
          and cgr_page_id = page_id
         join session_state s
           on cgr_id = p_cgr_id
        union all
       select 'CAG_' || cgr_id, 'CGR_' || cgr_id, 'Seitenkommandos', cgr_id, icon_cag || color_cag, 'CAA_GROUP',
              '' menu_action_list
         from adc_rule_groups
         join session_state s
           on cgr_id = p_cgr_id
        union all  
       select 'CAA_' || caa_id, 'CAG_' || caa_cgr_id, caa_label || ' (' || caa_name || ')', caa_id, icon_caa|| color_caa, 'APEX_ACTION',
              '' menu_action_list
         from adc_apex_actions_v
         join session_state s
           on caa_cgr_id = p_cgr_id
        union all
       select 'CRU_' || cru_id, 'CGR_' || cru_cgr_id, cru_name, cru_sort_seq, icon_cru || case cru_active when c_true then color_cru else color_deactive end, 'RULE',
              '' menu_action_list
         from adc_rules
         join session_state s
           on cru_cgr_id = p_cgr_id
        union all  
       select 'CRA_' || cra_id, 'CRU_' || cra_cru_id, cat_name, cra_sort_seq, icon_cra || case cra_active when c_true then color_cra else color_deactive end, 'ACTION',
              '' menu_action_list
         from adc_rule_actions
         join session_state s
           on cra_cgr_id = p_cgr_id
         join adc_action_types_v
           on cra_cat_id = cat_id)
 select case when connect_by_isleaf = 1 then 0 when level = 1 then 1 else -1 end as status,
        level lvl,
        node_name as title,
        node_icon as icon,
        node_id as value,
        node_name as tooltip,
        menu_action_list as link
   from data
  start with node_type = 'RULE_GROUP'
connect by prior node_id = node_parent_id
  order siblings by node_sort_seq;
  
comment on table adc_ui_designer_tree is 'Hierarchical representation of rule groups with their related rules and rule actions';
