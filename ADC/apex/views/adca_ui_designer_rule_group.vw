create or replace view adca_ui_designer_rule_group as
with params as (
       select utl_apex.get_number('CRG_ID') g_crg_id,
              adc_util.C_TRUE c_true,
              adc_util.C_FALSE c_false,
              'fa-check' C_YES,
              'fa-times' C_NO
         from dual),
     data as(
       select /*+ no_merge (p) */
              max(crg_active) crg_active,
              count(distinct cru_id) cru_amt,
              count(distinct cra_id) cra_amt,
              count(distinct caa_id) caa_amt,
              max(is_home_page) is_home_page,
              listagg(distinct cpi_id, '<br>') within group (order by cpi_id) firing_items
         from (select crg_id, crg_active, c_true, c_false,
                      case when utl_apex.get_application_id = crg_app_id and utl_apex.get_page_id = crg_page_id then c_true else c_false end is_home_page
                 from adc_rule_groups
                 join params p
                   on crg_id = g_crg_id
               union all
               select null, null, null, null, null
                 from dual)
         left join adc_rules
           on crg_id = cru_crg_id
         left join adc_rule_actions
           on cru_id = cra_cru_id
         left join adc_apex_actions
           on crg_id = caa_crg_id
         left join (
              select cpi_crg_id, cpi_id
                from adc_rules
                join adc_page_items
                  on cru_crg_id = cpi_crg_id
               where instr(',' || cru_firing_items|| ',', ',' || cpi_id || ',') > 0
                 /*and instr(cpi_cpit_id, 'ITEM') > 0*/)
           on crg_id = cpi_crg_id)
select case is_home_page when c_false then
         apex_item.switch(
             p_idx => 1,
             p_value => crg_active,
             p_on_value => C_TRUE,
             p_off_value => C_FALSE,
             p_item_id => 'P1_CRG_ACTIVE',
             p_item_label => NULL,
             p_attributes => 'class="js-actionButton" data-action="toggle-cgr-active"') 
       else
         -- Home Page of ADC must not be deactivated
         '<i class="fa fa-check"></i>'
       end crg_active,
       cru_amt, cra_amt, caa_amt, firing_items
  from data
 cross join params;
 
comment on table adca_ui_designer_rule_group is 'Form data including an overview over the rule and a switch to disable the rule group';
