create or replace force view adc_bl_rules
as 
with params as(
       select adc_util.c_true c_true
         from dual)
       -- get all rules and items denormalized
select /*+ no_merge(p) */
       cru_id, cru_crg_id crg_id, cru_sort_seq, cru_name,
       ',' || cru_firing_items|| ',DOCUMENT,' cru_firing_items, cru_fire_on_page_load, cra_raise_recursive,
       cra_cpi_id, cpi_css item_css, cra_cat_id, cra_param_1, cra_param_2, cra_param_3, cra_on_error, cra_sort_seq
  from adc_rule_groups
  join adc_rules
    on crg_id = cru_crg_id
  join adc_rule_actions
    on cru_id in cra_cru_id
   and cru_crg_id in cra_crg_id
  join adc_page_items
    on crg_id = cpi_crg_id
   and cra_cpi_id = cpi_id
  join params
    on crg_active = c_true
   and cru_active = c_true
   and cra_active = c_true
 where cra_cpi_id != 'ALL';

comment on table adc_bl_rules is 'View to collect common data for rules and their respective actions. Is used as the basis for ADC to execute the rule logic';
comment on column adc_bl_rules.cru_id is 'ID of the rule, reference to <Tables.ADC_RULES>';
comment on column adc_bl_rules.crg_id is 'ID of the rule group, reference to <Tables.ADC_RULE_GROUPS>';
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