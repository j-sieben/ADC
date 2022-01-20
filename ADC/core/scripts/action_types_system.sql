set define off
set sqlblanklines on

begin
  -- ACTION_PARAM_TYPES
  adc_admin.merge_action_param_type(
    p_cpt_id => 'APEX_ACTION',
    p_cpt_name => 'APEX-Aktion',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Existierende APEX-Aktion der Regelgruppe.</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'EVENT',
    p_cpt_name => 'Zusätzliche JavaScript-Events',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Liste der JavaScript-Events, die durch ADC überwacht werden können.</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'FUNCTION',
    p_cpt_name => 'PL/SQL-Funktion',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'ITEM_STATUS',
    p_cpt_name => 'Anzeigestatus',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Option zur Anzeige eines Seitenelements auf der Seite</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'JAVA_SCRIPT',
    p_cpt_name => 'JavaScript-Ausdruck',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Ausführbarer JavaScript-Ausdruck, keine Funktionsdefinition</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cpt_name => 'JavaScript-Funktion',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Name einer JavaScript-Funktion oder anonyme Funktionsdefinition/IIFE</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'JQUERY_SELECTOR',
    p_cpt_name => 'jQuery-Selektor',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'PAGE_ITEM',
    p_cpt_name => 'Seitenelement',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Seitenelement oder Region der aktuellen Seite</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'PIT_MESSAGE',
    p_cpt_name => 'Name der Meldung',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Bezeichner einer PIT-Meldung in der Form msg.NAME oder 'NAME', muss eine existierende Meldung sein.</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'PROCEDURE',
    p_cpt_name => 'PL/SQL-Prozedur',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Eine bestehende PL/SQL-Prozedur oder eine Package-Prozedur<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'SEQUENCE',
    p_cpt_name => 'Sequenz',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Name einer existierenden Sequenz</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'SQL_STATEMENT',
    p_cpt_name => 'SQL-Anweisung',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Ausführbare SELECT-Anweisung, die Eingabe erfolgt, wie im SQL-Developer &uuml;blich, es ist keine Angabe eines Semikolons erforderlich.</p>}',
    p_cpt_item_type => 'TEXT_AREA',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING',
    p_cpt_name => 'Zeichenkette',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Einfache Zeichenkette.<br>Die Zeichenkette wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich.</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING_OR_FUNCTION',
    p_cpt_name => 'Zeichenkette oder PL/SQL-Funktion',
    p_cpt_display_name => '',
    p_cpt_description => q'{Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein PL/SQL-Funktionsaufruf, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING_OR_JAVASCRIPT',
    p_cpt_name => 'Zeichenkette oder JS-Ausdruck',
    p_cpt_display_name => '',
    p_cpt_description => q'{Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Zeichenkette ITEM_VALUE, ohne Hochkommata. In diesem Fall wird der Wert von ITEM im Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING_OR_PIT_MESSAGE',
    p_cpt_name => 'Zeichenkette oder Meldungsname',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'SUBMIT_TYPE',
    p_cpt_name => 'Submit und/oder Validierung',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Typen der Seitenweiterleitung</p>}',
    p_cpt_item_type => 'SELECT_LIST',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'SWITCH',
    p_cpt_name => 'Schalter',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Wahrheitswert</p>}',
    p_cpt_item_type => 'SWITCH',
    p_cpt_active => adc_util.C_TRUE);


  -- PAGE_ITEM_TYPES
  adc_admin.merge_page_item_type(
    p_cit_id => 'AFTER_REFRESH',
    p_cit_name => 'Nach Refresh',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'apexafterrefresh',
    p_cit_col_template => q'{case p_event when 'apexafterrefresh' then p_firing_item end after_refresh}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'ALL',
    p_cit_name => 'Alle',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => '',
    p_cit_col_template => q'{}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'APP_ITEM',
    p_cit_name => 'Anwendungselement',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc_api.get_string('#ITEM#') #ITEM#}',
    p_cit_init_template => q'{itm.#ITEM#}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'BUTTON',
    p_cit_name => 'Schaltfläche',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'click',
    p_cit_col_template => q'{case p_firing_item when '#ITEM#' then c_true else c_false end #ITEM#}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'COMMAND',
    p_cit_name => 'Seitenkommando',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'command',
    p_cit_col_template => q'{case p_event when 'command' then adc_api.get_event_data('command') end command}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DATE_ITEM',
    p_cit_name => 'Element (Datum)',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc_api.get_date('#ITEM#', '#CONVERSION#', c_false) #ITEM#}',
    p_cit_init_template => q'{to_char(to_date(itm.#ITEM#), '#CONVERSION#')}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DIALOG_CLOSED',
    p_cit_name => 'Dialog geschlossen',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'apexafterclosedialog',
    p_cit_col_template => q'{case p_event when 'apexafterclosedialog' then p_firing_item end dialog_closed}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DOCUMENT',
    p_cit_name => 'Dokument',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => '',
    p_cit_col_template => q'{null #ITEM#}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DOUBLE_CLICK',
    p_cit_name => 'Doppelklick',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'dblclick',
    p_cit_col_template => q'{case p_event when 'dblclick' then p_firing_item end double_click}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'ENTER_KEY',
    p_cit_name => 'Enter-Taste',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'enter',
    p_cit_col_template => q'{case p_event when 'enter' then p_firing_item end enter_key}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'FIRING_ITEM',
    p_cit_name => 'Firing Item',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => '',
    p_cit_col_template => q'{p_firing_item firing_item}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'FORM_REGION',
    p_cit_name => 'Formularregion',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => '',
    p_cit_col_template => q'{null #ITEM#}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'INITIALIZING',
    p_cit_name => 'Initialize Flag',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => '',
    p_cit_col_template => q'{case p_firing_item when 'DOCUMENT' then c_true else c_false end initializing}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'ITEM',
    p_cit_name => 'Element',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc_api.get_string('#ITEM#') #ITEM#}',
    p_cit_init_template => q'{itm.#ITEM#}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'NUMBER_ITEM',
    p_cit_name => 'Element (Zahl)',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc_api.get_number('#ITEM#', '#CONVERSION#', c_false) #ITEM#}',
    p_cit_init_template => q'{to_char(itm.#ITEM#, '#CONVERSION#')}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'REGION',
    p_cit_name => 'Region',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => '',
    p_cit_col_template => q'{null #ITEM#}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'SELECTION_CHANGED',
    p_cit_name => 'Zeile in Bericht gewählt',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'adcselectionchange',
    p_cit_col_template => q'{case p_event when 'adcselectionchange' then p_firing_item end selection_changed}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);


  -- ACTION_ITEM_FOCUS
  adc_admin.merge_action_item_focus(
    p_cif_id => 'ALL',
    p_cif_name => 'Alle Seitenelemente',
    p_cif_description => q'{Alle Seitenelemente der Anwendung}',
    p_cif_actual_page_only => adc_util.C_FALSE,
    p_cif_item_types => 'DOCUMENT:APP_ELEMENT:BUTTON:REGION:ELEMENT',
    p_cif_default => 'DOCUMENT',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'DOCUMENT',
    p_cif_name => 'Keine Seitenelemente',
    p_cif_description => q'{Die Aktion is keinem konkreten Seitenelement zugeordnet}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DOCUMENT',
    p_cif_default => 'DOCUMENT',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'ENABLE_DISABLE',
    p_cif_name => 'Seitenelemente, die aktiviert und deaktiviert werden können',
    p_cif_description => q'{Alle Seitenelemente, die aktiviert und deaktiviert werden können}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'ELEMENT:DOCUMENT:BUTTON:REGION',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'FOCUSABLE',
    p_cif_name => 'Seitenelemente, die einen Focus erhalten können',
    p_cif_description => q'{Alle Seitenelemente, die einen Fokus erhalten können}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON:ELEMENT',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'FORM_REGION',
    p_cif_name => 'Formularregion',
    p_cif_description => q'{Region, die als Formular genutzt wird (kein Interactive Grid)}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'FORM_REGION',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE',
    p_cif_name => 'Alle Seitenelemente der aktuellen Seite',
    p_cif_description => q'{Alle Seitenelemente der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON:REGION:ELEMENT',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_BUTTON',
    p_cif_name => 'Schaltflächen der aktuellen Seite',
    p_cif_description => q'{Alle Schaltflächen der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_DOCUMENT',
    p_cif_name => 'Seitenelement oder jQuery-Selektor',
    p_cif_description => q'{Ermöglicht die Auswahl eines Seitenelements oder die Angabe eines jQuery-Selektors zur Auswahl mehrerer Seitenelemente.}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON:DOCUMENT:ELEMENT:REGION',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_ITEM',
    p_cif_name => 'Eingabefelder der aktuellen Seite',
    p_cif_description => q'{Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'ELEMENT',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cif_name => 'Eingabefeld oder Dokument',
    p_cif_description => q'{Alle Eingabefelder oder keine spezifische Angabe}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DOCUMENT:ELEMENT',
    p_cif_default => 'DOCUMENT',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_REGION',
    p_cif_name => 'Regionen der aktuellen Seite',
    p_cif_description => q'{Alle Regionen der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'REGION',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'REFRESHABLE',
    p_cif_name => 'Seitenelemente, die aktualisiert werden können',
    p_cif_description => q'{Alle Seitenelemente, die aktualisiert werden können}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'REGION:ELEMENT',
    p_cif_default => '',
    p_cif_active => adc_util.C_TRUE);


  -- ACTION_TYPE_GROUPS
  adc_admin.merge_action_type_group(
    p_ctg_id => 'ADC',
    p_ctg_name => 'Framework',
    p_ctg_description => q'{Allgemeine Aktionen}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'BUTTON',
    p_ctg_name => 'Schaltlfäche',
    p_ctg_description => q'{Aktionen für Schaltflächen}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'IG',
    p_ctg_name => 'Interactive Grid',
    p_ctg_description => q'{Aktionen für das Interaktive Grid}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'ITEM',
    p_ctg_name => 'Seitenelemente',
    p_ctg_description => q'{Aktionen für allgemeine Seitenelemente}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'JAVA_SCRIPT',
    p_ctg_name => 'JavaScript',
    p_ctg_description => q'{JavaScript-Funkionen und Events}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'PAGE_ITEM',
    p_ctg_name => 'Eingabefelder',
    p_ctg_description => q'{Aktionen für Eingabefelder}',
    p_ctg_active => adc_util.C_TRUE);

  adc_admin.merge_action_type_group(
    p_ctg_id => 'PL_SQL',
    p_ctg_name => 'PL/SQL',
    p_ctg_description => q'{PL/SQ-Funktionen}',
    p_ctg_active => adc_util.C_TRUE);


  -- ACTION TYPES
  adc_admin.merge_action_type(
    p_cat_id => 'CONFIRM_CLICK',
    p_cat_ctg_id => 'BUTTON',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Schaltfläche an Bestätigungsfrage binden',
    p_cat_display_name => q'{<p><strong>binde</strong> Schaltfläche “#ITEM#” and <strong>Bestätigungsabfrage</strong></p>}',
    p_cat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage bestätigt wird, wird das Ereignis an ADC gemeldet.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'CONFIRM_CLICK',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Geben Sie die Bestätigungsabfrage, die vor Ausführen der Schaltfläche angezeigt werden soll, ein. Hochkommata müssen nicht mit angegeben werden.</p>}',
    p_cap_display_name => 'Bestätigungsabfrage',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'CONFIRM_CLICK',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 2,
    p_cap_default => q'{Hinweis}',
    p_cap_description => q'{<p>Legen Sie fest, welcher Titel im Dialogfenster der Bestätgungsanfrage angezeigt werden soll.</p>}',
    p_cap_display_name => 'Titel des Dialogfensters',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DYNAMIC_JAVASCRIPT',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Dynamisches JavaScript ausführen',
    p_cat_display_name => q'{<p><strong>berechne JavaScript </strong>mittels “#PARAM_1#” und führe es aus</p>}',
    p_cat_description => q'{<p>Führt das übergebene JavaScript auf der Seite aus</p>}',
    p_cat_pl_sql => q'{adc_api.execute_javascript(q'##PARAM_1##');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DYNAMIC_JAVASCRIPT',
    p_cap_cpt_id => 'FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt.<br>Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'GET_REPORT_SELECTION',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Gewählte Zeilen-ID melden oder in Element speichern',
    p_cat_display_name => q'{<p>#PARAM_2|<strong>Spalte </strong>||<strong>Primärschlüssel</strong># aus Bericht “#ITEM#” #PARAM_1|<strong>in Feld</strong> “|” ablegen|an ADC melden#</p>}',
    p_cat_description => q'{<p>Legt die aktuell ausgewählten Zeilen-IDs im angegebenen Feld ab, falls ein Element angegeben wird, oder meldet den Schlüsselwert an ADC.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.getReportSelection('#ITEM#', '#PARAM_1#', #PARAM_2#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'GET_REPORT_SELECTION',
    p_cap_cpt_id => 'PAGE_ITEM',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Name des Seitenelements, in das die Auswahl des IG gespeichert werden soll. Falls dieser Parameter nicht gesetzt wird, wird das Ereignis SELECTION_CHANGED ausgelöst und der Primärschlüsselwert als EVENT_DATA-Inhalt an ADC zurückgegeben.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'GET_REPORT_SELECTION',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 2,
    p_cap_default => q'{1}',
    p_cap_description => q'{<p>1- basierte Ordinalzahl der Spalte, die im hinterlegten Element abgelegt werden soll. Die Reihenfolge richtet sich nach der Reihenfolge auf der APEX-Anwendungsseite.</p><p>Wird dieser Wert nicht angegeben, wird die Spalte verwendet, die auf der APEX-Anwendungsseite als Primärschlüsselspalte parametriert wurde. Bitte beachten Sie, dass derzeit nur eine Primärschlüsselspalte unterstützt wird.</p>}',
    p_cap_display_name => 'Ordinalzahl der Wertespalte',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'HIDE_IR_IG_FILTER',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Filterbank von IR/IG ausblenden',
    p_cat_display_name => q'{<p><strong>blende Filterbank</strong> von IR/IG “#ITEM#” aus</p>}',
    p_cat_description => q'{<p>Blendet die Filterbank von Interactive Report/Grid aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hideReportFilterPanel('#ITEM#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE);


  adc_admin.merge_action_type(
    p_cat_id => 'IG_ALIGN_VERTICAL',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Tabellenzellen vertikal oben formatieren',
    p_cat_display_name => q'{<p><strong>richte Zellinhalt </strong>von “#ITEM#” <strong>vertikal oben aus</strong></p>}',
    p_cat_description => q'{<p>Ändert die Formatierung eines interaktiven Grids/Reports so, dass die Tabellenzellen vertikal oben ausgerichtet sind.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.alignReportVerticalTop('#ITEM#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'INITIALIZE_FORM_REGION',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'FORM_REGION',
    p_cat_name => 'Formularregion initialiisieren',
    p_cat_display_name => q'{<p><strong>initialisiere Formular</strong> #PARAM_1#</p>}',
    p_cat_description => q'{<p>Analysiert die Datenquelle einer Formularregion und initialisiert die aktuellen Daten.</p>}',
    p_cat_pl_sql => q'{adc_api.initialize_form_region('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'IS_MANDATORY',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Feld ist Pflichtfeld',
    p_cat_display_name => q'{<p><strong>mache </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” zum <strong>Pflichtfeld</strong></p>}',
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>}',
    p_cat_pl_sql => q'{adc_api.register_mandatory('#ITEM#', adc_util.C_TRUE, '#PARAM_1#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setMandatory('#SELECTOR#', true);de.condes.plugin.adc.setDisplayState('#SELECTOR#', 'SHOW_ENABLE');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'IS_MANDATORY',
    p_cap_cpt_id => 'STRING_OR_PIT_MESSAGE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Fehlermeldung kann optional übergeben werden, ansonsten wird eine Standardmeldung verwendet.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'IS_MANDATORY',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'IS_OPTIONAL',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Feld ist optional',
    p_cat_display_name => q'{<p><strong>mache </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” <strong>optional</strong></p>}',
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>}',
    p_cat_pl_sql => q'{adc_api.register_mandatory('#ITEM#', adc_util.C_FALSE, null, '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setMandatory('#SELECTOR#',false);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'IS_OPTIONAL',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'MONITOR_EVENT',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'ALL',
    p_cat_name => 'JavaScript-Ereignis überwachen',
    p_cat_display_name => q'{<p><strong>beobachte Ereignis</strong> “#PARAM_1#” auf Seitenelement “#ITEM#” und #PARAM_2|<strong>führe Funktion</strong> “|” aus|<strong>melde Ereignis</strong> an ADC#</p>}',
    p_cat_description => q'{<p>Der Aktionstyp integriert einen zusätzlichen Eventhandler für Ereignisse, die nicht standardmäßig durch ADC überwacht werden, auf dem ausgewählten Seitenelement.</p><p>Durch diesen Aktionstyp ist es möglich auf spezielle Ereignisse, wie das Schließen eines modalen Dialogs oder die Betätigung der <span style="font-family:'Courier New', Courier, monospace;">ENTER</span>-Taste zu reagieren. Wird keine JavaScript-Funktion angegeben, wird ADC über das Ereignis informiert. Die zugehörige Pseudospalte enthält in diesem Fall die ID des auslösenden Elements. Beim Schließen eines modalen Dialogs muss darauf geachtet werden, dass das hier angegebene Seitenelement das Ereignis erhält. Dies wird über einen Parameter beim Erzeugen des URL sichergestellt.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_FALSE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'MONITOR_EVENT',
    p_cap_cpt_id => 'EVENT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{DIALOG_CLOSED}',
    p_cap_description => q'{<p>Liste der hinterlegten JavaScript-Events, die durch ADC zusätzlich überwacht werden können.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'MONITOR_EVENT',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'NOOP',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'nichts tun',
    p_cat_display_name => q'{<p><strong>tue nichts</strong>.</p>}',
    p_cat_description => q'{<p>Dieser Aktionstyp erlaubt es, eine technische Bedingung zu formulieren, bei der nichts weiter geschehen soll. Manchmal ist das sinnvoll, wenn zum Beispiel ein speziellerer Fall nichts tun soll, ein allgemeinerer Fall jedoch schon. In diesem Fall würde ein Anwendungsfall für den spezielleren Fall nur dann berücksichtigt, wenn auch eine Aktion hinterlegt ist, und diese wäre dann “nichts tun”.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'NOTIFY',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Benachrichtigung zeigen',
    p_cat_display_name => q'{<p><strong>zeige Hinweis </strong>“#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Zeigt eine Nachricht auf der Anwendungsseite</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.notify('#METHOD#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'NOTIFY',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Meldungstext</p>}',
    p_cap_display_name => 'Meldung',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'NOT_NULL',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Mindestens einen Wert wählen',
    p_cat_display_name => q'{<p>wähle <strong>mindestens einen Wert</strong> aus “#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut “<i>Liste der Seitenelemente</i>” einen Wert enthält.</p>}',
    p_cat_pl_sql => q'{adc.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'NOT_NULL',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte mindestens ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>}',
    p_cap_display_name => 'Liste der Seitenelemente',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'NOT_NULL',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form <span style="font-family:'Courier New', Courier, monospace;">MSG.&lt;Meldungsname&gt;</span></p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'PLSQL_CODE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'ALL',
    p_cat_name => 'PL/SQL-Code ausführen',
    p_cat_display_name => q'{<p>führe <strong>PL/SQL-Code</strong> “#PARAM_1#” aus</p>}',
    p_cat_description => q'{<p>Führt den als Parameter übergebenen PL/SQL-Code aus.</p>}',
    p_cat_pl_sql => q'{adc_api.execute_plsql('#PARAM_1#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'PLSQL_CODE',
    p_cap_cpt_id => 'PROCEDURE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>PL/SQL-Code, der ausgeführt werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld aktualisieren und Wert setzen',
    p_cat_display_name => q'{<p><strong>aktualisiere</strong> Feld “#ITEM#” und <strong>setze Feldwert </strong>auf #PARAM_1|Wert “|”|aktuellen Sessionstatus#</p>}',
    p_cat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refreshAndSetValue('#ITEM#', '#METHOD#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cap_cpt_id => 'STRING_OR_JAVASCRIPT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Wert, der gesetzt werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'REFRESHABLE',
    p_cat_name => 'Ziel aktualisieren (Refresh)',
    p_cat_display_name => q'{<p><strong>aktualisiere Seitenelement </strong>“#ITEM#”</p>}',
    p_cat_description => q'{<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refresh('#ITEM#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'RAISE_ITEM_EVENT',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld-Event auslösen',
    p_cat_display_name => q'{<p><strong>führe Anwendungsfälle </strong>des Elements “#ITEM#” aus</p>}',
    p_cat_description => q'{<p>Löst den zugehörigen Event auf das angegebene Seitenelement aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_cat_pl_sql => q'{adc_api.raise_item_event('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'REGISTER_OBSERVER',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld beobachten',
    p_cat_display_name => q'{<p><strong>beobachte Feld </strong>“#ITEM#”</p>}',
    p_cat_description => q'{<p>Beobachtet ein Feld, auch wenn kein Anwendungsfall es in der technischen Bedingung referenziert. So wird dessen aktueller Wert in den Session State übernommen.</p>}',
    p_cat_pl_sql => q'{adc_api.register_observer('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'REMEMBER_PAGE_STATE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'speichere aktuellen Seitenstatus',
    p_cat_display_name => q'{<p><strong>speichere</strong> den aktuellen <strong>Seitenstatus</strong></p>}',
    p_cat_description => q'{<p>Merkt sich den aktuellen Wert der zu überwachenden Eingabefelder. Dieser Aktionstyp wird benötigt, um dynamisch Änderungen an der Seite zu erkennen und eine Warnmeldung beim Verlassen oder Überschreiben der aktuell erfassten Werte zu geben.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.rememberPageItemStatus(#PARAM_1#);}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'REMEMBER_PAGE_STATE',
    p_cap_cpt_id => 'JAVA_SCRIPT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionales Array der IDs der Eingabefelder, deren Status erfasst werden soll. Ist dieser Parameter leer, werden alle sichtbaren Eingabefelder erfasst. Durch diesen Parameter kann die Liste der zu erfassenden Eingabefelder limitiert werden.</p><p>Der Parameter erwartet ein JSON-Array der Form ["P1_ENAME","P1_JOB"…] ohne umgebende Hochkommata oder geschweifte Klammern.</p>}',
    p_cap_display_name => 'Array der Eingabefelder',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SELECT_REGION_ENTRY',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Wähle Zeile in Region',
    p_cat_display_name => q'{<p><strong>wähle Zeile</strong> ‘#PARAM_1#' <strong>in Bericht</strong> #ITEM#</p>}',
    p_cat_description => q'{<p>Wählt eine Zeile in einem Bericht (klassisch, Interactive Region oder Interactive Grid) oder einem Tree.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.selectEntry('#ITEM#', '#PARAM_1#', true);}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SELECT_REGION_ENTRY',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>ID der Zeile, die gewählt werden soll. Kann z.B. #EVENT_DATA# sein, wenn die ID über eine Beobachtung einer Region geliefert wird.</p>}',
    p_cap_display_name => 'ID der Zeile',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SEND_VALIDATE_PAGE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Seite absenden und/oder validieren',
    p_cat_display_name => q'{<p><strong>fordere Verarbeitung</strong> der Seite im Modus “#PARAM<i>1#” <strong>an. </strong>PARAM</i>2| Request: ||#</p>}',
    p_cat_description => q'{<p>Validiert und/oder sendet die Seite ab.</p><p>Der Modus bestimmt, welche Aktionen durchgeführt werden. Soll die Seite validiert werden, kann ein Meldungstext definiert werden, der im Fall einer nicht erfolgreichen Validierung angezeigt wird. Wird diese Meldung weggelassen, werden nur die Fehlermeldungen der Validierungslogik angezeigt.</p>}',
    p_cat_pl_sql => q'{adc_api.validate_page('#PARAM_1#');}',
    p_cat_js => q'{de.condes.plugin.adc.submit('#PARAM_1#', '#PARAM_2#', '#PARAM_3#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SEND_VALIDATE_PAGE',
    p_cap_cpt_id => 'SUBMIT_TYPE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{VALIDATE_AND_SUBMIT}',
    p_cap_description => q'{<p>Legt den Modus der Übermittlung fest. Es kann eine Kombination aus Validieren und Absenden gewählt werden.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SEND_VALIDATE_PAGE',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 2,
    p_cap_default => q'{SUBMIT}',
    p_cap_description => q'{}',
    p_cap_display_name => 'Request',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SEND_VALIDATE_PAGE',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 3,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Referenziert eine Meldung, falls die Validierung fehl schlug.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_ELEMENT_FROM_STMT',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_cat_display_name => q'{<p><strong>setze Feldwert </strong>aus SQL-Anweisung</p>}',
    p_cat_description => q'{<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt…</p>}',
    p_cat_pl_sql => q'{adc_api.set_value_from_stmt('#ITEM#',q'|#PARAM_1#|');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_ELEMENT_FROM_STMT',
    p_cap_cpt_id => 'SQL_STATEMENT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt<br>Die Spaltenbezeichner müssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_FOCUS',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'FOCUSABLE',
    p_cat_name => 'Focus in Feld setzen',
    p_cat_display_name => q'{<p><strong>setze Fokus</strong> in Feld “#ITEM#”</p>}',
    p_cat_description => q'{<p>Fokus in Eingabefeld der Seite setzen</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{$('##ITEM#').focus();}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'SET_ITEM',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Feld auf Wert setzen',
    p_cat_display_name => q'{<p><strong>setze </strong>#PARAM_2|<strong>Selektor </strong>“||<strong>Feld </strong>“^ITEM^#” auf #PARAM_1|Wert “|”|NULL#, Status #PARAM_3#</p>}',
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert und kontrolliert den Anzeigestatus.</p>}',
    p_cat_pl_sql => q'{adc_api.set_session_state(p_cpi_id => '#ITEM#', p_value => #PARAM_1|||null#, p_allow_recursion => '#ALLOW_RECURSION#', p_jquery_selector => '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setDisplayState('#SELECTOR#', '#PARAM_3#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_ITEM',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Elementwert.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_ITEM',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_ITEM',
    p_cap_cpt_id => 'ITEM_STATUS',
    p_cap_sort_seq => 3,
    p_cap_default => q'{SHOW_ENABLE}',
    p_cap_description => q'{<p>Kontrolliert, wie das Seitenelement dargestellt werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_ITEM_LABEL',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feldbezeichner auf Wert setzen',
    p_cat_display_name => q'{<p><strong>setze Feldbezeichner</strong> auf “#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Setzt den Bezeichner des referenzierten Seitenelements auf den als Parameter übergebenen Wert.</p><p>Ein Pflichtfeld wird immer auch sichtbar und aktiv geschaltet, um eine Eingabe durch den Anwender zu ermöglichen.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.setDisplayState('#ITEM#', '', '#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE);


  adc_admin.merge_action_type(
    p_cat_id => 'SET_REGION_CONTENT',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'HTML-Inhalt einer Region setzen',
    p_cat_display_name => q'{<p><strong>setze Inhalt der Region</strong> “#ITEM#” auf berechneten Wert</p>}',
    p_cat_description => q'{<p>Setzt den HTML-Inhalt einer statischen Region auf einen berechneten Wert.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{$('##ITEM# .t-Region-body').html('#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_REGION_CONTENT',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>HTML-Code, der als Inhalt der Region verwendet werden soll.</p><p>Wird vor allem aus PL/SQL verwendet, um den neuen Inhalt durch eine PL/SQL-Prozedur berechnen lassen zu können.</p>}',
    p_cap_display_name => 'HTML-Code',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_VISUAL_STATE',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'ENABLE_DISABLE',
    p_cat_name => 'Anzeigestatus eines Seitenelements kontrollieren',
    p_cat_display_name => q'{<p><strong>setze die Sichtbarkeit</strong> des Seitenelements “#ITEM#” <strong>auf Status </strong>“#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Kontrolliert Sichtbarkeit (<span style="font-family:'Courier New', Courier, monospace;">SHOW/HIDE</span>) und Status (<span style="font-family:'Courier New', Courier, monospace;">ENABLED/DISABLED</span>) eines Seitenelements. Nur sinnvolle Kombinationen sind möglich.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.setDisplayState('#SELECTOR#', '#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_VISUAL_STATE',
    p_cap_cpt_id => 'ITEM_STATUS',
    p_cap_sort_seq => 1,
    p_cap_default => q'{SHOW_ENABLE}',
    p_cap_description => q'{<p>Legt den Anzeigestatus des Seitenelements fest.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_VISUAL_STATE',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SHOW_ERROR',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Fehler anzeigen',
    p_cat_display_name => q'{<p><strong>zeige Fehler </strong>“#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>}',
    p_cat_pl_sql => q'{adc_api.register_error('#ITEM#', '#PARAM_1#','');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_ERROR',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Geben Sie hier die Fehlermeldung ein. Diese kann auch durch eine PL/SQL-Funktion ermittelt werden.</p>}',
    p_cap_display_name => 'Fehlermeldung',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SHOW_HIDE_ITEMS',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Seitenlemente ein- und ausblenden',
    p_cat_display_name => q'{<p><strong>blende</strong> Selektoren "#PARAM_1#” &nbsp;<strong>ein und</strong> '#PARAM_2#" <strong>aus</strong></p>}',
    p_cat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten jQuery-Ausdruck identifiziert werden, ein- und die Seitenelemente, die durch den zweiten jQuery-Ausdruck identifiziert werden, ausgeblendet werden</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.setDisplayState('#PARAM_2#', 'HIDE');  de.condes.plugin.adc.setDisplayState('#PARAM_1#', 'SHOW_ENABLE');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_HIDE_ITEMS',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>}',
    p_cap_display_name => 'Einzublendende Seitenelemente',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_HIDE_ITEMS',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>}',
    p_cap_display_name => 'Auszublendende Seitenelemente',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'STOP_RULE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Regel stoppen',
    p_cat_display_name => q'{<p><strong>stoppe</strong> Anwendungsfall</p>}',
    p_cat_description => q'{<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>}',
    p_cat_pl_sql => q'{adc_api.stop_rule;}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'WARN_BEFORE_CLICK',
    p_cat_ctg_id => 'BUTTON',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Bestätigungsnachricht ausgeben, falls Änderungen vorliegen',
    p_cat_display_name => q'{<p><strong>zeige eine Warnmeldung</strong>, falls <strong>ungesicherte Änderungen</strong> existieren, bevor die Schaltfläche auslöst</p>}',
    p_cat_description => q'{<p>Stellt eine Prüfung vor dem Auslösen einer Schaltfläche bereit, die einen Warnhinweis zeigt, falls ungesicherte Änderungen auf der Seite existieren. Setzt voraus, dass der aktuelle Seitenstatus vorab mit “speichere aktuellen Seitenstatus” gesichert wurde.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'WARN_BEFORE_CLICK',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{Es existieren ungesicherte Änderungen auf der Seite.}',
    p_cap_description => q'{<p>Meldungstext, der angezeigt wird, falls ungesicherte Änderungen auf der Seite existieren.</p>}',
    p_cap_display_name => 'Warnhinweis',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'XOR',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'DOCUMENT',
    p_cat_name => 'Genau einen Wert wählen',
    p_cat_display_name => q'{<p>wähle <strong>genau einen Wert</strong> aus “#PARAM_1#”</p>}',
    p_cat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut “<i>Liste der Elemente</i>” einen Wert enthält.</p>}',
    p_cat_pl_sql => q'{adc.exclusive_or('#ITEM#', '#PARAM_1#', #PARAM_2#, #PARAM_3#);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen <span style="font-family:'Courier New', Courier, monospace;">NOT NULL</span>-Wert besitzen, oder alle Werte müssen leer sein, falls der Schalter “<i>Null ist erlaubt</i>” gesetzt ist.</p><p>Eine eventuelle Fehlermeldung wird beim Element angezeigt, das als Seitenelement für diese Aktion ausgewählt ist.</p>}',
    p_cap_display_name => 'Liste der Seitenelemente',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form <span style="font-family:'Courier New', Courier, monospace;">MSG.&lt;Meldungsname&gt;</span></p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'SWITCH',
    p_cap_sort_seq => 3,
    p_cap_default => q'{adc_util.C_TRUE}',
    p_cap_description => q'{<p>Legt fest, ob auch kein Wert enthalten sein darf oder nicht.</p>}',
    p_cap_display_name => 'Null ist erlaubt',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);



  -- APEX_ACTION TYPES
  adc_admin.merge_apex_action_type(
    p_cty_id => 'ACTION',
    p_cty_name => 'Befehl/Verweis',
    p_cty_description => q'{JavaScript oder PL/SQL-Befehl, alternativ Verweis}',
    p_cty_active  => adc_util.C_TRUE);

  adc_admin.merge_apex_action_type(
    p_cty_id => 'RADIO_GROUP',
    p_cty_name => 'Optionsgruppe',
    p_cty_description => q'{Auswahlliste, Optionsfelder}',
    p_cty_active  => adc_util.C_TRUE);

  adc_admin.merge_apex_action_type(
    p_cty_id => 'TOGGLE',
    p_cty_name => 'Schalter',
    p_cty_description => q'{Wahlschalter (JA|NEIN)}',
    p_cty_active  => adc_util.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off
