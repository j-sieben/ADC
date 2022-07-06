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

comment on table adc_bl_rules is 'View to collect common data for rules and their respective actions. Is used as the basis for ADC to execute the rule logic';
comment on column adc_bl_rules.cru_id is 'ID of the rule, reference to <Tables.ADC_RULES>';
comment on column adc_bl_rules.cgr_id is 'ID of the rule group, reference to <Tables.ADC_RULE_GROUPS>';
comment on column adc_bl_rules.cru_sort_seq is 'Sort criteria of the rule';
comment on column adc_bl_rules.cru_name is 'Name of the rule';
comment on column adc_bl_rules.cru_firing_items is 'List of page items that are considered firing, separated by comma';
comment on column adc_bl_rules.cru_fire_on_page_load is 'Flag to indicate whether this rule should be considere upon page initialization additionally to the initialize rule';
comment on column adc_bl_rules.cra_raise_recursive is 'Flag to indicate whether this rule allows for recursive execution';
comment on column adc_bl_rules.cra_cpi_id is 'Page item the rule action refers to, reference to <Tables.ADC_PAGE_ITEMS>';
comment on column adc_bl_rules.item_css is 'All CSS classes attached to the page item';
comment on column adc_bl_rules.cra_cat_id is 'ADC action type of the action. Reference to <Tables.ADC_ACTION_TYPES>';
comment on column adc_bl_rules.cra_param_1 is 'Actual value of parameter 1 of the action';
comment on column adc_bl_rules.cra_param_2 is 'Actual value of parameter 2 of the action';
comment on column adc_bl_rules.cra_param_3 is 'Actual value of parameter 3 of the action';
comment on column adc_bl_rules.cra_on_error is 'Flag to indicate whether this action is an error handler';
comment on column adc_bl_rules.cra_sort_seq is 'Sort criteria of the action';