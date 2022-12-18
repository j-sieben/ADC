set serveroutput on

prompt &h2.Removing existing tables
declare
   cursor delete_object_cur is
    select *
      from user_objects
     where object_name like 'HR%'
       and object_type in ('TABLE', 'VIEW', 'SEQUENCE');
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.object_type || ' ' || obj.object_name || case obj.object_type when 'TABLE' then ' cascade constraints purge' end;
      dbms_output.put_line('&s1.' || lower(obj.object_type) || ' ' || obj.object_name || ' deleted');
    exception
      when others then
        dbms_output.put_line('&s1.Error at ' || lower(obj.object_type) || ' ' || obj.object_name || ': ' || sqlerrm);
    end;
  end loop;
end;
/

prompt &h2. Creating tables
prompt &s1.Creating HR_REGIONS table

create table hr_regions(
  reg_id number constraint reg_id_notnull not null,
  reg_name varchar2(25 char),
  constraint hr_regions_p primary key(reg_id)
) organization index;


prompt &s1.Creating hr_countries table

create table hr_countries(
  cou_id char(2 byte) constraint cou_id_notnull not null,
  cou_name varchar2(40 char),
  cou_reg_id number, 
  constraint hr_countries_p primary key (cou_id),
  constraint cou_reg_id_fk foreign key (cou_reg_id)
    references hr_regions(reg_id) 
) organization index; 



prompt &s1.Creating hr_locations table

create table hr_locations(
  loc_id number(4),
  loc_street_address varchar2(40 char),
  loc_postal_code varchar2(12 byte),
  loc_city varchar2(30 char) constraint loc_city_notnull not null,
  loc_state_province varchar2(25 char),
  loc_cou_id char(2 byte),
  loc_geometry sdo_geometry,
  constraint hr_locations_p primary key (loc_id),
  constraint loc_cou_id_fk foreign key (loc_cou_id)
    references hr_countries(cou_id) 
) organization index;

create sequence hr_locations_seq
 start with     3300
 increment by   100
 maxvalue       9900
 nocache
 nocycle;

prompt &s1.Creating hr_departments table

prompt &s1.Creating hr_departments table

create table hr_departments(
  dep_id number(4),
  dep_name varchar2(30 char) constraint dept_name_notnull not null,
  dep_mgr_id number(6),
  dep_loc_id number(4),
  constraint hr_departments_p primary key (dep_id),
  constraint dep_loc_id_fk foreign key (dep_loc_id)
    references hr_locations (loc_id)
);


create sequence hr_departments_seq
 start with     280
 increment by   10
 maxvalue       9990
 nocache
 nocycle;


prompt &s1.Creating hr_jobs table

create table hr_jobs(
  job_id varchar2(10 byte),
  job_title varchar2(35 char) constraint job_title_notnull not null,
  job_min_salary number(6),
  job_max_salary number(6),
  job_is_commission_eligible char(1 byte) default on null 'Y' constraint job_is_commission_eligible_chk check (job_is_commission_eligible in ('Y', 'N')),
  constraint job_id_p primary key(job_id)
)organization index;


prompt &s1.Creating hr_employees table

create table hr_employees(
  emp_id number(6),
  emp_first_name varchar2(20 char),
  emp_last_name varchar2(25 char) constraint emp_last_name_notnull not null,
  emp_email varchar2(25 char) constraint emp_email_notnull not null,
  emp_phone_number varchar2(20 byte),
  emp_hire_date date constraint emp_hire_date_notnull not null,
  emp_job_id varchar2(10) constraint emp_job_notnull not null,
  emp_salary number(8,2),
  emp_commission_pct number(2,2),
  emp_mgr_id number(6),
  emp_dep_id number(4),
  emp_is_manager char(1 byte) default on null 'Y' constraint emp_is_manager_chk check (emp_is_manager in ('Y', 'N')),
  constraint hr_employees_p primary key (emp_id),
  constraint emp_dep_id_fk foreign key (emp_dep_id)
    references hr_departments,
  constraint emp_job_id_fk foreign key (emp_job_id)
    references hr_jobs (job_id),
  constraint emp_mgr_id_fk foreign key (emp_mgr_id)
    references hr_employees,
  constraint emp_email_u unique (emp_email),
  constraint emp_salary_gt_0 check (emp_salary > 0)
);

