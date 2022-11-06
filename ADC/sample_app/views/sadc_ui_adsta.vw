create or replace force view sadc_ui_adsta as
select emp_id, emp_first_name, emp_last_name, emp_email, emp_phone_number, emp_hire_date, 
       emp_job_id, emp_salary, emp_commission_pct, emp_mgr_id, emp_dep_id
  from hr_employees;