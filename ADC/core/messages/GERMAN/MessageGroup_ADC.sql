begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^');


  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^ADC-Aktion #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX-Anwendung #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regel-SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#// Dynamisch erzeugtes JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ERROR_HANDLING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler in Rekursion #1#, Regel #2# (#3#), Auslösendes Element: "#4#" aufgetreten, fuehre Fehlerbehandlung aus^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_EXPECTED_FORMAT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Erwartetes Format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_GENERIC_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^"#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CGR_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler bei der Initialisierung der Regelgruppe #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRU_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler bei der Initialisierung der Einzelregel #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INIT_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regel #1# (#2#), zusätzlich ausgelöst beim Laden der Seite^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INTERNAL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Ein Fehler ist auf der Seite aufgetreten: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Ungültige Zahl. Erwartetes Format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Ungültige Zahl: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler in technischer Bedingung: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Seitenelement #1# existiert nicht in Anwendung #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #LABEL# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Mergen von Regel #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Mergen von Regelaktion #1#, #2#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Mergen von Regelgruppe #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Keine Daten fuer #1# gefunden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Keine Daten fuer Workspace "#1#" und Alias "#2#" gefunden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Kein JavaScript-Code fuer Regel "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Keine JavaScript-Aktion^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Keine Daten für Workspace #1# und Anwendung #2# gefunden^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Kein Anwendungsfall für den aktuellen Seitenstatus gefunden^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ONE_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Genau eines der Felder #1# und #2# ist zwingend vorzugeben.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_CLIPPED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'Weitere JavaScript-Aktion unterdrückt, weil zu lang^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_REDUCED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'Ausgabe wegen Länge auf Level #1# reduziert'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Beheben Sie vor dem Versenden alle Fehler der Seite.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_INCORRECT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Die LOV-View #1# hat nicht die vorgegebenen Spalten D, R und CGR_ID.^',
    p_pms_description => q'^Damit eine LOV-View genutzt werden kann, muss sie über genau 3 Spalten mit den Bezeichnern D, R und CGR_ID verfügen.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Parametertyp #1# erfordert eine LOV-View des Namens #2#. Diese fehlt.^',
    p_pms_description => q'^Ein Parametertyp, der eine LOV-Liste benötigt, erfordert eine entsprechende LOV-View, damit die erforderlichen Daten ermittelt werden können.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Feld #LABEL# ist ein Pflichtfeld.^',
    p_pms_description => q'^Das Eingabefeld ist ein Pflichtparameter und muss daher belegt werden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARSE_JSON',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Parsen von JSON: #SQLERRM#.^',
    p_pms_description => q'^Beim Parsen einer JSON Instanz traten Fehler auf. Korrigieren Sie die JSON-Instanz und versuchen es erneut.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PROCESSING_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Erzeuge Aktion für Regel #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LIMIT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# hat Rekursionstiefe von #2# ueberschritten.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regel #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rekursion #1#: Regel #2# (Wenn der Anwender #3#), Auslösendes Element: "#4#"#5| (Wert: |)|#, Dauer: #TIME##NOTIFICATION#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Integration der Seitenaktionen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VALIDATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler bei der Validierung der Regel #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regelgruppenview #1# wurde erstellt.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_FIRING_ITEM_PUSHED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# wurde auf Rekursion #2# auf den Stack geschrieben.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regelgruppenview #1# wurde gelöscht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_SESSION_STATE_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element ~#1#~ wurde auf den Wert ~#2#~ gesetzt^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CGR_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Name der Regelgruppe muss für diese Anwendung eindeutig sein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CGR_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Die Regelgruppe existiert bereits. Wählen Sie einen eindeutigen Namen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STANDARD_JS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Standard-ADC JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regelgruppe #1# ist bereits auf Anwendung #2#, Seite #3# und kann nicht über sich selbst kopiert werden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unerwarteter Elementtyp ~#1#~ mit Formatmaske.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Ausfuehren von "#1#", kann Arbeit nicht fortsetzen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Exporttyp #1# ist unbekannt.^',
    p_pms_description => q'^Es wurde ein nicht unterstützter Exporttyp angefordert. Verwenden Sie nur die Konstanten C_%_GROUP(S).^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_CPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unbekannter Parametertyp: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Regelgruppe #1# erfolgreich erstellt^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Erstellen der Decision Table #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_WHERE_CLAUSE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Erzeugen der WHERE-Klausel: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_REJECTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Aktion #1# wurde nicht ausgeführt, da ein Fehler vorlag und diese Aktion kein Fehlerhandler ist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_PLSQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL-Code wurde nicht ausgeführt, da ein Fehler vorlag und die Regel gestoppt wurde.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_CODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL-Code: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^JavaScript-Code "#1#" wurde nicht berücksichtigt, da ein Fehler vorlag und die Regel gestoppt wurde.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_EXECUTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Führe Aktion #1# aus.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_INFINITE_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schleife #1# hat die maximal erlaubte Anzahl Durchläufe überschritten und wurde abgebrochen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/