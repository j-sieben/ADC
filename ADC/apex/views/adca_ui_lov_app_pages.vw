create or replace force view adca_ui_lov_app_pages
as 
select page_name || ' (' || page_id || ')' d,
       page_id r,
       application_id
  from apex_application_pages
 where page_id > 0;
