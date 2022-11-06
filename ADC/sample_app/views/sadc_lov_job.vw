create or replace force view sadc_lov_job as
select job_title d, job_id r
  from hr_jobs;