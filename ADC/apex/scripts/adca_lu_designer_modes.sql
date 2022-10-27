merge into adca_lu_designer_modes t
using (select 'CAA'	aldm_id, 'CAA' aldm_name,	adc_util.C_TRUE aldm_active 
         from dual
       union all
       select 'CAG', 'CAG',	adc_util.C_TRUE from dual union all
       select 'CGR', 'CGR',	adc_util.C_TRUE from dual union all
       select 'CRA', 'CRA',	adc_util.C_TRUE from dual union all
       select 'CRU', 'CRU',	adc_util.C_TRUE from dual union all
       select 'FLG', 'FLG',	adc_util.C_TRUE from dual union all
       select 'FLS', 'FLS',	adc_util.C_TRUE from dual) s
   on (t.aldm_id = s.aldm_id)
 when matched then update set
      t.aldm_name = s.aldm_name,
      t.aldm_active = s.aldm_active
 when not matched then insert(aldm_id, aldm_name, aldm_active)
      values(s.aldm_id, s.aldm_name, s.aldm_active);
      
      
commit;