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
           where object_name in (
                 '', -- Typen
                 'ADC_UI', 'SPLITTER_PLUGIN', -- Packages
                 'ADC_UI_ADMIN_CAT', 'ADC_UI_ADMIN_CGR_MAIN', 'ADC_UI_ADMIN_CGR_COMMANDS', 'ADC_UI_ADMIN_CGR_OVERVIEW', 'ADC_UI_ADMIN_CIF', 'ADC_UI_ADMIN_CGR_RULES', 
                 'ADC_UI_EDIT_RULE', 'ADC_UI_EDIT_RULE_ACTION', 'ADC_UI_EDIT_CAA', 'ADC_UI_EDIT_CAT', 'ADC_UI_EDIT_CIF', 'ADC_UI_EDIT_CGR',  'ADC_UI_EDIT_CTG', 'ADC_UI_EDIT_CPT', 
                 'ADC_UI_EDIT_CGR_APEX_ACTION', 'ADC_UI_EDIT_CRA', 'ADC_UI_EDIT_CRU', 'ADC_UI_EDIT_CRU_ACTION', 'ADC_UI_EDIT_CPT_STATIC_LIST', 
                 'ADC_UI_LIST_ACTION_TYPE', 'ADC_UI_LIST_PAGE_ITEMS', 'ADC_UI_LOV_ACTION_ITEM_FOCUS', 
                 'ADC_UI_LOV_ACTION_PARAM_TYPE', 'ADC_UI_LOV_ACTION_TYPE_GROUP', 'ADC_UI_LOV_APEX_ACTION_ITEMS', 
                 'ADC_UI_LOV_APEX_ACTION_TYPE', 'ADC_UI_LOV_APPLICATIONS', 'ADC_UI_LOV_APP_PAGES', 'ADC_UI_LOV_EXPORT_TYPES', 'ADC_UI_LOV_EXPORT_CAT', 
                 'ADC_UI_LOV_PAGE_ITEMS', 'ADC_UI_LOV_PAGE_ITEMS_P11', 'ADC_UI_LOV_CGR_APPLICATIONS', 'ADC_UI_LOV_PAGE_ITEM_TYPE',
                 'ADC_UI_LOV_CGR_APP_PAGES', 'ADC_UI_LOV_CGR_PAGE_ITEMS', 'ADC_UI_LOV_YES_NO', -- Views
                 'ADC_LU_DESIGNER_ACTIONS', 'ADC_LU_DESIGNER_MODES', 'ADC_UI_MAP_DESIGNER_ACTIONS',   -- Tabellen
                 '',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
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

prompt &h3.Removing ADC_UI translatable items
begin
  pit_admin.delete_message_group('ADC_UI', true);
  commit;
end;
/


prompt &h3.Removing ADC groups
declare
  c_stmt varchar2(100o byte) := 'select cgr_id from adc_rule_groups where cgr_app_id = &APP_ID.';
  l_cur sys_refcursor;
  l_cgr_id binary_integer;
begin
  if &APP_ID. is not null then
    open l_cur for c_stmt;
    fetch l_cur into l_cgr_id;
    while l_cur%found loop
      adc_admin.delete_rule_group(l_cgr_id);
      fetch l_cur into l_cgr_id;
    end loop;
  end if;
exception
  when others then
    -- ignore, if ADC_RULE_GROUPS does not exist yet
    if l_cur%isopen then
      close l_cur;
    end if;
    dbms_output.put_line('&s1.ADC does not exist, ignored.');
end;
/

prompt &h3.Checking whether app exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := 'ADC';  
begin
  if c_app_alias is not null then
    select application_id, workspace_id
      into l_app_id, l_ws
      from apex_applications
     where alias = c_app_alias;
     
    dbms_output.put_line('&s1.Remove application ' || c_app_alias);
    wwv_flow_api.set_security_group_id(l_ws);
    wwv_flow_api.remove_flow(l_app_id);
  end if;
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /