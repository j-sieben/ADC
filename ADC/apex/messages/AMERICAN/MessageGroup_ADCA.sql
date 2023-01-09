begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADCA',
    p_pmg_description => q'^Messages for the ADC plugin administration application^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_UNSAVED_DATA',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^There are unsaved entries on the application page. Please confirm that these should be discarded.^',
    p_pms_description => q'^Triggered if unsaved changes could be lost on the application side.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CONFIRM_DELETE',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Please confirm that the data should be deleted.^',
    p_pms_description => q'^Triggered when a delete operation is initiated to avoid accidental deletion.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_ACTION_REQUESTED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^#1# action requested for #2#.^',
    p_pms_description => q'^Information about the action determined by the logic.^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_UNKNOWN_ACTION',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Unknown action #1# requested.^',
    p_pms_description => q'^Programming error.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CHANGES_SAVED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Changes saved.^',
    p_pms_description => q'^Success message if a data change could be saved successfully.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_DATA_DELETED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Data has been deleted.^',
    p_pms_description => q'^Success message if data could be deleted successfully.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CHK_REGISTER_OBSERVER',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Element #1# does not need to be observed because a technical condition references the element.^',
    p_pms_description => q'^The action can be removed without changing the behavior of the dynamic page.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CHK_DEPRECATED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Action #1# is deprecated and should be replaced with another procedure.^',
    p_pms_description => q'^Please follow the instructions in the help text of the action type.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CHK_MISSING',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^The element #1# does not exist on the page.^',
    p_pms_description => q'^Eventually the element was deleted or renamed. Please check this, otherwise JavaScript errors will appear on the page.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UI_CONFIRM_DELETE',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Please confirm that you want to delete the record.^',
    p_pms_description => q'^Security message before deleting a record.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  commit;
  pit_admin.create_message_package;
end;
/