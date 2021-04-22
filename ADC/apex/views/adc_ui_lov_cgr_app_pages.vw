create or replace editionable view adc_ui_lov_cgr_app_pages
as 
  with params as(
       select utl_apex.get_application_id app_id,
              adc_util.c_true c_true,
              utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin
         from dual)
select /*+ no merge(p) */
       page_name || ' (' || page_id || ')' d, page_id r, sgr.cgr_app_id
  from apex_application_pages app
  join adc_rule_groups sgr
    on app.application_id = sgr.cgr_app_id
   and app.page_id = sgr.cgr_page_id
 cross join params p
 where sgr.cgr_app_id != p.app_id
    or p.is_adc_admin = c_true;
