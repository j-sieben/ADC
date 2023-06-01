create or replace force view adca_ui_lov_apex_action_items
as 
select cpi_id || ' (' || cpi_label || ')' d, cpi_id r, crg_id, cpi_caat_id
  from adc_page_items spi
  join adc_rule_groups sgr
    on cpi_crg_id = crg_id
  join adc_page_item_types_v sit
    on cpi_cpit_id = cpit_id
  join adc_apex_action_types
    on cpi_caat_id = caat_id;
