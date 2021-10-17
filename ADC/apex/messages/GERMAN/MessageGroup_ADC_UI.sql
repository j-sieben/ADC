begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADC_UI',
    p_pmg_description => q'^Meldungen für die ADC Plugin Administrationsanwendung^');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_UNSAVED_DATA',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^Es existieren ungesicherte Eingaben auf der Anwendungsseite. Bitte bestätigen Sie, dass diese verworfen werden sollen.^',
    p_pms_description => q'^Wird ausgelöst, falls ungesicherte Änderungen auf der Anwendungsseite verloren gehen könnten.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_CONFIRM_DELETE',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^Bitte bestätigen Sie, dass die Daten gelöscht werden sollen.^',
    p_pms_description => q'^Wird ausgelöst, wenn eine Löschoperation ausgelöst wird, um umgewolltes Löschen zu vermeiden.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_ACTION_REQUESTED',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^#1#-Aktion für #2# angefordert.^',
    p_pms_description => q'^Information über die Aktion die durch die Logik ermittelt wurde.^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_UNKNOWN_ACTION',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^Unbekannte Aktion #1# angefordert.^',
    p_pms_description => q'^Programmierfehler.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_CHANGES_SAVED',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^Änderungen gespeichert.^',
    p_pms_description => q'^Erfolgsmeldung, falls eine Datenänderung erfolgreich gespeichert werden konnte.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_UI_DATA_DELETED',
    p_pms_pmg_name => 'ADC_UI',
    p_pms_text => q'^Daten wurden gelöscht.^',
    p_pms_description => q'^Erfolgsmeldung, falls Daten erfolgreich gelöscht werden konnten.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  commit;
  pit_admin.create_message_package;
end;
/