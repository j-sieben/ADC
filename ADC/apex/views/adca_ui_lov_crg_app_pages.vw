create or replace force view adca_ui_lov_crg_app_pages
as 
  with params as(
       select utl_apex.get_application_id app_id,
              adc_util.c_true c_true,
              utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin
         from dual)
select /*+ no merge(p) */
       page_id || ' - ' || page_name || ' (' || page_alias || ')' d, page_id r, sgr.crg_app_id
  from apex_application_pages app
  join adc_rule_groups sgr
    on app.application_id = sgr.crg_app_id
   and app.page_id = sgr.crg_page_id
 cross join params p
 where sgr.crg_app_id != p.app_id
    or p.is_adc_admin = c_true;
