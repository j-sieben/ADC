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
    p_pti_name => q'^Alle Regelgruppen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Regelgruppen einer Anwendung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Regelgruppen einer Anwendungsseite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_CGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eine Regelgruppe^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPAC3D4D849D3D3917E8CC2606FF68F6E2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPBDA9160DDE5F6AEDB488FF32665A62D4',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Elementwert</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPBF769C85CC8DAB50F56D660ECB6B2FBA',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Einzublendende Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB0528533092E9D3F52D838938EB5930D',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB2D10702F0B0188397C2CA89A4BD944A',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Elementwert</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB62D45604A2D55BF5BCA1410CE0EF93B',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name des Seitenelements, in das die Auswahl des IG gespeichert werden soll.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB978A4138A030641A7462A678187CB20',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>REQUEST-Wert, kann optional &uuml;bergeben werden, ansonsten wird SUBMIT verwendet.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPC31B355C8A1EAEC903C714EB5D5B2296',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPDB647256162400B9E63FD2EFB18BFD90',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Meldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Meldungstext</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPDEB7F9B363DE45ED97D97891DF640704',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPD13D372C92172FF7A6D6DA4A430780CB',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPD2C15D4CFEC29ED0C5807C32D62C4000',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Nachricht^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Meldungstext</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPE181E6A716D6AD6D14BDFDB946CCA2F4',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPE61E3FD9A9FC0068E4CC62095FB0762E',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPFB17277D49BAFA7638B98C05D27A2838',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung der Seite  misslingt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPFD6AB926E62740D9CFBD2752874BD1FF',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0BD14564CB6FE907C6BC2DDE59CB5056',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0BFEE6E89A13BFD9D315FB56A4D4E651',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0EE72386778AC8E5A6C436E9D58BD4C2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>JavaScript-Anweisung, die ausgef&uuml;hrt werden soll. (ohne Semikolon)</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0689C597B72E1C3C1A68C4947E8E2406',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Elementwert</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP08B88A6421BF53E742982EC858694A66',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP117C7441334261A7FCBF4984E2AD73B4',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ordinalzahl der Wertespalte^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>1- basierte Ordinalzahl der Spalte, die im hinterlegten Element abgelegt werden soll. Die Reihenfolge richtet sich nach der Reihenfolge auf der APEX-Anwendungsseite.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP15E7057159CD40FF351530D05667BE60',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP177598894625ECABC760864A5E1C0A02',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP179D749A8A00A8832B7573AFA9E193F0',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Liste der Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte müssen leer sein</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP4F1E987BB2D9371305C1DC18A9AB0B82',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP4F360095CD75214AB35BF40E55ACA18C',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP50C16A7CCFAD2685DFE78533EA53813F',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name der Sequenz</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP531282FC2099B7CCD49D7CECADF2E905',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP611E99D4B894D68489A1060D4DE07C47',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt</br>Die Spaltenbezeichner m&uuml;ssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</dd>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP7C042712CDD7810589867BD3A08A6DD4',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP70D8A0B9EF3ADEB0DD9A2BD0E499A2A7',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP72850F551A3B5F37A7670B5EC081EA2B',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP729A6A7AABC066E08247DFCB3339D464',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Meldung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldung, die in der Bestätigungsmeldung angezeigt wird</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP75A4BB1CB653A11D97D845ABBB5CBDD3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP76ECA0290404F66846502EB78BBD4F76',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP7724DC6D811532DA8D522D3CEB2BAE8F',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP77504FC6F879315C6B0FBAB530A40C90',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP8B8771CE2BA0C22DCE51D389A2F21D25',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP80DBD593D7303BF0C1EFC308A40DB79E',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP82EEAF01903EBC85283DF7416D9ACADE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialogtitel^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Titel des Dialogfelds</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP86AC296FB638C95E539E775E307861E5',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Auszublendende Seitenelemente^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP88B0FC095F08F31DB49ABD31C39221E2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Wert, der gesetzt werden soll. Es stehen folgende Optionen zur Wahl:</p><ul><li>Konstante Zeichenkette, eingeschlossen in Hochkommata</li><li>JavaScript-Ausdruck, der clientseitig ausgewertet wird</li><li>NULL. In diesem Fall wird der aktuelle Sessionstatuswert des aktualisierten Seitenelements verwendet. Dieser Wert kann durch eine entsprechende Aktion vor Aufruf dieser Methode berechnet worden sein.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9BB1FC3515BD86A3FB1C8FD44C3FB34B',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Der Elementwert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9ECFCB015230C774FD6FFD4DC15A63A2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt.<br>Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP928CE4EFBA5F2EE3B4D691AEBFBA681E',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionale JavaScript-Aktion.<br>Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9459F044E685427FCFBB0536194ADF08',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9848E46D537D360B197740E74F10E043',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Meldungsname^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Medlungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_AFTER_REFRESH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ereignis "After Refresh" überwachen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registiert einen APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel AFTER_REFRESH = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CHECK_MANDATORY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Pflichtfelder prüfen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONFIRM_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche an Bestätigungsfrage binden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage best&auml;tigt wird, wird das Ereignis an ADC gemeldet.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DIALOG_CLOSED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ereignis "Dialog Close" überwachen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registiert einen APEXAfterDialogClose-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel DIALOG_CLOSED = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DISABLE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche deaktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Deaktiviert eine Schaltfl&auml;che. <br>Zum Deaktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld deaktivieren</span>.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DISABLE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel deaktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Deaktiviert das referenzierte Seitenelement.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DOUBLE_CLICK',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ereignis "Doppelklick" überwachen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registiert einen DoubleClick-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel DOUBLE_CLICK = &lt;Name des Seitenelements&gt; gefangen werden.&nbsp;<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DYNAMIC_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dynamisches JavaScript ausführen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Führt das übergebene JavaScript auf der Seite aus</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EMPTY_FIELD',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld leeren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENABLE_BUTTON',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Schaltfläche aktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Aktiviert eine Schaltfl&auml;che. Zum Aktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENABLE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel aktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Deaktiviert das referenzierte Seitenelement.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENTER_KEY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ereignis "Enter-Taste" überwachen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registiert einen Enter-Taste-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an ADC gemeldet und kann mit einer Regel ENTER_KEY = &lt;Name des Seitenelements&gt; gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_APEX_ACTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Befehl ausführen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Führt einen Befehl aus, der vorab als APEX-Aktion angelegt worden sein muss.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_ALLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Aktionstypen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Vom Benutzer angelegte und alle mitgelieferten Aktionstypen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_SYSTEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Integrierte Aktionstypen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Von ADC angelegte und mitgelieferte Aktionstypen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_USER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Selbsterstellte Aktionstypen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Vom Benutzer angelegte Aktionstypen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_GET_SEQ_VAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Sequenzwert ermitteln^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_IG_FILTER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Filterbank von IR/IG ausblenden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Blendet die Filterbank von Interactive Report/Grid aus.</p>
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel ausblenden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Blendet das referenzierte Seitenelement aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_DATE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld enthält Datum^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_MANDATORY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld ist Pflichtfeld^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_NUMERIC',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld enthält Zahl^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Pr&uuml;ft, ob ein Eingabefeld einen numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_OPTIONAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld ist optional^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ITEM_NULL_SHOW',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld leeren und aktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf NULL und zeigt es auf der Seite an.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_JAVA_SCRIPT_CODE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript-Code ausführen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_EDITABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^(nicht eiditierbar)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOTIFY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Benachrichtigung zeigen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Zeigt eine Nachricht auf der Anwendungsseite</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_NULL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Mindestens einen Wert wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut 1 einen Wert enthält.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_PLSQL_CODE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL-Code ausführen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_AND_SET_VALUE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld aktualisieren und Wert setzen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel aktualisieren (Refresh)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld-Event auslösen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_OBSERVER',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld beobachten^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Aktion beobachtet ein Feld oder eine Klasse und registriert die Elemente so, dass die entsprechenden Elementwerte bei jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_CONSOLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Nachricht auf Console ausgeben^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ELEMENT_FROM_STMT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Elementwert mit SQL-Anweisung setzen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_FOCUS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Focus in Feld setzen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Fokus in Eingabefeld der Seite setzen</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_IG_SELECTION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Auswahl in Feld speichern^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Legt die aktuell ausgewählten Zeilen-IDs im angegebenen Feld ab.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld auf Wert setzen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM_LABEL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feldbezeichner auf Wert setzen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt den Bezeichner des referenzierten Seitenelements auf den als Parameter übergebenen Wert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_NULL_DISABLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld leeren und deaktivieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_NULL_HIDE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld leeren und ausblenden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_VALUE_ONLY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Feld auf Wert setzen, keine Rekursion auslösen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Setzt das referenzierte Seitenelement auf den &uuml;bergebenen Wert, ohne weitere Rekursionen auszul&ouml;sen</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ERROR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Fehler anzeigen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ITEM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziel anzeigen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_TIP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hinweis anzeigen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>In der Meldungsregion einen Hinweis anzeigen</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_STOP_RULE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regel stoppen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SUBMIT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite absenden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Prüft alle Pflichtfelder und löst die Weiterlietung der Seite aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SUBMIT_WO_VALIDATION',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite absenden, keine Validierung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>L&ouml;st die Weiterleitung der Seite ohne vorherige Validierung aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_TOGGLE_ITEMS',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ziele ein- und ausblenden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten Parameter identifiziert werden, ein- und die Seitenelemente, die durch den zweiten Parameter identifiziert werden, ausgeblendet werden</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_VALIDATE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Seite validieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Prüft alle Pflichtfelder, löst aber keine Weiterleitung der Seite aus.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_WAIT_FOR_REFRESH',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Eieruhr zeigen, bis APEX-Refresh erfolgreich^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sorgt dafür, dass auf der Seite eine Eieruhr eingeblendet wird, bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen wurde.<br>Als Seitenelement muss die Region/das Element angegeben werden, auf dessen Aktuialisierung gewartet wird.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Genau einen Wert wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR_NN',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Genau einen Wert wählen, NOT_NULL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p>^'
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
    p_pti_id => 'SELECT_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Anwendungsseite wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_CGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regelgruppe wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Alle Regelgruppen exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regelgruppen der Anwendung "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regelgruppen der Anwendungsseite "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_CGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regelgruppe "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_REGION_HEADING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regelübersicht »#1#« (#2#)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

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
    p_pti_description => q'^<p>Wird der Wert mit einfachen Hochkommata &uuml;bergeben, wird er als konstanter Text ausgegeben.<br>Wird der Parameter ohne Hochkommata übergeben, wird er als PL/SQL-Funktkion interpretiert, die einen Wert liefert.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Zeichenkette oder JS-Ausdruck^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>^'
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
    p_pti_id => 'CRA_NO_HELP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Keine Hilfe vorhanden, bitte wählen Sie einen Aktionstypen.^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
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
    p_pti_id => 'CTG_ADC',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Allgemeine Aktionen^'
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
    p_pti_id => 'CRU_INITIAL_RULE_NAME',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^die Seite öffnet^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Bezeichner des automatisiert erzeugten Anwendungsfalls^'
  );

  commit;
end;
/

set define on