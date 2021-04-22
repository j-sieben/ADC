create or replace editionable view adc_bl_rules
as 
with params as(
       select adc_util.c_true c_true
         from dual)
       -- get all rules and items denormalized
select /*+ no_merge(p) */
       sru.cru_id, sru.cru_cgr_id cgr_id, sru.cru_sort_seq, sru.cru_name,
       ',' || sru.cru_firing_items|| ',DOCUMENT,' cru_firing_items, cru_fire_on_page_load, sra.cra_raise_recursive,
       sra.cra_cpi_id, spi.cpi_css item_css, sra.cra_cat_id, sra.cra_param_1, sra.cra_param_2, sra.cra_param_3, sra.cra_on_error, sra.cra_sort_seq
  from adc_rule_groups sgr
  join adc_rules sru
    on sgr.cgr_id = sru.cru_cgr_id
  join adc_rule_actions sra
    on sru.cru_id in sra.cra_cru_id
   and sru.cru_cgr_id in sra.cra_cgr_id
  join adc_page_items spi
    on sgr.cgr_id = spi.cpi_cgr_id
   and sra.cra_cpi_id = spi.cpi_id
  join params p
    on sgr.cgr_active = p.c_true
   and sru.cru_active = p.c_true
   and sra.cra_active = p.c_true
 where sra.cra_cpi_id != 'ALL';
