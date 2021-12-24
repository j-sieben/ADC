create or replace view adc_ui_designer_findings as
with params as (
       select q'^javascript:de.condes.plugin.adc.selectEntry('R13_HIERARCHY', '#NODE_ID#', true);^' link_template,
              'fa fa-exclamation-triangle-o u-warning-text margion-right-sm' warn_icon,
              'fa fa-times-square-o u-danger-text margion-right-sm' danger_icon,
              utl_apex.get_number('CGR_ID') p_cgr_id,
              adc_util.C_TRUE C_TRUE,
              adc_util.C_FALSE C_FALSE
         from dual),
     findings as(
       select /*+ no_merge (p) */
              cra_cgr_id cgr_id, 'CRA_' || cra_id node, 1 severity,
              pit.get_message('ADC_UI_CHK_REGISTER_OBSERVER', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         join adc_rules
           on cra_cgr_id = cru_cgr_id
          and instr(',' || cru_firing_items || ',', ',' || cra_cpi_id || ',') > 0
         join params p
           on cru_cgr_id = p_cgr_id
        where cra_cat_id = 'REGISTER_OBSERVER'
       union all
       select /*+ no_merge (p) */
              cra_cgr_id cgr_id, 'CRA_' || cra_id node, 1 severity,
              pit.get_message('ADC_UI_CHK_DEPRECATED', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         join adc_action_types
           on cra_cat_id = cat_id
         join params p
           on cra_cgr_id = p_cgr_id
        where cat_active = C_FALSE
       union all
       select /*+ no_merge (p) */
              cra_cgr_id cgr_id, 'CRA_' || cra_id node, 0 severity,
              pit.get_message('ADC_UI_CHK_MISSING', msg_args(cra_cpi_id)) message
         from adc_rule_actions
         left join adc_page_items
           on cra_cgr_id = cpi_cgr_id
          and cra_cpi_id = cpi_id
        where cpi_id is null
          and cra_cpi_id is not null
       union all
       select /*+ no_merge (p) */
              cru_cgr_id cgr_id, 'CRU_' || cru_id node, 0 severity,
              pit.get_message('ADC_UI_CHK_MISSING', msg_args(column_value)) message
         from adc_rules cru
         join adc_rule_groups
           on cru_cgr_id = cgr_id
         join params p
           on cru_cgr_id = p_cgr_id
        cross join table(utl_text.string_to_table(cru.cru_firing_items, ','))
         left join adc_bl_page_items
           on cgr_app_id = app_id
          and cgr_page_id = page_id
          and column_value = item_id
        where cru_firing_items not in ('COMMAND', 'DOCUMENT')
          and item_id is null)
select replace(link_template, '#NODE_ID#', node) link, case severity when 1 then warn_icon else danger_icon end icon, f.message.message_text message, f.message.message_description title,
       case max(severity) over () when 1 then warn_icon else danger_icon end region_icon
  from findings f
  join params p
    on cgr_id = p_cgr_id;
  
comment on table adc_ui_designer_findings is 'Analysis of the actually selected rule group. Displays violations of quality assurance rules';