prompt &s1.Create foreign key constraint here to overcome circular dependency
alter table hr_departments add (
  constraint dep_mgr_id_fk foreign key (dep_mgr_id)
    references hr_employees (emp_id)
);
prompt &s1.Disable integrity constraint to hr_employees to load data
alter table hr_departments disable constraint dep_mgr_id_fk;


prompt &s1.Create sequence hr_employee_seq, starting with 207 
create sequence hr_employees_seq
 start with     207
 increment by   1
 nocache
 nocycle;

prompt &s1.Creating HR_EMP_DETAILS view

create or replace force view hr_emp_details as
select emp_id, job_id, emp_mgr_id, dep_id, loc_id, cou_id,
       emp_first_name, emp_last_name, emp_salary, emp_commission_pct, dep_name,
       job_title, substr(job_id, 4) job_group, loc_city, loc_state_province, cou_name, reg_name
  from hr_employees
  join hr_departments on emp_dep_id = dep_id
  join hr_jobs on emp_job_id = job_id
  join hr_locations on dep_loc_id = loc_id
  join hr_countries on loc_cou_id = cou_id
  join hr_regions on cou_reg_id = reg_id
with read only;

prompt &s1.Creating indexes

create index emp_department_i
       on hr_employees (emp_dep_id);

create index emp_job_i
       on hr_employees (emp_job_id);

create index emp_manager_i
       on hr_employees (emp_mgr_id);

create index emp_name_i
       on hr_employees (emp_last_name, emp_first_name);

create index dept_location_i
       on hr_departments (dep_loc_id);

create index loc_city_i
       on hr_locations (loc_city);

create index loc_state_province_i	
       on hr_locations (loc_state_province);

create index loc_country_i
       on hr_locations (loc_cou_id);

prompt &h2.Populating table data
prompt &s1.Populating HR_REGIONS table

insert into hr_regions(reg_id, reg_name)
select 1 reg_id, 'Europe' reg_name from dual union all
select 2, 'Americas' from dual union all
select 3, 'Asia'  from dual union all
select 4, 'Middle East and Africa' from dual;

commit;

prompt &s1.Populating HT_COUNTRIES table

insert into hr_countries(cou_id, cou_name, cou_reg_id)
select 'IT' cou_id, 'Italy' cou_name, 1 cou_reg_id  from dual union all
select 'JP', 'Japan', 3  from dual union all
select 'US', 'United States of America', 2 from dual union all
select 'CA', 'Canada', 2 from dual union all
select 'CN', 'China', 3  from dual union all
select 'IN', 'India', 3  from dual union all
select 'AU', 'Australia', 3 from dual union all
select 'ZW', 'Zimbabwe', 4 from dual union all
select 'SG', 'Singapore', 3 from dual union all
select 'UK', 'United Kingdom', 1 from dual union all
select 'FR', 'France', 1 from dual union all
select 'DE', 'Germany', 1 from dual union all
select 'ZM', 'Zambia', 4 from dual union all
select 'EG', 'Egypt', 4 from dual union all
select 'BR', 'Brazil', 2 from dual union all
select 'CH', 'Switzerland', 1 from dual union all
select 'NL', 'Netherlands', 1 from dual union all
select 'MX', 'Mexico', 2 from dual union all
select 'KW', 'Kuwait', 4 from dual union all
select 'IL', 'Israel', 4 from dual union all
select 'DK', 'Denmark', 1 from dual union all
select 'ML', 'Malaysia', 3 from dual union all
select 'NG', 'Nigeria', 4 from dual union all
select 'AR', 'Argentina', 2 from dual union all
select 'BE', 'Belgium', 1  from dual;

commit;

prompt &s1.Populating HR_LOCATIONS table

