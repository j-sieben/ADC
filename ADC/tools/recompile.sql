
prompt &h1.Recompiling invalid objects
declare
  cursor obj_cur is
    select object_type, object_name,
           case when instr(object_type, 'BODY') = 0 then 1 else 2 end recompile_order
      from user_objects
     where status = 'INVALID'
       and object_name like 'ADC%'
     order by recompile_order;
  l_invalid_objects binary_integer;
begin
  for o in obj_cur loop
    if o.recompile_order = 1 then
      execute immediate 'alter ' || o.object_type || ' compile';
    else
      execute immediate 'alter ' || o.object_type || ' compile body';
    end if;
  end loop;
    
  select count(*)
    into l_invalid_objects
    from user_objects
   where status = 'INVALID';
   
  dbms_output.put_line(l_invalid_objects || ' invalid objects found');
end;
/