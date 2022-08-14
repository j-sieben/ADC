merge into adc_map_designer_actions t
using (select 'CRU' mda_alm_id, 'show' mda_ald_id, 'Rule selected from hierarchy' mda_comment, 'CRU_ID' mda_id_value, 'Y' mda_remember_page_state, 
               'Y' mda_create_button_visible, 'CRA' mda_create_target_mode, 'Y' mda_update_button_visible,  
               'Y' mda_delete_button_visible, 'CRU' mda_delete_mode, 'CGR' mda_delete_target_mode,
               'Y' mda_cancel_button_active, 'CGR' mda_cancel_target_mode
          from dual
        union all
        select 'CRU', 'create-action', 'Rule created from CGR', null, 'Y', 'N', null,  'Y', 'N', null, null, 'Y', 'CGR' from dual union all
        select 'CRU', 'update-action', 'Rule saved', 'CRU_ID', 'Y', 'Y', 'CRA', 'Y', 'Y', 'CRU', 'CGR', 'Y', 'CGR' from dual union all
        select 'CRU', 'delete-action', 'Rule Action deleted', 'CRU_ID', 'Y', 'Y', 'CRA', 'Y', 'Y', 'CRU', 'CGR', 'Y', 'CGR' from dual union all
        select 'CRU', 'cancel-action', 'Rule Action edit cancelled', 'CRU_ID', 'Y', 'Y', 'CRA', 'Y', 'Y', 'CRU', 'CGR', 'Y', 'CGR' from dual
        union all
        select 'CGR', 'show', 'Rule group selected from hierarchy', 'CGR_ID', 'N', 'Y', 'CRU', 'N', 'N', null, null, 'N', null from dual union all
        select 'CGR', 'delete-action', 'Rule deleted', 'CGR_ID', 'N', 'Y', 'CRU', 'N', 'N', null, null, 'N', null from dual union all
        select 'CGR', 'cancel-action', 'Rule edit cancelled', 'CGR_ID', 'N', 'Y', 'CRU', 'N', 'N', null, null, 'N', null from dual
        union all
        select 'CRA', 'show', 'Rule Action selected from hierarchy', 'CRA_ID', 'Y', 'Y', 'CRA', 'Y', 'Y', 'CRA', 'CRU', 'Y', 'CRU' from dual union all
        select 'CRA', 'create-action', 'Rule Action created from CRU', null, 'Y', 'N', null, 'Y', 'N', null, null, 'Y', 'CRU' from dual union all
        select 'CRA', 'update-action', 'Rule Action saved', 'CRA_ID', 'Y', 'Y', 'CRA', 'Y', 'Y', 'CRA', 'CRU', 'Y', 'CRU' from dual
        union all
        select 'CAG', 'show', 'Page commands headline selected from hierarchy', 'CGR_ID', 'N', 'Y', 'CAA', 'N', 'N', null, null, 'N', null from dual union all
        select 'CAG', 'delete-action', 'Page Command deleted', 'CGR_ID', 'N', 'Y', 'CAA', 'N', 'N', null, null, 'N', null from dual union all
        select 'CAG', 'cancel-action', 'Page Command edit cancelled', 'CGR_ID', 'N', 'Y', 'CAA', 'N', 'N', null, null, 'N', null from dual
        union all
        select 'CAA', 'show', 'Page Command selected from hierarchy', 'CAA_ID', 'Y', 'N', null, 'Y', 'Y', 'CAA', 'CAG', 'Y', 'CAG' from dual union all
        select 'CAA', 'create-action', 'Page Command created from CAG', null, 'Y', 'N', null, 'N', 'Y', 'CAA', 'CAG', 'Y', 'CAG' from dual union all
        select 'CAA', 'update-action', 'Page Command saved', 'CAA_ID', 'Y', 'N', null, 'Y', 'Y', 'CAA', 'CAG', 'Y', 'CAG' from dual
        union all
        select 'FLG', 'show', 'Flows headline selected from hierarchy', 'DIAGRAM_ID', 'N', 'Y', 'FLS', 'N', 'N', null, null, 'N', null from dual union all
        select 'FLG', 'delete-action', 'Flow deleted', 'DIAGRAM_ID', 'N', 'Y', 'FLS', 'N', 'N', null, null, 'N', null from dual union all
        select 'FLG', 'cancel-action', 'Flow edit cancelled', 'DIAGRAM_ID', 'N', 'Y', 'FLS', 'N', 'N', null, null, 'N', null from dual
        union all
        select 'FLS', 'show', 'Flow selected from hierarchy', 'DIAGRAM_ID', 'Y', 'N', null, 'Y', 'Y', 'FLS', 'FLG', 'Y', 'FLG' from dual union all
        select 'FLS', 'create-action', 'Flow created from FLG', null, 'Y', 'N', null, 'N', 'Y', 'FLS', 'FLG', 'Y', 'FLG' from dual union all
        select 'FLS', 'update-action', 'Flow saved', 'DIAGRAM_ID', 'Y', 'N', null, 'Y', 'Y', 'FLS', 'FLG', 'Y', 'FLG' from dual) s
   on (t.mda_alm_id = s.mda_alm_id
   and t.mda_ald_id = s.mda_ald_id)
 when matched then update set
      t.mda_comment = s.mda_comment,
      t.mda_id_value = s.mda_id_value,
      t.mda_remember_page_state = s.mda_remember_page_state,
      t.mda_create_button_visible = s.mda_create_button_visible,
      t.mda_create_target_mode = s.mda_create_target_mode,
      t.mda_update_button_visible = s.mda_update_button_visible,
      t.mda_delete_button_visible = s.mda_delete_button_visible,
      t.mda_delete_mode = s.mda_delete_mode,
      t.mda_delete_target_mode = s.mda_delete_target_mode,
      t.mda_cancel_button_active = s.mda_cancel_button_active,
      t.mda_cancel_target_mode = s.mda_cancel_target_mode
 when not matched then insert(
        mda_alm_id, mda_ald_id, mda_comment, mda_id_value, mda_remember_page_state, 
        mda_create_button_visible, mda_create_target_mode,
        mda_update_button_visible, mda_delete_button_visible, mda_delete_mode, mda_delete_target_mode,
        mda_cancel_button_active, mda_cancel_target_mode)
      values(
        s.mda_alm_id, s.mda_ald_id, s.mda_comment, s.mda_id_value, s.mda_remember_page_state, 
        s.mda_create_button_visible, s.mda_create_target_mode,
        s.mda_update_button_visible, s.mda_delete_button_visible, s.mda_delete_mode, s.mda_delete_target_mode,
        s.mda_cancel_button_active, s.mda_cancel_target_mode);

commit;
