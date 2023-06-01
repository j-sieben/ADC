create or replace force view adca_ui_lov_applications
as 
with params as(
       select utl_apex.get_application_id(utl_apex.c_true) app_id,
              utl_apex.current_user_in_group('ADC_ADMIN') is_adc_admin,
              utl_apex.c_true c_true
         from dual)
select /*+ NO_MERGE (p) */
       a.application_name || ' (' || a.application_id || ')' d,
       a.application_id r
  from apex_applications a
 cross join params p
 where (application_id != p.app_id or p.is_adc_admin = p.c_true)
   and application_id not between 3000 and 9000;

comment on table adca_ui_lov_applications is 'LOV view that displays all user defined APEX applications. Application ADC is excluded, unless the user is Administrator';
