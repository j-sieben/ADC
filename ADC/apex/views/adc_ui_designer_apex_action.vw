create or replace editionable view adc_ui_designer_apex_action
as
select caa_id, caa_cgr_id, caa_cty_id, caa_name, caa_label, caa_context_label,
       caa_icon, caa_icon_type, caa_title, caa_shortcut, caa_initially_disabled, caa_initially_hidden,
       caa_href, caa_action, caa_on_label, caa_off_label, caa_get, caa_set, caa_choices,
       caa_label_classes, caa_label_start_classes, caa_label_end_classes, caa_item_wrap_class, caa_cai_list
  from adc_apex_actions_v saa
  left join (
       select cai_caa_id, listagg(cai_cpi_id, ':') within group (order by cai_cpi_id) caa_cai_list
         from adc_apex_action_items
        group by cai_caa_id) sai
    on caa_id = cai_caa_id;
    
comment on table adc_ui_designer_apex_action is 'View on ADC_APEX_ACTION.';