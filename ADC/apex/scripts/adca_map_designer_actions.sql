merge into adca_map_designer_actions t
using (select 'CRU' amda_aldm_id, 'show' amda_alda_id, 'Rule selected from hierarchy' amda_comment, 'CRU_ID' amda_id_value, adc_util.C_TRUE amda_remember_page_state, 
               adc_util.C_TRUE amda_create_button_visible, 'CRA' amda_create_target_mode, adc_util.C_TRUE amda_update_button_visible,  
               adc_util.C_TRUE amda_delete_button_visible, 'CRU' amda_delete_mode, 'CRG' amda_delete_target_mode,
               adc_util.C_TRUE amda_cancel_button_active, 'CRG' amda_cancel_target_mode
          from dual
        union all
        select 'CRU', 'create-action', 'Rule created from CRG', null, adc_util.C_TRUE, adc_util.C_FALSE, null,  adc_util.C_TRUE, adc_util.C_FALSE, null, null, adc_util.C_TRUE, 'CRG' from dual union all
        select 'CRU', 'update-action', 'Rule saved', 'CRU_ID', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', adc_util.C_TRUE, adc_util.C_TRUE, 'CRU', 'CRG', adc_util.C_TRUE, 'CRG' from dual union all
        select 'CRU', 'delete-action', 'Rule Action deleted', 'CRU_ID', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', adc_util.C_TRUE, adc_util.C_TRUE, 'CRU', 'CRG', adc_util.C_TRUE, 'CRG' from dual union all
        select 'CRU', 'cancel-action', 'Rule Action edit cancelled', 'CRU_ID', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', adc_util.C_TRUE, adc_util.C_TRUE, 'CRU', 'CRG', adc_util.C_TRUE, 'CRG' from dual
        union all
        select 'CRG', 'show', 'Rule group selected from hierarchy', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CRU', adc_util.C_FALSE, adc_util.C_FALSE, null, 'CRG', adc_util.C_FALSE, null from dual union all
        select 'CRG', 'delete-action', 'Rule deleted', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CRU', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual union all
        select 'CRG', 'cancel-action', 'Rule edit cancelled', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CRU', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual
        union all
        select 'CRA', 'show', 'Rule Action selected from hierarchy', 'CRA_ID', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', 'CRU', adc_util.C_TRUE, 'CRU' from dual union all
        select 'CRA', 'create-action', 'Rule Action created from CRU', null, adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_FALSE, null, null, adc_util.C_TRUE, 'CRU' from dual union all
        select 'CRA', 'update-action', 'Rule Action saved', 'CRA_ID', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', adc_util.C_TRUE, adc_util.C_TRUE, 'CRA', 'CRU', adc_util.C_TRUE, 'CRU' from dual
        union all
        select 'CAG', 'show', 'Page commands headline selected from hierarchy', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CAA', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual union all
        select 'CAG', 'delete-action', 'Page Command deleted', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CAA', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual union all
        select 'CAG', 'cancel-action', 'Page Command edit cancelled', 'CRG_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'CAA', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual
        union all
        select 'CAA', 'show', 'Page Command selected from hierarchy', 'CAA_ID', adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_TRUE, 'CAA', 'CAG', adc_util.C_TRUE, 'CAG' from dual union all
        select 'CAA', 'create-action', 'Page Command created from CAG', null, adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_TRUE, 'CAA', 'CAG', adc_util.C_TRUE, 'CAG' from dual union all
        select 'CAA', 'update-action', 'Page Command saved', 'CAA_ID', adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_TRUE, 'CAA', 'CAG', adc_util.C_TRUE, 'CAG' from dual
        union all
        select 'FLG', 'show', 'Flows headline selected from hierarchy', 'DIAGRAM_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'FLS', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual union all
        select 'FLG', 'delete-action', 'Flow deleted', 'DIAGRAM_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'FLS', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual union all
        select 'FLG', 'cancel-action', 'Flow edit cancelled', 'DIAGRAM_ID', adc_util.C_FALSE, adc_util.C_TRUE, 'FLS', adc_util.C_FALSE, adc_util.C_FALSE, null, null, adc_util.C_FALSE, null from dual
        union all
        select 'FLS', 'show', 'Flow selected from hierarchy', 'DIAGRAM_ID', adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_TRUE, 'FLS', 'FLG', adc_util.C_TRUE, 'FLG' from dual union all
        select 'FLS', 'create-action', 'Flow created from FLG', null, adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_FALSE, adc_util.C_TRUE, 'FLS', 'FLG', adc_util.C_TRUE, 'FLG' from dual union all
        select 'FLS', 'update-action', 'Flow saved', 'DIAGRAM_ID', adc_util.C_TRUE, adc_util.C_FALSE, null, adc_util.C_TRUE, adc_util.C_TRUE, 'FLS', 'FLG', adc_util.C_TRUE, 'FLG' from dual) s
   on (t.amda_aldm_id = s.amda_aldm_id
   and t.amda_alda_id = s.amda_alda_id)
 when matched then update set
      t.amda_comment = s.amda_comment,
      t.amda_id_value = s.amda_id_value,
      t.amda_remember_page_state = s.amda_remember_page_state,
      t.amda_create_button_visible = s.amda_create_button_visible,
      t.amda_create_target_mode = s.amda_create_target_mode,
      t.amda_update_button_visible = s.amda_update_button_visible,
      t.amda_delete_button_visible = s.amda_delete_button_visible,
      t.amda_delete_mode = s.amda_delete_mode,
      t.amda_delete_target_mode = s.amda_delete_target_mode,
      t.amda_cancel_button_active = s.amda_cancel_button_active,
      t.amda_cancel_target_mode = s.amda_cancel_target_mode
 when not matched then insert(
        amda_aldm_id, amda_alda_id, amda_comment, amda_id_value, amda_remember_page_state, 
        amda_create_button_visible, amda_create_target_mode,
        amda_update_button_visible, amda_delete_button_visible, amda_delete_mode, amda_delete_target_mode,
        amda_cancel_button_active, amda_cancel_target_mode)
      values(
        s.amda_aldm_id, s.amda_alda_id, s.amda_comment, s.amda_id_value, s.amda_remember_page_state, 
        s.amda_create_button_visible, s.amda_create_target_mode,
        s.amda_update_button_visible, s.amda_delete_button_visible, s.amda_delete_mode, s.amda_delete_target_mode,
        s.amda_cancel_button_active, s.amda_cancel_target_mode);

commit;
