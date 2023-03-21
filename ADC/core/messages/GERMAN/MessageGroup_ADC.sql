begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^Meldungen für das ADC Plugin^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');


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
    p_pms_pse_id => 50,
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
    p_pms_name => 'ADC_INITIALZE_CRG_FAILED',
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
    p_pms_name => 'ADC_INVALID_DATE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Ungültiges Datum: #1#.^',
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
    p_pms_name => 'ADC_ITEM_IS_MANDATORY_DEFAULT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #LABEL# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#LABEL# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
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
    p_pms_name => 'ADC_RULE_ACTION_EXISTS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Diese Kombination aus Attributen einer Regelaktion existiert bereits.^',
    p_pms_description => q'^Die Attribute CRA_CRG_ID, CRA_CRU_ID, CRA_CPI_ID, CRA_CAT_ID und CRA_ON_ERROR müssen eindeutig sein.^',
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
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Keine JavaScript-Aktion^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
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
    p_pms_text => q'^Weitere JavaScript-Aktion unterdrückt, weil zu lang^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_REDUCED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'Ausgabe wegen Länge auf Level #1# reduziert'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
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
    p_pms_text => q'^Die LOV-View #1# hat nicht die vorgegebenen Spalten D, R und CRG_ID.^',
    p_pms_description => q'^Damit eine LOV-View genutzt werden kann, muss sie über genau 3 Spalten mit den Bezeichnern D, R und CRG_ID verfügen.^',
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
    p_pms_text => q'^Rekursion #1#, Lauf #2#: Regel #3# (Wenn der Anwender #4#), Auslösendes Element: "#5#"#6| (Wert: |)|#, Dauer: #TIME#hsec^',
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
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Name der Regelgruppe muss für diese Anwendung eindeutig sein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUST_BE_UNIQUE',
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
    p_pms_pse_id => 50,
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
    p_pms_name => 'ADC_NO_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Aktion #1# wurde nicht ausgeführt, da kein Fehler vorlag und diese Aktion ein Fehlerhandler ist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_PLSQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL-Code "#1#" wurde nicht ausgeführt, da ein Fehler vorlag und die Regel gestoppt wurde.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fehler beim Ausführen von PL/SQL-Code #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_CODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL-Code: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^JavaScript-Code "#1#" wurde ausgegeben, da ein Fehler vorlag und die Regel gestoppt wurde.^',
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

  pit_admin.merge_message(
    p_pms_name => 'ADC_NUMBER_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Zahlelement #1# auf Wert #2# gesetzt, Zeichenkettenwert: #3#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DATE_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Datumselement #1# auf Wert #2# gesetzt, Zeichenkettenwert: #3#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_DEBUG_LEVEL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Debuglevel ist nicht erlaubt, verwenden sie lediglich adc_util.C_JS_CODE, adc_util.C_JS_DEBUG, adc_util.C_JS_COMMENT oder adc_util.C_JS_DETAIL.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_VALIDATION_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^Beim Validieren eines Parameterwerts wird diese, abhängig von seinem Typ, auf Plausibilität geprüft. Der fehlerhafter Parameterwert muss korrigiert werden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_JQUERY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Selektor "#1#" wird auf der Seite nicht verwendet.^',
    p_pms_description => q'^Beim Validieren eines jQuery-Selektors muss dieser auf der Seite vorhanden sein.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_UNKNOWN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Die APEX-Aktion #1# existiert nicht.^',
    p_pms_description => q'^Beim Validieren eines Parameters vom Typ APEX_ACTION wurde eine nicht existente APEX-Aktion referenziert.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_METHOD_PARSE_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^Beim Validieren einer Methode ist ein Parse-Fehler ausgelöst worden. Korrigieren Sie die Methode.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_PAGE_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Der Seitenelement "#1#" wird auf der Seite nicht verwendet.^',
    p_pms_description => q'^Beim Validieren eines Elementnamens muss dieser auf der Seite vorhanden sein.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SEQUENCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Die Sequenz "#1#" existiert nicht.^',
    p_pms_description => q'^Es wurde eine nicht vorhandene Sequenz referenziert.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_1',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 1: Entferne die REQUIRED-Flags und markiere Sie jedes Element als fehlerhaft, dies wird später korrigiert.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_2',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 2: Führe APEX-Seitenelemente in ADC_PAGE_ITEMS zusammen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_3',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 3: Markiere Seitenelemente, auf die in einer technischen Bedingung verwiesen wird, als relevant^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_4',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 4: Entfernen von Elementen, die irrelevant, fehlerhaft oder nicht referenziert sind^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_5',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 5: Markiere Fehler in adc_rules und ADC_RULE_ACTION und setze alle Fehlerflags für die Regel auf FALSE^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_6',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 6: Markiere Regeln, die auf Elemente mit einem  Fehlerflag verweisen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_7',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 7: Setze alle Fehlerkennzeichen für Regelaktionen auf FALSE zurück^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_8',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 8: Markiere Regelaktionen, die auf Elemente mit einem Fehlerflag verweisen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_9',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Schritt 9: Initialisierungscode für schnelle Seiteninitialisierung neu erstellen und in Tabelle adc_rule_groups hinterlegen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');

  commit;
  pit_admin.create_message_package;
end;
/
