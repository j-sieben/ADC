create or replace force view sadc_lov_department as
select dep_name d, dep_id r
  from hr_departments;