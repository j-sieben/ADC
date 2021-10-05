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

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_HELP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Anwendungsfall</h2><p>Ein Anwendungfall stellt eine Aktivität des Anwendungsbenutzers dar, auf die durch ADC reagiert werden soll.</p><p>Um eine Aktivität ddes Anwendungsbenutzers zu erkennen, ist eine technische Bedingung erforderlich, die zu TRUE evaluieren muss.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_HELP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Dynamische Seite</h2><p>Eine dynamische Seite ist eine APEX-Anwendungsseite, die durch ADC dynamisch kontrolliert werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_HELP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Seitenkommando</h2><p>Ein Seitenkommando ist eine Aktion, die durch unterschiedliche Aktionen ausgelöst werden kann. Sie dient der Zentralisierung von dynamischen Aktivitäten.</p>^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_SAVE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Seitenkommando speichern^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_DELETE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Seitenkommando löschen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_SAVE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Aktion speichern^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_DELETE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Aktion löschen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_SAVE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Anwendungsfall speichern^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_DELETE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Anwendungsfall löschen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'NO_SAVE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Speichern^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'NO_DELETE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Löschen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_CREATE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Anwendungsfall erstellen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_CREATE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Aktion erstellen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_CREATE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Seitenkommando erstellen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'CANCEL_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Abbrechen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_UNSAVED_ITEM_TITLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC_UI^',
    p_pti_name => q'^Hinweis^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/

set define on