create or replace view adc_ui_designer_rule
as 
select cru_id, cru_cgr_id, cru_name, cru_condition, cru_sort_seq, cru_active, cru_fire_on_page_load
  from adc_rules;

comment on table adc_ui_designer_rule is 'Edit data for a rule';