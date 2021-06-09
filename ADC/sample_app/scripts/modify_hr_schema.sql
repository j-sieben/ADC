alter table jobs add (
  comm_eligible number(1, 0) default on null 0,
  is_manager number(1, 0) default on null 0);
  
update jobs
   set comm_eligible = 1
 where job_id in ('SA_MAN', 'SA_REP');
 
 
update jobs
   set is_manager = 1
 where job_id like '%MAN'
    or job_id like '%VP'
    or job_id like '%MGR'
    or job_id like '%PRES';
    
commit;