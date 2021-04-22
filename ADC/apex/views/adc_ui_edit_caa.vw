create or replace editionable view adc_ui_edit_caa
as 
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

comment on table adc_ui_edit_caa is 'Collection View auf ADC_APEX_ACTION, nicht refaktorisieren, um zeitgleiche Erstellung von Regelgruppe und Seitenaktionen zu ermoeglichen.';