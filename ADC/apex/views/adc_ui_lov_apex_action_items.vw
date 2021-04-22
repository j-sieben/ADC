create or replace editionable view adc_ui_lov_apex_action_items
as 
select cit_name || ' »' || cpi_label || '«' d, cpi_id r, cgr_id, cpi_cty_id
  from adc_page_items spi
  join adc_rule_groups sgr
    on cpi_cgr_id = cgr_id
  join adc_page_item_types_v sit
    on cpi_cit_id = cit_id
  join adc_apex_action_types
    on cpi_cty_id = cty_id;
