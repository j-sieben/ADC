merge into adc_lu_designer_modes t
using (select 'CAA'	alm_id, 'CAA' alm_name,	adc_util.C_TRUE alm_active 
         from dual
       union all
       select 'CAG', 'CAG',	adc_util.C_TRUE from dual union all
       select 'CGR', 'CGR',	adc_util.C_TRUE from dual union all
       select 'CRA', 'CRA',	adc_util.C_TRUE from dual union all
       select 'CRU', 'CRU',	adc_util.C_TRUE from dual union all
       select 'FLG', 'FLG',	adc_util.C_TRUE from dual union all
       select 'FLS', 'FLS',	adc_util.C_TRUE from dual) s
   on (t.alm_id = s.alm_id)
 when matched then update set
      t.alm_name = s.alm_name,
      t.alm_active = s.alm_active
 when not matched then insert(alm_id, alm_name, alm_active)
      values(s.alm_id, s.alm_name, s.alm_active);
      
      
commit;