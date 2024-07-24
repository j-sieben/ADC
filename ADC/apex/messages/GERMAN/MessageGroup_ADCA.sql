begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADCA',
    p_pmg_description => q'^Meldungen für die ADC Plugin Administrationsanwendung^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UNSAVED_DATA',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Es existieren ungesicherte Eingaben auf der Anwendungsseite. Bitte bestätigen Sie, dass diese verworfen werden sollen.^',
    p_pms_description => q'^Wird ausgelöst, falls ungesicherte Änderungen auf der Anwendungsseite verloren gehen könnten.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_CONFIRM_DELETE',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Bitte bestätigen Sie, dass die Daten gelöscht werden sollen.^',
    p_pms_description => q'^Wird ausgelöst, wenn eine Löschoperation ausgelöst wird, um umgewolltes Löschen zu vermeiden.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_ACTION_REQUESTED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^#1#-Aktion für #2# angefordert.^',
    p_pms_description => q'^Information über die Aktion die durch die Logik ermittelt wurde.^',
    p_pms_pse_id => pit.level_info,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_UNKNOWN_ACTION',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Unbekannte Aktion #1# angefordert.^',
    p_pms_description => q'^Programmierfehler.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_CHANGES_SAVED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Änderungen gespeichert.^',
    p_pms_description => q'^Erfolgsmeldung, falls eine Datenänderung erfolgreich gespeichert werden konnte.^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_DATA_DELETED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Daten wurden gelöscht.^',
    p_pms_description => q'^Erfolgsmeldung, falls Daten erfolgreich gelöscht werden konnten.^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_CHK_REGISTER_OBSERVER',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Das Element #1# muss nicht beobachtet werden, da eine technische Bedingung das Element referenziert.^',
    p_pms_description => q'^Die Aktion kann entfernt werden, ohne das Verhalten der dynamischen Seite zu ändern.^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_CHK_DEPRECATED',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Die Aktion #1# ist deprecated und sollte durch ein anderes Verfahren ersetzt werden.^',
    p_pms_description => q'^Bitte folgen Sie den Anweisungen im Hilfetext des Aktionstyps.^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADCA_CHK_MISSING',
    p_pms_pmg_name => 'ADCA',
    p_pms_text => q'^Das Element #1# existiert auf der Seite nicht.^',
    p_pms_description => q'^Eventuell wurde das Element gelöscht oder umbenannt. Bitte kontrollieren Sie dies, da ansonsten JavaScript-Fehler auf der Seite auftauchen.^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'GERMAN');

  commit;
  pit_admin.create_message_package;
end;
/
