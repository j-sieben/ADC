merge into adc_lu_designer_actions t
using (select 'cancel-action'	ald_id, 'cancel-action' ald_name,	adc_util.C_TRUE ald_active 
         from dual
       union all
       select 'create-action', 'Ccreate-actionAG',	adc_util.C_TRUE from dual union all
       select 'delete-action', 'delete-action',	adc_util.C_TRUE from dual union all
       select 'show', 'show',	adc_util.C_TRUE from dual union all
       select 'update-action', 'update-action',	adc_util.C_TRUE from dual) s
   on (t.ald_id = s.ald_id)
 when matched then update set
      t.ald_name = s.ald_name,
      t.ald_active = s.ald_active
 when not matched then insert(ald_id, ald_name, ald_active)
      values(s.ald_id, s.ald_name, s.ald_active);
      
      
commit;
