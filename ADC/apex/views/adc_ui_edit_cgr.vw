create or replace editionable view adc_ui_edit_cgr
as 
select cgr_id, cgr_app_id, cgr_page_id, cgr_active, cgr_initialization_code, cgr_with_recursion
  from adc_rule_groups;
