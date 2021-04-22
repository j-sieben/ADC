set define off
set sqlblanklines on

begin
  
    adc_admin.merge_action_type(
    p_cat_id => 'AFTER_REFRESH',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'REFRESHABLE',
    p_cat_name => 'Ereignis "After Refresh" überwachen',
    p_cat_description => q'{<p>Registiert einen APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel AFTER_REFRESH = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'AFTER_REFRESH',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'CHECK_MANDATORY',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Pflichtfelder prüfen',
    p_cat_description => q'{<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>}',
    p_cat_pl_sql => q'{adc.check_mandatory('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage best&auml;tigt wird, wird das Ereignis an ADC gemeldet.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'DIALOG_CLOSED',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ereignis "Dialog Close" überwachen',
    p_cat_description => q'{<p>Registiert einen APEXAfterDialogClose-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an ADC gemeldet und kann mit einer Regel DIALOG_CLOSED = 1 gefangen werden.</br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DIALOG_CLOSED',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DISABLE_BUTTON',
    p_cat_ctg_id => 'BUTTON',
    p_cat_cif_id => 'PAGE_BUTTON',
    p_cat_name => 'Schaltfläche deaktivieren',
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
    p_cat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.disable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Registiert einen DoubleClick-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an ADC gemeldet und kann mit einer Regel DOUBLE_CLICK = 1 gefangen werden. <br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'DOUBLE_CLICK',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'DYNAMIC_JAVASCRIPT',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Dynamisches JavaScript ausführen',
    p_cat_description => q'{<p>Führt das übergebene JavaScript auf der Seite aus</p>}',
    p_cat_pl_sql => q'{adc.execute_javascript(q'##PARAM_1##');}',
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
    p_cat_id => 'EMPTY_FIELD',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM_OR_JQUERY',
    p_cat_name => 'Feld leeren',
    p_cat_description => q'{<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Aktiviert eine Schaltfl&auml;che. Zum Aktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{apex.item('#ITEM#').enable();}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'ENABLE_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'ITEM_OR_JQUERY',
    p_cat_name => 'Ziel aktivieren',
    p_cat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.enable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Registiert einen Enter-Taste-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer RegelENTER_KEY = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'ENTER_KEY',
    p_cap_cpt_id => 'JAVA_SCRIPT_FUNCTION',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_FALSE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'EXECUTE_APEX_ACTION',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Befehl ausführen',
    p_cat_description => q'{<p>Führt einen Befehl aus, der vorab als APEX-Aktion angelegt worden sein muss.</p>}',
    p_cat_pl_sql => q'{adc.execute_apex_action('#PARAM_1#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#',#PARAM_1#.nextval, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_id => 'HIDE_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel ausblenden',
    p_cat_description => q'{<p>Blendet das referenzierte Seitenelement aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_cat_pl_sql => q'{adc.check_date('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'IS_MANDATORY',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld ist Pflichtfeld',
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>}',
    p_cat_pl_sql => q'{adc.register_mandatory('#ITEM#','#PARAM_1#', true, '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.setMandatory('#SELECTOR#', true);\CR\}' || 
q'{  de.condes.plugin.adc.show('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld einen numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_cat_pl_sql => q'{adc.check_number('#ITEM#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'IS_OPTIONAL',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld ist optional',
    p_cat_description => q'{<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>}',
    p_cat_pl_sql => q'{adc.register_mandatory('#ITEM#', null, false,'#PARAM_2#');}',
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
    p_cat_id => 'ITEM_NULL_SHOW',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld leeren und aktivieren',
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf NULL und zeigt es auf der Seite an.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.enable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{#PARAM_1#;}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Zeigt eine Nachricht auf der Anwendungsseite</p>}',
    p_cat_pl_sql => q'{adc.notify(#PARAM_1#);}',
    p_cat_js => q'{}',
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
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Mindestens einen Wert wählen',
    p_cat_description => q'{<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_cat_pl_sql => q'{adc.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_cif_id => 'NONE',
    p_cat_name => 'PL/SQL-Code ausführen',
    p_cat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>}',
    p_cat_pl_sql => q'{adc.execute_plsql('#PARAM_1#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'PLSQL_CODE',
    p_cap_cpt_id => 'PROCEDURE',
    p_cap_sort_seq => 1,
    p_cap_default => q'{}',
    p_cap_description => q'{<p>PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld aktualisieren und Wert setzen',
    p_cat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refreshAndSetValue('#ITEM#', #PARAM_1#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'REFRESH_AND_SET_VALUE',
    p_cap_cpt_id => 'STRING_OR_JAVASCRIPT',
    p_cap_sort_seq => 1,
    p_cap_default => q'{''}',
    p_cap_description => q'{<p>Wert, der gesetzt werden soll.</p>}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'REFRESH_ITEM',
    p_cat_ctg_id => 'ITEM',
    p_cat_cif_id => 'PAGE',
    p_cat_name => 'Ziel aktualisieren (Refresh)',
    p_cat_description => q'{<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.refresh('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'REGISTER_ITEM',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld-Event auslösen',
    p_cat_description => q'{<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_cat_pl_sql => q'{adc.register_item('#ITEM#', '#ALLOW_RECURSION#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'REGISTER_OBSERVER',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld beobachten',
    p_cat_description => q'{<p>Aktion beobachtet ein Feld oder eine Klasse und registriert die Elemente so, dass die entsprechenden Elementwerte bei jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{console.log(#PARAM_1#);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>}',
    p_cat_pl_sql => q'{adc.set_value_from_stmt('#ITEM#',q'##PARAM_1##');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Fokus in Eingabefeld der Seite setzen</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{$('##SELECTOR#').focus();}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'SET_ITEM',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld auf Wert setzen',
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', #PARAM_1#, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_id => 'SET_NULL_DISABLE',
    p_cat_ctg_id => 'PAGE_ITEM',
    p_cat_cif_id => 'PAGE_ITEM',
    p_cat_name => 'Feld leeren und deaktivieren',
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.disable('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#SELECTOR#');de.condes.plugin.adc.setMandatory('#SELECTOR#', false);}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Setzt das referenzierte Seitenelement auf den &uuml;bergebenen Wert, ohne weitere Rekursionen auszul&ouml;sen</p>}',
    p_cat_pl_sql => q'{adc.set_session_state('#ITEM#','#PARAM_1#', 0, '#PARAM_2#');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>}',
    p_cat_pl_sql => q'{adc.register_error('#ITEM#', '#PARAM_1#','');}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.show('#SELECTOR#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>In der Meldungsregion einen Hinweis anzeigen</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{drv.ek.adc.setNotification('#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>}',
    p_cat_pl_sql => q'{adc.stop_rule;}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'SUBMIT',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Seite absenden',
    p_cat_description => q'{<p>Prüft alle Pflichtfelder und löst die Weiterlietung der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page;}',
    p_cat_js => q'{de.condes.plugin.adc.submit('#PARAM_1#','#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>L&ouml;st die Weiterleitung der Seite ohne vorherige Validierung aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page(false);}',
    p_cat_js => q'{de.condes.plugin.adc.submit('#PARAM_1#','#PARAM_2#');}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Ziele ein- und ausblenden',
    p_cat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten Parameter identifiziert werden, ein- und die Seitenelemente, die durch den zweiten Parameter identifiziert werden, ausgeblendet werden</p>}',
    p_cat_pl_sql => q'{}',
    p_cat_js => q'{de.condes.plugin.adc.hide('#PARAM_2#');\CR\}' || 
q'{  de.condes.plugin.adc.show('#PARAM_1#');}',
    p_cat_is_editable => adc_util.C_TRUE,
    p_cat_raise_recursive => adc_util.C_TRUE);

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
    p_cat_description => q'{<p>Prüft alle Pflichtfelder, löst aber keine Weiterleitung der Seite aus.</p>}',
    p_cat_pl_sql => q'{adc.submit_page;}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

  
  adc_admin.merge_action_type(
    p_cat_id => 'WAIT_FOR_REFRESH',
    p_cat_ctg_id => 'JAVA_SCRIPT',
    p_cat_cif_id => 'REFRESHABLE',
    p_cat_name => 'Eieruhr zeigen, bis APEX-Refresh erfolgreich',
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
    p_cat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält.</p> <dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte m&uuml;ssen leer sein</dd> <dt>Parameter 2</dt><dd>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</dd></dl> }',
    p_cat_pl_sql => q'{adc.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, false);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  adc_admin.merge_action_type(
    p_cat_id => 'XOR_NN',
    p_cat_ctg_id => 'ADC',
    p_cat_cif_id => 'NONE',
    p_cat_name => 'Genau einen Wert wählen, NOT_NULL',
    p_cat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p> </p><dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</dd> <dt>Parameter 2</dt><dd>Medlungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</dd></dl> }',
    p_cat_pl_sql => q'{adc.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, true);}',
    p_cat_js => q'{}',
    p_cat_is_editable => adc_util.C_FALSE,
    p_cat_raise_recursive => adc_util.C_TRUE);

    adc_admin.merge_action_parameter(
    p_cap_cat_id => 'XOR_NN',
    p_cap_cpt_id => 'JQUERY_SELECTOR',
    p_cap_sort_seq => 2,
    p_cap_default => q'{}',
    p_cap_description => q'{}',
    p_cap_display_name => '',
    p_cap_mandatory => adc_util.C_TRUE,
    p_cap_active => adc_util.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off