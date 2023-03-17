@&tool_dir.check_has_column ADC_ACTION_TYPES CAT_CATO_ID "VARCHAR2(50 CHAR)"

begin
  merge into adc_action_type_owners t
  using (select 'ADC' cato_id, 'Predefined action types, delivered with ADC' cato_description
           from dual) s
     on (t.cato_id = s.cato_id)
   when not matched then insert(cato_id, cato_description)
        values (s.cato_id, s.cato_description);
  commit;
  execute immediate 'alter table adc_action_types modify (cat_cato_id default on null ''ADC'' constraint c_cat_cato_id_nn not null)';
  execute immediate 'alter table adc_action_types add constraint r_cat_cato_id foreign key(cat_cato_id) references adc_action_type_owners(cato_id)';
  execute immediate 'create index idx_fk_cat_cato_id on adc_action_types(cat_cato_id)';
exception
  when others then
    raise;
end;
/