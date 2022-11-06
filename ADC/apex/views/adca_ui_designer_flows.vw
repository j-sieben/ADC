create or replace force view adca_ui_designer_flows as
select diagram_id, diagram_name, diagram_version, diagram_status_id, diagram_category
  from fls_diagrams_v;
       