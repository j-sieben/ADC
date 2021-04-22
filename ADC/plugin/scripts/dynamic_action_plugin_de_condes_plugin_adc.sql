prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>14500363782405926
,p_default_application_id=>120
,p_default_id_offset=>126382688010832348
,p_default_owner=>'APEX_APP'
);
end;
/
 
prompt APPLICATION 120 - ADC-Administration
--
-- Application Export:
--   Application:     120
--   Name:            ADC-Administration
--   Date and Time:   09:35 Sunday March 14, 2021
--   Exported By:     APP_ADMIN
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 42787276973501415070
--   Manifest End
--   Version:         20.2.0.00.20
--   Instance ID:     300130950197729
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_condes_plugin_adc
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(42787276973501415070)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.CONDES.PLUGIN.ADC'
,p_display_name=>'APEX Dymnamic Controller'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/de/condes/plugin/adc/js/adc.js',
'/de/condes/plugin/adc/js/adcApex.js'))
,p_css_file_urls=>'/de/condes/plugin/adc/css/adc.css'
,p_api_version=>1
,p_render_function=>'plugin_adc.render'
,p_ajax_function=>'plugin_adc.ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Plugin APEX Dymnamic Controller</h2>',
'<p>Das Plugin vereinfacht die Verwaltung von Formularen auf einer ',
'Seite.<br/>Folgende Funktionen sind implementiert:</p>',
unistr('<ul><li>Es k\00F6nnen Regeln definiert werden, die steuern, ob Elemente auf '),
'der Seite angezeigt werden oder nicht</li>',
unistr('  <li>Elemente k\00F6nnen regelbasiert zu Pflichtfeldern erkl\00E4rt und gepr\00FCft '),
'werden</li>',
unistr('  <li>Regeln k\00F6nnen Validierungs- oder Initialisierungscode auf der '),
'Datenbank aufrufen</li>',
unistr('  <li>Regeln werden automatisch rekursiv aufgel\00F6st und rduzieren so die '),
unistr('Anzahl der ben\00F6tigten Regeln</li>'),
'  <li>Treten Fehler bei der Initialisierung, Berechnung oder Validierung ',
'von Werten auf, werden diese dynamisch auf die Seite integriert</li>',
'</ul>',
'<p>Regeln werden innerhalb von Tabellen in der Datenbank abgelegt. Diese ',
unistr('Regeln k\00F6nnen durch eine eigene APEX-Anwendung verwaltet werden und '),
unistr('anwendungs\00FCbergreifend eingesetzt werden.</p>')))
,p_version_identifier=>'1.0'
,p_files_version=>33
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(298358096925498499)
,p_plugin_id=>wwv_flow_api.id(42787276973501415070)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'ADC-Apexfunktionen'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'de.condes.plugin.adc.apex_42_20_2'
,p_display_length=>40
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>ADC-APEX functions</h2>',
'<p>This parameter defines the namespace of the JavaScript functionality that is required for the ADC.</p>',
'<p>By default <pre>de.condes.plugin.adc.apex_42_20_2</pre> will be used and supplied with the plugin. The naming scheme refers to theme 42, apex version 20.2.<br>There is also an older version available named <pre>de.condes.plugin.adc.apex_42_5_1</pr'
||'e>.</p>',
'<p>If these functions do not fit the theme you are using, you can create your own copy of this file and customize it.</p>',
'<p>Make sure that the public functions implemented in the supplied adcApex.js file are also present in your implementation.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(298358540634498499)
,p_plugin_id=>wwv_flow_api.id(42787276973501415070)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Kommentare ausgeben'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>ADC-APEX-Funktionen</h2><p>Das Flag legt fest, ob das ',
unistr('ADC Kommentare \00FCber die Konsole ausgibt oder nicht.<br>Kommentare sind '),
unistr('w\00E4hrend der Entwicklung sinnvoll, k\00F6nnen aber die Menge Informationen, die '),
unistr('bei jedem Roundtrip zum Server ausgetauscht werden m\00FCssen, stark erh\00F6hen. Daher sollte diese Einstellung f\00FCr TEST und '),
'PROD auf NEIN stehen.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(298358912921498500)
,p_plugin_id=>wwv_flow_api.id(42787276973501415070)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Name der Regelgruppe'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_display_length=>30
,p_max_length=>50
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Geben Sie hier den Namen der Regelgruppe ein, die f\00FCr dieses '),
'Plugin genutzt werden soll.'))
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
