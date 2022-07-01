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
,p_default_workspace_id=>37000359328590246
,p_default_application_id=>118
,p_default_id_offset=>111073935907048253
,p_default_owner=>'ADC_APP'
);
end;
/
 
prompt APPLICATION 118 - ADC Beispielanwendung
--
-- Application Export:
--   Application:     118
--   Name:            ADC Beispielanwendung
--   Exported By:     ADC_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     20
--       Items:                   55
--       Validations:              1
--       Processes:               11
--       Regions:                 78
--       Buttons:                 40
--       Dynamic Actions:          4
--     Shared Components:
--       Logic:
--         Items:                  7
--         Processes:              1
--         Computations:           1
--       Navigation:
--         Lists:                  7
--         Breadcrumbs:            1
--           Entries:             15
--       Security:
--         Authentication:         1
--         Authorization:          1
--       User Interface:
--         Themes:                 1
--         Templates:
--           Page:                 9
--           Region:              17
--           Label:                7
--           List:                13
--           Popup LOV:            1
--           Calendar:             1
--           Breadcrumb:           1
--           Button:               3
--           Report:              11
--         LOVs:                   3
--         Shortcuts:              1
--         Plug-ins:               1
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Excluded
--   Version:         20.2.0.00.20
--   Instance ID:     300130950197729
--

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'ADC_APP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'ADC Beispielanwendung')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'SADC')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'7B8E32C477A6C45E3C00784C24FE590D9F8A06675E9A716DBA13207419F8FD55'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'19.2'
,p_flow_language=>'de'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_date_time_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>'Application created from create application wizard 2021.05.08.'
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(184777620953718818)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'ADC Beispielanwendung'
,p_app_builder_icon_name=>'app-icon.svg'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'ADC Beispielanwendung'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220122102719'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>3
,p_ui_type_name => null
,p_print_server_type=>'NATIVE'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(184778339284718821)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184928081257718968)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Startseite'
,p_list_item_link_target=>'f?p=&APP_ID.:home:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(202108806527146957)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Tutorial'
,p_list_item_link_target=>'f?p=&APP_ID.:tutorial:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user-graduate'
,p_parent_list_item_id=>wwv_flow_api.id(184928081257718968)
,p_list_text_01=>unistr('Einf\00FChrung in die Verwendung von ADC')
,p_list_text_02=>unistr('Schritt-f\00FCr-Schritt-Anweisungen zur Verwendung von ADC in Ihren Anwendungen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'12'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184946909226927779)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Anwendungstexte verwalten'
,p_list_item_link_target=>'f?p=&APP_ID.:adpti:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_security_scheme=>wwv_flow_api.id(184920660891718940)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'100,101'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184978551295510831)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'ADC verwenden'
,p_list_item_link_target=>'f?p=&APP_ID.:useadc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Referenzierungsm\00F6glichkeiten des Plugins auf dynamischen Seiten')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184982743888590045)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'ADC Administrationsanwendung'
,p_list_item_link_target=>'f?p=&APP_ID.:adadc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Einf\00FChrung der zentralen ADC-Administrationsanwendung')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184994683102533751)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>unistr('Einfache Anwendungsf\00E4lle')
,p_list_item_link_target=>'f?p=&APP_ID.:adanf:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Zeigt, wie Pflichtfelder generiert und Felder ausgeblendet werden k\00F6nnen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'4'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(185015476961899962)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Einfache Validierungen'
,p_list_item_link_target=>'f?p=&APP_ID.:adval:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Einfache Validierungen mittels Anwendungsf\00E4llen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'5'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(185276853178461924)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Komplexere Validierungen'
,p_list_item_link_target=>'f?p=&APP_ID.:adval2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>'Validierung von Eingaben mit zentraler Validierungslogik in Packages'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'6'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(185575698272215870)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Kontrolle des Seitenstatus'
,p_list_item_link_target=>'f?p=&APP_ID.:adsta:&SESSION.::&DEBUG.::P7_EMPLOYEE_ID:106:'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Implementierung von Anwendungsf\00E4llen in einem Mitarbeiter-Dialog')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'7'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(202365742288396646)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'Zeile in Bericht erkennen'
,p_list_item_link_target=>'f?p=&APP_ID.:ADREP:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Ausge\00E4hlte Zeile eines Berichts erkennen und darauf reagieren')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(190675370583401674)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Seitenkommandos'
,p_list_item_link_target=>'f?p=&APP_ID.:adact:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(202108806527146957)
,p_list_text_01=>unistr('Erl\00E4uterungen zum Einsatz von Seitenkommandos')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'8'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(202780764646783557)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Dokumentation'
,p_list_item_link_target=>'f?p=&APP_ID.:doc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bookmark-o'
,p_parent_list_item_id=>wwv_flow_api.id(184928081257718968)
,p_list_text_01=>'Technische Informationen'
,p_list_text_02=>unistr('\00DCbersicht \00FCber verf\00FCgbare Aktionstypen, Pseudospalten und weiteres')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'13'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(194783365701538409)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_list_item_link_target=>'f?p=&APP_ID.:pseudo:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-columns'
,p_parent_list_item_id=>wwv_flow_api.id(202780764646783557)
,p_list_text_01=>unistr('\00DCbersicht \00FCber die Pseudospalten f\00FCr Anwendungsf\00E4lle')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'11'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(202976981398300231)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Mitgelieferte Aktionstypen'
,p_list_item_link_target=>'f?p=&APP_ID.:menu_cat:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bolt'
,p_parent_list_item_id=>wwv_flow_api.id(202780764646783557)
,p_list_text_01=>unistr('\00DCbersicht \00FCber die Aktionstypen von ADC')
,p_list_text_02=>'Beschreibt die Verwendung aller mitgelieferter ADC-Aktionstypen'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'14'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(203076403679771306)
,p_list_item_display_sequence=>160
,p_list_item_link_text=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_list_item_link_target=>'f?p=&APP_ID.:cat_page_item:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bolt'
,p_parent_list_item_id=>wwv_flow_api.id(202976981398300231)
,p_list_text_01=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_list_text_02=>'Manipulation der Sichtbarkeit, Pflichtstatus, Label etc.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'15'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(184917801308718920)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184929559109718976)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184929999763718976)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_api.id(184929559109718976)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(184930390184718976)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_api.id(184929559109718976)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/main_page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(188574665870377246)
,p_name=>'Main Page Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_home'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/navigation/lists/tutorial_page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(202782112055876940)
,p_name=>'Tutorial Page Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_tutorial'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/navigation/lists/documentation_page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(202787804278054153)
,p_name=>'Documentation Page Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_doc'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/navigation/lists/actiontype_page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(203075206277756651)
,p_name=>'ActionType Page Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_menu_cat'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/navigation/lists/actiontypedetail_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(207475595209610981)
,p_name=>'ActionTypeDetail Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_menu_catitems',
' WHERE cat_ctg_id = (select replace(v(''APP_PAGE_ALIAS''), ''CAT_'') from dual)'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/files/app_icon_svg
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3C73766720786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F737667222076696577426F783D22302030203634203634222077696474683D22363422206865696768743D223634223E3C726563742077696474683D2231303025';
wwv_flow_api.g_varchar2_table(2) := '22206865696768743D2231303025222066696C6C3D222345443831334522202F3E3C67206F7061636974793D222E32223E3C7061746820643D224D333220323661322E3520322E3520302031203020322E3520322E3541322E35303320322E3530332030';
wwv_flow_api.g_varchar2_table(3) := '203020302033322032367A6D30203461312E3520312E3520302031203120312E352D312E3541312E35303220312E3530322030203020312033322033307A222F3E3C7061746820643D224D34322E3533362033362E3832386C2D322E3637332D322E3637';
wwv_flow_api.g_varchar2_table(4) := '324131382E3937332031382E39373320302030203020343020333263302D352E3835352D322E3732332D31312E3439332D372E3636382D31352E383734612E352E352030203020302D2E36363420304332362E3732332032302E3530372032342032362E';
wwv_flow_api.g_varchar2_table(5) := '3134352032342033326131382E3937332031382E393733203020302030202E31333720322E3135366C2D322E36373320322E36373341342E39363720342E3936372030203020302032302034302E3336345634372E35612E352E35203020302030202E35';
wwv_flow_api.g_varchar2_table(6) := '2E3568312E30373561332E30303220332E30303220302030203020312E3935322D2E3732326C342E332D332E363835632E3431312E3538322E38343720312E31353520312E33323220312E37313261322E30303120322E30303120302030203020312E35';
wwv_flow_api.g_varchar2_table(7) := '32372E363935682E38323476312E35612E352E3520302030203020312030563436682E38323461322E30303120322E30303120302030203020312E3532372D2E3639352032332E37382032332E373820302030203020312E3332332D312E3731326C342E';
wwv_flow_api.g_varchar2_table(8) := '32393820332E36383461332E30303220332E30303220302030203020312E3935332E3732334834332E35612E352E35203020302030202E352D2E35762D372E31333661342E393720342E39372030203020302D312E3436342D332E3533367A4D33322031';
wwv_flow_api.g_varchar2_table(9) := '372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E3839372030203020312033322031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E33';
wwv_flow_api.g_varchar2_table(10) := '2E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E33303120302030203020322E39353920372E3335377A6D31312E3231342D312E383633';
wwv_flow_api.g_varchar2_table(11) := '61312E30313420312E3031342030203020312D2E3736362E3334344833322E35762D392E35612E352E352030203020302D312030563435682D2E38323461312E30313420312E3031342030203020312D2E3736362D2E3334344131392E342031392E3420';
wwv_flow_api.g_varchar2_table(12) := '30203020312032352033326131382E3434362031382E34343620302030203120312E3835382D386831302E3238344131382E3434362031382E3434362030203020312033392033326131392E342031392E342030203020312D342E39312031322E363536';
wwv_flow_api.g_varchar2_table(13) := '7A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E313420322E313441332E39373520332E393735203020';
wwv_flow_api.g_varchar2_table(14) := '3020312034332034302E3336347A222F3E3C2F673E3C7061746820643D224D33322031372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E383937203020302031203332';
wwv_flow_api.g_varchar2_table(15) := '2031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E332E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E';
wwv_flow_api.g_varchar2_table(16) := '33303120302030203020322E39353920372E3335377A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E31';
wwv_flow_api.g_varchar2_table(17) := '3420322E313441332E39373520332E3937352030203020312034332034302E3336347A222066696C6C3D222366636662666122206F7061636974793D222E34222F3E3C7061746820643D224D33372E3134322032344832362E3835384131382E34343620';
wwv_flow_api.g_varchar2_table(18) := '31382E3434362030203020302032352033326131392E342031392E3420302030203020342E39312031322E36353620312E30313420312E303134203020302030202E3736362E333434682E383234762D392E35612E352E35203020302031203120305634';
wwv_flow_api.g_varchar2_table(19) := '35682E38323461312E30313420312E303134203020302030202E3736362D2E3334344131392E342031392E342030203020302033392033326131382E3434362031382E3434362030203020302D312E3835382D387A4D333220333161322E3520322E3520';
wwv_flow_api.g_varchar2_table(20) := '302031203120322E352D322E3541322E35303320322E3530332030203020312033322033317A222066696C6C3D222366666622206F7061636974793D222E3935222F3E3C7061746820643D224D333220333061312E3520312E3520302031203120312E35';
wwv_flow_api.g_varchar2_table(21) := '2D312E3541312E35303220312E3530322030203020312033322033307A222066696C6C3D222366636662666122206F7061636974793D222E36222F3E3C2F7376673E';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(184919110013718938)
,p_file_name=>'app-icon.svg'
,p_mime_type=>'image/svg+xml'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/app_icon_css
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6170702D69636F6E207B0A202020206261636B67726F756E642D696D6167653A2075726C286170702D69636F6E2E737667293B0A202020206261636B67726F756E642D7265706561743A206E6F2D7265706561743B0A202020206261636B67726F756E';
wwv_flow_api.g_varchar2_table(2) := '642D73697A653A20636F7665723B0A202020206261636B67726F756E642D706F736974696F6E3A203530253B0A202020206261636B67726F756E642D636F6C6F723A20234544383133453B0A7D';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(184919423329718940)
,p_file_name=>'app-icon.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184775142942718815)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184775449900718818)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184775750702718818)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184776088512718818)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184776361786718818)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'modern'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184776639328718818)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184776954652718818)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184777247523718818)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(184933503952734235)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'PLUGIN_DE.CONDES.PLUGIN.ADC'
,p_attribute_01=>'de.condes.plugin.adc.apex_42_20_2'
,p_attribute_02=>'Y'
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(184920660891718940)
,p_name=>'Administration Rights'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'ADC_SUPERVISOR'
,p_attribute_02=>'A'
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_processes/get_prev_next_target
begin
wwv_flow_api.create_flow_process(
 p_id=>wwv_flow_api.id(190475448040116651)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_PREV_NEXT_TARGET'
,p_process_sql_clob=>'sadc_ui.calculate_prev_next;'
,p_process_clob_language=>'PLSQL'
,p_process_when=>'1,101,9999'
,p_process_when_type=>'CURRENT_PAGE_NOT_IN_CONDITION'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_adc_url
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(185002145359636090)
,p_name=>'SADC_ADC_URL'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_id
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(202274978449771009)
,p_name=>'SADC_NEXT_ID'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_target
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(188875247032384192)
,p_name=>'SADC_NEXT_TARGET'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_title
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(188874849065380621)
,p_name=>'SADC_NEXT_TITLE'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_id
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(202275146743771848)
,p_name=>'SADC_PREV_ID'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_target
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(188874640156378609)
,p_name=>'SADC_PREV_TARGET'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_title
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(188874490148377656)
,p_name=>'SADC_PREV_TITLE'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_computations/sadc_adc_url
begin
wwv_flow_api.create_flow_computation(
 p_id=>wwv_flow_api.id(185002559646641054)
,p_computation_sequence=>10
,p_computation_item=>'SADC_ADC_URL'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation_language=>'PLSQL'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>'return sadc_ui.get_adc_admin_url;'
);
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/login_remember_username
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(184923291533718954)
,p_lov_name=>'LOGIN_REMEMBER_USERNAME'
,p_lov_query=>'.'||wwv_flow_api.id(184923291533718954)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(184923658863718957)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Remember username'
,p_lov_return_value=>'Y'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_departments
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(185586343731266631)
,p_lov_name=>'LOV_DEPARTMENTS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'SADC_LOV_DEPARTMENT'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_jobs
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(185586230465264690)
,p_lov_name=>'LOV_JOBS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'SADC_LOV_JOB'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_default_sort_column_name=>'D'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(184921301414718942)
,p_group_name=>'Administration'
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(184777846050718820)
,p_name=>'Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(184778055770718820)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(184976259660440745)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Anwendungstexte verwalten'
,p_link=>'f?p=&APP_ID.:ADPTI:&SESSION.::&DEBUG.:100::'
,p_page_id=>100
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(184979472789510834)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'ADC verwenden'
,p_link=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(184984949808590051)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'ADC Administrationsanwendung'
,p_link=>'f?p=&APP_ID.:ADADC:&SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(184999039332533770)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(185019848905899978)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Einfache Validierungen'
,p_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(185281326491461943)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Komplexere Validierungen'
,p_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:::'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(185579956278215887)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Kontrolle des Seitenstatus'
,p_link=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(190687011409401698)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Seitenkommandos'
,p_link=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(194785576722538410)
,p_parent_id=>wwv_flow_api.id(202786722532048023)
,p_short_name=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(202370496308416831)
,p_parent_id=>wwv_flow_api.id(202778389683762770)
,p_short_name=>'Zeile eines Berichts erkennen'
,p_link=>'f?p=&APP_ID.:ADREP:&SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(202778389683762770)
,p_parent_id=>wwv_flow_api.id(184778055770718820)
,p_short_name=>'Tutorial'
,p_link=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(202786722532048023)
,p_parent_id=>wwv_flow_api.id(184778055770718820)
,p_short_name=>'Dokumentation'
,p_link=>'f?p=&APP_ID.:13:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>13
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(202977930986300243)
,p_parent_id=>wwv_flow_api.id(202786722532048023)
,p_short_name=>'Mitgelieferte Aktionstypen'
,p_link=>'f?p=&APP_ID.:menu_cat:&SESSION.::&DEBUG.:::'
,p_page_id=>14
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(203077290974771310)
,p_parent_id=>wwv_flow_api.id(202977930986300243)
,p_short_name=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_link=>'f?p=&APP_ID.:15:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>15
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/templates/page/left_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184778683413718824)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184778985294718829)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184779273092718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184779615747718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184779904367718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184780152375718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184780461349718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184780745321718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184781126032718832)
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_and_right_side_columns
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184781523847718835)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184781783305718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184782117763718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184782391529718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184782660449718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184782965864718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184783295157718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184783557915718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184783893198718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184784208270718835)
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
end;
/
prompt --application/shared_components/user_interface/templates/page/minimal_no_navigation
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184784630220718835)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184784896738718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184785166207718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184785458471718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184785777765718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184786126742718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184786343720718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184786711944718837)
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/right_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184787110679718837)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" aria-label="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button'
||'>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184787355917718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184787675004718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184787967237718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184788327017718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184788555129718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184788934230718837)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184789197885718838)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184789528538718838)
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/wizard_modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184789844865718838)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184790233822718838)
,p_page_template_id=>wwv_flow_api.id(184789844865718838)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184790442698718838)
,p_page_template_id=>wwv_flow_api.id(184789844865718838)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184790818249718838)
,p_page_template_id=>wwv_flow_api.id(184789844865718838)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/login
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184791415420718838)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-container">',
'  <header class="t-Login-containerHeader">#REGION_POSITION_01#</header>',
'  <main class="t-Login-containerBody" id="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</main>',
'  <footer class="t-Login-containerFooter">#REGION_POSITION_02#</footer>',
'</div>',
''))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184791676048718838)
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184791988623718838)
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184792319064718838)
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/master_detail
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184793726028718840)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'))
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-info" id="t_Body_info">#REGION_POSITION_02#</div>',
'        <div class="t-Body-contentInner" role="main">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184793973665718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184794284910718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184794569789718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184794908489718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184795177151718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184795493160718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184795774729718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184796110250718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184796388007718842)
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184796753255718842)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184797040941718845)
,p_page_template_id=>wwv_flow_api.id(184796753255718842)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184797397766718845)
,p_page_template_id=>wwv_flow_api.id(184796753255718842)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184797650071718845)
,p_page_template_id=>wwv_flow_api.id(184796753255718842)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/standard
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(184798239728718845)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184798560118718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184798850138718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184799169246718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184799445562718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184799800446718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184800069800718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(184800398484718845)
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/button/icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(184894717568718890)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(184895376012718892)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text_with_icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(184895472618718892)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region/alert
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184800776485718846)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY#</div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184801128988718848)
,p_plug_template_id=>wwv_flow_api.id(184800776485718846)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184804474632718848)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes_no_grid
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184804727648718848)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184804966153718848)
,p_plug_template_id=>wwv_flow_api.id(184804727648718848)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184805301302718849)
,p_plug_template_id=>wwv_flow_api.id(184804727648718848)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/carousel_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184805512744718849)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'))
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184805769160718849)
,p_plug_template_id=>wwv_flow_api.id(184805512744718849)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184806102438718849)
,p_plug_template_id=>wwv_flow_api.id(184805512744718849)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/content_block
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184812851368718853)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header">',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--title">',
'      <span class="t-ContentBlock-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'      <h1 class="t-ContentBlock-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'      #EDIT#',
'    </div>',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--buttons">#CHANGE#</div>',
'  </div>',
'  <div class="t-ContentBlock-body">#BODY#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>',
''))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/buttons_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184814885421718853)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184815221170718853)
,p_plug_template_id=>wwv_flow_api.id(184814885421718853)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184815533967718854)
,p_plug_template_id=>wwv_flow_api.id(184814885421718853)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/cards_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184816918098718854)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-CardsRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  #BODY##SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Cards Container'
,p_internal_name=>'CARDS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>21
,p_default_template_options=>'u-colors'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2071277712695139743
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/collapsible
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184817841652718854)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls"><button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button></div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184818221210718854)
,p_plug_template_id=>wwv_flow_api.id(184817841652718854)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184818448754718854)
,p_plug_template_id=>wwv_flow_api.id(184817841652718854)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/hero
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184823236456718856)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h1 class="t-HeroRegion-title">#TITLE#</h1>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184823577615718856)
,p_plug_template_id=>wwv_flow_api.id(184823236456718856)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_dialog
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184825342218718859)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184825720712718859)
,p_plug_template_id=>wwv_flow_api.id(184825342218718859)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_popup
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184827694575718859)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionPopup" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Popup'
,p_internal_name=>'INLINE_POPUP'
,p_theme_id=>42
,p_theme_class_id=>24
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1483922538999385230
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184827973307718859)
,p_plug_template_id=>wwv_flow_api.id(184827694575718859)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/interactive_report
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184830956519718859)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/login
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184831610247718859)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">#BODY#</div>',
'  <div class="t-Login-buttons">#NEXT#</div>',
'  <div class="t-Login-links">#EDIT##CREATE#</div>',
'  <div class="t-Login-subRegions">#SUB_REGIONS#</div>',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184831876987718859)
,p_plug_template_id=>wwv_flow_api.id(184831610247718859)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/standard
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184832857644718859)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184833146197718862)
,p_plug_template_id=>wwv_flow_api.id(184832857644718859)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184833533340718862)
,p_plug_template_id=>wwv_flow_api.id(184832857644718859)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/tabs_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184839647364718863)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES# apex-tabs-region" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184839969640718863)
,p_plug_template_id=>wwv_flow_api.id(184839647364718863)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184840330520718863)
,p_plug_template_id=>wwv_flow_api.id(184839647364718863)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/title_bar
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184842319708718863)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/wizard_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(184843298036718863)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(184843627510718863)
,p_plug_template_id=>wwv_flow_api.id(184843298036718863)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184868558625718876)
,p_list_template_current=>'<li class="t-NavTabs-item #A03# is-active" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class'
||'="t-NavTabs-badge #A05#">#A02#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-NavTabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class="t-NavTab'
||'s-badge #A05#">#A02#</span></a></li>'
,p_list_template_name=>'Top Navigation Tabs'
,p_internal_name=>'TOP_NAVIGATION_TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-NavTabs--inlineLabels-lg:t-NavTabs--displayLabels-sm'
,p_list_template_before_rows=>'<ul class="t-NavTabs #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_navtabs">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a02_label=>'Badge Value'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_a05_label=>'Badge Class'
,p_reference_id=>1453011561172885578
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_mega_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184870177338718878)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_name=>'Top Navigation Mega Menu'
,p_internal_name=>'TOP_NAVIGATION_MEGA_MENU'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-MegaMenu #COMPONENT_CSS_CLASSES#" id="t_MenuNav" style="display:none;">',
'  <div class="a-Menu-content t-MegaMenu-container">',
'    <div class="t-MegaMenu-body">',
'    <ul class="t-MegaMenu-list t-MegaMenu-list--top">'))
,p_list_template_after_rows=>' </ul></div></div></div>'
,p_before_sub_list=>'<ul class="t-MegaMenu-list t-MegaMenu-list--sub">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_list_item_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_sub_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Description'
,p_a04_label=>'List Item Class'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_a07_label=>'Badge Class'
,p_a08_label=>'Menu Item Class'
,p_reference_id=>1665447133514362075
);
end;
/
prompt --application/shared_components/user_interface/templates/list/wizard_progress
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184872340605718879)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></'
||'div></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>',
''))
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184873750829718879)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>2008709236185638887
);
end;
/
prompt --application/shared_components/user_interface/templates/list/badge_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184874794682718881)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--cols t-BadgeList--3cols:t-BadgeList--circular'
,p_list_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'Link Classes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
end;
/
prompt --application/shared_components/user_interface/templates/list/media_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184878577047718884)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
end;
/
prompt --application/shared_components/user_interface/templates/list/side_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184881536539718885)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_default_template_options=>'js-defaultCollapsed'
,p_preset_template_options=>'js-navCollapsed--hidden:t-TreeNav--styleA'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2466292414354694776
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184883379000718885)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("#t_MenuNav", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="t_MenuNav"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/list/navigation_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184884345305718885)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_a04_label=>'Title Attribute'
,p_reference_id=>2846096252961119197
);
end;
/
prompt --application/shared_components/user_interface/templates/list/cards
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184884829661718885)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item is-active #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_a07_label=>'Subtitle'
,p_reference_id=>2885322685880632508
);
end;
/
prompt --application/shared_components/user_interface/templates/list/tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184890192364718888)
,p_list_template_current=>'<li class="t-Tabs-item is-active #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_reference_id=>3288206686691809997
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_popup
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184891793828718888)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ iconType: ''fa'', callout: e.hasClass("js-menu-callout")});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>3492264004432431646
);
end;
/
prompt --application/shared_components/user_interface/templates/list/links_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(184892339769718888)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
end;
/
prompt --application/shared_components/user_interface/templates/report/alerts
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184844562920718865)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_alerts" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/badge_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184844774653718867)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
' <span class="t-BadgeList-wrap u-color">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
' </span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed:t-BadgeList--circular'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/cards
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184848738810718867)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/comments
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184854191022718870)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body">',
'        <div class="t-Comments-info">',
'            #USER_NAME# <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/standard
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184855336202718870)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" id="report_table_#REGION_STATIC_ID#" aria-label="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(184855336202718870)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
end;
/
prompt --application/shared_components/user_interface/templates/report/timeline
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184858023511718873)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline" data-region-id="#REGION_STATIC_ID#">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/content_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184858399463718873)
,p_row_template_name=>'Content Row'
,p_internal_name=>'CONTENT_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-ContentRow-item #ITEM_CLASSES#">',
'  <div class="t-ContentRow-wrap">',
'    <div class="t-ContentRow-selection">#SELECTION#</div>',
'    <div class="t-ContentRow-iconWrap">',
'      <span class="t-ContentRow-icon #ICON_CLASS#">#ICON_HTML#</span>',
'    </div>',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        <h3 class="t-ContentRow-title">#TITLE#</h3>',
'        <div class="t-ContentRow-description">#DESCRIPTION#</div>',
'      </div>',
'      <div class="t-ContentRow-misc">#MISC#</div>',
'      <div class="t-ContentRow-actions">#ACTIONS#</div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-ContentRow #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1797843454948280151
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/search_results
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184861566889718873)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/media_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184861753154718873)
,p_row_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_row_template_condition1=>':LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <div class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_preset_template_options=>'t-MediaList--stack'
,p_reference_id=>2092157460408299055
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_column
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184864780078718876)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(184866750091718876)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/hidden
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894017034718888)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894084238718890)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894230889718890)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894275810718890)
,p_template_name=>'Optional - Floating'
,p_internal_name=>'OPTIONAL_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>1607675164727151865
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894359069718890)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894526042718890)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(184894591749718890)
,p_template_name=>'Required - Floating'
,p_internal_name=>'REQUIRED_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1607675344320152883
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(184896760696718893)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(184896979941718896)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="apex-item-text"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(184896871633718895)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(184898368389718904)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(184798239728718845)
,p_default_dialog_template=>wwv_flow_api.id(184796753255718842)
,p_error_template=>wwv_flow_api.id(184791415420718838)
,p_printer_friendly_template=>wwv_flow_api.id(184798239728718845)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(184791415420718838)
,p_default_button_template=>wwv_flow_api.id(184895376012718892)
,p_default_region_template=>wwv_flow_api.id(184832857644718859)
,p_default_chart_template=>wwv_flow_api.id(184832857644718859)
,p_default_form_template=>wwv_flow_api.id(184832857644718859)
,p_default_reportr_template=>wwv_flow_api.id(184832857644718859)
,p_default_tabform_template=>wwv_flow_api.id(184832857644718859)
,p_default_wizard_template=>wwv_flow_api.id(184832857644718859)
,p_default_menur_template=>wwv_flow_api.id(184842319708718863)
,p_default_listr_template=>wwv_flow_api.id(184832857644718859)
,p_default_irr_template=>wwv_flow_api.id(184830956519718859)
,p_default_report_template=>wwv_flow_api.id(184855336202718870)
,p_default_label_template=>wwv_flow_api.id(184894275810718890)
,p_default_menu_template=>wwv_flow_api.id(184896760696718893)
,p_default_calendar_template=>wwv_flow_api.id(184896871633718895)
,p_default_list_template=>wwv_flow_api.id(184892339769718888)
,p_default_nav_list_template=>wwv_flow_api.id(184883379000718885)
,p_default_top_nav_list_temp=>wwv_flow_api.id(184883379000718885)
,p_default_side_nav_list_temp=>wwv_flow_api.id(184881536539718885)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(184814885421718853)
,p_default_dialogr_template=>wwv_flow_api.id(184804474632718848)
,p_default_option_label=>wwv_flow_api.id(184894275810718890)
,p_default_required_label=>wwv_flow_api.id(184894591749718890)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(184884345305718885)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184897205188718898)
,p_theme_id=>42
,p_name=>'Redwood Light'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_IMAGES#css/Redwood-Light#MIN#.css?v=#APEX_VERSION#'))
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>2596426436825065489
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184897361878718898)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_is_public=>false
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184897583614718898)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184897779997718898)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184897946903718898)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(184898162464718898)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184792614592718840)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184793420130718840)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184801545931718848)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184801973627718848)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184802628847718848)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184803033447718848)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184806373392718849)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184807162580718849)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184808370860718851)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184809604685718851)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184809999961718851)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184810792889718851)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184812001459718853)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184813357063718853)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184814194310718853)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184816020764718854)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184820625951718856)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184820954297718856)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_ICON_POSITION'
,p_display_name=>'Collapsible Icon Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the position of the expand and collapse toggle for the region.'
,p_null_text=>'Start'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184821746145718856)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_BUTTON_ICONS'
,p_display_name=>'Collapsible Button Icons'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines which arrows to use to represent the icons for the collapse and expand button.'
,p_null_text=>'Arrows'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184823878911718856)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184824532557718859)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REGION'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Rounded Corners'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184826419692718859)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184828311789718859)
,p_theme_id=>42
,p_name=>'CALLOUT_POSITION'
,p_display_name=>'Callout Position'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Determines where the callout for the popup will be positioned relative to its parent.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184832156045718859)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER'
,p_display_name=>'Login Header'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the Login region header.'
,p_null_text=>'Icon and Title (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184840578335718863)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184840975483718863)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184841737042718863)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184843866475718863)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184845068268718867)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184845485430718867)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184847441663718867)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184849314185718870)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184851114508718870)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184851846415718870)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184853302928718870)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REPORT'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184854450958718870)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184855654138718870)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184856307564718870)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184856685216718873)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184858730728718873)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184859123140718873)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184859530586718873)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184859855957718873)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184860235978718873)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184860659358718873)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184861284930718873)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184863518930718873)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184865092414718876)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184868896695718878)
,p_theme_id=>42
,p_name=>'MOBILE'
,p_display_name=>'Mobile'
,p_display_sequence=>100
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a mobile-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184869482861718878)
,p_theme_id=>42
,p_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_sequence=>90
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a desktop-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184870508654718879)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184872727431718879)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184876061773718881)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184877246095718884)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184879881143718884)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'LIST'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184880516043718884)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184882286529718885)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184885237384718885)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184887327114718885)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184887914404718885)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184893487368718888)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184894858421718892)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184895923015718892)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184898599199718907)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184898978576718909)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184900563961718909)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184900937017718909)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184902555649718909)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184903028702718909)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184904584518718910)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184904960770718910)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184906548221718910)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184907001654718910)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184907394915718910)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184907745982718913)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184908198125718913)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184908628032718913)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184909015419718913)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184910350906718913)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184911745770718913)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184912808754718913)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184913199731718913)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184913545314718913)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184913967640718913)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184914605634718913)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184915185122718913)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184915623169718913)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184915941854718913)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184916401325718913)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Item Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for radio and check box items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(184917171129718915)
,p_theme_id=>42
,p_name=>'PAGINATION_DISPLAY'
,p_display_name=>'Pagination Display'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of pagination for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184781360449718835)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184778683413718824)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184784476251718835)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184781523847718835)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184786999158718837)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184784630220718835)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184789762106718838)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184787110679718837)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184791058658718838)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(184789844865718838)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184791279109718838)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(184789844865718838)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184792762523718840)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(184792614592718840)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184792980561718840)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(184792614592718840)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184793191132718840)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(184792614592718840)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184793578125718840)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(184791415420718838)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(184793420130718840)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184796675067718842)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184793726028718840)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184797976985718845)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(184796753255718842)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184798208114718845)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(184796753255718842)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184800675519718845)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(184798239728718845)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184801357804718848)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184801828033718848)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(184801545931718848)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184802213684718848)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(184801973627718848)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184802399083718848)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(184801973627718848)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184802806384718848)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(184802628847718848)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184803200152718848)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(184803033447718848)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184803423230718848)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(184801545931718848)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184803589615718848)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(184802628847718848)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184803765049718848)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(184801545931718848)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184803957762718848)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(184802628847718848)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184804216975718848)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(184801545931718848)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184804393804718848)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184800776485718846)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(184803033447718848)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184806564869718849)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(184806373392718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184806735977718849)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(184806373392718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184806955502718849)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(184806373392718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184807339675718849)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184807568948718849)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184807779513718851)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184807998968718851)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(184806373392718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184808200501718851)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184808571827718851)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184808805876718851)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184809010229718851)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184809161146718851)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184809352748718851)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184809773940718851)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(184809604685718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184810235655718851)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184810364335718851)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(184809604685718851)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184810548352718851)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184811032800718851)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184811145600718851)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184811356820718851)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184811569973718851)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184811791200718853)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184812198739718853)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(184812001459718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184812402103718853)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184812541204718853)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184812832353718853)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184805512744718849)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(184812001459718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184813183092718853)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184813586033718853)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(184813357063718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184813758880718853)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(184813357063718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184813937201718853)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(184813357063718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184814343756718853)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(184814194310718853)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184814568113718853)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(184814194310718853)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184814775521718853)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184812851368718853)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184815777791718854)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184814885421718853)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184816148648718854)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(184814885421718853)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(184816020764718854)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184816363550718854)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(184814885421718853)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184816618579718854)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(184814885421718853)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(184816020764718854)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184816806967718854)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184814885421718853)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184817231977718854)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184816918098718854)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184817407668718854)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184816918098718854)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184817626402718854)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184816918098718854)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184817800542718854)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184816918098718854)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184818781290718854)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819014020718854)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819135929718854)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819395919718854)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819593151718854)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819830346718856)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184819970838718856)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184820161369718856)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184820435843718856)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184820740955718856)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(184820625951718856)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184821224188718856)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(184820954297718856)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184821423224718856)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(184820625951718856)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184821632349718856)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184821963613718856)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(184821746145718856)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184822148695718856)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184822345704718856)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184822591115718856)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184822781461718856)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184822955614718856)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184823205354718856)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184817841652718854)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184824052648718859)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(184823878911718856)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184824260701718859)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184824691391718859)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(184824532557718859)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184824925647718859)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(184824532557718859)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184825072736718859)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184825305410718859)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184823236456718856)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184826009256718859)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184826158349718859)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184826598865718859)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184826767961718859)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184827003369718859)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184827198821718859)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184827400880718859)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184827552782718859)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184825342218718859)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184828489476718859)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(184828311789718859)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184828668159718859)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(184828311789718859)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184828915111718859)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184829074308718859)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(184828311789718859)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184829317014718859)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(184828311789718859)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184829486945718859)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184829662778718859)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(184828311789718859)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184829874310718859)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184830082718718859)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184830272484718859)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184830499238718859)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184830710152718859)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184830840955718859)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184827694575718859)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(184826419692718859)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184831328151718859)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184830956519718859)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184831526668718859)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184830956519718859)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184832411218718859)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184831610247718859)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(184832156045718859)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184832610311718859)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184831610247718859)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(184832156045718859)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184832808018718859)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184831610247718859)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(184832156045718859)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184833754646718862)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184833970888718862)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184834136008718862)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184834348763718862)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(184807162580718849)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184834591520718862)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184834783973718862)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835023871718862)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835195652718862)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835428482718862)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835601079718862)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835832388718862)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184835980095718862)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184836191190718862)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184836354474718862)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184836562098718862)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184836788098718862)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184836972649718862)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184837198088718862)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184837339185718862)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(184808370860718851)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184837557409718862)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(184809604685718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184837814650718862)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838003700718862)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(184809604685718851)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838204409718862)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838423575718862)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838608146718862)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838766697718862)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(184809999961718851)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184838985687718862)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184839143040718862)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184839411957718862)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184839617928718863)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(184832857644718859)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(184810792889718851)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184840833684718863)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(184840578335718863)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184841171268718863)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(184840975483718863)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184841359646718863)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184841585440718863)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(184840975483718863)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184841983141718863)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(184841737042718863)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184842167016718863)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184839647364718863)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(184841737042718863)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184842621165718863)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184842319708718863)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(184813357063718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184842797607718863)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184842319708718863)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184843031441718863)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(184842319708718863)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(184813357063718853)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184843165373718863)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184842319708718863)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184844078248718865)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(184843298036718863)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(184843866475718863)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184844317688718865)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184843298036718863)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(184843866475718863)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184844533102718865)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(184843298036718863)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184845302174718867)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(184845068268718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184845719009718867)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184845917852718867)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(184845068268718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184846045866718867)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184846318160718867)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(184845068268718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184846498804718867)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184846662209718867)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184846850761718867)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(184845068268718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184847128758718867)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(184845068268718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184847272239718867)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184847660413718867)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184847860520718867)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184848115063718867)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184848298196718867)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184848478265718867)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184848730843718867)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184844774653718867)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184849113002718870)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184849503131718870)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(184849314185718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184849722224718870)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184849907588718870)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(184849314185718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184850075155718870)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184850331732718870)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(184849314185718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184850446522718870)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184850735623718870)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184850842159718870)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184851314703718870)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(184851114508718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184851469753718870)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(184851114508718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184851643723718870)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184852090204718870)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(184851846415718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184852270389718870)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(184851846415718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184852516926718870)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184852671486718870)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184852840477718870)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184853039428718870)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(184849314185718870)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184853472274718870)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184853710618718870)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184853843835718870)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184854132470718870)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184848738810718867)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184854689362718870)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184854191022718870)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(184854450958718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184854862871718870)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184854191022718870)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184855074647718870)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184854191022718870)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184855248189718870)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184854191022718870)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(184854450958718870)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184855929527718870)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(184855654138718870)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184856120897718870)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(184855654138718870)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184856449736718870)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(184856307564718870)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184856892531718873)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(184856685216718873)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184857077175718873)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(184856685216718873)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184857267146718873)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(184856685216718873)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184857479234718873)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(184856307564718870)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184857636038718873)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184857851207718873)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184855336202718870)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(184856685216718873)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184858335156718873)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(184858023511718873)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184858871003718873)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(184858730728718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184859297695718873)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(184859123140718873)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184859684943718873)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(184859530586718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184860046372718873)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(184859855957718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184860451417718873)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(184860235978718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184860908862718873)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(184860659358718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184861107621718873)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(184847441663718867)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184861440563718873)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184858399463718873)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(184861284930718873)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184862117603718873)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184862302252718873)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184862460656718873)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184862687843718873)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184862864349718873)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184863049985718873)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184863240393718873)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(184853302928718870)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184863689676718873)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(184863518930718873)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184863919888718873)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184864099410718873)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184864280425718873)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184864486992718873)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184864655264718876)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(184861753154718873)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184865254604718876)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184865479018718876)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184865659338718876)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184865880498718876)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184866068096718876)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184866271046718876)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184866457676718876)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184866716689718876)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184864780078718876)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184867094899718876)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184867285160718876)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184867519500718876)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184867680434718876)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184867921683718876)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(184845485430718867)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184868082581718876)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184868291826718876)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184868444492718876)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(184866750091718876)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(184865092414718876)
,p_template_types=>'REPORT'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184869038722718878)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184868558625718876)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(184868896695718878)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184869288194718878)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184868558625718876)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(184868896695718878)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184869638267718878)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184868558625718876)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(184869482861718878)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184869858468718878)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184868558625718876)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(184869482861718878)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184870113490718878)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184868558625718876)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(184869482861718878)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184870689327718879)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184870921431718879)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184871121030718879)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184871281586718879)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184871490053718879)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184871676184718879)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184871884629718879)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184872055172718879)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184872266053718879)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(184870177338718878)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184872906028718879)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184872340605718879)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(184872727431718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184873066096718879)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184872340605718879)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(184872727431718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184873321819718879)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184872340605718879)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(184872727431718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184873485848718879)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184872340605718879)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184873716041718879)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184872340605718879)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184874096600718881)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184873750829718879)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184874327681718881)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184873750829718879)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184874487642718881)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184873750829718879)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184874641439718881)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184873750829718879)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184875088674718881)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184875330448718881)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184875456578718881)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184875725113718881)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184875879448718881)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184876263974718881)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184876443205718881)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184876693909718884)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184876919244718884)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184877046476718884)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184877481378718884)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(184877246095718884)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184877671574718884)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(184877246095718884)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184877932395718884)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(184877246095718884)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184878111843718884)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184878240560718884)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(184877246095718884)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184878478213718884)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184874794682718881)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(184877246095718884)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184878837185718884)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184879112210718884)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184879292194718884)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184879457324718884)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184879694930718884)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184880039818718884)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(184879881143718884)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184880310709718884)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(184879881143718884)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184880690837718884)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(184880516043718884)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184880876734718884)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184881057894718884)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184881285032718885)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184881481592718885)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184881915098718885)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184882082780718885)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184882535812718885)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(184882286529718885)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184882689950718885)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(184882286529718885)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184882931702718885)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184883066333718885)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184883308790718885)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184883729997718885)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184883379000718885)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184883894580718885)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184883379000718885)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184884041916718885)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184883379000718885)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184884236000718885)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184883379000718885)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184884719874718885)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884345305718885)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184885087113718885)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184885439454718885)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(184885237384718885)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184885662811718885)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184885899704718885)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(184885237384718885)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184886080435718885)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184886241512718885)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(184885237384718885)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184886521245718885)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184886707877718885)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184886903755718885)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184887067038718885)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184887461244718885)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(184887327114718885)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184887705892718885)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184888083407718885)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(184887914404718885)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184888327039718888)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(184887914404718885)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184888497447718888)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184888715357718888)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184888934786718888)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184889099481718888)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(184885237384718885)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184889294012718888)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(184879881143718884)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184889462449718888)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(184879881143718884)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184889657836718888)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(184887327114718885)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184889908244718888)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184890096036718888)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184890446199718888)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(184887914404718885)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184890654455718888)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(184870508654718879)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184890884727718888)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(184887914404718885)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184891051230718888)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(184880516043718884)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184891335843718888)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184891461746718888)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184891697247718888)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(184890192364718888)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(184880516043718884)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184892066367718888)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184891793828718888)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184892322645718888)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184891793828718888)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184892680838718888)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(184876061773718881)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184892892480718888)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184893115696718888)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184893334609718888)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184893695564718888)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(184893487368718888)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184893935428718888)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(184892339769718888)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(184893487368718888)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184895119966718892)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(184894717568718890)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(184894858421718892)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184895273158718892)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(184894717568718890)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(184894858421718892)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184895682922718892)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184896070509718892)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(184895923015718892)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184896279294718892)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(184894858421718892)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184896532403718893)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(184895923015718892)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184896734106718893)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(184894858421718892)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184898817655718907)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(184898599199718907)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184899186727718909)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(184898978576718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184899434490718909)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(184898599199718907)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184899568311718909)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(184898978576718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184899759074718909)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(184898599199718907)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184899941380718909)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(184898978576718909)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184900180151718909)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(184898599199718907)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184900349422718909)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(184898978576718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184900805374718909)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(184900563961718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184901222754718909)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(184900937017718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184901337958718909)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(184900563961718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184901630117718909)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(184900937017718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184901749096718909)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(184900563961718909)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184902021910718909)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(184900937017718909)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184902168747718909)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(184900563961718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184902423703718909)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(184900937017718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184902809667718909)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(184902555649718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184903185215718910)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(184903028702718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184903422193718910)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(184902555649718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184903593960718910)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(184903028702718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184903808995718910)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(184902555649718909)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184904021308718910)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(184903028702718909)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184904204299718910)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(184902555649718909)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184904423043718910)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(184903028702718909)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184904827071718910)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(184904584518718910)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184905200428718910)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(184904960770718910)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184905434248718910)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(184904584518718910)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184905581293718910)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(184904960770718910)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184905800915718910)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(184904584518718910)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184905951580718910)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(184904960770718910)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184906224170718910)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(184904584518718910)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184906422507718910)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(184904960770718910)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184906747224718910)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(184906548221718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184907177235718910)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(184907001654718910)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184907582750718910)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(184907394915718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184907947175718913)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(184907745982718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184908420277718913)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(184908198125718913)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184908759411718913)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(184908628032718913)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184909200583718913)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(184909015419718913)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184909341967718913)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(184909015419718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184909611430718913)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(184907001654718910)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184909801511718913)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(184907394915718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184909940430718913)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(184907745982718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184910199482718913)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(184908198125718913)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184910613941718913)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(184910350906718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184910763942718913)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(184910350906718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184910984933718913)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(184910350906718913)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184911196960718913)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(184906548221718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184911363052718913)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(184909015419718913)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184911563326718913)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(184908628032718913)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184911999824718913)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(184911745770718913)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184912144924718913)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(184906548221718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184912363045718913)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(184908628032718913)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184912591922718913)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(184906548221718910)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184912997018718913)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(184912808754718913)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184913429505718913)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(184913199731718913)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184913765054718913)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(184913545314718913)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184914209834718913)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(184913967640718913)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184914419707718913)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(184913967640718913)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184914811472718913)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(184914605634718913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184915022361718913)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(184913199731718913)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184915377267718913)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(184915185122718913)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184915755750718913)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(184915623169718913)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184916170288718913)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(184915941854718913)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184916582292718915)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(184916401325718913)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184916810666718915)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184916953208718915)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(184915185122718913)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(184917405433718915)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(184917171129718915)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts/delete_confirm_msg
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(184921097308718942)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications/application_express_accounts
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(184777620953718818)
,p_name=>'Application Express Accounts'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_cookie_name=>'&WORKSPACE_COOKIE.'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_condes_plugin_adc
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(43022683634552888939)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.CONDES.PLUGIN.ADC'
,p_display_name=>'APEX Dynamic Controller'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','DE.CONDES.PLUGIN.ADC'),'')
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#adc/js/adc.js',
'#PLUGIN_FILES#adc/js/adcApex.js'))
,p_css_file_urls=>'#PLUGIN_FILES#adc/css/adc.css'
,p_api_version=>1
,p_render_function=>'adc_plugin.render'
,p_ajax_function=>'adc_plugin.ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Plugin APEX Dynamic Controller (ADC)</h2>',
'<p>Das Plugin vereinfacht die Verwaltung von Formularen auf einer Seite.<br/>Folgende Funktionen sind implementiert:</p>',
'<ul>',
unistr('  <li>Es k\00F6nnen Anwendungsf\00E4lle definiert werden, die steuern, ob Elemente auf der Seite angezeigt werden oder nicht</li>'),
unistr('  <li>Elemente k\00F6nnen regelbasiert zu Pflichtfeldern erkl\00E4rt und gepr\00FCft werden</li>'),
unistr('  <li>Anwendungsf\00E4lle k\00F6nnen Validierungs- oder Initialisierungscode auf der Datenbank aufrufen</li>'),
unistr('  <li>Anwendungsf\00E4lle werden automatisch rekursiv aufgel\00F6st und rduzieren so die Anzahl der ben\00F6tigten Regeln</li>'),
'  <li>Treten Fehler bei der Initialisierung, Berechnung oder Validierung von Werten auf, werden diese dynamisch auf die Seite integriert</li>',
'</ul>',
unistr('<p> Anwendungsf\00E4lle werden innerhalb von Tabellen in der Datenbank abgelegt. Diese Anwendungsf\00E4lle k\00F6nnen durch eine eigene APEX-Anwendung verwaltet werden und anwendungs\00FCbergreifend eingesetzt werden.</p>')))
,p_version_identifier=>'1.0'
,p_files_version=>36
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(533764757976972368)
,p_plugin_id=>wwv_flow_api.id(43022683634552888939)
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
'<h2>ADC-APEX-Funktionen</h2>',
'<p>Dieser Parameter definiert den Namensraum der ',
unistr('JavaScript-Funktionalit\00E4t, die f\00FCr das ADC ben\00F6tigt wird.</p>'),
unistr('<p>Standardm\00E4\00DFig wird de.condes.plugin.adc.apex verwendet und '),
'mitgeliefert. Wenn diese Funktionen zum eingesetzten Theme nicht passen, ',
unistr('k\00F6nnen Sie eine eigene Kopie dieser Datei erstellen und anpassen.<br/> '),
unistr('Stellen Sie sicher, dass die in der mitgelieferten Datei ADCApex.js implementierten, \00F6ffentlichen Funktionen auch in '),
'Ihrer Implementierung vorhanden sind.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(533765201685972368)
,p_plugin_id=>wwv_flow_api.id(43022683634552888939)
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
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6164632D6572726F72207B0D0A2020636F6C6F723A7265643B0D0A7D0D0A0D0A2E6164632D6F6E2D6572726F72207B0D0A2020636F6C6F723A626C75653B0D0A7D0D0A0D0A2E6164632D64697361626C65647B0D0A2020636F6C6F723A677265793B0D';
wwv_flow_api.g_varchar2_table(2) := '0A7D0D0A0D0A2E6164632D646570726563617465647B0D0A2020636F6C6F723A677265656E3B0D0A7D0D0A0D0A2E6164632D64747B0D0A2020626F726465722D746F703A6772657920736F6C6964207468696E3B0D0A2020666F6E742D7765696768743A';
wwv_flow_api.g_varchar2_table(3) := '626F6C643B0D0A2020666F6E742D73697A653A312E32656D3B0D0A202070616464696E672D746F703A203370783B0D0A202070616464696E672D626F74746F6D3A203370783B0D0A20206D617267696E2D746F703A313870783B0D0A7D0D0A0D0A2E6164';
wwv_flow_api.g_varchar2_table(4) := '632D6361726F7573656C2D6861734572726F727B0D0A20206261636B67726F756E643A72676261283235352C20302C20302C20302E33290D0A7D0D0A0D0A2E742D427574746F6E2E6164632D726567696F6E2D626F74746F6D2D627574746F6E7B0D0A20';
wwv_flow_api.g_varchar2_table(5) := '206D617267696E2D72696768743A313470783B0D0A20206D617267696E2D626F74746F6D3A3870783B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(111084375617678992)
,p_plugin_id=>wwv_flow_api.id(43022683634552888939)
,p_file_name=>'adc/css/adc.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '0D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E207C7C207B7D3B0D0A64652E63';
wwv_flow_api.g_varchar2_table(2) := '6F6E6465732E706C7567696E2E616463203D2064652E636F6E6465732E706C7567696E2E616463207C7C207B7D3B0D0A0D0A0D0A2F2A2A0D0A202A20406E616D6573706163652064652E636F6E6465732E706C7567696E2E6164630D0A202A204073696E';
wwv_flow_api.g_varchar2_table(3) := '636520352E310D0A202A20406465736372697074696F6E0D0A2020203C703E546869732066696C6520696D706C656D656E74732074686520636C69656E742D7369646520636F6D706F6E656E74206F6620415045582044796E616D696320436F6E74726F';
wwv_flow_api.g_varchar2_table(4) := '6C6C65722E3C62723E0D0A20202020497473207461736B20697320746F0D0A2020202020203C756C3E0D0A20202020202020203C6C693E63726561746520746865206E6563657373617279206576656E742068616E646C657273207768656E2074686520';
wwv_flow_api.g_varchar2_table(5) := '706167652069732072656E64657265643E6C693E3C6C693E636F6C6C656374207468652072656C6576616E7420646174612066726F6D207468652070616765207768656E20616E206576656E74206F636375727320616E642073656E6420697420746F20';
wwv_flow_api.g_varchar2_table(6) := '746865207365727665723E6C693E3C6C693E696D706C656D656E74207468652072657475726E656420726573706F6E7365207769746820696E737472756374696F6E7320746F206D6F6469667920746865206170706C69636174696F6E20706167652E3E';
wwv_flow_api.g_varchar2_table(7) := '6C693E0D0A2020202020203E756C3E0D0A202020203E703E0D0A202020203C703E54686520636F6E74726F6C6C657220776F726B73206F6E2074686520736572766572207369646520776974682061206465636973696F6E207472656520746861742063';
wwv_flow_api.g_varchar2_table(8) := '6F6D70757465732061206C697374206F6620616374696F6E20696E737472756374696F6E7320666F72206120676976656E20736974756174696F6E2E3C62723E0D0A20202020447572696E67207468652063616C63756C6174696F6E2C20746865207374';
wwv_flow_api.g_varchar2_table(9) := '617465206F6620746865206170706C69636174696F6E20706167652063616E206265206368616E67656420627920616374696F6E732C207768696368206C6561647320746F20612072656375727369766520636865636B206F6620746865206368616E67';
wwv_flow_api.g_varchar2_table(10) := '6564207061676520737461746520616761696E737420746865206465636973696F6E20747265652E2054686520726573706F6E736520696E636C7564657320616C6C206368616E676520696E737472756374696F6E7320666F7220746865206170706C69';
wwv_flow_api.g_varchar2_table(11) := '636174696F6E20706167652C20696E636C7564696E672074686520726563757273697665206368616E676520696E737472756374696F6E732E3E703E0D0A202020203C703E5468652041444320726573706F6E73652069732064656C6976657265642069';
wwv_flow_api.g_varchar2_table(12) := '6E2074686520666F726D206F66206120736372697074207769746820616E20494420616E6420696E736572746564206F6E207468652070616765206279207468697320636F6D706F6E656E742E20546875732C20616C6C20696E636C7564656420616374';
wwv_flow_api.g_varchar2_table(13) := '696F6E7320617265206578656375746564206469726563746C792E20416674657277617264732C2074686520706C7567696E2072656D6F7665732074686520736572766572277320726573706F6E73652C206173206974206973206E6F206C6F6E676572';
wwv_flow_api.g_varchar2_table(14) := '206E65656465642E3E703E0D0A202020203C703E4368616E676520696E737472756374696F6E7320746F206170706C69636174696F6E207061676520706172746C7920646570656E64206F6E20415045582076657273696F6E207573656420616E642065';
wwv_flow_api.g_varchar2_table(15) := '7370656369616C6C79206F6E207468656D6520757365642E2054686520706C7567696E207374617274732066726F6D205468656D652034322C20686F77657665722C20616C6C207468656D652D737065636966696320696D706C656D656E746174696F6E';
wwv_flow_api.g_varchar2_table(16) := '73206F66207468652061637469766974696573206172652073776170706564206F757420696E746F20612073657061726174652066696C652C207768696368206973206C696E6B65642061732061206E616D657370616365206F626A656374207768656E';
wwv_flow_api.g_varchar2_table(17) := '20706172616D65746572697A696E672074686520706C7567696E206173206120636F6D706F6E656E7420706172616D657465722E204173207065722064656661756C742C2074686973206973203C64652E636F6E6465732E706C7567696E2E6164632E61';
wwv_flow_api.g_varchar2_table(18) := '7065785F34325F355F313E2C20696D706C656D656E74656E7420696E2066696C65203C616463417065782E6A733E2C206275742069742063616E20626520656173696C79207265706C61636564206279206120636C69656E742073706563696669632069';
wwv_flow_api.g_varchar2_table(19) := '6D706C656D656E746174696F6E2E3E703E0D0A202020203C703E546F20776F726B2C207468697320706C7567696E206D757374206F6E6C792062652063616C6C656420647572696E672070616765206C6F61642C206E6F2061646D696E69737472617469';
wwv_flow_api.g_varchar2_table(20) := '6F6E206F7220706172616D65746572697A6174696F6E2069732072657175697265642E3E703E0D0A2020202A2F0D0A2866756E6374696F6E20286164632C20242C2073657276657229207B0D0A20202275736520737472696374223B0D0A0D0A20202F2A';
wwv_flow_api.g_varchar2_table(21) := '2A0D0A2020202A204074797065646566207B4F626A6563747D206572726F720D0A2020202A20406465736372697074696F6E0D0A20202020203C703E416E206572726F722069732061204A534F4E206F626A65637420726570726573656E74696E672061';
wwv_flow_api.g_varchar2_table(22) := '6E206572726F722E20497420636F6E7461696E7320696E666F726D6174696F6E2061626F757420746865206572726F72206D6573736167652C207468652061666665637465642070616765206974656D20616E64206164646974696F6E616C20696E666F';
wwv_flow_api.g_varchar2_table(23) := '726D6174696F6E20746861742073686F7773206F6E6C792069662074686520706167652069732072656E646572656420696E206465627567206D6F64652E3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A204070726F7065727479';
wwv_flow_api.g_varchar2_table(24) := '207B737472696E677D206974656D2050616765206974656D20746861742069732061666665637465642062792074686973206572726F720D0A2020202A204070726F7065727479207B737472696E677D206D657373616765204572726F72206D65737361';
wwv_flow_api.g_varchar2_table(25) := '67650D0A2020202A204070726F7065727479207B737472696E677D206164646974696F6E616C496E666F20446576656C6F70657220696E666F726D6174696F6E2C0D0A2020202020202020202020202020202020202020202020206E6F726D616C6C7920';
wwv_flow_api.g_varchar2_table(26) := '63616C6C20737461636B20616E6420696E7465726E616C206572726F72206E616D650D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D206572726F724C6973740D0A2020202A20406465736372697074';
wwv_flow_api.g_varchar2_table(27) := '696F6E0D0A20202020203C703E416E206572726F724C697374206973206120636F6C6C656374696F6E206F66206572726F72732074686174206F63637572726564206F6E2074686520706167652E20497420616C736F20636F6E7461696E732061727261';
wwv_flow_api.g_varchar2_table(28) := '797320666F72206572726F7220646570656E64656E74206974656D732028692E652E206974656D732074686174206861766520746F2062652064697361626C656420696620616E206572726F72206F63637572726564206F6E2074686520706167652920';
wwv_flow_api.g_varchar2_table(29) := '616E6420666972696E674974656D732E3C62723E0D0A2020202020466972696E67206974656D732070726F7669646520696E666F726D6174696F6E2061626F75742070616765206974656D7320746861742068617665206265656E2027746F7563686564';
wwv_flow_api.g_varchar2_table(30) := '272062792065786563757465642072756C65732E20496E74656E74696F6E20697320746F2072656D6F766520616E79206572726F7220746861742069732072656C6174656420746F206120666972696E67206974656D2066726F6D2074686520636F6C6C';
wwv_flow_api.g_varchar2_table(31) := '656374696F6E206F66206572726F7273206F6E20746865207061676520616E64207265706C616365206974207769746820746865206E65776C792070726F7669646564206572726F72206D6573736167652C20696620616E792E2054686973207761792C';
wwv_flow_api.g_varchar2_table(32) := '206572726F72206D6573736167657320776869636820646F6E2774206170706C79206172652072656D6F7665642C20627574206572726F72732072656C6174696E6720746F206F746865722070616765206974656D73206F6E2074686520706167652073';
wwv_flow_api.g_varchar2_table(33) := '746179206F6E20706167652E3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A204070726F7065727479207B737472696E677D20636F756E7420416D6F756E74206F66206572726F72730D0A2020202A204070726F7065727479207B';
wwv_flow_api.g_varchar2_table(34) := '737472696E675B5D7D20666972696E674974656D73204172726179206F662070616765206974656D732074686174206172650D0A20202020202020206166666563746564206279207468652065786563757465642072756C65732E205573656420746F20';
wwv_flow_api.g_varchar2_table(35) := '72656D6F7665206572726F727320746861740D0A2020202020202020726566657220746F2074686573652070616765206974656D73206265666F726520616464696E67206E6577206572726F72730D0A2020202A204070726F7065727479207B6572726F';
wwv_flow_api.g_varchar2_table(36) := '725B5D7D206572726F7273204172726179206F66206572726F7220696E7374616E6365730D0A2020202A2040706172616D207B4F626A6563747D20616463205468697320636F64650D0A2020202A2040706172616D207B4F626A6563747D2024206A5175';
wwv_flow_api.g_varchar2_table(37) := '65727920696E7374616E6365206F6620415045580D0A2020202A2040706172616D207B4F626A6563747D2073657276657220617065782E73657276657220696E7374616E63650D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A2040747970656465';
wwv_flow_api.g_varchar2_table(38) := '66207B4F626A6563747D2074726967676572696E67456C656D656E740D0A2020202A20406465736372697074696F6E203C703E416E206F626A65637420746F20636F6C6C65637420696E666F726D6174696F6E732061626F757420746865207472696767';
wwv_flow_api.g_varchar2_table(39) := '6572696E67206974656D3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D206964204944206F6620746865207061676520656C656D656E742074686174207472696767';
wwv_flow_api.g_varchar2_table(40) := '6572656420746865206576656E742E0D0A2020202A204070726F7065727479207B737472696E677D206576656E74204E616D65206F6620746865206576656E74207468617420776173207261697365642E204D6179206265206120646966666572656E74';
wwv_flow_api.g_varchar2_table(41) := '206576656E74207468616E206F726967696E616C6C79207261697365642C66692E20616E203C656E7465723E2074686174206973207261697365642069662061203C6B657970726573733E206576656E742077617320666F756E6420666F722074686520';
wwv_flow_api.g_varchar2_table(42) := '456E7465722D6B65792E0D0A2020202A204070726F7065727479207B737472696E677D206973436C69636B20466C616720746F20696E646963617465207768657468657220746865206576656E742077617320736F6D65206B696E64206F6620636C6963';
wwv_flow_api.g_varchar2_table(43) := '6B206576656E740D0A2020202A204070726F7065727479207B737472696E677D2064617461204F7074696F6E616C2064617461207468617420697320706173736564207769746820746865206576656E742E204D617920626520612073696D706C652073';
wwv_flow_api.g_varchar2_table(44) := '7472696E67206F722061204A534F4E206F626A6563742E0D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D2070416374696F6E0D0A2020202A20406465736372697074696F6E203C703E416E20616E73';
wwv_flow_api.g_varchar2_table(45) := '776572206F626A656374206F662074686520706C7567696E206672616D65776F726B20636F6E7461696E696E67206174747269627574657320746F20636F6E74726F6C20667572746865722070726F63657373696E673E703E0D0A2020202A2040747970';
wwv_flow_api.g_varchar2_table(46) := '65204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3031204A534F4E206F626A65637420636F6E7461696E696E6720616C6C2070616765206974656D7320616E64207468656972';
wwv_flow_api.g_varchar2_table(47) := '206576656E74732077686963682061726520626F756E642062792074686520706C7567696E0D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3032204A534F4E206F62656A6374206F6620656C656D656E747320';
wwv_flow_api.g_varchar2_table(48) := '746861742068617665206368616E67656420647572696E67204144432070726F63657373696E6720616C6F6E6720776974682074686569722061637475616C2076616C7565730D0A2020202A204070726F7065727479207B737472696E677D2061747472';
wwv_flow_api.g_varchar2_table(49) := '69627574655F3033204E616D657370616365206F6620746865203C6164632E20417065784A533E206F626A656374207573656420746F2072656E646572207468652076697375616C2065666665637473206F66204144430D0A2020202A204070726F7065';
wwv_flow_api.g_varchar2_table(50) := '727479207B737472696E677D206174747269627574655F3034204A61766153637269707420636F646520746F206265206578656375746564206F6E2074686520706167652E20536574732074686520696E697469616C2076697375616C20737461746520';
wwv_flow_api.g_varchar2_table(51) := '6F662074686520706167650D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3035206A51756572792073656C6563746F72206F72204172726179206F66206164646974696F6E616C2070616765206974656D7320';
wwv_flow_api.g_varchar2_table(52) := '776869636820617265206E6F7420626F756E6420746F206576656E742068616E646C657273206275742074686569722076616C75652069732070617373656420746F204144430D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A2040747970656465';
wwv_flow_api.g_varchar2_table(53) := '66207B4F626A6563747D206576656E74446174610D0A2020202A20406465736372697074696F6E203C703E41204A736F6E206F626A65637420636F6E7461696E74696E67206461746120666F7220746865207365727665722063616C6C20737563682061';
wwv_flow_api.g_varchar2_table(54) := '732074686520616A61784964656E74696669657220616E64207468652070616765206974656D7320746F207375626D69743E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E';
wwv_flow_api.g_varchar2_table(55) := '677D20616A61784964656E746966696572205265666572656E636520746F206164632E616A61784964656E7469666965720D0A2020202A204070726F7065727479207B737472696E677D20706167654974656D73207265666572656E636520746F206164';
wwv_flow_api.g_varchar2_table(56) := '632E706167654974656D730D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D20636F6D6D616E64446174610D0A2020202A20406465736372697074696F6E203C703E41204A736F6E206F626A65637420';
wwv_flow_api.g_varchar2_table(57) := '636F6E7461696E74696E6720646174612064657363726962696E67206120636F6D6D616E64206F626A656374207768696368206973206261736564206F6E20406C696E6B7B617065782E616374696F6E7D3E703E0D0A2020202A204074797065204F626A';
wwv_flow_api.g_varchar2_table(58) := '6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D20636F6D6D616E64204E616D65206F662074686520636F6D6D616E6420746F20657865637574650D0A2020202A204070726F7065727479207B737472696E677D2065';
wwv_flow_api.g_varchar2_table(59) := '76656E74204576656E74206F626A6563742074686174207261697365642074686520616374696F6E0D0A2020202A204070726F7065727479207B737472696E677D20666F6375734974656D204944206F6620746865206974656D20746861742067657473';
wwv_flow_api.g_varchar2_table(60) := '20666F6375732069662074686520657865637574696F6E206F66206120636F6D6D616E642072657475726E7320747275650D0A2020202A204070726F7065727479207B737472696E677D206164646974696F6E616C506167654974656D73204172726179';
wwv_flow_api.g_varchar2_table(61) := '206F662070616765206974656D20494473207768696368206861766520746F2062652070617373656420696E206164646974696F6E20746F20746865206E6F726D616C20706167654974656D7320636F6C6C656374696F6E2E0D0A2020202A204070726F';
wwv_flow_api.g_varchar2_table(62) := '7065727479207B737472696E677D2064617461204164646974696F6E616C20696E666F726D6174696F6E20746861742069732070617373656420616C6F6E6720776974682074686520636F6D6D616E642C2066692E20666F722076616C7565730D0A2020';
wwv_flow_api.g_varchar2_table(63) := '202A2F0D0A0D0A20202F2A2A0D0A2020202047726F75703A20436F6E7374616E74730D0A2020202A2F0D0A2020636F6E737420435F4348414E47455F4556454E54203D20276368616E6765273B0D0A2020636F6E737420435F434C49434B5F4556454E54';
wwv_flow_api.g_varchar2_table(64) := '203D2027636C69636B273B0D0A2020636F6E737420435F44424C434C49434B5F4556454E54203D202764626C636C69636B273B0D0A2020636F6E737420435F454E5445525F4556454E54203D2027656E746572273B0D0A2020636F6E737420435F4B4559';
wwv_flow_api.g_varchar2_table(65) := '50524553535F4556454E54203D20276B65797072657373273B0D0A2020636F6E737420435F415045585F52454652455348203D20276170657872656672657368273B0D0A2020636F6E737420435F415045585F4245464F52455F52454652455348203D20';
wwv_flow_api.g_varchar2_table(66) := '27617065786265666F726572656672657368273B0D0A2020636F6E737420435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368273B0D0A2020636F6E737420435F415045585F41465445525F434C4F5345';
wwv_flow_api.g_varchar2_table(67) := '5F4449414C4F47203D2027617065786166746572636C6F73656469616C6F67273B0D0A2020636F6E737420435F49475F53454C454354494F4E5F4348414E4745203D2027696E7465726163746976656772696473656C656374696F6E6368616E6765273B';
wwv_flow_api.g_varchar2_table(68) := '0D0A2020636F6E737420435F545245455F53454C454354494F4E5F4348414E4745203D2027747265657669657773656C656374696F6E6368616E6765273B0D0A2020636F6E737420435F53454C454354494F4E5F4348414E4745203D202761646373656C';
wwv_flow_api.g_varchar2_table(69) := '656374696F6E6368616E6765273B0D0A2020636F6E737420435F4E4F5F54524947474552494E475F4954454D203D2027444F43554D454E54273B0D0A2020636F6E737420435F4C4F434B5F4C454E475448203D203230303B0D0A2020636F6E737420435F';
wwv_flow_api.g_varchar2_table(70) := '50524F5445435445445F4556454E5453203D205B435F434C49434B5F4556454E542C20435F44424C434C49434B5F4556454E542C20435F454E5445525F4556454E545D3B0D0A2020636F6E737420435F424F4459203D2027626F6479273B0D0A2020636F';
wwv_flow_api.g_varchar2_table(71) := '6E737420435F425554544F4E203D2027627574746F6E273B0D0A2020636F6E737420435F415045585F425554544F4E203D2027742D427574746F6E273B0D0A2020636F6E737420435F524547494F4E5F4352203D2027436C61737369635265706F727427';
wwv_flow_api.g_varchar2_table(72) := '3B0D0A2020636F6E737420435F524547494F4E5F4952203D2027496E7465726163746976655265706F7274273B0D0A2020636F6E737420435F524547494F4E5F4947203D2027496E74657261637469766547726964273B0D0A2020636F6E737420435F52';
wwv_flow_api.g_varchar2_table(73) := '4547494F4E5F54524545203D202754726565273B0D0A2020636F6E737420435F524547494F4E5F544142203D2027546162273B0D0A2020636F6E737420435F494E5055545F53454C4543544F52203D20273A696E7075743A76697369626C653A6E6F7428';
wwv_flow_api.g_varchar2_table(74) := '627574746F6E29273B0D0A0D0A20202F2F20476C6F62616C0D0A20207661722071756172616E74696E654C697374203D205B5D3B0D0A2020766172206576656E7444617461203D207B0D0A2020202020202020202022616A61784964656E746966696572';
wwv_flow_api.g_varchar2_table(75) := '223A206164632E616A61784964656E7469666965722C0D0A2020202020202020202022706167654974656D73223A206164632E706167654974656D737D3B0D0A20207661722074726967676572696E67456C656D656E74203D207B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(76) := '202020226964223A2022222C0D0A202020202020202020202264617461223A2022222C0D0A20202020202020202020226576656E74223A2022222C0D0A20202020202020202020226973436C69636B223A2066616C73657D3B0D0A202076617220706167';
wwv_flow_api.g_varchar2_table(77) := '65537461747573203D207B7D3B0D0A202020202020706167655374617475732E6974656D4D6170203D206E6577204D617028293B0D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B2B2050524956415445202B2B2B2B2B2B2B2B2B202A2F0D0A20202F2A2A0D';
wwv_flow_api.g_varchar2_table(78) := '0A2020202047726F75703A20507269766174652043616C6C6261636B204D6574686F64730D0A2020202A2F0D0A20202F2A2A200D0A2020202046756E6374696F6E3A206368616E676543616C6C6261636B20200D0A20202020202043616C6C6261636B20';
wwv_flow_api.g_varchar2_table(79) := '6D6574686F6420666F722061206368616E6765206576656E740D0A2020202020200D0A202020202020416E79206576656E742069732070757368656420746F206120717565756520746F2070726F63657373207468656D206F6E65206279206F6E652C20';
wwv_flow_api.g_varchar2_table(80) := '646570656E64696E67206F6E20746865206F7574636F6D65206F6620746865207072656465636573736F722E0D0A202020202020417320616E206578616D706C652C20696620612070616765206974656D20697320666F63757373656420616E64207468';
wwv_flow_api.g_varchar2_table(81) := '65207573657220636C69636B73206F6E206120627574746F6E2C2074776F206576656E7473206F636375723A0D0A2020202020200D0A20202020202020202D206368616E6765206576656E74206F6E207468652070616765206974656D0D0A2020202020';
wwv_flow_api.g_varchar2_table(82) := '2020202D20636C69636B206576656E74206F6E2074686520627574746F6E0D0A20202020202020200D0A202020202020496620746865206368616E6765206576656E74207472696767657273206120636F6D7075746174696F6E20746861742072657475';
wwv_flow_api.g_varchar2_table(83) := '726E7320616E206572726F7220287375636820617320612070616765206974656D2076616C69646174696F6E292C20696E206D616E792063617365732074686520636C69636B206576656E740D0A2020202020206F662074686520627574746F6E206D75';
wwv_flow_api.g_varchar2_table(84) := '7374206E6F742062652070726F63657373656420616E796D6F72652E204275742062656361757365207468657365206576656E74732061707065617220736F20717569636B6C792C2041444320697320756E61626C6520746F20726573706F6E64206265';
wwv_flow_api.g_varchar2_table(85) := '666F7265207468650D0A202020202020636C69636B206576656E742069732068616E646C65642E205468657265666F72652C207468657365206576656E74732061207175657565642E204966204144432072657475726E73207769746820616E20657272';
wwv_flow_api.g_varchar2_table(86) := '6F722C2074686520717565756520697320636C656172656420616E6420746865206E657874206576656E74732077696C6C206E6F742062652070726F6365737365642E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020';
wwv_flow_api.g_varchar2_table(87) := '704576656E74202D204576656E742074686174206F6363757265640D0A202020202020704576656E7444617461202D204164646974696F6E616C206576656E742064617461207468617420697320706173736564207769746820746865206576656E742E';
wwv_flow_api.g_varchar2_table(88) := '204D6179206265206163636573736564206279204144432E4745545F4556454E545F444154412077697468696E207468652064617461626173650D0A2020202020207057616974202D20466C616720746F20696E64696361746520776865746865722061';
wwv_flow_api.g_varchar2_table(89) := '2077616974207370696E6E65722073686F756C642062652073686F776E20647572696E672070726F63657373696E670D0A2020202A2F0D0A202066756E6374696F6E206368616E676543616C6C6261636B28704576656E742C20704576656E7444617461';
wwv_flow_api.g_varchar2_table(90) := '2C20705761697429207B0D0A2020202067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A202020202428435F424F4459292E71756575652866756E6374696F6E202829207B0D0A2020202020206D61696E7461696E416E';
wwv_flow_api.g_varchar2_table(91) := '64436865636B4576656E744C6F636B28293B0D0A2020202020206164632E73686F77576169745370696E6E6572287057616974293B0D0A2020202020206164632E6578656375746528704576656E742C20704576656E7444617461293B0D0A202020207D';
wwv_flow_api.g_varchar2_table(92) := '293B0D0A20207D3B202F2F206368616E676543616C6C6261636B0D0A20200D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A20636F6E6669726D43616C6C6261636B0D0A2020202020205772617073207468652063616C6C20746F20746865';
wwv_flow_api.g_varchar2_table(93) := '20646174616261736520696E206120636F6E6669726D6174696F6E206469616C6F6720746F20656E61626C6520746865207573657220746F2073757270726573732074686973206576656E742E0D0A2020202020200D0A20202020202044656C65676174';
wwv_flow_api.g_varchar2_table(94) := '65732073686F77696E672074686520636F6E6669726D6174696F6E206469616C6F6720746F203C6164632E417065784A533E2E0D0A2020202020200D0A20202020506172616D65746572733A202020200D0A202020202020704576656E74202D20457665';
wwv_flow_api.g_varchar2_table(95) := '6E742074686174206F6363757265640D0A2020202020207057616974202D20466C616720746F20696E646963617465207768657468657220612077616974207370696E6E65722073686F756C642062652073686F776E20647572696E672070726F636573';
wwv_flow_api.g_varchar2_table(96) := '73696E670D0A2020202A2F0D0A202066756E6374696F6E20636F6E6669726D43616C6C6261636B28704576656E742C20705761697429207B0D0A2020202067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A2020202024';
wwv_flow_api.g_varchar2_table(97) := '28435F424F4459292E71756575652866756E6374696F6E202829207B0D0A2020202020206D61696E7461696E416E64436865636B4576656E744C6F636B28293B0D0A2020202020206164632E73686F77576169745370696E6E6572287057616974293B0D';
wwv_flow_api.g_varchar2_table(98) := '0A2020202020202F2F2048616E646C65206576656E74206F6E6C7920616674657220636F6E6669726D6174696F6E2066726F6D2074686520757365720D0A2020202020206164632E417065784A532E636F6E6669726D5265717565737428704576656E74';
wwv_flow_api.g_varchar2_table(99) := '2C206368616E676543616C6C6261636B293B0D0A202020207D293B0D0A20207D3B202F2F20636F6E6669726D43616C6C6261636B0D0A20200D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A20656E74657243616C6C6261636B0D0A202020';
wwv_flow_api.g_varchar2_table(100) := '2020205772617073207468652063616C6C20746F2074686520646174616261736520696E206120636F6E6669726D6174696F6E206469616C6F6720746F20656E61626C6520746865207573657220746F2073757270726573732074686973206576656E74';
wwv_flow_api.g_varchar2_table(101) := '2E0D0A20202020202044656C6567617465732073686F77696E672074686520636F6E6669726D6174696F6E206469616C6F6720746F203C6164632E417065784A533E2E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020';
wwv_flow_api.g_varchar2_table(102) := '704576656E74202D204576656E742074686174206F6363757265640D0A202020202020704576656E7444617461202D203C6576656E74446174613E20696E7374616E6365207468617420676F657320616C6F6E67207769746820746865206576656E740D';
wwv_flow_api.g_varchar2_table(103) := '0A2020202A2F0D0A202066756E6374696F6E20656E74657243616C6C6261636B28704576656E742C20704576656E74446174612C207057616974297B0D0A2020202067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A20';
wwv_flow_api.g_varchar2_table(104) := '2020202F2F20506C616365207265717565737420696E20717565756520746F2070726F63657373206D756C7469706C65206576656E747320696E2073657175656E63650D0A202020206966202874726967676572696E67456C656D656E742E6576656E74';
wwv_flow_api.g_varchar2_table(105) := '203D3D3D20435F454E5445525F4556454E54297B0D0A202020202020617065782E64656275672E696E666F2860456E7175657565696E67204576656E742027247B435F454E5445525F4556454E547D2760293B0D0A202020202020242827626F64792729';
wwv_flow_api.g_varchar2_table(106) := '2E71756575652866756E6374696F6E28297B0D0A20202020202020206D61696E7461696E416E64436865636B4576656E744C6F636B28293B0D0A20202020202020206164632E73686F77576169745370696E6E6572287057616974293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(107) := '2020206164632E6578656375746528704576656E7444617461293B0D0A2020202020207D293B0D0A202020207D0D0A20207D3B202F2F20656E74657243616C6C6261636B0D0A20200D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A20756E';
wwv_flow_api.g_varchar2_table(108) := '736176656443616C6C6261636B0D0A2020202020205772617073207468652063616C6C20746F2074686520646174616261736520696E206120636F6E6669726D6174696F6E206469616C6F6720746861742069732073686F776E20696620746865207061';
wwv_flow_api.g_varchar2_table(109) := '676520636F6E7461696E7320756E7361766564206368616E6765732E0D0A20202020202044656C6567617465732073686F77696E672074686520636F6E6669726D6174696F6E206469616C6F6720746F203C6164632E417065784A533E2E0D0A20202020';
wwv_flow_api.g_varchar2_table(110) := '20200D0A20202020506172616D65746572733A0D0A202020202020704576656E74202D204576656E742074686174206F6363757265640D0A2020202020207057616974202D20466C616720746F20696E6469636174652077686574686572206120776169';
wwv_flow_api.g_varchar2_table(111) := '74207370696E6E65722073686F756C642062652073686F776E20647572696E672070726F63657373696E670D0A2020202A2F0D0A202066756E6374696F6E20756E736176656443616C6C6261636B28704576656E742C20705761697429207B0D0A202020';
wwv_flow_api.g_varchar2_table(112) := '2067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A202020202428435F424F4459292E71756575652866756E6374696F6E202829207B0D0A2020202020206D61696E7461696E416E64436865636B4576656E744C6F636B';
wwv_flow_api.g_varchar2_table(113) := '28293B0D0A2020202020206164632E73686F77576169745370696E6E6572287057616974293B0D0A202020202020696628686173556E73617665644368616E6765732829297B0D0A20202020202020202F2F2048616E646C65206576656E74206F6E6C79';
wwv_flow_api.g_varchar2_table(114) := '20616674657220636F6E6669726D6174696F6E2066726F6D2074686520757365720D0A20202020202020206164632E417065784A532E636F6E6669726D5265717565737428704576656E742C206368616E676543616C6C6261636B293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(115) := '207D0D0A202020202020656C73657B0D0A20202020202020202F2F204E6F206368616E676573206F6E2074686520706167652C20636F6E74696E75650D0A20202020202020206368616E676543616C6C6261636B28704576656E74293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(116) := '207D3B0D0A202020207D293B0D0A20207D3B202F2F20756E736176656443616C6C6261636B0D0A20200D0A20202F2A2A0D0A2020202047726F75703A20496E746572616C2048656C706572206D6574686F64730D0A2020202A2F0D0A20202F2A2A0D0A20';
wwv_flow_api.g_varchar2_table(117) := '20202046756E6374696F6E3A2062696E644576656E740D0A20202020202042696E647320616E206576656E7420746F20612070616765206974656D0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020704974656D496420';
wwv_flow_api.g_varchar2_table(118) := '2D204944206F662074686520656C656D656E7420746F2062696E640D0A202020202020704576656E74202D204E6D6165206F6620746865206576656E7420746F2062696E642E0D0A20202020202070416374696F6E202D204F7074696F6E616C2063616C';
wwv_flow_api.g_varchar2_table(119) := '6C6261636B206D6574686F642E204F76657272696465732064656661756C74206265686176696F7572206F662063616C6C696E67203C6368616E676543616C6C6261636B3E0D0A2020202A2F0D0A202066756E6374696F6E2062696E644576656E742870';
wwv_flow_api.g_varchar2_table(120) := '4974656D49642C20704576656E742C2070416374696F6E29207B0D0A202020207661722024746869733B0D0A20202020766172206576656E744C6973743B0D0A202020207661722063616C6C6261636B3B0D0A0D0A2020202069662028704974656D4964';
wwv_flow_api.g_varchar2_table(121) := '2E736561726368282F5B5C2E235C75303032303A5C5B5C5D5D2B2F29203C203029207B0D0A202020202020704974656D4964203D206023247B704974656D49647D603B0D0A202020207D0D0A202020202474686973203D202428704974656D4964293B0D';
wwv_flow_api.g_varchar2_table(122) := '0A0D0A202020206966202824746869732E6C656E677468203E203029207B0D0A2020202020202F2F20436865636B207768657468657220656C656D656E7420657869737473206F6E20706167652028636F756C64206265206D697373696E672064756520';
wwv_flow_api.g_varchar2_table(123) := '746F20612073657276657220636F6E646974696F6E290D0A2020202020206576656E744C697374203D20242E5F646174612824746869732E6765742830292C20276576656E747327293B0D0A20202020202063616C6C6261636B203D202828747970656F';
wwv_flow_api.g_varchar2_table(124) := '662070416374696F6E20213D3D2027756E646566696E6564272026262070416374696F6E2E6C656E677468203E203029203F206E65772046756E6374696F6E2870416374696F6E29203A206368616E676543616C6C6261636B293B0D0A0D0A2020202020';
wwv_flow_api.g_varchar2_table(125) := '202F2F2041444320756E62696E6473206576656E742068616E646C65727320626F756E6420746F2074686973206974656D20746F2070726576656E742070726F626C656D73206265747765656E2074686520646966666572656E742068616E646C657273';
wwv_flow_api.g_varchar2_table(126) := '0D0A20202020202024746869730D0A20202020202020202E6F666628704576656E74290D0A20202020202020202E6F6E28704576656E742C206576656E74446174612C2063616C6C6261636B293B0D0A20202020202069662028704576656E74203D3D3D';
wwv_flow_api.g_varchar2_table(127) := '20435F4348414E47455F4556454E5429207B0D0A20202020202020202F2F204348414E4745206576656E742073686F756C64206E6F742062652063616C6C65642061667465722041504558524546524553482C20736F20706175736520697420756E7469';
wwv_flow_api.g_varchar2_table(128) := '6C20617065786166746572726566726573680D0A202020202020202024746869730D0A20202020202020202E6F6E28435F415045585F4245464F52455F524546524553482C2066756E6374696F6E20286529207B0D0A2020202020202020202024287468';
wwv_flow_api.g_varchar2_table(129) := '6973292E6F666628435F4348414E47455F4556454E54293B0D0A20202020202020202020617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272070617573656420617420247B704974656D49647D60';
wwv_flow_api.g_varchar2_table(130) := '293B0D0A20202020202020207D290D0A20202020202020202E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E20286529207B0D0A20202020202020202020242874686973292E6F6E28435F4348414E47455F4556454E';
wwv_flow_api.g_varchar2_table(131) := '542C206576656E74446174612C2063616C6C6261636B293B0D0A20202020202020202020617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272072652D65737461626C697368656420617420247B70';
wwv_flow_api.g_varchar2_table(132) := '4974656D49647D60293B0D0A20202020202020207D293B0D0A2020202020207D0D0A202020207D0D0A20207D3B202F2F2062696E644576656E740D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2062696E644576656E74730D0A20';
wwv_flow_api.g_varchar2_table(133) := '202020202042696E647320616C6C206576656E7473207468617420617265207265717565737465642062792074686520706C7567696E20766961206164632E62696E644974656D732E0D0A20202020202055706F6E20696E697469616C697A6174696F6E';
wwv_flow_api.g_varchar2_table(134) := '2C20616C6C2072656C6576616E742070616765206974656D732061726520636F6C6C656374656420616C6F6E67207769746820746865207265717569726564206576656E74732E0D0A20202020202054686973206D6574686F64207468656E2062696E64';
wwv_flow_api.g_varchar2_table(135) := '7320616C6C206974656D732077697468207468652072657370656374697665206576656E742E0D0A2020202A2F0D0A202066756E6374696F6E2062696E644576656E74732829207B0D0A20202020242E65616368286164632E62696E644974656D732C20';
wwv_flow_api.g_varchar2_table(136) := '66756E6374696F6E202829207B0D0A20202020202062696E644576656E7428746869732E69642C20746869732E6576656E742C20746869732E616374696F6E293B0D0A20202020202069662028746869732E6576656E74203D3D3D20435F4348414E4745';
wwv_flow_api.g_varchar2_table(137) := '5F4556454E5429207B0D0A2020202020202020616464506167654974656D28746869732E6964293B0D0A2020202020207D0D0A202020207D293B0D0A20207D3B202F2F2062696E644576656E74730D0A20200D0A0D0A20202F2A2A0D0A2020202046756E';
wwv_flow_api.g_varchar2_table(138) := '6374696F6E3A2062696E644F627365727665724974656D730D0A2020202020204D6574686F64206964656E74696669657320616C6C20656C656D656E74732077686F73652076616C756573206D7573742062652073656E7420746F207468652064617461';
wwv_flow_api.g_varchar2_table(139) := '62617365207769746820616E7920726571756573742E0D0A20202020202054776F20706F737369626C65207761797320657869737420746F2061646420616E206974656D20746F2074686973206F62736572766572206C6973743A0D0A2020202020200D';
wwv_flow_api.g_varchar2_table(140) := '0A2020202020202D20496E697469616C697A6174696F6E20636F6465206F662074686520706C7567696E2074686174206175746F6D61746963616C6C792064657465637473206974656D732074686174206861766520612076616C756520616E64206172';
wwv_flow_api.g_varchar2_table(141) := '65207265666572656E63656420627920706167652072756C65730D0A2020202020202D204578706C69636974206F62736572766174696F6E206173207265717565737465642062792061204144432072756C6520616374696F6E0D0A2020202020200D0A';
wwv_flow_api.g_varchar2_table(142) := '202020202020546865207365636F6E64206F7074696F6E2063616C6C732074686973206D6574686F642E0D0A202020200D0A20202020506172616D657465723A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F7220';
wwv_flow_api.g_varchar2_table(143) := '746F206964656E7469667920746865206974656D2873292074686174206D757374206265206F62736572766564206578706C696369746C790D0A2020202A2F0D0A202066756E6374696F6E2062696E644F627365727665724974656D73287053656C6563';
wwv_flow_api.g_varchar2_table(144) := '746F7229207B0D0A202020207661722073656C6563746F724C6973743B0D0A20202020696620287053656C6563746F7229207B0D0A20202020202073656C6563746F724C697374203D207053656C6563746F722E73706C697428272C27293B0D0A202020';
wwv_flow_api.g_varchar2_table(145) := '202020242E656163682873656C6563746F724C6973742C2066756E6374696F6E20286964782C20656C656D656E7429207B0D0A202020202020202069662028746869732E737562737472696E6728302C203129203D3D3D20272E2729207B0D0A20202020';
wwv_flow_api.g_varchar2_table(146) := '2020202020202428656C656D656E74292E656163682866756E6374696F6E20286964782C20656C656D656E7429207B0D0A202020202020202020202020616464506167654974656D282428656C656D656E74292E61747472282769642729293B0D0A2020';
wwv_flow_api.g_varchar2_table(147) := '20202020202020207D293B0D0A20202020202020207D0D0A2020202020202020656C7365207B0D0A2020202020202020202069662028242E696E417272617928656C656D656E742C206164632E706167654974656D7329203D3D3D202D3129207B0D0A20';
wwv_flow_api.g_varchar2_table(148) := '20202020202020202020206164632E706167654974656D732E7075736828656C656D656E74293B0D0A202020202020202020207D0D0A20202020202020207D0D0A2020202020207D293B0D0A202020207D0D0A20207D3B202F2F2062696E644F62736572';
wwv_flow_api.g_varchar2_table(149) := '7665724974656D730D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20616464506167654974656D0D0A2020202020204D6574686F64206164647320612070616765206974656D20746F2061206C697374206F662070616765206974656D7320';
wwv_flow_api.g_varchar2_table(150) := '746F2062652073656E7420746F207468652073657276657220776974682065766572792063616C6C2E0D0A2020202020200D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944206F66207468652070616765206974';
wwv_flow_api.g_varchar2_table(151) := '656D20746861742061686F756C642062652061646465640D0A2020202A2F0D0A202066756E6374696F6E20616464506167654974656D28704974656D496429207B0D0A2020202069662028242E696E417272617928704974656D49642C206164632E7061';
wwv_flow_api.g_varchar2_table(152) := '67654974656D7329203D3D3D202D3129207B0D0A2020202020206164632E706167654974656D732E7075736828704974656D4964293B0D0A202020207D0D0A20207D3B202F2F20616464506167654974656D0D0A20200D0A0D0A20202F2A2A0D0A202020';
wwv_flow_api.g_varchar2_table(153) := '2046756E6374696F6E3A2065786563757465436F64650D0A2020202020204D6574686F6420746F206578656375746520616C6C204A61766153637269707420636F64652070617373656420696E20776974682074686520726573706F6E7365206F662041';
wwv_flow_api.g_varchar2_table(154) := '44432E0D0A2020202020200D0A20202020202054686520636F646520697320616464656420746F2074686520646F63756D656E74207573696E67203C242E617070656E643E20776869636820696D6D6564696174656C7920657865637574657320616E79';
wwv_flow_api.g_varchar2_table(155) := '204A6176615363726970742E0D0A202020202020416674657220617070656E64696E672C2074686520726573706F6E73652063616E2062652064656C65746564206265636175736520697420646F6573206E6F74206D616B6520616E792073656E736520';
wwv_flow_api.g_varchar2_table(156) := '746F2073746F7265206974206F6E20746865207061676520616E7920667572746865722E0D0A20202020202041667465722064656C6574696E672C207468652065786563757465206D6574686F642072616973657320746865206E657874206576656E74';
wwv_flow_api.g_varchar2_table(157) := '206F6E207468652071756575652028696620616E79292E0D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070436F6465202D204A61766153637269707420636F646520746F20657865637574650D0A2020202A2F0D0A2020';
wwv_flow_api.g_varchar2_table(158) := '66756E6374696F6E2065786563757465436F64652870436F646529207B0D0A202020207661722053637269707453656C6563746F723B0D0A202020206966202870436F646529207B0D0A202020202020636F6E736F6C652E6C6F672827526573706F6E73';
wwv_flow_api.g_varchar2_table(159) := '652072656365697665643A205C6E27202B2070436F6465293B0D0A2020202020202428435F424F4459292E617070656E642870436F6465293B0D0A20202020202053637269707453656C6563746F72203D20272327202B20242870436F6465292E617474';
wwv_flow_api.g_varchar2_table(160) := '722827696427293B0D0A202020202020242853637269707453656C6563746F72292E72656D6F766528293B0D0A202020207D0D0A202020202428435F424F4459292E6465717565756528293B0D0A20207D3B202F2F2065786563757465436F64650D0A20';
wwv_flow_api.g_varchar2_table(161) := '200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2066696E644974656D56616C75650D0A2020202020204D6574686F6420746F2070657273697374207468652076616C7565206F6620612070616765206974656D2E0D0A2020202020200D0A';
wwv_flow_api.g_varchar2_table(162) := '2020202020205768656E20612063616C6C20746F207265667265736820612070616765206974656D206973206973737565642C207468652076616C7565206F662074686973206974656D20697320726573657420746F204E554C4C20627920415045582E';
wwv_flow_api.g_varchar2_table(163) := '0D0A20202020202054686973206D6574686F6420616C6C6F777320746F2073746F7265207468652076616C7565206F6620746865206974656D206265666F72652072656672657368696E6720697420616E6420746F20726573657420697420746F207468';
wwv_flow_api.g_varchar2_table(164) := '69732076616C756520616674657220726566726573682E0D0A2020202020200D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944206F66207468652070616765206974656D2E2050657263656976656420746F2062';
wwv_flow_api.g_varchar2_table(165) := '6520756E697175650D0A2020202A2F0D0A202066756E6374696F6E2066696E644974656D56616C756528704974656D496429207B0D0A2020202076617220726573756C74203D20242E67726570286164632E6C6173744974656D56616C7565732C206675';
wwv_flow_api.g_varchar2_table(166) := '6E6374696F6E20286529207B0D0A20202020202072657475726E20652E6964203D3D3D20704974656D49643B0D0A202020207D293B0D0A0D0A2020202069662028726573756C742E6C656E677468203E203029207B0D0A20202020202072657475726E20';
wwv_flow_api.g_varchar2_table(167) := '726573756C745B305D2E76616C75653B0D0A202020207D0D0A20207D3B202F2F2066696E644974656D56616C75650D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20666F72456163680D0A20202020202048656C70657220746F206964';
wwv_flow_api.g_varchar2_table(168) := '656E746966792070616765206974656D7320746F206170706C79203C70416374696F6E3E20746F0D0A2020202020200D0A20202020506172616D65746572733A200D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F72';
wwv_flow_api.g_varchar2_table(169) := '20746F206964656E746966792070616765206974656D730D0A20202020202070416374696F6E202D20416374696F6E20746F2065786563757465206F6E2074686520666F756E642070616765206974656D730D0A2020202A2F0D0A202066756E6374696F';
wwv_flow_api.g_varchar2_table(170) := '6E20666F7245616368287053656C6563746F722C2070416374696F6E29207B0D0A20202020696620282128242E69734172726179287053656C6563746F7229207C7C207053656C6563746F722E736561726368282F5B5C2E235C75303032303A5C5B5C5D';
wwv_flow_api.g_varchar2_table(171) := '5D2B2F29203E3D20302929207B0D0A2020202020202F2F20C3BC626572676562656E6573204954454D2069737420456C656D656E746E616D652C20756D20232065727765697465726E0D0A2020202020207053656C6563746F72203D206023247B705365';
wwv_flow_api.g_varchar2_table(172) := '6C6563746F727D603B0D0A202020207D0D0A0D0A20202020696620287053656C6563746F722E6D61746368282F6F6A2E2A2F29297B0D0A2020202020202F2F206974656D206973204F7261636C65204A6574206974656D2067726F75702C207472617665';
wwv_flow_api.g_varchar2_table(173) := '7273652075700D0A2020202020207053656C6563746F72203D2024286023247B7053656C6563746F727D60292E636C6F7365737428276469762E617065782D6974656D2D67726F757027292E617474722827696427293B0D0A202020207D0D0A20202020';
wwv_flow_api.g_varchar2_table(174) := '24287053656C6563746F72292E656163682870416374696F6E293B0D0A20207D3B202F2F20666F72456163680D0A20200D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A20676574526567696F6E547970650D0A2020202020204D6574686F';
wwv_flow_api.g_varchar2_table(175) := '6420746F2064657465726D696E65207468652074797065206120726567696F6E206861730D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070526567696F6E4964202D20496420746F206964656E74696679207468652072';
wwv_flow_api.g_varchar2_table(176) := '6567696F6E2E0D0A2020202020200D0A2020202052657475726E733A0D0A2020202020204F6E65206F662074686520636F6E7374616E7473203C435F524547494F4E5F49473E2C20203C435F524547494F4E5F49523E2C203C435F524547494F4E5F4352';
wwv_flow_api.g_varchar2_table(177) := '3E2C203C435F524547494F4E5F545245453E2C203C435F524547494F4E5F5441423E0D0A2020202A2F0D0A202066756E6374696F6E20676574526567696F6E547970652870526567696F6E4964297B0D0A2020202076617220435F43525F53454C454354';
wwv_flow_api.g_varchar2_table(178) := '4F52203D2060237265706F72745F7461626C655F247B70526567696F6E49647D603B0D0A2020202076617220435F49525F53454C4543544F52203D206023247B70526567696F6E49647D5F6972603B0D0A2020202076617220435F49475F53454C454354';
wwv_flow_api.g_varchar2_table(179) := '4F52203D206023247B70526567696F6E49647D5F6967603B0D0A2020202076617220435F545245455F53454C4543544F52203D206023247B70526567696F6E49647D5F74726565603B0D0A2020202076617220435F5441425F53454C4543544F52203D20';
wwv_flow_api.g_varchar2_table(180) := '602353525F247B70526567696F6E49647D603B0D0A20202020766172207265706F727424203D2024286023247B70526567696F6E49647D60293B0D0A20202020766172207265706F7274547970653B0D0A0D0A202020206966287265706F7274242E6669';
wwv_flow_api.g_varchar2_table(181) := '6E6428435F49475F53454C4543544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F49473B0D0A202020207D0D0A20202020656C7365206966287265706F7274242E66696E6428435F49';
wwv_flow_api.g_varchar2_table(182) := '525F53454C4543544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F49523B0D0A202020207D0D0A20202020656C7365206966287265706F7274242E66696E6428435F43525F53454C45';
wwv_flow_api.g_varchar2_table(183) := '43544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F43523B0D0A202020207D0D0A20202020656C7365206966287265706F7274242E66696E6428435F545245455F53454C4543544F52';
wwv_flow_api.g_varchar2_table(184) := '292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F545245453B0D0A202020207D0D0A20202020656C7365206966287265706F7274242E706172656E7428435F5441425F53454C4543544F5229';
wwv_flow_api.g_varchar2_table(185) := '2E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F5441423B0D0A202020207D0D0A0D0A2020202072657475726E207265706F7274547970653B0D0A20207D3B202F2F20676574526567696F6E54';
wwv_flow_api.g_varchar2_table(186) := '7970650D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2067657454726967676572696E67456C656D656E740D0A2020202020204D6574686F6420746F20646573637269626520746865206576656E7420616E642063616C6C696E67';
wwv_flow_api.g_varchar2_table(187) := '206974656D20616674657220616E206576656E7420686173206F6363757265642E0D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202065202D204576656E7420746F20676574207468652074726967676572696E6720656C65';
wwv_flow_api.g_varchar2_table(188) := '6D656E7420666F720D0A2020202A2F0D0A202066756E6374696F6E2067657454726967676572696E67456C656D656E74286529207B0D0A202020207661722024656C656D656E743B0D0A202020207661722024627574746F6E3B0D0A0D0A202020202F2F';
wwv_flow_api.g_varchar2_table(189) := '20436F7079206576656E74206461746120746F2061206C6F63616C207661726961626C6520746F20616C6C6F7720666F72207461796C6F72696E670D0A2020202074726967676572696E67456C656D656E742E6964203D20435F4E4F5F54524947474552';
wwv_flow_api.g_varchar2_table(190) := '494E475F4954454D3B0D0A2020202074726967676572696E67456C656D656E742E6576656E74203D20652E747970653B0D0A2020202074726967676572696E67456C656D656E742E64617461203D20652E646174613B0D0A0D0A20202020696620287479';
wwv_flow_api.g_varchar2_table(191) := '70656F6620652E74617267657420213D2027756E646566696E65642729207B0D0A202020202020737769746368202874726967676572696E67456C656D656E742E6576656E7429207B0D0A20202020202020206361736520435F415045585F4146544552';
wwv_flow_api.g_varchar2_table(192) := '5F434C4F53455F4449414C4F473A0D0A202020202020202020202F2F20436C6F73654469616C6F6720697320626F756E6420746F2063757272656E7454617267657420746F20616C6C6F7720666F722064656C656761746564206576656E74732E0D0A20';
wwv_flow_api.g_varchar2_table(193) := '20202020202020202074726967676572696E67456C656D656E742E6964203D20652E63757272656E745461726765742E69643B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F4348414E47455F4556454E543A0D';
wwv_flow_api.g_varchar2_table(194) := '0A2020202020202020202074726967676572696E67456C656D656E742E6964203D20652E7461726765742E69643B0D0A0D0A2020202020202020202024656C656D656E74203D2024286023247B74726967676572696E67456C656D656E742E69647D6029';
wwv_flow_api.g_varchar2_table(195) := '3B0D0A202020202020202020206966202824656C656D656E742E617474722827747970652729203D3D3D2027726164696F27207C7C2024656C656D656E742E617474722827747970652729203D3D3D2027636865636B626F782729207B0D0A2020202020';
wwv_flow_api.g_varchar2_table(196) := '202020202020202F2F20496E2063617365206F66206120726164696F2067726F7570206F72206120636865636B626F782C207468652069642068617320746F2062652074616B656E2066726F6D2074686520706172656E74206669656C647365740D0A20';
wwv_flow_api.g_varchar2_table(197) := '202020202020202020202074726967676572696E67456C656D656E742E6964203D2024656C656D656E742E706172656E747328276669656C6473657427292E617474722827696427293B0D0A202020202020202020207D0D0A2020202020202020202069';
wwv_flow_api.g_varchar2_table(198) := '66202874726967676572696E67456C656D656E742E69642E6D61746368282F6F6A2E2A2F29297B0D0A2020202020202020202020202F2F206974656D206973204F7261636C65204A6574206974656D2067726F75702C2074726176657273652075700D0A';
wwv_flow_api.g_varchar2_table(199) := '20202020202020202020202074726967676572696E67456C656D656E742E6964203D2024286023247B74726967676572696E67456C656D656E742E69647D60292E636C6F7365737428276469762E617065782D6974656D2D67726F757027292E61747472';
wwv_flow_api.g_varchar2_table(200) := '2827696427293B0D0A202020202020202020207D0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F434C49434B5F4556454E543A0D0A202020202020202020202F2F20466C6167206973207573656420746F20636C';
wwv_flow_api.g_varchar2_table(201) := '65617220746865206576656E7420717565756520746F2070726576656E74206D756C7469706C6520636C69636B730D0A2020202020202020202074726967676572696E67456C656D656E742E6973436C69636B203D20747275653B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(202) := '20202074726967676572696E67456C656D656E742E6964203D202828652E7461726765742E696420213D3D20272729203F20652E7461726765742E6964203A20652E63757272656E745461726765742E6964293B0D0A0D0A202020202020202020206966';
wwv_flow_api.g_varchar2_table(203) := '202874726967676572696E67456C656D656E742E6964203D3D3D20272729207B0D0A2020202020202020202020202F2F20536F6D652062726F77736572732073656E64206163636573734B65792D7370616E20696E7374656164206F6620747269676765';
wwv_flow_api.g_varchar2_table(204) := '72696E6720656C656D656E7420696E20726573706F6E736520746F206120636C69636B0D0A2020202020202020202020202F2F204765742074686520706172656E7420656C656D656E7420696E2074686573652063617365730D0A202020202020202020';
wwv_flow_api.g_varchar2_table(205) := '20202074726967676572696E67456C656D656E742E6964203D20652E7461726765742E706172656E74456C656D656E742E69643B0D0A202020202020202020207D0D0A2020202020202020202024627574746F6E203D2024286023247B74726967676572';
wwv_flow_api.g_varchar2_table(206) := '696E67456C656D656E742E69647D60293B0D0A202020202020202020202F2F20446570656E64696E67206F6E20686F77206120636C69636B206576656E74207761732072616973656420286D6F757365206F7220636F6465292C20612064696666657265';
wwv_flow_api.g_varchar2_table(207) := '6E74206974656D206973206164647265737365640D0A20202020202020202020696620282124627574746F6E2E686173436C61737328435F415045585F425554544F4E2929207B0D0A20202020202020202020202024627574746F6E203D202428602324';
wwv_flow_api.g_varchar2_table(208) := '7B74726967676572696E67456C656D656E742E69647D60292E706172656E7428435F425554544F4E293B0D0A202020202020202020207D0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F4B455950524553535F45';
wwv_flow_api.g_varchar2_table(209) := '56454E543A0D0A2020202020202020202074726967676572696E67456C656D656E742E6964203D20652E7461726765742E69643B0D0A202020202020202020202F2F2049662074686520454E5445522D6B65792077617320707265737365642C20746865';
wwv_flow_api.g_varchar2_table(210) := '206576656E742074797065206973206368616E67656420746F2027656E7465722720746F20616C6C6F7720666F72206561737920646574656374696F6E2077697468696E204144430D0A202020202020202020207377697463682028652E6B6579436F64';
wwv_flow_api.g_varchar2_table(211) := '6529207B0D0A202020202020202020202020636173652031333A0D0A202020202020202020202020202074726967676572696E67456C656D656E742E6576656E74203D20435F454E5445525F4556454E543B0D0A20202020202020202020202020206272';
wwv_flow_api.g_varchar2_table(212) := '65616B3B0D0A2020202020202020202020202F2F20616464206F74686572206B657920636F6465732068657265206966206E65636573736172790D0A202020202020202020207D0D0A20202020202020202020627265616B3B0D0A202020202020202064';
wwv_flow_api.g_varchar2_table(213) := '656661756C743A0D0A2020202020202020202074726967676572696E67456C656D656E742E6964203D20652E7461726765742E69643B0D0A2020202020207D0D0A202020202020617065782E64656275672E696E666F28604576656E742027247B747269';
wwv_flow_api.g_varchar2_table(214) := '67676572696E67456C656D656E742E6576656E747D27207261697365642061742054726967676572696E6720656C656D656E742027247B74726967676572696E67456C656D656E742E69647D2760293B0D0A202020207D0D0A20207D3B202F2F20676574';
wwv_flow_api.g_varchar2_table(215) := '54726967676572696E67456C656D656E740D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20686578546F436861720D0A2020202020204D6574686F6420746F20636173742061206865782D737472696E6720726570726573656E746174';
wwv_flow_api.g_varchar2_table(216) := '696F6E206372656174656420776974682055544C5F5241572E434153545F544F5F524157206261636B20746F20537472696E672E0D0A2020202020200D0A202020202020414443207375626D6974732069747320726573706F6E73652061732061206865';
wwv_flow_api.g_varchar2_table(217) := '7820737472696E6720746F2063697263756D76656E74206573636170696E6720697373756573206265747765656E204A534F4E2C204A61766153637269707420616E64204A61766153637269707420636F6E7461696E696E67204A534F4E2E0D0A202020';
wwv_flow_api.g_varchar2_table(218) := '2020204173206120636F6E73657175656E63652C207468652068657820737472696E67206D75737420626520636F6E766572746564206261636B20746F2061206E6F726D616C20737472696E6720696E206F7264657220746F20617070656E6420697420';
wwv_flow_api.g_varchar2_table(219) := '746F2074686520706167652E0D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070526177537472696E67202D204865782D656E636F64656420737472696E6720746F20636F6E76657274206261636B20746F2061206E6F72';
wwv_flow_api.g_varchar2_table(220) := '6D616C20737472696E672E0D0A2020202020200D0A2020202052657475726E733A0D0A202020202020436F6E76657274656420537472696E670D0A2020202A2F0D0A0D0A202066756E6374696F6E20686578546F436861722870526177537472696E6729';
wwv_flow_api.g_varchar2_table(221) := '207B0D0A2020202076617220636F6465203D2027273B0D0A2020202076617220686578537472696E673B0D0A0D0A202020206966202870526177537472696E6729207B0D0A202020202020686578537472696E67203D2070526177537472696E672E746F';
wwv_flow_api.g_varchar2_table(222) := '537472696E6728293B0D0A202020202020666F7220286C65742069203D20303B2069203C20686578537472696E672E6C656E6774683B2069202B3D203229207B0D0A2020202020202020636F6465202B3D20537472696E672E66726F6D43686172436F64';
wwv_flow_api.g_varchar2_table(223) := '65287061727365496E7428686578537472696E672E73756273747228692C2032292C20313629293B0D0A2020202020207D0D0A202020207D0D0A2020202072657475726E20636F64653B0D0A20207D3B202F2F686578546F436861720D0A20200D0A2020';
wwv_flow_api.g_varchar2_table(224) := '0D0A20202F2A2A200D0A2020202046756E6374696F6E3A20686173556E73617665644368616E6765730D0A2020202020204D6574686F6420746F2064657465637420756E7361766564206368616E676573206F6E2074686520706167652E0D0A20202020';
wwv_flow_api.g_varchar2_table(225) := '20200D0A2020202020204973207573656420696E20636F6E6A756E6374696F6E2077697468207B407365653A2072656D656D626572506167654974656D5374617475737D207768696368206861732073617665642074686520696E697469616C20706167';
wwv_flow_api.g_varchar2_table(226) := '6520737461747573206265666F72652E0D0A202020202020436F6D7061726573207468652061637475616C2076616C75657320616761696E7374207061676553746174757320616E642072657475726E732074727565206966206174206C65617374206F';
wwv_flow_api.g_varchar2_table(227) := '6E652076616C756520686173206368616E6765642E0D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070506167654974656D73202D204F7074696F6E616C206172726179206F6620616C6C2070616765206974656D206964';
wwv_flow_api.g_varchar2_table(228) := '7320746F20636170747572652E20496620656D7074792C20616C6C2070616765206974656D73206172652063617074757265642E0D0A2020202A2F0D0A202066756E6374696F6E20686173556E73617665644368616E6765732870506167654974656D73';
wwv_flow_api.g_varchar2_table(229) := '297B0D0A20202020766172206974656D4C6973743B0D0A20202020766172206974656D56616C75653B0D0A20202020766172206973446966666572656E74203D2066616C73653B0D0A202020200D0A202020202F2F20496E697469616C697A650D0A2020';
wwv_flow_api.g_varchar2_table(230) := '202041727261792E697341727261792870506167654974656D7329203F206974656D4C697374203D2070506167654974656D73203A206974656D4C697374203D202428435F494E5055545F53454C4543544F52293B0D0A202020200D0A20202020242E65';
wwv_flow_api.g_varchar2_table(231) := '616368286974656D4C6973742C2066756E6374696F6E286974656D297B0D0A2020202020206974656D203D206974656D4C6973745B6974656D5D3B0D0A2020202020206966286974656D2E6964297B0D0A20202020202020206974656D203D206974656D';
wwv_flow_api.g_varchar2_table(232) := '2E69643B0D0A2020202020207D3B0D0A202020202020617065782E64656275672E696E666F2860436F6D706172696E6720247B6974656D7D60293B0D0A20202020202069662028706167655374617475732E6974656D4D61702E686173286974656D2920';
wwv_flow_api.g_varchar2_table(233) := '262620706167655374617475732E6974656D4D61702E676574286974656D2920213D20617065782E6974656D286974656D292E67657456616C75652829297B0D0A20202020202020206973446966666572656E74203D20747275653B0D0A202020202020';
wwv_flow_api.g_varchar2_table(234) := '202072657475726E2066616C73653B0D0A2020202020207D0D0A202020207D293B0D0A2020202072657475726E206973446966666572656E743B0D0A20207D3B202F2F20686173556E73617665644368616E6765730D0A20200D0A0D0A20202F2A2A200D';
wwv_flow_api.g_varchar2_table(235) := '0A2020202046756E6374696F6E3A206D61696E7461696E416E64436865636B4576656E744C6F636B0D0A2020202020204D6574686F6420746F2072656A656374207468652073616D65206576656E7420666F722061206365727461696E20616D6F756E74';
wwv_flow_api.g_varchar2_table(236) := '206F662074696D6520746F2070726576656E7420646F75626C6520657865637574696F6E206F66204144432072657175657374732E0D0A2020202020200D0A2020202020204576656E74732C207375636820617320454E544552206B6579206F7220636C';
wwv_flow_api.g_varchar2_table(237) := '69636B206D61792062652072616973656420717569636B6572207468616E204144432069732061626C6520746F20636F6E73756D65207468656E2C206C656164696E6720746F206120646F75626C650D0A2020202020207265717565737420616E642061';
wwv_flow_api.g_varchar2_table(238) := '20646F75626C6520657865637574696F6E206F662072756C65732E2054686973206D6179206C65616420746F2061206D6F64616C206469616C6F6720746F2062652073686F776E207477696365206F72206120646F75626C6520696E7365727420696E74';
wwv_flow_api.g_varchar2_table(239) := '6F0D0A20202020202061207461626C652C2072616973696E6720756E69717565206572726F7273206574632E0D0A2020202020200D0A202020202020546F20636174657220666F7220746869732C20616E206576656E7420697320707574206F6E206120';
wwv_flow_api.g_varchar2_table(240) := '71756172616E74696E654C69737420666F722061206365727461696E20616D6F756E74206F662074696D652E2054686973206D6574686F642061646D696E69737465727320746869730D0A20202020202071756172616E74696E65206C69737420616E64';
wwv_flow_api.g_varchar2_table(241) := '20636865636B732077686574686572206974206973206F6B20746F20726169736520616E206576656E742E0D0A2020202A2F0D0A202066756E6374696F6E206D61696E7461696E416E64436865636B4576656E744C6F636B28297B0D0A20202020766172';
wwv_flow_api.g_varchar2_table(242) := '2069734F6B546F52616973654576656E74203D20747275653B0D0A0D0A2020202069662028435F50524F5445435445445F4556454E54532E696E6465784F662874726967676572696E67456C656D656E742E6576656E7429203E202D31297B0D0A202020';
wwv_flow_api.g_varchar2_table(243) := '20202069662871756172616E74696E654C6973742E696E6465784F662874726967676572696E67456C656D656E742E6576656E7429203E202D31297B0D0A20202020202020202F2F2049676E6F7265206576656E74206173206974206973206F6E207175';
wwv_flow_api.g_varchar2_table(244) := '6172616E74696E654C6973740D0A2020202020202020617065782E64656275672E696E666F286049676E6F72696E67204576656E742027247B74726967676572696E67456C656D656E742E6576656E747D272C206F6E2071756172616E74696E65206C69';
wwv_flow_api.g_varchar2_table(245) := '737460293B0D0A202020202020202069734F6B546F52616973654576656E74203D2066616C73653B0D0A2020202020207D0D0A202020202020656C73657B0D0A20202020202020202F2F2052656D6F766520616E79206578697374696E67206576656E74';
wwv_flow_api.g_varchar2_table(246) := '732066726F6D207468652071756575650D0A2020202020202020617065782E64656275672E696E666F2860436C656172206576656E74207175657565206166746572206C6F636B696E6720616E206576656E7460293B0D0A202020202020202024282762';
wwv_flow_api.g_varchar2_table(247) := '6F647927292E636C656172517565756528293B0D0A0D0A20202020202020202F2F20507574206576656E74206F6E2071756172616E74696E654C69737420746F2070726576656E7420646F75626C6520657865637574696F6E0D0A202020202020202071';
wwv_flow_api.g_varchar2_table(248) := '756172616E74696E654C6973742E707573682874726967676572696E67456C656D656E742E6576656E74293B0D0A2020202020202020617065782E64656275672E696E666F28604576656E742027247B74726967676572696E67456C656D656E742E6576';
wwv_flow_api.g_varchar2_table(249) := '656E747D2720707573686564206F6E2071756172616E74696E6560293B0D0A0D0A20202020202020202F2F20506F70206576656E7420616674657220435F4C4F434B5F4C454E4754482066726F6D2071756172616E74696E650D0A202020202020202073';
wwv_flow_api.g_varchar2_table(250) := '657454696D656F7574280D0A2020202020202020202066756E6374696F6E28297B0D0A202020202020202020202071756172616E74696E654C697374203D205B5D3B0D0A2020202020202020202020617065782E64656275672E696E666F28604576656E';
wwv_flow_api.g_varchar2_table(251) := '742027247B74726967676572696E67456C656D656E742E6576656E747D2720706F707065642066726F6D2071756172616E74696E6560293B0D0A202020202020202020207D2C0D0A20202020202020202020435F4C4F434B5F4C454E4754480D0A202020';
wwv_flow_api.g_varchar2_table(252) := '2020202020293B0D0A0D0A20202020202020202F2F204164646974696F6E616C6C792064697361626C6520627574746F6E20746F2070726576656E7420646F75626C6520636C69636B2E2057696C6C20626520656E61626C656420627920746865207265';
wwv_flow_api.g_varchar2_table(253) := '73706F6E7365206F66204144430D0A20202020202020206966202874726967676572696E67456C656D656E742E6973436C69636B297B0D0A20202020202020202020617065782E64656275672E696E666F28604C6F636B696E6720627574746F6E202724';
wwv_flow_api.g_varchar2_table(254) := '7B74726967676572696E67456C656D656E742E69647D2760293B0D0A20202020202020202020617065782E6974656D2874726967676572696E67456C656D656E742E6964292E64697361626C6528293B0D0A20202020202020207D0D0A2020202020207D';
wwv_flow_api.g_varchar2_table(255) := '0D0A202020207D0D0A2020202072657475726E2069734F6B546F52616973654576656E743B0D0A20207D3B202F2F206D61696E7461696E416E64436865636B4576656E744C6F636B0D0A20200D0A20202F2A202B2B2B2B2B20454E442050524956415445';
wwv_flow_api.g_varchar2_table(256) := '20202B2B2B2B2B2B2B2B202A2F0D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B2B20434F52452046554E4354494F4E414C495459202B2B2B2B2B2B2B2B2B2B202A2F0D0A0D0A20202F2A2A204150455820756E69717565206964656E74696669657220666F';
wwv_flow_api.g_varchar2_table(257) := '72207468652064796E616D696320616374696F6E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E616A61784964656E746966696572';
wwv_flow_api.g_varchar2_table(258) := '203D207B7D3B0D0A0D0A20202F2A2A204C697374206F662070616765206974656D732074686174207265636569766564206368616E676573206C6174656C790D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E616463';
wwv_flow_api.g_varchar2_table(259) := '0D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E6C6173744974656D56616C756573203D207B7D3B0D0A0D0A20202F2A2A0D0A2020202A2043656E7472616C206576656E742068616E646C65722C2063616C6C7320414443206173';
wwv_flow_api.g_varchar2_table(260) := '796E6368726F6E6F75736C7920616E642068616E646C65732041444320726573706F6E73650D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A202061';
wwv_flow_api.g_varchar2_table(261) := '64632E65786563757465203D2066756E6374696F6E28297B0D0A0D0A202020206966286D61696E7461696E416E64436865636B4576656E744C6F636B2829297B0D0A202020202020766172206164646974696F6E616C506167654974656D73203D207472';
wwv_flow_api.g_varchar2_table(262) := '6967676572696E67456C656D656E742E646174612E6164646974696F6E616C506167654974656D73207C7C205B5D3B200D0A20202020202076617220706167654974656D73203D206E657720536574285B2E2E2E6164632E706167654974656D732C202E';
wwv_flow_api.g_varchar2_table(263) := '2E2E6164646974696F6E616C506167654974656D735D293B0D0A202020202020706167654974656D73203D2041727261792E66726F6D28706167654974656D73293B0D0A2020202020200D0A202020202020617065782E64656275672E696E666F286041';
wwv_flow_api.g_varchar2_table(264) := '44432068616E646C6573206576656E7420247B74726967676572696E67456C656D656E742E6576656E747D60293B0D0A202020202020617065782E64656275672E696E666F28604144432073656E647320506167654974656D7320247B6164632E706167';
wwv_flow_api.g_varchar2_table(265) := '654974656D732E6A6F696E28297D60293B0D0A2020202020207365727665722E706C7567696E280D0A20202020202020206164632E616A61784964656E7469666965722C0D0A20202020202020207B0D0A2020202020202020202022783031223A207472';
wwv_flow_api.g_varchar2_table(266) := '6967676572696E67456C656D656E742E69642C0D0A2020202020202020202022783032223A2074726967676572696E67456C656D656E742E6576656E742C0D0A2020202020202020202022783033223A204A534F4E2E737472696E676966792874726967';
wwv_flow_api.g_varchar2_table(267) := '676572696E67456C656D656E742E64617461292C0D0A2020202020202020202022706167654974656D73223A20706167654974656D730D0A20202020202020207D2C0D0A20202020202020207B0D0A20202020202020202020226461746154797065223A';
wwv_flow_api.g_varchar2_table(268) := '202268746D6C222C0D0A202020202020202020202273756363657373223A2066756E6374696F6E202870414443526573706F6E736529207B0D0A2020202020202020202020206966202874726967676572696E67456C656D656E742E6973436C69636B29';
wwv_flow_api.g_varchar2_table(269) := '207B0D0A2020202020202020202020202020617065782E6974656D2874726967676572696E67456C656D656E742E6964292E656E61626C6528293B0D0A2020202020202020202020207D0D0A20202020202020202020202065786563757465436F646528';
wwv_flow_api.g_varchar2_table(270) := '70414443526573706F6E7365293B0D0A202020202020202020207D0D0A20202020202020207D0D0A202020202020293B0D0A2020202020202F2F207265736574206164646974696F6E616C206F6E652074696D652070616765206974656D730D0A202020';
wwv_flow_api.g_varchar2_table(271) := '2020206164632E6164646974696F6E616C4974656D73203D205B5D3B0D0A202020207D0D0A20207D3B0D0A0D0A0D0A20202F2A2A0D0A2020202A20496E697469616C697A6174696F6E206D6574686F642E3C62723E0D0A2020202A2054686973206D6574';
wwv_flow_api.g_varchar2_table(272) := '686F642069732063616C6C656420647572696E672072656E646572696E67206F6620746865204150455820706167652E20497420696E7374616C6C732074686520706C7567696E206F6E20746865207061676520616E6420637265617465732074686520';
wwv_flow_api.g_varchar2_table(273) := '6E6563657373617279206576656E742068616E646C65722E0D0A2020202A20546F2061636869766520746869732C20706172616D65746572203C70416374696F6E3E207769746820746865206E6563657373617279206174747269627574657320697320';
wwv_flow_api.g_varchar2_table(274) := '70617373656420696E20616E64206576616C75617465642E3C62723E0D0A2020202A2040706172616D207B70416374696F6E7D2070416374696F6E204A736F6E206F626A6563742070617373656420696E20647572696E6720696E697469616C697A6174';
wwv_flow_api.g_varchar2_table(275) := '696F6E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E696E6974203D2066756E6374696F6E202870416374696F6E29207B0D0A2020';
wwv_flow_api.g_varchar2_table(276) := '20202F2F2062696E6420616C6C2070616765206974656D73207265717569726564206279204144430D0A202020206164632E62696E644974656D73203D20242E70617273654A534F4E2870416374696F6E2E61747472696275746530312E7265706C6163';
wwv_flow_api.g_varchar2_table(277) := '65282F7E2F672C2027222729293B0D0A202020200D0A202020202F2F20726567697374657220616C6C207265717569726564206974656D7320287468652061637475616C2076616C7565206F662074686F7365206974656D732077696C6C20626520696E';
wwv_flow_api.g_varchar2_table(278) := '636C7564656420696E20616E79204144432063616C6C290D0A202020206164632E706167654974656D73203D205B5D3B0D0A202020206164632E6164646974696F6E616C4974656D73203D205B5D3B0D0A202020206966202870416374696F6E2E617474';
wwv_flow_api.g_varchar2_table(279) := '726962757465303229207B0D0A202020202020617065782E64656275672E696E666F2827526571756972656420506167654974656D733A2027202B2070416374696F6E2E6174747269627574653032293B0D0A2020202020206164632E70616765497465';
wwv_flow_api.g_varchar2_table(280) := '6D73203D2070416374696F6E2E61747472696275746530322E73706C697428272C27293B0D0A202020207D0D0A0D0A2020202062696E644F627365727665724974656D732870416374696F6E2E6174747269627574653035293B0D0A0D0A202020202F2F';
wwv_flow_api.g_varchar2_table(281) := '207265676973746572206164632E417065784A53206E616D657370616365206F626A65637420616E6420416A6178206964656E7469666965720D0A202020206164632E417065784A53203D206576616C2870416374696F6E2E6174747269627574653033';
wwv_flow_api.g_varchar2_table(282) := '293B0D0A202020206164632E616A61784964656E746966696572203D2070416374696F6E2E616A61784964656E7469666965723B0D0A0D0A202020202F2F2050726570617265207061676520666F72204144432075736167650D0A2020202062696E6445';
wwv_flow_api.g_varchar2_table(283) := '76656E747328293B0D0A20202020617065782E64656275672E696E666F282741444320696E697469616C697A656427293B0D0A0D0A202020202F2F206578636575746520696E697469616C204A61766153637269707420636F6465207061737365642069';
wwv_flow_api.g_varchar2_table(284) := '6E2066726F6D20746865207365727665720D0A2020202065786563757465436F646528686578546F436861722870416374696F6E2E617474726962757465303429293B0D0A20207D3B0D0A20202F2A202B2B2B2B2B2B2B2B2B20454E4420434F52452046';
wwv_flow_api.g_varchar2_table(285) := '554E4354494F4E414C495459202B2B2B2B2B2B2B2B2B2B2B202A2F0D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B2053595354454D20414354494F4E205459504553202B2B2B2B2B2B2B2B2B2B2B202A2F0D0A0D0A20202F2A2A0D0A2020202A2053657473';
wwv_flow_api.g_varchar2_table(286) := '20766572746963616C20616C69676E6D656E74206F6620495220616E6420494720746F20746F702E2044656C65676174657320616C69676E696E6720746F203C6164632E417065784A533E2E0D0A2020202A2040706172616D207B737472696E677D2070';
wwv_flow_api.g_varchar2_table(287) := '53656C6563746F72206A51756572792073656C6563746F72206F662074686520726567696F6E7320746F2061646A75737420766572746963616C20616C69676E6D656E740D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C756769';
wwv_flow_api.g_varchar2_table(288) := '6E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E616C69676E5265706F7274566572746963616C546F70203D2066756E6374696F6E20287053656C6563746F7229207B0D0A20202020666F7245616368287053656C65';
wwv_flow_api.g_varchar2_table(289) := '63746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427293B0D0A2020202020206164632E417065784A532E616C69676E5265706F7274566572746963616C546F';
wwv_flow_api.g_varchar2_table(290) := '7028704974656D4964293B0D0A202020207D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2042696E64206120636F6E6669726D6174696F6E206469616C6F6720746F206120627574746F6E20746F2073686F77206120636F6E6669726D6174';
wwv_flow_api.g_varchar2_table(291) := '696F6E206469616C6F67206265666F726520616E206576656E74206973207261697365640D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F662074686520627574746F6E20746F2062696E6420746865206576656E';
wwv_flow_api.g_varchar2_table(292) := '7420746F0D0A2020202A2040706172616D207B737472696E677D20704D65737361676520436F6E6669726D6174696F6E206D6573736167650D0A2020202A2040706172616D207B737472696E677D20704469616C6F675469746C65205469746C65206F66';
wwv_flow_api.g_varchar2_table(293) := '2074686520636F6E6669726D6174696F6E206469616C6F6720626F780D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E62696E64436F';
wwv_flow_api.g_varchar2_table(294) := '6E6669726D6174696F6E203D2066756E6374696F6E2028704974656D49642C20704D6573736167652C20704469616C6F675469746C6529207B0D0A20202020766172202474686973203D2024286023247B704974656D49647D60293B0D0A202020202020';
wwv_flow_api.g_varchar2_table(295) := '766172206576656E744C6973743B0D0A0D0A202020206966202824746869732E6C656E677468203E203029207B0D0A2020202020202F2F20456C656D656E7420697320616C736F2070726573656E74206F6E20706167652028636F756C64206265206D69';
wwv_flow_api.g_varchar2_table(296) := '7373696E672064756520746F20636F6E646974696F6E290D0A2020202020206576656E744C697374203D20242E5F646174612824746869732E6765742830292C20276576656E747327293B0D0A20202020202069662028747970656F66206576656E744C';
wwv_flow_api.g_varchar2_table(297) := '69737420213D2027756E646566696E656427202626206576656E744C6973745B435F434C49434B5F4556454E545D29207B0D0A202020202020202024746869732E6F666628435F434C49434B5F4556454E54293B0D0A2020202020207D0D0A2020202020';
wwv_flow_api.g_varchar2_table(298) := '202F2F2062696E6420636F6E6669726D6174696F6E2068616E646C657220746F2074686520636C69636B206576656E740D0A20202020202024746869732E6F6E28435F434C49434B5F4556454E542C0D0A2020202020202020202020202020207B202261';
wwv_flow_api.g_varchar2_table(299) := '6A61784964656E746966696572223A206164632E616A61784964656E7469666965722C0D0A2020202020202020202020202020202020226D657373616765223A20704D6573736167652C0D0A202020202020202020202020202020202022706167654974';
wwv_flow_api.g_varchar2_table(300) := '656D73223A206164632E706167654974656D732C0D0A2020202020202020202020202020202020227469746C65223A20704469616C6F675469746C650D0A2020202020202020202020202020207D2C0D0A202020202020202020202020202020636F6E66';
wwv_flow_api.g_varchar2_table(301) := '69726D43616C6C6261636B293B0D0A202020207D0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2042696E64206120636F6E6669726D6174696F6E206469616C6F6720746F206120627574746F6E20746F2073686F77206120636F6E6669726D6174';
wwv_flow_api.g_varchar2_table(302) := '696F6E206469616C6F67206265666F726520616E206576656E74206973207261697365640D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F662074686520627574746F6E20746F2062696E6420746865206576656E';
wwv_flow_api.g_varchar2_table(303) := '7420746F0D0A2020202A2040706172616D207B737472696E677D20704D65737361676520436F6E6669726D6174696F6E206D6573736167650D0A2020202A2040706172616D207B737472696E677D20704469616C6F675469746C65205469746C65206F66';
wwv_flow_api.g_varchar2_table(304) := '2074686520636F6E6669726D6174696F6E206469616C6F6720626F780D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E62696E64556E';
wwv_flow_api.g_varchar2_table(305) := '73617665645761726E696E67203D2066756E6374696F6E2028704974656D49642C20704D6573736167652C20704469616C6F675469746C6529207B0D0A20202020766172202474686973203D2024286023247B704974656D49647D60293B0D0A20202020';
wwv_flow_api.g_varchar2_table(306) := '2020766172206576656E744C6973743B0D0A0D0A202020206966202824746869732E6C656E677468203E203029207B0D0A2020202020202F2F20456C656D656E7420697320616C736F2070726573656E74206F6E20706167652028636F756C6420626520';
wwv_flow_api.g_varchar2_table(307) := '6D697373696E672064756520746F20636F6E646974696F6E290D0A2020202020206576656E744C697374203D20242E5F646174612824746869732E6765742830292C20276576656E747327293B0D0A20202020202069662028747970656F66206576656E';
wwv_flow_api.g_varchar2_table(308) := '744C69737420213D2027756E646566696E656427202626206576656E744C6973745B435F434C49434B5F4556454E545D29207B0D0A202020202020202024746869732E6F666628435F434C49434B5F4556454E54293B0D0A2020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(309) := '2020202F2F2062696E6420636F6E6669726D6174696F6E2068616E646C657220746F2074686520636C69636B206576656E740D0A20202020202024746869732E6F6E28435F434C49434B5F4556454E542C0D0A2020202020202020202020202020207B20';
wwv_flow_api.g_varchar2_table(310) := '22616A61784964656E746966696572223A206164632E616A61784964656E7469666965722C0D0A2020202020202020202020202020202020226D657373616765223A20704D6573736167652C0D0A20202020202020202020202020202020202270616765';
wwv_flow_api.g_varchar2_table(311) := '4974656D73223A206164632E706167654974656D732C0D0A2020202020202020202020202020202020227469746C65223A20704469616C6F675469746C650D0A2020202020202020202020202020207D2C0D0A202020202020202020202020202020756E';
wwv_flow_api.g_varchar2_table(312) := '736176656443616C6C6261636B293B0D0A202020207D0D0A20207D3B0D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A206164632E636F6E6669726D416E6445786563757465436F6D6D616E640D0A2020202020204D6574686F6420';
wwv_flow_api.g_varchar2_table(313) := '746F2062696E642074686520657865637574696F6E206F662061207061676520636F6D6D616E6420746F206120706F73697469766520726573756C74206F66206120636F6E6669726D6174696F6E206469616C6F672E0D0A2020202020200D0A20202020';
wwv_flow_api.g_varchar2_table(314) := '506172616D65746572733A0D0A202020202020704D657373616765202D204D65737361676520746F2073686F7720696E2074686520636F6E6669726D6174696F6E206469616C6F670D0A2020202020207044617461202D204E616D65206F662074686520';
wwv_flow_api.g_varchar2_table(315) := '636F6D6D616E6420746F2065786563757465206F722061204A534F4E20696E7374616E636520636F6E7461696E696E672074686520636F6D6D616E64206E616D6520616E64206164646974696F6E616C20696E666F726D6174696F6E2E0D0A2020202020';
wwv_flow_api.g_varchar2_table(316) := '20704974656D202D204974656D2074686174206765747320666F6375732069662074686520636F6E6669726D6174696F6E206973206E6F7420676976656E2E0D0A2020202A2F0D0A20206164632E636F6E6669726D416E6445786563757465436F6D6D61';
wwv_flow_api.g_varchar2_table(317) := '6E64203D2066756E6374696F6E2028704D6573736167652C2070446174612C20704974656D297B0D0A2020202074726967676572696E67456C656D656E742E6576656E74203D2027636F6D6D616E64273B0D0A2020202074726967676572696E67456C65';
wwv_flow_api.g_varchar2_table(318) := '6D656E742E6964203D2027434F4D4D414E44273B0D0A2020202074726967676572696E67456C656D656E742E6973436C69636B203D2066616C73653B202020200D0A202020202F2F2048616E646C65206576656E74206F6E6C7920616674657220636F6E';
wwv_flow_api.g_varchar2_table(319) := '6669726D6174696F6E2066726F6D2074686520757365720D0A202020206164632E417065784A532E636F6E6669726D5265717565737428704576656E742C2066756E6374696F6E2829207B6164632E65786563757465436F6D6D616E6428704461746129';
wwv_flow_api.g_varchar2_table(320) := '3B7D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2065786563757465436F6D6D616E640D0A202020202020577261707065722061726F756E64203C6164632E657865637574653E207468617420726169736573206120';
wwv_flow_api.g_varchar2_table(321) := '636F6D6D616E64206576656E7420616C6F6E67207769746820746865206E656365737361727920646174612E0D0A2020202020200D0A20202020202054686973206D6574686F64206973207573656420617320746865207374616E646172642061637469';
wwv_flow_api.g_varchar2_table(322) := '6F6E20666F72206120636F6D6D616E64206F626A65637420746F206D616B65207375726520746861742041444320697320696E666F726D656420746861740D0A202020202020616E20414443206D61696E7461696E6564204150455820616374696F6E20';
wwv_flow_api.g_varchar2_table(323) := '77617320696E766F6B65642E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020705F64617461202D20496E7374616E6365206F662074797065203C636F6D6D616E64446174613E2C204E616D65206F662074686520636F';
wwv_flow_api.g_varchar2_table(324) := '6D6D616E6420746F2065786563757465206F722061204A534F4E0D0A202020202020202020202020202020696E7374616E636520636F6E7461696E696E672074686520636F6D6D616E64206E616D6520616E64206164646974696F6E616C20696E666F72';
wwv_flow_api.g_varchar2_table(325) := '6D6174696F6E2E0D0A2020202A2F0D0A20206164632E65786563757465436F6D6D616E64203D2066756E6374696F6E287044617461297B0D0A2020202076617220646174613B0D0A20202020766172206576656E74203D207B7D3B0D0A202020200D0A20';
wwv_flow_api.g_varchar2_table(326) := '202020696628747970656F66207044617461203D3D2027737472696E6727297B0D0A20202020202064617461203D207B22636F6D6D616E64223A70446174612C20226164646974696F6E616C506167654974656D73223A5B5D2C20226D6F6E69746F7243';
wwv_flow_api.g_varchar2_table(327) := '68616E676573223A2066616C73657D3B0D0A202020207D0D0A20202020656C73657B0D0A20202020202064617461203D2070446174613B0D0A202020202020646174612E6164646974696F6E616C506167654974656D73203D20646174612E6164646974';
wwv_flow_api.g_varchar2_table(328) := '696F6E616C506167654974656D73207C7C205B5D3B0D0A202020202020646174612E6D6F6E69746F724368616E676573203D20646174612E6D6F6E69746F724368616E676573207C7C2066616C73653B0D0A202020207D0D0A202020200D0A2020202074';
wwv_flow_api.g_varchar2_table(329) := '726967676572696E67456C656D656E74203D207B0D0A202020202020226576656E74223A22636F6D6D616E64222C0D0A202020202020226964223A22434F4D4D414E44222C0D0A202020202020226973436C69636B223A66616C73652C0D0A2020202020';
wwv_flow_api.g_varchar2_table(330) := '202264617461223A646174610D0A202020207D3B0D0A202020200D0A2020202069662870446174612E6D6F6E69746F724368616E67657320262620686173556E73617665644368616E6765732829297B0D0A20202020202020202F2F20556E7361766564';
wwv_flow_api.g_varchar2_table(331) := '206368616E67657320616D6F6E6720746865206F627365727665642070616765206974656D732C20636865636B207769746820757365720D0A20202020202020206576656E742E64617461203D2070446174613B0D0A20202020202020206576656E742E';
wwv_flow_api.g_varchar2_table(332) := '646174612E6D657373616765203D20706167655374617475732E6D6573736167653B0D0A20202020202020206576656E742E646174612E7469746C65203D20706167655374617475732E7469746C653B0D0A20202020202020206164632E417065784A53';
wwv_flow_api.g_varchar2_table(333) := '2E636F6E6669726D52657175657374286576656E742C206164632E65786563757465293B2020202020200D0A202020207D656C73657B0D0A2020202020206164632E6578656375746528293B0D0A202020207D0D0A20207D3B0D0A0D0A20202F2A2A0D0A';
wwv_flow_api.g_varchar2_table(334) := '2020202046756E6374696F6E3A206164632E6765745265706F727453656C656374696F6E0D0A2020202020205265636F676E697A65732073656C656374696F6E206368616E676573206F6E20496E746572616374697665207265706F7274732C20696E74';
wwv_flow_api.g_varchar2_table(335) := '6572616374697665206772696473206F7220636C6173736963207265706F7274732E0D0A202020202020546F206761746865722061636365737320746F20746865207072696D617279206B65792076616C75652C206974206973206E6563657373617279';
wwv_flow_api.g_varchar2_table(336) := '20746F206F6265792074686520666F6C6C6F77696E6720636F6E76656E74696F6E733A0D0A2020202020200D0A2020202020202D20496E20696E74657261637469766520616E6420636C6173736963207265706F7274732C20612076697369626C652063';
wwv_flow_api.g_varchar2_table(337) := '6F6C756D6E206D75737420636F6E7461696E20612068746D6C2065787072657373696F6E20776974682061203C646174612D69643E206174747269627574650D0A2020202020202020636F6E7461696E696E672074686520504B2076616C75653A203C26';
wwv_flow_api.g_varchar2_table(338) := '6C743B7370616E20646174612D69643D2223504B5F434F4C554D4E23222667743B2356495349424C455F434F4C554D4E23266C743B2F7370616E2667743B3E3E6C693E0D0A2020202020202D20496E20696E74657261637469766520677269642C206974';
wwv_flow_api.g_varchar2_table(339) := '20697320706F737369626C6520746F20656974686572206964656E7469667920612073696E676C6520636F6C756D6E206F6620746865207265706F727420617320746865207072696D617279206B657920636F6C756D6E0D0A2020202020202020284144';
wwv_flow_api.g_varchar2_table(340) := '4320646F6573206E6F7420737570706F7274206D756C7469706C65206B657920636F6C756D6E732079657429206F722062792070617373696E6720616E206F7264696E616C206E756D6265722028312062617365642920706F696E74696E6720746F2074';
wwv_flow_api.g_varchar2_table(341) := '686520636F6C756D6E0D0A2020202020202020636F6E7461696E696E6720746865207072696D617279206B65792E20546865206F7264657220697320646566696E656420627920746865206F72646572206F66207468652053514C207175657279206F72';
wwv_flow_api.g_varchar2_table(342) := '2074686520636F6C756D6E206F7264657220726573706563746976656C792E0D0A202020202020200D0A2020202020204966206E6F2070616765206974656D20746F2073746F726520746865207072696D617279206B65792076616C7565206973207072';
wwv_flow_api.g_varchar2_table(343) := '6F76696465642C2074686973206D6574686F6420726169736573206576656E74203C61646373656C656374696F6E6368616E67653E207768696368200D0A20202020202063616E20626520646574656374656420696E2041444320627920717565727969';
wwv_flow_api.g_varchar2_table(344) := '6E67207468652070736575646F20636F6C756D6E203C53454C454354494F4E5F4348414E4745443E2E200D0A20202020202054686520636F6C756D6E20636F6E7461696E7320746865207265706F7274204944206F6E2077686963682074686520657665';
wwv_flow_api.g_varchar2_table(345) := '6E74207761732066697265642E20546865207072696D617279206B65792076616C75650D0A20202020202069732070726F76696465642076696120746865206576656E7420646174612070726F706572747920616E642063616E20626520726561642066';
wwv_flow_api.g_varchar2_table(346) := '726F6D20504C2F53514C206279207573696E67206164632E6765745F6576656E745F64617461206F7220696E204A617661536372697074200D0A2020202020207769746820746865207265706C6163656D656E7420416E63686F72203C234556454E545F';
wwv_flow_api.g_varchar2_table(347) := '44415441233E202877697468696E20414443206F6E6C79292E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020705265706F72744964202D204944206F6620746865207265706F727420746F206F6273657276650D0A20';
wwv_flow_api.g_varchar2_table(348) := '2020202020704974656D4964202D204944206F66207468652070616765206974656D20746F2073617665207468652073656C656374696F6E20746F2E204966207365742C207468652076616C7565206F66207468652070616765206974656D2077696C6C';
wwv_flow_api.g_varchar2_table(349) := '206265206368616E6765640D0A20202020202020202020202020202020746F20746865204944206F66207468652073656C656374656420726F772E204966206E6F74207365742C20746865206D6574686F642077696C6C207261697365206576656E7420';
wwv_flow_api.g_varchar2_table(350) := '3C61646373656C656374696F6E6368616E67653E20776974682074686520494420617320646174612E0D0A20202020202070436F6C756D6E202D204F7074696F6E616C206F7264696E617279206E756D626572206F662074686520636F6C756D6E20636F';
wwv_flow_api.g_varchar2_table(351) := '6E7461696E696E672074686520504B20696E666F726D6174696F6E200D0A20202020202020202020202020202020284947206F6E6C7920616E64206E6563657373617279206F6E6C79206966206E6F2073696E676C65207072696D617279206B65792063';
wwv_flow_api.g_varchar2_table(352) := '6F6C756D6E2069732061646D696E69737465726564290D0A2020202A2F0D0A20206164632E6765745265706F727453656C656374696F6E203D2066756E6374696F6E28705265706F727449642C20704974656D49642C2070436F6C756D6E297B0D0A2020';
wwv_flow_api.g_varchar2_table(353) := '2020766172207265706F727424203D2024286023247B705265706F727449647D60293B0D0A202020207661722074726565243B0D0A202020207661722073656C65637465644E6F6465733B0D0A202020207661722069644C6973743B0D0A202020207661';
wwv_flow_api.g_varchar2_table(354) := '7220706B56616C75653B0D0A0D0A2020202076617220706572736973744F725265706F7274203D2066756E6374696F6E287056616C7565297B0D0A202020202020696628704974656D4964297B0D0A2020202020202020617065782E6974656D28704974';
wwv_flow_api.g_varchar2_table(355) := '656D4964292E73657456616C7565287056616C7565293B0D0A2020202020207D0D0A202020202020656C73657B0D0A20202020202020202F2F204E6F206974656D2070726573656E742C207375626D69742049442077697468206576656E7420435F5345';
wwv_flow_api.g_varchar2_table(356) := '4C454354494F4E5F4348414E47450D0A202020202020202074726967676572696E67456C656D656E742E6964203D20705265706F727449643B0D0A202020202020202074726967676572696E67456C656D656E742E6576656E74203D20435F53454C4543';
wwv_flow_api.g_varchar2_table(357) := '54494F4E5F4348414E47453B0D0A202020202020202074726967676572696E67456C656D656E742E6973436C69636B203D2066616C73653B0D0A202020202020202074726967676572696E67456C656D656E742E64617461203D207056616C75653B0D0A';
wwv_flow_api.g_varchar2_table(358) := '20202020202020206164632E6578656375746528293B0D0A2020202020207D0D0A202020207D3B0D0A0D0A202020202F2F204578616D696E652074797065206F66207265706F727420616E642062696E6420636C69636B2068616E646C65720D0A202020';
wwv_flow_api.g_varchar2_table(359) := '2073776974636828676574526567696F6E5479706528705265706F7274496429297B0D0A2020202020206361736520435F524547494F4E5F43523A0D0A20202020202020207265706F7274242E6F6E2827636C69636B272C20272E742D5265706F72742D';
wwv_flow_api.g_varchar2_table(360) := '7265706F72742074626F6479207472272C2066756E6374696F6E28297B0D0A20202020202020202020706B56616C7565203D20242874686973292E66696E6428277464205B646174612D69645D27292E646174612827696427293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(361) := '202020706572736973744F725265706F727428706B56616C7565293B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49473A0D0A20202020202020207265706F7274242E';
wwv_flow_api.g_varchar2_table(362) := '6F6E28435F49475F53454C454354494F4E5F4348414E47452C2066756E6374696F6E28652C2064617461297B0D0A20202020202020202020696628646174612E73656C65637465645265636F7264732E6C656E677468297B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(363) := '20202F2F2054727920746F2067657420746865207072696D617279206B657920696E666F726D6174696F6E2066726F6D20746865206964656E7469747920636F6C756D6E2E0D0A2020202020202020202020202F2F204966206E6F6E6520657869737473';
wwv_flow_api.g_varchar2_table(364) := '2C206765742069742066726F6D2074686520636F6C756D6E20696E6465782070617373656420696E0D0A20202020202020202020202069662870436F6C756D6E297B0D0A2020202020202020202020202020706B56616C7565203D20646174612E73656C';
wwv_flow_api.g_varchar2_table(365) := '65637465645265636F7264735B305D5B4D6174682E6D61782870436F6C756D6E202D20312C2030295D3B0D0A2020202020202020202020207D656C73657B0D0A2020202020202020202020202020706B56616C7565203D20646174612E6D6F64656C2E67';
wwv_flow_api.g_varchar2_table(366) := '65745265636F7264496428646174612E73656C65637465645265636F7264735B305D293B0D0A2020202020202020202020207D0D0A202020202020202020202020706572736973744F725265706F727428706B56616C7565293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(367) := '20207D0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49523A0D0A20202020202020207265706F7274242E6F6E2827636C69636B272C20272E612D4952522D7461626C65';
wwv_flow_api.g_varchar2_table(368) := '2074723A6E6F74283A66697273742D6368696C6429272C2066756E6374696F6E28297B0D0A20202020202020202020706B56616C7565203D20242874686973292E66696E6428277464205B646174612D69645D27292E646174612827696427293B0D0A20';
wwv_flow_api.g_varchar2_table(369) := '202020202020202020706572736973744F725265706F727428706B56616C7565293B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F545245453A0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(370) := '7472656524203D2024286023247B705265706F727449647D5F7472656560293B0D0A202020202020202074726565242E6F6E28435F545245455F53454C454354494F4E5F4348414E47452C2066756E6374696F6E28297B0D0A2020202020202020202073';
wwv_flow_api.g_varchar2_table(371) := '656C65637465644E6F646573203D2074726565242E7472656556696577282767657453656C65637465644E6F64657327293B0D0A2020202020202020202069644C697374203D2073656C65637465644E6F6465730D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(372) := '20202020202E6D61702866756E6374696F6E286974656D297B72657475726E206974656D2E69643B7D290D0A202020202020202020202020202020202020202E6A6F696E28273A27293B0D0A20202020202020202020706572736973744F725265706F72';
wwv_flow_api.g_varchar2_table(373) := '742869644C697374293B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A206164632E666F6375730D0A2020202020204D657468';
wwv_flow_api.g_varchar2_table(374) := '6F6420746F206578706C696369746C79207365742074686520666F63757320746F2074686520726571756573746564206974656D0D0A202020200D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944206F66207468';
wwv_flow_api.g_varchar2_table(375) := '65206974656D20746F20736574207468746520666F63757320746F0D0A2020202A2F0D0A20206164632E666F637573203D2066756E6374696F6E28704974656D4964297B0D0A2020202024286023247B704974656D49647D60292E666F63757328293B0D';
wwv_flow_api.g_varchar2_table(376) := '0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A206164632E686964655265706F727446696C74657250616E656C0D0A20202020202048696465732066696C7465722070616E656C732066726F6D20495220616E642049472E';
wwv_flow_api.g_varchar2_table(377) := '2044656C65676174657320686964696E67207468652066696C7465722070616E656C20746F203C6164632E417065784A533E2E0D0A2020202020200D0A20202020506172616D65746572733A0D0A2020202020207053656C6563746F72206A5175657279';
wwv_flow_api.g_varchar2_table(378) := '2073656C6563746F72206F662074686520726567696F6E73207468617420636F6E7461696E20612066696C7465722070616E656C20746F20686964652E0D0A2020202A2F0D0A20206164632E686964655265706F727446696C74657250616E656C203D20';
wwv_flow_api.g_varchar2_table(379) := '66756E6374696F6E20287053656C6563746F7229207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E61747472282769642729';
wwv_flow_api.g_varchar2_table(380) := '3B0D0A2020202020206164632E417065784A532E686964655265706F727446696C74657250616E656C28704974656D4964293B0D0A202020207D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A204D6574686F6420746F2073686F772061206E';
wwv_flow_api.g_varchar2_table(381) := '6F74696669636174696F6E20746F2074686520757365722E2044656C65676174657320696D706C656D656E746174696F6E20746F203C6164632E417065784A533E2E3C62723E0D0A2020202A2041206E6F74696669636174696F6E2069732061206D6573';
wwv_flow_api.g_varchar2_table(382) := '7361676520746861742069732073686F776E20617320612073756363657373206D65737361676520746F2074686520757365722E0D0A2020202A2040706172616D207B737472696E677D20704D657373616765204D657373616765207468617420697320';
wwv_flow_api.g_varchar2_table(383) := '73686F776E20746F2074686520757365722E205265706C6163657320616E79206578697374696E67206D657373616765732E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69';
wwv_flow_api.g_varchar2_table(384) := '630D0A2020202A2F0D0A20206164632E6E6F74696679203D2066756E6374696F6E2028704D65737361676529207B0D0A202020206164632E417065784A532E7365744E6F74696669636174696F6E28704D657373616765293B0D0A20207D3B0D0A0D0A20';
wwv_flow_api.g_varchar2_table(385) := '2066756E6374696F6E2070617573654368616E67654576656E74447572696E675265667265736828704974656D49642C20704974656D56616C7565297B0D0A2020202076617220246974656D203D2024286023247B704974656D49647D60293B0D0A2020';
wwv_flow_api.g_varchar2_table(386) := '2020766172206E6F6465203D20246974656D2E6765742830293B0D0A20202020766172206974656D4576656E74733B0D0A202020207661722074656D706F72616C4576656E74733B0D0A0D0A2020202069662028246974656D2E6C656E677468203E2030';
wwv_flow_api.g_varchar2_table(387) := '297B0D0A2020202020202F2F2052656672657368207468726F77732061206368616E6765206576656E742077686963682063616E206C65616420746F20756E77616E746564204D414E4441544F525920636865636B73207072696F7220746F2073657474';
wwv_flow_api.g_varchar2_table(388) := '696E67207468652076616C75650D0A2020202020202F2F206368616E6765206576656E747320617265207468657265666F72652072656D6F76656420616E6420726561747461636865642061667465722073657474696E67207468652076616C75652E0D';
wwv_flow_api.g_varchar2_table(389) := '0A2020202020202F2F20706572736973742061637475616C6C792061737369676E6564206576656E742068616E646C6572730D0A2020202020206974656D4576656E7473203D20242E5F64617461286E6F64652C20276576656E747327293B0D0A202020';
wwv_flow_api.g_varchar2_table(390) := '2020200D0A2020202020202F2F204D616B652061206465657020636F7079206F66206576656E74732C2072656D6F7665206368616E676520616E642061737369676E20697420746F20746865206974656D0D0A20202020202074656D706F72616C457665';
wwv_flow_api.g_varchar2_table(391) := '6E7473203D20242E657874656E6428747275652C205B5D2C206974656D4576656E7473293B0D0A20202020202064656C6574652074656D706F72616C4576656E74732E6368616E67653B0D0A202020202020242E5F64617461286E6F64652C2027657665';
wwv_flow_api.g_varchar2_table(392) := '6E7473272C2074656D706F72616C4576656E7473293B0D0A2020202020200D0A202020202020246974656D0D0A2020202020202E6F6E6528435F415045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(393) := '69662028704974656D56616C7565297B0D0A20202020202020202020617065782E6974656D28704974656D4964292E73657456616C756528704974656D56616C75652C20704974656D56616C75652C2074727565293B0D0A202020202020202020202F2F';
wwv_flow_api.g_varchar2_table(394) := '20696620776520617265206F6273657276696E672074686973206974656D20666F72206368616E6765732C20757064617465207468652076616C756520746F2070726576656E742066616C732074727565206368616E6765206D657373616765730D0A20';
wwv_flow_api.g_varchar2_table(395) := '20202020202020202069662028706167655374617475732E6974656D4D61702E68617328704974656D496429297B0D0A202020202020202020202020706167655374617475732E6974656D4D61702E73657428704974656D49642C20704974656D56616C';
wwv_flow_api.g_varchar2_table(396) := '7565293B0D0A202020202020202020207D3B0D0A20202020202020207D3B200D0A20202020202020202F2F20726573746F7265206F726967696E616C206576656E74730D0A2020202020202020242E5F64617461286E6F64652C20276576656E7473272C';
wwv_flow_api.g_varchar2_table(397) := '206974656D4576656E7473293B0D0A2020202020207D293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20202F2A2A204D6574686F6420746F2072656769737465722061206C697374206F662070616765206974656D732074686174206172652074';
wwv_flow_api.g_varchar2_table(398) := '6F206265206164646974696F6E616C6C792073656E7420746F207468652073657276657220647572696E6720746865206E65787420414443206576656E740D0A2020202A2040706172616D207B4A534F4E7D20704974656D4C697374204172726179206F';
wwv_flow_api.g_varchar2_table(399) := '662070616765206974656D206E616D65730D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E7265676973746572506167654974656D73';
wwv_flow_api.g_varchar2_table(400) := '4F6E6365203D2066756E6374696F6E28704974656D4C697374297B0D0A202020206164632E6164646974696F6E616C4974656D73203D20704974656D4C6973743B0D0A20207D3B0D0A20200D0A20202F2A2A204D6574686F6420746F2070657273697374';
wwv_flow_api.g_varchar2_table(401) := '2074686520737461747573206F6620616C6C2070616765206974656D73206F72206F6E6C7920746865206974656D732070726F76696465642061732070506167654974656D730D0A2020202A2020546869732069732074686520626173697320666F7220';
wwv_flow_api.g_varchar2_table(402) := '22756E7361766564206368616E67657322206D6573736167657320696E20612064796E616D696320656E7669726F6E6D656E740D0A2020202A2040706172616D207B41727261797D2070506167654974656D73204F7074696F6E616C206172726179206F';
wwv_flow_api.g_varchar2_table(403) := '6620616C6C2070616765206974656D2069647320746F20636170747572652E20496620656D7074792C20616C6C2070616765206974656D73206172652063617074757265642E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C75';
wwv_flow_api.g_varchar2_table(404) := '67696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E72656D656D626572506167654974656D537461747573203D2066756E6374696F6E2870506167654974656D732C20704D6573736167652C20705469746C65297B';
wwv_flow_api.g_varchar2_table(405) := '0D0A20202020766172206974656D4C6973743B0D0A20202020766172206974656D56616C75653B0D0A202020200D0A202020202F2F20496E697469616C697A650D0A20202020706167655374617475732E6974656D4D61702E636C65617228293B0D0A20';
wwv_flow_api.g_varchar2_table(406) := '202020706167655374617475732E6D657373616765203D20704D6573736167653B0D0A20202020706167655374617475732E7469746C65203D20705469746C653B0D0A202020200D0A2020202041727261792E697341727261792870506167654974656D';
wwv_flow_api.g_varchar2_table(407) := '7329203F206974656D4C697374203D2070506167654974656D73203A206974656D4C697374203D202428435F494E5055545F53454C4543544F52293B0D0A202020200D0A20202020242E65616368286974656D4C6973742C2066756E6374696F6E286974';
wwv_flow_api.g_varchar2_table(408) := '656D297B0D0A20202020202020206974656D203D206974656D4C6973745B6974656D5D3B0D0A20202020202020206966286974656D2E6964297B0D0A202020202020202020206974656D203D206974656D2E69643B0D0A20202020202020207D3B0D0A20';
wwv_flow_api.g_varchar2_table(409) := '202020202020206974656D56616C7565203D20617065782E6974656D286974656D292E67657456616C756528293B0D0A2020202020202020706167655374617475732E6974656D4D61702E736574286974656D2C206974656D56616C7565293B0D0A2020';
wwv_flow_api.g_varchar2_table(410) := '202020202020617065782E64656275672E696E666F2860536176696E6720247B6974656D7D20776974682076616C756520247B6974656D56616C75657D60293B0D0A2020202020207D0D0A20202020293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020';
wwv_flow_api.g_varchar2_table(411) := '202A2052656672657368657320616E206974656D2028726567696F6E2C2070616765206974656D206574632E292E205472696767657273206170657872656672657368206576656E7420616E6420656E61626C6573207468652070616765206974656D2E';
wwv_flow_api.g_varchar2_table(412) := '0D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F66207468652070616765206974656D20746F20726566726573680D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A';
wwv_flow_api.g_varchar2_table(413) := '2020202A20407075626C69630D0A2020202A2F0D0A20206164632E72656672657368203D2066756E6374696F6E2028704974656D496429207B0D0A20202069662824286064697623247B704974656D49647D2E6A732D617065782D726567696F6E60292E';
wwv_flow_api.g_varchar2_table(414) := '6C656E677468203E2030297B0D0A2020202020617065782E726567696F6E28704974656D4964292E7265667265736828293B0D0A2020207D0D0A202020656C73657B0D0A2020202020617065782E6974656D28704974656D4964292E73686F7728293B0D';
wwv_flow_api.g_varchar2_table(415) := '0A2020202020617065782E6974656D28704974656D4964292E656E61626C6528293B0D0A2020202020617065782E6974656D28704974656D4964292E7265667265736828293B0D0A202020202070617573654368616E67654576656E74447572696E6752';
wwv_flow_api.g_varchar2_table(416) := '65667265736828704974656D4964293B0D0A2020207D3B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2052656672657368657320616E206974656D2028726567696F6E2C2070616765206974656D206574632E2920616E64207365747320746865';
wwv_flow_api.g_varchar2_table(417) := '206974656D2076616C756520616674657277617264732E0D0A2020202A2054686520666F6C6C6F77696E6720666C6F77206F6620616374696F6E73206172652074616B656E3A3C756C3E0D0A2020202A203C6C693E506572736973742074686520616374';
wwv_flow_api.g_varchar2_table(418) := '75616C2076616C7565206F66207468652070616765206974656D3E6C693E0D0A2020202A203C6C693E42696E64206F6E652074696D6520617065786166746572726566726573682068616E646C657220746F20736574207468652070616765206974656D';
wwv_flow_api.g_varchar2_table(419) := '2076616C756520746F20746865207065727369737465642076616C756520616674657220726566726573683E6C693E0D0A2020202A203C6C693E54726967676572206170657872656672657368206576656E743E6C693E0D0A2020202A203C6C693E656E';
wwv_flow_api.g_varchar2_table(420) := '61626C65207468652070616765206974656D3E6C693E3E756C3E0D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F66207468652070616765206974656D20746F207265667265736820616E64207365742074686520';
wwv_flow_api.g_varchar2_table(421) := '76616C75650D0A2020202A2040706172616D207B737472696E677D207056616C7565204F7074696F6E616C2076616C75652E204966206E6F74207365742C206D6574686F64206C6F6F6B7320666F722061637475616C206974656D2076616C756520696E';
wwv_flow_api.g_varchar2_table(422) := '206361636865206F72206F6E20706167652E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E72656672657368416E6453657456616C';
wwv_flow_api.g_varchar2_table(423) := '7565203D2066756E6374696F6E2028704974656D49642C207056616C756529207B0D0A202020766172206974656D56616C7565203D207056616C7565207C7C20617065782E6974656D28704974656D4964292E67657456616C75652829207C7C2066696E';
wwv_flow_api.g_varchar2_table(424) := '644974656D56616C756528704974656D4964293B0D0A20202076617220246974656D203D2024286023247B704974656D49647D60293B0D0A202020766172206E6F6465203D20246974656D2E6765742830293B0D0A0D0A202020617065782E6974656D28';
wwv_flow_api.g_varchar2_table(425) := '704974656D4964292E73686F7728293B0D0A202020617065782E6974656D28704974656D4964292E656E61626C6528293B0D0A202020617065782E6974656D28704974656D4964292E7265667265736828293B0D0A20202070617573654368616E676545';
wwv_flow_api.g_varchar2_table(426) := '76656E74447572696E675265667265736828704974656D49642C206974656D56616C7565293B0D0A20207D3B0D0A0D0A20202F2A2A204D6574686F6420746F2073656C65637420616E20656E74727920696E20616E2049522C204947206F722054524545';
wwv_flow_api.g_varchar2_table(427) := '2E20536F206661722C206F6E6C79205472656520616E6420496E74657261637469766520477269642061726520696D706C656D656E7465640D0A2020202A2040706172616D207B737472696E677D2070526567696F6E496420204944206F662074686520';
wwv_flow_api.g_varchar2_table(428) := '726567696F6E20746F2073656C65637420616E20656E74727920696E0D0A2020202A2040706172616D207B737472696E677D2070456E74727949642020204944206F662074686520656E74727920746F2073656C6563740D0A2020202A2040706172616D';
wwv_flow_api.g_varchar2_table(429) := '207B626F6F6C65616E7D20704E6F4E6F74696679204966207472756520746865207472656556696577236576656E743A73656C656374696F6E4368616E6765206576656E742077696C6C20626520737570707265737365642E0D0A2020202A20406D656D';
wwv_flow_api.g_varchar2_table(430) := '6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E73656C656374456E747279203D2066756E6374696F6E2870526567696F6E49642C2070456E74727949642C2070';
wwv_flow_api.g_varchar2_table(431) := '4E6F4E6F74696679297B0D0A20202020636F6E737420435F43525F53454C4543544F52203D2060237265706F72745F7461626C655F247B70526567696F6E49647D603B0D0A20202020636F6E737420435F49525F53454C4543544F52203D206023247B70';
wwv_flow_api.g_varchar2_table(432) := '526567696F6E49647D5F6972603B0D0A20202020636F6E737420435F49475F53454C4543544F52203D206023247B70526567696F6E49647D5F6967603B0D0A20202020636F6E737420435F545245455F53454C4543544F52203D206023247B7052656769';
wwv_flow_api.g_varchar2_table(433) := '6F6E49647D5F74726565603B0D0A0D0A2020202076617220726567696F6E243B0D0A2020202076617220656E7472793B0D0A0D0A2020202073776974636828676574526567696F6E547970652870526567696F6E496429297B0D0A202020202020636173';
wwv_flow_api.g_varchar2_table(434) := '6520435F524547494F4E5F43523A0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49473A0D0A2020202020202020726567696F6E24203D202428435F49475F53454C4543544F52293B0D0A202020202020';
wwv_flow_api.g_varchar2_table(435) := '2020656E747279203D20726567696F6E240D0A202020202020202020202020202020202E696E7465726163746976654772696428276765745669657773272C20276772696427290D0A202020202020202020202020202020202E6D6F64656C0D0A202020';
wwv_flow_api.g_varchar2_table(436) := '202020202020202020202020202E6765745265636F72642870456E7472794964293B0D0A2020202020202020696628656E747279297B0D0A20202020202020202020726567696F6E242E696E74657261637469766547726964282773657453656C656374';
wwv_flow_api.g_varchar2_table(437) := '65645265636F726473272C20656E7472792C20747275652C20704E6F4E6F74696679293B0D0A20202020202020207D0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49523A0D0A20202020202020206272';
wwv_flow_api.g_varchar2_table(438) := '65616B3B0D0A2020202020206361736520435F524547494F4E5F545245453A0D0A2020202020202020726567696F6E24203D202428435F545245455F53454C4543544F52293B0D0A2020202020202020656E747279203D20726567696F6E242E74726565';
wwv_flow_api.g_varchar2_table(439) := '56696577280D0A2020202020202020202020202020202020202266696E64222C0D0A2020202020202020202020202020202020207B226465707468223A202D312C0D0A20202020202020202020202020202020202020226D61746368223A2066756E6374';
wwv_flow_api.g_varchar2_table(440) := '696F6E286E297B0D0A20202020202020202020202020202020202020202020202020202020202072657475726E206E2E6964203D3D3D2070456E74727949643B0D0A202020202020202020202020202020202020202020202020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(441) := '2020202020202020202020202020207D0D0A20202020202020202020202020202020293B0D0A2020202020202020726567696F6E242E74726565566965772827636F6C6C61707365416C6C27293B0D0A2020202020202020726567696F6E242E74726565';
wwv_flow_api.g_varchar2_table(442) := '566965772827657870616E64272C20656E747279293B0D0A2020202020202020726567696F6E242E7472656556696577282773657453656C656374696F6E272C20656E7472792C20747275652C20704E6F4E6F74696679293B0D0A202020202020202062';
wwv_flow_api.g_varchar2_table(443) := '7265616B3B0D0A202020207D0D0A20207D3B0D0A0D0A0D0A20202F2A2A204D6574686F64206D616B657320616E204150455820616374696F6E2073686F72746375742076697369626C6520627920616464696E6720612043535320636C6173732061726F';
wwv_flow_api.g_varchar2_table(444) := '756E642074686520616363657373206B6579206C65747465722E3C62723E0D0A2020202A2054686973206D6574686F642066696E647320746865206669727374206C65747465722074686174206D617463686573207468652073686F7274637574206B65';
wwv_flow_api.g_varchar2_table(445) := '7920616E6420737572726F756E647320697420776974682061207370616E20656C656D656E7420616E6420612043535320636C6173732E3C62723E0D0A2020202A203C7374726F6E673E494D504F5254414E543E7374726F6E673E3A2054686973206D65';
wwv_flow_api.g_varchar2_table(446) := '74686F64206F6E6C7920737570706F7274732073696D706C652073686F727463757473206C696B65203C416C742D543E210D0A2020202A2040706172616D207B737472696E677D2070416374696F6E204E616D65206F6620746865204150455820616374';
wwv_flow_api.g_varchar2_table(447) := '696F6E206F6E2074686520706167650D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E73657441706578416374696F6E416363657373';
wwv_flow_api.g_varchar2_table(448) := '4B6579203D2066756E6374696F6E202870416374696F6E297B0D0A20202020636F6E737420435F53484F52544355545F434C415353203D20276163636573736B6579273B0D0A20202020636F6E737420435F444154415F53484F52544355545F434C4153';
wwv_flow_api.g_varchar2_table(449) := '53203D2027646174612D6163636573736B6579273B0D0A20202020636F6E737420435F425554544F4E5F4C4142454C5F434C415353203D2027742D427574746F6E2D6C6162656C273B0D0A0D0A202020207661722072653B0D0A20202020766172202474';
wwv_flow_api.g_varchar2_table(450) := '6869733B0D0A2020202076617220246C6162656C203D2024746869732E66696E6428602E247B435F425554544F4E5F4C4142454C5F434C4153537D60293B0D0A20202020766172206C6162656C203D20246C6162656C2E68746D6C28293B0D0A20202020';
wwv_flow_api.g_varchar2_table(451) := '7661722073686F7274637574203D2072652E65786563286C6162656C293B0D0A0D0A202020207661722024627574746F6E73203D202428605B646174612D616374696F6E3D22247B70416374696F6E7D225D60293B0D0A20202020766172206163636573';
wwv_flow_api.g_varchar2_table(452) := '736B6579203D20617065782E616374696F6E732E6C6F6F6B75702870416374696F6E292E73686F72746375743B0D0A0D0A202020206966286163636573736B657920213D3D20222229207B0D0A2020202020206163636573736B6579203D206163636573';
wwv_flow_api.g_varchar2_table(453) := '736B65792E736C696365282D31293B0D0A202020207D0D0A202020206966286163636573736B65792E6C656E677468203E2030297B0D0A2020202020207265203D206E657720526567457870286163636573736B65792C20226922293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(454) := '2024627574746F6E732E656163682866756E6374696F6E28297B0D0A20202020202020202474686973203D20242874686973293B0D0A0D0A20202020202020206966282124746869732E66696E6428602E247B435F425554544F4E5F4C4142454C5F434C';
wwv_flow_api.g_varchar2_table(455) := '4153537D60295B305D297B0D0A2020202020202020202024746869732E68746D6C28603C7370616E20636C6173733D22247B435F425554544F4E5F4C4142454C5F434C4153537D223E247B24746869732E68746D6C28297D3E7370616E3E60293B0D0A20';
wwv_flow_api.g_varchar2_table(456) := '202020202020207D0D0A0D0A2020202020202020246C6162656C2E68746D6C280D0A2020202020202020202020206C6162656C2E7265706C6163652872652C0D0A2020202020202020202020202020202020202020202020202020603C7370616E20636C';
wwv_flow_api.g_varchar2_table(457) := '6173733D22247B435F53484F52544355545F434C4153537D223E247B73686F72746375747D3E7370616E3E6029293B0D0A0D0A202020202020202024746869732E6174747228276163636573736B6579272C2073686F7274637574293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(458) := '20202024746869732E617474722827646174612D6163636573736B6579272C206C6162656C2E73656172636828726529293B0D0A2020202020207D293B0D0A202020207D0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2053657473207468697320';
wwv_flow_api.g_varchar2_table(459) := '76697369626C652061737065637473206F6620612070616765206974656D732E0D0A2020202A2040706172616D207B737472696E677D207053656C6563746F72206A51756572792073656C6563746F72206F6620746865206974656D7320746861742073';
wwv_flow_api.g_varchar2_table(460) := '68616C6C2062652073686F776E0D0A2020202A2040706172616D207B737472696E677D207056697369626C655374617465204F6E65206F662074686520636F6E7374616E74732048494445207C2053484F575F44495341424C45207C2053484F575F454E';
wwv_flow_api.g_varchar2_table(461) := '41424C450D0A2020202A2040706172616D207B737472696E677D20704C6162656C204966207365742C20636F6E74726F6C7320746865206C6162656C206F66207468652070616765206974656D730D0A2020202A20406D656D6265726F662064652E636F';
wwv_flow_api.g_varchar2_table(462) := '6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E736574446973706C61795374617465203D2066756E6374696F6E20287053656C6563746F722C207056697369626C6553746174652C20704C';
wwv_flow_api.g_varchar2_table(463) := '6162656C29207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427293B0D0A202020202020636F6E737420';
wwv_flow_api.g_varchar2_table(464) := '435F48494445203D202748494445273B0D0A202020202020636F6E737420435F53484F575F44495341424C45203D202753484F575F44495341424C45273B0D0A202020202020636F6E737420435F53484F575F454E41424C45203D202753484F575F454E';
wwv_flow_api.g_varchar2_table(465) := '41424C45273B0D0A2020202020200D0A202020202020737769746368287056697369626C655374617465297B0D0A20202020202020206361736520435F484944453A0D0A20202020202020202020617065782E6974656D28704974656D4964292E686964';
wwv_flow_api.g_varchar2_table(466) := '6528293B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F53484F575F44495341424C453A0D0A20202020202020202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(467) := '20206164632E417065784A532E64697361626C65456C656D656E7428704974656D4964293B0D0A202020202020202020202F2F204265736964652064697361626C696E6720746865206974656D2C20616C6C206576656E74732066726F6D207468652071';
wwv_flow_api.g_varchar2_table(468) := '75657565206D7573742062652072656D6F7665640D0A202020202020202020202F2F20746F20617373757265207468617420612064697361626C656420627574746F6E2063616E206E6F74207261697365206120636C69636B206576656E740D0A202020';
wwv_flow_api.g_varchar2_table(469) := '202020202020202428435F424F4459292E636C656172517565756528293B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F53484F575F454E41424C453A0D0A20202020202020202020617065782E6974656D2870';
wwv_flow_api.g_varchar2_table(470) := '4974656D4964292E73686F7728293B0D0A202020202020202020206164632E417065784A532E656E61626C65456C656D656E7428704974656D4964293B0D0A20202020202020202020627265616B3B0D0A202020202020202064656661756C743A0D0A20';
wwv_flow_api.g_varchar2_table(471) := '202020202020202020617065782E64656275672E696E666F286056697375616C20537461746520247B7056697369626C6553746174657D206E6F7420737570706F7274656460293B0D0A2020202020207D0D0A0D0A202020202020696628704C6162656C';
wwv_flow_api.g_varchar2_table(472) := '297B0D0A20202020202020206164632E417065784A532E7365744974656D4C6162656C28704974656D49642C20704C6162656C293B0D0A2020202020207D0D0A202020207D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2053686F77732061';
wwv_flow_api.g_varchar2_table(473) := '6E206572726F72206D657373616765206F6E207468652073637265656E2E3C62723E0D0A2020202A20416E206572726F7220646F6573206E6F74206E65636573736172696C7920696E6469636174652061206D69736265686176696F7572206F66204144';
wwv_flow_api.g_varchar2_table(474) := '43206275742069732061206E6F726D616C20726573706F6E73652066692E207768656E20612076616C69646174696F6E206661696C732E3C62723E0D0A2020202A2044656C6567617465732073686F77696E6720746865206572726F727320746F203C61';
wwv_flow_api.g_varchar2_table(475) := '64632E417065784A533E2E3C62723E0D0A2020202A2054686973206D6574686F642077696C6C20636C65617220746865206576656E7420717565756520696620616E206572726F722069732070617373656420696E2E20526561736F6E696E6720626568';
wwv_flow_api.g_varchar2_table(476) := '696E6420746869732069733A0D0A2020202A20496620612076616C756520697320656E746572656420696E20616E20696E707574206669656C642062757420746865206669656C64206973206E6F74206C656674207573696E67206120746162206B6579';
wwv_flow_api.g_varchar2_table(477) := '206F722061206D6F75736520636C69636B2C2062757420696E737465616420796F7520636C69636B206F6E206120627574746F6E0D0A2020202A207768696C652074686520666F637573206973207374696C6C20696E2074686520696E70757420666965';
wwv_flow_api.g_varchar2_table(478) := '6C642C2074776F206576656E74732077696C6C206265207261697365643A203C6368616E67653E206F6E2074686520696E707574206669656C6420616E64203C636C69636B3E206F6E2074686520627574746F6E2E3C62723E0D0A2020202A204E6F772C';
wwv_flow_api.g_varchar2_table(479) := '20414443206D61792076616C6964617465207468656E20696E707574206669656C6420616E6420746865203C636C69636B3E206576656E742073686F756C64206F6E6C792062652070726F636573736564206966207468652076616C69646174696F6E20';
wwv_flow_api.g_varchar2_table(480) := '7061737365732E0D0A2020202A20417320626F7468206576656E747320617265207261697365642028616C6D6F73742920636F6E63757272656E746C7920616E642068616E646C6564206173796E6368726F6E6F75736C792C207468657265206973206E';
wwv_flow_api.g_varchar2_table(481) := '6F20706F73736962696C69747920666F722041444320746F2070726576656E7420746865203C636C69636B3E206576656E742066726F6D2068617070656E696E672E0D0A2020202A20546F20636174657220666F7220746869732C20616C6C206576656E';
wwv_flow_api.g_varchar2_table(482) := '747320617265207175657565642077697468696E2041444320616E64207468657265666F72652073657269616C697A65642E205573696E67207468697320746563686E697175652C20746865203C636C69636B3E206576656E742063616E206265207375';
wwv_flow_api.g_varchar2_table(483) := '727072657373656420627920636C656172696E67207468652071756575652E0D0A2020202A2040706172616D207B6572726F724C6973747D20704572726F724C697374204C697374206F66206572726F72206F626A656374732074686174206F63637572';
wwv_flow_api.g_varchar2_table(484) := '72656420647572696E672070726F63657373696E670D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E7365744572726F7273203D2066';
wwv_flow_api.g_varchar2_table(485) := '756E6374696F6E2028704572726F724C69737429207B0D0A2020202069662028704572726F724C6973742E6572726F72732E6C656E677468203E203029207B0D0A2020202020202F2F204966206572726F72732068617665206F6363757265642C206E6F';
wwv_flow_api.g_varchar2_table(486) := '2066757274686572206576656E7473206D7573742062652070726F6365737365642E0D0A2020202020202428435F424F4459292E636C656172517565756528293B0D0A202020207D0D0A202020206164632E417065784A532E6D61696E7461696E457272';
wwv_flow_api.g_varchar2_table(487) := '6F727328704572726F724C697374293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2057726170706572203C61726F756E6420617065782E6974656D28292E73657456616C756528293E207468617420616C6C6F777320746F2073657420746865';
wwv_flow_api.g_varchar2_table(488) := '2073616D652076616C756520746F206D616E79206974656D73207573696E672061206A51756572792073656C6563746F722E0D0A2020202A20497420616C736F20737572707265737365732061206368616E6765206576656E74207768656E2073657474';
wwv_flow_api.g_varchar2_table(489) := '696E67207468652076616C75657320746F2061766F696420414443206C6F6F70732E0D0A2020202A2040706172616D207B737472696E677D207053656C6563746F72206A51756572792073656C6563746F7220746F206964656E74696679207468652070';
wwv_flow_api.g_varchar2_table(490) := '616765206974656D7320746F20736574207468652076616C75650D0A2020202A2040706172616D207B737472696E677D207056616C75652056616C7565206F66207468652070616765206974656D0D0A2020202A20407075626C69630D0A2020202A2040';
wwv_flow_api.g_varchar2_table(491) := '6D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A2F0D0A20206164632E7365744974656D56616C7565203D2066756E6374696F6E20287053656C6563746F722C207056616C756529207B0D0A20202020666F724561';
wwv_flow_api.g_varchar2_table(492) := '6368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427293B0D0A202020202020617065782E6974656D28704974656D4964292E7365745661';
wwv_flow_api.g_varchar2_table(493) := '6C7565287056616C75652C207056616C75652C2074727565293B0D0A202020207D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2054616B657320616E206F626A65637420776974682070616765206974656D7320616E642074686569722061';
wwv_flow_api.g_varchar2_table(494) := '637475616C2076616C75652061732073746F72656420696E207468652073657373696F6E20737461746520616E64206861726D6F6E697A6573207468656D20776974682074686520706167652E0D0A2020202A2040706172616D207B4F626A6563747D20';
wwv_flow_api.g_varchar2_table(495) := '70506167654974656D73204172726179206F66206F626A65637473206F662074686520666F726D203C7B226964223A22706167654974656D4944222C2276616C7565223A226974656D56616C7565227D3E2E0D0A2020202A2F0D0A20206164632E736574';
wwv_flow_api.g_varchar2_table(496) := '4974656D56616C756573203D2066756E6374696F6E202870506167654974656D7329207B0D0A202020202F2F2053746F726520746865206F626A65637420666F72206C61746572207265666572656E6365206279206173796E6368726F6E6F7573206361';
wwv_flow_api.g_varchar2_table(497) := '6C6C730D0A202020206164632E6C6173744974656D56616C756573203D2070506167654974656D733B0D0A202020202F2F206861726D6F6E697A65207468652073657373696F6E2073746174652077697468207468652070616765206974656D730D0A20';
wwv_flow_api.g_varchar2_table(498) := '202020242E656163682870506167654974656D732C2066756E6374696F6E202829207B0D0A2020202020206966202828746869732E76616C7565207C7C2027464F4F272920213D3D2028617065782E6974656D28746869732E6964292E67657456616C75';
wwv_flow_api.g_varchar2_table(499) := '652829207C7C2027464F4F272929207B0D0A20202020202020202F2F20746869726420617474726962757465207375727072657373657320746865206368616E6765206576656E742069662073657420746F20747275650D0A2020202020202020617065';
wwv_flow_api.g_varchar2_table(500) := '782E6974656D28746869732E6964292E73657456616C756528746869732E76616C75652C20746869732E76616C75652C2074727565293B0D0A2020202020202020617065782E64656275672E696E666F28604974656D2027247B746869732E69647D2720';
wwv_flow_api.g_varchar2_table(501) := '73657420746F2027247B746869732E76616C75657D2760293B0D0A2020202020207D0D0A202020207D293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2052656E646572732061206669656C64206173206D616E6461746F7279206F72206F7074';
wwv_flow_api.g_varchar2_table(502) := '696F6E616C2C206261736564206F6E20706172616D65746572203C7049734D616E6461746F72793E2E0D0A2020202A2053657474696E6720616E206974656D206D616E6461746F727920697320612074776F20737465702070726F636573732E203C6F6C';
wwv_flow_api.g_varchar2_table(503) := '3E3C6C693E414443207265677369746572732061206368616E67652068616E646C657220616E64206F627365727665732069742C206966206E6F742079657420646F6E653E6C693E3C6C693E746865207061676520726570726573656E746174696F6E20';
wwv_flow_api.g_varchar2_table(504) := '6D7573740D0A2020202A206265206368616E67656420746F20726570726573656E7420746865207374617475732E3E6C693E3E6F6C3E0D0A2020202A20436F6E74726F6C696E6720746865207061676520726570726573656E746174696F6E2069732064';
wwv_flow_api.g_varchar2_table(505) := '656C65676174656420746F203C6164632E417065784A533E2E0D0A2020202A2040706172616D207B737472696E677D207053656C6563746F72206A51756572792073656C6563746F72206F6620746865206974656D732074686174207368616C6C206265';
wwv_flow_api.g_varchar2_table(506) := '2073657420746F206D616E6461746F72790D0A2020202A2040706172616D207B626F6F6C65616E7D207049734D616E6461746F727920466C616720746F20696E646963617465207768657468657220746865206974656D7320617265206D616E6461746F';
wwv_flow_api.g_varchar2_table(507) := '727920285452554529206F7220206E6F74202846414C5345290D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E7365744D616E646174';
wwv_flow_api.g_varchar2_table(508) := '6F7279203D2066756E6374696F6E20287053656C6563746F722C207049734D616E6461746F727929207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D496420';
wwv_flow_api.g_varchar2_table(509) := '3D20242874686973292E617474722827696427292E7265706C61636528275F434F4E5441494E4552272C202727293B0D0A202020202020696620287049734D616E6461746F727929207B0D0A202020202020202069662028242E696E4172726179287049';
wwv_flow_api.g_varchar2_table(510) := '74656D49642C206164632E706167654974656D7329203D3D3D202D3129207B0D0A202020202020202020206164632E706167654974656D732E7075736828704974656D4964293B0D0A2020202020202020202062696E644576656E7428704974656D4964';
wwv_flow_api.g_varchar2_table(511) := '2C20435F4348414E47455F4556454E54293B0D0A20202020202020207D0D0A2020202020207D0D0A2020202020206164632E417065784A532E7365744974656D4D616E6461746F727928704974656D49642C207049734D616E6461746F7279293B0D0A20';
wwv_flow_api.g_varchar2_table(512) := '2020207D293B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A205365747320746865207469746C65206F662061206D6F64616C206469616C6F672077696E646F770D0A2020202A2040706172616D20705469746C65205469746C65206F662074';
wwv_flow_api.g_varchar2_table(513) := '6865206D6F64616C2077696E646F770D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E7365744D6F64616C4469616C6F675469746C65';
wwv_flow_api.g_varchar2_table(514) := '203D2066756E6374696F6E28705469746C65297B0D0A202020206164632E417065784A532E7365744D6F64616C4469616C6F675469746C6528705469746C65293B0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E';
wwv_flow_api.g_varchar2_table(515) := '3A206164632E736574526567696F6E436F6E74656E740D0A2020202020204D6574686F6420746F20736574207468652061637475616C20726567696F6E20636F6E74656E74206F6620612073746174696320726567696F6E0D0A2020202020200D0A2020';
wwv_flow_api.g_varchar2_table(516) := '2020506172616D65746572733A0D0A20202020202070526567696F6E4964202D204944206F662074686520726567696F6E0D0A20202020202070436F6E74656E74202D2048544D4C20636F6E74656E74206F662074686520726567696F6E0D0A2020202A';
wwv_flow_api.g_varchar2_table(517) := '2F0D0A20206164632E736574526567696F6E436F6E74656E74203D2066756E6374696F6E2870526567696F6E49642C2070436F6E74656E74297B0D0A2020202024286023247B70526567696F6E49647D202E742D526567696F6E2D626F647960292E6874';
wwv_flow_api.g_varchar2_table(518) := '6D6C2870436F6E74656E74293B0D0A20207D3B202F2F20736574526567696F6E436F6E74656E740D0A20200D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A206164632E736574526567696F6E4865616465720D0A2020202020204D6574';
wwv_flow_api.g_varchar2_table(519) := '686F6420746F2061646A7573742074686520726567696F6E206865616465722E20576F726B732077697468206E6F726D616C20726567696F6E7320616E642074616220726567696F6E732E0D0A2020202020200D0A20202020506172616D65746572733A';
wwv_flow_api.g_varchar2_table(520) := '0D0A20202020202070526567696F6E4964202D204944206F662074686520726567696F6E0D0A20202020202070486561646572202D20486561646572206F662074686520726567696F6E0D0A2020202A2F0D0A20206164632E736574526567696F6E4865';
wwv_flow_api.g_varchar2_table(521) := '61646572203D2066756E6374696F6E2870526567696F6E49642C2070486561646572297B0D0A2020202073776974636828676574526567696F6E547970652870526567696F6E496429297B0D0A2020202020206361736520435F524547494F4E5F544142';
wwv_flow_api.g_varchar2_table(522) := '3A0D0A20202020202020202428602353525F247B70526567696F6E49647D5F7461622061207370616E60292E68746D6C2870486561646572290D0A2020202020202020627265616B3B0D0A20202020202064656661756C743A0D0A202020202020202024';
wwv_flow_api.g_varchar2_table(523) := '286023247B70526567696F6E49647D202E742D526567696F6E2D7469746C6560292E68746D6C2870486561646572293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20207D3B202F2F20736574526567696F6E4865616465720D0A0D0A';
wwv_flow_api.g_varchar2_table(524) := '20202F2A2A2053686F7773206F7220686964657320612077616974696E67207370696E6E65720D0A2020202A2040706172616D207B626F6F6C65616E7D2070466C616720466C616720746F20696E64696361746520776865746865720D0A2020202A2020';
wwv_flow_api.g_varchar2_table(525) := '20202020202020202020202020202020202020202020746F2073686F772028747275652920612077616974207370696E6E6572206F72206E6F74202866616C7365290D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E';
wwv_flow_api.g_varchar2_table(526) := '6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E73686F77576169745370696E6E6572203D2066756E6374696F6E2870466C6167297B0D0A202020206164632E417065784A532E73686F77576169745370696E6E65722870';
wwv_flow_api.g_varchar2_table(527) := '466C6167293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A205375626D6974732074686520706167652E2044656C65676174657320696D706C656D656E746174696F6E20746F203C6164632E417065784A533E2E0D0A2020202A20496620746865';
wwv_flow_api.g_varchar2_table(528) := '2070616765207374696C6C20636F6E7461696E7320756E736F6C766564206572726F72732C2074686520706167652077696C6C206E6F74206265207375626D69747465642C206275742061206469616C6F672069732073686F776E20746F207468652075';
wwv_flow_api.g_varchar2_table(529) := '7365722E0D0A2020202A2040706172616D207B737472696E677D207052657175657374205245515545535420746861742069732070617373656420746F20746865207365727665720D0A2020202A2040706172616D207B737472696E677D20704D657373';
wwv_flow_api.g_varchar2_table(530) := '616765204D65737361676520746861742069732073686F776E20746F207468652075736572206966207468652070616765207374696C6C20636F6E7461696E7320756E736F6C766564206572726F72732E0D0A2020202A20406D656D6265726F66206465';
wwv_flow_api.g_varchar2_table(531) := '2E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E7375626D6974203D2066756E6374696F6E202870526571756573742C20704D65737361676529207B0D0A202020206164632E417065';
wwv_flow_api.g_varchar2_table(532) := '784A532E7375626D6974506167652870526571756573742C20704D657373616765293B0D0A20207D3B0D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B20454E442053595354454D20414354494F4E205459504553202B2B2B2B2B2B2B2B2B2B2B202A2F0D0A';
wwv_flow_api.g_varchar2_table(533) := '0D0A7D2864652E636F6E6465732E706C7567696E2E6164632C20617065782E6A51756572792C20617065782E73657276657229293B0D0A0D0A0D0A2F2F20496E7465726661636520746F204150455820706C7567696E206D656368616E69736D2E0D0A2F';
wwv_flow_api.g_varchar2_table(534) := '2F20466F7220736F6D6520726561736F6E204920646F6E2274207265616C6C7920756E6465727374616E642C20697420697320696D706F737369626C650D0A2F2F20746F2074656C6C204150455820746F206469726563746C79207573652061206E616D';
wwv_flow_api.g_varchar2_table(535) := '657370616365206F626A65637420686572652E0D0A66756E6374696F6E2064655F636F6E6465735F706C7567696E5F6164632829207B0D0A202064652E636F6E6465732E706C7567696E2E6164632E696E697428746869732E616374696F6E293B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(111084651285678992)
,p_plugin_id=>wwv_flow_api.id(43022683634552888939)
,p_file_name=>'adc/js/adc.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F204E616D6573706163650D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E20';
wwv_flow_api.g_varchar2_table(2) := '7C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E616463203D2064652E636F6E6465732E706C7567696E2E616463207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F32203D207B7D3B0D';
wwv_flow_api.g_varchar2_table(3) := '0A0D0A2F2A2A0D0A202A20496E74657266616365206265747765656E207468652041444320706C7567696E20616E64207468652041504558207573657220696E7465726661636520666F722056657273696F6E20352E312C205468656D652034320D0A20';
wwv_flow_api.g_varchar2_table(4) := '2A20406E616D6573706163652064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A202A204073696E63652032302E320D0A202A20406465736372697074696F6E0D0A202A203C703E414443206E6565647320746F20';
wwv_flow_api.g_varchar2_table(5) := '696E746572616374207769746820746865204150455820554920746F2061636869657665207468652076697375616C2065666665637473207265717565737465642062792074686520706167652072756C65732E2041504558206F6E20746865206F7468';
wwv_flow_api.g_varchar2_table(6) := '65722068616E640D0A202A20636F6D657320696E20646966666572656E742076657273696F6E7320616E64207468656D65732C206D616B696E6720697420646966666963756C7420666F72206F6E2063656E7472616C20636F646520746F2074616B6520';
wwv_flow_api.g_varchar2_table(7) := '63617265206F6620616C6C2074686520646966666572656E7420737472617465676965730D0A202A207573656420746F2073686F7720636F6E74656E743C2F703E0D0A202A203C703E4144432063617465727320666F7220746869732062792064656C65';
wwv_flow_api.g_varchar2_table(8) := '676174696E6720746865205549207370656369666963206D6574686F647320696E746F20612073657061726174652066696C652C20696D706C656D656E74696E67207468652076697375616C20636F646520666F7220612073706563696669630D0A202A';
wwv_flow_api.g_varchar2_table(9) := '20636F6D62696E6174696F6E206F6620415045582076657273696F6E20616E64207468656D652E205468652072657175697265642066696C65206D61792062652063686F73656E206279207574696C697A696E67206120636F6D706F6E656E7420706172';
wwv_flow_api.g_varchar2_table(10) := '616D65746572206F662074686520706C7567696E2E2054686572652C0D0A202A20746865206E616D657370616365206F662074686520726571756972656420554920636F646520696D706C656D656E746174696F6E2063616E206265207365742E3C2F70';
wwv_flow_api.g_varchar2_table(11) := '3E0D0A202A203C703E54686973206F626A65637420696D706C656D656E7473207468652076697375616C2065666665637473206F662076657273696F6E20352E312C205468656D652034322E20496620796F7520757365207468652073616D6520766572';
wwv_flow_api.g_varchar2_table(12) := '73696F6E20627574206120646966666572656E742074656D706C617465206F720D0A202A20696620796F7520657874656E64656420796F7572207468656D652062792061646472657373696E67207370656369666963206E6565647320666F7220796F75';
wwv_flow_api.g_varchar2_table(13) := '7220636F6D70616E792C20796F75206D6179206861766520746F20616464206F72206F76657277726974652066756E6374696F6E616C697479206F662074686973206F626A6563742E3C2F703E0D0A202A203C703E546F2070726F7669646520796F7572';
wwv_flow_api.g_varchar2_table(14) := '206F776E2076657273696F6E2C206974206973207265636F6D6D656E64656420746F206372656174652061206E6577206F626A656374207468617420696E6865726974732066726F6D2074686973206F626A65637420616E64206F766572777269746573';
wwv_flow_api.g_varchar2_table(15) := '207468652066756E6374696F6E616C6974790D0A202A20796F75206E6565642E3C2F703E0D0A202A203C703E466F722061206465736372697074696F6E206F662074686520737472756374757265206F6620746865206F626A6563747320706173736564';
wwv_flow_api.g_varchar2_table(16) := '20696E207365652074686520646F63756D656E746174696F6E206F66206164632E6A733C2F703E0D0A202A2040706172616D207B4F626A6563747D20616463204E616D657370616365206F626A65637420746F2061646F70742041444320746F20746865';
wwv_flow_api.g_varchar2_table(17) := '20676976656E20415045582076657273696F6E20616E64207468656D650D0A202A2040706172616D207B617065782E6D6573736167657D204D657373616765206F626A6563742070726F766964656420627920415045580D0A202A2F0D0A2866756E6374';
wwv_flow_api.g_varchar2_table(18) := '696F6E286164632C206D7367297B0D0A0D0A202076617220435F415045585F4552524F525F434C4153535F53454C203D20276469762E612D4E6F74696669636174696F6E2D2D6572726F72272C0D0A202020202020435F56495349424C45203D2022752D';
wwv_flow_api.g_varchar2_table(19) := '76697369626C65222C0D0A202020202020435F48494444454E203D2022752D68696464656E222C0D0A202020202020435F4954454D5F4552524F52203D2022617065782D706167652D6974656D2D6572726F72222C0D0A202020202020435F464F524D5F';
wwv_flow_api.g_varchar2_table(20) := '4552524F52203D2022612D466F726D2D6572726F72222C0D0A202020202020435F5354414E444152445F4552524F525F53454C203D20222E68746D6C6462537464457272222C0D0A202020202020435F415045585F44495341424C45445F434C41535320';
wwv_flow_api.g_varchar2_table(21) := '3D20276164632D64697361626C6564273B0D0A0D0A202076617220415F4445534352494245444259203D2022617269612D6465736372696265646279222C0D0A202020202020415F494E56414C4944203D2022617269612D696E76616C6964223B0D0A20';
wwv_flow_api.g_varchar2_table(22) := '20202020200D0A202076617220445F4F4C445F415F4445534352494245444259203D2022646174612D6F6C642D617269612D6465736372696265646279223B0D0A20200D0A20202F2F20476C6F62616C730D0A202076617220674572726F7273203D205B';
wwv_flow_api.g_varchar2_table(23) := '5D3B202F2F20496E746572696D20736F6C7574696F6E20726571756972656420756E74696C203C636F64653E617065782E6D6573736167653C2F636F64653E20737570706F7274732072656D6F76696E6720612073696E676C65206572726F720D0A2020';
wwv_flow_api.g_varchar2_table(24) := '0D0A20206164632E616C69676E5265706F7274566572746963616C546F70203D2066756E6374696F6E286964297B0D0A09202024286023247B69647D20746460292E616464436C6173732827752D616C69676E546F7027293B0D0A0920200D0A09202024';
wwv_flow_api.g_varchar2_table(25) := '286023247B69647D60292E6F6E28276170657861667465727265667265736827292C2066756E6374696F6E28297B0D0A0920202020616C69676E5265706F7274566572746963616C546F7055286964293B0D0A202020207D09090D0A20207D3B0D0A2020';
wwv_flow_api.g_varchar2_table(26) := '0D0A20202F2A2A0D0A2020202A2052656D6F76657320616C6C206D6573736167657320696E20746865206E6F74696669636174696F6E20726567696F6E0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E61';
wwv_flow_api.g_varchar2_table(27) := '7065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E636C6561724E6F74696669636174696F6E203D2066756E6374696F6E28297B0D0A202020206D73672E686964';
wwv_flow_api.g_varchar2_table(28) := '65506167655375636365737328293B0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A2053686F7773206120636F6E6669726D6174696F6E206469616C6F6720746F207468652075736572206265666F72652063616C6C696E672074686520696E7465';
wwv_flow_api.g_varchar2_table(29) := '6E646564207266756E6374696F6E616C6974790D0A2020202A2040706172616D207B6576656E747D20704576656E74204576656E74207468617420776173207261697365642062792074686520757365720D0A2020202A2040706172616D207B63616C6C';
wwv_flow_api.g_varchar2_table(30) := '6261636B7D2063616C6C6261636B204D6574686F6420746F2062652063616C6C656420696620746865207573657220636F6E6669726D65732074686973206469616C6F670D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C756769';
wwv_flow_api.g_varchar2_table(31) := '6E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E636F6E6669726D52657175657374203D2066756E6374696F6E28704576656E742C2063616C6C6261636B297B0D0A20202020617065';
wwv_flow_api.g_varchar2_table(32) := '782E6D6573736167652E636F6E6669726D28704576656E742E646174612E6D6573736167652C2066756E6374696F6E202870416E7377657229207B0D0A20202020202069662870416E73776572297B0D0A20202020202020202063616C6C6261636B2870';
wwv_flow_api.g_varchar2_table(33) := '4576656E74293B0D0A2020202020207D3B0D0A202020207D293B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A2044697361626C657320612070616765206974656D2E2048616E646C657320646561637469766174696F6E206F66200D0A2020';
wwv_flow_api.g_varchar2_table(34) := '202A202D2070616765206974656D7320776974682076616C75657320746F20616C6C6F7720746F20696E636C756465207468656D20696E2061207375626D69740D0A2020202A202D2073656C656374206C697374730D0A2020202A202D20627574746F6E';
wwv_flow_api.g_varchar2_table(35) := '730D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F66207468652070616765206974656D20746F2064697361626C650D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E';
wwv_flow_api.g_varchar2_table(36) := '617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A2F0D0A20206164632E64697361626C65456C656D656E74203D2066756E6374696F6E2028704974656D4964297B0D0A202020202F2F204E6F726D616C20656C656D656E74';
wwv_flow_api.g_varchar2_table(37) := '2C20646F206E6F742064697361626C652C206F74686572776973652073657373696F6E73746174652077696C6C206E6F742062652066696C6C65642E0D0A202020202F2F20496E73746561642C2073657420726561646F6E6C7920616E64204353532063';
wwv_flow_api.g_varchar2_table(38) := '6C61737320736F2074686174206974206C6F6F6B73206C696B652064697361626C65642E0D0A20202020766172202474686973203D2024286023247B704974656D49647D60293B0D0A2020202024746869732E70726F702827726561646F6E6C79272C20';
wwv_flow_api.g_varchar2_table(39) := '74727565292E616464436C61737328276164632D64697361626C656427293B0D0A0D0A202020206966202824746869732E6973282773656C6563742729297B0D0A2020202020202F2F2053656C656374206C6973742C206465616374697661746520616C';
wwv_flow_api.g_varchar2_table(40) := '6C20656E747269657320657863657074207468652073656C6563746564206F6E650D0A20202020202024286023247B704974656D49647D3A6E6F74283A73656C65637465642960292E70726F70282764697361626C6564272C2066616C7365293B0D0A20';
wwv_flow_api.g_varchar2_table(41) := '2020207D0D0A20202020656C7365206966202824746869732E69732827627574746F6E2729297B0D0A2020202020202F2F20627574746F6E2C20697320646561637469766174656420226E6F726D616C6C79220D0A202020202020617065782E6974656D';
wwv_flow_api.g_varchar2_table(42) := '28704974656D4964292E64697361626C6528293B0D0A202020207D0D0A20202020656C7365206966202824746869732E69732827696E7075742729297B0D0A2020202020202F2F617065782E6974656D28704974656D4964292E64697361626C6528293B';
wwv_flow_api.g_varchar2_table(43) := '0D0A202020207D3B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A20456E61626C657320612070616765206974656D2E2048616E646C65732061637469766174696F6E206F66200D0A2020202A202D2070616765206974656D73207769746820';
wwv_flow_api.g_varchar2_table(44) := '76616C75657320746F20616C6C6F7720746F20696E636C756465207468656D20696E2061207375626D69740D0A2020202A202D2073656C656374206C697374730D0A2020202A202D20627574746F6E730D0A2020202A2040706172616D207B737472696E';
wwv_flow_api.g_varchar2_table(45) := '677D20704974656D4964204944206F66207468652070616765206974656D20746F2064697361626C650D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A204070';
wwv_flow_api.g_varchar2_table(46) := '75626C69630D0A2020202A2F0D0A20206164632E656E61626C65456C656D656E74203D2066756E6374696F6E2028704974656D4964297B0D0A20202020766172202474686973203D2024286023247B704974656D49647D60293B0D0A2020202024746869';
wwv_flow_api.g_varchar2_table(47) := '732E70726F702827726561646F6E6C79272C2066616C7365292E72656D6F7665436C61737328276164632D64697361626C656427293B0D0A0D0A202020206966202824746869732E6973282773656C6563742729297B0D0A20202020202024286023247B';
wwv_flow_api.g_varchar2_table(48) := '704974656D49647D3A6E6F74283A73656C65637465642960292E70726F70282764697361626C6564272C2066616C7365293B0D0A202020207D0D0A20202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A20202020617065782E';
wwv_flow_api.g_varchar2_table(49) := '6974656D28704974656D4964292E656E61626C6528293B0D0A202020200D0A202020202F2F2069662070616765206974656D20697320612064617465207069636B65722C20656E61626C6520627574746F6E2061732077656C6C0D0A2020202069662028';
wwv_flow_api.g_varchar2_table(50) := '24746869732E686173436C6173732822686173446174657069636B6572222929207B0D0A20202020202024746869732E706172656E7428292E66696E642822627574746F6E22292E70726F702827726561646F6E6C79272C2066616C7365292E72656D6F';
wwv_flow_api.g_varchar2_table(51) := '7665436C61737328435F415045585F44495341424C45445F434C415353293B0D0A202020207D0D0A0D0A202020202F2F2069662070616765206974656D206973206120636F6C6F7572207069636B65722C20656E61626C6520627574746F6E2061732077';
wwv_flow_api.g_varchar2_table(52) := '656C6C0D0A20202020656C7365206966202824746869732E686173436C6173732822636F6C6F725F7069636B6572222929207B0D0A2020202020202428272327202B20704974656D202B20275F6669656C6473657427292E70726F702827726561646F6E';
wwv_flow_api.g_varchar2_table(53) := '6C79272C2066616C7365292E72656D6F7665436C61737328435F415045585F44495341424C45445F434C415353293B0D0A202020207D0D0A0D0A202020202F2F2069662070616765206974656D206973206120706F707570206C6973742C20656E61626C';
wwv_flow_api.g_varchar2_table(54) := '6520627574746F6E2061732077656C6C0D0A20202020656C7365206966202824746869732E686173436C6173732822706F7075705F6C6F76222929207B0D0A20202020202024746869732E636C6F7365737428272327202B20704974656D202B20275F66';
wwv_flow_api.g_varchar2_table(55) := '69656C6473657427292E66696E6428272E612D427574746F6E2D2D706F7075704C4F5627290D0A2020202020202020202E70726F702827726561646F6E6C79272C2066616C7365292E72656D6F7665436C61737328435F415045585F44495341424C4544';
wwv_flow_api.g_varchar2_table(56) := '5F434C415353293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A2052656D6F7665732066696C74657220617265612066726F6D20696E746572616374697665207265706F7274206F7220696E7465726163746976652067';
wwv_flow_api.g_varchar2_table(57) := '7269640D0A2020202A2040706172616D207B737472696E677D2070526567696F6E496420737461746963206964206F662074686520696E746572616374697665207265706F7274206F7220677269640D0A2020202A20406D656D6265726F662064652E63';
wwv_flow_api.g_varchar2_table(58) := '6F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E686964655265706F727446696C74657250616E656C203D206675';
wwv_flow_api.g_varchar2_table(59) := '6E6374696F6E2870526567696F6E4964297B0D0A2020202024286023247B70526567696F6E49647D5F636F6E726F6C5F70616E656C60292E6869646528293B202F2F20696E746572616374697665207265706F72740D0A2020202024286023247B705265';
wwv_flow_api.g_varchar2_table(60) := '67696F6E49647D202E612D4D65646961426C6F636B60292E6869646528293B202F2F20696E74657261637469766520677269640D0A202020200D0A2020202024286023247B70526567696F6E49647D60292E6F6E28276170657861667465727265667265';
wwv_flow_api.g_varchar2_table(61) := '7368272C2066756E6374696F6E28297B0D0A2020202020206164632E686964655265706F727446696C74657250616E656C2870526567696F6E4964293B0D0A202020207D293B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A204D61696E7461';
wwv_flow_api.g_varchar2_table(62) := '696E7320746865206572726F72206C697374206F6E2074686520706167650D0A2020202A2040706172616D207B6572726F724C6973747D204C697374206F66206572726F72730D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C75';
wwv_flow_api.g_varchar2_table(63) := '67696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E6D61696E7461696E4572726F7273203D2066756E6374696F6E28704572726F724C6973';
wwv_flow_api.g_varchar2_table(64) := '74297B0D0A202020200D0A202020202F2F204D6170206572726F727320746F20617065782E6D6573736167652E6572726F724F626A6563740D0A20202020617065782E64656275672E6C6F6728604572726F7220616D6F756E7420506C7567496E3A2024';
wwv_flow_api.g_varchar2_table(65) := '7B704572726F724C6973742E636F756E747D60293B0D0A202020202020200D0A202020202F2F2052656D6F7665206572726F727320666F7220616C6C20746F7563686564206974656D732066726F6D206F757220674572726F727320636F70790D0A2020';
wwv_flow_api.g_varchar2_table(66) := '2020242E6561636828704572726F724C6973742E666972696E674974656D732C2066756E6374696F6E28696E6465782C20704974656D4964297B0D0A2020202020202F2F2072656D6F766520746865206572726F722066726F6D20674572726F72730D0A';
wwv_flow_api.g_varchar2_table(67) := '202020202020674572726F7273203D20242E6772657028674572726F72732C2066756E6374696F6E2865297B0D0A202020202020202072657475726E20652E706167654974656D20213D20704974656D49643B0D0A2020202020207D293B0D0A20202020';
wwv_flow_api.g_varchar2_table(68) := '7D293B0D0A20200D0A202020202F2F20416464206E6577206572726F727320746F206F757220674572726F727320636F70790D0A20202020666F72202869203D20303B2069203C20704572726F724C6973742E6572726F72732E6C656E6774683B20692B';
wwv_flow_api.g_varchar2_table(69) := '2B297B0D0A2020202020202020674572726F72732E7075736828704572726F724C6973742E6572726F72735B695D293B0D0A202020207D3B0D0A202020200D0A202020206D73672E636C6561724572726F727328293B0D0A202020206D73672E73686F77';
wwv_flow_api.g_varchar2_table(70) := '4572726F727328674572726F7273293B0D0A202020200D0A20207D3B0D0A202020200D0A20202F2A2A0D0A2020202A20436F6E74726F6C7320746865206D616E6461746F727920737461747573206F6620612070616765206974656D0D0A2020202A2040';
wwv_flow_api.g_varchar2_table(71) := '706172616D207B737472696E677D20704974656D49642050616765206974656D204944206F6620746865206974656D20746F20736574206D616E6461746F7279206F72206F7074696F6E616C0D0A2020202A2040706172616D207B626F6F6C65616E7D20';
wwv_flow_api.g_varchar2_table(72) := '7049734D616E6461746F727920466C616720746F2073657420612070616765206974656D206D616E6461746F727920287472756529206F72206F7074696F6E616C202866616C7365290D0A2020202A20406D656D6265726F662064652E636F6E6465732E';
wwv_flow_api.g_varchar2_table(73) := '706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E7365744974656D4D616E6461746F7279203D2066756E6374696F6E2870497465';
wwv_flow_api.g_varchar2_table(74) := '6D49642C207049734D616E6461746F7279297B0D0A0D0A2020202076617220246D616E6461746F72794974656D203D2024286023247B704974656D49647D5F434F4E5441494E455260293B0D0A2020202076617220435F52455155495245445F434C4153';
wwv_flow_api.g_varchar2_table(75) := '53203D202769732D7265717569726564273B0D0A0D0A20202020246D616E6461746F72794974656D2E72656D6F7665436C61737328435F52455155495245445F434C415353293B0D0A202020200D0A202020206966287049734D616E6461746F7279297B';
wwv_flow_api.g_varchar2_table(76) := '0D0A202020202020246D616E6461746F72794974656D2E616464436C61737328435F52455155495245445F434C415353293B0D0A202020207D0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A205365747320746865206C6162656C206F662061';
wwv_flow_api.g_varchar2_table(77) := '2070616765206974656D0D0A2020202A2040706172616D207B737472696E677D20704974656D4964204944206F66207468652070616765206974656D20746F2073657420746865206C6162656C206F660D0A2020202A2040706172616D207B737472696E';
wwv_flow_api.g_varchar2_table(78) := '677D20704974656D4C6162656C20204E6577206974656D206C6162656C0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20';
wwv_flow_api.g_varchar2_table(79) := '406F766572726964650D0A2020202A2F0D0A20206164632E7365744974656D4C6162656C203D2066756E6374696F6E28704974656D49642C20704974656D4C6162656C297B0D0A09202024286023247B704974656D49647D5F4C4142454C60292E746578';
wwv_flow_api.g_varchar2_table(80) := '7428704974656D4C6162656C293B0D0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A205365747320746865207469746C65206F662061206D6F64616C206469616C6F672077696E646F770D0A2020202A2040706172616D207B737472696E677D20';
wwv_flow_api.g_varchar2_table(81) := '704974656D4C6162656C20204E6577206974656D206C6162656C0D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A2F0D0A20';
wwv_flow_api.g_varchar2_table(82) := '206164632E7365744D6F64616C4469616C6F675469746C65203D2066756E6374696F6E28705469746C65297B0D0A20202020706172656E742E2428272E75692D6469616C6F672D7469746C6527292E6C61737428292E68746D6C28705469746C65293B0D';
wwv_flow_api.g_varchar2_table(83) := '0A20207D3B0D0A20200D0A20202F2A2A0D0A2020202A2053686F77732061206D657373616765206F6E2074686520706167650D0A2020202A2040706172616D207B737472696E677D20704D657373616765204D657373616765207465787420746F207368';
wwv_flow_api.g_varchar2_table(84) := '6F770D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E736574';
wwv_flow_api.g_varchar2_table(85) := '4E6F74696669636174696F6E203D2066756E6374696F6E28704D657373616765297B0D0A202020206D73672E68696465506167655375636365737328293B0D0A202020206D73672E73686F77506167655375636365737328704D657373616765293B0D0A';
wwv_flow_api.g_varchar2_table(86) := '20207D3B0D0A20200D0A20202F2A2A0D0A2020202A2053686F777320612077616974207370696E6E6572206F6E2074686520706167650D0A2020202A2040706172616D207B626F6F6C65616E7D2070466C616720466C616720746F20696E646963617465';
wwv_flow_api.g_varchar2_table(87) := '207768657468657220746F2073686F772028747275652920612077616974207370696E6E6572206F72206E6F74202866616C7365290D0A2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32';
wwv_flow_api.g_varchar2_table(88) := '305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E73686F77576169745370696E6E6572203D2066756E6374696F6E2870466C6167297B0D0A2020202069662870466C6167297B0D0A';
wwv_flow_api.g_varchar2_table(89) := '202020202020617065782E7574696C2E73686F775370696E6E657228293B0D0A202020207D0D0A20202020656C73657B0D0A20202020202024282223617065785F776169745F6F7665726C617922292E72656D6F766528293B0D0A202020202020242822';
wwv_flow_api.g_varchar2_table(90) := '2E752D50726F63657373696E6722292E72656D6F766528293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20202F2A2A200D0A2020202A204D6574686F64207375626D697473207061676520776974682074686520676976656E2072657175657374';
wwv_flow_api.g_varchar2_table(91) := '206966206E6F206572726F727320617265206F6E2074686520706167650D0A2020202A2040706172616D207B737472696E677D207052657175657374205265717565737420666F7220746865207365727665720D0A2020202A2040706172616D207B7374';
wwv_flow_api.g_varchar2_table(92) := '72696E677D20704D65737361676520416C657274206D657373616765207761726E696E67207468652075736572206966207375626D697420636F756C646E27742062652065786563757465642064756520746F206572726F7273206F6E20706167650D0A';
wwv_flow_api.g_varchar2_table(93) := '2020202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F320D0A2020202A20407075626C69630D0A2020202A20406F766572726964650D0A2020202A2F0D0A20206164632E7375626D697450';
wwv_flow_api.g_varchar2_table(94) := '616765203D2066756E6374696F6E2870526571756573742C20704D657373616765297B0D0A0D0A20202020696620282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D203029207B0D0A202020202020617065782E';
wwv_flow_api.g_varchar2_table(95) := '706167652E7375626D6974287B0D0A2020202020202020227265717565737422203A2070526571756573742C0D0A20202020202020202273686F775761697422203A20747275650D0A2020202020207D293B0D0A202020207D0D0A20202020656C73657B';
wwv_flow_api.g_varchar2_table(96) := '0D0A2020202020206D73672E616C65727428704D657373616765293B0D0A202020207D0D0A20207D3B0D0A0D0A7D292864652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F322C20617065782E6D657373616765293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(111085026126678993)
,p_plugin_id=>wwv_flow_api.id(43022683634552888939)
,p_file_name=>'adc/js/adcApex.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(184918109637718920)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ALIAS.:HOME:&SESSION.'
,p_login_url=>'f?p=&APP_ALIAS.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_api.id(184778339284718821)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(184881536539718885)
,p_nav_list_template_options=>'#DEFAULT#:js-defaultCollapsed:js-navCollapsed--hidden:t-TreeNav--styleA'
,p_css_file_urls=>'#APP_IMAGES#app-icon.css?version=#APP_VERSION#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(184917801308718920)
,p_nav_bar_list_template_id=>wwv_flow_api.id(184884345305718885)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Global Page - Desktop'
,p_step_title=>'Global Page - Desktop'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210918102207'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(184293240181887669)
,p_name=>'ADC'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'CURRENT_PAGE_NOT_IN_CONDITION'
,p_display_when_cond=>'100,101,9999'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(184293336568887670)
,p_event_id=>wwv_flow_api.id(184293240181887669)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.CONDES.PLUGIN.ADC'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Startseite'
,p_alias=>'HOME'
,p_step_title=>'ADC Beispielanwendung'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210528184108'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184293665581887673)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184928998394718968)
,p_plug_name=>'ADC Beispielanwendung'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184823236456718856)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(188574903151377265)
,p_plug_name=>'Main Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(188574665870377246)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258154461095720775)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_OVERVIEW'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184293831658887674)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(184293665581887673)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'ADC verwenden'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:USEADC:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-chevron-right'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'ADC verwenden'
,p_alias=>'USEADC'
,p_step_title=>'ADC verwenden'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220122084351'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184979108427510832)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258200443568414405)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(332060290115186928)
,p_plug_name=>'ADC in ihre Anwendung einbinden'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h1:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_USE_ADC'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184981026394574985)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(258200443568414405)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184293934172887675)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(258200443568414405)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'ADC Administrationsanwendung'
,p_alias=>'ADADC'
,p_step_title=>'ADC Administrationsanwendung'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210816135855'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184294126090887677)
,p_plug_name=>unistr('Dynamische Anwendungsseite ohne Anwendungsf\00E4lle')
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADC_NO_RULES'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184294213045887678)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258887658060052621)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(263721028744072092)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADADC_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(332108993200956194)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(405968839747728717)
,p_plug_name=>'Die ADC Administartionsanwendung'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_ADC_APP'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184293990750887676)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(405968839747728717)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188976002506659281)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(332108993200956194)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188975733029658307)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(332108993200956194)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184294301683887679)
,p_name=>'P3_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(184294213045887678)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894591749718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184294421995887680)
,p_name=>'P3_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(184294213045887678)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184294460403887681)
,p_name=>'P3_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(184294213045887678)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_api.create_page(
 p_id=>4
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_alias=>'ADANF'
,p_step_title=>unistr('Einfache Anwendungsf\00E4lle')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210815105052'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258214553886373166)
,p_plug_name=>'Anmerkungen zum Formular'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ANF_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258214640841373167)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(332808085855538110)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(343148936343280127)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADANF_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(406029420996441683)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(479889267543214206)
,p_plug_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_ANF_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184995649700533763)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(479889267543214206)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188978786707690921)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(406029420996441683)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188978514155689763)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(406029420996441683)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184997740507533765)
,p_name=>'P4_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(258214640841373167)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184998160746533767)
,p_name=>'P4_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(258214640841373167)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184998539365533768)
,p_name=>'P4_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(258214640841373167)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Einfache Validierungen'
,p_alias=>'ADVAL'
,p_step_title=>'Einfache Validierungen'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210815103639'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(332155791437224866)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_VAL_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(332155878392224867)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(406749323406389810)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(422577656070526402)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADVAL_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(479970658547293383)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(553830505094065906)
,p_plug_name=>'Einfache Validierungen erstellen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_VAL_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(185016460686899973)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(553830505094065906)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188980151857695537)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(479970658547293383)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188979917005694467)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(479970658547293383)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185018550997899976)
,p_name=>'P5_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(332155878392224867)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185019030701899976)
,p_name=>'P5_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(332155878392224867)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185019371988899978)
,p_name=>'P5_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(332155878392224867)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Komplexere Validierungen'
,p_alias=>'ADVAL2'
,p_step_title=>'Komplexere Validierungen'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210815105511'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(406358400164638526)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_VAL2_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(406358487119638527)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(480951932133803470)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(502008639756786186)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADVAL_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(554173267274707043)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(628033113821479566)
,p_plug_name=>'Komplexere Validierungen einrichten'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_VAL2_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(185277897387461935)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(628033113821479566)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981583148700368)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(554173267274707043)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.:P7_EMPLOYEE_ID:118'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981249618699207)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(554173267274707043)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185280027878461937)
,p_name=>'P6_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(406358487119638527)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185280341085461940)
,p_name=>'P6_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(406358487119638527)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(185280758304461940)
,p_name=>'P6_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(406358487119638527)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Kontrolle des Seitenstatus'
,p_alias=>'ADSTA'
,p_step_title=>'Kontrolle des Seitenstatus'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210817111107'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184295967876887696)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADSTA_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(480859818645806127)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADSTA_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(480859905600806128)
,p_plug_name=>'Beispieldialog (Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADSTA'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(555453350614971071)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(628674685755874644)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(702534532302647167)
,p_plug_name=>'Kontrolle des Seitenstatus'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_ADSTA_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(185576625224215881)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(702534532302647167)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188982959081706159)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(628674685755874644)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188982683538704962)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(628674685755874644)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184294782020887684)
,p_name=>'P7_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Mitarbeiternummer'
,p_source=>'EMPLOYEE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184294849506887685)
,p_name=>'P7_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Vorname'
,p_source=>'FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295003287887686)
,p_name=>'P7_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Nachname'
,p_source=>'LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295062395887687)
,p_name=>'P7_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Email'
,p_source=>'EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295187008887688)
,p_name=>'P7_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Telefon'
,p_source=>'PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295240090887689)
,p_name=>'P7_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Einstelldatum'
,p_source=>'HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295362900887690)
,p_name=>'P7_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Beruf'
,p_source=>'JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_JOBS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295451310887691)
,p_name=>'P7_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Gehalt'
,p_source=>'SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295598632887692)
,p_name=>'P7_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Vertriebsboni'
,p_source=>'COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295729225887693)
,p_name=>'P7_MANAGER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Vorgestezter'
,p_source=>'MANAGER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184295758913887694)
,p_name=>'P7_DEPARTMENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(480859905600806128)
,p_item_source_plug_id=>wwv_flow_api.id(480859905600806128)
,p_prompt=>'Abteilung'
,p_source=>'DEPARTMENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_DEPARTMENTS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184294692004887683)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(480859905600806128)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Kontrolle des Seitenstatus'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_api.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Seitenkommandos'
,p_alias=>'ADACT'
,p_step_title=>'Seitenkommandos'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210817112525'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(263897160142241089)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADACT_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(560461010911159520)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADACT_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(560461097866159521)
,p_plug_name=>'Mitarbeiterliste (Interactive Grid)'
,p_region_name=>'R8_EMPLOYEES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADACT'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Beispieldialog (Interactive Grid)'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(187775900172710865)
,p_name=>'EMPLOYEE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(187776025686710866)
,p_name=>'FIRST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FIRST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(187776069808710867)
,p_name=>'LAST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nachname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>25
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(187776981430710876)
,p_name=>'DEPARTMENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Abteilung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>30
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(187777086299710877)
,p_name=>'JOB_TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'JOB_TITLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Beruf'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>35
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(187775786192710864)
,p_internal_uid=>76701850285662611
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>240
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(190775142389491781)
,p_interactive_grid_id=>wwv_flow_api.id(187775786192710864)
,p_static_id=>'797013'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(190775425403491781)
,p_report_id=>wwv_flow_api.id(190775142389491781)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(190775921824491785)
,p_view_id=>wwv_flow_api.id(190775425403491781)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(187775900172710865)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(190776768093491790)
,p_view_id=>wwv_flow_api.id(190775425403491781)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(187776025686710866)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(190777726979491792)
,p_view_id=>wwv_flow_api.id(190775425403491781)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(187776069808710867)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(190778585003491795)
,p_view_id=>wwv_flow_api.id(190775425403491781)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(187776981430710876)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(190779453751491796)
,p_view_id=>wwv_flow_api.id(190775425403491781)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(187777086299710877)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(635054542880324464)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(708275878021228037)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(782135724568000560)
,p_plug_name=>'Seitenkommandos'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_ADACT_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190676696000401687)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(782135724568000560)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187777319326710879)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(560461097866159521)
,p_button_name=>'EDIT_EMP'
,p_button_static_id=>'B8_EDIT_EMP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Edit Emp'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190677749293401690)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(708275878021228037)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190677416547401687)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(708275878021228037)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMPLOYEE_ID:118'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_api.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Mitarbeiter bearbeiten'
,p_alias=>'EDEMP'
,p_page_mode=>'MODAL'
,p_step_title=>'Mitarbeiter bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20211107163716'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(190874338511753471)
,p_plug_name=>'Mitarbeiter bearbeiten'
,p_region_name=>'R9_EDEMP_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_EDEMP'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(190882434639753510)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190882835594753512)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(190882434639753510)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190884373615753517)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(190882434639753510)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P9_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190884774297753517)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(190882434639753510)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P9_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(190885136607753517)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(190882434639753510)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P9_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190874643618753474)
,p_name=>'P9_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Employee Id'
,p_source=>'EMPLOYEE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190875067354753482)
,p_name=>'P9_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'First Name'
,p_source=>'FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190875497735753487)
,p_name=>'P9_LAST_NAMES'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_prompt=>'Last Names'
,p_source=>'LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_field_template=>wwv_flow_api.id(184894591749718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190875860376753490)
,p_name=>'P9_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Email'
,p_source=>'EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894591749718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190876312320753492)
,p_name=>'P9_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Phone Number'
,p_source=>'PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190876637085753495)
,p_name=>'P9_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hire Date'
,p_source=>'HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894591749718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190877066161753498)
,p_name=>'P9_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Job Id'
,p_source=>'JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894591749718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190877519330753501)
,p_name=>'P9_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Salary'
,p_source=>'SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190877862352753503)
,p_name=>'P9_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Commission Pct'
,p_source=>'COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190878329768753506)
,p_name=>'P9_MANAGER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Manager Id'
,p_source=>'MANAGER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(190878642743753509)
,p_name=>'P9_DEPARTMENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(190874338511753471)
,p_item_source_plug_id=>wwv_flow_api.id(190874338511753471)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Department Id'
,p_source=>'DEPARTMENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(190882886768753512)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(190882835594753512)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(190883656417753515)
,p_event_id=>wwv_flow_api.id(190882886768753512)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(190886016956753518)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(190874338511753471)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Mitarbeiter bearbeiten'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(190886356960753518)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(190885605185753518)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(190874338511753471)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Mitarbeiter bearbeiten'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Zeile in Bericht erkennen'
,p_alias=>'ADREP'
,p_step_title=>'Zeile in Bericht erkennen'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210818112037'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200874735019833456)
,p_plug_name=>'Beispielbericht (interaktvie Report)'
,p_region_name=>'R10_EMPLOYEE_IR'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADREP'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Beispielbericht (interaktvie Report)'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(200874775077833457)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>240
,p_show_detail_link=>'N'
,p_owner=>'ADC_ADMIN'
,p_internal_uid=>89800839170785204
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(200874871426833458)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Employee Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(200875031048833459)
,p_db_column_name=>'FIRST_NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Vorname'
,p_column_html_expression=>'<span data-id="#EMPLOYEE_ID#">#FIRST_NAME#</span>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(200875098570833460)
,p_db_column_name=>'LAST_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nachname'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(200875178444833461)
,p_db_column_name=>'DEPARTMENT_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Abteilung'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(200875310993833462)
,p_db_column_name=>'JOB_TITLE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Beruf'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(202381189225726584)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'913073'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_ID:FIRST_NAME:LAST_NAME:DEPARTMENT_NAME:JOB_TITLE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200875440769833464)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_PAGE2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(200875607259833465)
,p_name=>'Beispielbericht (klassischer Bericht)'
,p_region_name=>'R10_EMPLOYEE_CR'
,p_template=>wwv_flow_api.id(184832857644718859)
,p_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_grid_column_span=>5
,p_display_column=>3
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADREP'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(184855336202718870)
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(200875714180833466)
,p_query_column_id=>1
,p_column_alias=>'EMPLOYEE_ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(200875786333833467)
,p_query_column_id=>2
,p_column_alias=>'FIRST_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Vorname'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span data-id="#EMPLOYEE_ID#">#FIRST_NAME#</span>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(200875907195833468)
,p_query_column_id=>3
,p_column_alias=>'LAST_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'Nachname'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(200875961972833469)
,p_query_column_id=>4
,p_column_alias=>'DEPARTMENT_NAME'
,p_column_display_sequence=>40
,p_column_heading=>'Abteilung'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(200876085542833470)
,p_query_column_id=>5
,p_column_alias=>'JOB_TITLE'
,p_column_display_sequence=>50
,p_column_heading=>'Beruf'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200876193071833471)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_PAGE3'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(355179659011570928)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_PAGE1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(651743509780489359)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(651743596735489360)
,p_plug_name=>'Beispielbericht (Interactive Grid)'
,p_region_name=>'R10_EMPLOYEES_IG'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADREP'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Beispieldialog (Interactive Grid)'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(279058399042040704)
,p_name=>'EMPLOYEE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(279058524556040705)
,p_name=>'FIRST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FIRST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(279058568678040706)
,p_name=>'LAST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nachname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>25
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(279059480300040715)
,p_name=>'DEPARTMENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Abteilung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>30
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(279059585169040716)
,p_name=>'JOB_TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'JOB_TITLE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Beruf'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>35
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(279058285062040703)
,p_internal_uid=>167984349154992450
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>240
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(282057641258821620)
,p_interactive_grid_id=>wwv_flow_api.id(279058285062040703)
,p_static_id=>'797013'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(282057924272821620)
,p_report_id=>wwv_flow_api.id(282057641258821620)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(282058420693821624)
,p_view_id=>wwv_flow_api.id(282057924272821620)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(279058399042040704)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(282059266962821629)
,p_view_id=>wwv_flow_api.id(282057924272821620)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(279058524556040705)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(282060225848821631)
,p_view_id=>wwv_flow_api.id(282057924272821620)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(279058568678040706)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(282061083872821634)
,p_view_id=>wwv_flow_api.id(282057924272821620)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(279059480300040715)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(282061952620821635)
,p_view_id=>wwv_flow_api.id(282057924272821620)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(279059585169040716)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(726344182941656689)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>60
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(799558376890557876)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(873418223437330399)
,p_plug_name=>'Zeile in Berichten erkennen'
,p_region_name=>'Berichte'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(202357539785378092)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(873418223437330399)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(202358657986378093)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(799558376890557876)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(202358313423378093)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(799558376890557876)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMPLOYEE_ID:118'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(200875379883833463)
,p_name=>'P10_EMPLOYEE_ID_IR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(200874735019833456)
,p_prompt=>unistr('gew\00E4hlte ID')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(202362805539378095)
,p_name=>'P10_EMPLOYEE_ID_IG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(651743596735489360)
,p_prompt=>unistr('gew\00E4hlte ID')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_alias=>'PSEUDO'
,p_step_title=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210818121000'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268688287170000986)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(415769468857677082)
,p_plug_name=>'Use ADC'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_PSEUDO_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Tutorial'
,p_alias=>'TUTORIAL'
,p_step_title=>'Tutorial'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210818115805'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202778034683762768)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(275995679970602151)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276631012783433446)
,p_plug_name=>'ADC Tutorial'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184823236456718856)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(280276917540091743)
,p_plug_name=>'Tutorial Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(202782112055876940)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(349856475484435253)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_TUTORIAL'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(202776596100762760)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(275995679970602151)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(184895472618718892)
,p_button_image_alt=>'ADC verwenden'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:USEADC:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-chevron-right'
);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_api.create_page(
 p_id=>13
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Dokumentation'
,p_alias=>'DOC'
,p_step_title=>'Dokumentation'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210819103929'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(294488452237762510)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(368341430337433188)
,p_plug_name=>'ADC Dokumentation'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184823236456718856)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(371987335094091485)
,p_plug_name=>'Documentation Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(202787804278054153)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(441566893038434995)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_DOC'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00014
begin
wwv_flow_api.create_page(
 p_id=>14
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Mitgelieferte Aktionstypen'
,p_alias=>'MENU_CAT'
,p_step_title=>'Mitgelieferte Aktionstypen'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210819123222'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202977481736300242)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(463988194607797230)
,p_plug_name=>'ActionType Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(203075206277756651)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(184884829661718885)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00015
begin
wwv_flow_api.create_page(
 p_id=>15
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_alias=>'CAT_PAGE_ITEM'
,p_step_title=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210912162726'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200876366440833473)
,p_plug_name=>'Aktionstypen'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(207475595209610981)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(184878577047718884)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200876525178833474)
,p_plug_name=>'Details'
,p_region_name=>'R15_CAT_LIST'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2'
,p_plug_template=>wwv_flow_api.id(184812851368718853)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(203076891197771309)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184842319708718863)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(184777846050718820)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(184896760696718893)
);
end;
/
prompt --application/pages/page_00099
begin
wwv_flow_api.create_page(
 p_id=>99
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Unit Test Testseite'
,p_alias=>'UNITTEST'
,p_step_title=>'Unit Test Testseite'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(184921301414718942)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20211028150520'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(292512027732993028)
,p_plug_name=>'Mitarbeiter bearbeiten'
,p_region_name=>'R99_UNITTEST_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_EDEMP'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(292528147254994167)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(212720001779288910)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(292528147254994167)
,p_button_name=>'CANCEL'
,p_button_static_id=>'B99_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(212720377217288912)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(292528147254994167)
,p_button_name=>'DELETE'
,p_button_static_id=>'B99_DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(212720768908288912)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(292528147254994167)
,p_button_name=>'SAVE'
,p_button_static_id=>'B99_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(212721224184288912)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(292528147254994167)
,p_button_name=>'CREATE'
,p_button_static_id=>'B99_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212711885045287817)
,p_name=>'P99_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Employee Id'
,p_source=>'EMPLOYEE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212712298124287820)
,p_name=>'P99_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'First Name'
,p_source=>'FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212712709706287820)
,p_name=>'P99_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_prompt=>'Last Name'
,p_source=>'LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212713116974287820)
,p_name=>'P99_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_prompt=>'Email'
,p_source=>'EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212713441587287820)
,p_name=>'P99_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Phone Number'
,p_source=>'PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212713878971287821)
,p_name=>'P99_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_prompt=>'Hire Date'
,p_source=>'HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212714313032287821)
,p_name=>'P99_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_prompt=>'Job Id'
,p_source=>'JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212714678055287821)
,p_name=>'P99_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_prompt=>'Salary'
,p_source=>'SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212715108898287821)
,p_name=>'P99_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Commission Pct'
,p_source=>'COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212715491100287821)
,p_name=>'P99_MANAGER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Manager Id'
,p_source=>'MANAGER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(212715926032287821)
,p_name=>'P99_DEPARTMENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(292512027732993028)
,p_item_source_plug_id=>wwv_flow_api.id(292512027732993028)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Department Id'
,p_source=>'DEPARTMENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
end;
/
prompt --application/pages/page_00100
begin
wwv_flow_api.create_page(
 p_id=>100
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Anwendungstexte verwalten'
,p_alias=>'ADPTI'
,p_step_title=>'Anwendungstexte verwalten'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(184921301414718942)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210508103803'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184944449323927771)
,p_plug_name=>'Anwendungstexte'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(184832857644718859)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADPTI'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Anwendungstexte'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(184944919266927771)
,p_name=>'Report 1'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLSX:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:RP:P101_PTI_ID,P101_PTI_PMG_NAME:\#PTI_ID#\,\#PTI_PMG_NAME#\'
,p_detail_link_text=>'<span aria-label="Edit"><span class="fa fa-edit" aria-hidden="true" title="Edit"></span></span>'
,p_owner=>'ADC_ADMIN'
,p_internal_uid=>73870983359879518
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(184945020362927773)
,p_db_column_name=>'PTI_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(184945263589927776)
,p_db_column_name=>'PTI_PMG_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Pti Pmg Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(184945648556927776)
,p_db_column_name=>'PTI_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(184946056052927776)
,p_db_column_name=>'PTI_DISPLAY_NAME'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Bezeichner'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(184946460163927778)
,p_db_column_name=>'PTI_DESCRIPTION'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Beschreibung'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(184974083670345613)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'739002'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PTI_ID:PTI_PMG_NAME:PTI_NAME:PTI_DISPLAY_NAME:PTI_DESCRIPTION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184948617707927781)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(184944449323927771)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anwendungstext erstellen'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:101'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(184947591605927781)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(184944449323927771)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(184948071256927781)
,p_event_id=>wwv_flow_api.id(184947591605927781)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(184944449323927771)
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Anwendungstext bearbeiten'
,p_alias=>'EDPTI'
,p_page_mode=>'MODAL'
,p_step_title=>'Anwendungstext bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(184921301414718942)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210815134842'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184936040090927728)
,p_plug_name=>'Anwendungstext bearbeiten'
,p_region_name=>'EDPTI_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SADC_UI_ADPTI'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184939837469927748)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184814885421718853)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184940275778927749)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(184939837469927748)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184941845192927753)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(184939837469927748)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184942318941927754)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(184939837469927748)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184942697939927754)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(184939837469927748)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184936365052927728)
,p_name=>'P101_PTI_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_source_plug_id=>wwv_flow_api.id(184936040090927728)
,p_prompt=>'ID'
,p_source=>'PTI_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P101_PTI_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184936775996927734)
,p_name=>'P101_PTI_PMG_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_source_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_default=>'SADC'
,p_source=>'PTI_PMG_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184937208414927740)
,p_name=>'P101_PTI_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_source_plug_id=>wwv_flow_api.id(184936040090927728)
,p_source=>'PTI_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184937569537927743)
,p_name=>'P101_PTI_DISPLAY_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_source_plug_id=>wwv_flow_api.id(184936040090927728)
,p_source=>'PTI_DISPLAY_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184937964984927748)
,p_name=>'P101_PTI_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(184936040090927728)
,p_item_source_plug_id=>wwv_flow_api.id(184936040090927728)
,p_prompt=>'Beschreibung'
,p_source=>'PTI_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cSize=>60
,p_cMaxlength=>32767
,p_cHeight=>15
,p_tag_attributes=>'style="height:480px;"'
,p_field_template=>wwv_flow_api.id(184894275810718890)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_02=>'Full'
,p_attribute_07=>'480'
,p_attribute_09=>'html'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(184293548673887672)
,p_validation_name=>'Validate ADPTI'
,p_validation_sequence=>10
,p_validation=>'return sadc_ui.validate_adpti;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(184940355203927749)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(184940275778927749)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(184941161636927751)
,p_event_id=>wwv_flow_api.id(184940355203927749)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184943439812927754)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(184936040090927728)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process ADPTI'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'sadc_ui.process_edpti;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184943839596927754)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184943068068927754)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(184936040090927728)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Anwendungstext bearbeiten'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_api.create_page(
 p_id=>9999
