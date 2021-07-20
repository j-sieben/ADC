create or replace view adc_ui_edit_cru_action
as
with params as(
       select v('P5_CRU_ID') cru_id,
              v('P5_CRU_CGR_ID') cgr_id,
              'fa-check' c_yes,
              'fa-times' c_no,
             '- ' cgr_page_prefix,
             ',' delimiter,
             '<span class="adc-error" title="Element existiert nicht.">' span_error,
             '<span class="adc-on-error">' span_on_error,
             '<span class="adc-disabled">(disabled) ' span_disabled,
             '</i><span class="adc-deprecated">(deprecated) ' span_deprecated,
             '</span>' close_span,
             '' br,
             adc_util.c_true c_true,
             adc_util.c_false c_false
         from dual)
      select /*+ no_merge (p) */
             cru.cru_id, cru.cru_cgr_id, seq_id, cra_id, cra_sort_seq, cat_id,
             case
               when cpi.cpi_has_error = p.c_true then p.span_error || cat_name || p.close_span
               when cra_on_error = p.c_true then p.span_on_error || cat_name || p.close_span
               when cra_active = p.c_false then p.span_disabled || cat_name || p.close_span
               when cat_active = p.c_false then p.span_deprecated || cat_name || p.close_span
               else cat_name
             end cra_name,
             case when cra_raise_recursive = c_true then c_yes else c_no end cra_raise_recursive
        from params p
        join adc_rules cru
          on p.cgr_id = cru.cru_cgr_id
         and p.cru_id = cru.cru_id
        left join adc_page_items cpi
          on cru.cru_cgr_id = cpi.cpi_cgr_id
         and instr(p.delimiter || cru_firing_items || p.delimiter, p.delimiter || cpi.cpi_id || p.delimiter) > 0
         and cpi.cpi_has_error = p.c_true
        left join (
             select seq_id, cra_id, cra_cgr_id, cat_id,
                    case when cat_display_name is not null then
                      to_char(utl_text.bulk_replace(cat_display_name, char_table(
                        'ITEM', case when cra_cpi_id = 'DOCUMENT' and cra_param_2 is not null then cra_param_2 else cra_cpi_id end,
                        'PARAM_1', cra_param_1,
                        'PARAM_2', cra_param_2,
                        'PARAM_3', cra_param_3,
                        'p>', 'span>')))
                    else cat_name
                    end cat_name,
                    cat_active,
                    cra_cru_id, cra_cat_id, cra_sort_seq, cra_active, cpi.cpi_has_error, cra_on_error, cra_raise_recursive
               from adc_ui_edit_cra cra
               join adc_page_items cpi
                 on cra_cgr_id = cpi.cpi_cgr_id
                and cra_cpi_id = cpi.cpi_id
               left join adc_action_types_v cat
                 on cra_cat_id = cat_id) cra
          on cru.cru_id = cra_cru_id;
          

comment on table adc_ui_edit_cru_action is 'UI-View for page ADC_UI_EDIT_CRU, report ACTION';