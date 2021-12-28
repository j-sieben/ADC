create table adc_ui_map_designer_actions(
  mda_alm_id varchar2(3 byte), 
	mda_ald_id varchar2(128 byte),
  mda_comment varchar2(200 byte),
	mda_id_value varchar2(128 byte), 
	mda_remember_page_state char(1 byte) constraint mda_remember_page_state_chk check (mda_remember_page_state in ('Y', 'N')), 
	mda_create_button_visible char(1 byte) constraint mda_create_button_visible_chk check (mda_create_button_visible in ('Y', 'N')), 
	mda_create_target_mode varchar2(3 byte), 
	mda_update_button_visible char(1 byte) constraint mda_update_button_visible_chk check (mda_update_button_visible in ('Y', 'N')),
	mda_delete_button_visible char(1 byte) constraint mda_delete_button_visible_chk check (mda_delete_button_visible in ('Y', 'N')),
	mda_delete_mode varchar2(3 byte), 
	mda_delete_target_mode varchar2(3 byte), 
	mda_cancel_button_active char(1 byte) constraint mda_cancel_button_active_chk check (mda_cancel_button_active in ('Y', 'N')), 
	mda_cancel_target_mode varchar2(3 byte), 
  constraint adc_ui_map_designer_actions_pk primary key (mda_alm_id, mda_ald_id),
  constraint mda_alm_id_fk foreign key (mda_alm_id)
	  references adc_lu_designer_modes (alm_id),
  constraint mda_ald_id_fk foreign key (mda_ald_id)
	  references adc_lu_designer_actions (ald_id),
  constraint mda_create_target_mode_fk foreign key (mda_create_target_mode)
	  references adc_lu_designer_modes (alm_id),
  constraint mda_delete_mode_fk foreign key (mda_delete_mode)
	  references adc_lu_designer_modes (alm_id),
  constraint mda_delete_target_mode_fk foreign key (mda_delete_target_mode)
	  references adc_lu_designer_modes (alm_id),
  constraint mda_cancel_target_mode_fk foreign key (mda_cancel_target_mode)
	  references adc_lu_designer_modes (alm_id)
) organization index;

comment on table adc_ui_map_designer_actions is 'Decision table for the page state of the ADC designer in response to a combination of Mode and APEX action raised by the user';
comment on column adc_ui_map_designer_actions.mda_alm_id is 'Reference to ADC_LU_DESIGNER_MODES, part of PK';
comment on column adc_ui_map_designer_actions.mda_ald_id is 'Reference to ADC_LU_DESIGNER_ACTIONSS, part of PK';
comment on column adc_ui_map_designer_actions.mda_comment is 'Optional comment for the mapping';
comment on column adc_ui_map_designer_actions.mda_id_value is 'Target mode for create operations';
comment on column adc_ui_map_designer_actions.mda_remember_page_state is 'Flag to indicate whether switching to this mode requires the actual page state to be saved';
comment on column adc_ui_map_designer_actions.mda_create_button_visible is 'Flag to indicate whether CREATE action is visible';
comment on column adc_ui_map_designer_actions.mda_create_target_mode is 'Mode the designer switches to after performing a CREATE';
comment on column adc_ui_map_designer_actions.mda_update_button_visible is 'Flag to indicate whether UPDATE action is visible';
comment on column adc_ui_map_designer_actions.mda_delete_button_visible is 'Flag to indicate whether DELETE action is visible';
comment on column adc_ui_map_designer_actions.mda_delete_mode is 'Mode the designer uses when performing a DELETE';
comment on column adc_ui_map_designer_actions.mda_delete_target_mode is 'Mode the designer switches to after performing a DELETE';
comment on column adc_ui_map_designer_actions.mda_cancel_button_active is 'Flag to indicate whether CANCEL action is visible';
comment on column adc_ui_map_designer_actions.mda_cancel_target_mode is 'Mode the designer switches to after performing a CANCEL';