insert into hr_locations(loc_id, loc_street_address, loc_postal_code, loc_city, loc_state_province, loc_cou_id)
select 1000 loc_id, '1297 Via Cola di Rie' loc_street_address, '00989'loc_postal_code, 'Roma' loc_city, null loc_state_province, 'IT' loc_cou_id from dual union all
select 1100, '93091 Calle della Testa', '10934', 'Venice', null, 'IT' from dual union all
select 1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP' from dual union all
select 1300, '9450 Kamiya-cho', '6823', 'Hiroshima', null, 'JP' from dual union all
select 1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US' from dual union all
select 1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US' from dual union all
select 1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US' from dual union all
select 1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US' from dual union all
select 1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA' from dual union all
select 1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA' from dual union all
select 2000, '40-5-12 Laogianggen', '190518', 'Beijing', null, 'CN' from dual union all
select 2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN' from dual union all
select 2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU' from dual union all
select 2300, '198 Clementi North', '540198', 'Singapore', null, 'SG' from dual union all
select 2400, '8204 Arthur St', null, 'London', null, 'UK' from dual union all
select 2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK' from dual union all
select 2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK' from dual union all
select 2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE' from dual union all
select 2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR' from dual union all
select 2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH' from dual union all
select 3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH' from dual union all
select 3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL' from dual union all
select 3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX' from dual;

commit;

prompt &s1.Populating HR_DEPARTMENTS table

insert into hr_departments(dep_id, dep_name, dep_mgr_id, dep_loc_id)
select 10 dep_id, 'Administration' dep_name, 200 dep_mgr_id, 1700 dep_loc_id from dual union all
select 20, 'Marketing', 201, 1800 from dual union all
select 30, 'Purchasing', 114, 1700 from dual union all
select 40, 'Human Resources', 203, 2400 from dual union all
select 50, 'Shipping', 121, 1500 from dual union all
select 60, 'IT', 103, 1400 from dual union all
select 70, 'Public Relations', 204, 2700 from dual union all
select 80, 'Sales', 145, 2500 from dual union all
select 90, 'Executive', 100, 1700 from dual union all
select 100, 'Finance', 108, 1700 from dual union all
select 110, 'Accounting', 205, 1700 from dual union all
select 120, 'Treasury', null, 1700 from dual union all
select 130, 'Corporate Tax', null, 1700 from dual union all
select 140, 'Control And Credit', null, 1700 from dual union all
select 150, 'Shareholder Services', null, 1700 from dual union all
select 160, 'Benefits', null, 1700 from dual union all
select 170, 'Manufacturing', null, 1700 from dual union all
select 180, 'Construction', null, 1700 from dual union all
select 190, 'Contracting', null, 1700 from dual union all
select 200, 'Operations', null, 1700 from dual union all
select 210, 'IT Support', null, 1700 from dual union all
select 220, 'NOC', null, 1700 from dual union all
select 230, 'IT Helpdesk', null, 1700 from dual union all
select 240, 'Government Sales', null, 1700 from dual union all
select 250, 'Retail Sales', null, 1700 from dual union all
select 260, 'Recruiting', null, 1700 from dual union all
select 270, 'Payroll', null, 1700 from dual;

commit;

prompt &s1.Populating HR_JOBS table

insert into hr_jobs(job_id, job_title, job_min_salary, job_max_salary, job_is_commission_eligible)
select 'AD_PRES' job_id, 'President' job_title, 20080 job_min_salary, 40000 job_max_salary, 'N' job_is_commission_eligible from dual union all
select 'AD_VP', 'Administration Vice President', 15000, 30000, 'N' from dual union all
select 'AD_ASST', 'Administration Assistant', 3000, 6000, 'N' from dual union all
select 'FI_MGR', 'Finance Manager', 8200, 16000, 'N' from dual union all
select 'FI_ACCOUNT', 'Accountant', 4200, 9000, 'N' from dual union all
select 'AC_MGR', 'Accounting Manager', 8200, 16000, 'N' from dual union all
select 'AC_ACCOUNT', 'Public Accountant', 4200, 9000, 'N' from dual union all
select 'SA_MAN', 'Sales Manager', 10000, 20080, 'Y' from dual union all
select 'SA_REP', 'Sales Representative', 6000, 12008, 'Y' from dual union all
select 'PU_MAN', 'Purchasing Manager', 8000, 15000, 'N' from dual union all
select 'PU_CLERK', 'Purchasing Clerk', 2500, 5500, 'N' from dual union all
select 'ST_MAN', 'Stock Manager', 5500, 8500, 'N' from dual union all
select 'ST_CLERK', 'Stock Clerk', 2008, 5000, 'N' from dual union all
select 'SH_CLERK', 'Shipping Clerk', 2500, 5500, 'N' from dual union all
select 'IT_PROG', 'Programmer', 4000, 10000, 'N' from dual union all
select 'MK_MAN', 'Marketing Manager', 9000, 15000, 'N' from dual union all
select 'MK_REP', 'Marketing Representative', 4000, 9000, 'N' from dual union all
select 'HR_REP', 'Human Resources Representative', 4000, 9000, 'N' from dual union all
select 'PR_REP', 'Public Relations Representative', 4500, 10500, 'N' from dual;

