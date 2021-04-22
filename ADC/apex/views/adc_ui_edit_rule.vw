create or replace force view adc_ui_edit_rule
as 
select sru.rowid row_id, sru.cru_id, sru.cru_cgr_id, sru.cru_name, sru.cru_condition, sru.cru_firing_items,
       sru.cru_sort_seq, sgr.cgr_app_id, sgr.cgr_page_id, sru.cru_active, sru.cru_fire_on_page_load
  from adc_rules sru
  join adc_rule_groups sgr
    on sru.cru_cgr_id = sgr.cgr_id;
