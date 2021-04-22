create or replace editionable view adc_ui_admin_cgr_rules
as
with params as (
       select cgr_id, cgr_app_id, cgr_page_id,
              '- ' cgr_page_prefix,
              ',' delimiter,
              '<span class="adc-error" title="Element existiert nicht.">' span_error,
              '<span class="adc-on-error">' span_on_error,
              '<span class="adc-disabled">' span_disabled,
              '</span>' close_span,
              '<br/>' br,
              adc_util.c_true c_true,
              adc_util.c_false c_false
         from adc_rule_groups
        where cgr_id = (select utl_apex.get_number('CGR_ID') from dual)),
       actions as(
       select /*+ no_merge (p) */ 
              p.cgr_app_id, p.cgr_page_id, 
              sru.cru_id, sru.cru_cgr_id, sra.cra_id, sru.cru_sort_seq, sra.cra_sort_seq, sru.cru_fire_on_page_load, sru.cru_active,
              case
                when spi.cpi_id is not null then p.span_error || sru.cru_name || p.close_span
                else sru.cru_name
              end cru_name,
              replace(replace(dbms_lob.substr(sru.cru_condition, 4000, 1), ' and ', p.br || 'and '), ' or ', p.br || 'or ') cru_condition,
              case
                when sru.cru_firing_items is not null then p.cgr_page_prefix
                else '- Alle - '
              end
              ||
              replace(
              case
                when spi.cpi_id is not null then
                  replace(p.delimiter || sru.cru_firing_items || p.delimiter, p.delimiter || cpi_id || p.delimiter, p.span_error || cpi_id || p.close_span)
                else sru.cru_firing_items
              end, p.delimiter, p.br || p.cgr_page_prefix) cru_firing_items,
              case
                when sra.cpi_has_error = p.c_true then p.span_error || p.cgr_page_prefix || cra_cpi_id || ': ' || cat_name || p.close_span
                when sra.cra_on_error = p.c_true then p.span_on_error || p.cgr_page_prefix || cra_cpi_id || ': ' || cat_name || p.close_span
                when sra.cra_active = p.c_false then p.span_disabled || p.cgr_page_prefix || cra_cpi_id || ': ' || cat_name || p.close_span
                else p.cgr_page_prefix || cra_cpi_id || ': ' || cat_name
              end cra_name
         from params p
         join adc_rules sru
           on p.cgr_id = sru.cru_cgr_id
         left join adc_page_items spi
           on sru.cru_cgr_id = spi.cpi_cgr_id
          and instr(p.delimiter || cru_firing_items || p.delimiter, p.delimiter || spi.cpi_id || p.delimiter) > 0
          and spi.cpi_has_error = p.c_true
         left join (
              select sra.cra_id, sra.cra_cgr_id,
                     case when sra.cra_cpi_id = 'DOCUMENT' and to_char(sra.cra_param_2) is not null then '[' || to_char(sra.cra_param_2) || ']' else sra.cra_cpi_id end cra_cpi_id,
                     sra.cra_cru_id, sra.cra_cat_id, sra.cra_sort_seq, sra.cra_active, spi.cpi_has_error, sra.cra_on_error
                from adc_rule_actions sra
                join adc_page_items spi
                  on sra.cra_cgr_id = spi.cpi_cgr_id
                 and sra.cra_cpi_id = spi.cpi_id) sra
           on cru_id = cra_cru_id
         left join adc_action_types_v sat
           on cra_cat_id = cat_id)
select app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_name || ' (' || pag.page_id || ')' page_name,
       cru_id, cru_cgr_id, cru_name, cru_condition, cru_firing_items, cru_sort_seq, cru_fire_on_page_load, cru_active,
       listagg(cra_name, '<br>')
         within group (order by cra_sort_seq) cru_action
  from actions a
  join apex_applications app
    on cgr_app_id = app.application_id
  join apex_application_pages pag
    on cgr_app_id = pag.application_id
   and cgr_page_id = pag.page_id
 group by cgr_app_id, app.application_name || ' (' || app.application_id || ')',
       pag.page_id, pag.page_name || ' (' || pag.page_id || ')',
       cru_id, cru_cgr_id, cru_name, cru_condition, cru_firing_items, cru_sort_seq, cru_fire_on_page_load, cru_active;
