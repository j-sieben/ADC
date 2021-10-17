drop table adc_ui_map_designer_actions;

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