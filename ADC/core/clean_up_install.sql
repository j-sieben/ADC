set serveroutput on

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
                 'ADC_ADMIN', 'ADC_INTERNAL', 'ADC_UTIL', 'ADC_VALIDATION', 'ADC', 'ADC_API', 'ADC_APEX_ACTION', -- Packages
                 'ADC_RULE_GROUP_STATUS', 'ADC_BL_PAGE_ITEMS', 'ADC_BL_PAGE_TARGETS', 'ADC_BL_RULES', 'ADC_BL_CAT_HELP', 
                 'ADC_ACTION_ITEM_FOCUS_V', 'ADC_ACTION_PARAM_TYPES_V', 'ADC_ACTION_PARAMETERS_V', 'ADC_ACTION_TYPE_GROUPS_V', 
                 'ADC_APEX_ACTION_TYPES_V', 'ADC_APEX_ACTIONS_V', 'ADC_PAGE_ITEM_TYPES_V', 
                 'ADC_PARAM_LOV_APEX_ACTION', 'ADC_PARAM_LOV_PAGE_ITEM', 'ADC_PARAM_LOV_PIT_MESSAGE', 'ADC_PARAM_LOV_SEQUENCE', -- Views
                 'ADC_ACTION_ITEM_FOCUS', 'ADC_ACTION_PARAMETERS', 'ADC_ACTION_PARAM_TYPES', 'ADC_ACTION_TYPES', 
                 'ADC_ACTION_TYPE_GROUPS', 'ADC_APEX_ACTIONS', 'ADC_APEX_ACTION_ITEMS', 'ADC_APEX_ACTION_TYPES', 'ADC_PAGE_ITEMS', 
                 'ADC_PAGE_ITEM_TYPES', 'ADC_RULES', 'ADC_RULE_ACTIONS', 'ADC_RULE_GROUPS',   -- Tabellen
                 '',  -- Synonyme
                 'ADC_SEQ' -- Sequenzen
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
  
  pit_admin.delete_message_group('ADC', true);
  param_admin.delete_parameter_group('ADC', true);  
  utl_text.remove_templates('ADC');
  
end;
/
