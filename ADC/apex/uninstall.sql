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
                 'ADCA_UI', 'ADC_UI_DESIGNER', 'SPLITTER_PLUGIN', -- Packages
                 'ADCA_BL_CAT_HELP', 'ADCA_BL_CAT_PARAMETER_ITEMS', 'ADCA_BL_DESIGNER_ACTIONS', 
                 'ADCA_UI_ADMIN_CAIF', 'ADCA_UI_ADMIN_CAPT', 'ADCA_UI_ADMIN_CAT', 'ADCA_UI_DESIGNER_APEX_ACTION', 
                 'ADCA_UI_DESIGNER_FINDINGS', 'ADCA_UI_DESIGNER_RULE', 'ADCA_UI_DESIGNER_RULES', 
                 'ADCA_UI_DESIGNER_RULE_ACTION', 'ADCA_UI_DESIGNER_RULE_GROUP', 'ADCA_UI_DESIGNER_TREE', 
                 'ADCA_UI_EDIT_CAIF', 'ADCA_UI_EDIT_CAPT', 'ADCA_UI_EDIT_CAPT_STATIC_LIST', 'ADCA_UI_EDIT_CAT', 
                 'ADCA_UI_EDIT_CATG', 'ADCA_UI_EDIT_CPIT', 'ADCA_UI_LIST_ACTION_TYPE', 'ADCA_UI_LOV_ACTION_ITEM_FOCUS', 
                 'ADCA_UI_LOV_ACTION_PARAM_TYPE', 'ADCA_UI_LOV_ACTION_PARAM_VISUAL_TYPE', 'ADCA_UI_LOV_ACTION_TYPE_GROUP', 
                 'ADCA_UI_LOV_APEX_ACTION_ITEMS', 'ADCA_UI_LOV_APEX_ACTION_TYPE', 'ADCA_UI_LOV_APPLICATIONS', 
                 'ADCA_UI_LOV_APP_PAGES', 'ADCA_UI_LOV_CRG_APPLICATIONS', 'ADCA_UI_LOV_CRG_APP_PAGES', 
                 'ADCA_UI_LOV_CRG_PAGE_ITEMS', 'ADCA_UI_LOV_EXPORT_CAT', 'ADCA_UI_LOV_EXPORT_TYPES', 
                 'ADCA_UI_LOV_ITEM_TYPES', 'ADCA_UI_LOV_PAGE_ITEMS', 'ADCA_UI_LOV_PAGE_ITEMS_P11', 
                 'ADCA_UI_LOV_PAGE_ITEM_TYPE', 'ADCA_UI_LOV_PAGE_ITEM_TYPE_GROUP', 'ADCA_UI_LOV_YES_NO', -- Views
                 'ADCA_LU_DESIGNER_ACTIONS', 'ADCA_LU_DESIGNER_MODES', 'ADCA_MAP_DESIGNER_ACTIONS',   -- Tabellen
                 '',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and object_type != 'INDEX'
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
        dbms_output.put_line('&s1.Error at ' || obj.type || ' ' || obj.name || ': ' || sqlerrm);
        raise;
    end;
  end loop;
  
end;
/

prompt &h3.Removing ADC_UI translatable items
begin
  pit_admin.delete_message_group('ADCA', true);
  commit;
end;
/


prompt &h3.Removing ADC groups
declare
  c_stmt varchar2(1000 byte) := 'select crg_id from adc_rule_groups where crg_app_id = &APP_ID.';
  l_cur sys_refcursor;
  l_crg_id binary_integer;
begin
  if &APP_ID. is not null then
    open l_cur for c_stmt;
    fetch l_cur into l_crg_id;
    while l_cur%found loop
      adc_admin.delete_rule_group(l_crg_id);
      fetch l_cur into l_crg_id;
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