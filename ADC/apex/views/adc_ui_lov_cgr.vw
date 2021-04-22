create or replace editionable view adc_ui_lov_cgr
as 
select cgr_description || ' (' || cgr_name || ')' d, cgr_id r
  from adc_rule_groups;
