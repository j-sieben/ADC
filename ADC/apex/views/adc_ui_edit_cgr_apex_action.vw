create or replace editionable view adc_ui_edit_cgr_apex_action
as 
select caa_id, caa_cgr_id, caa_name, caa_label, cty_name, caa_shortcut
  from adc_ui_edit_caa saa
  join adc_apex_action_types_v sty
    on caa_cty_id = cty_id;