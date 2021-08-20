set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^');
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente der Anwendung^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_DATE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement (Datum)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Datumsformatmasek</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Keine Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Die Aktion is keinem konkreten Seitenelement zugeordnet^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ENABLE_DISABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente, die aktiviert und deaktiviert werden können^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente, die aktiviert und deaktiviert werden können^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement oder jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente oder ein jQuery-Selektor^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_NONE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Keine Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Keine Seitenelemente^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_NUMBER_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement (Zahl)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Zahlformatmaske</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Seitenelemente der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltflächen der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Schaltflächen der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM_OR_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefeld oder Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Eingabefelder oder keine spezifische Angabe^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefeld oder jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Eingabefelder oder ein jQuery-Selektor^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regionen der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Regionen der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_REFRESHABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente, die aktualisiert werden können^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente, die aktualisiert werden können^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_AFTER_REFRESH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Nach Refresh^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_APP_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anwendungselement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_COMMAND',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenkommando^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DATE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Datum)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DIALOG_CLOSED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog geschlossen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DOCUMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DOUBLE_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Doppelklick^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ELEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ENTER_KEY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter-Taste^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_FIRING_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Firing Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_INITIALIZING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialize Flag^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_NUMBER_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Zahl)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_REGION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_SELECTION_CHANGED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeile in Bericht gewählt^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_APEX_ACTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^APEX-Aktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Existierende APEX-Aktion der Regelgruppe.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JAVA_SCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Ausdruck^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ausführbarer JavaScript-Ausdruck, keine Funktionsdefinition</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JAVA_SCRIPT_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name einer JavaScript-Funktion oder anonyme Funktionsdefinition/IIFE</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JQUERY_SELECTOR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Seitenelement oder Region der aktuellen Seite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PIT_MESSAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Name der Meldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Bezeichner einer PIT-Meldung in der Form msg.NAME oder 'NAME', muss eine existierende Meldung sein.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PROCEDURE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Prozedur^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Eine bestehende PL/SQL-Prozedur oder eine Package-Prozedur<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_SEQUENCE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Sequenz^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name einer existierenden Sequenz</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_SQL_STATEMENT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^SQL-Anweisung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ausführbare SELECT-Anweisung, die Eingabe erfolgt, wie im SQL-Developer &uuml;blich, es ist keine Angabe eines Semikolons erforderlich.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Einfache Zeichenkette.<br>Die Zeichenkette wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_FUNCTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder PL/SQL-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein PL/SQL-Funktionsaufruf, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder JS-Ausdruck^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_PIT_MESSAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder Meldungsname^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_SWITCH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schalter^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Wahrheitswert</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_INITIAL_RULE_NAME',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^die Seite öffnet^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Bezeichner des automatisiert erzeugten Anwendungsfalls^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_ADC',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Allgemeine Aktionen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltlfäche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für Schaltflächen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_IG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für das Interaktive Grid^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für allgemeine Seitenelemente^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_JAVA_SCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript-Funkionen und Events^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_PAGE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefelder^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für Eingabefelder^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_PL_SQL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^PL/SQ-Funktionen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_ACTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Befehl/Verweis^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript oder PL/SQL-Befehl, alternativ Verweis^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_RADIO_GROUP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Optionsgruppe^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Auswahlliste, Optionsfelder^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_TOGGLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schalter^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wahlschalter (JA|NEIN)^'
  );

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
    p_pti_id => 'ITEM_STATUS_A_SHOW_ENABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^sichtbar und aktiv^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_B_SHOW_DISABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^sichtbar, aber deaktiv^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_C_HIDE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ausgeblendet^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/

set define on