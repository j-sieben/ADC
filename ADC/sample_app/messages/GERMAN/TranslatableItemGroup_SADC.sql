set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'SADC',
    p_pmg_description => q'^Meldungen für die ADC Administrationsanwendung^');

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>Der Bericht erhält ein verstecktes Feld <span style="font-family:'Courier New', Courier, monospace;">P8_EMPLOYEE_ID</span>, das die aktuell ausgewählte ID des Berichts enthalten soll.</li><li>Der Bericht erhält eine statische ID (<span style="font-family:'Courier New', Courier, monospace;">R8_EMPLOYEE</span>), damit ADC weiß, dass Aktionen auf diese Region geplant sind und er einen eindeutigen Bezeichner für die Region erhält.</li><li>Die Schaltfläche erhält eine statische ID (<span style="font-family:'Courier New', Courier, monospace;">B8_EDIT_EMP</span>), damit ADC weiß, dass eine Aktion auf diese Schaltfläche geplant ist. Der Bezeichner dieser Schaltfläche is beliebig, er wird durch das Seitenkommando überschrieben. Als Aktion wird “Defined by Dynamic Action" gewählt.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ein Seitenkommando ist eine Aktivität, die über Schaltflächen, Menüs oder sonstige Auslöser ausgeführt werden kann. Im Gegensatz zum Absenden einer Seite bleibt die Anwendungsseite aber geladen. Ein Seitenkommando basiert auf APEX-Actions (nicht Dynamic Actions!), die unter einem technischen Bezeichner ein Label, Tastaturkürzel und den Status verwalten.&nbsp;</p><p>Seitenkommandos werden in ADC für unterschiedliche Zwecke verwendet. Sie gestatten eine einfache dynamische Kontrolle, so dass das Verhalten, aber auch der Status und das Label beliebig angepasst werden können.</p><p>Die Anwendungsseite demonstriert die Verwendung anhand einer Schaltfläche, die je nach gewähltem Mitarbeiter aus der Liste ein unterschiedliches Verhalten zeigt. Manager können nicht bearbeitet werden, während andere Mitarbeiter im Bezeichner der Schaltfläche angezeigt werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Bemerkungen</h3><p>Beim Rendern der Seite wird der aktuell ausgewählte Wert des Interactive Grids an ADC gemeldet.</p><p>Wird eine Änderung des Berichts an ADC gemeldet, wird ein PL/SQL-Code angestoßen, der das Seitenkommando <span style="font-family:'Courier New', Courier, monospace;">edit-employee</span> editiert. Dadurch können die Beschriftung sowie das Verhalten der Schaltfläche zum Bearbeiten des Mitarbeiters kontrolliert werden.&nbsp;</p><p>Im Beispiel wird ein modales Fenster zum Editieren des Mitarbeiters geöffnet, falls dies erlaubt ist, und die Schaltfläche deaktiviert und mit “nicht bearbeitbar” beschriftet, falls dies nicht erlaubt ist.</p><p>Die Methode zur Kontrolle des Seitenkommandos verwendet das Hilfspackage <span style="font-family:'Courier New', Courier, monospace;">ADC_APEX_ACTION</span>. Dabei wird die Aktion ausgewählt und anschließend das Verhalten kontrolliert:</p><p><span style="font-family:'Courier New', Courier, monospace;">adc_apex_action.<strong>action_init('edit-employee')</strong>;</span><br><span style="font-family:'Courier New', Courier, monospace;">if l_is_manager = 1 then</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.<strong>set_label</strong>('Nicht bearbeitbar');</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.<strong>set_disabled</strong>(true);</span><br><span style="font-family:'Courier New', Courier, monospace;">else</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.set_label(l_label);</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.set_disabled(false);</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.<strong>set_href</strong>(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; utl_apex.get_page_url(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_page =&gt; 'edemp',</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_param_items =&gt; 'P9_EMPLOYEE_ID',</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_value_list =&gt; l_employee_id,</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_triggering_element =&gt; 'B8_EDIT_EMP',</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_clear_cache =&gt; 9));</span><br><span style="font-family:'Courier New', Courier, monospace;">end if;</span><br><span style="font-family:'Courier New', Courier, monospace;">adc.add_javascript(<strong>adc_apex_action.get_action_script</strong>);</span></p><p>&nbsp;Nach Abschluss der Änderungen wird ein Skript an ADC übergeben, der die Kontrolle auf der Seite ausübt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADADC_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>Alle Seitenelemente: Attribut “Element ist Pflichtfeld” abgeschaltet</li><li>Datumsfeld und Zahlfeld mit Formatmaske ausgestattet, um automatische Erkennung zu ermöglichen</li><li>Pflichtfeld mit Label “<span style="font-family:'Courier New', Courier, monospace;">REQUIRED…</span>” ausgestattet (egal, welche Variante), um automatisches Erkennen zu aktivieren.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADANF_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>Alle Seitenelemente: Attribut “Element ist Pflichtfeld” abgeschaltet</li><li>Datumsfeld und Zahlfeld mit Formatmaske ausgestattet, um automatische Erkennung zu ermöglichen</li><li>Pflichtfeld nicht ausgezeichnet, da dies über einen Anwendungsfall erreicht wird.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADC_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Dynamische Seiten werden über ein zentrale Anwendung konfiguriert, die für alle APEX-Anwendungen des Workspaces Anwendungsfälle verwalten kann. In dieser Anwendung werden nicht nur die Anwendungsfälle für die dynamischen Seiten verwaltet, sondern auch alle Anwendungsfälle als SQL-Datei exportiert, so dass die Anwendungsfälle einfach ausgeliefert und skriptgesteuert auf andere Umgebungen (Test, Produktion) übertragen werden können.</p><p>Die folgende Schaltfläche öffnet die für diese Anwendungsseite zugehörige Bearbeitungsseite in der ADC Administrationsanwendung in einem neuen Tabulator.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADC_NO_RULES',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Die Anwendungsseite, auf der Sie sich gerade befinden, hat keine Anwendungsfälle definiert. Dennoch erscheint ein vordefinierter Anwendungsfall, wenn der Anwender die Seite öffnet. Beachten Sie die technische Bedingung. Sie referenziert eine Spalte <span style="font-family:'Courier New', Courier, monospace;">INITIALIZING</span>. Wird eine dynamische Seite initial gerendert, hat diese Spalte den Wert <span style="font-family:'Courier New', Courier, monospace;">C_TRUE</span>, ansonsten <span style="font-family:'Courier New', Courier, monospace;">C_FALSE</span>. Auch diese beiden Spalten stehen zur Erstellung von technischen Bedingungen zur Verfügung. Der Datentyp dieser Spalten ist im Package <span style="font-family:'Courier New', Courier, monospace;">ADC_UTIL</span> als <span style="font-family:'Courier New', Courier, monospace;">FLAG_TYPE</span> definiert. Wenn Sie Methoden entwickeln, die boolesche Entscheidungen treffen, ist es ebenfalls eine gute Idee, diesen Datentyp zurückgeben zu lassen, dann können auch Ihre Methoden auf diese Weise geprüft werden.</p><h3>Was kann eine dynamische Anwendungsseite ohne Anwendungsfälle?</h3><p>Eine dynamische Seite ohne Anwendungsfälle verhält sich bereits anders als eine statische Anwendungsseite. Probieren Sie diese Unterschiede im nachfolgenden Dialog aus. Pflichtfelder werden bereits dynamisch geprüft, und auch Datums- und Zahlfelder müssen korrekte Datums- oder Zahlangaben enthalten.&nbsp;</p><p>Diese Funktionalität ist möglich, weil</p><ul><li>Pflichtfelder auf der Anwendungsseite einen Labeltyp <span style="font-family:'Courier New', Courier, monospace;">REQUIRED</span> erhalten haben</li><li>Zahl- und Datumsfelder mittels Formatmasken kenntlich gemacht wurden</li><li>Formularregionen, die auf einer View oder Tabelle basieren, werden ebenfalls automatisch geprüft, wenn deren Spaltentyp als Zahl- oder Datumsfeld erkannt werden konnte.</li></ul><p>Bitte beachten Sie, dass bei Eingabefeldern auf dynamischen Anwendungsseiten das Attribut “Validation → Value Required” ausgeschaltet sein sollte, um nicht mit den Prüfungen der dynamischen Seite zu kollidieren.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADREP_PAGE1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Das interaktive Grid benötigt lediglich die Definition, welche der Spalten als Primärschlüsselspalte fungiert. Diese Spalte muss nicht visualisiert werden, da der Wert aus dem MODEL ermittelt wird, das unabhängig von der Visualisierung die benötigte Information enthält.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADREP_PAGE2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Beim interaktiven Report muss einer Spalte der HTML-Ausdruck</p><p><span style="font-family:'Courier New', Courier, monospace;">&lt;span data-id="#&lt;Primärschlüsselspalte"&gt;#&lt;belieibige Spalte&gt;#&lt;/span&gt;</span></p><p>mitgegeben werden, damit der Zugriff auf die Primärschlüsselinformation gelingt. Im Beispiel ist das in Spalte <span style="font-family:'Courier New', Courier, monospace;">EMP_FIRST_NAME</span> geschehen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADREP_PAGE3',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Auch beim klassischen Report muss einer Spalte der HTML-Ausdruck</p><p><span style="font-family:'Courier New', Courier, monospace;">&lt;span data-id="#&lt;Primärschlüsselspalte"&gt;#&lt;belieibige Spalte&gt;#&lt;/span&gt;</span></p><p>mitgegeben werden, damit der Zugriff auf die Primärschlüsselinformation gelingt. Im Beispiel ist das in Spalte <span style="font-family:'Courier New', Courier, monospace;">EMP_FIRST_NAME</span> geschehen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADREP_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Eine häufig benötigte Funktion besteht darin, erkennen zu können, welche Zeile eines Berichts ausgewählt wurde. ADC unterstützt diesen Vorgang mit einem eigenen Aktionstyp “Ausgewählte Zeile in Bericht melden”. &nbsp;Diese Aktion unterstützt Klassische Berichte ebenso wie interaktive Berichte und Grids und Hierarchien (Tree).</p><p>Auf welche Weise diese Information gewonnen werden kann, hängt von der Art des Berichts ab. Am einfachsten funktioniert dies bei interaktiven Grids und Trees, weil bei diesen beiden Berichten lediglich die statische ID des Berichts angegeben werden muss. Hier wird die Primärschlüsselspalte bzw. die ID-Spalte bei Hierarchien zurückgeliefert.</p><p>Die beiden älteren, anderen Berichtstypen verfügen nicht über diese Möglichkeit, sondern benötigen ein anderes Verfahren. Da dort keine Möglichkeit besteht, eine Primärschlüsselspalte deklarativ zu benennen, wird stattdessen eine Spalte mit einem Attribut <span style="font-family:'Courier New', Courier, monospace;">data-id</span> ausgestattet, das die Primärschlüsselinformation enthält. Im Beispiel wurde den Spalten Vorname jeweils ein HTML-Ausdruck beigefügt, der folgenden Inhalt enthält:</p><p><span style="font-family:'Courier New', Courier, monospace;">&lt;span data-id="#EMP_ID#"&gt;#EMP_FIRST_NAME#&lt;/span&gt;</span></p><p>Dieser Ausdruck kann in einer beliebigen Spalte eingefügt werden. Bei klassischen Berichten muss diese Spalte visualisiert werden.</p><p>Der ermittelte Wert kann, wie im Beispiel bei den ersten beiden Berichten, in ein Seitenelement abgelegt werden. Alternativ kann er direkt an ADC gemeldet werden, so dass kein verstecktes Element auf der Anwendungsseite erforderlich ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADREP_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Keine</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>Formularregion löst Erkennen von Zahl- und Datumsfeldern aus, keine Formatmaske erforderlich</li><li>Page Required-Attribut ausgeschaltet für alle Elemente</li><li>Required-Auszeichnung über Advanced - CSS-Klasse <span style="font-family:'Courier New', Courier, monospace;">sadc-mandatory</span> und entsprechende Aktion beim Laden der Seite</li><li>Welche Seitenelemente als Pflichtelemente bekannt sind, kann zusätzlich im Session State unter den Collections der aktuellen Seite eingesehen werden.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Neben der Validierung lässt sich der Status der Anwendungsseite über ADC kontrollieren. In Kombination ergeben sich dadurch mächtige Kontrollmöglichkeiten über die dynamische Seite.</p><p>In diesem Beispiel steuert die Auswahl des Berufs, ob ein Vertriebsbonus gezahlt werden darf oder nicht. Wird einer der <span style="font-family:'Courier New', Courier, monospace;">SALES</span>-Berufe gewählt, wird das Feld Vertriebsboni eingeblendet, zum Pflichtfeld gemacht und mit dem Standardsatz <span style="font-family:'Courier New', Courier, monospace;">0,3</span> vorbelegt.</p><p>Wird ein anderer Beruf gewählt, werden diese Einstellungen rückgängig gemacht. Beachten Sie, das, wie üblich, keinerlei Dynamic Actions auf der Anwendungsseite erforderlich sind. Die Pflichtfelder sind diesmal durch eine CSS-Klasse auf der Seite und eine Aktion beim Laden der Seite gekennzeichnet. Alternativ wäre auch der bislang genutzte Weg möglich gewesen. Das Beispiel zeigt jedoch die größere Flexibilität, denn basierend auf Initialisierungslogik können unterschiedliche Seitenelemente als Pflichtfeld ausgezeichnet werden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Bemerkungen</h3><p>Die Anwendungsfälle zur Kontrolle der Vertriebsboni zeigen ein Beispiel für eine Entscheidungsfunktion in der technischen Bedingung. Da alle relevanten Sessionwerte über entsprechende Spalten verfügbar sind, können diese auch an Funktionen übergeben werden. Die Funktion liefert ADC_UTIL.FLAG_TYPE zurück, so dass das Ergebnis einfach über die Spalte C_TRUE geprüft werden kann.</p><p>Im ersten Anwendungsfall wurde als zweite Aktion hinterlegt, dass die Anwendungsfälle, die sich auf das Eingabefeld P7_JOB_ID beziehen, ausgeführt werden sollen. Hierdurch wird erreicht, dass die beiden Anwendungsfälle geprüft und, bei erfüllter technischer Bedingung, auch direkt ausgeführt werden. Dadurch sind die Eingabefelder beim initialen Anzeigen der Seite korrekt eingestellt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADVAL_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Keine Änderungen gegenüber den Vorseiten</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ANF_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Betrachten Sie den unten angezeigten Dialog. Dieser Dialog ist bereits durch einfache Anwendungsfälle verändert worden. Diese Änderungen sind beim Öffnen der Anwendungsseite ausgeführt worden. Die Schaltlfäche bringt Sie zur entsprechenden Seite der ADC Administrationsanwendung in einem neuen Tab. Betrachten Sie die Aktionen des Anwendungsfalls “Wenn der Anwender die Seite öffnet”.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ANF_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Auch diesmal ist Feld “Pflichtfeld” ein Pflichtfeld, doch diesmal ist dies nicht durch das Label-Template REQUIRED, sondern durch eine Aktion beim Seitenladen eingerichtet worden. Zudem ist Feld “Datum” deaktiviert worden.</p><p>Sehen Sie sich an, auf welche Weise diese beiden Eigenschaften gesetzt wurden. Beachten Sie auch, dass das Pflichtfeld beim Löschen eines vorher eingetragenen Wertes eine abweichende Fehlermeldung liefert. Dies liegt daran, dass der Aktion “Feld ist Pflichtfeld” eine Fehlermeldung als Parameter hinzugefügt wurde. Dieser überschreibt die Standardmeldung. Wird dieser Parameter leer gelassen, erscheint wieder die Standardmeldung.</p><p>Es ist im Übrigen egal, auf welche Weise Sie ein Pflichtfeld definieren, in beiden Fällen ist diese Auszeichnung dynamisch änderbar. Möchten Sie, als Aktion eines anderen Anwendungsfalls, dass dieses Feld kein Pflichtfeld mehr ist, ist dies jederzeit möglich. ADC speichert die Liste der Pflichtfelder für jeden Benutzer in einer APEX Collection. Diese können Sie sich im Session Status auch ansehen.</p><h3>Aktivieren und Deaktivieren dynamischer Anwendungsseiten</h3><p>Sie können entweder die gesamte dynamische Anwendungsseite deaktivieren, indem Sie den Schalter “Aktiv” im Bereich “Dynamische Seite” ausschalten, oder aber einzelne Anwendungsfälle, indem Sie diesen Anwendungsfall bearbeiten und die entsprechende Option wählen. Ebenso können Sie einzelne Aktionen an- oder abschalten. Diese Fähigkeit ist sehr wichtig, wenn es um die Fehlersuche geht.</p><p>Testen Sie diese Möglichkeit, indem Sie zur ADC Administrationsanwendung gehen und die dynamische Seite deaktivieren. Kehren Sie zu dieser Seite zurück und laden Sie sie erneut. Sie sehen, dass weder das Feld “Pflichtfeld” ein Pflichtfeld ist, noch, dass das Feld Datum deaktiviert ist.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_INIT_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Bei komplexen Formularen kann es sinnvoll sein, einen Seitenmodus vorab zu berechnen und der Anwendungsseite zur Verfügung zu stellen. Die Initialisierung der Seite kann dann darauf reagieren und, je nach Seitenmodus, unterschiedliche Validierungsregeln anwenden.</p><p>Dieser modale Dialog besitzt ein verstecktes Feld <span style="font-family:'Courier New', Courier, monospace;">P16_PAGE_MODE,</span> das entweder den Wert <span style="font-family:'Courier New', Courier, monospace;">COMMISSION</span> enthalten kann oder auch nicht. Abhängig hiervon werden zusätzliche Initialisierungsregeln ausgeführt. In jedem Fall werden alle Eingabefelder, die die CSS-Klasse adc-mandatory besitzen, zu Pflichtfeldern gemacht.</p><p>Ist der Seitenmodus COMMISSION, wird zusätzlich das Feld Boni eingeblendet und zu einem Pflichtfeld, anderenfalls wird es ausgeblendet. Um dies zu erreichen, müssen weitere Seitenregeln ausgeführt werden. Diese erhalten eine entsprechende Prüfung (<span style="font-family:'Courier New', Courier, monospace;">initializing = C_TRUE and P16_PAGE_MODE = 'COMMISSION'</span>). Damit diese Regel zusätzlich zur normalen Initialisierungsregel ausgeführt wird, muss noch der Schalter “Bei Seite laden” gesetzt sein.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_OVERVIEW',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Übersicht über die APEX Dynamic Action (ADC) Beispielanwendung</h3>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_TEXT_MISSING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^<p>Text "#1#" ist nicht vorhanden.</p>^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_TUTORIAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Dieses Tutorial führt in die Verwendung von ADC in Ihren eigenen Anwendungen ein. Die Beispielseiten sind in aufsteigender Komplexität angeordnet und erläutern die Einbindung in die Anwendungsseite sowie die Verwendung der unterschiedlichen Features.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_USE_ADC',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>ADC wird als Dynamic Action Plugin ausgeliefert. Dieses Plugin müssen Sie zunächst in Ihre Anwendung importieren. Um ADC mit Ihren Seiten zu verwenden, haben Sie mehrere Möglichkeiten:</p><h3>Verwendung für eine spezifische Seite</h3><p>Wollen Sie nur wenige Seiten mit ADC kontrollieren, empfiehlt es sich, das Plugin auf den entsprechenden Anwendungsseiten beim Seiteladen (PageLoad) einzubinden. Das Plugin benötigt keine Parametrierung auf der Anwendungsseite.</p><h3>ADC auf allen Anwendungsseiten verwenden</h3><p>Alternativ kann das Plugin auf Seite 0 eingebunden werden und steht so auf allen Anwendungsseiten zur Verfügung. Dieser Weg bietet sich auch dann an, wenn Sie die meisten Seiten mit ADC kontrollieren, einige aber hiervon ausnehmen möchten. In diesem Fall fügen Sie eine serverseitige Bedingung hinzu, die die Ausführung des Plugins auf diesen Seiten unterbindet.</p><p>Diese Anwendung verwendet das Plugin auf die hier beschrieben Weise auf Seite 0.</p><h3>Anwendungsseite in ADC-Verwaltungsanwendung verfügbar machen</h3><p>Wenn Sie eine neue Seite eingefügt und auf einem der beschriebenen Wege ADC für diese Seite eingerichtet haben, müssen Sie diese Seite einmal ausführen, um sie in der ADC-Verwaltungsanwendung zu registrieren. Anschließend können Sie für diese Anwendungsseite Anwendungsfälle erfassen. Beachten Sie, dass auf der Anwendungsseite Seitenelemente vorhanden sein müssen, damit sinnvolle Anwendungsfälle erfasst werden können.</p><p>Beachten Sie auch, dass ADC nicht automatisch erkennen kann, ob Sie eine Seite in APEX geändert haben. Wenn Sie also zum Beispiel Seitenelemente hinzufügen oder löschen, müssen Sie anschließend einen Anwendungsfall dieser Seite in ADC öffnen und erneut speichern. Hierdurch wird die Dynamische Seite in ADC mit der APEX Anwendungsseite synchronisiert. Im Regelfall wird zunächst die APEX Anwendungsseite vollständig erstellt und erst danach mit der Erfassung der Anwendungsfälle begonnen.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Validierungen können als Anwendungsfall modelliert werden. Im unten stehenden Dialog darf nur ein Datum in der Zukunft eingegeben werden. Diese Validierung wurde erstellt, indem die technische Bedingung <span style="font-family:'Courier New', Courier, monospace;">P5_DATE &lt; SYSDATE</span> eingefügt wurde. Als Aktion soll in diesem Fall eine Fehlermeldung ausgegeben werden. Zudem muss eine Zahl zwischen 100 und 1000 liegen. Diese Bedingung wird analog als <span style="font-family:'Courier New', Courier, monospace;">P5_NUMBER not between 100 and 1000</span> formuliert.</p><p>Sie erkennen an der technischen Bedingung, dass die Eingabefelder umgewandelt wurden und als Datum bzw. Zahl zur Verfügung stehen, wenn eine Formatmaske hinterlegt wurde oder eine Formularregion den entsprechenden Datentyp erkannt hat.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Validierungen dieser Art sind in ihrer Leistungsfähigkeit recht begrenzt. Im weiteren Verlauf dieser Anwendung wird gezeigt, wie auch komplexere Validierungen einfach umgesetzt werden können.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL2_S1',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Um komplexere Validierungen einzurichten, werden PL/SQL-Methoden verwendet. Sie können diese Methoden bevorzugt als Prozeduren ausführen, die eventuelle Fehler an ADC melden. Hierzu steht im Package ADC die Methode ADC.REGISTER_ERROR zur Verfügung. Sie hat folgende Deklaration:</p><p><span style="font-family:'Courier New', Courier, monospace;">&nbsp; /** Method to register an error</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * %param &nbsp;p_cpi_id &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ID of the page item that is referenced by the error (or DOCUMENT)</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * %param &nbsp;p_error_msg &nbsp; &nbsp; &nbsp; Error message to register</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * %param [p_internal_error] Optional additional information, visible for developers</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * %usage &nbsp;Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * &nbsp; &nbsp; &nbsp; &nbsp; consequence of an internal error.</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; */</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp;procedure register_error(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_cpi_id in adc_page_items.cpi_id%type,</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_error_msg in varchar2,</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_internal_error in varchar2 default null);</span></p><p>Es existiert zudem eine Überladung für PIT-Messages. Übergeben Sie innerhalb der Prozedur Fehler an ADC, ist das identisch zu einer Aktion vom Typ “Fehler anzeigen”, die wir in den einfachen Validierungsbeispielen verwendet haben.</p><p>Prozeduren sind hingegen ungleich leistungsfähiger, weil sie die gesamte Bandbreite konditionaler Logik sowie beliebig komplexe Validierungslogik ausführen können.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL2_S2',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Die Verwendung von Prozeduren zur Validierung sollte das Standardverfahren darstellen, um die technischen Bedingungen nicht unnötig komplex werden zu lassen. Die technische Bedingung ist hier nur noch dafür zuständig, zu ermitteln, wann eine Validierung ausgeführt werden soll, während die Prozedur die eigentliche Validierung ausführt.</p><p>Als Alternative zu diesem Vorgehen ist es natürlich auch möglich, in der technischen Bedingung eine Funktion aufzurufen, die entscheidet, ob eine Validierung erforderlich ist oder nicht. Diese Strategie wird insbesondere zur Statuskontrolle verwendet, die wir auf der nächsten Anwendungsseite untersuchen.</p>^'
  );

  commit;
end;
/

set define on