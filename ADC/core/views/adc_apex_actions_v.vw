create or replace editionable view adc_apex_actions_v as 
select caa_id,
       caa_crg_id,
       caa_caat_id, 
       caa_name,
       pti_name caa_label,
       to_char(pti_description) caa_context_label,
       caa_confirm_message_name,
       caa_icon,
       caa_icon_type,
       pti_display_name caa_title,
       caa_shortcut,
       caa_initially_disabled,
       caa_initially_hidden,
       caa_href,
       caa_action,
       caa_on_label,
       caa_off_label,
       caa_get,
       caa_set,
       caa_choices,
       caa_label_classes,
       caa_label_start_classes,
       caa_label_end_classes,
       caa_item_wrap_class,
       caa_pti_id
  from adc_apex_actions
  join pit_translatable_item_v
    on caa_pti_id = pti_id
   and caa_pmg_name = pti_pmg_name;