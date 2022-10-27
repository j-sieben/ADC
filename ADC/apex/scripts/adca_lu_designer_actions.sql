merge into adca_lu_designer_actions t
using (select 'cancel-action'	alda_id, 'cancel-action' alda_name,	adc_util.C_TRUE alda_active 
         from dual
       union all
       select 'create-action', 'create-action',	adc_util.C_TRUE from dual union all
       select 'delete-action', 'delete-action',	adc_util.C_TRUE from dual union all
       select 'show', 'show',	adc_util.C_TRUE from dual union all
       select 'update-action', 'update-action',	adc_util.C_TRUE from dual) s
   on (t.alda_id = s.alda_id)
 when matched then update set
      t.alda_name = s.alda_name,
      t.alda_active = s.alda_active
 when not matched then insert(alda_id, alda_name, alda_active)
      values(s.alda_id, s.alda_name, s.alda_active);
      
      
commit;