,p_user_interface_id=>wwv_flow_api.id(184918109637718920)
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'ADC Sample Application - Sign In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(184791415420718838)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210513142901'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184922230612718953)
,p_plug_name=>'ADC Sample Application'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184831610247718859)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(184926874292718963)
,p_plug_name=>'Language Selector'
,p_parent_plug_id=>wwv_flow_api.id(184922230612718953)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(184804474632718848)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>'apex_lang.emit_language_selector_list;'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(184924960468718959)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(184922230612718953)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(184895376012718892)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184922627008718954)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(184922230612718953)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894017034718888)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184922969274718954)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(184922230612718953)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(184894017034718888)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(184924100206718957)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(184922230612718953)
,p_prompt=>'Remember username'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOGIN_REMEMBER_USERNAME'
,p_lov=>'.'||wwv_flow_api.id(184923291533718954)||'.'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(184894017034718888)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'If you select this checkbox, the application will save your username in a persistent browser cookie named "LOGIN_USERNAME_COOKIE".',
'When you go to the login page the next time,',
'the username field will be automatically populated with this value.',
'</p>',
'<p>',
'If you deselect this checkbox and your username is already saved in the cookie,',
'the application will overwrite it with an empty value.',
'You can also use your browser''s developer tools to completely remove the cookie.',
'</p>'))
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184925821405718960)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P9999_USERNAME),',
'    p_consent  => :P9999_REMEMBER = ''Y'' );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184925424172718960)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P9999_USERNAME,',
'    p_password => :P9999_PASSWORD );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184926555104718960)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(184926137576718960)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
);
end;
/
set define ^
declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 1');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 1);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(652),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 1,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(654),
    p_cru_cgr_id => adc_admin.map_id(652),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(652));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 2');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 2);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(656),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 2,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(658),
    p_cru_cgr_id => adc_admin.map_id(656),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(656));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 3');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 3);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(660),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 3,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(662),
    p_cru_cgr_id => adc_admin.map_id(660),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(660));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 4');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 4);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(664),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 4,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(666),
    p_cru_cgr_id => adc_admin.map_id(664),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(668),
    p_cra_cru_id => adc_admin.map_id(666),
    p_cra_cgr_id => adc_admin.map_id(664),
    p_cra_cpi_id => 'P4_DATE',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(670),
    p_cra_cru_id => adc_admin.map_id(666),
    p_cra_cgr_id => adc_admin.map_id(664),
    p_cra_cpi_id => 'P4_REQUIRED',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.propagate_rule_change(adc_admin.map_id(664));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 5');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 5);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(672),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 5,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(674),
    p_cru_cgr_id => adc_admin.map_id(672),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(676),
    p_cra_cru_id => adc_admin.map_id(674),
    p_cra_cgr_id => adc_admin.map_id(672),
    p_cra_cpi_id => 'P5_REQUIRED',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(678),
    p_cru_cgr_id => adc_admin.map_id(672),
    p_cru_name => 'ein Datum in der Vergangenheit eingibt',
    p_cru_condition => q'|P5_DATE < sysdate|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(680),
    p_cra_cru_id => adc_admin.map_id(678),
    p_cra_cgr_id => adc_admin.map_id(672),
    p_cra_cpi_id => 'P5_DATE',
    p_cra_cat_id => 'SHOW_ERROR',
    p_cra_param_1 => q'|Das Datum muss in der Zukunft liegen.|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(682),
    p_cru_cgr_id => adc_admin.map_id(672),
    p_cru_name => 'eine nicht erlaubte Zahl eingibt',
    p_cru_condition => q'|P5_NUMBER not between 100 and 1000|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(684),
    p_cra_cru_id => adc_admin.map_id(682),
    p_cra_cgr_id => adc_admin.map_id(672),
    p_cra_cpi_id => 'P5_NUMBER',
    p_cra_cat_id => 'SHOW_ERROR',
    p_cra_param_1 => q'|Die Zahl muss zwischen 100 und 1000 liegen.|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.propagate_rule_change(adc_admin.map_id(672));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 6');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 6);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(686),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 6,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(688),
    p_cru_cgr_id => adc_admin.map_id(686),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(690),
    p_cra_cru_id => adc_admin.map_id(688),
    p_cra_cgr_id => adc_admin.map_id(686),
    p_cra_cpi_id => 'P6_REQUIRED',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(692),
    p_cru_cgr_id => adc_admin.map_id(686),
    p_cru_name => 'eine Zahl eingibt',
    p_cru_condition => q'|P6_NUMBER is not null|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(694),
    p_cra_cru_id => adc_admin.map_id(692),
    p_cra_cgr_id => adc_admin.map_id(686),
    p_cra_cpi_id => 'P6_NUMBER',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|sadc_ui.validate_p6_number|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(696),
    p_cru_cgr_id => adc_admin.map_id(686),
    p_cru_name => 'ein Datum eingibt',
    p_cru_condition => q'|P6_DATE is not null|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(698),
    p_cra_cru_id => adc_admin.map_id(696),
    p_cra_cgr_id => adc_admin.map_id(686),
    p_cra_cpi_id => 'P6_DATE',
    p_cra_cat_id => 'PLSQL_CODE',
    p_cra_param_1 => q'|sadc_ui.validate_p6_date;|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.propagate_rule_change(adc_admin.map_id(686));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 7');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 7);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(700),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 7,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(702),
    p_cru_cgr_id => adc_admin.map_id(700),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(704),
    p_cra_cru_id => adc_admin.map_id(702),
    p_cra_cgr_id => adc_admin.map_id(700),
    p_cra_cpi_id => 'DOCUMENT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'|.sadc-mandatory|',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(706),
    p_cra_cru_id => adc_admin.map_id(702),
    p_cra_cgr_id => adc_admin.map_id(700),
    p_cra_cpi_id => 'P7_JOB_ID',
    p_cra_cat_id => 'RAISE_ITEM_EVENT',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(708),
    p_cru_cgr_id => adc_admin.map_id(700),
    p_cru_name => 'einen Beruf mit Bonusberechtigung wählt',
    p_cru_condition => q'|sadc_ui.is_comm_eligible(P7_JOB_ID) = C_TRUE|',
    p_cru_sort_seq => 20,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(710),
    p_cra_cru_id => adc_admin.map_id(708),
    p_cra_cgr_id => adc_admin.map_id(700),
    p_cra_cpi_id => 'P7_COMMISSION_PCT',
    p_cra_cat_id => 'IS_MANDATORY',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(712),
    p_cru_cgr_id => adc_admin.map_id(700),
    p_cru_name => 'einen Beruf ohne Bonusberechtigung wählt',
    p_cru_condition => q'|sadc_ui.is_comm_eligible(P7_JOB_ID) = C_FALSE|',
    p_cru_sort_seq => 30,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(714),
    p_cra_cru_id => adc_admin.map_id(712),
    p_cra_cgr_id => adc_admin.map_id(700),
    p_cra_cpi_id => 'P7_COMMISSION_PCT',
    p_cra_cat_id => 'IS_OPTIONAL',
    p_cra_param_1 => q'||',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 10,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  adc_admin.merge_rule_action(
    p_cra_id => adc_admin.map_id(716),
    p_cra_cru_id => adc_admin.map_id(712),
    p_cra_cgr_id => adc_admin.map_id(700),
    p_cra_cpi_id => 'P7_COMMISSION_PCT',
    p_cra_cat_id => 'SET_VISUAL_STATE',
    p_cra_param_1 => q'|SHOW_DISABLE|',
    p_cra_param_2 => q'||',
    p_cra_param_3 => q'||',
    p_cra_sort_seq => 20,
    p_cra_on_error => adc_util.C_FALSE,
    p_cra_raise_recursive => adc_util.C_TRUE,
    p_cra_active => adc_util.C_TRUE);
  
  adc_admin.propagate_rule_change(adc_admin.map_id(700));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 8');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 8);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(718),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 8,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(720),
    p_cru_cgr_id => adc_admin.map_id(718),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(718));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 10');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 10);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(722),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 10,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(724),
    p_cru_cgr_id => adc_admin.map_id(722),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(722));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 11');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 11);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(726),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 11,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(728),
    p_cru_cgr_id => adc_admin.map_id(726),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(726));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 12');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 12);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(730),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 12,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(732),
    p_cru_cgr_id => adc_admin.map_id(730),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(730));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 13');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 13);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(734),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 13,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(736),
    p_cru_cgr_id => adc_admin.map_id(734),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(734));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 14');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 14);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(738),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 14,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(740),
    p_cru_cgr_id => adc_admin.map_id(738),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(738));

  commit;
end;
/


declare
  l_foo number;
  l_app_id number;
begin
  l_foo := adc_admin.map_id;
  l_app_id := apex_application_install.get_application_id;

  dbms_output.put_line('Rulegroup page 15');

  adc_admin.prepare_rule_group_import(
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 15);

  adc_admin.merge_rule_group(
    p_cgr_id => adc_admin.map_id(742),
    p_cgr_app_id => l_app_id,
    p_cgr_page_id => 15,
    p_cgr_with_recursion => adc_util.C_TRUE,
    p_cgr_active => adc_util.C_TRUE);
  
  adc_admin.merge_rule(
    p_cru_id => adc_admin.map_id(744),
    p_cru_cgr_id => adc_admin.map_id(742),
    p_cru_name => 'die Seite öffnet',
    p_cru_condition => q'|initializing = c_true|',
    p_cru_sort_seq => 10,
    p_cru_fire_on_page_load => adc_util.C_FALSE,
    p_cru_active => adc_util.C_TRUE);
  
  
  adc_admin.propagate_rule_change(adc_admin.map_id(742));

  commit;
end;
/

set define onprompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
