create or replace view adc_ui_admin_cgr_commands as
with params as (
       select utl_apex.get_number('CGR_ID') g_cgr_id
         from dual)
select /*+ no_merge (p) */ 
       caa_id, caa_name, caa_label, caa_context_label, caa_shortcut, caa_cai_list
  from adc_apex_actions_v
  join params p
    on caa_cgr_id = g_cgr_id
  left join (
       select cai_caa_id, listagg(cai_cpi_id, ', ') within group (order by cai_cpi_id) caa_cai_list
         from adc_apex_action_items
        group by cai_caa_id)
    on caa_id = cai_caa_id;
