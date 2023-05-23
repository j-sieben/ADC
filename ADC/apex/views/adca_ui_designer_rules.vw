create or replace editionable view adca_ui_designer_rules
as
with session_state as (
       select /*+ no_merge */ 
              utl_apex.get_number('CRG_ID') g_crg_id,
              adc_util.c_true c_true,
              adc_util.c_false c_false
         from dual),
     translations as(
              select max(decode(pti_id, 'ADC_AUTO_INITIALIZE', to_char(pti_description))) auto_initialize,
                     max(decode(pti_id, 'ADC_FORCE_INITIALIZE', to_char(pti_description))) force_initialize,
                     max(decode(pti_id, 'ADC_NO_INITIALIZE', to_char(pti_description))) no_initialize
                from pit_translatable_item_v
               where pti_pmg_name = 'ADCA'
                 and pti_id like 'ADC_%'),
     params as (
      select crg_id, crg_app_id, crg_page_id,
             '- ' crg_page_prefix,
             ',' delimiter,
             '<span class="adc-error" title="Element existiert nicht.">' span_error,
             '<span class="adc-on-error">' span_on_error,
             '<span class="adc-disabled">(disabled) ' span_disabled,
             '</i><span class="adc-deprecated">(deprecated) ' span_deprecated,
             '</span>' close_span,
             '<ul class="adca-rule-list">' ul_open,
             '</ul>' ul_close,
             '<li>' li_open,
             '</li>' li_close,
             q'^<a class="fa fa-arrow-circle-o-right u-color-5-text" href="javascript:de.condes.plugin.adc.actions.selectEntry('R13_HIERARCHY', 'CRA_#ID#', true);"></a>^' href,
             '<br>' br,
             'fa-play' c_initialize,
             'fa-check' c_yes,
             'fa-times' c_no,
             c_true,
             c_false
        from adc_rule_groups
        join session_state s
          on crg_id = g_crg_id),
    actions as(
      select p.crg_app_id, p.crg_page_id,
             cru.cru_id, cru.cru_crg_id, cra_id, cru.cru_sort_seq, cra_sort_seq, 
             case 
               when cru_fire_on_page_load = c_true then c_yes 
               when instr(cru.cru_condition, 'initializing') > 0 then c_initialize 
               else c_no 
             end cru_fire_on_page_load, 
             case 
               when cru_fire_on_page_load = c_true then force_initialize 
               when instr(cru.cru_condition, 'initializing') > 0 then auto_initialize 
               else no_initialize
             end cru_fire_on_page_load_title, 
             case cru_active when c_true then c_yes else c_no end cru_active,
             case
               when cpi.cpi_id is not null then p.span_error || cru.cru_name || p.close_span
               else cru.cru_name
             end cru_name,
             replace(replace(dbms_lob.substr(cru.cru_condition, 4000, 1), ' and ', p.br || 'and '), ' or ', p.br || 'or ') cru_condition,
             case
               when cru.cru_firing_items is not null then p.crg_page_prefix
               else '- Alle - '
             end
             ||
             replace(
             case
               when cpi.cpi_id is not null then
                 replace(p.delimiter || cru.cru_firing_items || p.delimiter, p.delimiter || cpi_id || p.delimiter, p.span_error || cpi_id || p.close_span)
               else cru.cru_firing_items
             end, p.delimiter, p.br || p.crg_page_prefix) cru_firing_items,
             replace(href, '#ID#', cra_id) || 
             case
               when cpi.cpi_has_error = p.c_true then p.span_error || cat_name || p.close_span
               when cra_on_error = p.c_true then p.span_on_error || cat_name || p.close_span
               when cra_active = p.c_false then p.span_disabled || cat_name || p.close_span
               when cat_active = p.c_false then p.span_deprecated || cat_name || p.close_span
               else cat_name
             end cra_name,
             ul_open, ul_close, li_open, li_close, br
        from params p
       cross join translations
        join adc_rules cru
          on p.crg_id = cru.cru_crg_id
        left join adc_page_items cpi
          on cru.cru_crg_id = cpi.cpi_crg_id
         and instr(p.delimiter || cru_firing_items || p.delimiter, p.delimiter || cpi.cpi_id || p.delimiter) > 0
         and cpi.cpi_has_error = p.c_true
        left join (
             select cra_id, cra_crg_id,
                    case when cat_display_name is not null then
                      to_char(utl_text.bulk_replace(replace(replace(cat_display_name, '<p>'), '</p>'), char_table(
                        'ITEM', case when cra_cpi_id = 'DOCUMENT' and to_char(cra_param_2) is not null then to_char(cra_param_2) else cra_cpi_id end,
                        'PARAM_1', cra_param_1,
                        'PARAM_2', cra_param_2,
                        'PARAM_3', cra_param_3)))
                    else cat_name
                    end cat_name,
                    cat_active,
                    case when cra_cpi_id = 'DOCUMENT' and to_char(cra_param_2) is not null then to_char(cra_param_2) else cra_cpi_id end cra_cpi_id,
                    cra_cru_id, cra_cat_id, cra_sort_seq, cra_active, cpi.cpi_has_error, cra_on_error
               from adc_rule_actions cra
               join adc_page_items cpi
                 on cra_crg_id = cpi.cpi_crg_id
                and cra_cpi_id = cpi.cpi_id
               left join adc_action_types_v cat
                 on cra_cat_id = cat_id) cra
          on cru_id = cra_cru_id)
select app.application_name || ' (' || app.application_id || ')' application_name, pag.page_name || ' (' || pag.page_id || ')' page_name,
      'CRU_' || cru_id cru_id, cru_crg_id, cru_name, cru_condition, cru_firing_items, cru_sort_seq, cru_fire_on_page_load, cru_fire_on_page_load_title, cru_active,
      ul_open || li_open || listagg(cra_name , li_close || li_open)
        within group (order by cra_sort_seq) || li_close || ul_close cru_action
 from actions a
 join apex_applications app
   on crg_app_id = app.application_id
 join apex_application_pages pag
   on crg_app_id = pag.application_id
  and crg_page_id = pag.page_id
group by crg_app_id, app.application_name || ' (' || app.application_id || ')',
      pag.page_id, pag.page_name || ' (' || pag.page_id || ')',
      cru_id, cru_crg_id, cru_name, cru_condition, cru_firing_items, cru_sort_seq, cru_fire_on_page_load, cru_fire_on_page_load_title, cru_active,
      li_close, li_open, ul_open, ul_close;

comment on table adca_ui_designer_rules is 'Overview over all rules of a rule group including a summary of the rule actions';