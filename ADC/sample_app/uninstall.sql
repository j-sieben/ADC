
prompt &h3.Removing sample database objects
declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from user_objects
           where (object_name in (
                 '', -- Typen
                 '', '', -- Packages
                 'SADC_LOV_DEPARTMENT', 'SADC_LOV_JOB', 'SADCA_UI_ADACT', 'SADCA_UI_ADPTI', 'EMP_DETAILS_VW', 
                 'SADCA_UI_ADSTA', 'SADCA_UI_EDEMP', 'SADCA_UI_HOME', 'SADCA_UI_ADREP', 'SADCA_UI_DOC', 'SADCA_UI_MENU_CAT', 'SADCA_UI_TUTORIAL', 
                 'EMP_DETAILS_VIEW', -- Views
                 '', 'HR_EMPLOYEES', 'HR_JOBS', 'HR_DEPARTMENTS', 'HR_LOCATIONS', 'HR_REGIONS', 'HR_COUNTRIES',   -- Tabellen
                 '',  -- Synonyme
                 'HR_LOCATIONS_SEQ', 'HR_DEPARTMENTS_SEQ', 'HR_EMPLOYEES_SEQ' -- Sequenzen
                 )
              or object_name like 'SADC_UI%')
             and object_type not like '%BODY'
           order by object_type, object_name;
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints purge' 
                        end;
     dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        dbms_output.put_line('&s1.' || obj.type || ' ' || obj.name || ' does not exist.');
      when others then
        raise;
    end;
  end loop;
  
end;
/

whenever sqlerror continue
prompt &h3.Removing ADC groups *** IGNORE POSSIBLE EXCEPTIONS FROM HERE
declare
  cursor adc_cur is
    select crg_id
      from adc_rule_groups
     where crg_app_id = (
           select application_id
             from apex_applications
            where alias = 'SADC');
begin
  for r in adc_cur loop
    adc_admin.delete_rule_group(r.crg_id);
  end loop;
exception
  when others then
    dbms_output.put_line('Error when removing SADC groups: ' || sqlerrm);
end;
/

prompt &h3.Checking whether app exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := 'SADC';  
begin
  select application_id, workspace_id
    into l_app_id, l_ws
    from apex_applications
   where alias = c_app_alias;
 
  dbms_output.put_line('&s1.Remove application ' || c_app_alias);
  wwv_flow_api.set_security_group_id(l_ws);
  wwv_flow_api.remove_flow(l_app_id);
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /
whenever sqlerror exit
prompt *** IGNORE POSSIBLE EXCEPTIONS UNTIL HERE