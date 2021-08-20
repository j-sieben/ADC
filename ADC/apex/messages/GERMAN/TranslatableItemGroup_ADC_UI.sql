set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC_UI',
    p_pmg_description => q'^Meldungen für die ADC Administrationsanwendung^');
    
    

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_AUTO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_FORCE_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite zusätzlich ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_NO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird ausgeführt, falls die Bedingung erfüllt ist und der Anwendungsfall als erster auf der Liste sortiert ist.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_1005',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Dynamische Seite aktivieren oder deaktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktiviert oder deaktiviert ADC für die Seite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_1521',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Aktion erstellen^',
    p_pti_display_name => q'^Erstellt eine neue Aktion^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_1729',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Bitte Mitarbeiter wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Bearbeitet den ausgewählten Mitarbeiter^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_544',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Dynamische Seite(n) exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Öffnet Anwendungsseite EXPORT_CGR^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_546',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Anwendungsfall erzeugen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Öffnet Anwendungsseite EDIT_CRU^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_548',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Seitenkommando erstellen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Öffnet Anwendungsseite EDIT_CAA^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_630',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Dynamische Anwendungsseiten exportieren^',
    p_pti_display_name => q'^Exportiert die gewählten dynamischen Seiten^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_ALL_CGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Alle Dynamischen Anwendungsseiten aller Anwendungen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^APEX-Anwendung inkl. dynamischer Anwendungsseiten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Alle dynamischen Anwendungsseiten einer Anwendung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Anwendung wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_AUTO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_FORCE_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite zusätzlich ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_NO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird ausgeführt, falls die Bedingung erfüllt ist und der Anwendungsfall als erster auf der Liste sortiert ist.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_NO_HELP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Keine Hilfe vorhanden, bitte wählen Sie einen Aktionstypen.^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/

set define on