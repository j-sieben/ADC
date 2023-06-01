create or replace force view adca_ui_lov_crg_applications
as 
  with params as(
       select utl_apex.get_application_id app_id,
              adc_util.c_true c_true,
              utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin
         from dual)
select /*+ NO_MERGE (p) */
       distinct application_id || ' - ' || application_name || ' (' || alias || ')' d, application_id r
  from apex_applications app
  join adc_rule_groups sgr
    on app.application_id = sgr.crg_app_id
  join params p
    on (sgr.crg_app_id != p.app_id or p.is_adc_admin = p.c_true);
