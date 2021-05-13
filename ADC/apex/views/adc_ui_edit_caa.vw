create or replace editionable view adc_ui_edit_caa
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
/*
select seq_id,
       n001 caa_id,
       n002 caa_cgr_id,
       c001 caa_cty_id,
       c002 caa_name,
       c003 caa_label,
       c004 caa_context_label,
       c005 caa_icon,
       c006 caa_icon_type,
       c007 caa_title,
       c008 caa_shortcut,
       c009 caa_initially_disabled,
       c010 caa_initially_hidden,
       c011 caa_href,
       c012 caa_action,
       c013 caa_on_label,
       c014 caa_off_label,
       c015 caa_get,
       c016 caa_set,
       c017 caa_choices,
       c018 caa_label_classes,
       c019 caa_label_start_classes,
       c020 caa_label_end_classes,
       c021 caa_item_wrap_class,
       c022 caa_cai_list
  from apex_collections
 where collection_name = 'ADC_UI_EDIT_CAA';
*/
comment on table adc_ui_edit_caa is 'Collection View auf ADC_APEX_ACTION, nicht refaktorisieren, um zeitgleiche Erstellung von Regelgruppe und Seitenaktionen zu ermoeglichen.';