create or replace view adc_ui_admin_cgr_main
as 
with params as (
       select utl_apex.get_application_id c_app_id,
              utl_apex.get_number('P1_CGR_APP_ID') c_cgr_app_id,
              utl_apex.get_number('P1_CGR_PAGE_ID') c_cgr_page_id,
              adc_util.c_true c_true,
              utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin
         from dual
       ),
       rule_details as (
       select cru_cgr_id, count(*) cru_amount
         from adc_rules
        group by cru_cgr_id),
       apex_action_details as(
       select caa_cgr_id, count(*) caa_amount
         from adc_apex_actions_v
        group by caa_cgr_id)
select /*+ NO_MERGE (p) */
       cgr_app_id, cgr_page_id, cgr_id,
       app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_name || ' (' || pag.page_id || ')' page_name,
       coalesce(cru_amount, 0) cru_amount, 
       coalesce(caa_amount, 0) caa_amount,
       cgr_with_recursion, cgr_active
  from adc_rule_groups
  left join rule_details
    on cgr_id = cru_cgr_id
  left join apex_action_details
    on cgr_id = caa_cgr_id
  join apex_applications app
    on cgr_app_id = app.application_id
  join apex_application_pages pag
    on cgr_app_id = pag.application_id
   and cgr_page_id = pag.page_id
  join params p
    on cgr_app_id = c_cgr_app_id
   and (cgr_page_id = c_cgr_page_id or c_cgr_page_id is null)
 where cgr_app_id != c_app_id
    or is_adc_admin = c_true;
