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
            from all_objects
           where object_name in (
                 '', -- Typen
                 'SADC_UI', '', -- Packages
                 'SADC_LOV_DEPARTMENT', 'SADC_LOV_JOB', 'SADC_UI_ADACT', 'SADC_UI_ADPTI', 
                 'SADC_UI_ADSTA', 'SADC_UI_EDEMP', 'SADC_UI_HOME', -- Views
                 'JOB_HISTORY', 'EMPLOYEES', 'JOBS', 'DEPARTMENTS', 'LOCATIONS', 'REGIONS', 'COUNTRIES',   -- Tabellen
                 '',  -- Synonyme
                 'LOCATIONS_SEQ', 'DEPARTMENTS_SEQ', 'EMPLOYEES_SEQ' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
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


prompt &h3.Removing ADC groups
declare
  cursor adc_cur is
    select cgr_id
      from adc_rule_groups
     where cgr_app_id = &APP_ID.;
begin
  for r in adc_cur loop
    adc_admin.delete_rule_group(r.cgr_id);
  end loop;
end;
/

prompt &h3.Checking whether app exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := '&APEX_ALIAS.';  
begin
  select application_id, workspace_id
    into l_app_id, l_ws
    from apex_applications
   where alias = c_app_alias
     and owner = '&INSTALL_USER.';
   
  dbms_output.put_line('&s1.Remove application ' || c_app_alias);
  wwv_flow_api.set_security_group_id(l_ws);
  wwv_flow_api.remove_flow(l_app_id);
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /