set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_126',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamische Seite exportieren^',
    p_pti_display_name => q'^Dynamische Seite exportieren^',
    p_pti_description => q'^Dynamische Seite exportieren^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_51',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Löschen^',
    p_pti_display_name => q'^Aktion löschen^',
    p_pti_description => q'^Löschen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_53',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Speichern^',
    p_pti_display_name => q'^Änderungen speichern^',
    p_pti_description => q'^Speichern^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_55',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Löschen^',
    p_pti_display_name => q'^Daten löschen^',
    p_pti_description => q'^Löschen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_57',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Aktiv^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktiv^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_59',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Erstellen^',
    p_pti_display_name => q'^Datensatz erstellen^',
    p_pti_description => q'^Erstellen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAA_61',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamische Seite exportieren^',
    p_pti_display_name => q'^Dynamische Seite exportieren^',
    p_pti_description => q'^Dynamische Seite exportieren^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Bestätigungsabfrage^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Geben Sie die Bestätigungsabfrage, die vor Ausführen der Schaltfläche angezeigt werden soll, ein. Hochkommata müssen nicht mit angegeben werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_CONFIRM_CLICK_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Titel des Dialogfensters^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Legen Sie fest, welcher Titel im Dialogfenster der Bestätgungsanfrage angezeigt werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_DYNAMIC_JAVASCRIPT_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt.<br>Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name des Seitenelements, in das die Auswahl des IG gespeichert werden soll. Falls dieser Parameter nicht gesetzt wird, wird das Ereignis SELECTION_CHANGED ausgelöst und der Primärschlüsselwert als EVENT_DATA-Inhalt an ADC zurückgegeben.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_GET_REPORT_SELECTION_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ordinalzahl der Wertespalte^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>1- basierte Ordinalzahl der Spalte, die im hinterlegten Element abgelegt werden soll. Die Reihenfolge richtet sich nach der Reihenfolge auf der APEX-Anwendungsseite.</p><p>Wird dieser Wert nicht angegeben, wird die Spalte verwendet, die auf der APEX-Anwendungsseite als Primärschlüsselspalte parametriert wurde. Bitte beachten Sie, dass derzeit nur eine Primärschlüsselspalte unterstützt wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Fehlermeldung kann optional übergeben werden, ansonsten wird eine Standardmeldung verwendet.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_MANDATORY_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_IS_OPTIONAL_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_MONITOR_EVENT_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Liste der hinterlegten JavaScript-Events, die durch ADC zusätzlich überwacht werden können.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_MONITOR_EVENT_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOTIFY_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Meldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Meldungstext</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Liste der Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte mindestens ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_NOT_NULL_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form <span style="font-family:'Courier New', Courier, monospace;">MSG.[Meldungsname]</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_PLSQL_CODE_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL-Code, der ausgeführt werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REFRESH_AND_SET_VALUE_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Wert, der gesetzt werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_REMEMBER_PAGE_STATE_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Array der Eingabefelder^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionales Array der IDs der Eingabefelder, deren Status erfasst werden soll. Ist dieser Parameter leer, werden alle sichtbaren Eingabefelder erfasst. Durch diesen Parameter kann die Liste der zu erfassenden Eingabefelder limitiert werden.</p><p>Der Parameter erwartet ein JSON-Array der Form ["P1_ENAME","P1_JOB"…] ohne umgebende Hochkommata oder geschweifte Klammern.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SELECT_REGION_ENTRY_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ID der Zeile^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>ID der Zeile, die gewählt werden soll. Kann z.B. #EVENT_DATA# sein, wenn die ID über eine Beobachtung einer Region geliefert wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Legt den Modus der Übermittlung fest. Es kann eine Kombination aus Validieren und Absenden gewählt werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SEND_VALIDATE_PAGE_PARAM_3',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Referenziert eine Meldung, falls die Validierung fehl schlug.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ELEMENT_FROM_STMT_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt<br>Die Spaltenbezeichner müssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Elementwert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_ITEM_PARAM_3',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Kontrolliert, wie das Seitenelement dargestellt werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_REGION_CONTENT_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^HTML-Code^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>HTML-Code, der als Inhalt der Region verwendet werden soll.</p><p>Wird vor allem aus PL/SQL verwendet, um den neuen Inhalt durch eine PL/SQL-Prozedur berechnen lassen zu können.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_VISUAL_STATE_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Legt den Anzeigestatus des Seitenelements fest.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SET_VISUAL_STATE_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_ERROR_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Fehlermeldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Geben Sie hier die Fehlermeldung ein. Diese kann auch durch eine PL/SQL-Funktion ermittelt werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Einzublendende Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_SHOW_HIDE_ITEMS_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Auszublendende Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_WARN_BEFORE_CLICK_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Warnhinweis^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungstext, der angezeigt wird, falls ungesicherte Änderungen auf der Seite existieren.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_1',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Liste der Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen, oder alle Werte müssen leer sein, falls der Schalter “<i>Null ist erlaubt</i>” gesetzt ist.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_2',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form <span style="font-family:'Courier New', Courier, monospace;">MSG.[Meldungsname]</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAP_XOR_PARAM_3',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Null ist erlaubt^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Legt fest, ob auch kein Wert enthalten sein darf oder nicht.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONFIRM_CLICK',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche an Bestätigungsfrage binden^',
    p_pti_display_name => q'^<p><strong>binde</strong> Schaltfläche “#ITEM#” and <strong>Bestätigungsabfrage</strong></p>^',
    p_pti_description => q'^<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage bestätigt wird, wird das Ereignis an ADC gemeldet.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DYNAMIC_JAVASCRIPT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamisches JavaScript ausführen^',
    p_pti_display_name => q'^<p><strong>berechne JavaScript </strong>mittels “#PARAM_1#” und führe es aus</p>^',
    p_pti_description => q'^<p>Führt das übergebene JavaScript auf der Seite aus</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_GET_REPORT_SELECTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Gewählte Zeilen-ID melden oder in Element speichern^',
    p_pti_display_name => q'^<p>#PARAM_2|<strong>Spalte </strong>||<strong>Primärschlüssel</strong># aus Bericht “#ITEM#” #PARAM_1|<strong>in Feld</strong> “|” ablegen|an ADC melden#</p>^',
    p_pti_description => q'^<p>Legt die aktuell ausgewählten Zeilen-IDs im angegebenen Feld ab, falls ein Element angegeben wird, oder meldet den Schlüsselwert an ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_IG_FILTER',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Filterbank von IR/IG ausblenden^',
    p_pti_display_name => q'^<p><strong>blende Filterbank</strong> von IR/IG “#ITEM#” aus</p>^',
    p_pti_description => q'^<p>Blendet die Filterbank von Interactive Report/Grid aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IG_ALIGN_VERTICAL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Tabellenzellen vertikal oben formatieren^',
    p_pti_display_name => q'^<p><strong>richte Zellinhalt </strong>von “#ITEM#” <strong>vertikal oben aus</strong></p>^',
    p_pti_description => q'^<p>Ändert die Formatierung eines interaktiven Grids/Reports so, dass die Tabellenzellen vertikal oben ausgerichtet sind.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_INITIALIZE_FORM_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Formularregion initialiisieren^',
    p_pti_display_name => q'^<p><strong>initialisiere Formular</strong> #PARAM_1#</p>^',
    p_pti_description => q'^<p>Analysiert die Datenquelle einer Formularregion und initialisiert die aktuellen Daten.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_MANDATORY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld ist Pflichtfeld^',
    p_pti_display_name => q'^<p><strong>mache </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” zum <strong>Pflichtfeld</strong></p>^',
    p_pti_description => q'^<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_OPTIONAL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld ist optional^',
    p_pti_display_name => q'^<p><strong>mache </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” <strong>optional</strong></p>^',
    p_pti_description => q'^<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_MONITOR_EVENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Ereignis überwachen^',
    p_pti_display_name => q'^<p><strong>beobachte Ereignis</strong> “#PARAM_1#” auf Seitenelement “#ITEM#” und #PARAM_2|<strong>führe Funktion</strong> “|” aus|<strong>melde Ereignis</strong> an ADC#</p>^',
    p_pti_description => q'^<p>Der Aktionstyp integriert einen zusätzlichen Eventhandler für Ereignisse, die nicht standardmäßig durch ADC überwacht werden, auf dem ausgewählten Seitenelement.</p><p>Durch diesen Aktionstyp ist es möglich auf spezielle Ereignisse, wie das Schließen eines modalen Dialogs oder die Betätigung der <span style="font-family:'Courier New', Courier, monospace;">ENTER</span>-Taste zu reagieren. Wird keine JavaScript-Funktion angegeben, wird ADC über das Ereignis informiert. Die zugehörige Pseudospalte enthält in diesem Fall die ID des auslösenden Elements. Beim Schließen eines modalen Dialogs muss darauf geachtet werden, dass das hier angegebene Seitenelement das Ereignis erhält. Dies wird über einen Parameter beim Erzeugen des URL sichergestellt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOOP',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^nichts tun^',
    p_pti_display_name => q'^<p><strong>tue nichts</strong>.</p>^',
    p_pti_description => q'^<p>Dieser Aktionstyp erlaubt es, eine technische Bedingung zu formulieren, bei der nichts weiter geschehen soll. Manchmal ist das sinnvoll, wenn zum Beispiel ein speziellerer Fall nichts tun soll, ein allgemeinerer Fall jedoch schon. In diesem Fall würde ein Anwendungsfall für den spezielleren Fall nur dann berücksichtigt, wenn auch eine Aktion hinterlegt ist, und diese wäre dann “nichts tun”.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOTIFY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Benachrichtigung zeigen^',
    p_pti_display_name => q'^<p><strong>zeige Hinweis </strong>“#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Zeigt eine Nachricht auf der Anwendungsseite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_NULL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Mindestens einen Wert wählen^',
    p_pti_display_name => q'^<p>wähle <strong>mindestens einen Wert</strong> aus “#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut “<i>Liste der Seitenelemente</i>” einen Wert enthält.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_PLSQL_CODE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Code ausführen^',
    p_pti_display_name => q'^<p>führe <strong>PL/SQL-Code</strong> “#PARAM_1#” aus</p>^',
    p_pti_description => q'^<p>Führt den als Parameter übergebenen PL/SQL-Code aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_RAISE_ITEM_EVENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld-Event auslösen^',
    p_pti_display_name => q'^<p><strong>führe Anwendungsfälle </strong>des Elements “#ITEM#” aus</p>^',
    p_pti_description => q'^<p>Löst den zugehörigen Event auf das angegebene Seitenelement aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_AND_SET_VALUE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld aktualisieren und Wert setzen^',
    p_pti_display_name => q'^<p><strong>aktualisiere</strong> Feld “#ITEM#” und <strong>setze Feldwert </strong>auf #PARAM_1|Wert “|”|aktuellen Sessionstatus#</p>^',
    p_pti_description => q'^<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel aktualisieren (Refresh)^',
    p_pti_display_name => q'^<p><strong>aktualisiere Seitenelement </strong>“#ITEM#”</p>^',
    p_pti_description => q'^<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_OBSERVER',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld beobachten^',
    p_pti_display_name => q'^<p><strong>beobachte Feld </strong>“#ITEM#”</p>^',
    p_pti_description => q'^<p>Beobachtet ein Feld, auch wenn kein Anwendungsfall es in der technischen Bedingung referenziert. So wird dessen aktueller Wert in den Session State übernommen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REMEMBER_PAGE_STATE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^speichere aktuellen Seitenstatus^',
    p_pti_display_name => q'^<p><strong>speichere</strong> den aktuellen <strong>Seitenstatus</strong></p>^',
    p_pti_description => q'^<p>Merkt sich den aktuellen Wert der zu überwachenden Eingabefelder. Dieser Aktionstyp wird benötigt, um dynamisch Änderungen an der Seite zu erkennen und eine Warnmeldung beim Verlassen oder Überschreiben der aktuell erfassten Werte zu geben.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SELECT_REGION_ENTRY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Wähle Zeile in Region^',
    p_pti_display_name => q'^<p><strong>wähle Zeile</strong> ‘#PARAM_1#' <strong>in Bericht</strong> #ITEM#</p>^',
    p_pti_description => q'^<p>Wählt eine Zeile in einem Bericht (klassisch, Interactive Region oder Interactive Grid) oder einem Tree.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SEND_VALIDATE_PAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite absenden und/oder validieren^',
    p_pti_display_name => q'^<p><strong>fordere Verarbeitung</strong> der Seite im Modus “#PARAM<i>1#” <strong>an. </strong>PARAM</i>2| Request: ||#</p>^',
    p_pti_description => q'^<p>Validiert und/oder sendet die Seite ab.</p><p>Der Modus bestimmt, welche Aktionen durchgeführt werden. Soll die Seite validiert werden, kann ein Meldungstext definiert werden, der im Fall einer nicht erfolgreichen Validierung angezeigt wird. Wird diese Meldung weggelassen, werden nur die Fehlermeldungen der Validierungslogik angezeigt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ELEMENT_FROM_STMT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Elementwert mit SQL-Anweisung setzen^',
    p_pti_display_name => q'^<p><strong>setze Feldwert </strong>aus SQL-Anweisung</p>^',
    p_pti_description => q'^<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt…</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_FOCUS',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Focus in Feld setzen^',
    p_pti_display_name => q'^<p><strong>setze Fokus</strong> in Feld “#ITEM#”</p>^',
    p_pti_description => q'^<p>Fokus in Eingabefeld der Seite setzen</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld auf Wert setzen^',
    p_pti_display_name => q'^<p><strong>setze </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” auf #PARAM_1|Wert “|”|NULL#, Status #PARAM_3#</p>^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert und kontrolliert den Anzeigestatus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM_LABEL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feldbezeichner auf Wert setzen^',
    p_pti_display_name => q'^<p><strong>setze Feldbezeichner</strong> auf “#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Setzt den Bezeichner des referenzierten Seitenelements auf den als Parameter übergebenen Wert.</p><p>Ein Pflichtfeld wird immer auch sichtbar und aktiv geschaltet, um eine Eingabe durch den Anwender zu ermöglichen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_REGION_CONTENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^HTML-Inhalt einer Region setzen^',
    p_pti_display_name => q'^<p><strong>setze Inhalt der Region</strong> “#ITEM#” auf berechneten Wert</p>^',
    p_pti_description => q'^<p>Setzt den HTML-Inhalt einer statischen Region auf einen berechneten Wert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_VISUAL_STATE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anzeigestatus eines Seitenelements kontrollieren^',
    p_pti_display_name => q'^<p><strong>setze die Sichtbarkeit</strong> des Seitenelements “#ITEM#” <strong>auf Status </strong>“#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Kontrolliert Sichtbarkeit (<span style="font-family:'Courier New', Courier, monospace;">SHOW/HIDE</span>) und Status (<span style="font-family:'Courier New', Courier, monospace;">ENABLED/DISABLED</span>) eines Seitenelements. Nur sinnvolle Kombinationen sind möglich.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ERROR',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Fehler anzeigen^',
    p_pti_display_name => q'^<p><strong>zeige Fehler </strong>“#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_HIDE_ITEMS',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenlemente ein- und ausblenden^',
    p_pti_display_name => q'^<p><strong>blende</strong> Selektoren "#PARAM_1#” <strong>ein und</strong> '#PARAM_2#" <strong>aus</strong></p>^',
    p_pti_description => q'^<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten jQuery-Ausdruck identifiziert werden, ein- und die Seitenelemente, die durch den zweiten jQuery-Ausdruck identifiziert werden, ausgeblendet werden</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_STOP_RULE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regel stoppen^',
    p_pti_display_name => q'^<p><strong>stoppe</strong> Anwendungsfall</p>^',
    p_pti_description => q'^<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_WARN_BEFORE_CLICK',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Bestätigungsnachricht ausgeben, falls Änderungen vorliegen^',
    p_pti_display_name => q'^<p><strong>zeige eine Warnmeldung</strong>, falls <strong>ungesicherte Änderungen</strong> existieren, bevor die Schaltfläche auslöst</p>^',
    p_pti_description => q'^<p>Stellt eine Prüfung vor dem Auslösen einer Schaltfläche bereit, die einen Warnhinweis zeigt, falls ungesicherte Änderungen auf der Seite existieren. Setzt voraus, dass der aktuelle Seitenstatus vorab mit “speichere aktuellen Seitenstatus” gesichert wurde.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Genau einen Wert wählen^',
    p_pti_display_name => q'^<p>wähle <strong>genau einen Wert</strong> aus “#PARAM_1#”</p>^',
    p_pti_description => q'^<p>Stellt sicher, dass genau eines der Elemente aus Attribut “<i>Liste der Elemente</i>” einen Wert enthält.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ALL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente der Anwendung^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DATE_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement (Datum)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Datumsformatmasek</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_DOCUMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Keine Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Die Aktion is keinem konkreten Seitenelement zugeordnet^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ENABLE_DISABLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente, die aktiviert und deaktiviert werden können^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente, die aktiviert und deaktiviert werden können^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FOCUSABLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente, die einen Focus erhalten können^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente, die einen Fokus erhalten können^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_FORM_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Formularregion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Region, die als Formular genutzt wird (kein Interactive Grid)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_ITEM_OR_JQUERY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement oder jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente oder ein jQuery-Selektor^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_NONE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Keine Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Keine Seitenelemente^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_NUMBER_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement (Zahl)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Zahlformatmaske</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Seitenelemente der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_BUTTON',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltflächen der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Schaltflächen der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_DOCUMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement oder jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Ermöglicht die Auswahl eines Seitenelements oder die Angabe eines jQuery-Selektors zur Auswahl mehrerer Seitenelemente.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_DOCUMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefeld oder Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Eingabefelder oder keine spezifische Angabe^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_ITEM_OR_JQUERY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefeld oder jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Eingabefelder oder ein jQuery-Selektor^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_PAGE_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regionen der aktuellen Seite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Regionen der aktuellen Anwendungsseite^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAIF_REFRESHABLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente, die aktualisiert werden können^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Alle Seitenelemente, die aktualisiert werden können^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_AFTER_REFRESH',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Nach Refresh^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ALL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_APP_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anwendungselement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_BUTTON',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_COMMAND',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenkommando^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DATE_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Datum)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DIALOG_CLOSED',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog geschlossen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOCUMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dokument^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_DOUBLE_CLICK',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Doppelklick^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ELEMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ENTER_KEY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter-Taste^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FIRING_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Firing Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_FORM_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Formularregion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_INITIALIZING',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialize Flag^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_NUMBER_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element (Zahl)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPIT_SELECTION_CHANGED',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeile in Bericht gewählt^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_APEX_ACTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^APEX-Aktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Existierende APEX-Aktion der Regelgruppe.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_EVENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zusätzliche JavaScript-Events^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Liste der JavaScript-Events, die durch ADC überwacht werden können.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_FUNCTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_ITEM_STATUS',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anzeigestatus^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Option zur Anzeige eines Seitenelements auf der Seite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Ausdruck^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ausführbarer JavaScript-Ausdruck, keine Funktionsdefinition</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JAVA_SCRIPT_FUNCTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name einer JavaScript-Funktion oder anonyme Funktionsdefinition/IIFE</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_JQUERY_SELECTOR',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^jQuery-Selektor^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PAGE_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Seitenelement oder Region der aktuellen Seite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PIT_MESSAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Name der Meldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Bezeichner einer PIT-Meldung in der Form msg.NAME oder 'NAME', muss eine existierende Meldung sein.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_PROCEDURE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Prozedur^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Eine bestehende PL/SQL-Prozedur oder eine Package-Prozedur<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SEQUENCE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Sequenz^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name einer existierenden Sequenz</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SQL_STATEMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^SQL-Anweisung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ausführbare SELECT-Anweisung, die Eingabe erfolgt, wie im SQL-Developer &uuml;blich, es ist keine Angabe eines Semikolons erforderlich.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Einfache Zeichenkette.<br>Die Zeichenkette wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_FUNCTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder PL/SQL-Funktion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein PL/SQL-Funktionsaufruf, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder JS-Ausdruck^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_STRING_OR_PIT_MESSAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder Meldungsname^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SUBMIT_TYPE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Submit und/oder Validierung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Typen der Seitenweiterleitung</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAPT_SWITCH',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schalter^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Wahrheitswert</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRU_INITIAL_RULE_NAME',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^die Seite öffnet^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Bezeichner des automatisiert erzeugten Anwendungsfalls^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ADC',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Allgemeine Aktionen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_BUTTON',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltlfäche^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für Schaltflächen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_IG',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für das Interaktive Grid^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für allgemeine Seitenelemente^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_JAVA_SCRIPT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript-Funkionen und Events^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_PAGE_ITEM',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eingabefelder^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Aktionen für Eingabefelder^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CATG_PL_SQL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^PL/SQ-Funktionen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_ACTION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Befehl/Verweis^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript oder PL/SQL-Befehl, alternativ Verweis^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_RADIO_GROUP',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Optionsgruppe^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Auswahlliste, Optionsfelder^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAAT_TOGGLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schalter^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wahlschalter (JA|NEIN)^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_A_SHOW_ENABLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^sichtbar und aktiv^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_B_SHOW_DISABLE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^sichtbar, aber deaktiv^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_STATUS_C_HIDE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^ausgeblendet^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_A_VALIDATE_AND_SUBMIT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite validieren und weiterleiten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_B_VALIDATE_ONLY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite validieren, nicht weiterleiten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SUBMIT_TYPE_C_SUBMIT_ONLY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite nicht validieren, aber weiterleiten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SELECT_LIST',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamische Auswahlliste^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird für die Auswahl einer berechneten Menge Optionen verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_STATIC_LIST',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Statische Auswahlliste^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird für die Auswahl einer vorgegebenen Menge Optionen verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_SWITCH',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schalter^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird für die Ja/Nein oder An/Aus-Entscheidungen verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Textfeld^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird für kürzere Freitexte verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'VISUAL_TYPE_TEXT_AREA',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Textbereich^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Wird für umfangreiche Textmengen verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAG',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenkommandos^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLG',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Workflows^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'FLS',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Workflow^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/

set define on