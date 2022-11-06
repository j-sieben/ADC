create or replace view adca_ui_designer_findings as
with params as (
       select /*+ no_merge */
              q'^javascript:de.condes.plugin.adc-actions.selectEntry('R13_HIERARCHY', '#NODE_ID#', true);^' link_template,
              'fa fa-exclamation-triangle-o u-warning-text margion-right-sm' warn_icon,
              'fa fa-times-square-o u-danger-text margion-right-sm' danger_icon,
              utl_apex.get_number('CRG_ID') p_crg_id,
              adc_util.C_TRUE C_TRUE,
              adc_util.C_FALSE C_FALSE
         from dual),
     findings as(
       select cra_crg_id crg_id, 'CRA_' || cra_id node, 1 severity,
              pit.get_message('ADCA_UI_CHK_REGISTER_OBSERVER', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         join adc_rules
           on cra_crg_id = cru_crg_id
          and instr(',' || cru_firing_items || ',', ',' || cra_cpi_id || ',') > 0
         join params p
           on cru_crg_id = p_crg_id
        where cra_cat_id = 'REGISTER_OBSERVER'
       union all
       select cra_crg_id crg_id, 'CRA_' || cra_id node, 1 severity,
              pit.get_message('ADCA_UI_CHK_DEPRECATED', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         join adc_action_types
           on cra_cat_id = cat_id
         join params p
           on cra_crg_id = p_crg_id
        where cat_active = C_FALSE
       union all
       select cra_crg_id crg_id, 'CRA_' || cra_id node, 0 severity,
              pit.get_message('ADCA_UI_CHK_MISSING', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         left join adc_page_items
           on cra_crg_id = cpi_crg_id
          and cra_cpi_id = cpi_id
        where cpi_id is null
          and cra_cpi_id is not null
       union all
       select cru_crg_id crg_id, 'CRU_' || cru_id node, 0 severity,
              pit.get_message('ADCA_UI_CHK_MISSING', msg_args(column_value)) message
         from adc_rules cru
         join adc_rule_groups
           on cru_crg_id = crg_id
         join params p
           on cru_crg_id = p_crg_id
        cross join table(utl_text.string_to_table(cru.cru_firing_items, ','))
         left join adc_bl_page_items
           on crg_app_id = app_id
          and crg_page_id = page_id
          and column_value = item_id
        where cru_firing_items not in ('COMMAND', 'DOCUMENT')
          and item_id is null)
select replace(link_template, '#NODE_ID#', node) link, case severity when 1 then warn_icon else danger_icon end icon, f.message.message_text message, f.message.message_description title,
       case max(severity) over () when 1 then warn_icon else danger_icon end region_icon
  from findings f
  join params p
    on crg_id = p_crg_id;
  
comment on table adca_ui_designer_findings is 'Analysis of the actually selected rule group. Displays violations of quality assurance rules';
