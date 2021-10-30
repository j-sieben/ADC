create or replace view adc_ui_designer_rule_group as
with params as (
       select utl_apex.get_number('CGR_ID') g_cgr_id,
              adc_util.C_TRUE c_true,
              adc_util.C_FALSE c_false,
              'fa-check' C_YES,
              'fa-times' C_NO
         from dual),
     data as(
       select /*+ no_merge (p) */
              max(cgr_active) cgr_active,
              count(distinct cru_id) cru_amt,
              count(distinct cra_id) cra_amt,
              count(distinct caa_id) caa_amt,
              max(is_home_page) is_home_page,
              listagg(distinct cpi_id, '<br>') within group (order by cpi_id) firing_items
         from (select cgr_id, cgr_active, c_true, c_false,
                      case when utl_apex.get_application_id = cgr_app_id and utl_apex.get_page_id = cgr_page_id then c_true else c_false end is_home_page
                 from adc_rule_groups
                 join params p
                   on cgr_id = g_cgr_id
               union all
               select null, null, null, null, null
                 from dual)
         left join adc_rules
           on cgr_id = cru_cgr_id
         left join adc_rule_actions
           on cru_id = cra_cru_id
         left join adc_apex_actions
           on cgr_id = caa_cgr_id
         left join (
              select cpi_cgr_id, cpi_id
                from adc_rules
                join adc_page_items
                  on cru_cgr_id = cpi_cgr_id
               where instr(',' || cru_firing_items|| ',', ',' || cpi_id || ',') > 0
                 /*and instr(cpi_cit_id, 'ITEM') > 0*/)
           on cgr_id = cpi_cgr_id)
select case is_home_page when c_false then
         apex_item.switch(
             p_idx => 1,
             p_value => cgr_active,
             p_on_value => C_TRUE,
             p_off_value => C_FALSE,
             p_item_id => 'P1_CGR_ACTIVE',
             p_item_label => NULL,
             p_attributes => 'class="js-actionButton" data-action="toggle-cgr-active"') 
       else
         -- Home Page of ADC must not be deactivated
         '<i class="fa fa-check"></i>'
       end cgr_active,
       cru_amt, cra_amt, caa_amt, firing_items
  from data
 cross join params;
 
comment on table adc_ui_designer_rule_group is 'Form data including an overview over the rule and a switch to disable the rule group';
