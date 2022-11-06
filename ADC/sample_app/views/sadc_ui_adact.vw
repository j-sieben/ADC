create or replace force view sadc_ui_adact as
select emp_id, emp_first_name, emp_last_name, dep_name, job_title
  from hr_employees
  join hr_departments
    on emp_dep_id = dep_id
  join hr_jobs
    on emp_job_id = job_id;