create or replace force view adca_ui_designer_tree as
with page_state as(
       select /*+ no_merge */
              utl_apex.get_number('CRG_APP_ID') p_app_id,
              adc_util.C_TRUE c_true,
              adca_ui_designer.support_flows c_support_flows,
              '' color_deactive,
              ' u-danger-text' color_error_handler,
              ' u-color-1-text' color_cgr,
              ' u-color-3-text' color_cag,
              ' u-color-3-text' color_caa,
              ' u-color-6-text' color_cru,
              ' u-color-5-text' color_cra,
              ' u-color-4-text' color_fls,
              'fa-server-play' icon_cgr,
              'fa-bookmark' icon_cag,
              'fa-bookmark-o' icon_caa,
              'fa-user-graduate' icon_cru,
              'fa-arrow-circle-o-right' icon_cra,
              'fa-tree-org' icon_fls
         from dual),
     data as(
              -- Rule Groups
       select 'CRG_' || crg_id node_id, 'PAGE' node_parent_id, crg_page_id || ': ' || page_name || ' (' || page_alias || ')' node_name, crg_page_id node_sort_seq, icon_cgr || color_cgr node_icon
         from adc_rule_groups
         join apex_application_pages
           on crg_app_id = application_id
          and crg_page_id = page_id
         join page_state
           on crg_app_id = p_app_id
        union all
       select 'CAG_' || crg_id, 'CRG_' || crg_id, pti_name, 99999, icon_cag || color_cag
         from adc_rule_groups
         join page_state
           on crg_app_id = p_app_id
        cross join pit_translatable_item_v
        where pti_pmg_name = 'ADC'
          and pti_id = 'CAG'
        union all  
       select 'CAA_' || caa_id, 'CAG_' || caa_crg_id, caa_label || ' (' || caa_name || ')', caa_id, icon_caa|| color_caa
         from adc_apex_actions_v
         join adc_rule_groups
           on caa_crg_id = crg_id
         join page_state
           on crg_app_id = p_app_id
        union all
       select 'CRU_' || cru_id, 'CRG_' || cru_crg_id, cru_sort_seq || ' - ' || cru_name, cru_sort_seq, icon_cru || case cru_active when c_true then color_cru else color_deactive end
         from adc_rules
         join adc_rule_groups
           on cru_crg_id = crg_id
         join page_state
           on crg_app_id = p_app_id
        union all  
       select 'CRA_' || cra_id, 'CRU_' || cra_cru_id, cat_name, cra_sort_seq, icon_cra || case cra_active when c_true then color_cra else color_deactive end
         from adc_rule_actions
         join adc_rule_groups
           on cra_crg_id = crg_id
         join page_state
           on crg_app_id = p_app_id
         join adc_action_types_v
           on cra_cat_id = cat_id)
 select /*+ result_cache */ case when connect_by_isleaf = 1 then 0 when level = 1 then 1 else -1 end as status,
        level lvl,
        node_name as title,
        node_icon as icon,
        node_id as value,
        node_name as tooltip,
        null as link
   from data
  start with node_parent_id in ('PAGE')
connect by prior node_id = node_parent_id
  order siblings by node_sort_seq;
  
comment on table adca_ui_designer_tree is 'Hierarchical representation of rule groups with their related rules and rule actions';
