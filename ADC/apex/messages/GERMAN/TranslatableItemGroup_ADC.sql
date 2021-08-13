set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^');
    
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_ELEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_PAGE_ELEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_ALL_CGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Dynamischen Anwendungsseiten aller Anwendungen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^APEX-Anwendung inkl. dynamischer Anwendungsseiten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle dynamischen Anwendungsseiten einer Anwendung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anwendung wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_AUTO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_FORCE_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird beim Initialisieren der Seite zusätzlich ausgeführt, falls die Bedingung erfüllt ist^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ADC_NO_INITIALIZE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird ausgeführt, falls die Bedingung erfüllt ist und der Anwendungsfall als erster auf der Liste sortiert ist.^'
  );

  commit;
end;
/

set define on