commit;

prompt &s1.Populating HR_EMPLOYEES table

insert into hr_employees(emp_id, emp_first_name, emp_last_name, emp_email, emp_phone_number, emp_hire_date, emp_job_id, emp_salary, emp_commission_pct, emp_mgr_id, emp_dep_id)
select 100 emp_id, 'Steven' emp_first_name, 'King' emp_last_name, 'SKING' emp_email, '515.123.4567' emp_phone_number, to_date('17.06.2003', 'dd.mm.yyyy') emp_hire_date, 'AD_PRES' emp_job_id, 24000 emp_salary, null emp_commission_pct, null emp_mgr_id, 90 emp_dep_id from dual union all
select 101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', to_date('21.09.2005', 'dd.mm.yyyy'), 'AD_VP', 17000, null, 100, 90 from dual union all
select 102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', to_date('13.01.2001', 'dd.mm.yyyy'), 'AD_VP', 17000, null, 100, 90 from dual union all
select 103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', to_date('03.01.2006', 'dd.mm.yyyy'), 'IT_PROG', 9000, null, 102, 60 from dual union all
select 104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', to_date('21.05.2007', 'dd.mm.yyyy'), 'IT_PROG', 6000, null, 103, 60 from dual union all
select 105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', to_date('25.06.2005', 'dd.mm.yyyy'), 'IT_PROG', 4800, null, 103, 60 from dual union all
select 106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', to_date('05.02.2006', 'dd.mm.yyyy'), 'IT_PROG', 4800, null, 103, 60 from dual union all
select 107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', to_date('07.02.2007', 'dd.mm.yyyy'), 'IT_PROG', 4200, null, 103, 60 from dual union all
select 108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', to_date('17.08.2002', 'dd.mm.yyyy'), 'FI_MGR', 12008, null, 101, 100 from dual union all
select 109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', to_date('16.08.2002', 'dd.mm.yyyy'), 'FI_ACCOUNT', 9000, null, 108, 100 from dual union all
select 110, 'John', 'Chen', 'JCHEN', '515.124.4269', to_date('28.09.2005', 'dd.mm.yyyy'), 'FI_ACCOUNT', 8200, null, 108, 100 from dual union all
select 111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', to_date('30.09.2005', 'dd.mm.yyyy'), 'FI_ACCOUNT', 7700, null, 108, 100 from dual union all
select 112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', to_date('07.03.2006', 'dd.mm.yyyy'), 'FI_ACCOUNT', 7800, null, 108, 100 from dual union all
select 113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', to_date('07.12.2007', 'dd.mm.yyyy'), 'FI_ACCOUNT', 6900, null, 108, 100 from dual union all
select 114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', to_date('07.12.2002', 'dd.mm.yyyy'), 'PU_MAN', 11000, null, 100, 30 from dual union all
select 115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', to_date('18.05.2003', 'dd.mm.yyyy'), 'PU_CLERK', 3100, null, 114, 30 from dual union all
select 116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', to_date('24.12.2005', 'dd.mm.yyyy'), 'PU_CLERK', 2900, null, 114, 30 from dual union all
select 117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', to_date('24.07.2005', 'dd.mm.yyyy'), 'PU_CLERK', 2800, null, 114, 30 from dual union all
select 118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', to_date('15.11.2006', 'dd.mm.yyyy'), 'PU_CLERK', 2600, null, 114, 30 from dual union all
select 119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', to_date('10.08.2007', 'dd.mm.yyyy'), 'PU_CLERK', 2500, null, 114, 30 from dual union all
select 120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', to_date('18.07.2004', 'dd.mm.yyyy'), 'ST_MAN', 8000, null, 100, 50 from dual union all
select 121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', to_date('10.04.2005', 'dd.mm.yyyy'), 'ST_MAN', 8200, null, 100, 50 from dual union all
select 122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', to_date('01.05.2003', 'dd.mm.yyyy'), 'ST_MAN', 7900, null, 100, 50 from dual union all
select 123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', to_date('10.10.2005', 'dd.mm.yyyy'), 'ST_MAN', 6500, null, 100, 50 from dual union all
select 124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', to_date('16.11.2007', 'dd.mm.yyyy'), 'ST_MAN', 5800, null, 100, 50 from dual union all
select 125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', to_date('16.07.2005', 'dd.mm.yyyy'), 'ST_CLERK', 3200, null, 120, 50 from dual union all
select 126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', to_date('28.09.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2700, null, 120, 50 from dual union all
select 127, 'James', 'Landry', 'JLANDRY', '650.124.1334', to_date('14.01.2007', 'dd.mm.yyyy'), 'ST_CLERK', 2400, null, 120, 50 from dual union all
select 128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', to_date('08.03.2008', 'dd.mm.yyyy'), 'ST_CLERK', 2200, null, 120, 50 from dual union all
select 129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', to_date('20.08.2005', 'dd.mm.yyyy'), 'ST_CLERK', 3300, null, 121, 50 from dual union all
select 130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', to_date('30.10.2005', 'dd.mm.yyyy'), 'ST_CLERK', 2800, null, 121, 50 from dual union all
select 131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', to_date('16.02.2005', 'dd.mm.yyyy'), 'ST_CLERK', 2500, null, 121, 50 from dual union all
select 132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', to_date('10.04.2007', 'dd.mm.yyyy'), 'ST_CLERK', 2100, null, 121, 50 from dual union all
select 133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', to_date('14.06.2004', 'dd.mm.yyyy'), 'ST_CLERK', 3300, null, 122, 50 from dual union all
select 134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', to_date('26.08.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2900, null, 122, 50 from dual union all
select 135, 'Ki', 'Gee', 'KGEE', '650.127.1734', to_date('12.12.2007', 'dd.mm.yyyy'), 'ST_CLERK', 2400, null, 122, 50 from dual union all
select 136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', to_date('06.02.2008', 'dd.mm.yyyy'), 'ST_CLERK', 2200, null, 122, 50 from dual union all
select 137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', to_date('14.07.2003', 'dd.mm.yyyy'), 'ST_CLERK', 3600, null, 123, 50 from dual union all
select 138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', to_date('26.10.2005', 'dd.mm.yyyy'), 'ST_CLERK', 3200, null, 123, 50 from dual union all
select 139, 'John', 'Seo', 'JSEO', '650.121.2019', to_date('12.02.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2700, null, 123, 50 from dual union all
select 140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', to_date('06.04.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2500, null, 123, 50 from dual union all
select 141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', to_date('17.10.2003', 'dd.mm.yyyy'), 'ST_CLERK', 3500, null, 124, 50 from dual union all
select 142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', to_date('29.01.2005', 'dd.mm.yyyy'), 'ST_CLERK', 3100, null, 124, 50 from dual union all
select 143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', to_date('15.03.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2600, null, 124, 50 from dual union all
select 144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', to_date('09.07.2006', 'dd.mm.yyyy'), 'ST_CLERK', 2500, null, 124, 50 from dual union all
select 145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', to_date('01.10.2004', 'dd.mm.yyyy'), 'SA_MAN', 14000, .4, 100, 80 from dual union all
select 146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', to_date('05.01.2005', 'dd.mm.yyyy'), 'SA_MAN', 13500, .3, 100, 80 from dual union all
select 147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', to_date('10.03.2005', 'dd.mm.yyyy'), 'SA_MAN', 12000, .3, 100, 80 from dual union all
select 148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', to_date('15.10.2007', 'dd.mm.yyyy'), 'SA_MAN', 11000, .3, 100, 80 from dual union all
select 149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', to_date('29.01.2008', 'dd.mm.yyyy'), 'SA_MAN', 10500, .2, 100, 80 from dual union all
select 150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', to_date('30.01.2005', 'dd.mm.yyyy'), 'SA_REP', 10000, .3, 145, 80 from dual union all
select 151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', to_date('24.03.2005', 'dd.mm.yyyy'), 'SA_REP', 9500, .25, 145, 80 from dual union all
select 152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', to_date('20.08.2005', 'dd.mm.yyyy'), 'SA_REP', 9000, .25, 145, 80 from dual union all
select 153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', to_date('30.03.2006', 'dd.mm.yyyy'), 'SA_REP', 8000, .2, 145, 80 from dual union all
select 154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', to_date('09.12.2006', 'dd.mm.yyyy'), 'SA_REP', 7500, .2, 145, 80 from dual union all
select 155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', to_date('23.11.2007', 'dd.mm.yyyy'), 'SA_REP', 7000, .15, 145, 80 from dual union all
select 156, 'Janette', 'King', 'JKING', '011.44.1345.429268', to_date('30.01.2004', 'dd.mm.yyyy'), 'SA_REP', 10000, .35, 146, 80 from dual union all
select 157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', to_date('04.03.2004', 'dd.mm.yyyy'), 'SA_REP', 9500, .35, 146, 80 from dual union all
select 158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', to_date('01.08.2004', 'dd.mm.yyyy'), 'SA_REP', 9000, .35, 146, 80 from dual union all
select 159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', to_date('10.03.2005', 'dd.mm.yyyy'), 'SA_REP', 8000, .3, 146, 80 from dual union all
select 160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', to_date('15.12.2005', 'dd.mm.yyyy'), 'SA_REP', 7500, .3, 146, 80 from dual union all
select 161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', to_date('03.11.2006', 'dd.mm.yyyy'), 'SA_REP', 7000, .25, 146, 80 from dual union all
select 162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', to_date('11.11.2005', 'dd.mm.yyyy'), 'SA_REP', 10500, .25, 147, 80 from dual union all
select 163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', to_date('19.03.2007', 'dd.mm.yyyy'), 'SA_REP', 9500, .15, 147, 80 from dual union all
select 164, 'Mattea', 'Marvins', 'mmARVINS', '011.44.1346.329268', to_date('24.01.2008', 'dd.mm.yyyy'), 'SA_REP', 7200, .10, 147, 80 from dual union all
select 165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', to_date('23.02.2008', 'dd.mm.yyyy'), 'SA_REP', 6800, .1, 147, 80 from dual union all
select 166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', to_date('24.03.2008', 'dd.mm.yyyy'), 'SA_REP', 6400, .10, 147, 80 from dual union all
select 167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', to_date('21.04.2008', 'dd.mm.yyyy'), 'SA_REP', 6200, .10, 147, 80 from dual union all
select 168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', to_date('11.03.2005', 'dd.mm.yyyy'), 'SA_REP', 11500, .25, 148, 80 from dual union all
select 169  , 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', to_date('23.03.2006', 'dd.mm.yyyy'), 'SA_REP', 10000, .20, 148, 80 from dual union all
select 170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', to_date('24.01.2006', 'dd.mm.yyyy'), 'SA_REP', 9600, .20, 148, 80 from dual union all
select 171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', to_date('23.02.2007', 'dd.mm.yyyy'), 'SA_REP', 7400, .15, 148, 80 from dual union all
select 172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', to_date('24.03.2007', 'dd.mm.yyyy'), 'SA_REP', 7300, .15, 148, 80 from dual union all
select 173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', to_date('21.04.2008', 'dd.mm.yyyy'), 'SA_REP', 6100, .10, 148, 80 from dual union all
select 174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', to_date('11.05.2004', 'dd.mm.yyyy'), 'SA_REP', 11000, .30, 149, 80 from dual union all
select 175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', to_date('19.03.2005', 'dd.mm.yyyy'), 'SA_REP', 8800, .25, 149, 80 from dual union all
select 176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', to_date('24.03.2006', 'dd.mm.yyyy'), 'SA_REP', 8600, .20, 149, 80 from dual union all
select 177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', to_date('23.04.2006', 'dd.mm.yyyy'), 'SA_REP', 8400, .20, 149, 80 from dual union all
select 178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', to_date('24.05.2007', 'dd.mm.yyyy'), 'SA_REP', 7000, .15, 149, null from dual union all
select 179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', to_date('04.01.2008', 'dd.mm.yyyy'), 'SA_REP', 6200, .10, 149, 80 from dual union all
select 180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', to_date('24.01.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3200, null, 120, 50 from dual union all
select 181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', to_date('23.02.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3100, null, 120, 50 from dual union all
select 182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', to_date('21.06.2007', 'dd.mm.yyyy'), 'SH_CLERK', 2500, null, 120, 50 from dual union all
select 183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', to_date('03.02.2008', 'dd.mm.yyyy'), 'SH_CLERK', 2800, null, 120, 50 from dual union all
select 184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', to_date('27.01.2004', 'dd.mm.yyyy'), 'SH_CLERK', 4200, null, 121, 50 from dual union all
select 185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', to_date('20.02.2005', 'dd.mm.yyyy'), 'SH_CLERK', 4100, null, 121, 50 from dual union all
select 186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', to_date('24.06.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3400, null, 121, 50 from dual union all
select 187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', to_date('07.02.2007', 'dd.mm.yyyy'), 'SH_CLERK', 3000, null, 121, 50 from dual union all
select 188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', to_date('14.06.2005', 'dd.mm.yyyy'), 'SH_CLERK', 3800, null, 122, 50 from dual union all
select 189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', to_date('13.08.2005', 'dd.mm.yyyy'), 'SH_CLERK', 3600, null, 122, 50 from dual union all
select 190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', to_date('11.07.2006', 'dd.mm.yyyy'), 'SH_CLERK', 2900, null, 122, 50 from dual union all
select 191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', to_date('19.12.2007', 'dd.mm.yyyy'), 'SH_CLERK', 2500, null, 122, 50 from dual union all
select 192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', to_date('04.02.2004', 'dd.mm.yyyy'), 'SH_CLERK', 4000, null, 123, 50 from dual union all
select 193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', to_date('03.03.2005', 'dd.mm.yyyy'), 'SH_CLERK', 3900, null, 123, 50 from dual union all
select 194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', to_date('01.07.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3200, null, 123, 50 from dual union all
select 195, 'Vance', 'Jones', 'VJONES', '650.501.4876', to_date('17.03.2007', 'dd.mm.yyyy'), 'SH_CLERK', 2800, null, 123, 50 from dual union all
select 196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', to_date('24.04.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3100, null, 124, 50 from dual union all
select 197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', to_date('23.05.2006', 'dd.mm.yyyy'), 'SH_CLERK', 3000, null, 124, 50 from dual union all
select 198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', to_date('21.06.2007', 'dd.mm.yyyy'), 'SH_CLERK', 2600, null, 124, 50 from dual union all
select 199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', to_date('13.01.2008', 'dd.mm.yyyy'), 'SH_CLERK', 2600, null, 124, 50 from dual union all
select 200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', to_date('17.09.2003', 'dd.mm.yyyy'), 'AD_ASST', 4400, null, 101, 10 from dual union all
select 201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', to_date('17.02.2004', 'dd.mm.yyyy'), 'MK_MAN', 13000, null, 100, 20 from dual union all
select 202, 'Pat', 'Fay', 'PFAY', '603.123.6666', to_date('17.08.2005', 'dd.mm.yyyy'), 'MK_REP', 6000, null, 201, 20 from dual union all
select 203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', to_date('07.06.2002', 'dd.mm.yyyy'), 'HR_REP', 6500, null, 101, 40 from dual union all
select 204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', to_date('07.06.2002', 'dd.mm.yyyy'), 'PR_REP', 10000, null, 101, 70 from dual union all
select 205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', to_date('07.06.2002', 'dd.mm.yyyy'), 'AC_MGR', 12008, null, 101, 110 from dual union all
select 206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', to_date('07.06.2002', 'dd.mm.yyyy'), 'AC_ACCOUNT', 8300, null, 205, 110 from dual;

update hr_employees t
   set emp_is_manager = case when substr(emp_job_id, 4) in ('PRES', 'VP', 'MGR', 'MAN') then 'Y' else 'N' end;

commit;

prompt &s1.Enable integrity constraint to hr_departments

alter table hr_departments enable constraint dep_mgr_id_fk;
