
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
                 'UT_ADC_JS_REC', 'UT_ADC_JS_LIST', 'UT_ADC_RESULT', 'UT_ADC_LIST', 'UT_ADC_ROW', -- Typen
                 'UT_ADC_ADMIN',  'UT_ADC_INTERNAL',  'UT_ADC_PAGE_STATE',  'UT_ADC_RECURSION_STAXCK',  'UT_ADC_UTIL',  'UT_ADC',  -- Packages
                 '', -- Views
                 'UT_ADC_OUTCOME',  -- Tabellen
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
  
  commit;
end;
/