create or replace view sadc_ui_adrep as
select employee_id, first_name, last_name, department_name, job_title
  from employees e
  join departments d
    on e.department_id = d.department_id
  join jobs j
    on e.job_id = j.job_id;