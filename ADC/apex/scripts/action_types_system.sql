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
    p_cpt_id => 'FUNCTION',
    p_cpt_name => 'PL/SQL-Funktion',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_cpt_item_type => 'TEXT',
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
    p_cpt_description => q'{<p>Wird der Wert mit einfachen Hochkommata &uuml;bergeben, wird er als konstanter Text ausgegeben.<br>Wird der Parameter ohne Hochkommata übergeben, wird er als PL/SQL-Funktkion interpretiert, die einen Wert liefert.</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING_OR_JAVASCRIPT',
    p_cpt_name => 'Zeichenkette oder JS-Ausdruck',
    p_cpt_display_name => '',
    p_cpt_description => q'{Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);

  adc_admin.merge_action_param_type(
    p_cpt_id => 'STRING_OR_PIT_MESSAGE',
    p_cpt_name => 'Zeichenkette oder Meldungsname',
    p_cpt_display_name => '',
    p_cpt_description => q'{<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>}',
    p_cpt_item_type => 'TEXT',
    p_cpt_active => adc_util.C_TRUE);


  -- PAGE_ITEM_TYPES
  adc_admin.merge_page_item_type(
    p_cit_id => 'AFTER_REFRESH',
    p_cit_name => 'Nach Refresh',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'apexafterrefresh',
    p_cit_col_template => q'{case adc.get_event when 'apexafterrefresh' then adc.get_firing_item end after_refresh}',
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
    p_cit_col_template => q'{v('#ITEM#') #ITEM#}',
    p_cit_init_template => q'{itm.#ITEM#}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'BUTTON',
    p_cit_name => 'Schaltfläche',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'click',
    p_cit_col_template => q'{case adc.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DATE_ITEM',
    p_cit_name => 'Element (Datum)',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc.get_date('#ITEM#', '#CONVERSION#') #ITEM#}',
    p_cit_init_template => q'{to_char(to_date(itm.#ITEM#), '#CONVERSION#')}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'DIALOG_CLOSED',
    p_cit_name => 'Dialog geschlossen',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'apexafterclosedialog',
    p_cit_col_template => q'{case adc.get_event when 'apexafterclosedialog' then adc.get_firing_item end dialog_closed}',
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
    p_cit_col_template => q'{case adc.get_event when 'dblclick' then adc.get_firing_item end double_click}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'ENTER_KEY',
    p_cit_name => 'Enter-Taste',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => 'enter',
    p_cit_col_template => q'{case adc.get_event when 'enter' then adc.get_firing_item end enter_key}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_TRUE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'FIRING_ITEM',
    p_cit_name => 'Firing Item',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => '',
    p_cit_col_template => q'{adc.get_firing_item firing_item}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'INITIALIZING',
    p_cit_name => 'Initialize Flag',
    p_cit_has_value => adc_util.C_FALSE,
    p_cit_include_in_view => adc_util.C_TRUE,
    p_cit_event => '',
    p_cit_col_template => q'{case adc.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing}',
    p_cit_init_template => q'{}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'ITEM',
    p_cit_name => 'Element',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc.get_string('#ITEM#') #ITEM#}',
    p_cit_init_template => q'{itm.#ITEM#}',
    p_cit_is_custom_event => adc_util.C_FALSE);
  adc_admin.merge_page_item_type(
    p_cit_id => 'NUMBER_ITEM',
    p_cit_name => 'Element (Zahl)',
    p_cit_has_value => adc_util.C_TRUE,
    p_cit_include_in_view => adc_util.C_FALSE,
    p_cit_event => 'change',
    p_cit_col_template => q'{adc.get_number('#ITEM#',replace( '#CONVERSION#', 'G')) #ITEM#}',
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


  -- ACTION_ITEM_FOCUS
  adc_admin.merge_action_item_focus(
    p_cif_id => 'ALL',
    p_cif_name => 'Alle Seitenelemente',
    p_cif_description => q'{Alle Seitenelemente der Anwendung}',
    p_cif_actual_page_only => adc_util.C_FALSE,
    p_cif_item_types => 'DOCUMENT:ALL:APP_ITEM:BUTTON:DATE_ITEM:ITEM:NUMBER_ITEM:REGION:ELEMENT',
    p_cif_default => 'DOCUMENT',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'DATE_ITEM',
    p_cif_name => 'Seitenelement (Datum)',
    p_cif_description => q'{<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Datumsformatmasek</p>}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DATE_ITEM',
    p_cif_default => null,
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
    p_cif_id => 'ITEM_OR_JQUERY',
    p_cif_name => 'Seitenelement oder jQuery-Selektor',
    p_cif_description => q'{Alle Seitenelemente oder ein jQuery-Selektor}',
    p_cif_actual_page_only => adc_util.C_FALSE,
    p_cif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'NONE',
    p_cif_name => 'Keine Seitenelemente',
    p_cif_description => q'{Keine Seitenelemente}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DOCUMENT',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'NUMBER_ITEM',
    p_cif_name => 'Seitenelement (Zahl)',
    p_cif_description => q'{<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite mit Zahlformatmaske</p>}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'NUMBER_ITEM',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE',
    p_cif_name => 'Alle Seitenelemente der aktuellen Seite',
    p_cif_description => q'{Alle Seitenelemente der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON:DATE_ITEM:ITEM:NUMBER_ITEM:REGION:ELEMENT',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_BUTTON',
    p_cif_name => 'Schaltflächen der aktuellen Seite',
    p_cif_description => q'{Alle Schaltflächen der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'BUTTON',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_ITEM',
    p_cif_name => 'Seitenelement',
    p_cif_description => q'{<p>Alle Anwendungs- und Seitenelemente der aktuellen Anwendungsseite</p>}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cif_name => 'Eingabefeld oder Dokument',
    p_cif_description => q'{Alle Eingabefelder oder keine spezifische Angabe}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DOCUMENT:DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT',
    p_cif_default => 'DOCUMENT',
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_ITEM_OR_JQUERY',
    p_cif_name => 'Eingabefeld oder jQuery-Selektor',
    p_cif_description => q'{Alle Eingabefelder oder ein jQuery-Selektor}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'PAGE_REGION',
    p_cif_name => 'Regionen der aktuellen Seite',
    p_cif_description => q'{Alle Regionen der aktuellen Anwendungsseite}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'REGION',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);

  adc_admin.merge_action_item_focus(
    p_cif_id => 'REFRESHABLE',
    p_cif_name => 'Seitenelemente, die aktualisiert werden können',
    p_cif_description => q'{Alle Seitenelemente, die aktualisiert werden können}',
    p_cif_actual_page_only => adc_util.C_TRUE,
    p_cif_item_types => 'ITEM:REGION',
    p_cif_default => null,
    p_cif_active => adc_util.C_TRUE);


  -- ACTION_TYPE_GROUPS
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

  adc_admin.merge_action_type_group(
    p_ctg_id => 'ADC',
    p_ctg_name => 'Framework',
    p_ctg_description => q'{Allgemeine Aktionen}',
    p_ctg_active => adc_util.C_TRUE);


  -- ACTION TYPES
  
  adc_admin.merge_action_type(
    p_cat_id => 'AFTER_REFRESH',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'REFRESHABLE',
    p_cat_name => 'Ereignis "After Refresh" überwachen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Registiert einen APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel AFTER_REFRESH = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'AFTER_REFRESH',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'CHECK_MANDATORY',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Pflichtfelder prüfen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>}',
    p_cat_pl_sql => q'{adc.check_mandatory('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'CHECK_MANDATORY',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Titel des Dialogfelds</p>}',
    p_cap_display_name => 'Dialogtitel',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'CHECK_MANDATORY',
    p_cap_cpt_id => 'STRING_OR_PIT_MESSAGE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldung, die in der Bestätigungsmeldung angezeigt wird</p>}',
    p_cap_display_name => 'Meldung',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'CONFIRM_CLICK',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Schaltfläche an Bestätigungsfrage binden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage best&auml;tigt wird, wird das Ereignis an ADC gemeldet.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'DIALOG_CLOSED',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ereignis "Dialog Close" überwachen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Registiert einen APEXAfterDialogClose-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel DIALOG_CLOSED = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DIALOG_CLOSED',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DISABLE_BUTTON',
    p_cat_ctg_id => 'BUTTON',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Schaltfläche deaktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Deaktiviert eine Schaltfl&auml;che. <br>Zum Deaktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld deaktivieren</span>.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{apex.item('#ITEM#').disable();$('##ITEM#').removeClass('in_progress');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'DISABLE_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel deaktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.disable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DISABLE_ITEM',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DOUBLE_CLICK',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ereignis "Doppelklick" überwachen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Registiert einen DoubleClick-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel DOUBLE_CLICK = &lt;Name des Seitenelements&gt; gefangen werden.&nbsp;<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DOUBLE_CLICK',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DYNAMIC_JAVASCRIPT',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Dynamisches JavaScript ausführen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Führt das übergebene JavaScript auf der Seite aus</p>}',
    p_cat_pl_sql => q'{adc.execute_javascript(q'##PARAM_1##');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

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
    p_cat_id => 'EMPTY_FIELD',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_JQUERY',
    p_cat_name => 'Feld leeren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'EMPTY_FIELD',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'ENABLE_BUTTON',
    p_cat_ctg_id => 'BUTTON',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Schaltfläche aktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Aktiviert eine Schaltfl&auml;che. Zum Aktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{apex.item('#ITEM#').enable();}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'ENABLE_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'ITEM_OR_JQUERY',
    p_cat_name => 'Ziel aktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.enable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'ENABLE_ITEM',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'ENTER_KEY',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Ereignis "Enter-Taste" überwachen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Registiert einen Enter-Taste-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel ENTER_KEY = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'ENTER_KEY',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'EXECUTE_APEX_ACTION',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Befehl ausführen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Führt einen Befehl aus, der vorab als APEX-Aktion angelegt worden sein muss.</p>}',
    p_cat_pl_sql => q'{adc.execute_apex_action('#PARAM_1#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'EXECUTE_APEX_ACTION',
    p_cap_cpt_id => 'APEX_ACTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'GET_SEQ_VAL',
    p_cat_ctg_id => 'PL_SQL',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Sequenzwert ermitteln',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#',#PARAM_1#.nextval, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'GET_SEQ_VAL',
    p_cap_cpt_id => 'SEQUENCE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Name der Sequenz</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'HIDE_IR_IG_FILTER',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Filterbank von IR/IG ausblenden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Blendet die Filterbank von Interactive Report/Grid aus.</p>\CR\}' || 
q'{}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hideFilterPanel('#ITEM#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'HIDE_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel ausblenden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Blendet das referenzierte Seitenelement aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'HIDE_ITEM',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'IS_DATE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld enthält Datum',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_cat_pl_sql => q'{adc.check_date('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'IS_MANDATORY',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld ist Pflichtfeld',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>}',
    p_cat_pl_sql => q'{adc.register_mandatory('#ITEM#','#PARAM_1#', true, '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setMandatory('#SELECTOR#', true);\CR\}' || 
q'{  de.condes.plugin.adc.show('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'IS_MANDATORY',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'IS_MANDATORY',
    p_cap_cpt_id => 'STRING_OR_PIT_MESSAGE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet.}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'IS_NUMERIC',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld enthält Zahl',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld einen numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_cat_pl_sql => q'{adc.check_number('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'IS_OPTIONAL',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld ist optional',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>}',
    p_cat_pl_sql => q'{adc.register_mandatory('#ITEM#', null, false,'#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setMandatory('#SELECTOR#',false);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

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
    p_cat_id => 'ITEM_NULL_SHOW',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld leeren und aktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf NULL und zeigt es auf der Seite an.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.enable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'ITEM_NULL_SHOW',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'JAVA_SCRIPT_CODE',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'JavaScript-Code ausführen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{#PARAM_1#;}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'JAVA_SCRIPT_CODE',
    p_cap_cpt_id => 'JAVA_SCRIPT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>JavaScript-Anweisung, die ausgef&uuml;hrt werden soll. (ohne Semikolon)</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'NOTIFY',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Benachrichtigung zeigen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Zeigt eine Nachricht auf der Anwendungsseite</p>}',
    p_cat_pl_sql => q'{adc.notify(#PARAM_1#);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

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
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Mindestens einen Wert wählen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_cat_pl_sql => q'{adc.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'NOT_NULL',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'NOT_NULL',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'PLSQL_CODE',
    p_cat_ctg_id => 'PL_SQL',
    p_cat_cif_id => 'ALL',
    p_cat_name => 'PL/SQL-Code ausführen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>\CR\}' || 
q'{}',
    p_cat_pl_sql => q'{adc.execute_plsql('#PARAM_1#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'PLSQL_CODE',
    p_cap_cpt_id => 'PROCEDURE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>\CR\}' || 
q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'ALL',
    p_cat_name => 'Feld aktualisieren und Wert setzen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refreshAndSetValue('#ITEM#', #PARAM_1#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cap_cpt_id => 'STRING_OR_JAVASCRIPT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Wert, der gesetzt werden soll. Es stehen folgende Optionen zur Wahl:</p><ul><li>Konstante Zeichenkette, eingeschlossen in Hochkommata</li><li>JavaScript-Ausdruck, der clientseitig ausgewertet wird</li><li>NULL. In diesem Fall wird der aktuelle Sessionstatuswert des aktualisierten Seitenelements verwendet. Dieser Wert kann durch eine entsprechende Aktion vor Aufruf dieser Methode berechnet worden sein.</li></ul>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel aktualisieren (Refresh)',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refresh('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'REGISTER_ITEM',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld-Event auslösen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_cat_pl_sql => q'{adc.register_item('#ITEM#', '#ALLOW_RECURSION#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'REGISTER_OBSERVER',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld beobachten',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Aktion beobachtet ein Feld oder eine Klasse und registriert die Elemente so, dass die entsprechenden Elementwerte bei jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'REGISTER_OBSERVER',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_CONSOLE',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Nachricht auf Console ausgeben',
    p_cat_display_name => null,
    p_cat_description => q'{<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{console.log(#PARAM_1#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_CONSOLE',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Meldungstext</p>}',
    p_cap_display_name => 'Nachricht',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_ELEMENT_FROM_STMT',
    p_cat_ctg_id => 'PL_SQL',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>}',
    p_cat_pl_sql => q'{adc.set_value_from_stmt('#ITEM#',q'##PARAM_1##');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_ELEMENT_FROM_STMT',
    p_cap_cpt_id => 'SQL_STATEMENT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt</br>Die Spaltenbezeichner m&uuml;ssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</dd>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_FOCUS',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Focus in Feld setzen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Fokus in Eingabefeld der Seite setzen</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{$('##SELECTOR#').focus();}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'SET_IG_SELECTION',
    p_cat_ctg_id => 'IG',
    p_cat_cif_id => 'PAGE_REGION',
    p_cat_name => 'Auswahl in Feld speichern',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Legt die aktuell ausgewählten Zeilen-IDs im angegebenen Feld ab.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.persistIGSelection('#ITEM#', '#PARAM_1#', #PARAM_2#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_IG_SELECTION',
    p_cap_cpt_id => 'PAGE_ITEM',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Name des Seitenelements, in das die Auswahl des IG gespeichert werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_IG_SELECTION',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 2,
    p_cap_default => q'{1}',
    p_cap_description => q'{<p>1- basierte Ordinalzahl der Spalte, die im hinterlegten Element abgelegt werden soll. Die Reihenfolge richtet sich nach der Reihenfolge auf der APEX-Anwendungsseite.</p>}',
    p_cap_display_name => 'Ordinalzahl der Wertespalte',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_ITEM',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld auf Wert setzen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', #PARAM_1#, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

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
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Elementwert.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_ITEM_LABEL',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feldbezeichner auf Wert setzen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt den Bezeichner des referenzierten Seitenelements auf den als Parameter übergebenen Wert.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.setItemLabel('#ITEM#', '#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_FALSE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'SET_NULL_DISABLE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld leeren und deaktivieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.disable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_NULL_DISABLE',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_NULL_HIDE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld leeren und ausblenden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#SELECTOR#');de.condes.plugin.adc.setMandatory('#SELECTOR#', false);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_NULL_HIDE',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SET_VALUE_ONLY',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld auf Wert setzen, keine Rekursion auslösen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf den &uuml;bergebenen Wert, ohne weitere Rekursionen auszul&ouml;sen</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#','#PARAM_1#', 0, '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_VALUE_ONLY',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SET_VALUE_ONLY',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Elementwert</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SHOW_ERROR',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_cat_name => 'Fehler anzeigen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>}',
    p_cat_pl_sql => q'{adc.register_error('#ITEM#', '#PARAM_1#','');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_ERROR',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Elementwert</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SHOW_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel anzeigen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.show('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_ITEM',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SHOW_TIP',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Hinweis anzeigen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>In der Meldungsregion einen Hinweis anzeigen</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{drv.ek.adc.setNotification('#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SHOW_TIP',
    p_cap_cpt_id => 'STRING_OR_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Der Elementwert</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'STOP_RULE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Regel stoppen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>}',
    p_cat_pl_sql => q'{adc.stop_rule;}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'SUBMIT',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Seite absenden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Prüft alle Pflichtfelder und löst die Weiterlietung der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page;}',
    p_cat_js => q'{de.condes.plugin.adc.submit('#PARAM_1#','#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SUBMIT',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung der Seite  misslingt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SUBMIT',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>REQUEST-Wert, kann optional &uuml;bergeben werden, ansonsten wird SUBMIT verwendet.</p>}',
    p_cap_display_name => 'Request',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'SUBMIT_WO_VALIDATION',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Seite absenden, keine Validierung',
    p_cat_display_name => null,
    p_cat_description => q'{<p>L&ouml;st die Weiterleitung der Seite ohne vorherige Validierung aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page(false);}',
    p_cat_js => q'{de.condes.plugin.adc.submit('#PARAM_1#','#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'SUBMIT_WO_VALIDATION',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'TOGGLE_ITEMS',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Ziele ein- und ausblenden',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten Parameter identifiziert werden, ein- und die Seitenelemente, die durch den zweiten Parameter identifiziert werden, ausgeblendet werden</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#PARAM_2#');\CR\}' || 
q'{  de.condes.plugin.adc.show('#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'TOGGLE_ITEMS',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>}',
    p_cap_display_name => 'Einzublendende Seitenelemente',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'TOGGLE_ITEMS',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>}',
    p_cap_display_name => 'Auszublendende Seitenelemente',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'VALIDATE',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Seite validieren',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Prüft alle Pflichtfelder, löst aber keine Weiterleitung der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page;}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'WAIT_FOR_REFRESH',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'REFRESHABLE',
    p_cat_name => 'Eieruhr zeigen, bis APEX-Refresh erfolgreich',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Sorgt dafür, dass auf der Seite eine Eieruhr eingeblendet wird, bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen wurde.<br>Als Seitenelement muss die Region/das Element angegeben werden, auf dessen Aktuialisierung gewartet wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{drv.ek.waitUntilRefresh('#ITEM#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);


  adc_admin.merge_action_type(
    p_cat_id => 'XOR',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Genau einen Wert wählen',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_cat_pl_sql => q'{adc.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, false);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte müssen leer sein</p>}',
    p_cap_display_name => 'Liste der Seitenelemente',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_FALSE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'XOR_NN',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Genau einen Wert wählen, NOT_NULL',
    p_cat_display_name => null,
    p_cat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p>}',
    p_cat_pl_sql => q'{adc.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, true);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE,
    p_cat_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR_NN',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR_NN',
    p_cap_cpt_id => 'PIT_MESSAGE',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Medlungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>}',
    p_cap_display_name => 'Meldungsname',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR_NN',
    p_cap_cpt_id => 'STRING',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</p>}',
    p_cap_display_name => 'Seitenelemente',
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
