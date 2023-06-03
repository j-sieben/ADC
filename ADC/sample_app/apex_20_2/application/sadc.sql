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
,p_default_id_offset=>726624762833141824
,p_default_owner=>'ADC_APP'
);
end;
/
 
prompt APPLICATION 118 - ADC Beispielanwendung
--
-- Application Export:
--   Application:     118
--   Name:            ADC Beispielanwendung
--   Date and Time:   11:28 Saturday June 3, 2023
--   Exported By:     ADC_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     23
--       Items:                   92
--       Validations:              1
--       Processes:               12
--       Regions:                 93
--       Buttons:                 56
--       Dynamic Actions:          4
--     Shared Components:
--       Logic:
--         Items:                  7
--         Processes:              1
--         Computations:           1
--       Navigation:
--         Lists:                  7
--         Breadcrumbs:            1
--           Entries:             18
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
--         LOVs:                   6
--         Shortcuts:              1
--         Plug-ins:               1
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--       Install scripts:         17
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
,p_authentication_id=>wwv_flow_api.id(800328447879812389)
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
,p_last_upd_yyyymmddhh24miss=>'20230603112819'
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
 p_id=>wwv_flow_api.id(800329166210812392)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800478908183812539)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Startseite'
,p_list_item_link_target=>'f?p=&APP_ID.:home:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(817659633453240528)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Tutorial'
,p_list_item_link_target=>'f?p=&APP_ID.:tutorial:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-user-graduate'
,p_parent_list_item_id=>wwv_flow_api.id(800478908183812539)
,p_list_text_01=>unistr('Einf\00FChrung in die Verwendung von ADC')
,p_list_text_02=>unistr('Schritt-f\00FCr-Schritt-Anweisungen zur Verwendung von ADC in Ihren Anwendungen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'12'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800497736153021350)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Anwendungstexte verwalten'
,p_list_item_link_target=>'f?p=&APP_ID.:adpti:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_security_scheme=>wwv_flow_api.id(800471487817812511)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'100,101'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800529378221604402)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'ADC verwenden'
,p_list_item_link_target=>'f?p=&APP_ID.:useadc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Referenzierungsm\00F6glichkeiten des Plugins auf dynamischen Seiten')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800533570814683616)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'ADC Administrationsanwendung'
,p_list_item_link_target=>'f?p=&APP_ID.:adadc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Einf\00FChrung der zentralen ADC-Administrationsanwendung')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800545510028627322)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>unistr('Einfache Anwendungsf\00E4lle')
,p_list_item_link_target=>'f?p=&APP_ID.:adanf:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Zeigt, wie Pflichtfelder generiert und Felder ausgeblendet werden k\00F6nnen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'4'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800566303887993533)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Einfache Validierungen'
,p_list_item_link_target=>'f?p=&APP_ID.:adval:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Einfache Validierungen mittels Anwendungsf\00E4llen')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'5'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800827680104555495)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Komplexere Validierungen'
,p_list_item_link_target=>'f?p=&APP_ID.:adval2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>'Validierung von Eingaben mit zentraler Validierungslogik in Packages'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'6'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(801126525198309441)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Kontrolle des Seitenstatus'
,p_list_item_link_target=>'f?p=&APP_ID.:adsta:&SESSION.::&DEBUG.::P7_EMP_ID:106:'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Implementierung von Anwendungsf\00E4llen in einem Mitarbeiter-Dialog')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'7'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(817916569214490217)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'Zeile in Bericht erkennen'
,p_list_item_link_target=>'f?p=&APP_ID.:adrep:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Ausge\00E4hlte Zeile eines Berichts erkennen und darauf reagieren')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(806226197509495245)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Seitenkommandos'
,p_list_item_link_target=>'f?p=&APP_ID.:adact:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Erl\00E4uterungen zum Einsatz von Seitenkommandos')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'8'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(616038118297435109)
,p_list_item_display_sequence=>170
,p_list_item_link_text=>'Erweiterte Initialisierung'
,p_list_item_link_target=>'f?p=&APP_ID.:einit:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-arrow-circle-right'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_text_01=>unistr('Zeigt die Verwendung von Initialisierungsregeln, die zus\00E4tzlich ausgef\00FChrt werden, falls eine Bedingung vorliegt.')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'16'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(618478965656641417)
,p_list_item_display_sequence=>180
,p_list_item_link_text=>unistr('Seitenkommandos ausf\00FChren')
,p_list_item_link_target=>'f?p=&APP_ID.:caaex:&SESSION.::&DEBUG.::::'
,p_parent_list_item_id=>wwv_flow_api.id(817659633453240528)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'17'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(818331591572877128)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Dokumentation'
,p_list_item_link_target=>'f?p=&APP_ID.:doc:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bookmark-o'
,p_parent_list_item_id=>wwv_flow_api.id(800478908183812539)
,p_list_text_01=>'Technische Informationen'
,p_list_text_02=>unistr('\00DCbersicht \00FCber verf\00FCgbare Aktionstypen, Pseudospalten und weiteres')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'13'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(810334192627631980)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_list_item_link_target=>'f?p=&APP_ID.:pseudo:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-columns'
,p_parent_list_item_id=>wwv_flow_api.id(818331591572877128)
,p_list_text_01=>unistr('\00DCbersicht \00FCber die Pseudospalten f\00FCr Anwendungsf\00E4lle')
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'11'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(818527808324393802)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Mitgelieferte Aktionstypen'
,p_list_item_link_target=>'f?p=&APP_ID.:menu_cat:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bolt'
,p_parent_list_item_id=>wwv_flow_api.id(818331591572877128)
,p_list_text_01=>unistr('\00DCbersicht \00FCber die Aktionstypen von ADC')
,p_list_text_02=>'Beschreibt die Verwendung aller mitgelieferter ADC-Aktionstypen'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'14'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(818627230605864877)
,p_list_item_display_sequence=>160
,p_list_item_link_text=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_list_item_link_target=>'f?p=&APP_ID.:catpi:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bolt'
,p_parent_list_item_id=>wwv_flow_api.id(818527808324393802)
,p_list_text_01=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_list_text_02=>'Manipulation der Sichtbarkeit, Pflichtstatus, Label etc.'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'15'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(618620458166237526)
,p_list_item_display_sequence=>190
,p_list_item_link_text=>'Elemente mit ADC'
,p_list_item_link_target=>'f?p=&APP_ID.:elems:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-bolt'
,p_parent_list_item_id=>wwv_flow_api.id(818331591572877128)
,p_list_text_01=>'Demonstrationsseite'
,p_list_text_02=>'Zeigt die wichtigsten Seitenelemente in verschiedenen Status, kontrolliert durch ADC'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(800468628234812491)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800480386035812547)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'&APP_USER.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800480826689812547)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_api.id(800480386035812547)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(800481217110812547)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_api.id(800480386035812547)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/main_page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(804125492796470817)
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
 p_id=>wwv_flow_api.id(818332938981970511)
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
 p_id=>wwv_flow_api.id(818338631204147724)
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
 p_id=>wwv_flow_api.id(818626033203850222)
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
 p_id=>wwv_flow_api.id(823026422135704552)
,p_name=>'ActionTypeDetail Navigation'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT status, label_value, target_value, is_current, ',
'       image_value, image_attr_value, image_alt_value,',
'       attribute_01, attribute_02',
'  FROM sadc_ui_menu_catitems',
' WHERE cat_catg_id = (select replace(v(''APP_PAGE_ALIAS''), ''CAT_'') from dual)'))
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
 p_id=>wwv_flow_api.id(800469936939812509)
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
 p_id=>wwv_flow_api.id(800470250255812511)
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
 p_id=>wwv_flow_api.id(255795250355302285)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795321721302285)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795456251302285)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795533711302285)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795583294302285)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'modern'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795685051302287)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795834169302287)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255795914921302287)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(255867598691674238)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'PLUGIN_DE.CONDES.PLUGIN.ADC'
,p_attribute_01=>'de.condes.plugin.adc.apex_42_20_2'
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(800471487817812511)
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
 p_id=>wwv_flow_api.id(806026274966210222)
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
 p_id=>wwv_flow_api.id(800552972285729661)
,p_name=>'SADC_ADC_URL'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_id
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(817825805375864580)
,p_name=>'SADC_NEXT_ID'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_target
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(804426073958477763)
,p_name=>'SADC_NEXT_TARGET'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_next_title
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(804425675991474192)
,p_name=>'SADC_NEXT_TITLE'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_id
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(817825973669865419)
,p_name=>'SADC_PREV_ID'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_target
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(804425467082472180)
,p_name=>'SADC_PREV_TARGET'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_items/sadc_prev_title
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(804425317074471227)
,p_name=>'SADC_PREV_TITLE'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_computations/sadc_adc_url
begin
wwv_flow_api.create_flow_computation(
 p_id=>wwv_flow_api.id(800553386572734625)
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
 p_id=>wwv_flow_api.id(800474118459812525)
,p_lov_name=>'LOGIN_REMEMBER_USERNAME'
,p_lov_query=>'.'||wwv_flow_api.id(800474118459812525)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(800474485789812528)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Remember username'
,p_lov_return_value=>'Y'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_departments
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(801137170657360202)
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
prompt --application/shared_components/user_interface/lovs/lov_elements_checkbox
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(618553306150446984)
,p_lov_name=>'LOV_ELEMENTS_CHECKBOX'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'SADC_LOV_JOB'
,p_query_where=>'rownum < 4'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_elements_control
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(618554497173446992)
,p_lov_name=>'LOV_ELEMENTS_CONTROL'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'SADC_LOV_DEPARTMENT'
,p_query_where=>'rownum < 4'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_elements_radio
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(618555399258446992)
,p_lov_name=>'LOV_ELEMENTS_RADIO'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'SADC_LOV_DEPARTMENT'
,p_query_where=>'rownum < 4'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_jobs
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(801137057391358261)
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
 p_id=>wwv_flow_api.id(800472128340812513)
,p_group_name=>'Administration'
);
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(800328672976812391)
,p_name=>'Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(616049708600435134)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Erweiterte Initialisierung'
,p_link=>'f?p=&APP_ID.:16:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>16
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(618485550358641439)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>unistr('Seitenkommandos ausf\00FChren')
,p_link=>'f?p=&APP_ID.:17:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>17
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(618551564374446978)
,p_parent_id=>wwv_flow_api.id(818337549458141594)
,p_short_name=>'Elemente mit ADC'
,p_link=>'f?p=&APP_ID.:50:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>50
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800328882696812391)
,p_parent_id=>0
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800527086586534316)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Anwendungstexte verwalten'
,p_link=>'f?p=&APP_ID.:ADPTI:&SESSION.::&DEBUG.:100::'
,p_page_id=>100
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800530299715604405)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'ADC verwenden'
,p_link=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800535776734683622)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'ADC Administrationsanwendung'
,p_link=>'f?p=&APP_ID.:ADADC:&SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800549866258627341)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800570675831993549)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Einfache Validierungen'
,p_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(800832153417555514)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Komplexere Validierungen'
,p_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:::'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(801130783204309458)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Kontrolle des Seitenstatus'
,p_link=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(806237838335495269)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Seitenkommandos'
,p_link=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(810336403648631981)
,p_parent_id=>wwv_flow_api.id(818337549458141594)
,p_short_name=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(817921323234510402)
,p_parent_id=>wwv_flow_api.id(818329216609856341)
,p_short_name=>'Zeile eines Berichts erkennen'
,p_link=>'f?p=&APP_ID.:ADREP:&SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(818329216609856341)
,p_parent_id=>wwv_flow_api.id(800328882696812391)
,p_short_name=>'Tutorial'
,p_link=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(818337549458141594)
,p_parent_id=>wwv_flow_api.id(800328882696812391)
,p_short_name=>'Dokumentation'
,p_link=>'f?p=&APP_ID.:13:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>13
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(818528757912393814)
,p_parent_id=>wwv_flow_api.id(818337549458141594)
,p_short_name=>'Mitgelieferte Aktionstypen'
,p_link=>'f?p=&APP_ID.:menu_cat:&SESSION.::&DEBUG.:::'
,p_page_id=>14
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(818628117900864881)
,p_parent_id=>wwv_flow_api.id(818528757912393814)
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
 p_id=>wwv_flow_api.id(800329510339812395)
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
 p_id=>wwv_flow_api.id(800329812220812400)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800330100018812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800330442673812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800330731293812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800330979301812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800331288275812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800331572247812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800331952958812403)
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
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
 p_id=>wwv_flow_api.id(800332350773812406)
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
 p_id=>wwv_flow_api.id(800332610231812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800332944689812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800333218455812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800333487375812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800333792790812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800334122083812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800334384841812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800334720124812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800335035196812406)
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
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
 p_id=>wwv_flow_api.id(800335457146812406)
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
 p_id=>wwv_flow_api.id(800335723664812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800335993133812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800336285397812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800336604691812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800336953668812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800337170646812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800337538870812408)
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
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
 p_id=>wwv_flow_api.id(800337937605812408)
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
 p_id=>wwv_flow_api.id(800338182843812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800338501930812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800338794163812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800339153943812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800339382055812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800339761156812408)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800340024811812409)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800340355464812409)
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
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
 p_id=>wwv_flow_api.id(800340671791812409)
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
 p_id=>wwv_flow_api.id(800341060748812409)
,p_page_template_id=>wwv_flow_api.id(800340671791812409)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800341269624812409)
,p_page_template_id=>wwv_flow_api.id(800340671791812409)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800341645175812409)
,p_page_template_id=>wwv_flow_api.id(800340671791812409)
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
 p_id=>wwv_flow_api.id(800342242346812409)
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
 p_id=>wwv_flow_api.id(800342502974812409)
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800342815549812409)
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800343145990812409)
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
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
 p_id=>wwv_flow_api.id(800344552954812411)
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
 p_id=>wwv_flow_api.id(800344800591812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800345111836812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800345396715812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800345735415812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800346004077812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800346320086812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800346601655812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800346937176812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800347214933812413)
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
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
 p_id=>wwv_flow_api.id(800347580181812413)
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
 p_id=>wwv_flow_api.id(800347867867812416)
,p_page_template_id=>wwv_flow_api.id(800347580181812413)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800348224692812416)
,p_page_template_id=>wwv_flow_api.id(800347580181812413)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800348476997812416)
,p_page_template_id=>wwv_flow_api.id(800347580181812413)
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
 p_id=>wwv_flow_api.id(800349066654812416)
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
 p_id=>wwv_flow_api.id(800349387044812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800349677064812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800349996172812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800350272488812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800350627372812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800350896726812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(800351225410812416)
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
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
 p_id=>wwv_flow_api.id(800445544494812461)
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
 p_id=>wwv_flow_api.id(800446202938812463)
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
 p_id=>wwv_flow_api.id(800446299544812463)
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
 p_id=>wwv_flow_api.id(800351603411812417)
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
 p_id=>wwv_flow_api.id(800351955914812419)
,p_plug_template_id=>wwv_flow_api.id(800351603411812417)
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
 p_id=>wwv_flow_api.id(800355301558812419)
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
 p_id=>wwv_flow_api.id(800355554574812419)
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
 p_id=>wwv_flow_api.id(800355793079812419)
,p_plug_template_id=>wwv_flow_api.id(800355554574812419)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800356128228812420)
,p_plug_template_id=>wwv_flow_api.id(800355554574812419)
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
 p_id=>wwv_flow_api.id(800356339670812420)
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
 p_id=>wwv_flow_api.id(800356596086812420)
,p_plug_template_id=>wwv_flow_api.id(800356339670812420)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800356929364812420)
,p_plug_template_id=>wwv_flow_api.id(800356339670812420)
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
 p_id=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(800366048096812424)
,p_plug_template_id=>wwv_flow_api.id(800365712347812424)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800366360893812425)
,p_plug_template_id=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(800367745024812425)
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
 p_id=>wwv_flow_api.id(800368668578812425)
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
 p_id=>wwv_flow_api.id(800369048136812425)
,p_plug_template_id=>wwv_flow_api.id(800368668578812425)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800369275680812425)
,p_plug_template_id=>wwv_flow_api.id(800368668578812425)
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
 p_id=>wwv_flow_api.id(800374063382812427)
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
 p_id=>wwv_flow_api.id(800374404541812427)
,p_plug_template_id=>wwv_flow_api.id(800374063382812427)
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
 p_id=>wwv_flow_api.id(800376169144812430)
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
 p_id=>wwv_flow_api.id(800376547638812430)
,p_plug_template_id=>wwv_flow_api.id(800376169144812430)
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
 p_id=>wwv_flow_api.id(800378521501812430)
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
 p_id=>wwv_flow_api.id(800378800233812430)
,p_plug_template_id=>wwv_flow_api.id(800378521501812430)
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
 p_id=>wwv_flow_api.id(800381783445812430)
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
 p_id=>wwv_flow_api.id(800382437173812430)
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
 p_id=>wwv_flow_api.id(800382703913812430)
,p_plug_template_id=>wwv_flow_api.id(800382437173812430)
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
 p_id=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(800383973123812433)
,p_plug_template_id=>wwv_flow_api.id(800383684570812430)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800384360266812433)
,p_plug_template_id=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(800390474290812434)
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
 p_id=>wwv_flow_api.id(800390796566812434)
,p_plug_template_id=>wwv_flow_api.id(800390474290812434)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(800391157446812434)
,p_plug_template_id=>wwv_flow_api.id(800390474290812434)
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
 p_id=>wwv_flow_api.id(800393146634812434)
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
 p_id=>wwv_flow_api.id(800394124962812434)
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
 p_id=>wwv_flow_api.id(800394454436812434)
,p_plug_template_id=>wwv_flow_api.id(800394124962812434)
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
 p_id=>wwv_flow_api.id(800419385551812447)
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
 p_id=>wwv_flow_api.id(800421004264812449)
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
 p_id=>wwv_flow_api.id(800423167531812450)
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
 p_id=>wwv_flow_api.id(800424577755812450)
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
 p_id=>wwv_flow_api.id(800425621608812452)
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
 p_id=>wwv_flow_api.id(800429403973812455)
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
 p_id=>wwv_flow_api.id(800432363465812456)
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
 p_id=>wwv_flow_api.id(800434205926812456)
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
 p_id=>wwv_flow_api.id(800435172231812456)
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
 p_id=>wwv_flow_api.id(800435656587812456)
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
 p_id=>wwv_flow_api.id(800441019290812459)
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
 p_id=>wwv_flow_api.id(800442620754812459)
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
 p_id=>wwv_flow_api.id(800443166695812459)
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
 p_id=>wwv_flow_api.id(800395389846812436)
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
 p_id=>wwv_flow_api.id(800395601579812438)
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
 p_id=>wwv_flow_api.id(800399565736812438)
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
 p_id=>wwv_flow_api.id(800405017948812441)
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
 p_id=>wwv_flow_api.id(800406163128812441)
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
 p_id=>wwv_flow_api.id(800406163128812441)
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
 p_id=>wwv_flow_api.id(800408850437812444)
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
 p_id=>wwv_flow_api.id(800409226389812444)
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
 p_id=>wwv_flow_api.id(800412393815812444)
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
 p_id=>wwv_flow_api.id(800412580080812444)
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
 p_id=>wwv_flow_api.id(800415607004812447)
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
 p_id=>wwv_flow_api.id(800417577017812447)
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
 p_id=>wwv_flow_api.id(800444843960812459)
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
 p_id=>wwv_flow_api.id(800444911164812461)
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
 p_id=>wwv_flow_api.id(800445057815812461)
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
 p_id=>wwv_flow_api.id(800445102736812461)
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
 p_id=>wwv_flow_api.id(800445185995812461)
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
 p_id=>wwv_flow_api.id(800445352968812461)
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
 p_id=>wwv_flow_api.id(800445418675812461)
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
 p_id=>wwv_flow_api.id(800447587622812464)
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
 p_id=>wwv_flow_api.id(800447806867812467)
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
 p_id=>wwv_flow_api.id(800447698559812466)
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
 p_id=>wwv_flow_api.id(800449195315812475)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(800349066654812416)
,p_default_dialog_template=>wwv_flow_api.id(800347580181812413)
,p_error_template=>wwv_flow_api.id(800342242346812409)
,p_printer_friendly_template=>wwv_flow_api.id(800349066654812416)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(800342242346812409)
,p_default_button_template=>wwv_flow_api.id(800446202938812463)
,p_default_region_template=>wwv_flow_api.id(800383684570812430)
,p_default_chart_template=>wwv_flow_api.id(800383684570812430)
,p_default_form_template=>wwv_flow_api.id(800383684570812430)
,p_default_reportr_template=>wwv_flow_api.id(800383684570812430)
,p_default_tabform_template=>wwv_flow_api.id(800383684570812430)
,p_default_wizard_template=>wwv_flow_api.id(800383684570812430)
,p_default_menur_template=>wwv_flow_api.id(800393146634812434)
,p_default_listr_template=>wwv_flow_api.id(800383684570812430)
,p_default_irr_template=>wwv_flow_api.id(800381783445812430)
,p_default_report_template=>wwv_flow_api.id(800406163128812441)
,p_default_label_template=>wwv_flow_api.id(800445102736812461)
,p_default_menu_template=>wwv_flow_api.id(800447587622812464)
,p_default_calendar_template=>wwv_flow_api.id(800447698559812466)
,p_default_list_template=>wwv_flow_api.id(800443166695812459)
,p_default_nav_list_template=>wwv_flow_api.id(800434205926812456)
,p_default_top_nav_list_temp=>wwv_flow_api.id(800434205926812456)
,p_default_side_nav_list_temp=>wwv_flow_api.id(800432363465812456)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(800365712347812424)
,p_default_dialogr_template=>wwv_flow_api.id(800355301558812419)
,p_default_option_label=>wwv_flow_api.id(800445102736812461)
,p_default_required_label=>wwv_flow_api.id(800445418675812461)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(800435172231812456)
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
 p_id=>wwv_flow_api.id(800448032114812469)
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
 p_id=>wwv_flow_api.id(800448188804812469)
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
 p_id=>wwv_flow_api.id(800448410540812469)
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
 p_id=>wwv_flow_api.id(800448606923812469)
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
 p_id=>wwv_flow_api.id(800448773829812469)
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
 p_id=>wwv_flow_api.id(800448989390812469)
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
 p_id=>wwv_flow_api.id(800343441518812411)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800344247056812411)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800352372857812419)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800352800553812419)
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
 p_id=>wwv_flow_api.id(800353455773812419)
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
 p_id=>wwv_flow_api.id(800353860373812419)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800357200318812420)
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
 p_id=>wwv_flow_api.id(800357989506812420)
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
 p_id=>wwv_flow_api.id(800359197786812422)
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
 p_id=>wwv_flow_api.id(800360431611812422)
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
 p_id=>wwv_flow_api.id(800360826887812422)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800361619815812422)
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
 p_id=>wwv_flow_api.id(800362828385812424)
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
 p_id=>wwv_flow_api.id(800364183989812424)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800365021236812424)
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
 p_id=>wwv_flow_api.id(800366847690812425)
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
 p_id=>wwv_flow_api.id(800371452877812427)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800371781223812427)
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
 p_id=>wwv_flow_api.id(800372573071812427)
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
 p_id=>wwv_flow_api.id(800374705837812427)
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
 p_id=>wwv_flow_api.id(800375359483812430)
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
 p_id=>wwv_flow_api.id(800377246618812430)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800379138715812430)
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
 p_id=>wwv_flow_api.id(800382982971812430)
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
 p_id=>wwv_flow_api.id(800391405261812434)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800391802409812434)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800392563968812434)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800394693401812434)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800395895194812438)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800396312356812438)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800398268589812438)
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
 p_id=>wwv_flow_api.id(800400141111812441)
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
 p_id=>wwv_flow_api.id(800401941434812441)
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
 p_id=>wwv_flow_api.id(800402673341812441)
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
 p_id=>wwv_flow_api.id(800404129854812441)
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
 p_id=>wwv_flow_api.id(800405277884812441)
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
 p_id=>wwv_flow_api.id(800406481064812441)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800407134490812441)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800407512142812444)
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
 p_id=>wwv_flow_api.id(800409557654812444)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800409950066812444)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800410357512812444)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800410682883812444)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800411062904812444)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800411486284812444)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800412111856812444)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800414345856812444)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800415919340812447)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800419723621812449)
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
 p_id=>wwv_flow_api.id(800420309787812449)
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
 p_id=>wwv_flow_api.id(800421335580812450)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800423554357812450)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800426888699812452)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800428073021812455)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800430708069812455)
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
 p_id=>wwv_flow_api.id(800431342969812455)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800433113455812456)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800436064310812456)
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
 p_id=>wwv_flow_api.id(800438154040812456)
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
 p_id=>wwv_flow_api.id(800438741330812456)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800444314294812459)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800445685347812463)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800446749941812463)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800449426125812478)
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
 p_id=>wwv_flow_api.id(800449805502812480)
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
 p_id=>wwv_flow_api.id(800451390887812480)
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
 p_id=>wwv_flow_api.id(800451763943812480)
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
 p_id=>wwv_flow_api.id(800453382575812480)
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
 p_id=>wwv_flow_api.id(800453855628812480)
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
 p_id=>wwv_flow_api.id(800455411444812481)
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
 p_id=>wwv_flow_api.id(800455787696812481)
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
 p_id=>wwv_flow_api.id(800457375147812481)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800457828580812481)
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
 p_id=>wwv_flow_api.id(800458221841812481)
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
 p_id=>wwv_flow_api.id(800458572908812484)
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
 p_id=>wwv_flow_api.id(800459025051812484)
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
 p_id=>wwv_flow_api.id(800459454958812484)
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
 p_id=>wwv_flow_api.id(800459842345812484)
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
 p_id=>wwv_flow_api.id(800461177832812484)
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
 p_id=>wwv_flow_api.id(800462572696812484)
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
 p_id=>wwv_flow_api.id(800463635680812484)
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
 p_id=>wwv_flow_api.id(800464026657812484)
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
 p_id=>wwv_flow_api.id(800464372240812484)
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
 p_id=>wwv_flow_api.id(800464794566812484)
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
 p_id=>wwv_flow_api.id(800465432560812484)
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
 p_id=>wwv_flow_api.id(800466012048812484)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(800466450095812484)
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
 p_id=>wwv_flow_api.id(800466768780812484)
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
 p_id=>wwv_flow_api.id(800467228251812484)
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
 p_id=>wwv_flow_api.id(800467998055812486)
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
 p_id=>wwv_flow_api.id(800332187375812406)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800329510339812395)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800335303177812406)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800332350773812406)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800337826084812408)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800335457146812406)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800340589032812409)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800337937605812408)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800341885584812409)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(800340671791812409)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800342106035812409)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(800340671791812409)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800343589449812411)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(800343441518812411)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800343807487812411)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(800343441518812411)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800344018058812411)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(800343441518812411)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800344405051812411)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(800342242346812409)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(800344247056812411)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800347501993812413)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800344552954812411)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800348803911812416)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(800347580181812413)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800349035040812416)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(800347580181812413)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800351502445812416)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(800349066654812416)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800352184730812419)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800352654959812419)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(800352372857812419)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800353040610812419)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(800352800553812419)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800353226009812419)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(800352800553812419)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800353633310812419)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(800353455773812419)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800354027078812419)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(800353860373812419)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800354250156812419)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(800352372857812419)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800354416541812419)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(800353455773812419)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800354591975812419)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(800352372857812419)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800354784688812419)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(800353455773812419)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800355043901812419)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(800352372857812419)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800355220730812419)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800351603411812417)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(800353860373812419)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800357391795812420)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(800357200318812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800357562903812420)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(800357200318812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800357782428812420)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(800357200318812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800358166601812420)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800358395874812420)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800358606439812422)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800358825894812422)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(800357200318812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800359027427812422)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800359398753812422)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800359632802812422)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800359837155812422)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800359988072812422)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800360179674812422)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800360600866812422)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(800360431611812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800361062581812422)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800361191261812422)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(800360431611812422)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800361375278812422)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800361859726812422)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800361972526812422)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800362183746812422)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800362396899812422)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800362618126812424)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800363025665812424)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(800362828385812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800363229029812424)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800363368130812424)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800363659279812424)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800356339670812420)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(800362828385812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800364010018812424)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800364412959812424)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(800364183989812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800364585806812424)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(800364183989812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800364764127812424)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(800364183989812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800365170682812424)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(800365021236812424)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800365395039812424)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(800365021236812424)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800365602447812424)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800363678294812424)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800366604717812425)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800365712347812424)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800366975574812425)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(800365712347812424)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(800366847690812425)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800367190476812425)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(800365712347812424)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800367445505812425)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(800365712347812424)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(800366847690812425)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800367633893812425)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800365712347812424)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800368058903812425)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800367745024812425)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800368234594812425)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800367745024812425)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800368453328812425)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800367745024812425)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800368627468812425)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800367745024812425)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800369608216812425)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800369840946812425)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800369962855812425)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800370222845812425)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800370420077812425)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800370657272812427)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800370797764812427)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800370988295812427)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800371262769812427)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800371567881812427)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(800371452877812427)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800372051114812427)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(800371781223812427)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800372250150812427)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(800371452877812427)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800372459275812427)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800372790539812427)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(800372573071812427)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800372975621812427)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800373172630812427)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800373418041812427)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800373608387812427)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800373782540812427)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800374032280812427)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800368668578812425)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800374879574812430)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(800374705837812427)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800375087627812430)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800375518317812430)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(800375359483812430)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800375752573812430)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(800375359483812430)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800375899662812430)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800376132336812430)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800374063382812427)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800376836182812430)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800376985275812430)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800377425791812430)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800377594887812430)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800377830295812430)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800378025747812430)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800378227806812430)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800378379708812430)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800376169144812430)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800379316402812430)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(800379138715812430)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800379495085812430)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(800379138715812430)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800379742037812430)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800379901234812430)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(800379138715812430)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800380143940812430)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(800379138715812430)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800380313871812430)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800380489704812430)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(800379138715812430)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800380701236812430)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800380909644812430)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800381099410812430)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800381326164812430)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800381537078812430)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800381667881812430)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800378521501812430)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(800377246618812430)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800382155077812430)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800381783445812430)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800382353594812430)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800381783445812430)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800383238144812430)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800382437173812430)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(800382982971812430)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800383437237812430)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800382437173812430)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(800382982971812430)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800383634944812430)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800382437173812430)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(800382982971812430)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800384581572812433)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800384797814812433)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800384962934812433)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800385175689812433)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(800357989506812420)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800385418446812433)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800385610899812433)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800385850797812433)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800386022578812433)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800386255408812433)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800386428005812433)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800386659314812433)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800386807021812433)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800387018116812433)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800387181400812433)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800387389024812433)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800387615024812433)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800387799575812433)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800388025014812433)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800388166111812433)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(800359197786812422)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800388384335812433)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(800360431611812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800388641576812433)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800388830626812433)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(800360431611812422)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389031335812433)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389250501812433)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389435072812433)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389593623812433)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(800360826887812422)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389812613812433)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800389969966812433)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800390238883812433)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800390444854812434)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(800383684570812430)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(800361619815812422)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800391660610812434)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(800391405261812434)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800391998194812434)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(800391802409812434)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800392186572812434)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800392412366812434)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(800391802409812434)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800392810067812434)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(800392563968812434)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800392993942812434)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800390474290812434)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(800392563968812434)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800393448091812434)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800393146634812434)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(800364183989812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800393624533812434)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800393146634812434)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800393858367812434)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(800393146634812434)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(800364183989812424)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800393992299812434)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800393146634812434)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800394905174812436)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(800394124962812434)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(800394693401812434)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800395144614812436)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800394124962812434)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(800394693401812434)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800395360028812436)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(800394124962812434)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800396129100812438)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(800395895194812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800396545935812438)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800396744778812438)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(800395895194812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800396872792812438)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800397145086812438)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(800395895194812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800397325730812438)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800397489135812438)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800397677687812438)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(800395895194812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800397955684812438)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(800395895194812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800398099165812438)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800398487339812438)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800398687446812438)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800398941989812438)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800399125122812438)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800399305191812438)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800399557769812438)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800395601579812438)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800399939928812441)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800400330057812441)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(800400141111812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800400549150812441)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800400734514812441)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(800400141111812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800400902081812441)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800401158658812441)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(800400141111812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800401273448812441)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800401562549812441)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800401669085812441)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800402141629812441)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(800401941434812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800402296679812441)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(800401941434812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800402470649812441)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800402917130812441)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(800402673341812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800403097315812441)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(800402673341812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800403343852812441)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800403498412812441)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800403667403812441)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800403866354812441)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(800400141111812441)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800404299200812441)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800404537544812441)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800404670761812441)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800404959396812441)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800399565736812438)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800405516288812441)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800405017948812441)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(800405277884812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800405689797812441)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800405017948812441)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800405901573812441)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800405017948812441)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800406075115812441)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800405017948812441)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(800405277884812441)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800406756453812441)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(800406481064812441)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800406947823812441)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(800406481064812441)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800407276662812441)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(800407134490812441)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800407719457812444)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(800407512142812444)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800407904101812444)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(800407512142812444)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800408094072812444)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(800407512142812444)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800408306160812444)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(800407134490812441)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800408462964812444)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800408678133812444)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800406163128812441)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(800407512142812444)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800409162082812444)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(800408850437812444)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800409697929812444)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(800409557654812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800410124621812444)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(800409950066812444)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800410511869812444)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(800410357512812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800410873298812444)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(800410682883812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800411278343812444)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(800411062904812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800411735788812444)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(800411486284812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800411934547812444)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(800398268589812438)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800412267489812444)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800409226389812444)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(800412111856812444)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800412944529812444)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800413129178812444)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800413287582812444)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800413514769812444)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800413691275812444)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800413876911812444)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800414067319812444)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(800404129854812441)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800414516602812444)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(800414345856812444)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800414746814812444)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800414926336812444)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800415107351812444)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800415313918812444)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800415482190812447)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(800412580080812444)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800416081530812447)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800416305944812447)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800416486264812447)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800416707424812447)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800416895022812447)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800417097972812447)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800417284602812447)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800417543615812447)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800415607004812447)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800417921825812447)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800418112086812447)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800418346426812447)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800418507360812447)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800418748609812447)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(800396312356812438)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800418909507812447)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800419118752812447)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800419271418812447)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(800417577017812447)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(800415919340812447)
,p_template_types=>'REPORT'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800419865648812449)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800419385551812447)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(800419723621812449)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800420115120812449)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800419385551812447)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(800419723621812449)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800420465193812449)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800419385551812447)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(800420309787812449)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800420685394812449)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800419385551812447)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(800420309787812449)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800420940416812449)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800419385551812447)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(800420309787812449)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800421516253812450)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800421748357812450)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800421947956812450)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800422108512812450)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800422316979812450)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800422503110812450)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800422711555812450)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800422882098812450)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800423092979812450)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(800421004264812449)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800423732954812450)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800423167531812450)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(800423554357812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800423893022812450)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800423167531812450)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(800423554357812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800424148745812450)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800423167531812450)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(800423554357812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800424312774812450)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800423167531812450)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800424542967812450)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800423167531812450)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800424923526812452)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800424577755812450)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800425154607812452)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800424577755812450)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800425314568812452)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800424577755812450)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800425468365812452)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800424577755812450)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800425915600812452)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800426157374812452)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800426283504812452)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800426552039812452)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800426706374812452)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800427090900812452)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800427270131812452)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800427520835812455)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800427746170812455)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800427873402812455)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800428308304812455)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(800428073021812455)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800428498500812455)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(800428073021812455)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800428759321812455)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(800428073021812455)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800428938769812455)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800429067486812455)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(800428073021812455)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800429305139812455)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800425621608812452)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(800428073021812455)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800429664111812455)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800429939136812455)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800430119120812455)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800430284250812455)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800430521856812455)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800430866744812455)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(800430708069812455)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800431137635812455)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(800430708069812455)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800431517763812455)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(800431342969812455)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800431703660812455)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800431884820812455)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800432111958812456)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800432308518812456)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800432742024812456)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800432909706812456)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800433362738812456)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(800433113455812456)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800433516876812456)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(800433113455812456)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800433758628812456)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800433893259812456)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800434135716812456)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800434556923812456)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800434205926812456)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800434721506812456)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800434205926812456)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800434868842812456)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800434205926812456)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800435062926812456)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800434205926812456)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800435546800812456)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435172231812456)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800435914039812456)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800436266380812456)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(800436064310812456)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800436489737812456)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800436726630812456)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(800436064310812456)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800436907361812456)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800437068438812456)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(800436064310812456)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800437348171812456)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800437534803812456)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800437730681812456)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800437893964812456)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800438288170812456)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(800438154040812456)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800438532818812456)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800438910333812456)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(800438741330812456)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800439153965812459)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(800438741330812456)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800439324373812459)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800439542283812459)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800439761712812459)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800439926407812459)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(800436064310812456)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800440120938812459)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(800430708069812455)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800440289375812459)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(800430708069812455)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800440484762812459)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(800438154040812456)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800440735170812459)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800440922962812459)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800441273125812459)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(800438741330812456)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800441481381812459)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(800421335580812450)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800441711653812459)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(800438741330812456)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800441878156812459)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(800431342969812455)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800442162769812459)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800442288672812459)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800442524173812459)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(800441019290812459)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(800431342969812455)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800442893293812459)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800442620754812459)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800443149571812459)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800442620754812459)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800443507764812459)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(800426888699812452)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800443719406812459)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800443942622812459)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800444161535812459)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800444522490812459)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(800444314294812459)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800444762354812459)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(800443166695812459)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(800444314294812459)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800445946892812463)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(800445544494812461)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(800445685347812463)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800446100084812463)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(800445544494812461)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(800445685347812463)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800446509848812463)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800446897435812463)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(800446749941812463)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800447106220812463)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(800445685347812463)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800447359329812464)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(800446749941812463)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800447561032812464)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(800445685347812463)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800449644581812478)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(800449426125812478)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800450013653812480)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(800449805502812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800450261416812480)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(800449426125812478)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800450395237812480)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(800449805502812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800450586000812480)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(800449426125812478)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800450768306812480)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(800449805502812480)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800451007077812480)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(800449426125812478)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800451176348812480)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(800449805502812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800451632300812480)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(800451390887812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452049680812480)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(800451763943812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452164884812480)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(800451390887812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452457043812480)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(800451763943812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452576022812480)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(800451390887812480)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452848836812480)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(800451763943812480)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800452995673812480)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(800451390887812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800453250629812480)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(800451763943812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800453636593812480)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(800453382575812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800454012141812481)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(800453855628812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800454249119812481)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(800453382575812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800454420886812481)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(800453855628812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800454635921812481)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(800453382575812480)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800454848234812481)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(800453855628812480)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800455031225812481)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(800453382575812480)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800455249969812481)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(800453855628812480)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800455653997812481)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(800455411444812481)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800456027354812481)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(800455787696812481)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800456261174812481)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(800455411444812481)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800456408219812481)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(800455787696812481)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800456627841812481)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(800455411444812481)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800456778506812481)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(800455787696812481)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800457051096812481)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(800455411444812481)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800457249433812481)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(800455787696812481)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800457574150812481)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(800457375147812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800458004161812481)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(800457828580812481)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800458409676812481)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(800458221841812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800458774101812484)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(800458572908812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800459247203812484)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(800459025051812484)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800459586337812484)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(800459454958812484)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800460027509812484)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(800459842345812484)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800460168893812484)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(800459842345812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800460438356812484)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(800457828580812481)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800460628437812484)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(800458221841812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800460767356812484)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(800458572908812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800461026408812484)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(800459025051812484)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800461440867812484)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(800461177832812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800461590868812484)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(800461177832812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800461811859812484)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(800461177832812484)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800462023886812484)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(800457375147812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800462189978812484)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(800459842345812484)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800462390252812484)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(800459454958812484)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800462826750812484)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(800462572696812484)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800462971850812484)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(800457375147812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800463189971812484)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(800459454958812484)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800463418848812484)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(800457375147812481)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800463823944812484)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(800463635680812484)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800464256431812484)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(800464026657812484)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800464591980812484)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(800464372240812484)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800465036760812484)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(800464794566812484)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800465246633812484)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(800464794566812484)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800465638398812484)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(800465432560812484)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800465849287812484)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(800464026657812484)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800466204193812484)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(800466012048812484)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800466582676812484)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(800466450095812484)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800466997214812484)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(800466768780812484)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800467409218812486)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(800467228251812484)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800467637592812486)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800467780134812486)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(800466012048812484)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(800468232359812486)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(800467998055812486)
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
prompt --application/shared_components/globalization/translations
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
 p_id=>wwv_flow_api.id(800471924234812513)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications/application_express_accounts
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(800328447879812389)
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
 p_id=>wwv_flow_api.id(43931307690644833305)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.CONDES.PLUGIN.ADC'
,p_display_name=>'APEX Dynamic Controller'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','DE.CONDES.PLUGIN.ADC'),'')
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#adc/js/renderer#MIN#.js',
'#PLUGIN_FILES#adc/js/controller#MIN#.js',
'#PLUGIN_FILES#adc/js/actions#MIN#.js',
''))
,p_css_file_urls=>'#PLUGIN_FILES#adc/css/adc#MIN#.css'
,p_api_version=>1
,p_render_function=>'adc_plugin.render'
,p_ajax_function=>'adc_plugin.ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Plugin APEX Dynamic Controller (ADC)</h2>',
'<p>The plugin simplifies the management of forms on a page.<br/>The following functions are implemented:</p>',
'<ul>',
'  <li>Use cases can be defined that control whether elements are displayed on the page or not</li>',
'  <li>Elements can be declared mandatory fields and checked based on rules</li>',
'  <li>Use cases can call validation or initialization code on the database</li>',
'  <li>Use cases are automatically resolved recursively, thus reducing the number of rules required</li>',
'  <li>If errors occur during initialization, calculation or validation of values, these are dynamically integrated on the page</li>',
'</ul>',
'<p> Use cases are stored within tables in the database. These use cases can be managed by a separate APEX application and can be used across applications.</p>'))
,p_version_identifier=>'1.0'
,p_files_version=>248
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(1442388814068916734)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
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
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722064653D64657C7C7B7D3B66756E6374696F6E2064655F636F6E6465735F706C7567696E5F61646328297B64652E636F6E6465732E706C7567696E2E6164632E696E697428746869732E616374696F6E297D64652E636F6E6465733D64652E636F';
wwv_flow_api.g_varchar2_table(2) := '6E6465737C7C7B7D2C64652E636F6E6465732E706C7567696E3D64652E636F6E6465732E706C7567696E7C7C7B7D2C64652E636F6E6465732E706C7567696E2E6164633D64652E636F6E6465732E706C7567696E2E6164637C7C7B7D2C66756E6374696F';
wwv_flow_api.g_varchar2_table(3) := '6E286164632C242C736572766572297B2275736520737472696374223B636F6E737420435F4348414E47455F4556454E543D226368616E6765222C435F434C49434B5F4556454E543D22636C69636B222C435F44424C434C49434B5F4556454E543D2264';
wwv_flow_api.g_varchar2_table(4) := '626C636C69636B222C435F454E5445525F4556454E543D22656E746572222C435F4B455950524553535F4556454E543D226B65797072657373222C435F415045585F4245464F52455F524546524553483D22617065786265666F72657265667265736822';
wwv_flow_api.g_varchar2_table(5) := '2C435F415045585F41465445525F524546524553483D2261706578616674657272656672657368222C435F415045585F41465445525F434C4F53455F4449414C4F473D22617065786166746572636C6F73656469616C6F67222C435F4E4F5F5452494747';
wwv_flow_api.g_varchar2_table(6) := '4552494E475F4954454D3D22444F43554D454E54222C435F4C4F434B5F4C454E4754483D3230302C435F50524F5445435445445F4556454E54533D5B435F434C49434B5F4556454E542C435F44424C434C49434B5F4556454E542C435F454E5445525F45';
wwv_flow_api.g_varchar2_table(7) := '56454E545D2C435F424F44593D22626F6479222C435F425554544F4E3D22627574746F6E222C435F415045585F425554544F4E3D22742D427574746F6E222C435F494E5055545F53454C4543544F523D223A696E7075743A76697369626C653A6E6F7428';
wwv_flow_api.g_varchar2_table(8) := '627574746F6E29223B6164632E636F6E74726F6C6C65723D7B7D3B7661722063746C3D6164632E636F6E74726F6C6C65722C70726F70733D7B616A61784964656E7469666965723A22222C71756172616E74696E654C6973743A5B5D2C74726967676572';
wwv_flow_api.g_varchar2_table(9) := '696E67456C656D656E743A7B69643A22222C646174613A22222C6576656E743A22222C6973436C69636B3A21317D2C6576656E74446174613A7B616A61784964656E7469666965723A22222C706167654974656D733A22227D2C7061676553746174653A';
wwv_flow_api.g_varchar2_table(10) := '7B6974656D4D61703A6E6577204D61707D2C706167654974656D733A5B5D2C62696E644974656D733A5B5D2C6C6173744974656D56616C7565733A5B5D2C6164646974696F6E616C4974656D733A5B5D2C7374616E646172644D657373616765733A7B7D';
wwv_flow_api.g_varchar2_table(11) := '7D3B636F6E7374206368616E676543616C6C6261636B3D66756E6374696F6E28652C742C6E297B67657454726967676572696E67456C656D656E742865292C2428435F424F4459292E7175657565282866756E6374696F6E28297B6164632E616374696F';
wwv_flow_api.g_varchar2_table(12) := '6E732E73686F77576169745370696E6E6572286E292C63746C2E6578656375746528652C74297D29297D2C656E74657243616C6C6261636B3D66756E6374696F6E28652C742C6E297B67657454726967676572696E67456C656D656E742865292C70726F';
wwv_flow_api.g_varchar2_table(13) := '70732E74726967676572696E67456C656D656E742E6576656E743D3D3D435F454E5445525F4556454E54262628617065782E64656275672E696E666F2860456E7175657565696E67204576656E742027247B435F454E5445525F4556454E547D2760292C';
wwv_flow_api.g_varchar2_table(14) := '242822626F647922292E7175657565282866756E6374696F6E28297B6164632E616374696F6E732E73686F77576169745370696E6E6572286E292C63746C2E657865637574652874297D2929297D2C756E736176656443616C6C6261636B3D66756E6374';
wwv_flow_api.g_varchar2_table(15) := '696F6E28652C74297B67657454726967676572696E67456C656D656E742865292C2428435F424F4459292E7175657565282866756E6374696F6E28297B6164632E616374696F6E732E73686F77576169745370696E6E65722874292C63746C2E68617355';
wwv_flow_api.g_varchar2_table(16) := '6E73617665644368616E67657328293F6164632E72656E64657265722E636F6E6669726D5265717565737428652C6368616E676543616C6C6261636B293A6368616E676543616C6C6261636B2865297D29297D2C62696E644576656E743D66756E637469';
wwv_flow_api.g_varchar2_table(17) := '6F6E28652C742C6E297B76617220692C613B652E736561726368282F5B5C2E235C75303032303A5C5B5C5D5D2B2F293C30262628653D6023247B657D60292C28693D24286529292E6C656E6774683E30262628613D2266756E6374696F6E223D3D747970';
wwv_flow_api.g_varchar2_table(18) := '656F66206E3F6E3A766F69642030213D3D6E26266E2E6C656E6774683E303F6E65772046756E6374696F6E286E293A6368616E676543616C6C6261636B2C692E6F66662874292E6F6E28742C70726F70732E6576656E74446174612C61292C743D3D3D43';
wwv_flow_api.g_varchar2_table(19) := '5F4348414E47455F4556454E542626692E6F6E28435F415045585F4245464F52455F524546524553482C2866756E6374696F6E2874297B242874686973292E6F666628435F4348414E47455F4556454E54292C617065782E64656275672E696E666F2860';
wwv_flow_api.g_varchar2_table(20) := '4576656E742027247B435F4348414E47455F4556454E547D272070617573656420617420247B657D60297D29292E6F6E28435F415045585F41465445525F524546524553482C2866756E6374696F6E2874297B242874686973292E6F6E28435F4348414E';
wwv_flow_api.g_varchar2_table(21) := '47455F4556454E542C70726F70732E6576656E74446174612C61292C617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272072652D65737461626C697368656420617420247B657D60297D2929297D';
wwv_flow_api.g_varchar2_table(22) := '2C62696E644576656E74733D66756E6374696F6E28297B242E656163682870726F70732E62696E644974656D732C2866756E6374696F6E28297B746869732E6576656E743D3D435F454E5445525F4556454E543F62696E644576656E7428746869732E69';
wwv_flow_api.g_varchar2_table(23) := '642C435F4B455950524553535F4556454E542C746869732E616374696F6E7C7C656E74657243616C6C6261636B293A2862696E644576656E7428746869732E69642C746869732E6576656E742C746869732E616374696F6E292C746869732E6576656E74';
wwv_flow_api.g_varchar2_table(24) := '3D3D3D435F4348414E47455F4556454E542626616464506167654974656D28746869732E696429297D29297D2C616464506167654974656D3D66756E6374696F6E2865297B2D313D3D3D242E696E417272617928652C70726F70732E706167654974656D';
wwv_flow_api.g_varchar2_table(25) := '7329262670726F70732E706167654974656D732E707573682865297D2C65786563757465436F64653D66756E6374696F6E2865297B76617220743B652626282428435F424F4459292E617070656E642865292C743D2223222B242865292E617474722822';
wwv_flow_api.g_varchar2_table(26) := '696422292C242874292E72656D6F76652829292C2428435F424F4459292E6465717565756528297D2C67657454726967676572696E67456C656D656E743D66756E6374696F6E2865297B76617220743B69662870726F70732E74726967676572696E6745';
wwv_flow_api.g_varchar2_table(27) := '6C656D656E742E69643D435F4E4F5F54524947474552494E475F4954454D2C70726F70732E74726967676572696E67456C656D656E742E6576656E743D652E747970652C70726F70732E74726967676572696E67456C656D656E742E646174613D652E64';
wwv_flow_api.g_varchar2_table(28) := '6174612C70726F70732E74726967676572696E67456C656D656E742E6973436C69636B3D21312C766F69642030213D3D652E746172676574297B7377697463682870726F70732E74726967676572696E67456C656D656E742E6576656E74297B63617365';
wwv_flow_api.g_varchar2_table(29) := '20435F415045585F41465445525F434C4F53455F4449414C4F473A70726F70732E74726967676572696E67456C656D656E742E69643D652E63757272656E745461726765742E69643B627265616B3B6361736520435F4348414E47455F4556454E543A70';
wwv_flow_api.g_varchar2_table(30) := '726F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E69642C22726164696F22213D3D28743D24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D6029292E617474722822747970652229';
wwv_flow_api.g_varchar2_table(31) := '262622636865636B626F7822213D3D742E6174747228227479706522297C7C2870726F70732E74726967676572696E67456C656D656E742E69643D742E706172656E747328222E726164696F5F67726F75702C2E636865636B626F785F67726F75702229';
wwv_flow_api.g_varchar2_table(32) := '2E61747472282269642229292C70726F70732E74726967676572696E67456C656D656E742E6964262670726F70732E74726967676572696E67456C656D656E742E69642E6D61746368282F6F6A2E2A2F2926262870726F70732E74726967676572696E67';
wwv_flow_api.g_varchar2_table(33) := '456C656D656E742E69643D24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E636C6F7365737428226469762E617065782D6974656D2D67726F757022292E61747472282269642229293B627265616B3B63617365';
wwv_flow_api.g_varchar2_table(34) := '20435F434C49434B5F4556454E543A70726F70732E74726967676572696E67456C656D656E742E6973436C69636B3D21302C70726F70732E74726967676572696E67456C656D656E742E69643D2222213D3D652E7461726765742E69643F652E74617267';
wwv_flow_api.g_varchar2_table(35) := '65742E69643A652E63757272656E745461726765742E69642C22223D3D3D70726F70732E74726967676572696E67456C656D656E742E696426262870726F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E706172656E';
wwv_flow_api.g_varchar2_table(36) := '74456C656D656E742E6964292C24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E686173436C61737328435F415045585F425554544F4E297C7C24286023247B70726F70732E74726967676572696E67456C656D';
wwv_flow_api.g_varchar2_table(37) := '656E742E69647D60292E706172656E7428435F425554544F4E293B627265616B3B6361736520435F4B455950524553535F4556454E543A7377697463682870726F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E6964';
wwv_flow_api.g_varchar2_table(38) := '2C652E6B6579436F6465297B636173652031333A70726F70732E74726967676572696E67456C656D656E742E6576656E743D435F454E5445525F4556454E543B627265616B7D627265616B3B64656661756C743A70726F70732E74726967676572696E67';
wwv_flow_api.g_varchar2_table(39) := '456C656D656E742E69643D652E7461726765742E69647D617065782E64656275672E696E666F28604576656E742027247B70726F70732E74726967676572696E67456C656D656E742E6576656E747D27207261697365642061742054726967676572696E';
wwv_flow_api.g_varchar2_table(40) := '6720656C656D656E742027247B70726F70732E74726967676572696E67456C656D656E742E69647D2760297D7D2C686578546F436861723D66756E6374696F6E2865297B76617220742C6E3D22223B69662865297B743D652E746F537472696E6728293B';
wwv_flow_api.g_varchar2_table(41) := '666F72286C657420653D303B653C742E6C656E6774683B652B3D32296E2B3D537472696E672E66726F6D43686172436F6465287061727365496E7428742E73756273747228652C32292C313629297D72657475726E206E7D2C6D61696E7461696E416E64';
wwv_flow_api.g_varchar2_table(42) := '436865636B4576656E744C6F636B3D66756E6374696F6E28297B76617220653D21302C743D70726F70732E74726967676572696E67456C656D656E743B72657475726E20435F50524F5445435445445F4556454E54532E696E6465784F6628742E657665';
wwv_flow_api.g_varchar2_table(43) := '6E74293E2D313F70726F70732E71756172616E74696E654C6973742E696E6465784F6628742E6576656E74293E2D313F28617065782E64656275672E696E666F286049676E6F72696E67204576656E742027247B742E6576656E747D272C206F6E207175';
wwv_flow_api.g_varchar2_table(44) := '6172616E74696E65206C69737460292C653D2131293A28617065782E64656275672E696E666F2822436C656172206576656E74207175657565206166746572206C6F636B696E6720616E206576656E7422292C242822626F647922292E636C6561725175';
wwv_flow_api.g_varchar2_table(45) := '65756528292C70726F70732E71756172616E74696E654C6973742E7075736828742E6576656E74292C617065782E64656275672E696E666F28604576656E742027247B742E6576656E747D2720707573686564206F6E2071756172616E74696E6560292C';
wwv_flow_api.g_varchar2_table(46) := '73657454696D656F7574282866756E6374696F6E28297B70726F70732E71756172616E74696E654C6973743D5B5D2C617065782E64656275672E696E666F28604576656E742027247B742E6576656E747D2720706F707065642066726F6D207175617261';
wwv_flow_api.g_varchar2_table(47) := '6E74696E6560297D292C435F4C4F434B5F4C454E475448292C742E6973436C69636B262628617065782E64656275672E696E666F28604C6F636B696E6720627574746F6E2027247B742E69647D2760292C617065782E6974656D28742E6964292E646973';
wwv_flow_api.g_varchar2_table(48) := '61626C65282929293A435F50524F5445435445445F4556454E54532E696E6465784F662870726F70732E71756172616E74696E654C6973745B305D293E2D31262628617065782E64656275672E696E666F286049676E6F72696E67206576656E74202724';
wwv_flow_api.g_varchar2_table(49) := '7B742E6576656E747D272C206576656E742027247B70726F70732E71756172616E74696E654C6973745B305D7D27206973206F6E2071756172616E74696E65206C69737460292C653D2131292C657D2C616464427574746F6E48616E646C65723D66756E';
wwv_flow_api.g_varchar2_table(50) := '6374696F6E28652C742C6E2C69297B6C657420613B613D242E5F6461746128652E6765742830292C226576656E747322292C766F69642030213D3D612626615B435F434C49434B5F4556454E545D2626652E6F666628435F434C49434B5F4556454E5429';
wwv_flow_api.g_varchar2_table(51) := '2C652E6F6E28435F434C49434B5F4556454E542C7B616A61784964656E7469666965723A70726F70732E616A61784964656E7469666965722C6D6573736167653A742C2270726F70732E706167654974656D73223A70726F70732E706167654974656D73';
wwv_flow_api.g_varchar2_table(52) := '2C7469746C653A6E7D2C69297D3B63746C2E62696E644F627365727665724974656D733D66756E6374696F6E2865297B76617220743B65262628743D652E73706C697428222C22292C242E6561636828742C2866756E6374696F6E28652C74297B222E22';
wwv_flow_api.g_varchar2_table(53) := '3D3D3D746869732E737562737472696E6728302C31293F242874292E65616368282866756E6374696F6E28652C74297B616464506167654974656D28242874292E61747472282269642229297D29293A2D313D3D3D242E696E417272617928742C70726F';
wwv_flow_api.g_varchar2_table(54) := '70732E706167654974656D7329262670726F70732E706167654974656D732E707573682874297D29292C617065782E64656275672E696E666F28604164646974696F6E616C2070616765206974656D733A20247B657D6029297D2C63746C2E62696E6443';
wwv_flow_api.g_varchar2_table(55) := '6F6E6669726D6174696F6E48616E646C65723D66756E6374696F6E28652C742C6E2C69297B6C657420612C723B613D693F66756E6374696F6E28297B617065782E616374696F6E732E696E766F6B652869297D3A6368616E676543616C6C6261636B2C72';
wwv_flow_api.g_varchar2_table(56) := '3D66756E6374696F6E2874297B6164632E72656E64657265722E636F6E6669726D5265717565737428742C612C652E61747472282269642229297D2C616464427574746F6E48616E646C657228652C742C6E2C72297D2C63746C2E62696E64556E736176';
wwv_flow_api.g_varchar2_table(57) := '6564436F6E6669726D6174696F6E48616E646C65723D66756E6374696F6E28652C742C6E297B616464427574746F6E48616E646C657228652C742C6E2C756E736176656443616C6C6261636B297D2C63746C2E66696E644974656D56616C75653D66756E';
wwv_flow_api.g_varchar2_table(58) := '6374696F6E2865297B76617220743D242E677265702870726F70732E6C6173744974656D56616C7565732C2866756E6374696F6E2874297B72657475726E20742E69643D3D3D657D29293B696628742E6C656E6774683E302972657475726E20745B305D';
wwv_flow_api.g_varchar2_table(59) := '2E76616C75657D2C63746C2E6765745061676553746174653D66756E6374696F6E28297B72657475726E2070726F70732E7061676553746174657D2C63746C2E7365745061676553746174653D66756E6374696F6E2865297B70726F70732E7061676553';
wwv_flow_api.g_varchar2_table(60) := '746174653D657D2C63746C2E70757368506167654974656D3D66756E6374696F6E2865297B2D313D3D3D242E696E417272617928652C70726F70732E706167654974656D732926262870726F70732E706167654974656D732E707573682865292C62696E';
wwv_flow_api.g_varchar2_table(61) := '644576656E7428652C435F4348414E47455F4556454E5429297D2C63746C2E686173556E73617665644368616E6765733D66756E6374696F6E2865297B76617220742C6E3D21313B72657475726E20743D41727261792E697341727261792865293F653A';
wwv_flow_api.g_varchar2_table(62) := '2428435F494E5055545F53454C4543544F52292C242E6561636828742C2866756E6374696F6E2865297B69662828653D745B655D292E6964262628653D652E6964292C617065782E64656275672E696E666F2860436F6D706172696E6720247B657D6029';
wwv_flow_api.g_varchar2_table(63) := '2C70726F70732E7061676553746174652E6974656D4D61702E686173286529262670726F70732E7061676553746174652E6974656D4D61702E676574286529213D617065782E6974656D2865292E67657456616C756528292972657475726E206E3D2130';
wwv_flow_api.g_varchar2_table(64) := '2C21317D29292C6E7D2C63746C2E70617573654368616E67654576656E74447572696E67526566726573683D66756E6374696F6E28652C74297B766172206E2C692C613D24286023247B657D60292C723D612E6765742830293B612E6C656E6774683E30';
wwv_flow_api.g_varchar2_table(65) := '2626286E3D242E5F6461746128722C226576656E747322292C64656C65746528693D242E657874656E642821302C5B5D2C6E29292E6368616E67652C242E5F6461746128722C226576656E7473222C69292C612E6F6E6528435F415045585F4146544552';
wwv_flow_api.g_varchar2_table(66) := '5F524546524553482C2866756E6374696F6E2869297B76617220613D63746C2E67657450616765537461746528293B74262628617065782E6974656D2865292E73657456616C756528742C742C2130292C612E6974656D4D61702E686173286529262628';
wwv_flow_api.g_varchar2_table(67) := '612E6974656D4D61702E73657428652C74292C63746C2E73657450616765537461746528612929292C242E5F6461746128722C226576656E7473222C6E297D2929297D2C63746C2E7365744164646974696F6E616C4974656D733D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(68) := '65297B70726F70732E6164646974696F6E616C4974656D733D657D2C63746C2E73657454726967676572696E67456C656D656E743D66756E6374696F6E28652C742C6E2C69297B70726F70732E74726967676572696E67456C656D656E742E69643D652C';
wwv_flow_api.g_varchar2_table(69) := '70726F70732E74726967676572696E67456C656D656E742E6576656E743D742C70726F70732E74726967676572696E67456C656D656E742E646174613D6E2C70726F70732E74726967676572696E67456C656D656E742E6973436C69636B3D697C7C2131';
wwv_flow_api.g_varchar2_table(70) := '7D2C63746C2E7365744C6173744974656D56616C7565733D66756E6374696F6E2865297B70726F70732E6C6173744974656D56616C7565733D657D2C63746C2E6765745374616E646172644D6573736167653D66756E6374696F6E2865297B7265747572';
wwv_flow_api.g_varchar2_table(71) := '6E2070726F70732E7374616E646172644D657373616765735B655D7D2C63746C2E657865637574653D66756E6374696F6E28297B6D61696E7461696E416E64436865636B4576656E744C6F636B282926262870726F70732E74726967676572696E67456C';
wwv_flow_api.g_varchar2_table(72) := '656D656E742E64617461262670726F70732E74726967676572696E67456C656D656E742E646174612E6164646974696F6E616C506167654974656D7326262870726F70732E706167654974656D733D6E657720536574285B2E2E2E70726F70732E706167';
wwv_flow_api.g_varchar2_table(73) := '654974656D732C2E2E2E70726F70732E74726967676572696E67456C656D656E742E646174612E6164646974696F6E616C506167654974656D735D292C70726F70732E706167654974656D733D41727261792E66726F6D2870726F70732E706167654974';
wwv_flow_api.g_varchar2_table(74) := '656D7329292C617065782E64656275672E696E666F28604144432068616E646C6573206576656E7420247B70726F70732E74726967676572696E67456C656D656E742E6576656E747D60292C617065782E64656275672E696E666F28604144432073656E';
wwv_flow_api.g_varchar2_table(75) := '647320706167654974656D7320247B70726F70732E706167654974656D732E6A6F696E28297D60292C7365727665722E706C7567696E2870726F70732E616A61784964656E7469666965722C7B7830313A70726F70732E74726967676572696E67456C65';
wwv_flow_api.g_varchar2_table(76) := '6D656E742E69642C7830323A70726F70732E74726967676572696E67456C656D656E742E6576656E742C7830333A4A534F4E2E737472696E676966792870726F70732E74726967676572696E67456C656D656E742E64617461292C706167654974656D73';
wwv_flow_api.g_varchar2_table(77) := '3A70726F70732E706167654974656D737D2C7B64617461547970653A2268746D6C222C737563636573733A66756E6374696F6E2865297B70726F70732E74726967676572696E67456C656D656E742E6973436C69636B2626617065782E6974656D287072';
wwv_flow_api.g_varchar2_table(78) := '6F70732E74726967676572696E67456C656D656E742E6964292E656E61626C6528292C65786563757465436F64652865297D7D292C70726F70732E6164646974696F6E616C4974656D733D5B5D297D2C6164632E696E69743D66756E6374696F6E287041';
wwv_flow_api.g_varchar2_table(79) := '6374696F6E297B70726F70732E62696E644974656D733D242E70617273654A534F4E2870416374696F6E2E61747472696275746530312E7265706C616365282F7E2F672C27222729292C6164632E72656E64657265723D6576616C2870416374696F6E2E';
wwv_flow_api.g_varchar2_table(80) := '6174747269627574653033292C70726F70732E616A61784964656E7469666965723D70416374696F6E2E616A61784964656E7469666965722C70726F70732E6576656E74446174612E616A61784964656E7469666965723D70726F70732E616A61784964';
wwv_flow_api.g_varchar2_table(81) := '656E7469666965722C70726F70732E6576656E74446174612E706167654974656D733D70726F70732E706167654974656D732C70416374696F6E2E6174747269627574653032262628617065782E64656275672E696E666F282252657175697265642070';
wwv_flow_api.g_varchar2_table(82) := '6167654974656D733A20222B70416374696F6E2E6174747269627574653032292C70726F70732E706167654974656D733D70416374696F6E2E61747472696275746530322E73706C697428222C2229292C70416374696F6E2E6174747269627574653036';
wwv_flow_api.g_varchar2_table(83) := '26262870726F70732E7374616E646172644D657373616765733D4A534F4E2E70617273652870416374696F6E2E617474726962757465303629292C63746C2E62696E644F627365727665724974656D732870416374696F6E2E6174747269627574653035';
wwv_flow_api.g_varchar2_table(84) := '292C62696E644576656E747328292C617065782E64656275672E696E666F282241444320696E697469616C697A656422292C65786563757465436F646528686578546F436861722870416374696F6E2E617474726962757465303429297D7D2864652E63';
wwv_flow_api.g_varchar2_table(85) := '6F6E6465732E706C7567696E2E6164632C617065782E6A51756572792C617065782E736572766572293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(131335319979519014)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/controller-min.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '0D0A3A726F6F747B0D0A20202D2D612D666F726D2D7761726E696E672D746578742D636F6C6F723A234642434534413B0D0A7D0D0A0D0A2E6164632D6572726F72207B0D0A2020636F6C6F723A7265643B0D0A7D0D0A0D0A2E6164632D6F6E2D6572726F';
wwv_flow_api.g_varchar2_table(2) := '72207B0D0A2020636F6C6F723A626C75653B0D0A7D0D0A0D0A2E6164632D64697361626C65647B0D0A2020636F6C6F723A677265793B0D0A7D0D0A0D0A2E6164632D646570726563617465647B0D0A2020636F6C6F723A677265656E3B0D0A7D0D0A0D0A';
wwv_flow_api.g_varchar2_table(3) := '2E6164632D64747B0D0A2020626F726465722D746F703A6772657920736F6C6964207468696E3B0D0A2020666F6E742D7765696768743A626F6C643B0D0A2020666F6E742D73697A653A312E32656D3B0D0A202070616464696E672D746F703A20337078';
wwv_flow_api.g_varchar2_table(4) := '3B0D0A202070616464696E672D626F74746F6D3A203370783B0D0A20206D617267696E2D746F703A313870783B0D0A7D0D0A0D0A2E6164632D6361726F7573656C2D6861734572726F727B0D0A20206261636B67726F756E643A72676261283235352C20';
wwv_flow_api.g_varchar2_table(5) := '302C20302C20302E33290D0A7D0D0A0D0A2E742D427574746F6E2E6164632D726567696F6E2D626F74746F6D2D627574746F6E7B0D0A20206D617267696E2D72696768743A313470783B0D0A20206D617267696E2D626F74746F6D3A3870783B0D0A7D0D';
wwv_flow_api.g_varchar2_table(6) := '0A0D0A2E617065782D6974656D2D746578742E617065782D706167652D6974656D2D7761726E696E672C202E617065782D6974656D2D73656C6563742E617065782D706167652D6974656D2D7761726E696E672C202E617065782D6974656D2D74657874';
wwv_flow_api.g_varchar2_table(7) := '617265612E617065782D706167652D6974656D2D7761726E696E672C202E752D54462D6974656D2D2D746578742E617065782D706167652D6974656D2D7761726E696E672C200D0A2E752D54462D6974656D2D2D73656C6563742E617065782D70616765';
wwv_flow_api.g_varchar2_table(8) := '2D6974656D2D7761726E696E672C2073656C6563742E6C6973746D616E616765722E617065782D706167652D6974656D2D7761726E696E672C2073656C6563742E67726F75705F73656C6563746C6973742E617065782D706167652D6974656D2D776172';
wwv_flow_api.g_varchar2_table(9) := '6E696E672C202E617065782D6974656D2D6D756C74692E617065782D706167652D6974656D2D7761726E696E672C200D0A2E6461746574696D657069636B65725F6E65774D6F6E74682E617065782D706167652D6974656D2D7761726E696E67207B0D0A';
wwv_flow_api.g_varchar2_table(10) := '20202020626F726465722D636F6C6F723A20766172282D2D612D666F726D2D7761726E696E672D746578742D636F6C6F72293B0D0A7D0D0A0D0A2E742D466F726D2D7761726E696E677B0D0A20202020636F6C6F723A20626C61636B3B0D0A7D0D0A0D0A';
wwv_flow_api.g_varchar2_table(11) := '2E742D466F726D2D7761726E696E673A6265666F72657B0D0A2020636F6E74656E743A20225C66303731223B0D0A2020666F6E742D66616D696C793A2027466F6E74204150455820536D616C6C2721696D706F7274616E743B0D0A2020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(12) := '766172282D2D612D666F726D2D7761726E696E672D746578742D636F6C6F72293B0D0A2020666C6F61743A6C6566743B0D0A20206D617267696E2D72696768743A302E3472656D3B0D0A7D0D0A0D0A2E742D466F726D2D6572726F72206469767B0D0A20';
wwv_flow_api.g_varchar2_table(13) := '202020636F6C6F723A20626C61636B3B0D0A7D0D0A0D0A2E742D466F726D2D6572726F723A6265666F72657B0D0A2020636F6E74656E743A20225C66303537223B0D0A2020666F6E742D66616D696C793A2027466F6E74204150455820536D616C6C2721';
wwv_flow_api.g_varchar2_table(14) := '696D706F7274616E743B0D0A2020636F6C6F723A20766172282D2D612D666F726D2D6572726F722D746578742D636F6C6F72293B0D0A2020666C6F61743A6C6566743B0D0A20206D617267696E2D72696768743A302E3472656D3B0D0A7D0D0A0D0A2E61';
wwv_flow_api.g_varchar2_table(15) := '2D47562D6865616465727B0D0A20202020766572746963616C2D616C69676E3A20746F702021696D706F7274616E743B0D0A7D0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740439567835785496)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/css/adc.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3A726F6F747B2D2D612D666F726D2D7761726E696E672D746578742D636F6C6F723A234642434534417D2E6164632D6572726F727B636F6C6F723A7265647D2E6164632D6F6E2D6572726F727B636F6C6F723A233030667D2E6164632D64697361626C65';
wwv_flow_api.g_varchar2_table(2) := '647B636F6C6F723A677261797D2E6164632D646570726563617465647B636F6C6F723A677265656E7D2E6164632D64747B626F726465722D746F703A6772617920736F6C6964207468696E3B666F6E742D7765696768743A3730303B666F6E742D73697A';
wwv_flow_api.g_varchar2_table(3) := '653A312E32656D3B70616464696E672D746F703A3370783B70616464696E672D626F74746F6D3A3370783B6D617267696E2D746F703A313870787D2E6164632D6361726F7573656C2D6861734572726F727B6261636B67726F756E643A72676261283235';
wwv_flow_api.g_varchar2_table(4) := '352C302C302C2E33297D2E742D427574746F6E2E6164632D726567696F6E2D626F74746F6D2D627574746F6E7B6D617267696E2D72696768743A313470783B6D617267696E2D626F74746F6D3A3870787D2E617065782D6974656D2D6D756C74692E6170';
wwv_flow_api.g_varchar2_table(5) := '65782D706167652D6974656D2D7761726E696E672C2E617065782D6974656D2D73656C6563742E617065782D706167652D6974656D2D7761726E696E672C2E617065782D6974656D2D746578742E617065782D706167652D6974656D2D7761726E696E67';
wwv_flow_api.g_varchar2_table(6) := '2C2E617065782D6974656D2D74657874617265612E617065782D706167652D6974656D2D7761726E696E672C2E6461746574696D657069636B65725F6E65774D6F6E74682E617065782D706167652D6974656D2D7761726E696E672C2E752D54462D6974';
wwv_flow_api.g_varchar2_table(7) := '656D2D2D73656C6563742E617065782D706167652D6974656D2D7761726E696E672C2E752D54462D6974656D2D2D746578742E617065782D706167652D6974656D2D7761726E696E672C73656C6563742E67726F75705F73656C6563746C6973742E6170';
wwv_flow_api.g_varchar2_table(8) := '65782D706167652D6974656D2D7761726E696E672C73656C6563742E6C6973746D616E616765722E617065782D706167652D6974656D2D7761726E696E677B626F726465722D636F6C6F723A766172282D2D612D666F726D2D7761726E696E672D746578';
wwv_flow_api.g_varchar2_table(9) := '742D636F6C6F72297D2E742D466F726D2D6572726F72206469762C2E742D466F726D2D7761726E696E677B636F6C6F723A233030307D2E742D466F726D2D6572726F723A6265666F72652C2E742D466F726D2D7761726E696E673A6265666F72657B636F';
wwv_flow_api.g_varchar2_table(10) := '6E74656E743A22EF81B1223B666F6E742D66616D696C793A22466F6E74204150455820536D616C6C2221696D706F7274616E743B636F6C6F723A766172282D2D612D666F726D2D7761726E696E672D746578742D636F6C6F72293B666C6F61743A6C6566';
wwv_flow_api.g_varchar2_table(11) := '743B6D617267696E2D72696768743A2E3472656D7D2E742D466F726D2D6572726F723A6265666F72657B636F6E74656E743A22EF8197223B636F6C6F723A766172282D2D612D666F726D2D6572726F722D746578742D636F6C6F72297D2E612D47562D68';
wwv_flow_api.g_varchar2_table(12) := '65616465727B766572746963616C2D616C69676E3A746F7021696D706F7274616E747D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740439822283785496)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/css/adc.min.css'
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
wwv_flow_api.g_varchar2_table(3) := '636520352E310D0A202A20406465736372697074696F6E0D0A2020203C703E546869732066696C6520696D706C656D656E74732074686520636C69656E742D7369646520636F6D706F6E656E74206F6620415045582044796E616D6963206164632E636F';
wwv_flow_api.g_varchar2_table(4) := '6E74726F6C6C65722E3C62723E0D0A20202020497473207461736B20697320746F0D0A2020202020203C756C3E0D0A20202020202020203C6C693E63726561746520746865206E6563657373617279206576656E742068616E646C657273207768656E20';
wwv_flow_api.g_varchar2_table(5) := '74686520706167652069732072656E64657265643E6C693E0D0A20202020202020203C6C693E636F6C6C656374207468652072656C6576616E7420646174612066726F6D207468652070616765207768656E20616E206576656E74206F63637572732061';
wwv_flow_api.g_varchar2_table(6) := '6E642073656E6420697420746F20746865207365727665723E6C693E0D0A20202020202020203C6C693E696D706C656D656E74207468652072657475726E656420726573706F6E7365207769746820696E737472756374696F6E7320746F206D6F646966';
wwv_flow_api.g_varchar2_table(7) := '7920746865206170706C69636174696F6E20706167652E3E6C693E0D0A2020202020203E756C3E0D0A202020203E703E0D0A202020203C703E546865206164632E636F6E74726F6C6C657220776F726B73206F6E20746865207365727665722073696465';
wwv_flow_api.g_varchar2_table(8) := '20776974682061206465636973696F6E2074726565207468617420636F6D70757465732061206C697374206F6620616374696F6E20696E737472756374696F6E7320666F72206120676976656E20736974756174696F6E2E3C62723E0D0A202020204475';
wwv_flow_api.g_varchar2_table(9) := '72696E67207468652063616C63756C6174696F6E2C20746865207374617465206F6620746865206170706C69636174696F6E20706167652063616E206265206368616E67656420627920616374696F6E732C207768696368206C6561647320746F206120';
wwv_flow_api.g_varchar2_table(10) := '72656375727369766520636865636B206F6620746865206368616E676564200D0A202020207061676520737461746520616761696E737420746865206465636973696F6E20747265652E2054686520726573706F6E736520696E636C7564657320616C6C';
wwv_flow_api.g_varchar2_table(11) := '206368616E676520696E737472756374696F6E7320666F7220746865206170706C69636174696F6E20706167652C200D0A20202020696E636C7564696E672074686520726563757273697665206368616E676520696E737472756374696F6E732E3E703E';
wwv_flow_api.g_varchar2_table(12) := '0D0A202020203C703E5468652041444320726573706F6E73652069732064656C69766572656420696E2074686520666F726D206F66206120736372697074207769746820616E20494420616E6420696E736572746564206F6E2074686520706167652062';
wwv_flow_api.g_varchar2_table(13) := '79207468697320636F6D706F6E656E742E200D0A20202020546875732C20616C6C20696E636C7564656420616374696F6E7320617265206578656375746564206469726563746C792E20416674657277617264732C2074686520706C7567696E2072656D';
wwv_flow_api.g_varchar2_table(14) := '6F7665732074686520736572766572277320726573706F6E73652C206173206974206973206E6F206C6F6E676572206E65656465642E3E703E0D0A202020203C703E4368616E676520696E737472756374696F6E7320746F206170706C69636174696F6E';
wwv_flow_api.g_varchar2_table(15) := '207061676520706172746C7920646570656E64206F6E20415045582076657273696F6E207573656420616E6420657370656369616C6C79206F6E207468656D6520757365642E200D0A2020202054686520706C7567696E207374617274732066726F6D20';
wwv_flow_api.g_varchar2_table(16) := '5468656D652034322C20686F77657665722C20616C6C207468656D652D737065636966696320696D706C656D656E746174696F6E73206F66207468652061637469766974696573206172652073776170706564206F757420696E746F2061207365706172';
wwv_flow_api.g_varchar2_table(17) := '6174652066696C652C200D0A202020207768696368206973206C696E6B65642061732061206E616D657370616365206F626A656374207768656E20706172616D65746572697A696E672074686520706C7567696E206173206120636F6D706F6E656E7420';
wwv_flow_api.g_varchar2_table(18) := '706172616D657465722E200D0A202020204173207065722064656661756C742C2074686973206973203C64652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F323E2C20696D706C656D656E74656E7420696E2066696C65203C';
wwv_flow_api.g_varchar2_table(19) := '72656E64657265722E6A733E2C206275742069742063616E20626520656173696C79207265706C61636564206279206120636C69656E7420737065636966696320696D706C656D656E746174696F6E2E3E703E0D0A202020203C703E546F20776F726B2C';
wwv_flow_api.g_varchar2_table(20) := '207468697320706C7567696E206D757374206F6E6C792062652063616C6C656420647572696E672070616765206C6F61642C206E6F2061646D696E697374726174696F6E206F7220706172616D65746572697A6174696F6E206973207265717569726564';
wwv_flow_api.g_varchar2_table(21) := '2E3E703E0D0A2020202A2F0D0A2866756E6374696F6E20286164632C202429207B0D0A20202775736520737472696374273B0D0A0D0A20202F2A2A0D0A2020202047726F75703A20436F6E7374616E74730D0A2020202A2F0D0A2020636F6E737420435F';
wwv_flow_api.g_varchar2_table(22) := '424F4459203D2027626F6479273B0D0A2020636F6E737420435F494E5055545F53454C4543544F52203D20273A696E7075743A76697369626C653A6E6F7428627574746F6E29273B0D0A2020636F6E737420435F444F43554D454E54203D2027444F4355';
wwv_flow_api.g_varchar2_table(23) := '4D454E54273B0D0A2020636F6E737420435F44415445495F4E414D45203D202764652E636F6E6465732E706C7567696E2E6164632E616374696F6E732E6A73273B0D0A0D0A20202F2F20526567696F6E205479706520636F6E7374616E74730D0A202063';
wwv_flow_api.g_varchar2_table(24) := '6F6E737420435F524547494F4E5F4352203D2027436C61737369635265706F7274273B0D0A2020636F6E737420435F524547494F4E5F4952203D2027496E7465726163746976655265706F7274273B0D0A2020636F6E737420435F524547494F4E5F4947';
wwv_flow_api.g_varchar2_table(25) := '203D2027496E74657261637469766547726964273B0D0A2020636F6E737420435F524547494F4E5F54524545203D202754726565273B0D0A2020636F6E737420435F524547494F4E5F544142203D2027546162273B0D0A2020636F6E737420435F524547';
wwv_flow_api.g_varchar2_table(26) := '494F4E5F444154415F4954454D203D2027646174612D6974656D2D666F722D726567696F6E273B0D0A20200D0A20202F2F2053656C6563746F7220636F6E7374616E74730D0A2020636F6E737420435F524547494F4E5F43525F53454C4543544F52203D';
wwv_flow_api.g_varchar2_table(27) := '20272E742D5265706F72742D7265706F72742074626F6479207472273B0D0A2020636F6E737420435F524547494F4E5F49525F53454C4543544F52203D20272E612D4952522D7461626C652074723A6E6F74283A66697273742D6368696C6429273B0D0A';
wwv_flow_api.g_varchar2_table(28) := '2020636F6E737420435F524547494F4E5F49525F524F575F53454C4543544F52203D20272E742D6668742D74626F6479202E612D4952522D7461626C65207472273B0D0A2020636F6E737420435F524547494F4E5F49525F46495253545F524F575F5345';
wwv_flow_api.g_varchar2_table(29) := '4C4543544F52203D2060247B435F524547494F4E5F49525F524F575F53454C4543544F527D3A6E74682D6368696C64283229603B0D0A20200D0A20202F2F20436F6D6D616E6420636F6E7374616E74730D0A2020636F6E737420435F434F4D4D414E4420';
wwv_flow_api.g_varchar2_table(30) := '3D2027434F4D4D414E44273B0D0A2020636F6E737420435F434F4D4D414E445F4E414D45203D2027636F6D6D616E64273B0D0A20200D0A20202F2F204576656E7420636F6E7374616E74730D0A2020636F6E737420435F434C49434B5F4556454E54203D';
wwv_flow_api.g_varchar2_table(31) := '2027636C69636B273B0D0A2020636F6E737420435F4B4559444F574E5F4556454E54203D20276B6579646F776E273B0D0A2020636F6E737420435F53454C454354494F4E5F4348414E47455F4556454E54203D202761646373656C656374696F6E636861';
wwv_flow_api.g_varchar2_table(32) := '6E6765273B0D0A2020636F6E737420435F49475F53454C454354494F4E5F4348414E4745203D2027696E7465726163746976656772696473656C656374696F6E6368616E6765273B0D0A2020636F6E737420435F545245455F53454C454354494F4E5F43';
wwv_flow_api.g_varchar2_table(33) := '48414E4745203D2027747265657669657773656C656374696F6E6368616E6765273B0D0A2020636F6E737420435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368273B0D0A2020636F6E737420435F4D4F';
wwv_flow_api.g_varchar2_table(34) := '44414C5F4449414C4F475F43414E43454C5F4556454E54203D202761706578616674657263616E63656C6469616C6F67273B0D0A2020636F6E737420435F4D4F44414C5F4449414C4F475F434C4F53455F4556454E54203D202761706578616674657263';
wwv_flow_api.g_varchar2_table(35) := '6C6F73656469616C6F67273B0D0A20200D0A2020636F6E737420435F5441424B4559203D20393B0D0A0D0A20202F2F204D6F64616C206469616C6F6720636F6E7374616E74730D0A2020636F6E737420435F4D4F44414C5F4449414C4F475F434C415353';
wwv_flow_api.g_varchar2_table(36) := '203D202775692D6469616C6F67273B0D0A2020636F6E737420435F4D4F44414C5F4449414C4F475F53454C4543544F52203D20272E75692D6469616C6F672D636F6E74656E74273B0D0A0D0A20202F2F20476C6F62616C20766172730D0A20206164632E';
wwv_flow_api.g_varchar2_table(37) := '616374696F6E73203D206164632E616374696F6E73207C7C207B7D3B0D0A202076617220616374696F6E73203D206164632E616374696F6E733B0D0A202076617220674572726F7273203D205B5D3B202F2F20496E746572696D20736F6C7574696F6E20';
wwv_flow_api.g_varchar2_table(38) := '726571756972656420756E74696C203C636F64653E617065782E6D6573736167653C2F636F64653E20737570706F7274732072656D6F76696E6720612073696E676C65206572726F720D0A202076617220675761726E696E6773203D205B5D3B202F2F20';
wwv_flow_api.g_varchar2_table(39) := '496E746572696D20736F6C7574696F6E20726571756972656420756E74696C203C636F64653E617065782E6D6573736167653C2F636F64653E20737570706F727473206D6F7265206572726F72207374796C65730D0A0D0A20202F2A2B2B2B2B2B2B2B2B';
wwv_flow_api.g_varchar2_table(40) := '2048454C504552205354415254202B2B2B2B2B2B2B2B2B2B2B2B2A2F0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20666F72456163680D0A20202020202048656C70657220746F206964656E746966792070616765206974656D7320746F2061';
wwv_flow_api.g_varchar2_table(41) := '70706C79203C70416374696F6E3E20746F0D0A2020202020200D0A20202020506172616D65746572733A200D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F7220746F206964656E746966792070616765206974656D';
wwv_flow_api.g_varchar2_table(42) := '730D0A20202020202070416374696F6E202D20416374696F6E20746F2065786563757465206F6E2074686520666F756E642070616765206974656D730D0A2020202A2F0D0A2020636F6E737420666F7245616368203D2066756E6374696F6E2028705365';
wwv_flow_api.g_varchar2_table(43) := '6C6563746F722C2070416374696F6E29207B0D0A20202020696620282128242E69734172726179287053656C6563746F7229207C7C207053656C6563746F722E736561726368282F5B5C2E235C75303032303A5C5B5C5D5D2B2F29203E3D20302929207B';
wwv_flow_api.g_varchar2_table(44) := '0D0A2020202020202F2F20706173736564204954454D20697320656C656D656E74206E616D652C20657874656E6420627920232E0D0A2020202020207053656C6563746F72203D206023247B7053656C6563746F727D603B0D0A202020207D0D0A0D0A20';
wwv_flow_api.g_varchar2_table(45) := '202020696620287053656C6563746F722E6D61746368282F6F6A2E2A2F29297B0D0A2020202020202F2F206974656D206973204F7261636C65204A6574206974656D2067726F75702C2074726176657273652075700D0A2020202020207053656C656374';
wwv_flow_api.g_varchar2_table(46) := '6F72203D2024286023247B7053656C6563746F727D60292E636C6F7365737428276469762E617065782D6974656D2D67726F757027292E617474722827696427293B0D0A202020207D0D0A2020202024287053656C6563746F72292E6561636828704163';
wwv_flow_api.g_varchar2_table(47) := '74696F6E293B0D0A20207D3B202F2F20666F72456163680D0A0D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A20676574526567696F6E547970650D0A2020202020204D6574686F6420746F2064657465726D696E6520746865207479';
wwv_flow_api.g_varchar2_table(48) := '7065206120726567696F6E206861730D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070526567696F6E4964202D20496420746F206964656E746966792074686520726567696F6E2E0D0A2020202020200D0A2020202052';
wwv_flow_api.g_varchar2_table(49) := '657475726E733A0D0A2020202020204F6E65206F662074686520636F6E7374616E7473203C435F524547494F4E5F49473E2C20203C435F524547494F4E5F49523E2C203C435F524547494F4E5F43523E2C203C435F524547494F4E5F545245453E2C203C';
wwv_flow_api.g_varchar2_table(50) := '435F524547494F4E5F5441423E0D0A2020202A2F0D0A2020636F6E737420676574526567696F6E54797065203D2066756E6374696F6E202870526567696F6E4964297B0D0A20202020636F6E737420247265706F7274203D2024286023247B7052656769';
wwv_flow_api.g_varchar2_table(51) := '6F6E49647D60293B0D0A20202020636F6E737420435F43525F53454C4543544F52203D2060237265706F72745F7461626C655F247B70526567696F6E49647D603B0D0A20202020636F6E737420435F49525F53454C4543544F52203D206023247B705265';
wwv_flow_api.g_varchar2_table(52) := '67696F6E49647D5F6972603B0D0A20202020636F6E737420435F49475F53454C4543544F52203D206023247B70526567696F6E49647D5F6967603B0D0A20202020636F6E737420435F545245455F53454C4543544F52203D206023247B70526567696F6E';
wwv_flow_api.g_varchar2_table(53) := '49647D5F74726565603B0D0A20202020636F6E737420435F5441425F53454C4543544F52203D20602353525F247B70526567696F6E49647D603B0D0A20202020766172207265706F7274547970653B0D0A0D0A20202020696628247265706F72742E6669';
wwv_flow_api.g_varchar2_table(54) := '6E6428435F49475F53454C4543544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F49473B0D0A202020207D0D0A20202020656C736520696628247265706F72742E66696E6428435F49';
wwv_flow_api.g_varchar2_table(55) := '525F53454C4543544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F49523B0D0A202020207D0D0A20202020656C736520696628247265706F72742E66696E6428435F43525F53454C45';
wwv_flow_api.g_varchar2_table(56) := '43544F52292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F43523B0D0A202020207D0D0A20202020656C736520696628247265706F72742E66696E6428435F545245455F53454C4543544F52';
wwv_flow_api.g_varchar2_table(57) := '292E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F545245453B0D0A202020207D0D0A20202020656C736520696628247265706F72742E706172656E7428435F5441425F53454C4543544F5229';
wwv_flow_api.g_varchar2_table(58) := '2E6C656E677468203E2030297B0D0A2020202020207265706F727454797065203D20435F524547494F4E5F5441423B0D0A202020207D0D0A0D0A2020202072657475726E207265706F7274547970653B0D0A20207D3B202F2F20676574526567696F6E54';
wwv_flow_api.g_varchar2_table(59) := '7970650D0A0D0A20202F2A2B2B2B2B2B2B2B2B2048454C50455220454E44202B2B2B2B2B2B2B2B2B2B2B2B2A2F0D0A0D0A200D0A20202F2A202B2B2B2B2B2B2B2B2B2053595354454D20414354494F4E205459504553202B2B2B2B2B2B2B2B2B2B2B202A';
wwv_flow_api.g_varchar2_table(60) := '2F0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20616C69676E5265706F7274566572746963616C546F700D0A2020202020205365747320766572746963616C20616C69676E6D656E74206F6620495220616E6420494720746F20746F702E';
wwv_flow_api.g_varchar2_table(61) := '2044656C65676174657320616C69676E696E6720746F203C6164632E72656E64657265723E2E0D0A202020200D0A20202020506172616D657465723A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F72206F662074';
wwv_flow_api.g_varchar2_table(62) := '686520726567696F6E7320746F2061646A75737420766572746963616C20616C69676E6D656E740D0A2020202A2F0D0A2020616374696F6E732E616C69676E5265706F7274566572746963616C546F70203D2066756E6374696F6E20287053656C656374';
wwv_flow_api.g_varchar2_table(63) := '6F7229207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427293B0D0A2020202020206164632E72656E64';
wwv_flow_api.g_varchar2_table(64) := '657265722E616C69676E5265706F7274566572746963616C546F7028704974656D4964293B0D0A202020207D293B0D0A20207D3B202F2F20616C69676E5265706F7274566572746963616C546F700D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374';
wwv_flow_api.g_varchar2_table(65) := '696F6E3A2062696E64436F6E6669726D6174696F6E0D0A20202020202042696E64206120636F6E6669726D6174696F6E206469616C6F6720746F206120627574746F6E20746F2073686F77206120636F6E6669726D6174696F6E206469616C6F67206265';
wwv_flow_api.g_varchar2_table(66) := '666F726520616E206576656E74206973207261697365640D0A0D0A20202020506172616D65746572733A0D0A20202020202070427574746F6E4964202D204944206F662074686520627574746F6E20746F2062696E6420746865206576656E7420746F0D';
wwv_flow_api.g_varchar2_table(67) := '0A202020202020704D657373616765202D20436F6E6669726D6174696F6E206D6573736167650D0A202020202020704469616C6F675469746C65202D205469746C65206F662074686520636F6E6669726D6174696F6E206469616C6F6720626F780D0A20';
wwv_flow_api.g_varchar2_table(68) := '20202A20406D656D6265726F662064652E636F6E6465732E706C7567696E2E6164630D0A2020202A20407075626C69630D0A2020202A2F0D0A2020616374696F6E732E62696E64436F6E6669726D6174696F6E203D2066756E6374696F6E202870427574';
wwv_flow_api.g_varchar2_table(69) := '746F6E49642C20704D6573736167652C20704469616C6F675469746C652C207041706578416374696F6E29207B0D0A202020207661722024627574746F6E203D2024286023247B70427574746F6E49647D60293B0D0A202020200D0A2020202069662028';
wwv_flow_api.g_varchar2_table(70) := '24627574746F6E2E6C656E677468203E203029207B0D0A20202020202020206164632E636F6E74726F6C6C65722E62696E64436F6E6669726D6174696F6E48616E646C65722824627574746F6E2C20704D6573736167652C20704469616C6F675469746C';
wwv_flow_api.g_varchar2_table(71) := '652C207041706578416374696F6E293B0D0A202020207D0D0A20207D3B202F2F2062696E64436F6E6669726D6174696F6E0D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2062696E64556E73617665645761726E696E670D0A20202020';
wwv_flow_api.g_varchar2_table(72) := '202042696E64206120636F6E6669726D6174696F6E206469616C6F6720746F206120627574746F6E20746F2073686F77206120636F6E6669726D6174696F6E206469616C6F67206265666F726520616E206576656E74206973207261697365640D0A0D0A';
wwv_flow_api.g_varchar2_table(73) := '20202020506172616D65746572733A0D0A20202020202070427574746F6E4964202D204944206F662074686520627574746F6E20746F2062696E6420746865206576656E7420746F0D0A202020202020704D657373616765202D20436F6E6669726D6174';
wwv_flow_api.g_varchar2_table(74) := '696F6E206D6573736167650D0A202020202020704469616C6F675469746C65202D205469746C65206F662074686520636F6E6669726D6174696F6E206469616C6F6720626F780D0A2020202A2F0D0A2020616374696F6E732E62696E64556E7361766564';
wwv_flow_api.g_varchar2_table(75) := '5761726E696E67203D2066756E6374696F6E202870427574746F6E49642C20704D6573736167652C20704469616C6F675469746C6529207B0D0A202020207661722024627574746F6E203D2024286023247B70427574746F6E49647D60293B0D0A0D0A20';
wwv_flow_api.g_varchar2_table(76) := '2020206966202824627574746F6E2E6C656E677468203E203029207B0D0A2020202020206164632E636F6E74726F6C6C65722E62696E64556E7361766564436F6E6669726D6174696F6E48616E646C65722824627574746F6E2C20704D6573736167652C';
wwv_flow_api.g_varchar2_table(77) := '20704469616C6F675469746C65293B0D0A202020207D0D0A20207D3B202F2F2062696E64556E73617665645761726E696E670D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2063616E63656C4D6F64616C4469616C6F670D0A20202020';
wwv_flow_api.g_varchar2_table(78) := '20204D6574686F6420746F20747269676765722074686520616674657263616E63656C6469616C6F67206576656E74207768656E2065786974696E672061206D6F64616C206469616C6F672E0D0A0D0A20202020506172616D657465723A20200D0A2020';
wwv_flow_api.g_varchar2_table(79) := '202020207054726967676572696E674974656D4964202D204F7074696F6E616C2074726967676572696E6720656C656D656E7420697320736574207768656E206D756C7469706C65206D6F64616C2077696E646F7773206172652075736564206F766572';
wwv_flow_api.g_varchar2_table(80) := '6C617070696E676C790D0A2020202A2F0D0A2020616374696F6E732E63616E63656C4D6F64616C4469616C6F67203D2066756E6374696F6E287054726967676572696E674974656D49642C2070436865636B4368616E676573297B0D0A20202020636F6E';
wwv_flow_api.g_varchar2_table(81) := '73742063616E63656C4469616C6F67203D2066756E6374696F6E287054726967676572696E674974656D496429207B0D0A20202020202069662028747970656F66207054726967676572696E674974656D496420213D2027756E646566696E6564272026';
wwv_flow_api.g_varchar2_table(82) := '26207054726967676572696E674974656D496420213D202727297B0D0A2020202020202020706172656E742E2428272327202B207054726967676572696E674974656D496420292E7472696767657228435F4D4F44414C5F4449414C4F475F43414E4345';
wwv_flow_api.g_varchar2_table(83) := '4C5F4556454E54293B0D0A2020202020207D0D0A202020202020656C7365207B0D0A2020202020202020696620287054726967676572696E674974656D4964203D3D202727297B0D0A202020202020202020207054726967676572696E674974656D4964';
wwv_flow_api.g_varchar2_table(84) := '203D20706172656E742E2428435F4D4F44414C5F4449414C4F475F53454C4543544F52292E6461746128435F4D4F44414C5F4449414C4F475F434C415353292E6F70656E65722E617474722827696427293B0D0A20202020202020202020706172656E74';
wwv_flow_api.g_varchar2_table(85) := '2E2428435F4D4F44414C5F4449414C4F475F53454C4543544F52292E6461746128435F4D4F44414C5F4449414C4F475F434C415353292E6F70656E65722E7472696767657228435F4D4F44414C5F4449414C4F475F43414E43454C5F4556454E54293B0D';
wwv_flow_api.g_varchar2_table(86) := '0A20202020202020207D0D0A2020202020202020656C7365207B0D0A202020202020202020207054726967676572696E674974656D4964203D20706172656E742E74726967676572696E67456C656D656E742E69643B0D0A202020202020202020207061';
wwv_flow_api.g_varchar2_table(87) := '72656E742E2428272327202B207054726967676572696E674974656D4964292E7472696767657228435F4D4F44414C5F4449414C4F475F43414E43454C5F4556454E54293B0D0A20202020202020207D3B0D0A2020202020207D3B0D0A202020200D0A20';
wwv_flow_api.g_varchar2_table(88) := '2020202020617065782E64656275672E696E666F282763616E63656C4D6F64616C4469616C6F67202D2074726967676572696E67456C656D656E743A27202B207054726967676572696E674974656D4964293B0D0A202020202020617065782E6E617669';
wwv_flow_api.g_varchar2_table(89) := '676174696F6E2E6469616C6F672E63616E63656C2874727565293B0D0A202020207D3B0D0A202020200D0A202020206966202870436865636B4368616E676573202626206164632E636F6E74726F6C6C65722E686173556E73617665644368616E676573';
wwv_flow_api.g_varchar2_table(90) := '2829297B0D0A2020202020202020617065782E6D6573736167652E636F6E6669726D280D0A202020202020202020206164632E636F6E74726F6C6C65722E6765745374616E646172644D657373616765282743534D5F43414E43454C5F4841535F434841';
wwv_flow_api.g_varchar2_table(91) := '4E47455327292C0D0A2020202020202020202066756E6374696F6E28206F6B507265737365642029207B0D0A202020202020202020202020696628206F6B507265737365642029207B0D0A2020202020202020202020202020202063616E63656C446961';
wwv_flow_api.g_varchar2_table(92) := '6C6F67287054726967676572696E674974656D4964293B0D0A2020202020202020202020207D0D0A202020202020202020207D293B0D0A202020207D0D0A20202020656C73657B0D0A20202020202063616E63656C4469616C6F67287054726967676572';
wwv_flow_api.g_varchar2_table(93) := '696E674974656D4964293B0D0A202020207D3B0D0A20207D3B202F2F2063616E63656C4D6F64616C4469616C6F670D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636C6F73654D6F64616C4469616C6F670D0A2020202020204D6574';
wwv_flow_api.g_varchar2_table(94) := '686F6420746F20747269676765722074686520616674657263616E63656C6469616C6F67206576656E74207768656E2065786974696E672061206D6F64616C206469616C6F672E0D0A0D0A20202020506172616D657465723A20200D0A20202020202070';
wwv_flow_api.g_varchar2_table(95) := '54726967676572696E674974656D4964202D204F7074696F6E616C2074726967676572696E6720656C656D656E7420697320736574207768656E206D756C7469706C65206D6F64616C2077696E646F7773206172652075736564206F7665726C61707069';
wwv_flow_api.g_varchar2_table(96) := '6E676C790D0A2020202A2F0D0A2020616374696F6E732E636C6F73654D6F64616C4469616C6F67203D2066756E6374696F6E287054726967676572696E674974656D49642C2070506167654974656D732C2070436865636B4368616E676573297B0D0A20';
wwv_flow_api.g_varchar2_table(97) := '202020636F6E737420636C6F73654469616C6F67203D2066756E6374696F6E287054726967676572696E674974656D49642C2070506167654974656D73297B0D0A20202020202069662028747970656F66207054726967676572696E674974656D496420';
wwv_flow_api.g_varchar2_table(98) := '213D2027756E646566696E656427202626207054726967676572696E674974656D496420213D202727297B0D0A2020202020202020706172656E742E2428272327202B207054726967676572696E674974656D496420292E7472696767657228435F4D4F';
wwv_flow_api.g_varchar2_table(99) := '44414C5F4449414C4F475F434C4F53455F4556454E54293B0D0A2020202020207D0D0A202020202020656C7365207B0D0A202020202020202069662028747970656F66207054726967676572696E674974656D4964203D3D2027756E646566696E656427';
wwv_flow_api.g_varchar2_table(100) := '207C7C207054726967676572696E674974656D4964203D3D202727297B0D0A202020202020202020207054726967676572696E674974656D4964203D20706172656E742E2428435F4D4F44414C5F4449414C4F475F53454C4543544F52292E6461746128';
wwv_flow_api.g_varchar2_table(101) := '435F4D4F44414C5F4449414C4F475F434C415353292E6F70656E65722E617474722827696427293B0D0A20202020202020202020706172656E742E2428435F4D4F44414C5F4449414C4F475F53454C4543544F52292E6461746128435F4D4F44414C5F44';
wwv_flow_api.g_varchar2_table(102) := '49414C4F475F434C415353292E6F70656E65722E7472696767657228435F4D4F44414C5F4449414C4F475F434C4F53455F4556454E54293B0D0A20202020202020207D0D0A2020202020202020656C7365207B0D0A202020202020202020207054726967';
wwv_flow_api.g_varchar2_table(103) := '676572696E674974656D4964203D20706172656E742E74726967676572696E67456C656D656E742E69643B0D0A20202020202020202020706172656E742E2428272327202B207054726967676572696E674974656D4964292E7472696767657228435F4D';
wwv_flow_api.g_varchar2_table(104) := '4F44414C5F4449414C4F475F434C4F53455F4556454E54293B0D0A20202020202020207D3B0D0A2020202020207D3B0D0A202020200D0A202020202020617065782E64656275672E696E666F2827636C6F73654D6F64616C4469616C6F67202D20747269';
wwv_flow_api.g_varchar2_table(105) := '67676572696E67456C656D656E743A27202B207054726967676572696E674974656D4964293B0D0A202020202020617065782E6E617669676174696F6E2E6469616C6F672E636C6F736528747275652C2070506167654974656D73293B0D0A202020207D';
wwv_flow_api.g_varchar2_table(106) := '3B0D0A2020202020200D0A202020206966202870436865636B4368616E67657320262620216164632E636F6E74726F6C6C65722E686173556E73617665644368616E6765732829297B0D0A2020202020202020617065782E6D6573736167652E616C6572';
wwv_flow_api.g_varchar2_table(107) := '74280D0A202020202020202020206164632E636F6E74726F6C6C65722E6765745374616E646172644D657373616765282743534D5F434C4F53455F574F5F4348414E47455327292C0D0A2020202020202020202066756E6374696F6E2870547269676765';
wwv_flow_api.g_varchar2_table(108) := '72696E674974656D49642C2070506167654974656D73297B0D0A202020202020202020202020636C6F73654469616C6F67287054726967676572696E674974656D49642C2070506167654974656D73290D0A202020202020202020207D293B0D0A202020';
wwv_flow_api.g_varchar2_table(109) := '207D0D0A20202020656C73657B0D0A202020202020636C6F73654469616C6F67287054726967676572696E674974656D49642C2070506167654974656D73293B0D0A202020207D3B0D0A202020200D0A20207D3B202F2F20636C6F73654D6F64616C4469';
wwv_flow_api.g_varchar2_table(110) := '616C6F670D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636F6E6669726D436F6D6D616E640D0A2020202020204D6574686F6420746F20636F6E6669726D2074686174206120636F6D6D616E642068617320746F2062652065786563';
wwv_flow_api.g_varchar2_table(111) := '757465642E0D0A0D0A202020202020577261707065722061726F756E6420616374696F6E732E65786563757465436F6D6D616E64207468617420657874656E647320746869732066756E6374696F6E616C697479207769746820610D0A20202020202063';
wwv_flow_api.g_varchar2_table(112) := '6F6E6669726D6174696F6E206469616C6F672E0D0A0D0A20202020506172616D65746572733A0D0A202020202020704D657373616765202D204D657373616765207465787420666F722074686520636F6E6669726D6174696F6E206469616C6F670D0A20';
wwv_flow_api.g_varchar2_table(113) := '20202020207044617461202D20496E7374616E6365206F662074797065203C636F6D6D616E64446174613E2C204E616D65206F662074686520636F6D6D616E6420746F2065786563757465206F722061204A534F4E0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(114) := '20696E7374616E636520636F6E7461696E696E672074686520636F6D6D616E64206E616D6520616E64206164646974696F6E616C20696E666F726D6174696F6E2E0D0A2020202020200D0A2020202A2F0D0A2020616374696F6E732E636F6E6669726D43';
wwv_flow_api.g_varchar2_table(115) := '6F6D6D616E64203D2066756E6374696F6E28704D6573736167652C207044617461297B0D0A202020206164632E72656E64657265722E636F6E6669726D5265717565737428704D6573736167652C2066756E6374696F6E28297B616374696F6E732E6578';
wwv_flow_api.g_varchar2_table(116) := '6563757465436F6D6D616E64287044617461297D293B0D0A20207D3B202F2F20636F6E6669726D436F6D6D616E640D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636F6E6669726D526571756573740D0A2020202020204D6574';
wwv_flow_api.g_varchar2_table(117) := '686F642073686F77206120636F6E6669726D6174696F6E206469616C6F67206265666F72652070617373696E6720616E20616374696F6E20746F204144432E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020202070457665';
wwv_flow_api.g_varchar2_table(118) := '6E74202D204576656E74206F626A656374207468617420776173207261697365642E0D0A2020202020207043616C6C6261636B202D2043616C6C6261636B206D6574686F6420746F206578656375746520696E2063617365206F6620636F6E6669726D61';
wwv_flow_api.g_varchar2_table(119) := '74696F6E0D0A2020202A2F0D0A2020616374696F6E732E636F6E6669726D52657175657374203D2066756E6374696F6E2028704576656E742C207043616C6C6261636B297B0D0A202020206164632E72656E64657265722E636F6E6669726D5265717565';
wwv_flow_api.g_varchar2_table(120) := '737428704576656E742C207043616C6C6261636B293B0D0A20207D3B20202F2F20636F6E6669726D526571756573740D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2065786563757465436F6D6D616E640D0A20202020202057726170';
wwv_flow_api.g_varchar2_table(121) := '7065722061726F756E64203C636F6E74726F6C6C65722E657865637574653E207468617420726169736573206120636F6D6D616E64206576656E7420616C6F6E67207769746820746865206E656365737361727920646174612E0D0A2020202020200D0A';
wwv_flow_api.g_varchar2_table(122) := '20202020202054686973206D6574686F64206973207573656420617320746865207374616E6461726420616374696F6E20666F72206120636F6D6D616E64206F626A65637420746F206D616B65207375726520746861742041444320697320696E666F72';
wwv_flow_api.g_varchar2_table(123) := '6D656420746861740D0A202020202020616E20414443206D61696E7461696E6564204150455820616374696F6E2077617320696E766F6B65642E0D0A2020202020200D0A20202020506172616D65746572733A0D0A2020202020207044617461202D2049';
wwv_flow_api.g_varchar2_table(124) := '6E7374616E6365206F662074797065203C636F6D6D616E64446174613E2C204E616D65206F662074686520636F6D6D616E6420746F2065786563757465206F722061204A534F4E0D0A2020202020202020202020202020696E7374616E636520636F6E74';
wwv_flow_api.g_varchar2_table(125) := '61696E696E672074686520636F6D6D616E64206E616D6520616E64206164646974696F6E616C20696E666F726D6174696F6E2E0D0A2020202A2F0D0A2020616374696F6E732E65786563757465436F6D6D616E64203D2066756E6374696F6E2870446174';
wwv_flow_api.g_varchar2_table(126) := '61297B0D0A2020202076617220646174613B0D0A20202020766172206576656E74203D207B7D3B0D0A202020200D0A20202020696628747970656F66207044617461203D3D3D2027737472696E6727297B0D0A20202020202064617461203D207B0D0A20';
wwv_flow_api.g_varchar2_table(127) := '2020202020202027636F6D6D616E64273A70446174612C200D0A2020202020202020276164646974696F6E616C506167654974656D73273A5B5D2C200D0A2020202020202020276D6F6E69746F724368616E676573273A2066616C73650D0A2020202020';
wwv_flow_api.g_varchar2_table(128) := '207D3B0D0A202020207D0D0A20202020656C73657B0D0A20202020202064617461203D2070446174613B0D0A202020202020646174612E6164646974696F6E616C506167654974656D73203D20646174612E6164646974696F6E616C506167654974656D';
wwv_flow_api.g_varchar2_table(129) := '73207C7C205B5D3B0D0A202020202020646174612E6D6F6E69746F724368616E676573203D20646174612E6D6F6E69746F724368616E676573207C7C2066616C73653B0D0A202020207D0D0A202020200D0A202020206164632E636F6E74726F6C6C6572';
wwv_flow_api.g_varchar2_table(130) := '2E73657454726967676572696E67456C656D656E7428435F434F4D4D414E442C20435F434F4D4D414E445F4E414D452C2064617461293B0D0A202020200D0A2020202069662870446174612E6D6F6E69746F724368616E676573202626206164632E636F';
wwv_flow_api.g_varchar2_table(131) := '6E74726F6C6C65722E686173556E73617665644368616E6765732829297B0D0A2020202020202F2F20556E7361766564206368616E67657320616D6F6E6720746865206F627365727665642070616765206974656D732C20636865636B20776974682075';
wwv_flow_api.g_varchar2_table(132) := '7365720D0A20202020202076617220706167655374617465203D206164632E636F6E74726F6C6C65722E67657450616765537461746528293B0D0A2020202020206576656E742E64617461203D2070446174613B0D0A2020202020206576656E742E6461';
wwv_flow_api.g_varchar2_table(133) := '74612E6D657373616765203D207061676553746174652E6D6573736167653B0D0A2020202020206576656E742E646174612E7469746C65203D207061676553746174652E7469746C653B0D0A2020202020206164632E72656E64657265722E636F6E6669';
wwv_flow_api.g_varchar2_table(134) := '726D52657175657374286576656E742C206164632E636F6E74726F6C6C65722E65786563757465293B2020202020200D0A202020207D656C73657B0D0A2020202020206164632E636F6E74726F6C6C65722E6578656375746528293B0D0A202020207D0D';
wwv_flow_api.g_varchar2_table(135) := '0A20207D3B202F2F2065786563757465436F6D6D616E640D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20666F6375730D0A2020202020204D6574686F6420746F206578706C696369746C79207365742074686520666F63757320';
wwv_flow_api.g_varchar2_table(136) := '746F2074686520726571756573746564206974656D0D0A202020200D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944206F6620746865206974656D20746F20736574207468746520666F63757320746F0D0A2020';
wwv_flow_api.g_varchar2_table(137) := '202A2F0D0A2020616374696F6E732E666F637573203D2066756E6374696F6E28704974656D4964297B0D0A2020202024286023247B704974656D49647D60292E666F63757328293B0D0A20207D3B202F2F20666F6375730D0A0D0A0D0A20202F2A2A0D0A';
wwv_flow_api.g_varchar2_table(138) := '2020202046756E6374696F6E3A206765745265706F727453656C656374696F6E0D0A2020202020205265636F676E697A65732073656C656374696F6E206368616E676573206F6E20496E746572616374697665207265706F7274732C20696E7465726163';
wwv_flow_api.g_varchar2_table(139) := '74697665206772696473206F7220636C6173736963207265706F7274732E0D0A202020202020546F206761746865722061636365737320746F20746865207072696D617279206B65792076616C75652C206974206973206E656365737361727920746F20';
wwv_flow_api.g_varchar2_table(140) := '6F6265792074686520666F6C6C6F77696E6720636F6E76656E74696F6E733A0D0A2020202020200D0A2020202020202D20496E20696E74657261637469766520616E6420636C6173736963207265706F7274732C20612076697369626C6520636F6C756D';
wwv_flow_api.g_varchar2_table(141) := '6E206D75737420636F6E7461696E20612068746D6C2065787072657373696F6E20776974682061203C646174612D69643E206174747269627574650D0A2020202020202020636F6E7461696E696E672074686520504B2076616C75653A203C266C743B73';
wwv_flow_api.g_varchar2_table(142) := '70616E20646174612D69643D2723504B5F434F4C554D4E23272667743B2356495349424C455F434F4C554D4E23266C743B2F7370616E2667743B3E3E6C693E0D0A2020202020202D20496E20696E74657261637469766520677269642C20697420697320';
wwv_flow_api.g_varchar2_table(143) := '706F737369626C6520746F20656974686572206964656E7469667920612073696E676C6520636F6C756D6E206F6620746865207265706F727420617320746865207072696D617279206B657920636F6C756D6E0D0A20202020202020202841444320646F';
wwv_flow_api.g_varchar2_table(144) := '6573206E6F7420737570706F7274206D756C7469706C65206B657920636F6C756D6E732079657429206F722062792070617373696E6720616E206F7264696E616C206E756D6265722028312062617365642920706F696E74696E6720746F207468652063';
wwv_flow_api.g_varchar2_table(145) := '6F6C756D6E0D0A2020202020202020636F6E7461696E696E6720746865207072696D617279206B65792E20546865206F7264657220697320646566696E656420627920746865206F72646572206F66207468652053514C207175657279206F7220746865';
wwv_flow_api.g_varchar2_table(146) := '20636F6C756D6E206F7264657220726573706563746976656C792E0D0A202020202020200D0A2020202020204966206E6F2070616765206974656D20746F2073746F726520746865207072696D617279206B65792076616C75652069732070726F766964';
wwv_flow_api.g_varchar2_table(147) := '65642C2074686973206D6574686F6420726169736573206576656E74203C61646373656C656374696F6E6368616E67653E207768696368200D0A20202020202063616E20626520646574656374656420696E20414443206279207175657279696E672074';
wwv_flow_api.g_varchar2_table(148) := '68652070736575646F20636F6C756D6E203C53454C454354494F4E5F4348414E4745443E2E200D0A20202020202054686520636F6C756D6E20636F6E7461696E7320746865207265706F7274204944206F6E20776869636820746865206576656E742077';
wwv_flow_api.g_varchar2_table(149) := '61732066697265642E20546865207072696D617279206B65792076616C75650D0A20202020202069732070726F76696465642076696120746865206576656E7420646174612070726F706572747920616E642063616E20626520726561642066726F6D20';
wwv_flow_api.g_varchar2_table(150) := '504C2F53514C206279207573696E67203C6164632E6765745F6576656E745F646174613E206F7220696E204A617661536372697074200D0A2020202020207769746820746865207265706C6163656D656E7420416E63686F72203C234556454E545F4441';
wwv_flow_api.g_varchar2_table(151) := '5441233E202877697468696E20414443206F6E6C79292E0D0A2020202020200D0A202020202020496E746572616374697665207265706F7274732061726520657874656E64656420627920737570706F727420666F7220746162206B65797320616E6420';
wwv_flow_api.g_varchar2_table(152) := '726F7720686967686C69676874696E672E20416C736F2C20746162206B6579206E617669676174696F6E20697320657874656E646564200D0A202020202020746F20636F6E74696E756520776F726B696E67207768656E206C656176696E672074686520';
wwv_flow_api.g_varchar2_table(153) := '6C617374206F7220656E746572696E672074686520666972737420726F772E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020705265706F72744964202D204944206F6620746865207265706F727420746F206F627365';
wwv_flow_api.g_varchar2_table(154) := '7276650D0A202020202020704974656D4964202D204944206F66207468652070616765206974656D20746F2073617665207468652073656C656374696F6E20746F2E204966207365742C207468652076616C7565206F6620746865207061676520697465';
wwv_flow_api.g_varchar2_table(155) := '6D2077696C6C206265206368616E6765640D0A20202020202020202020202020202020746F20746865204944206F66207468652073656C656374656420726F772E204966206E6F74207365742C20746865206D6574686F642077696C6C20726169736520';
wwv_flow_api.g_varchar2_table(156) := '6576656E74203C61646373656C656374696F6E6368616E67653E20776974682074686520494420617320646174612E0D0A20202020202070436F6C756D6E202D204F7074696F6E616C206F7264696E617279206E756D626572206F662074686520636F6C';
wwv_flow_api.g_varchar2_table(157) := '756D6E20636F6E7461696E696E672074686520504B20696E666F726D6174696F6E200D0A20202020202020202020202020202020284947206F6E6C7920616E64206E6563657373617279206F6E6C79206966206E6F2073696E676C65207072696D617279';
wwv_flow_api.g_varchar2_table(158) := '206B657920636F6C756D6E2069732061646D696E69737465726564290D0A20202020202070536574466F637573202D20466C616720746F20696E64696361746520776865746865722073656C656374696E67206120726F772075706F6E20696E69746961';
wwv_flow_api.g_varchar2_table(159) := '6C697A697461696F6E206F72207265667265736820616C736F20736574732074686520666F63757320746F207468652073656C656374656420726F772E0D0A2020202A2F0D0A2020616374696F6E732E6765745265706F727453656C656374696F6E203D';
wwv_flow_api.g_varchar2_table(160) := '2066756E6374696F6E28705265706F727449642C20704974656D49642C2070436F6C756D6E2C2070536574466F637573297B0D0A20202020636F6E737420247265706F7274203D2024286023247B705265706F727449647D60293B0D0A20202020636F6E';
wwv_flow_api.g_varchar2_table(161) := '7374207265706F727454797065203D20676574526567696F6E5479706528705265706F72744964293B0D0A202020206C65742063616C6C6261636B3B0D0A202020206C657420706B56616C75653B0D0A202020200D0A20202020696628704974656D4964';
wwv_flow_api.g_varchar2_table(162) := '297B0D0A20202020202063616C6C6261636B203D2066756E6374696F6E287056616C7565297B0D0A2020202020202020617065782E6974656D28704974656D4964292E73657456616C7565287056616C7565293B0D0A2020202020207D3B0D0A20202020';
wwv_flow_api.g_varchar2_table(163) := '20202F2F20636F6E6E65637420746172676574206974656D20746F207265706F727420746F20656E61626C65206C61746572207265666572656E6365206F66207468652073656C6563746564206E6F64652E0D0A2020202020202F2F20616C736F2C2074';
wwv_flow_api.g_varchar2_table(164) := '686973206974656D73206E6565647320746F206265206F62736572766572656420746F206861726D6F6E697A65206974732076616C756520776974682074686520706167652073746174652E0D0A20202020202024286023247B704974656D49647D6029';
wwv_flow_api.g_varchar2_table(165) := '2E6174747228435F524547494F4E5F444154415F4954454D2C20705265706F72744964293B0D0A2020202020206164632E636F6E74726F6C6C65722E62696E644F627365727665724974656D7328704974656D4964293B0D0A202020207D0D0A20202020';
wwv_flow_api.g_varchar2_table(166) := '656C73657B0D0A2020202020202F2F204E6F206974656D2070726573656E742C207375626D69742049442077697468206576656E7420435F53454C454354494F4E5F4348414E47455F4556454E540D0A20202020202063616C6C6261636B203D2066756E';
wwv_flow_api.g_varchar2_table(167) := '6374696F6E287056616C7565297B0D0A20202020202020206164632E636F6E74726F6C6C65722E73657454726967676572696E67456C656D656E7428705265706F727449642C20435F53454C454354494F4E5F4348414E47455F4556454E542C20705661';
wwv_flow_api.g_varchar2_table(168) := '6C7565293B0D0A20202020202020206164632E636F6E74726F6C6C65722E6578656375746528293B0D0A2020202020207D3B0D0A202020207D3B0D0A0D0A202020202F2F204578616D696E652074797065206F66207265706F727420616E642062696E64';
wwv_flow_api.g_varchar2_table(169) := '20636C69636B2068616E646C65720D0A20202020737769746368287265706F727454797065297B0D0A2020202020206361736520435F524547494F4E5F43523A0D0A2020202020202020247265706F72742E6F6E28435F434C49434B5F4556454E542C20';
wwv_flow_api.g_varchar2_table(170) := '435F524547494F4E5F43525F53454C4543544F522C2066756E6374696F6E28297B0D0A20202020202020202020706B56616C7565203D20242874686973292E66696E6428277464205B646174612D69645D27292E646174612827696427293B0D0A202020';
wwv_flow_api.g_varchar2_table(171) := '202020202020206164632E72656E64657265722E686967686C69676874526F7728242874686973292C2070536574466F637573293B0D0A2020202020202020202063616C6C6261636B28706B56616C7565293B0D0A20202020202020207D293B0D0A2020';
wwv_flow_api.g_varchar2_table(172) := '202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49473A0D0A2020202020202020247265706F72742E6F6E28435F49475F53454C454354494F4E5F4348414E47452C2066756E6374696F6E28652C2064617461297B0D';
wwv_flow_api.g_varchar2_table(173) := '0A20202020202020202020696628646174612E73656C65637465645265636F7264732E6C656E677468297B0D0A2020202020202020202020202F2F2054727920746F2067657420746865207072696D617279206B657920696E666F726D6174696F6E2066';
wwv_flow_api.g_varchar2_table(174) := '726F6D20746865206964656E7469747920636F6C756D6E2E0D0A2020202020202020202020202F2F204966206E6F6E65206578697374732C206765742069742066726F6D2074686520636F6C756D6E20696E6465782070617373656420696E0D0A202020';
wwv_flow_api.g_varchar2_table(175) := '20202020202020202069662870436F6C756D6E297B0D0A2020202020202020202020202020706B56616C7565203D20646174612E73656C65637465645265636F7264735B305D5B4D6174682E6D61782870436F6C756D6E202D20312C2030295D3B0D0A20';
wwv_flow_api.g_varchar2_table(176) := '20202020202020202020207D656C73657B0D0A2020202020202020202020202020706B56616C7565203D20646174612E6D6F64656C2E6765745265636F7264496428646174612E73656C65637465645265636F7264735B305D293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(177) := '20202020207D0D0A20202020202020202020202063616C6C6261636B28706B56616C7565293B0D0A202020202020202020207D3B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F52454749';
wwv_flow_api.g_varchar2_table(178) := '4F4E5F49523A0D0A2020202020202020247265706F72740D0A202020202020202020202E6F6E28435F434C49434B5F4556454E542C20435F524547494F4E5F49525F53454C4543544F522C2066756E6374696F6E28297B0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(179) := '20706B56616C7565203D20242874686973292E66696E6428277464205B646174612D69645D27292E646174612827696427293B0D0A202020202020202020202020616374696F6E732E73656C656374456E74727928705265706F727449642C20706B5661';
wwv_flow_api.g_varchar2_table(180) := '6C75652C20747275652C2066616C7365293B0D0A20202020202020202020202063616C6C6261636B28706B56616C7565293B0D0A202020202020202020207D290D0A202020202020202020202E6F6E28435F4B4559444F574E5F4556454E542C20435F52';
wwv_flow_api.g_varchar2_table(181) := '4547494F4E5F49525F524F575F53454C4543544F522C2066756E6374696F6E286529207B0D0A20202020202020202020202020202F2F2074616220666F72776172640D0A202020202020202020202020202069662028652E7768696368203D3D3D20435F';
wwv_flow_api.g_varchar2_table(182) := '5441424B455920262620652E73686966744B6579203D3D3D2066616C7365297B0D0A20202020202020202020202020202020242874686973292E6E65787428292E636C69636B28293B0D0A20202020202020202020202020202020696620282428746869';
wwv_flow_api.g_varchar2_table(183) := '73292E697328273A6C6173742D6368696C642729297B0D0A202020202020202020202020202020202020617065782E64656275672E696E666F2860247B435F44415445495F4E414D457D202D20746162206B65792066726F6D206C61737420726F77206C';
wwv_flow_api.g_varchar2_table(184) := '656176657320495260293B0D0A202020202020202020202020202020207D20656C7365207B0D0A20202020202020202020202020202020202072657475726E2066616C73653B0D0A202020202020202020202020202020207D3B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(185) := '20202020207D0D0A2020202020202020202020202020656C73652069662028652E7768696368203D3D3D20435F5441424B455920262620652E73686966744B6579203D3D3D2074727565297B0D0A202020202020202020202020202020202F2F20746162';
wwv_flow_api.g_varchar2_table(186) := '206261636B77617264730D0A20202020202020202020202020202020242874686973292E7072657628292E636C69636B28293B0D0A2020202020202020202020202020202069662028242874686973292E697328273A6E74682D6368696C642832292729';
wwv_flow_api.g_varchar2_table(187) := '297B0D0A202020202020202020202020202020202020617065782E64656275672E696E666F2860247B435F44415445495F4E414D457D202D20746162206B6579206261636B77617264732066726F6D20666972737420726F77206C656176657320495260';
wwv_flow_api.g_varchar2_table(188) := '293B0D0A202020202020202020202020202020207D20656C7365207B0D0A20202020202020202020202020202020202072657475726E2066616C73653B0D0A202020202020202020202020202020207D3B0D0A20202020202020202020202020207D3B0D';
wwv_flow_api.g_varchar2_table(189) := '0A202020202020202020207D290D0A202020202020202020202E6F6E28435F4B4559444F574E5F4556454E542C20272E742D6668742D7468656164202E612D4952522D7461626C652074682E612D4952522D68656164657220613A6C617374272C206675';
wwv_flow_api.g_varchar2_table(190) := '6E6374696F6E286529207B0D0A2020202020202020202020202020617065782E64656275672E696E666F2860247B435F44415445495F4E414D457D202D20746162206B65792066726F6D206C6173742068656164657220726F7720656E74657273204952';
wwv_flow_api.g_varchar2_table(191) := '60293B0D0A202020202020202020202020202069662028652E7768696368203D3D3D20435F5441424B455920262620652E73686966744B6579203D3D3D2066616C7365297B0D0A202020202020202020202020202020202428435F524547494F4E5F4952';
wwv_flow_api.g_varchar2_table(192) := '5F46495253545F524F575F53454C4543544F52292E636C69636B28293B0D0A2020202020202020202020202020202072657475726E2066616C73653B0D0A20202020202020202020202020207D3B0D0A202020202020202020207D290D0A202020202020';
wwv_flow_api.g_varchar2_table(193) := '202020202E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A202020202020202020202020617065782E64656275672E6C6F672860247B435F44415445495F4E414D457D202D2061706578616674657272';
wwv_flow_api.g_varchar2_table(194) := '65667265736820646574656374656460293B0D0A202020202020202020202020696628704974656D4964297B0D0A2020202020202020202020202020617065782E6974656D28704974656D4964292E73657456616C756528293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(195) := '202020207D3B0D0A202020202020202020202020616374696F6E732E73656C656374456E74727928705265706F727449642C2027272C2070536574466F6375732C2066616C7365293B0D0A202020202020202020207D293B0D0A20202020202020206272';
wwv_flow_api.g_varchar2_table(196) := '65616B3B0D0A2020202020206361736520435F524547494F4E5F545245453A0D0A20202020202020206C6574202474726565203D2024286023247B705265706F727449647D5F7472656560293B0D0A202020202020202024747265652E6F6E28435F5452';
wwv_flow_api.g_varchar2_table(197) := '45455F53454C454354494F4E5F4348414E47452C2066756E6374696F6E28297B0D0A202020202020202020206C65742073656C65637465644E6F6465733B0D0A202020202020202020206C65742069644C6973743B0D0A2020202020202020202073656C';
wwv_flow_api.g_varchar2_table(198) := '65637465644E6F646573203D2024747265652E7472656556696577282767657453656C65637465644E6F64657327293B0D0A2020202020202020202069644C697374203D2073656C65637465644E6F6465730D0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(199) := '2020202E6D61702866756E6374696F6E286974656D297B72657475726E206974656D2E69643B7D290D0A202020202020202020202020202020202020202E6A6F696E28273A27293B0D0A2020202020202020202063616C6C6261636B2869644C69737429';
wwv_flow_api.g_varchar2_table(200) := '3B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20202020616374696F6E732E73656C656374456E74727928705265706F727449642C2027272C2070536574466F6375732C2074727565293B0D0A20207D';
wwv_flow_api.g_varchar2_table(201) := '3B202F2F206765745265706F727453656C656374696F6E0D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20686964655265706F727446696C74657250616E656C0D0A20202020202048696465732066696C7465722070616E656C73';
wwv_flow_api.g_varchar2_table(202) := '2066726F6D20495220616E642049472E2044656C65676174657320686964696E67207468652066696C7465722070616E656C20746F203C6164632E72656E64657265723E2E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020';
wwv_flow_api.g_varchar2_table(203) := '20207053656C6563746F72206A51756572792073656C6563746F72206F662074686520726567696F6E73207468617420636F6E7461696E20612066696C7465722070616E656C20746F20686964652E0D0A2020202A2F0D0A2020616374696F6E732E6869';
wwv_flow_api.g_varchar2_table(204) := '64655265706F727446696C74657250616E656C203D2066756E6374696F6E20287053656C6563746F7229207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D49';
wwv_flow_api.g_varchar2_table(205) := '64203D20242874686973292E617474722827696427293B0D0A2020202020206164632E72656E64657265722E686964655265706F727446696C74657250616E656C28704974656D49642C20676574526567696F6E5479706528704974656D496429293B0D';
wwv_flow_api.g_varchar2_table(206) := '0A202020207D293B0D0A20207D3B202F2F20686964655265706F727446696C74657250616E656C0D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A206E6F746966790D0A2020202020204D6574686F6420746F2073686F772061206E6F74';
wwv_flow_api.g_varchar2_table(207) := '696669636174696F6E2E2044656C65676174657320696D706C656D656E746174696F6E20746F203C6164632E72656E64657265723E2E0D0A20202020202041206E6F74696669636174696F6E2069732061206D6573736167652074686174206973207368';
wwv_flow_api.g_varchar2_table(208) := '6F776E20746F20746865207573657220696E206120736D616C6C206469616C6F672E0D0A0D0A20202020506172616D657465723A0D0A202020202020705374796C65202D204F6E65206F662074686520707265646566696E6564207374796C657320616C';
wwv_flow_api.g_varchar2_table(209) := '6572747C7761726E696E677C7375636573737C696E666F7C636F6E6669726D0D0A202020202020704D657373616765202D204D65737361676520746861742069732073686F776E20746F2074686520757365722E205265706C6163657320616E79206578';
wwv_flow_api.g_varchar2_table(210) := '697374696E67206D657373616765732E0D0A202020202020705469746C65202D204F7074696F6E616C207469746C65206F6620746865206469616C6F670D0A20202020202070466F6375734974656D202D204974656D2074686174206765747320666F63';
wwv_flow_api.g_varchar2_table(211) := '757320616674657220636C6F73696E6720746865206469616C6F670D0A2020202A2F0D0A2020616374696F6E732E6E6F74696679203D2066756E6374696F6E2028705374796C652C20704D6573736167652C20705469746C652C2070466F637573497465';
wwv_flow_api.g_varchar2_table(212) := '6D29207B0D0A202020206164632E72656E64657265722E73686F774469616C6F6728705374796C652C20704D6573736167652C20705469746C652C2070466F6375734974656D293B0D0A20207D3B202F2F206E6F746966790D0A0D0A0D0A20202F2A2A0D';
wwv_flow_api.g_varchar2_table(213) := '0A2020202046756E6374696F6E3A20636C6561724572726F72730D0A2020202020204D6574686F6420746F2072656D6F766520616C6C206572726F72732073686F776E206F6E2074686520706167652E204973207573656420696E2063617365206F6620';
wwv_flow_api.g_varchar2_table(214) := '63616E63656C20616374697669746965730D0A202020202020746F2072656D6F766520746F206120636C65616E207374617465206F6E20746865207061676520776974686F75742073686F77696E6720616E79206572726F7273206F76657220616E6420';
wwv_flow_api.g_varchar2_table(215) := '6F76657220616761696E2E0D0A0D0A2020202A2F0D0A2020616374696F6E732E636C6561724572726F7273203D2066756E6374696F6E202829207B0D0A202020206164632E72656E64657265722E73686F774572726F7273285B5D293B0D0A20207D3B20';
wwv_flow_api.g_varchar2_table(216) := '2F2F20636F6E6669726D0D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636F6E6669726D0D0A2020202020204D6574686F6420746F2073686F77206120636F6E6669726D6174696F6E206469616C6F672E2044656C65676174657320';
wwv_flow_api.g_varchar2_table(217) := '696D706C656D656E746174696F6E20746F203C6164632E72656E64657265723E2E0D0A2020202020204120636F6E6669726D6174696F6E206D6179206265206163636570746564206F722072656A65637465642062792074686520757365722E0D0A0D0A';
wwv_flow_api.g_varchar2_table(218) := '20202020506172616D657465723A0D0A202020202020704D657373616765202D204D65737361676520746861742069732073686F776E20746F2074686520757365722E205265706C6163657320616E79206578697374696E67206D657373616765732E0D';
wwv_flow_api.g_varchar2_table(219) := '0A202020202020705469746C65202D204F7074696F6E616C207469746C65206F6620746865206469616C6F670D0A202020202020705374796C65202D204F6E65206F662074686520707265646566696E6564207374796C657320696E666F726D6174696F';
wwv_flow_api.g_varchar2_table(220) := '6E7C7761726E696E677C7375636573737C6572726F720D0A2020202A2F0D0A2020616374696F6E732E636F6E6669726D203D2066756E6374696F6E2028704D6573736167652C20705469746C652C20705374796C6529207B0D0A202020206164632E7265';
wwv_flow_api.g_varchar2_table(221) := '6E64657265722E73686F774469616C6F6728704D6573736167652C20705469746C652C20705374796C652C2074727565293B0D0A20207D3B202F2F20636F6E6669726D0D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F775375';
wwv_flow_api.g_varchar2_table(222) := '63636573730D0A2020202020204D6574686F6420746F2073686F7773206120706167652073756363657373206D6573736167650D0A0D0A20202020506172616D657465723A0D0A202020202020704D657373616765202D204D6573736167652074686174';
wwv_flow_api.g_varchar2_table(223) := '2069732073686F776E20746F2074686520757365722E0D0A2020202A2F0D0A2020616374696F6E732E73686F7753756363657373203D2066756E6374696F6E2028704D65737361676529207B0D0A202020206164632E72656E64657265722E73686F7753';
wwv_flow_api.g_varchar2_table(224) := '75636365737328704D657373616765293B0D0A20207D3B202F2F2073686F77537563636573730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F774D6573736167650D0A20202020202047656E6572696320616374696F6E2074';
wwv_flow_api.g_varchar2_table(225) := '6F2073686F77206469616C6F672C20706F707570206F7220706167652073756363657373206D657373616765730D0A0D0A20202020506172616D657465723A0D0A202020202020704D657373616765202D204D6573736167652074686174206973207368';
wwv_flow_api.g_varchar2_table(226) := '6F776E20746F2074686520757365722E0D0A202020202020705469746C65202D204F7074696F6E616C207469746C65206F6620746865206469616C6F670D0A202020202020704F7074696F6E73202D204F7074696F6E73206F626A65637420746F20636F';
wwv_flow_api.g_varchar2_table(227) := '6E74726F6C20686F7720746865206D65737361676520697320646973706C617965642E0D0A2020202020202020202020202020202020546865206F7074696F6E73206F626A65637420616C736F20636F6E7461696E732074686520666F63757320697465';
wwv_flow_api.g_varchar2_table(228) := '6D20746F207365742074686520666F63757320746F0D0A2020202020202020202020202020202020616674657220636C6F73696E6720746865206469616C6F672E0D0A20202020202020202020202020202020204164646974696F6E616C20746F207468';
wwv_flow_api.g_varchar2_table(229) := '6520617065782E6D6573736167652E73686F774469616C6F672E6F7074696F6E7320706172616D657465722C20704F7074696F6E730D0A2020202020202020202020202020202020636F6E7461696E7320616E20617474726962757465206469616C6F67';
wwv_flow_api.g_varchar2_table(230) := '5479706520746F2064697374696E6775697368206265747765656E20737563636573734D6573736167650D0A2020202020202020202020202020202020616E64206469616C6F670D0A2020202A2F0D0A2020616374696F6E732E73686F774D6573736167';
wwv_flow_api.g_varchar2_table(231) := '65203D2066756E6374696F6E2028704D6573736167652C20705469746C652C20704F7074696F6E7329207B0D0A2020202073776974636828704F7074696F6E732E6469616C6F6754797065297B0D0A2020202020206361736520276469616C6F67273A0D';
wwv_flow_api.g_varchar2_table(232) := '0A20202020202020206164632E72656E64657265722E73686F774D65737361676528704D6573736167652C20705469746C652C20704F7074696F6E73293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520277375636365737327';
wwv_flow_api.g_varchar2_table(233) := '3A0D0A20202020202020206164632E72656E64657265722E73686F775375636365737328704D657373616765293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20207D3B202F2F2073686F774D6573736167650D0A0D0A0D0A20202F2A';
wwv_flow_api.g_varchar2_table(234) := '2A0D0A2020202046756E6374696F6E3A20686964654D6573736167650D0A20202020202047656E6572696320616374696F6E20746F20686964652073756363657373206F72206572726F72206D657373616765730D0A0D0A20202020506172616D657465';
wwv_flow_api.g_varchar2_table(235) := '723A0D0A2020202020207054797065202D204F6E65206F662074686520636F6E7374616E747320737563636573737C6572726F727C626F746820746F20646563696465207768617420746F20686964650D0A2020202A2F0D0A2020616374696F6E732E68';
wwv_flow_api.g_varchar2_table(236) := '6964654D657373616765203D2066756E6374696F6E2028705479706529207B0D0A20202020737769746368287054797065297B0D0A20202020202063617365202773756363657373273A0D0A20202020202020206164632E72656E64657265722E636C65';
wwv_flow_api.g_varchar2_table(237) := '61724E6F74696669636174696F6E28293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520276572726F72273A0D0A20202020202020206164632E72656E64657265722E636C6561724572726F727328293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(238) := '20627265616B3B0D0A202020202020636173652027626F7468273A0D0A20202020202020206164632E72656E64657265722E636C6561724E6F74696669636174696F6E28293B0D0A20202020202020206164632E72656E64657265722E636C6561724572';
wwv_flow_api.g_varchar2_table(239) := '726F727328293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20207D3B202F2F20686964654D6573736167650D0A0D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A207265676973746572506167654974656D734F6E';
wwv_flow_api.g_varchar2_table(240) := '63650D0A2020202020204D6574686F6420746F2072656769737465722061206C697374206F662070616765206974656D7320746861742061726520746F206265206164646974696F6E616C6C792073656E7420746F207468652073657276657220647572';
wwv_flow_api.g_varchar2_table(241) := '696E6720746865206E65787420414443206576656E740D0A0D0A20202020506172616D657465723A0D0A202020202020704974656D4C697374202D204172726179206F662070616765206974656D206E616D65730D0A2020202A2F0D0A2020616374696F';
wwv_flow_api.g_varchar2_table(242) := '6E732E7265676973746572506167654974656D734F6E6365203D2066756E6374696F6E28704974656D4C697374297B0D0A202020206164632E636F6E74726F6C6C65722E7365744164646974696F6E616C4974656D7328704974656D4C697374293B0D0A';
wwv_flow_api.g_varchar2_table(243) := '20207D3B202F2F207265676973746572506167654974656D734F6E63650D0A0D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A2072656D656D626572506167654974656D5374617475730D0A2020202020204D6574686F6420746F2070';
wwv_flow_api.g_varchar2_table(244) := '6572736973742074686520737461747573206F6620616C6C2070616765206974656D73206F72206F6E6C7920746865206974656D732070726F7669646564206173203C70506167654974656D733E2E0D0A20202020202054686973206973207468652062';
wwv_flow_api.g_varchar2_table(245) := '6173697320666F722027756E7361766564206368616E67657327206D6573736167657320696E20612064796E616D696320656E7669726F6E6D656E742E0D0A0D0A20202020506172616D65746572733A0D0A20202020202070506167654974656D73202D';
wwv_flow_api.g_varchar2_table(246) := '204172726179206F6620616C6C2070616765206974656D2069647320746F20636170747572652E20496620656D7074792C20616C6C2070616765206974656D73206172652063617074757265642E0D0A202020202020704D657373616765202D204F7074';
wwv_flow_api.g_varchar2_table(247) := '696F6E616C206D65737361676520746F2073686F7720696620756E7361766564206368616E676573206578697374206F6E2074686520706167650D0A202020202020705469746C65202D204F7074696F6E616C207469746C65206F662074686520646961';
wwv_flow_api.g_varchar2_table(248) := '6C6F6720746861742069732073686F776E20696620756E7361766564206368616E676573206172652064657465637465640D0A2020202A2F0D0A2020616374696F6E732E72656D656D626572506167654974656D537461747573203D2066756E6374696F';
wwv_flow_api.g_varchar2_table(249) := '6E2870506167654974656D732C20704D6573736167652C20705469746C65297B0D0A20202020766172206974656D4C6973743B0D0A20202020766172206974656D56616C75653B0D0A20202020766172207061676553746174653B0D0A202020200D0A20';
wwv_flow_api.g_varchar2_table(250) := '2020202F2F20496E697469616C697A650D0A20202020706167655374617465203D206164632E636F6E74726F6C6C65722E67657450616765537461746528293B0D0A202020207061676553746174652E6974656D4D61702E636C65617228293B0D0A2020';
wwv_flow_api.g_varchar2_table(251) := '20207061676553746174652E6D657373616765203D20704D6573736167653B0D0A202020207061676553746174652E7469746C65203D20705469746C653B0D0A202020206974656D4C697374203D202428435F494E5055545F53454C4543544F52293B0D';
wwv_flow_api.g_varchar2_table(252) := '0A202020200D0A202020206966202841727261792E697341727261792870506167654974656D7329297B0D0A2020202020206966202870506167654974656D732E636F756E74203E2030297B0D0A20202020202020206974656D4C697374203D20705061';
wwv_flow_api.g_varchar2_table(253) := '67654974656D733B0D0A2020202020207D0D0A202020207D0D0A202020200D0A20202020242E65616368286974656D4C6973742C2066756E6374696F6E286974656D297B0D0A20202020202020206974656D203D206974656D4C6973745B6974656D5D3B';
wwv_flow_api.g_varchar2_table(254) := '0D0A20202020202020206966286974656D2E6964297B0D0A202020202020202020206974656D203D206974656D2E69643B0D0A20202020202020207D3B0D0A20202020202020206974656D56616C7565203D20617065782E6974656D286974656D292E67';
wwv_flow_api.g_varchar2_table(255) := '657456616C756528293B0D0A20202020202020207061676553746174652E6974656D4D61702E736574286974656D2C206974656D56616C7565293B0D0A2020202020202020617065782E64656275672E696E666F2860536176696E6720247B6974656D7D';
wwv_flow_api.g_varchar2_table(256) := '20776974682076616C756520247B6974656D56616C75657D60293B0D0A2020202020207D0D0A20202020293B0D0A202020206164632E636F6E74726F6C6C65722E73657450616765537461746528706167655374617465293B0D0A20207D3B202F2F2072';
wwv_flow_api.g_varchar2_table(257) := '656D656D626572506167654974656D5374617475730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20726566726573680D0A20202020202052656672657368657320616E206974656D2028726567696F6E2C2070616765206974656D20';
wwv_flow_api.g_varchar2_table(258) := '6574632E292E205472696767657273206170657872656672657368206576656E7420616E6420656E61626C6573207468652070616765206974656D2E0D0A0D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944206F';
wwv_flow_api.g_varchar2_table(259) := '66207468652070616765206974656D20746F20726566726573680D0A2020202A2F0D0A2020616374696F6E732E72656672657368203D2066756E6374696F6E2028704974656D49642C207056616C756529207B0D0A202020206966282428606469762324';
wwv_flow_api.g_varchar2_table(260) := '7B704974656D49647D2E6A732D617065782D726567696F6E60292E6C656E677468203E2030297B0D0A202020202020696620287056616C7565297B20202020202020200D0A202020202020202024286023247B704974656D49647D60290D0A2020202020';
wwv_flow_api.g_varchar2_table(261) := '2020202E6F6E6528435F415045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A20202020202020202020616374696F6E732E73656C656374456E74727928704974656D49642C207056616C75652C2074727565293B0D0A20';
wwv_flow_api.g_varchar2_table(262) := '202020202020207D293B0D0A2020202020207D0D0A202020202020617065782E726567696F6E28704974656D4964292E7265667265736828293B0D0A202020207D0D0A20202020656C73657B0D0A2020202020206164632E636F6E74726F6C6C65722E70';
wwv_flow_api.g_varchar2_table(263) := '617573654368616E67654576656E74447572696E675265667265736828704974656D49642C207056616C7565293B0D0A202020202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A202020202020617065782E6974656D287049';
wwv_flow_api.g_varchar2_table(264) := '74656D4964292E656E61626C6528293B0D0A202020202020617065782E6974656D28704974656D4964292E7265667265736828293B0D0A202020207D3B0D0A20207D3B202F2F20726566726573680D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374';
wwv_flow_api.g_varchar2_table(265) := '696F6E3A2072656672657368416E6453657456616C75650D0A20202020202052656672657368657320616E206974656D2028726567696F6E2C2070616765206974656D206574632E2920616E64207365747320746865206974656D2076616C7565206166';
wwv_flow_api.g_varchar2_table(266) := '74657277617264732E0D0A2020202020200D0A20202020202054686520666F6C6C6F77696E6720666C6F77206F6620616374696F6E73206172652074616B656E3A0D0A2020202020200D0A2020202020202D205065727369737420746865206163747561';
wwv_flow_api.g_varchar2_table(267) := '6C2076616C7565206F66207468652070616765206974656D0D0A2020202020202D2042696E64206F6E652074696D6520617065786166746572726566726573682068616E646C657220746F20736574207468652070616765206974656D2076616C756520';
wwv_flow_api.g_varchar2_table(268) := '746F20746865207065727369737465642076616C756520616674657220726566726573680D0A2020202020202D2054726967676572206170657872656672657368206576656E740D0A2020202020202D20656E61626C6520746865207061676520697465';
wwv_flow_api.g_varchar2_table(269) := '6D0D0A0D0A20202020506172616D65746572733A0D0A202020202020704974656D4964202D204944206F66207468652070616765206974656D20746F207265667265736820616E6420736574207468652076616C75650D0A2020202020207056616C7565';
wwv_flow_api.g_varchar2_table(270) := '202D204F7074696F6E616C2076616C75652E204966206E6F74207365742C206D6574686F64206C6F6F6B7320666F722061637475616C206974656D2076616C756520696E206361636865206F72206F6E20706167652E0D0A2020202A2F0D0A2020616374';
wwv_flow_api.g_varchar2_table(271) := '696F6E732E72656672657368416E6453657456616C7565203D2066756E6374696F6E2028704974656D49642C207056616C756529207B0D0A20202020766172206974656D56616C7565203D207056616C7565207C7C20617065782E6974656D2870497465';
wwv_flow_api.g_varchar2_table(272) := '6D4964292E67657456616C75652829207C7C206164632E636F6E74726F6C6C65722E66696E644974656D56616C756528704974656D4964293B0D0A0D0A202020206164632E636F6E74726F6C6C65722E70617573654368616E67654576656E7444757269';
wwv_flow_api.g_varchar2_table(273) := '6E675265667265736828704974656D49642C206974656D56616C7565293B0D0A20202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A20202020617065782E6974656D28704974656D4964292E656E61626C6528293B0D0A2020';
wwv_flow_api.g_varchar2_table(274) := '2020617065782E6974656D28704974656D4964292E7265667265736828293B0D0A20207D3B202F2F2072656672657368416E6453657456616C75650D0A0D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A2073656C656374456E7472790D0A';
wwv_flow_api.g_varchar2_table(275) := '2020202020204D6574686F6420746F2073656C65637420616E20656E74727920696E20616E2043522C2049522C204947206F7220545245452E200D0A202020202020466F7220495220616E642043522C206120646174612D696420617474726962757465';
wwv_flow_api.g_varchar2_table(276) := '206D7573742062652070726573656E7420746F2063726561746520612073656C656374696F6E207461726765742E0D0A0D0A20202020506172616D65746572733A0D0A20202020202070526567696F6E4964202D204944206F662074686520726567696F';
wwv_flow_api.g_varchar2_table(277) := '6E20746F2073656C65637420616E20656E74727920696E0D0A20202020202070456E7472794964202D204944206F662074686520656E74727920746F2073656C6563740D0A20202020202070536574466F637573202D2049662074727565746865207365';
wwv_flow_api.g_varchar2_table(278) := '6C656374656420726F772077696C6C2067657420666F6375730D0A202020202020704E6F696E666F726D202D204966207472756520746865207472656556696577236576656E743A73656C656374696F6E4368616E6765206576656E742077696C6C2062';
wwv_flow_api.g_varchar2_table(279) := '6520737570707265737365642E0D0A2020202A2F0D0A2020616374696F6E732E73656C656374456E747279203D2066756E6374696F6E2870526567696F6E49642C2070456E74727949642C2070536574466F6375732C20704E6F696E666F726D297B0D0A';
wwv_flow_api.g_varchar2_table(280) := '202020206C65742024726567696F6E3B0D0A202020206C657420656E7472793B0D0A20202020636F6E737420435F43525F53454C4543544F52203D2060237265706F72745F7461626C655F247B70526567696F6E49647D603B0D0A20202020636F6E7374';
wwv_flow_api.g_varchar2_table(281) := '20435F49525F53454C4543544F52203D206023247B70526567696F6E49647D5F6972603B0D0A20202020636F6E737420435F49475F53454C4543544F52203D206023247B70526567696F6E49647D5F6967603B0D0A20202020636F6E737420435F545245';
wwv_flow_api.g_varchar2_table(282) := '455F53454C4543544F52203D206023247B70526567696F6E49647D5F74726565603B0D0A20202020636F6E737420435F49525F46495253545F524F575F53454C4543544F52203D2027202E612D4952522D7461626C652074626F64792074723A6E74682D';
wwv_flow_api.g_varchar2_table(283) := '6368696C64283229273B0D0A20202020636F6E737420435F43525F46495253545F524F575F53454C4543544F52203D2027203E2074626F6479203E2074723A6E74682D6368696C64283129273B0D0A20202020636F6E737420247265706F727444617461';
wwv_flow_api.g_varchar2_table(284) := '4974656D203D20242860696E7075745B247B435F524547494F4E5F444154415F4954454D7D3D247B70526567696F6E49647D5D60293B0D0A202020200D0A20202020696628747970656F662070456E7472794964203D3D2027756E646566696E65642720';
wwv_flow_api.g_varchar2_table(285) := '7C7C2070456E7472794964203D3D202727297B0D0A20202020202069662028247265706F7274446174614974656D2E6C656E677468203E2030297B0D0A202020202020202070456E7472794964203D20617065782E6974656D28247265706F7274446174';
wwv_flow_api.g_varchar2_table(286) := '614974656D2E61747472282769642729292E67657456616C756528293B0D0A2020202020207D3B0D0A202020207D3B0D0A20202020636F6E737420435F444154415F49445F53454C4543544F52203D2060207370616E5B646174612D69643D27247B7045';
wwv_flow_api.g_varchar2_table(287) := '6E74727949647D275D603B0D0A0D0A2020202073776974636828676574526567696F6E547970652870526567696F6E496429297B0D0A2020202020206361736520435F524547494F4E5F43523A0D0A202020202020202069662870456E7472794964203D';
wwv_flow_api.g_varchar2_table(288) := '3D202727297B0D0A20202020202020202020656E747279203D202428435F43525F53454C4543544F52202B20435F43525F46495253545F524F575F53454C4543544F52293B0D0A20202020202020207D0D0A2020202020202020656C7365207B0D0A2020';
wwv_flow_api.g_varchar2_table(289) := '2020202020202020656E747279203D202428435F43525F53454C4543544F52202B20435F444154415F49445F53454C4543544F52292E706172656E742827746427292E706172656E742827747227293B0D0A20202020202020207D3B0D0A202020202020';
wwv_flow_api.g_varchar2_table(290) := '20206164632E72656E64657265722E686967686C69676874526F7728656E7472792C2070536574466F637573293B0D0A2020202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49473A0D0A2020202020202020247265';
wwv_flow_api.g_varchar2_table(291) := '67696F6E203D202428435F49475F53454C4543544F52293B0D0A202020202020202069662870456E7472794964203D3D202727297B0D0A2020202020202020202070456E7472794964203D2024726567696F6E2E66696E64282774626F64792074722729';
wwv_flow_api.g_varchar2_table(292) := '2E646174612827696427293B0D0A20202020202020207D3B0D0A2020202020202020656E747279203D2024726567696F6E0D0A202020202020202020202020202020202E696E7465726163746976654772696428276765745669657773272C2027677269';
wwv_flow_api.g_varchar2_table(293) := '6427290D0A202020202020202020202020202020202E6D6F64656C0D0A202020202020202020202020202020202E6765745265636F72642870456E7472794964293B0D0A2020202020202020696628656E747279297B0D0A202020202020202020202472';
wwv_flow_api.g_varchar2_table(294) := '6567696F6E2E696E74657261637469766547726964282773657453656C65637465645265636F726473272C20656E7472792C2070536574466F6375732C20704E6F696E666F726D293B0D0A20202020202020207D3B0D0A2020202020202020627265616B';
wwv_flow_api.g_varchar2_table(295) := '3B0D0A2020202020206361736520435F524547494F4E5F49523A0D0A202020202020202069662870456E7472794964203D3D202727297B0D0A20202020202020202020656E747279203D202428435F49525F53454C4543544F52202B20435F49525F4649';
wwv_flow_api.g_varchar2_table(296) := '5253545F524F575F53454C4543544F52293B0D0A2020202020202020202069662028247265706F7274446174614974656D2E6C656E677468203E2030297B0D0A20202020202020202020202070456E7472794964203D20656E7472792E66696E6428275B';
wwv_flow_api.g_varchar2_table(297) := '646174612D69645D27292E646174612827696427293B0D0A202020202020202020202020617065782E6974656D28247265706F7274446174614974656D2E61747472282769642729292E73657456616C75652870456E7472794964293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(298) := '20202020207D3B0D0A20202020202020207D0D0A2020202020202020656C7365207B0D0A20202020202020202020656E747279203D202428435F49525F53454C4543544F52202B20435F444154415F49445F53454C4543544F52292E706172656E742827';
wwv_flow_api.g_varchar2_table(299) := '746427292E706172656E742827747227293B0D0A20202020202020207D3B0D0A20202020202020206164632E72656E64657265722E686967686C69676874526F7728656E7472792C2070536574466F637573293B0D0A2020202020202020627265616B3B';
wwv_flow_api.g_varchar2_table(300) := '0D0A2020202020206361736520435F524547494F4E5F545245453A0D0A202020202020202024726567696F6E203D202428435F545245455F53454C4543544F52293B0D0A2020202020202020656E747279203D2024726567696F6E2E7472656556696577';
wwv_flow_api.g_varchar2_table(301) := '280D0A2020202020202020202020202020202020202766696E64272C0D0A2020202020202020202020202020202020207B276465707468273A202D312C0D0A20202020202020202020202020202020202020276D61746368273A2066756E6374696F6E28';
wwv_flow_api.g_varchar2_table(302) := '6E297B0D0A20202020202020202020202020202020202020202020202020202020202072657475726E206E2E6964203D3D3D2070456E74727949643B0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020';
wwv_flow_api.g_varchar2_table(303) := '20202020202020202020207D0D0A20202020202020202020202020202020293B0D0A202020202020202024726567696F6E2E74726565566965772827636F6C6C61707365416C6C27293B0D0A202020202020202024726567696F6E2E7472656556696577';
wwv_flow_api.g_varchar2_table(304) := '2827657870616E64272C20656E747279293B0D0A202020202020202024726567696F6E2E7472656556696577282773657453656C656374696F6E272C20656E7472792C2070536574466F6375732C20704E6F696E666F726D293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(305) := '627265616B3B0D0A202020207D0D0A20207D3B202F2F2073656C656374456E7472790D0A0D0A0D0A20202F2A2A200D0A2020202046756E6374696F6E3A2073657441706578416374696F6E4163636573734B65790D0A2020202020204D6574686F64206D';
wwv_flow_api.g_varchar2_table(306) := '616B657320616E204150455820616374696F6E2073686F72746375742076697369626C6520627920616464696E6720612043535320636C6173732061726F756E642074686520616363657373206B6579206C65747465722E2020202020200D0A20202020';
wwv_flow_api.g_varchar2_table(307) := '202054686973206D6574686F642066696E647320746865206669727374206C65747465722074686174206D617463686573207468652073686F7274637574206B657920616E6420737572726F756E647320697420776974682061207370616E20656C656D';
wwv_flow_api.g_varchar2_table(308) := '656E7420616E6420612043535320636C6173732E0D0A2020202020200D0A202020202020494D504F5254414E543A2054686973206D6574686F64206F6E6C7920737570706F7274732073696D706C652073686F727463757473206C696B65203C416C742D';
wwv_flow_api.g_varchar2_table(309) := '543E210D0A0D0A20202020506172616D7465723A0D0A20202020202070416374696F6E202D204E616D65206F6620746865204150455820616374696F6E206F6E2074686520706167650D0A2020202A2F0D0A2020616374696F6E732E7365744170657841';
wwv_flow_api.g_varchar2_table(310) := '6374696F6E4163636573734B6579203D2066756E6374696F6E202870416374696F6E297B0D0A20202020636F6E737420435F53484F52544355545F434C415353203D20276163636573736B6579273B0D0A20202020636F6E737420435F444154415F5348';
wwv_flow_api.g_varchar2_table(311) := '4F52544355545F434C415353203D2027646174612D6163636573736B6579273B0D0A20202020636F6E737420435F425554544F4E5F4C4142454C5F434C415353203D2027742D427574746F6E2D6C6162656C273B0D0A0D0A202020207661722072653B0D';
wwv_flow_api.g_varchar2_table(312) := '0A202020207661722024746869733B0D0A2020202076617220246C6162656C203D2024746869732E66696E6428602E247B435F425554544F4E5F4C4142454C5F434C4153537D60293B0D0A20202020766172206C6162656C203D20246C6162656C2E6874';
wwv_flow_api.g_varchar2_table(313) := '6D6C28293B0D0A202020207661722073686F7274637574203D2072652E65786563286C6162656C293B0D0A0D0A202020207661722024627574746F6E73203D202428605B646174612D616374696F6E3D27247B70416374696F6E7D275D60293B0D0A2020';
wwv_flow_api.g_varchar2_table(314) := '2020766172206163636573736B6579203D20617065782E616374696F6E732E6C6F6F6B75702870416374696F6E292E73686F72746375743B0D0A0D0A202020206966286163636573736B657920213D3D20272729207B0D0A202020202020616363657373';
wwv_flow_api.g_varchar2_table(315) := '6B6579203D206163636573736B65792E736C696365282D31293B0D0A202020207D0D0A202020206966286163636573736B65792E6C656E677468203E2030297B0D0A2020202020207265203D206E657720526567457870286163636573736B65792C2027';
wwv_flow_api.g_varchar2_table(316) := '6927293B0D0A20202020202024627574746F6E732E656163682866756E6374696F6E28297B0D0A20202020202020202474686973203D20242874686973293B0D0A0D0A20202020202020206966282124746869732E66696E6428602E247B435F42555454';
wwv_flow_api.g_varchar2_table(317) := '4F4E5F4C4142454C5F434C4153537D60295B305D297B0D0A2020202020202020202024746869732E68746D6C28603C7370616E20636C6173733D27247B435F425554544F4E5F4C4142454C5F434C4153537D273E247B24746869732E68746D6C28297D3E';
wwv_flow_api.g_varchar2_table(318) := '7370616E3E60293B0D0A20202020202020207D0D0A0D0A2020202020202020246C6162656C2E68746D6C280D0A2020202020202020202020206C6162656C2E7265706C6163652872652C0D0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(319) := '2020603C7370616E20636C6173733D27247B435F53484F52544355545F434C4153537D273E247B73686F72746375747D3E7370616E3E6029293B0D0A0D0A202020202020202024746869732E6174747228276163636573736B6579272C2073686F727463';
wwv_flow_api.g_varchar2_table(320) := '7574293B0D0A202020202020202024746869732E617474722827646174612D6163636573736B6579272C206C6162656C2E73656172636828726529293B0D0A2020202020207D293B0D0A202020207D0D0A20207D3B202F2F207365744170657841637469';
wwv_flow_api.g_varchar2_table(321) := '6F6E4163636573734B65790D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20736574446973706C617953746174650D0A2020202020205365747320746869732076697369626C652061737065637473206F662061207061676520697465';
wwv_flow_api.g_varchar2_table(322) := '6D732E0D0A0D0A20202020506172616D65746572733A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F72206F6620746865206974656D7320746861742073686F756C642062652073686F776E0D0A20202020202070';
wwv_flow_api.g_varchar2_table(323) := '56697369626C655374617465202D204F6E65206F662074686520636F6E7374616E74732048494445207C2053484F575F44495341424C45207C2053484F575F454E41424C450D0A202020202020704C6162656C202D204966207365742C20636F6E74726F';
wwv_flow_api.g_varchar2_table(324) := '6C7320746865206C6162656C206F66207468652070616765206974656D730D0A2020202A2F0D0A2020616374696F6E732E736574446973706C61795374617465203D2066756E6374696F6E20287053656C6563746F722C207056697369626C6553746174';
wwv_flow_api.g_varchar2_table(325) := '652C20704C6162656C29207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427293B0D0A20202020202063';
wwv_flow_api.g_varchar2_table(326) := '6F6E737420435F48494445203D202748494445273B0D0A202020202020636F6E737420435F53484F575F44495341424C45203D202753484F575F44495341424C45273B0D0A202020202020636F6E737420435F53484F575F454E41424C45203D20275348';
wwv_flow_api.g_varchar2_table(327) := '4F575F454E41424C45273B0D0A2020202020200D0A202020202020737769746368287056697369626C655374617465297B0D0A20202020202020206361736520435F484944453A0D0A20202020202020202020617065782E6974656D28704974656D4964';
wwv_flow_api.g_varchar2_table(328) := '292E6869646528293B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F53484F575F44495341424C453A0D0A20202020202020202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A202020';
wwv_flow_api.g_varchar2_table(329) := '202020202020206164632E72656E64657265722E64697361626C65456C656D656E7428704974656D4964293B0D0A202020202020202020202F2F204265736964652064697361626C696E6720746865206974656D2C20616C6C206576656E74732066726F';
wwv_flow_api.g_varchar2_table(330) := '6D20746865207175657565206D7573742062652072656D6F7665640D0A202020202020202020202F2F20746F20617373757265207468617420612064697361626C656420627574746F6E2063616E206E6F74207261697365206120636C69636B20657665';
wwv_flow_api.g_varchar2_table(331) := '6E740D0A202020202020202020202428435F424F4459292E636C656172517565756528293B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F53484F575F454E41424C453A0D0A2020202020202020202061706578';
wwv_flow_api.g_varchar2_table(332) := '2E6974656D28704974656D4964292E73686F7728293B0D0A202020202020202020206164632E72656E64657265722E656E61626C65456C656D656E7428704974656D4964293B0D0A20202020202020202020627265616B3B0D0A20202020202020206465';
wwv_flow_api.g_varchar2_table(333) := '6661756C743A0D0A20202020202020202020617065782E64656275672E696E666F286056697375616C20537461746520247B7056697369626C6553746174657D206E6F7420737570706F7274656460293B0D0A2020202020207D0D0A0D0A202020202020';
wwv_flow_api.g_varchar2_table(334) := '696628704C6162656C297B0D0A20202020202020206164632E72656E64657265722E7365744974656D4C6162656C28704974656D49642C20704C6162656C293B0D0A2020202020207D0D0A202020207D293B0D0A20207D3B202F2F20736574446973706C';
wwv_flow_api.g_varchar2_table(335) := '617953746174650D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E207365744572726F72730D0A20202020202053686F777320616E206572726F72206D657373616765206F6E207468652073637265656E2E0D0A2020202020200D0A202020';
wwv_flow_api.g_varchar2_table(336) := '202020416E206572726F7220646F6573206E6F74206E65636573736172696C7920696E6469636174652061206D69736265686176696F7572206F6620414443206275742069732061206E6F726D616C20726573706F6E73652066692E207768656E206120';
wwv_flow_api.g_varchar2_table(337) := '76616C69646174696F6E206661696C732E0D0A20202020202054686973206D6574686F642077696C6C20636C65617220746865206576656E7420717565756520696620616E206572726F722069732070617373656420696E2E20526561736F6E696E6720';
wwv_flow_api.g_varchar2_table(338) := '626568696E6420746869732069733A0D0A202020202020496620612076616C756520697320656E746572656420696E20616E20696E707574206669656C642062757420746865206669656C64206973206E6F74206C656674207573696E67206120746162';
wwv_flow_api.g_varchar2_table(339) := '206B6579206F722061206D6F75736520636C69636B2C2062757420696E737465616420796F7520636C69636B206F6E206120627574746F6E0D0A2020202020207768696C652074686520666F637573206973207374696C6C20696E2074686520696E7075';
wwv_flow_api.g_varchar2_table(340) := '74206669656C642C2074776F206576656E74732077696C6C206265207261697365643A203C6368616E67653E206F6E2074686520696E707574206669656C6420616E64203C636C69636B3E206F6E2074686520627574746F6E2E0D0A0D0A202020202020';
wwv_flow_api.g_varchar2_table(341) := '4E6F772C20414443206D61792076616C69646174652074686520696E707574206669656C6420616E6420746865203C636C69636B3E206576656E742073686F756C64206F6E6C792062652070726F636573736564206966207468652076616C6964617469';
wwv_flow_api.g_varchar2_table(342) := '6F6E207061737365732E0D0A202020202020417320626F7468206576656E747320617265207261697365642028616C6D6F73742920636F6E63757272656E746C7920616E642068616E646C6564206173796E6368726F6E6F75736C792C20746865726520';
wwv_flow_api.g_varchar2_table(343) := '6973206E6F20706F73736962696C69747920666F7220414443200D0A202020202020746F2070726576656E7420746865203C636C69636B3E206576656E742066726F6D2068617070656E696E672E0D0A0D0A202020202020546F20636174657220666F72';
wwv_flow_api.g_varchar2_table(344) := '20746869732C20736F6D65206576656E747320286C696B6520636C69636B206F7220656E7465722920617265207175657565642077697468696E2041444320616E64207468657265666F72652073657269616C697A65642E205573696E67207468697320';
wwv_flow_api.g_varchar2_table(345) := '746563686E697175652C0D0A202020202020746865203C636C69636B3E206576656E742063616E206265207375727072657373656420627920636C656172696E67207468652071756575652E0D0A2020202A2F0D0A2020616374696F6E732E7365744572';
wwv_flow_api.g_varchar2_table(346) := '726F7273203D2066756E6374696F6E2028704572726F724C69737429207B0D0A202020200D0A2020202069662028704572726F724C697374297B0D0A2020202020202F2F204966206572726F72732068617665206F6363757265642C206E6F2066757274';
wwv_flow_api.g_varchar2_table(347) := '686572206576656E7473206D7573742062652070726F6365737365642E0D0A20202020202069662028704572726F724C6973742E6572726F72732E6C656E677468203E203029207B0D0A20202020202020202428435F424F4459292E636C656172517565';
wwv_flow_api.g_varchar2_table(348) := '756528293B0D0A2020202020207D0D0A2020202020202F2F2052656D6F7665206572726F727320616E64207761726E696E677320666F7220616C6C20746F7563686564206974656D732066726F6D206F757220674572726F727320636F70790D0A202020';
wwv_flow_api.g_varchar2_table(349) := '202020242E6561636828704572726F724C6973742E666972696E674974656D732C2066756E6374696F6E28696E6465782C20704974656D4964297B0D0A20202020202020202F2F2072656D6F766520746865206572726F722066726F6D20674572726F72';
wwv_flow_api.g_varchar2_table(350) := '730D0A2020202020202020674572726F7273203D20242E6772657028674572726F72732C2066756E6374696F6E2865297B0D0A2020202020202020202072657475726E20652E706167654974656D20213D20704974656D496420262620652E7061676549';
wwv_flow_api.g_varchar2_table(351) := '74656D20213D20435F444F43554D454E543B0D0A20202020202020207D293B0D0A2020202020207D293B0D0A202020200D0A2020202020202F2F20416464206E6577206572726F727320746F206F757220674572726F727320636F70790D0A2020202020';
wwv_flow_api.g_varchar2_table(352) := '20666F7220286C65742069203D20303B2069203C20704572726F724C6973742E6572726F72732E6C656E6774683B20692B2B297B0D0A2020202020202020636F6E737420657272203D20704572726F724C6973742E6572726F72735B695D0D0A20202020';
wwv_flow_api.g_varchar2_table(353) := '20202020674572726F72732E7075736828657272293B0D0A2020202020207D3B0D0A202020207D0D0A20202020656C73657B0D0A2020202020202F2F204E6F206572726F72206F626A6563742070617373656420696E2C2072656D6F766520616C6C2065';
wwv_flow_api.g_varchar2_table(354) := '72726F72730D0A202020202020674572726F7273203D205B5D3B0D0A202020207D0D0A202020200D0A202020206164632E72656E64657265722E73686F774572726F727328674572726F7273293B0D0A20207D3B202F2F207365744572726F72730D0A0D';
wwv_flow_api.g_varchar2_table(355) := '0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744974656D56616C7565730D0A20202020202057726170706572203C61726F756E6420617065782E6974656D28292E73657456616C756528293E207468617420616C6C6F777320746F20';
wwv_flow_api.g_varchar2_table(356) := '736574207468652073616D652076616C756520746F206D616E79206974656D73207573696E672061206A51756572792073656C6563746F722E0D0A202020202020497420616C736F20737572707265737365732061206368616E6765206576656E742077';
wwv_flow_api.g_varchar2_table(357) := '68656E2073657474696E67207468652076616C75657320746F2061766F696420414443206C6F6F70732E0D0A0D0A20202020506172616D65746572733A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F7220746F20';
wwv_flow_api.g_varchar2_table(358) := '6964656E74696679207468652070616765206974656D7320746F20736574207468652076616C75650D0A2020202020207056616C7565202D2056616C7565206F66207468652070616765206974656D0D0A2020202A2F0D0A2020616374696F6E732E7365';
wwv_flow_api.g_varchar2_table(359) := '744974656D56616C7565203D2066756E6374696F6E20287053656C6563746F722C207056616C756529207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964';
wwv_flow_api.g_varchar2_table(360) := '203D20242874686973292E617474722827696427293B0D0A202020202020617065782E6974656D28704974656D4964292E73657456616C7565287056616C75652C207056616C75652C2074727565293B0D0A202020207D293B0D0A20207D3B202F2F2073';
wwv_flow_api.g_varchar2_table(361) := '65744974656D56616C75650D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744974656D56616C7565730D0A20202020202054616B657320616E206F626A65637420776974682070616765206974656D7320616E64207468656972';
wwv_flow_api.g_varchar2_table(362) := '2061637475616C2076616C75652061732073746F72656420696E207468652073657373696F6E20737461746520616E64206861726D6F6E697A6573207468656D20776974682074686520706167652E0D0A0D0A20202020506172616D657465723A0D0A20';
wwv_flow_api.g_varchar2_table(363) := '202020202070506167654974656D73202D204172726179206F66206F626A65637473206F662074686520666F726D203C7B276964273A27706167654974656D4944272C2776616C7565273A276974656D56616C7565277D3E2E0D0A2020202A2F0D0A2020';
wwv_flow_api.g_varchar2_table(364) := '616374696F6E732E7365744974656D56616C756573203D2066756E6374696F6E202870506167654974656D7329207B0D0A202020202F2F2053746F726520746865206F626A65637420666F72206C61746572207265666572656E6365206279206173796E';
wwv_flow_api.g_varchar2_table(365) := '6368726F6E6F75732063616C6C730D0A202020206164632E636F6E74726F6C6C65722E7365744C6173744974656D56616C7565732870506167654974656D73293B0D0A0D0A202020202F2F206861726D6F6E697A65207468652073657373696F6E207374';
wwv_flow_api.g_varchar2_table(366) := '6174652077697468207468652070616765206974656D730D0A20202020242E656163682870506167654974656D732C2066756E6374696F6E202829207B0D0A2020202020206966202828746869732E76616C7565207C7C2027464F4F272920213D3D2028';
wwv_flow_api.g_varchar2_table(367) := '617065782E6974656D28746869732E6964292E67657456616C75652829207C7C2027464F4F272929207B0D0A20202020202020202F2F20746869726420617474726962757465207375727072657373657320746865206368616E6765206576656E742069';
wwv_flow_api.g_varchar2_table(368) := '662073657420746F20747275650D0A2020202020202020617065782E6974656D28746869732E6964292E73657456616C756528746869732E76616C75652C20746869732E76616C75652C2074727565293B0D0A2020202020202020617065782E64656275';
wwv_flow_api.g_varchar2_table(369) := '672E696E666F28604974656D2027247B746869732E69647D272073657420746F2027247B746869732E76616C75657D2760293B0D0A2020202020207D0D0A202020207D293B0D0A20207D3B202F2F207365744974656D56616C7565730D0A0D0A0D0A2020';
wwv_flow_api.g_varchar2_table(370) := '2F2A2A0D0A2020202046756E6374696F6E3A207365744D616E6461746F72790D0A20202020202052656E646572732061206669656C64206173206D616E6461746F7279206F72206F7074696F6E616C2C206261736564206F6E20706172616D6574657220';
wwv_flow_api.g_varchar2_table(371) := '3C7049734D616E6461746F72793E2E0D0A2020202020200D0A20202020202053657474696E6720616E206974656D206D616E6461746F727920697320612074776F20737465702070726F636573732E200D0A2020202020200D0A2020202020202D204144';
wwv_flow_api.g_varchar2_table(372) := '43207265677369746572732061206368616E67652068616E646C657220616E64206F627365727665732069742C206966206E6F742079657420646F6E650D0A2020202020202D20746865207061676520726570726573656E746174696F6E206D75737420';
wwv_flow_api.g_varchar2_table(373) := '6265206368616E67656420746F20726570726573656E7420746865207374617475732E0D0A2020202020200D0A20202020506172616D65746572733A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F72206F662074';
wwv_flow_api.g_varchar2_table(374) := '6865206974656D7320746861742073686F756C642062652073657420746F206D616E6461746F72790D0A2020202020207049734D616E6461746F7279202D20466C616720746F20696E646963617465207768657468657220746865206974656D73206172';
wwv_flow_api.g_varchar2_table(375) := '65206D616E6461746F727920285452554529206F7220206E6F74202846414C5345290D0A2020202A2F0D0A2020616374696F6E732E7365744D616E6461746F7279203D2066756E6374696F6E20287053656C6563746F722C207049734D616E6461746F72';
wwv_flow_api.g_varchar2_table(376) := '7929207B0D0A20202020666F7245616368287053656C6563746F722C2066756E6374696F6E202829207B0D0A20202020202076617220704974656D4964203D20242874686973292E617474722827696427292E7265706C61636528275F434F4E5441494E';
wwv_flow_api.g_varchar2_table(377) := '4552272C202727293B0D0A202020202020696620287049734D616E6461746F727929207B0D0A20202020202020206164632E636F6E74726F6C6C65722E70757368506167654974656D28704974656D4964290D0A2020202020207D0D0A20202020202061';
wwv_flow_api.g_varchar2_table(378) := '64632E72656E64657265722E656E61626C65456C656D656E7428704974656D4964293B0D0A2020202020206164632E72656E64657265722E7365744974656D4D616E6461746F727928704974656D49642C207049734D616E6461746F7279293B0D0A2020';
wwv_flow_api.g_varchar2_table(379) := '20207D293B0D0A20207D3B202F2F207365744D616E6461746F72790D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744D6F64616C4469616C6F675469746C650D0A2020202020205365747320746865207469746C65206F66';
wwv_flow_api.g_varchar2_table(380) := '2061206D6F64616C206469616C6F672077696E646F772E0D0A0D0A20202020506172616D657465723A0D0A202020202020705469746C65202D205469746C65206F6620746865206D6F64616C2077696E646F770D0A2020202A2F0D0A2020616374696F6E';
wwv_flow_api.g_varchar2_table(381) := '732E7365744D6F64616C4469616C6F675469746C65203D2066756E6374696F6E28705469746C65297B0D0A202020206164632E72656E64657265722E7365744D6F64616C4469616C6F675469746C6528705469746C65293B0D0A20207D3B202F2F207365';
wwv_flow_api.g_varchar2_table(382) := '744D6F64616C4469616C6F675469746C650D0A20200D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20736574526567696F6E436F6E74656E740D0A2020202020204D6574686F6420746F20736574207468652061637475616C20726567';
wwv_flow_api.g_varchar2_table(383) := '696F6E20636F6E74656E74206F6620612073746174696320726567696F6E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020202070526567696F6E4964202D204944206F662074686520726567696F6E0D0A20202020202070';
wwv_flow_api.g_varchar2_table(384) := '436F6E74656E74202D2048544D4C20636F6E74656E74206F662074686520726567696F6E0D0A2020202A2F0D0A2020616374696F6E732E736574526567696F6E436F6E74656E74203D2066756E6374696F6E2870526567696F6E49642C2070436F6E7465';
wwv_flow_api.g_varchar2_table(385) := '6E74297B0D0A202020206164632E72656E64657265722E736574526567696F6E436F6E74656E742870526567696F6E49642C2070436F6E74656E74293B0D0A20207D3B202F2F20736574526567696F6E436F6E74656E740D0A20200D0A20200D0A20202F';
wwv_flow_api.g_varchar2_table(386) := '2A2A0D0A2020202046756E6374696F6E3A20736574526567696F6E4865616465720D0A2020202020204D6574686F6420746F2061646A7573742074686520726567696F6E206865616465722E20576F726B732077697468206E6F726D616C20726567696F';
wwv_flow_api.g_varchar2_table(387) := '6E7320616E642074616220726567696F6E732E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020202070526567696F6E4964202D204944206F662074686520726567696F6E0D0A20202020202070486561646572202D204865';
wwv_flow_api.g_varchar2_table(388) := '61646572206F662074686520726567696F6E0D0A2020202A2F0D0A2020616374696F6E732E736574526567696F6E486561646572203D2066756E6374696F6E2870526567696F6E49642C2070486561646572297B0D0A202020206164632E72656E646572';
wwv_flow_api.g_varchar2_table(389) := '65722E736574526567696F6E4865616465722870526567696F6E49642C20704865616465722C20676574526567696F6E547970652870526567696F6E496429293B0D0A20207D3B202F2F20736574526567696F6E4865616465720D0A0D0A20202F2A0D0A';
wwv_flow_api.g_varchar2_table(390) := '2020202046756E6374696F6E3A2073656C6563745461620D0A2020202020204D6574686F6420746F2073656C65637420616E6420616374697661746520612074616220696E206120746162756C61746F7220726567696F6E0D0A0D0A2020202050617261';
wwv_flow_api.g_varchar2_table(391) := '6D65746572733A0D0A20202020202070546162526567696F6E4964202D204944206F662074686520746162756C61746F7220726567696F6E0D0A202020202020705461624964202D204944206F66207468652074616220746F2061637469766174650D0A';
wwv_flow_api.g_varchar2_table(392) := '2020202A2F0D0A2020616374696F6E732E73656C656374546162203D2066756E6374696F6E2870546162526567696F6E49642C20705461624964297B0D0A20202020617065782E726567696F6E2870546162526567696F6E4964292E7769646765742829';
wwv_flow_api.g_varchar2_table(393) := '2E615461627328276765745461627327295B6023247B7054616249647D605D2E6D616B6541637469766528293B0D0A20207D3B202F2F2073656C6563745461620D0A0D0A0D0A20202F2A2A2053686F7773206F7220686964657320612077616974696E67';
wwv_flow_api.g_varchar2_table(394) := '207370696E6E65720D0A2020202046756E6374696F6E3A2073686F77576169745370696E6E65720D0A202020202020446973706C617973206F722072656D6F76657320612077616974207370696E6E657220616E696D6174696F6E20666F72206C6F6E67';
wwv_flow_api.g_varchar2_table(395) := '2072756E6E696E67206F7065726174696F6E730D0A0D0A20202020506172616D657465723A0D0A20202020202070466C6167202D20466C616720746F20696E646963617465207768657468657220746F2073686F77202874727565292061207761697420';
wwv_flow_api.g_varchar2_table(396) := '7370696E6E6572206F72206E6F74202866616C7365290D0A2020202A2F0D0A2020616374696F6E732E73686F77576169745370696E6E6572203D2066756E6374696F6E2870466C6167297B0D0A202020206164632E72656E64657265722E73686F775761';
wwv_flow_api.g_varchar2_table(397) := '69745370696E6E65722870466C6167293B0D0A20207D3B202F2F2073686F77576169745370696E6E65720D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A207375626D69740D0A2020202020205375626D6974732074686520706167652E';
wwv_flow_api.g_varchar2_table(398) := '200D0A2020202020204966207468652070616765207374696C6C20636F6E7461696E7320756E736F6C766564206572726F72732C2074686520706167652077696C6C206E6F74206265207375626D69747465642C206275742061206469616C6F67206973';
wwv_flow_api.g_varchar2_table(399) := '2073686F776E20746F2074686520757365722E0D0A0D0A20202020506172616D65746572733A0D0A2020202020207052657175657374202D20524551554553542076616C756520746861742069732070617373656420746F20746865207365727665720D';
wwv_flow_api.g_varchar2_table(400) := '0A202020202020704D657373616765202D204D65737361676520746861742069732073686F776E20746F207468652075736572206966207468652070616765207374696C6C20636F6E7461696E7320756E736F6C766564206572726F72732E0D0A202020';
wwv_flow_api.g_varchar2_table(401) := '2A2F0D0A2020616374696F6E732E7375626D6974203D2066756E6374696F6E202870526571756573742C20704D65737361676529207B0D0A202020206164632E72656E64657265722E7375626D6974506167652870526571756573742C20704D65737361';
wwv_flow_api.g_varchar2_table(402) := '6765293B0D0A20207D3B202F2F207375626D69740D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B20454E442053595354454D20414354494F4E205459504553202B2B2B2B2B2B2B2B2B2B2B202A2F0D0A0D0A7D2864652E636F6E6465732E706C7567696E2E';
wwv_flow_api.g_varchar2_table(403) := '6164632C20617065782E6A517565727929293B0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740440293907785497)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/actions.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722064653D64657C7C7B7D3B64652E636F6E6465733D64652E636F6E6465737C7C7B7D2C64652E636F6E6465732E706C7567696E3D64652E636F6E6465732E706C7567696E7C7C7B7D2C64652E636F6E6465732E706C7567696E2E6164633D64652E';
wwv_flow_api.g_varchar2_table(2) := '636F6E6465732E706C7567696E2E6164637C7C7B7D2C66756E6374696F6E28652C74297B2275736520737472696374223B636F6E7374206E3D22626F6479222C723D2264652E636F6E6465732E706C7567696E2E6164632E616374696F6E732E6A73222C';
wwv_flow_api.g_varchar2_table(3) := '613D22436C61737369635265706F7274222C693D22496E7465726163746976655265706F7274222C6F3D22496E74657261637469766547726964222C733D2254726565222C633D22646174612D6974656D2D666F722D726567696F6E222C6C3D222E742D';
wwv_flow_api.g_varchar2_table(4) := '6668742D74626F6479202E612D4952522D7461626C65207472222C643D60247B6C7D3A6E74682D6368696C64283229602C673D22636C69636B222C753D226B6579646F776E222C683D2261706578616674657272656672657368222C663D226170657861';
wwv_flow_api.g_varchar2_table(5) := '6674657263616E63656C6469616C6F67222C703D22617065786166746572636C6F73656469616C6F67222C6D3D2275692D6469616C6F67222C623D222E75692D6469616C6F672D636F6E74656E74223B652E616374696F6E733D652E616374696F6E737C';
wwv_flow_api.g_varchar2_table(6) := '7C7B7D3B76617220783D652E616374696F6E732C763D5B5D3B636F6E737420243D66756E6374696F6E28652C6E297B742E697341727261792865297C7C652E736561726368282F5B5C2E235C75303032303A5C5B5C5D5D2B2F293E3D307C7C28653D6023';
wwv_flow_api.g_varchar2_table(7) := '247B657D60292C652E6D61746368282F6F6A2E2A2F29262628653D74286023247B657D60292E636C6F7365737428226469762E617065782D6974656D2D67726F757022292E61747472282269642229292C742865292E65616368286E297D2C523D66756E';
wwv_flow_api.g_varchar2_table(8) := '6374696F6E2865297B636F6E7374206E3D74286023247B657D60292C723D60237265706F72745F7461626C655F247B657D602C633D6023247B657D5F6972602C6C3D6023247B657D5F6967602C643D6023247B657D5F74726565602C673D602353525F24';
wwv_flow_api.g_varchar2_table(9) := '7B657D603B76617220753B72657475726E206E2E66696E64286C292E6C656E6774683E303F753D6F3A6E2E66696E642863292E6C656E6774683E303F753D693A6E2E66696E642872292E6C656E6774683E303F753D613A6E2E66696E642864292E6C656E';
wwv_flow_api.g_varchar2_table(10) := '6774683E303F753D733A6E2E706172656E742867292E6C656E6774683E30262628753D2254616222292C757D3B782E616C69676E5265706F7274566572746963616C546F703D66756E6374696F6E286E297B24286E2C2866756E6374696F6E28297B7661';
wwv_flow_api.g_varchar2_table(11) := '72206E3D742874686973292E617474722822696422293B652E72656E64657265722E616C69676E5265706F7274566572746963616C546F70286E297D29297D2C782E62696E64436F6E6669726D6174696F6E3D66756E6374696F6E286E2C722C612C6929';
wwv_flow_api.g_varchar2_table(12) := '7B766172206F3D74286023247B6E7D60293B6F2E6C656E6774683E302626652E636F6E74726F6C6C65722E62696E64436F6E6669726D6174696F6E48616E646C6572286F2C722C612C69297D2C782E62696E64556E73617665645761726E696E673D6675';
wwv_flow_api.g_varchar2_table(13) := '6E6374696F6E286E2C722C61297B76617220693D74286023247B6E7D60293B692E6C656E6774683E302626652E636F6E74726F6C6C65722E62696E64556E7361766564436F6E6669726D6174696F6E48616E646C657228692C722C61297D2C782E63616E';
wwv_flow_api.g_varchar2_table(14) := '63656C4D6F64616C4469616C6F673D66756E6374696F6E28742C6E297B636F6E737420723D66756E6374696F6E2865297B766F69642030213D3D6526262222213D653F706172656E742E24282223222B65292E747269676765722866293A22223D3D653F';
wwv_flow_api.g_varchar2_table(15) := '28653D706172656E742E242862292E64617461286D292E6F70656E65722E617474722822696422292C706172656E742E242862292E64617461286D292E6F70656E65722E74726967676572286629293A28653D706172656E742E74726967676572696E67';
wwv_flow_api.g_varchar2_table(16) := '456C656D656E742E69642C706172656E742E24282223222B65292E74726967676572286629292C617065782E64656275672E696E666F282263616E63656C4D6F64616C4469616C6F67202D2074726967676572696E67456C656D656E743A222B65292C61';
wwv_flow_api.g_varchar2_table(17) := '7065782E6E617669676174696F6E2E6469616C6F672E63616E63656C282130297D3B6E2626652E636F6E74726F6C6C65722E686173556E73617665644368616E67657328293F617065782E6D6573736167652E636F6E6669726D28652E636F6E74726F6C';
wwv_flow_api.g_varchar2_table(18) := '6C65722E6765745374616E646172644D657373616765282243534D5F43414E43454C5F4841535F4348414E47455322292C2866756E6374696F6E2865297B652626722874297D29293A722874297D2C782E636C6F73654D6F64616C4469616C6F673D6675';
wwv_flow_api.g_varchar2_table(19) := '6E6374696F6E28742C6E2C72297B636F6E737420613D66756E6374696F6E28652C74297B766F69642030213D3D6526262222213D653F706172656E742E24282223222B65292E747269676765722870293A766F696420303D3D3D657C7C22223D3D653F28';
wwv_flow_api.g_varchar2_table(20) := '653D706172656E742E242862292E64617461286D292E6F70656E65722E617474722822696422292C706172656E742E242862292E64617461286D292E6F70656E65722E74726967676572287029293A28653D706172656E742E74726967676572696E6745';
wwv_flow_api.g_varchar2_table(21) := '6C656D656E742E69642C706172656E742E24282223222B65292E74726967676572287029292C617065782E64656275672E696E666F2822636C6F73654D6F64616C4469616C6F67202D2074726967676572696E67456C656D656E743A222B65292C617065';
wwv_flow_api.g_varchar2_table(22) := '782E6E617669676174696F6E2E6469616C6F672E636C6F73652821302C74297D3B72262621652E636F6E74726F6C6C65722E686173556E73617665644368616E67657328293F617065782E6D6573736167652E616C65727428652E636F6E74726F6C6C65';
wwv_flow_api.g_varchar2_table(23) := '722E6765745374616E646172644D657373616765282243534D5F434C4F53455F574F5F4348414E47455322292C2866756E6374696F6E28652C74297B6128652C74297D29293A6128742C6E297D2C782E636F6E6669726D436F6D6D616E643D66756E6374';
wwv_flow_api.g_varchar2_table(24) := '696F6E28742C6E297B652E72656E64657265722E636F6E6669726D5265717565737428742C2866756E6374696F6E28297B782E65786563757465436F6D6D616E64286E297D29297D2C782E636F6E6669726D526571756573743D66756E6374696F6E2874';
wwv_flow_api.g_varchar2_table(25) := '2C6E297B652E72656E64657265722E636F6E6669726D5265717565737428742C6E297D2C782E65786563757465436F6D6D616E643D66756E6374696F6E2874297B766172206E2C723D7B7D3B69662822737472696E67223D3D747970656F6620743F6E3D';
wwv_flow_api.g_varchar2_table(26) := '7B636F6D6D616E643A742C6164646974696F6E616C506167654974656D733A5B5D2C6D6F6E69746F724368616E6765733A21317D3A28286E3D74292E6164646974696F6E616C506167654974656D733D6E2E6164646974696F6E616C506167654974656D';
wwv_flow_api.g_varchar2_table(27) := '737C7C5B5D2C6E2E6D6F6E69746F724368616E6765733D6E2E6D6F6E69746F724368616E6765737C7C2131292C652E636F6E74726F6C6C65722E73657454726967676572696E67456C656D656E742822434F4D4D414E44222C22636F6D6D616E64222C6E';
wwv_flow_api.g_varchar2_table(28) := '292C742E6D6F6E69746F724368616E6765732626652E636F6E74726F6C6C65722E686173556E73617665644368616E6765732829297B76617220613D652E636F6E74726F6C6C65722E67657450616765537461746528293B722E646174613D742C722E64';
wwv_flow_api.g_varchar2_table(29) := '6174612E6D6573736167653D612E6D6573736167652C722E646174612E7469746C653D612E7469746C652C652E72656E64657265722E636F6E6669726D5265717565737428722C652E636F6E74726F6C6C65722E65786563757465297D656C736520652E';
wwv_flow_api.g_varchar2_table(30) := '636F6E74726F6C6C65722E6578656375746528297D2C782E666F6375733D66756E6374696F6E2865297B74286023247B657D60292E666F63757328297D2C782E6765745265706F727453656C656374696F6E3D66756E6374696F6E286E2C662C702C6D29';
wwv_flow_api.g_varchar2_table(31) := '7B636F6E737420623D74286023247B6E7D60292C763D52286E293B6C657420242C773B73776974636828663F28243D66756E6374696F6E2865297B617065782E6974656D2866292E73657456616C75652865297D2C74286023247B667D60292E61747472';
wwv_flow_api.g_varchar2_table(32) := '28632C6E292C652E636F6E74726F6C6C65722E62696E644F627365727665724974656D73286629293A243D66756E6374696F6E2874297B652E636F6E74726F6C6C65722E73657454726967676572696E67456C656D656E74286E2C2261646373656C6563';
wwv_flow_api.g_varchar2_table(33) := '74696F6E6368616E6765222C74292C652E636F6E74726F6C6C65722E6578656375746528297D2C76297B6361736520613A622E6F6E28672C222E742D5265706F72742D7265706F72742074626F6479207472222C2866756E6374696F6E28297B773D7428';
wwv_flow_api.g_varchar2_table(34) := '74686973292E66696E6428227464205B646174612D69645D22292E646174612822696422292C652E72656E64657265722E686967686C69676874526F7728742874686973292C6D292C242877297D29293B627265616B3B63617365206F3A622E6F6E2822';
wwv_flow_api.g_varchar2_table(35) := '696E7465726163746976656772696473656C656374696F6E6368616E6765222C2866756E6374696F6E28652C74297B742E73656C65637465645265636F7264732E6C656E677468262628773D703F742E73656C65637465645265636F7264735B305D5B4D';
wwv_flow_api.g_varchar2_table(36) := '6174682E6D617828702D312C30295D3A742E6D6F64656C2E6765745265636F7264496428742E73656C65637465645265636F7264735B305D292C24287729297D29293B627265616B3B6361736520693A622E6F6E28672C222E612D4952522D7461626C65';
wwv_flow_api.g_varchar2_table(37) := '2074723A6E6F74283A66697273742D6368696C6429222C2866756E6374696F6E28297B773D742874686973292E66696E6428227464205B646174612D69645D22292E646174612822696422292C782E73656C656374456E747279286E2C772C21302C2131';
wwv_flow_api.g_varchar2_table(38) := '292C242877297D29292E6F6E28752C6C2C2866756E6374696F6E2865297B696628393D3D3D652E7768696368262621313D3D3D652E73686966744B6579297B696628742874686973292E6E65787428292E636C69636B28292C21742874686973292E6973';
wwv_flow_api.g_varchar2_table(39) := '28223A6C6173742D6368696C6422292972657475726E21313B617065782E64656275672E696E666F2860247B727D202D20746162206B65792066726F6D206C61737420726F77206C656176657320495260297D656C736520696628393D3D3D652E776869';
wwv_flow_api.g_varchar2_table(40) := '6368262621303D3D3D652E73686966744B6579297B696628742874686973292E7072657628292E636C69636B28292C21742874686973292E697328223A6E74682D6368696C6428322922292972657475726E21313B617065782E64656275672E696E666F';
wwv_flow_api.g_varchar2_table(41) := '2860247B727D202D20746162206B6579206261636B77617264732066726F6D20666972737420726F77206C656176657320495260297D7D29292E6F6E28752C222E742D6668742D7468656164202E612D4952522D7461626C652074682E612D4952522D68';
wwv_flow_api.g_varchar2_table(42) := '656164657220613A6C617374222C2866756E6374696F6E2865297B696628617065782E64656275672E696E666F2860247B727D202D20746162206B65792066726F6D206C6173742068656164657220726F7720656E7465727320495260292C393D3D3D65';
wwv_flow_api.g_varchar2_table(43) := '2E7768696368262621313D3D3D652E73686966744B65792972657475726E20742864292E636C69636B28292C21317D29292E6F6E28682C2866756E6374696F6E2865297B617065782E64656275672E6C6F672860247B727D202D20617065786166746572';
wwv_flow_api.g_varchar2_table(44) := '7265667265736820646574656374656460292C662626617065782E6974656D2866292E73657456616C756528292C782E73656C656374456E747279286E2C22222C6D2C2131297D29293B627265616B3B6361736520733A6C657420633D74286023247B6E';
wwv_flow_api.g_varchar2_table(45) := '7D5F7472656560293B632E6F6E2822747265657669657773656C656374696F6E6368616E6765222C2866756E6374696F6E28297B6C657420652C743B653D632E7472656556696577282267657453656C65637465644E6F64657322292C743D652E6D6170';
wwv_flow_api.g_varchar2_table(46) := '282866756E6374696F6E2865297B72657475726E20652E69647D29292E6A6F696E28223A22292C242874297D29297D782E73656C656374456E747279286E2C22222C6D2C2130297D2C782E686964655265706F727446696C74657250616E656C3D66756E';
wwv_flow_api.g_varchar2_table(47) := '6374696F6E286E297B24286E2C2866756E6374696F6E28297B766172206E3D742874686973292E617474722822696422293B652E72656E64657265722E686964655265706F727446696C74657250616E656C286E2C52286E29297D29297D2C782E6E6F74';
wwv_flow_api.g_varchar2_table(48) := '6966793D66756E6374696F6E28742C6E2C722C61297B652E72656E64657265722E73686F774469616C6F6728742C6E2C722C61297D2C782E636C6561724572726F72733D66756E6374696F6E28297B652E72656E64657265722E73686F774572726F7273';
wwv_flow_api.g_varchar2_table(49) := '285B5D297D2C782E636F6E6669726D3D66756E6374696F6E28742C6E2C72297B652E72656E64657265722E73686F774469616C6F6728742C6E2C722C2130297D2C782E73686F77537563636573733D66756E6374696F6E2874297B652E72656E64657265';
wwv_flow_api.g_varchar2_table(50) := '722E73686F77537563636573732874297D2C782E73686F774D6573736167653D66756E6374696F6E28742C6E2C72297B73776974636828722E6469616C6F6754797065297B63617365226469616C6F67223A652E72656E64657265722E73686F774D6573';
wwv_flow_api.g_varchar2_table(51) := '7361676528742C6E2C72293B627265616B3B636173652273756363657373223A652E72656E64657265722E73686F77537563636573732874297D7D2C782E686964654D6573736167653D66756E6374696F6E2874297B7377697463682874297B63617365';
wwv_flow_api.g_varchar2_table(52) := '2273756363657373223A652E72656E64657265722E636C6561724E6F74696669636174696F6E28293B627265616B3B63617365226572726F72223A652E72656E64657265722E636C6561724572726F727328293B627265616B3B6361736522626F746822';
wwv_flow_api.g_varchar2_table(53) := '3A652E72656E64657265722E636C6561724E6F74696669636174696F6E28292C652E72656E64657265722E636C6561724572726F727328297D7D2C782E7265676973746572506167654974656D734F6E63653D66756E6374696F6E2874297B652E636F6E';
wwv_flow_api.g_varchar2_table(54) := '74726F6C6C65722E7365744164646974696F6E616C4974656D732874297D2C782E72656D656D626572506167654974656D5374617475733D66756E6374696F6E286E2C722C61297B76617220692C6F2C733B28733D652E636F6E74726F6C6C65722E6765';
wwv_flow_api.g_varchar2_table(55) := '745061676553746174652829292E6974656D4D61702E636C65617228292C732E6D6573736167653D722C732E7469746C653D612C693D7428223A696E7075743A76697369626C653A6E6F7428627574746F6E2922292C41727261792E6973417272617928';
wwv_flow_api.g_varchar2_table(56) := '6E2926266E2E636F756E743E30262628693D6E292C742E6561636828692C2866756E6374696F6E2865297B28653D695B655D292E6964262628653D652E6964292C6F3D617065782E6974656D2865292E67657456616C756528292C732E6974656D4D6170';
wwv_flow_api.g_varchar2_table(57) := '2E73657428652C6F292C617065782E64656275672E696E666F2860536176696E6720247B657D20776974682076616C756520247B6F7D60297D29292C652E636F6E74726F6C6C65722E7365745061676553746174652873297D2C782E726566726573683D';
wwv_flow_api.g_varchar2_table(58) := '66756E6374696F6E286E2C72297B74286064697623247B6E7D2E6A732D617065782D726567696F6E60292E6C656E6774683E303F2872262674286023247B6E7D60292E6F6E6528682C2866756E6374696F6E2865297B782E73656C656374456E74727928';
wwv_flow_api.g_varchar2_table(59) := '6E2C722C2130297D29292C617065782E726567696F6E286E292E726566726573682829293A28652E636F6E74726F6C6C65722E70617573654368616E67654576656E74447572696E6752656672657368286E2C72292C617065782E6974656D286E292E73';
wwv_flow_api.g_varchar2_table(60) := '686F7728292C617065782E6974656D286E292E656E61626C6528292C617065782E6974656D286E292E726566726573682829297D2C782E72656672657368416E6453657456616C75653D66756E6374696F6E28742C6E297B76617220723D6E7C7C617065';
wwv_flow_api.g_varchar2_table(61) := '782E6974656D2874292E67657456616C756528297C7C652E636F6E74726F6C6C65722E66696E644974656D56616C75652874293B652E636F6E74726F6C6C65722E70617573654368616E67654576656E74447572696E675265667265736828742C72292C';
wwv_flow_api.g_varchar2_table(62) := '617065782E6974656D2874292E73686F7728292C617065782E6974656D2874292E656E61626C6528292C617065782E6974656D2874292E7265667265736828297D2C782E73656C656374456E7472793D66756E6374696F6E286E2C722C6C2C64297B6C65';
wwv_flow_api.g_varchar2_table(63) := '7420672C753B636F6E737420683D60237265706F72745F7461626C655F247B6E7D602C663D6023247B6E7D5F6972602C703D6023247B6E7D5F6967602C6D3D6023247B6E7D5F74726565602C623D742860696E7075745B247B637D3D247B6E7D5D60293B';
wwv_flow_api.g_varchar2_table(64) := '766F69642030213D3D7226262222213D727C7C622E6C656E6774683E30262628723D617065782E6974656D28622E61747472282269642229292E67657456616C75652829293B636F6E737420783D60207370616E5B646174612D69643D27247B727D275D';
wwv_flow_api.g_varchar2_table(65) := '603B7377697463682852286E29297B6361736520613A753D22223D3D723F7428682B22203E2074626F6479203E2074723A6E74682D6368696C6428312922293A7428682B78292E706172656E742822746422292E706172656E742822747222292C652E72';
wwv_flow_api.g_varchar2_table(66) := '656E64657265722E686967686C69676874526F7728752C6C293B627265616B3B63617365206F3A673D742870292C22223D3D72262628723D672E66696E64282274626F647920747222292E64617461282269642229292C753D672E696E74657261637469';
wwv_flow_api.g_varchar2_table(67) := '76654772696428226765745669657773222C226772696422292E6D6F64656C2E6765745265636F72642872292C752626672E696E74657261637469766547726964282273657453656C65637465645265636F726473222C752C6C2C64293B627265616B3B';
wwv_flow_api.g_varchar2_table(68) := '6361736520693A22223D3D723F28753D7428662B22202E612D4952522D7461626C652074626F64792074723A6E74682D6368696C6428322922292C622E6C656E6774683E30262628723D752E66696E6428225B646174612D69645D22292E646174612822';
wwv_flow_api.g_varchar2_table(69) := '696422292C617065782E6974656D28622E61747472282269642229292E73657456616C756528722929293A753D7428662B78292E706172656E742822746422292E706172656E742822747222292C652E72656E64657265722E686967686C69676874526F';
wwv_flow_api.g_varchar2_table(70) := '7728752C6C293B627265616B3B6361736520733A673D74286D292C753D672E7472656556696577282266696E64222C7B64657074683A2D312C6D617463683A66756E6374696F6E2865297B72657475726E20652E69643D3D3D727D7D292C672E74726565';
wwv_flow_api.g_varchar2_table(71) := '566965772822636F6C6C61707365416C6C22292C672E74726565566965772822657870616E64222C75292C672E7472656556696577282273657453656C656374696F6E222C752C6C2C64297D7D2C782E73657441706578416374696F6E4163636573734B';
wwv_flow_api.g_varchar2_table(72) := '65793D66756E6374696F6E2865297B636F6E7374206E3D22742D427574746F6E2D6C6162656C223B76617220722C612C693D612E66696E6428602E247B6E7D60292C6F3D692E68746D6C28292C733D722E65786563286F292C633D7428605B646174612D';
wwv_flow_api.g_varchar2_table(73) := '616374696F6E3D27247B657D275D60292C6C3D617065782E616374696F6E732E6C6F6F6B75702865292E73686F72746375743B2222213D3D6C2626286C3D6C2E736C696365282D3129292C6C2E6C656E6774683E30262628723D6E657720526567457870';
wwv_flow_api.g_varchar2_table(74) := '286C2C226922292C632E65616368282866756E6374696F6E28297B28613D74287468697329292E66696E6428602E247B6E7D60295B305D7C7C612E68746D6C28603C7370616E20636C6173733D27247B6E7D273E247B612E68746D6C28297D3E7370616E';
wwv_flow_api.g_varchar2_table(75) := '3E60292C692E68746D6C286F2E7265706C61636528722C603C7370616E20636C6173733D276163636573736B6579273E247B737D3E7370616E3E6029292C612E6174747228226163636573736B6579222C73292C612E617474722822646174612D616363';
wwv_flow_api.g_varchar2_table(76) := '6573736B6579222C6F2E736561726368287229297D2929297D2C782E736574446973706C617953746174653D66756E6374696F6E28722C612C69297B2428722C2866756E6374696F6E28297B76617220723D742874686973292E61747472282269642229';
wwv_flow_api.g_varchar2_table(77) := '3B7377697463682861297B636173652248494445223A617065782E6974656D2872292E6869646528293B627265616B3B636173652253484F575F44495341424C45223A617065782E6974656D2872292E73686F7728292C652E72656E64657265722E6469';
wwv_flow_api.g_varchar2_table(78) := '7361626C65456C656D656E742872292C74286E292E636C656172517565756528293B627265616B3B636173652253484F575F454E41424C45223A617065782E6974656D2872292E73686F7728292C652E72656E64657265722E656E61626C65456C656D65';
wwv_flow_api.g_varchar2_table(79) := '6E742872293B627265616B3B64656661756C743A617065782E64656275672E696E666F286056697375616C20537461746520247B617D206E6F7420737570706F7274656460297D692626652E72656E64657265722E7365744974656D4C6162656C28722C';
wwv_flow_api.g_varchar2_table(80) := '69297D29297D2C782E7365744572726F72733D66756E6374696F6E2872297B69662872297B722E6572726F72732E6C656E6774683E30262674286E292E636C656172517565756528292C742E6561636828722E666972696E674974656D732C2866756E63';
wwv_flow_api.g_varchar2_table(81) := '74696F6E28652C6E297B763D742E6772657028762C2866756E6374696F6E2865297B72657475726E20652E706167654974656D213D6E262622444F43554D454E5422213D652E706167654974656D7D29297D29293B666F72286C657420653D303B653C72';
wwv_flow_api.g_varchar2_table(82) := '2E6572726F72732E6C656E6774683B652B2B297B636F6E737420743D722E6572726F72735B655D3B762E707573682874297D7D656C736520763D5B5D3B652E72656E64657265722E73686F774572726F72732876297D2C782E7365744974656D56616C75';
wwv_flow_api.g_varchar2_table(83) := '653D66756E6374696F6E28652C6E297B2428652C2866756E6374696F6E28297B76617220653D742874686973292E617474722822696422293B617065782E6974656D2865292E73657456616C7565286E2C6E2C2130297D29297D2C782E7365744974656D';
wwv_flow_api.g_varchar2_table(84) := '56616C7565733D66756E6374696F6E286E297B652E636F6E74726F6C6C65722E7365744C6173744974656D56616C756573286E292C742E65616368286E2C2866756E6374696F6E28297B28746869732E76616C75657C7C22464F4F2229213D3D28617065';
wwv_flow_api.g_varchar2_table(85) := '782E6974656D28746869732E6964292E67657456616C756528297C7C22464F4F2229262628617065782E6974656D28746869732E6964292E73657456616C756528746869732E76616C75652C746869732E76616C75652C2130292C617065782E64656275';
wwv_flow_api.g_varchar2_table(86) := '672E696E666F28604974656D2027247B746869732E69647D272073657420746F2027247B746869732E76616C75657D276029297D29297D2C782E7365744D616E6461746F72793D66756E6374696F6E286E2C72297B24286E2C2866756E6374696F6E2829';
wwv_flow_api.g_varchar2_table(87) := '7B766172206E3D742874686973292E617474722822696422292E7265706C61636528225F434F4E5441494E4552222C2222293B722626652E636F6E74726F6C6C65722E70757368506167654974656D286E292C652E72656E64657265722E656E61626C65';
wwv_flow_api.g_varchar2_table(88) := '456C656D656E74286E292C652E72656E64657265722E7365744974656D4D616E6461746F7279286E2C72297D29297D2C782E7365744D6F64616C4469616C6F675469746C653D66756E6374696F6E2874297B652E72656E64657265722E7365744D6F6461';
wwv_flow_api.g_varchar2_table(89) := '6C4469616C6F675469746C652874297D2C782E736574526567696F6E436F6E74656E743D66756E6374696F6E28742C6E297B652E72656E64657265722E736574526567696F6E436F6E74656E7428742C6E297D2C782E736574526567696F6E4865616465';
wwv_flow_api.g_varchar2_table(90) := '723D66756E6374696F6E28742C6E297B652E72656E64657265722E736574526567696F6E48656164657228742C6E2C52287429297D2C782E73656C6563745461623D66756E6374696F6E28652C74297B617065782E726567696F6E2865292E7769646765';
wwv_flow_api.g_varchar2_table(91) := '7428292E615461627328226765745461627322295B6023247B747D605D2E6D616B6541637469766528297D2C782E73686F77576169745370696E6E65723D66756E6374696F6E2874297B652E72656E64657265722E73686F77576169745370696E6E6572';
wwv_flow_api.g_varchar2_table(92) := '2874297D2C782E7375626D69743D66756E6374696F6E28742C6E297B652E72656E64657265722E7375626D69745061676528742C6E297D7D2864652E636F6E6465732E706C7567696E2E6164632C617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740440633031785499)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/actions.min.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E207C7C207B7D3B0D0A64652E636F6E';
wwv_flow_api.g_varchar2_table(2) := '6465732E706C7567696E2E616463203D2064652E636F6E6465732E706C7567696E2E616463207C7C207B7D3B0D0A0D0A0D0A2F2A2A0D0A202A20406E616D6573706163652064652E636F6E6465732E706C7567696E2E6164630D0A202A204073696E6365';
wwv_flow_api.g_varchar2_table(3) := '20352E310D0A202A20406465736372697074696F6E0D0A2020203C703E546869732066696C6520696D706C656D656E74732074686520636C69656E742D7369646520636F6E74726F6C6C657220636F6D706F6E656E74206F6620415045582044796E616D';
wwv_flow_api.g_varchar2_table(4) := '696320436F6E74726F6C6C65722E3C62723E0D0A20202020497473207461736B20697320746F0D0A2020202020203C756C3E0D0A20202020202020203C6C693E63726561746520746865206E6563657373617279206576656E742068616E646C65727320';
wwv_flow_api.g_varchar2_table(5) := '7768656E2074686520706167652069732072656E64657265643E6C693E3C6C693E636F6C6C656374207468652072656C6576616E7420646174612066726F6D207468652070616765207768656E20616E206576656E74206F636375727320616E64207365';
wwv_flow_api.g_varchar2_table(6) := '6E6420697420746F20746865207365727665723E6C693E3C6C693E696D706C656D656E74207468652072657475726E656420726573706F6E7365207769746820696E737472756374696F6E7320746F206D6F6469667920746865206170706C6963617469';
wwv_flow_api.g_varchar2_table(7) := '6F6E20706167652E3E6C693E0D0A2020202020203E756C3E0D0A202020203E703E0D0A202020203C703E54686520636F6E74726F6C6C657220776F726B73206F6E2074686520736572766572207369646520776974682061206465636973696F6E207472';
wwv_flow_api.g_varchar2_table(8) := '6565207468617420636F6D70757465732061206C697374206F6620616374696F6E20696E737472756374696F6E7320666F72206120676976656E20736974756174696F6E2E3C62723E0D0A20202020447572696E67207468652063616C63756C6174696F';
wwv_flow_api.g_varchar2_table(9) := '6E2C20746865207374617465206F6620746865206170706C69636174696F6E20706167652063616E206265206368616E67656420627920616374696F6E732C207768696368206C6561647320746F20612072656375727369766520636865636B206F6620';
wwv_flow_api.g_varchar2_table(10) := '746865206368616E676564207061676520737461746520616761696E737420746865206465636973696F6E20747265652E2054686520726573706F6E736520696E636C7564657320616C6C206368616E676520696E737472756374696F6E7320666F7220';
wwv_flow_api.g_varchar2_table(11) := '746865206170706C69636174696F6E20706167652C20696E636C7564696E672074686520726563757273697665206368616E676520696E737472756374696F6E732E3E703E0D0A202020203C703E5468652041444320726573706F6E7365206973206465';
wwv_flow_api.g_varchar2_table(12) := '6C69766572656420696E2074686520666F726D206F66206120736372697074207769746820616E20494420616E6420696E736572746564206F6E207468652070616765206279207468697320636F6D706F6E656E742E20546875732C20616C6C20696E63';
wwv_flow_api.g_varchar2_table(13) := '6C7564656420616374696F6E7320617265206578656375746564206469726563746C792E20416674657277617264732C2074686520706C7567696E2072656D6F7665732074686520736572766572277320726573706F6E73652C20617320697420697320';
wwv_flow_api.g_varchar2_table(14) := '6E6F206C6F6E676572206E65656465642E3E703E0D0A202020203C703E4368616E676520696E737472756374696F6E7320746F206170706C69636174696F6E207061676520706172746C7920646570656E64206F6E20415045582076657273696F6E2075';
wwv_flow_api.g_varchar2_table(15) := '73656420616E6420657370656369616C6C79206F6E207468656D6520757365642E2054686520706C7567696E207374617274732066726F6D205468656D652034322C20686F77657665722C20616C6C207468656D652D737065636966696320696D706C65';
wwv_flow_api.g_varchar2_table(16) := '6D656E746174696F6E73206F66207468652061637469766974696573206172652073776170706564206F757420696E746F20612073657061726174652066696C652C207768696368206973206C696E6B65642061732061206E616D657370616365206F62';
wwv_flow_api.g_varchar2_table(17) := '6A656374207768656E20706172616D65746572697A696E672074686520706C7567696E206173206120636F6D706F6E656E7420706172616D657465722E204173207065722064656661756C742C2074686973206973203C64652E636F6E6465732E706C75';
wwv_flow_api.g_varchar2_table(18) := '67696E2E6164632E617065785F34325F355F313E2C20696D706C656D656E74656E7420696E2066696C65203C616463417065782E6A733E2C206275742069742063616E20626520656173696C79207265706C61636564206279206120636C69656E742073';
wwv_flow_api.g_varchar2_table(19) := '7065636966696320696D706C656D656E746174696F6E2E3E703E0D0A202020203C703E546F20776F726B2C207468697320706C7567696E206D757374206F6E6C792062652063616C6C656420647572696E672070616765206C6F61642C206E6F2061646D';
wwv_flow_api.g_varchar2_table(20) := '696E697374726174696F6E206F7220706172616D65746572697A6174696F6E2069732072657175697265642E3E703E0D0A2020202A2F0D0A2866756E6374696F6E20286164632C20242C2073657276657229207B0D0A2020227573652073747269637422';
wwv_flow_api.g_varchar2_table(21) := '3B0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D206572726F720D0A2020202A20406465736372697074696F6E0D0A20202020203C703E416E206572726F722069732061204A534F4E206F626A656374207265707265';
wwv_flow_api.g_varchar2_table(22) := '73656E74696E6720616E206572726F722E20497420636F6E7461696E7320696E666F726D6174696F6E2061626F757420746865206572726F72206D6573736167652C207468652061666665637465642070616765206974656D20616E6420616464697469';
wwv_flow_api.g_varchar2_table(23) := '6F6E616C20696E666F726D6174696F6E20746861742073686F7773206F6E6C792069662074686520706167652069732072656E646572656420696E206465627567206D6F64652E3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A20';
wwv_flow_api.g_varchar2_table(24) := '4070726F7065727479207B737472696E677D206974656D2050616765206974656D20746861742069732061666665637465642062792074686973206572726F720D0A2020202A204070726F7065727479207B737472696E677D206D657373616765204572';
wwv_flow_api.g_varchar2_table(25) := '726F72206D6573736167650D0A2020202A204070726F7065727479207B737472696E677D206164646974696F6E616C496E666F20446576656C6F70657220696E666F726D6174696F6E2C0D0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(26) := '6E6F726D616C6C792063616C6C20737461636B20616E6420696E7465726E616C206572726F72206E616D650D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D206572726F724C6973740D0A2020202A20';
wwv_flow_api.g_varchar2_table(27) := '406465736372697074696F6E0D0A20202020203C703E416E206572726F724C697374206973206120636F6C6C656374696F6E206F66206572726F72732074686174206F63637572726564206F6E2074686520706167652E20497420616C736F20636F6E74';
wwv_flow_api.g_varchar2_table(28) := '61696E732061727261797320666F72206572726F7220646570656E64656E74206974656D732028692E652E206974656D732074686174206861766520746F2062652064697361626C656420696620616E206572726F72206F63637572726564206F6E2074';
wwv_flow_api.g_varchar2_table(29) := '686520706167652920616E6420666972696E674974656D732E3C62723E0D0A2020202020466972696E67206974656D732070726F7669646520696E666F726D6174696F6E2061626F75742070616765206974656D7320746861742068617665206265656E';
wwv_flow_api.g_varchar2_table(30) := '2027746F7563686564272062792065786563757465642072756C65732E20496E74656E74696F6E20697320746F2072656D6F766520616E79206572726F7220746861742069732072656C6174656420746F206120666972696E67206974656D2066726F6D';
wwv_flow_api.g_varchar2_table(31) := '2074686520636F6C6C656374696F6E206F66206572726F7273206F6E20746865207061676520616E64207265706C616365206974207769746820746865206E65776C792070726F7669646564206572726F72206D6573736167652C20696620616E792E20';
wwv_flow_api.g_varchar2_table(32) := '54686973207761792C206572726F72206D6573736167657320776869636820646F6E2774206170706C79206172652072656D6F7665642C20627574206572726F72732072656C6174696E6720746F206F746865722070616765206974656D73206F6E2074';
wwv_flow_api.g_varchar2_table(33) := '686520706167652073746179206F6E20706167652E3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A204070726F7065727479207B737472696E677D20636F756E7420416D6F756E74206F66206572726F72730D0A2020202A204070';
wwv_flow_api.g_varchar2_table(34) := '726F7065727479207B737472696E675B5D7D20666972696E674974656D73204172726179206F662070616765206974656D732074686174206172650D0A20202020202020206166666563746564206279207468652065786563757465642072756C65732E';
wwv_flow_api.g_varchar2_table(35) := '205573656420746F2072656D6F7665206572726F727320746861740D0A2020202020202020726566657220746F2074686573652070616765206974656D73206265666F726520616464696E67206E6577206572726F72730D0A2020202A204070726F7065';
wwv_flow_api.g_varchar2_table(36) := '727479207B6572726F725B5D7D206572726F7273204172726179206F66206572726F7220696E7374616E6365730D0A2020202A2040706172616D207B4F626A6563747D20616463205468697320636F64650D0A2020202A2040706172616D207B4F626A65';
wwv_flow_api.g_varchar2_table(37) := '63747D2024206A517565727920696E7374616E6365206F6620415045580D0A2020202A2040706172616D207B4F626A6563747D2073657276657220617065782E73657276657220696E7374616E63650D0A2020202A2F0D0A0D0A20202F2A2A0D0A202020';
wwv_flow_api.g_varchar2_table(38) := '2A204074797065646566207B4F626A6563747D2070726F70732E74726967676572696E67456C656D656E740D0A2020202A20406465736372697074696F6E203C703E416E206F626A65637420746F20636F6C6C65637420696E666F726D6174696F6E7320';
wwv_flow_api.g_varchar2_table(39) := '61626F7574207468652074726967676572696E67206974656D3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D206964204944206F6620746865207061676520656C65';
wwv_flow_api.g_varchar2_table(40) := '6D656E7420746861742074726967676572656420746865206576656E742E0D0A2020202A204070726F7065727479207B737472696E677D206576656E74204E616D65206F6620746865206576656E74207468617420776173207261697365642E204D6179';
wwv_flow_api.g_varchar2_table(41) := '206265206120646966666572656E74206576656E74207468616E206F726967696E616C6C79207261697365642C66692E20616E203C656E7465723E2074686174206973207261697365642069662061203C6B657970726573733E206576656E7420776173';
wwv_flow_api.g_varchar2_table(42) := '20666F756E6420666F722074686520456E7465722D6B65792E0D0A2020202A204070726F7065727479207B737472696E677D206973436C69636B20466C616720746F20696E646963617465207768657468657220746865206576656E742077617320736F';
wwv_flow_api.g_varchar2_table(43) := '6D65206B696E64206F6620636C69636B206576656E740D0A2020202A204070726F7065727479207B737472696E677D2064617461204F7074696F6E616C2064617461207468617420697320706173736564207769746820746865206576656E742E204D61';
wwv_flow_api.g_varchar2_table(44) := '7920626520612073696D706C6520737472696E67206F722061204A534F4E206F626A6563742E0D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D2070416374696F6E0D0A2020202A2040646573637269';
wwv_flow_api.g_varchar2_table(45) := '7074696F6E203C703E416E20616E73776572206F626A656374206F662074686520706C7567696E206672616D65776F726B20636F6E7461696E696E67206174747269627574657320746F20636F6E74726F6C20667572746865722070726F63657373696E';
wwv_flow_api.g_varchar2_table(46) := '673E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3031204A534F4E206F626A65637420636F6E7461696E696E6720616C6C207061676520';
wwv_flow_api.g_varchar2_table(47) := '6974656D7320616E64207468656972206576656E74732077686963682061726520626F756E642062792074686520706C7567696E0D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3032204A534F4E206F62656A';
wwv_flow_api.g_varchar2_table(48) := '6374206F6620656C656D656E747320746861742068617665206368616E67656420647572696E67204144432070726F63657373696E6720616C6F6E6720776974682074686569722061637475616C2076616C7565730D0A2020202A204070726F70657274';
wwv_flow_api.g_varchar2_table(49) := '79207B737472696E677D206174747269627574655F3033204E616D657370616365206F6620746865203C6164632E20417065784A533E206F626A656374207573656420746F2072656E646572207468652076697375616C2065666665637473206F662041';
wwv_flow_api.g_varchar2_table(50) := '44430D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3034204A61766153637269707420636F646520746F206265206578656375746564206F6E2074686520706167652E20536574732074686520696E69746961';
wwv_flow_api.g_varchar2_table(51) := '6C2076697375616C207374617465206F662074686520706167650D0A2020202A204070726F7065727479207B737472696E677D206174747269627574655F3035206A51756572792073656C6563746F72206F72204172726179206F66206164646974696F';
wwv_flow_api.g_varchar2_table(52) := '6E616C2070616765206974656D7320776869636820617265206E6F7420626F756E6420746F206576656E742068616E646C657273206275742074686569722076616C75652069732070617373656420746F204144430D0A2020202A2F0D0A0D0A20202F2A';
wwv_flow_api.g_varchar2_table(53) := '2A0D0A2020202A204074797065646566207B4F626A6563747D2070726F70732E6576656E74446174610D0A2020202A20406465736372697074696F6E203C703E41204A736F6E206F626A65637420636F6E7461696E74696E67206461746120666F722074';
wwv_flow_api.g_varchar2_table(54) := '6865207365727665722063616C6C20737563682061732074686520616A61784964656E74696669657220616E64207468652070616765206974656D7320746F207375626D69743E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A';
wwv_flow_api.g_varchar2_table(55) := '2020202A204070726F7065727479207B737472696E677D20616A61784964656E746966696572205265666572656E636520746F2070726F70732E616A61784964656E7469666965720D0A2020202A204070726F7065727479207B737472696E677D207072';
wwv_flow_api.g_varchar2_table(56) := '6F70732E706167654974656D73207265666572656E636520746F203C70726F70732E706167654974656D733E0D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202A204074797065646566207B4F626A6563747D20636F6D6D616E64446174610D0A2020';
wwv_flow_api.g_varchar2_table(57) := '202A20406465736372697074696F6E203C703E41204A736F6E206F626A65637420636F6E7461696E74696E6720646174612064657363726962696E67206120636F6D6D616E64206F626A656374207768696368206973206261736564206F6E20406C696E';
wwv_flow_api.g_varchar2_table(58) := '6B7B617065782E616374696F6E7D3E703E0D0A2020202A204074797065204F626A6563740D0A2020202A0D0A2020202A204070726F7065727479207B737472696E677D20636F6D6D616E64204E616D65206F662074686520636F6D6D616E6420746F2065';
wwv_flow_api.g_varchar2_table(59) := '7865637574650D0A2020202A204070726F7065727479207B737472696E677D206576656E74204576656E74206F626A6563742074686174207261697365642074686520616374696F6E0D0A2020202A204070726F7065727479207B737472696E677D2066';
wwv_flow_api.g_varchar2_table(60) := '6F6375734974656D204944206F6620746865206974656D2074686174206765747320666F6375732069662074686520657865637574696F6E206F66206120636F6D6D616E642072657475726E7320747275650D0A2020202A204070726F7065727479207B';
wwv_flow_api.g_varchar2_table(61) := '737472696E677D206164646974696F6E616C506167654974656D73204172726179206F662070616765206974656D20494473207768696368206861766520746F2062652070617373656420696E206164646974696F6E20746F20746865206E6F726D616C';
wwv_flow_api.g_varchar2_table(62) := '2070726F70732E706167654974656D7320636F6C6C656374696F6E2E0D0A2020202A204070726F7065727479207B737472696E677D2064617461204164646974696F6E616C20696E666F726D6174696F6E20746861742069732070617373656420616C6F';
wwv_flow_api.g_varchar2_table(63) := '6E6720776974682074686520636F6D6D616E642C2066692E20666F722076616C7565730D0A2020202A2F0D0A0D0A20202F2A2A0D0A2020202047726F75703A20436F6E7374616E74730D0A2020202A2F0D0A2020636F6E737420435F4348414E47455F45';
wwv_flow_api.g_varchar2_table(64) := '56454E54203D20276368616E6765273B0D0A2020636F6E737420435F434C49434B5F4556454E54203D2027636C69636B273B0D0A2020636F6E737420435F44424C434C49434B5F4556454E54203D202764626C636C69636B273B0D0A2020636F6E737420';
wwv_flow_api.g_varchar2_table(65) := '435F454E5445525F4556454E54203D2027656E746572273B0D0A2020636F6E737420435F4B455950524553535F4556454E54203D20276B65797072657373273B0D0A2020636F6E737420435F415045585F4245464F52455F52454652455348203D202761';
wwv_flow_api.g_varchar2_table(66) := '7065786265666F726572656672657368273B0D0A2020636F6E737420435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368273B0D0A2020636F6E737420435F415045585F41465445525F434C4F53455F44';
wwv_flow_api.g_varchar2_table(67) := '49414C4F47203D2027617065786166746572636C6F73656469616C6F67273B0D0A2020636F6E737420435F4E4F5F54524947474552494E475F4954454D203D2027444F43554D454E54273B0D0A2020636F6E737420435F4C4F434B5F4C454E475448203D';
wwv_flow_api.g_varchar2_table(68) := '203230303B0D0A2020636F6E737420435F50524F5445435445445F4556454E5453203D205B435F434C49434B5F4556454E542C20435F44424C434C49434B5F4556454E542C20435F454E5445525F4556454E545D3B0D0A2020636F6E737420435F424F44';
wwv_flow_api.g_varchar2_table(69) := '59203D2027626F6479273B0D0A2020636F6E737420435F425554544F4E203D2027627574746F6E273B0D0A2020636F6E737420435F415045585F425554544F4E203D2027742D427574746F6E273B0D0A2020636F6E737420435F494E5055545F53454C45';
wwv_flow_api.g_varchar2_table(70) := '43544F52203D20273A696E7075743A76697369626C653A6E6F7428627574746F6E29273B0D0A0D0A20202F2F20476C6F62616C0D0A20206164632E636F6E74726F6C6C6572203D207B7D3B0D0A20207661722063746C203D206164632E636F6E74726F6C';
wwv_flow_api.g_varchar2_table(71) := '6C65723B0D0A20207661722070726F7073203D207B0D0A2020202022616A61784964656E746966696572223A22222C0D0A202020202271756172616E74696E654C697374223A5B5D2C0D0A202020202274726967676572696E67456C656D656E74223A7B';
wwv_flow_api.g_varchar2_table(72) := '0D0A202020202020226964223A2022222C0D0A2020202020202264617461223A2022222C0D0A202020202020226576656E74223A2022222C0D0A202020202020226973436C69636B223A2066616C73650D0A202020207D2C0D0A20202020226576656E74';
wwv_flow_api.g_varchar2_table(73) := '44617461223A7B0D0A20202020202022616A61784964656E746966696572223A22222C0D0A20202020202022706167654974656D73223A22227D2C0D0A2020202022706167655374617465223A7B0D0A202020202020226974656D4D6170223A6E657720';
wwv_flow_api.g_varchar2_table(74) := '4D617028290D0A202020207D2C0D0A2020202022706167654974656D73223A5B5D2C0D0A202020202262696E644974656D73223A5B5D2C0D0A20202020226C6173744974656D56616C756573223A5B5D2C0D0A20202020226164646974696F6E616C4974';
wwv_flow_api.g_varchar2_table(75) := '656D73223A5B5D2C0D0A20202020227374616E646172644D65737361676573223A7B7D0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202047726F75703A20496E7465726E616C2043616C6C6261636B206D6574686F64730D0A2020202A2F0D0A20202F';
wwv_flow_api.g_varchar2_table(76) := '2A2A200D0A2020202046756E6374696F6E3A206368616E676543616C6C6261636B20200D0A20202020202043616C6C6261636B206D6574686F6420666F722061206368616E6765206576656E740D0A2020202020200D0A202020202020416E7920657665';
wwv_flow_api.g_varchar2_table(77) := '6E742069732070757368656420746F206120717565756520746F2070726F63657373207468656D206F6E65206279206F6E652C20646570656E64696E67206F6E20746865206F7574636F6D65206F6620746865207072656465636573736F722E0D0A2020';
wwv_flow_api.g_varchar2_table(78) := '20202020417320616E206578616D706C652C20696620612070616765206974656D20697320666F63757373656420616E6420746865207573657220636C69636B73206F6E206120627574746F6E2C2074776F206576656E7473206F636375723A0D0A2020';
wwv_flow_api.g_varchar2_table(79) := '202020200D0A20202020202020202D206368616E6765206576656E74206F6E207468652070616765206974656D0D0A20202020202020202D20636C69636B206576656E74206F6E2074686520627574746F6E0D0A20202020202020200D0A202020202020';
wwv_flow_api.g_varchar2_table(80) := '496620746865206368616E6765206576656E74207472696767657273206120636F6D7075746174696F6E20746861742072657475726E7320616E206572726F7220287375636820617320612070616765206974656D2076616C69646174696F6E292C2069';
wwv_flow_api.g_varchar2_table(81) := '6E206D616E792063617365732074686520636C69636B206576656E740D0A2020202020206F662074686520627574746F6E206D757374206E6F742062652070726F63657373656420616E796D6F72652E2042757420626563617573652074686573652065';
wwv_flow_api.g_varchar2_table(82) := '76656E74732061707065617220736F20717569636B6C792C2041444320697320756E61626C6520746F20726573706F6E64206265666F7265207468650D0A202020202020636C69636B206576656E742069732068616E646C65642E205468657265666F72';
wwv_flow_api.g_varchar2_table(83) := '652C207468657365206576656E74732061207175657565642E204966204144432072657475726E73207769746820616E206572726F722C2074686520717565756520697320636C656172656420616E6420746865206E657874206576656E74732077696C';
wwv_flow_api.g_varchar2_table(84) := '6C206E6F742062652070726F6365737365642E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020704576656E74202D204576656E742074686174206F6363757265640D0A20202020202070726F70732E6576656E744461';
wwv_flow_api.g_varchar2_table(85) := '7461202D204164646974696F6E616C206576656E742064617461207468617420697320706173736564207769746820746865206576656E742E204D6179206265206163636573736564206279204144432E4745545F4556454E545F444154412077697468';
wwv_flow_api.g_varchar2_table(86) := '696E207468652064617461626173650D0A2020202020207057616974202D20466C616720746F20696E646963617465207768657468657220612077616974207370696E6E65722073686F756C642062652073686F776E20647572696E672070726F636573';
wwv_flow_api.g_varchar2_table(87) := '73696E670D0A2020202A2F0D0A2020636F6E7374206368616E676543616C6C6261636B203D2066756E6374696F6E28704576656E742C20704576656E74446174612C20705761697429207B0D0A2020202067657454726967676572696E67456C656D656E';
wwv_flow_api.g_varchar2_table(88) := '7428704576656E74293B0D0A0D0A202020202428435F424F4459292E71756575652866756E6374696F6E202829207B0D0A2020202020206164632E616374696F6E732E73686F77576169745370696E6E6572287057616974293B0D0A2020202020206374';
wwv_flow_api.g_varchar2_table(89) := '6C2E6578656375746528704576656E742C20704576656E7444617461293B0D0A202020207D293B0D0A20207D3B202F2F206368616E676543616C6C6261636B0D0A2020202020200D0A202020200D0A20202F2A2A200D0A2020202046756E6374696F6E3A';
wwv_flow_api.g_varchar2_table(90) := '20656E74657243616C6C6261636B0D0A2020202020205772617073207468652063616C6C20746F2074686520646174616261736520696E206120636F6E6669726D6174696F6E206469616C6F6720746F20656E61626C6520746865207573657220746F20';
wwv_flow_api.g_varchar2_table(91) := '73757270726573732074686973206576656E742E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020704576656E74202D204576656E742074686174206F6363757265640D0A202020202020704576656E7444617461202D';
wwv_flow_api.g_varchar2_table(92) := '203C70726F70732E6576656E74446174613E20696E7374616E6365207468617420676F657320616C6F6E67207769746820746865206576656E740D0A202020202A2F0D0A2020636F6E737420656E74657243616C6C6261636B203D2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(93) := '2028704576656E742C20704576656E74446174612C207057616974297B0D0A2020202067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A202020202F2F20506C616365207265717565737420696E20717565756520746F';
wwv_flow_api.g_varchar2_table(94) := '2070726F63657373206D756C7469706C65206576656E747320696E2073657175656E63650D0A202020206966202870726F70732E74726967676572696E67456C656D656E742E6576656E74203D3D3D20435F454E5445525F4556454E54297B0D0A202020';
wwv_flow_api.g_varchar2_table(95) := '202020617065782E64656275672E696E666F2860456E7175657565696E67204576656E742027247B435F454E5445525F4556454E547D2760293B0D0A202020202020242827626F647927292E71756575652866756E6374696F6E28297B0D0A2020202020';
wwv_flow_api.g_varchar2_table(96) := '2020200D0A20202020202020206164632E616374696F6E732E73686F77576169745370696E6E6572287057616974293B0D0A202020202020202063746C2E6578656375746528704576656E7444617461293B0D0A2020202020207D293B0D0A202020207D';
wwv_flow_api.g_varchar2_table(97) := '0D0A20207D3B202F2F20656E74657243616C6C6261636B0D0A2020202020200D0A202020200D0A20202F2A2A200D0A2020202046756E6374696F6E3A20756E736176656443616C6C6261636B0D0A2020202020205772617073207468652063616C6C2074';
wwv_flow_api.g_varchar2_table(98) := '6F2074686520646174616261736520696E206120636F6E6669726D6174696F6E206469616C6F6720746861742069732073686F776E20696620746865207061676520636F6E7461696E7320756E7361766564206368616E6765732E0D0A2020202020200D';
wwv_flow_api.g_varchar2_table(99) := '0A20202020506172616D65746572733A0D0A202020202020704576656E74202D204576656E742074686174206F6363757265640D0A2020202020207057616974202D20466C616720746F20696E6469636174652077686574686572206120776169742073';
wwv_flow_api.g_varchar2_table(100) := '70696E6E65722073686F756C642062652073686F776E20647572696E672070726F63657373696E670D0A202020202A2F0D0A2020636F6E737420756E736176656443616C6C6261636B203D2066756E6374696F6E2028704576656E742C20705761697429';
wwv_flow_api.g_varchar2_table(101) := '207B0D0A2020202067657454726967676572696E67456C656D656E7428704576656E74293B0D0A0D0A202020202428435F424F4459292E71756575652866756E6374696F6E202829207B0D0A2020202020200D0A2020202020206164632E616374696F6E';
wwv_flow_api.g_varchar2_table(102) := '732E73686F77576169745370696E6E6572287057616974293B0D0A20202020202069662863746C2E686173556E73617665644368616E6765732829297B0D0A20202020202020202F2F2048616E646C65206576656E74206F6E6C7920616674657220636F';
wwv_flow_api.g_varchar2_table(103) := '6E6669726D6174696F6E2066726F6D2074686520757365720D0A20202020202020206164632E72656E64657265722E636F6E6669726D5265717565737428704576656E742C206368616E676543616C6C6261636B293B0D0A2020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(104) := '202020656C73657B0D0A20202020202020202F2F204E6F206368616E676573206F6E2074686520706167652C20636F6E74696E75650D0A20202020202020206368616E676543616C6C6261636B28704576656E74293B0D0A2020202020207D3B0D0A2020';
wwv_flow_api.g_varchar2_table(105) := '20207D293B0D0A20207D3B202F2F20756E736176656443616C6C6261636B0D0A0D0A0D0A20202F2A2A0D0A2020202047726F75703A20496E746572616C2048656C706572206D6574686F64730D0A2020202A2F0D0A20202F2A2A0D0A2020202046756E63';
wwv_flow_api.g_varchar2_table(106) := '74696F6E3A2062696E644576656E740D0A20202020202042696E647320616E206576656E7420746F20612070616765206974656D0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020704974656D4964202D204944206F66';
wwv_flow_api.g_varchar2_table(107) := '2074686520656C656D656E7420746F2062696E640D0A202020202020704576656E74202D204E6D6165206F6620746865206576656E7420746F2062696E642E0D0A20202020202070416374696F6E202D204F7074696F6E616C2063616C6C6261636B206D';
wwv_flow_api.g_varchar2_table(108) := '6574686F642E204F76657272696465732064656661756C74206265686176696F7572206F662063616C6C696E67203C6368616E676543616C6C6261636B3E0D0A2020202A2F0D0A2020636F6E73742062696E644576656E74203D2066756E6374696F6E20';
wwv_flow_api.g_varchar2_table(109) := '28704974656D49642C20704576656E742C2070416374696F6E29207B0D0A202020207661722024746869733B0D0A202020207661722063616C6C6261636B3B0D0A0D0A2020202069662028704974656D49642E736561726368282F5B5C2E235C75303032';
wwv_flow_api.g_varchar2_table(110) := '303A5C5B5C5D5D2B2F29203C203029207B0D0A202020202020704974656D4964203D206023247B704974656D49647D603B0D0A202020207D0D0A202020202474686973203D202428704974656D4964293B0D0A0D0A202020202F2F20436865636B207768';
wwv_flow_api.g_varchar2_table(111) := '657468657220656C656D656E7420657869737473206F6E20706167652028636F756C64206265206D697373696E672064756520746F20612073657276657220636F6E646974696F6E290D0A202020206966202824746869732E6C656E677468203E203029';
wwv_flow_api.g_varchar2_table(112) := '207B0D0A20202020202069662028747970656F662070416374696F6E203D3D202766756E6374696F6E27297B0D0A202020202020202063616C6C6261636B203D2070416374696F6E3B0D0A2020202020207D0D0A202020202020656C7365206966287479';
wwv_flow_api.g_varchar2_table(113) := '70656F662070416374696F6E20213D2027756E646566696E6564272026262070416374696F6E2E6C656E677468203E2030297B0D0A202020202020202063616C6C6261636B203D206E65772046756E6374696F6E2870416374696F6E293B0D0A20202020';
wwv_flow_api.g_varchar2_table(114) := '20207D0D0A202020202020656C7365207B0D0A202020202020202063616C6C6261636B203D206368616E676543616C6C6261636B3B0D0A2020202020207D0D0A0D0A2020202020202F2F2041444320756E62696E6473206576656E742068616E646C6572';
wwv_flow_api.g_varchar2_table(115) := '7320626F756E6420746F2074686973206974656D20746F2070726576656E742070726F626C656D73206265747765656E2074686520646966666572656E742068616E646C6572730D0A20202020202024746869730D0A20202020202020202E6F66662870';
wwv_flow_api.g_varchar2_table(116) := '4576656E74290D0A20202020202020202E6F6E28704576656E742C2070726F70732E6576656E74446174612C2063616C6C6261636B293B0D0A20202020202069662028704576656E74203D3D3D20435F4348414E47455F4556454E5429207B0D0A202020';
wwv_flow_api.g_varchar2_table(117) := '20202020202F2F204348414E4745206576656E742073686F756C64206E6F742062652063616C6C65642061667465722041504558524546524553482C20736F20706175736520697420756E74696C20617065786166746572726566726573680D0A202020';
wwv_flow_api.g_varchar2_table(118) := '202020202024746869730D0A20202020202020202E6F6E28435F415045585F4245464F52455F524546524553482C2066756E6374696F6E20286529207B0D0A20202020202020202020242874686973292E6F666628435F4348414E47455F4556454E5429';
wwv_flow_api.g_varchar2_table(119) := '3B0D0A20202020202020202020617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272070617573656420617420247B704974656D49647D60293B0D0A20202020202020207D290D0A20202020202020';
wwv_flow_api.g_varchar2_table(120) := '202E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E20286529207B0D0A20202020202020202020242874686973292E6F6E28435F4348414E47455F4556454E542C2070726F70732E6576656E74446174612C2063616C';
wwv_flow_api.g_varchar2_table(121) := '6C6261636B293B0D0A20202020202020202020617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272072652D65737461626C697368656420617420247B704974656D49647D60293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(122) := '2020207D293B0D0A2020202020207D0D0A202020207D0D0A20207D3B202F2F2062696E644576656E740D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2062696E644576656E74730D0A20202020202042696E647320616C6C206576';
wwv_flow_api.g_varchar2_table(123) := '656E7473207468617420617265207265717565737465642062792074686520706C7567696E20766961203C70726F70732E62696E644974656D733E2E0D0A0D0A20202020202055706F6E20696E697469616C697A6174696F6E2C20616C6C2072656C6576';
wwv_flow_api.g_varchar2_table(124) := '616E742070616765206974656D732061726520636F6C6C656374656420616C6F6E67207769746820746865207265717569726564206576656E74732E0D0A20202020202054686973206D6574686F64207468656E2062696E647320616C6C206974656D73';
wwv_flow_api.g_varchar2_table(125) := '2077697468207468652072657370656374697665206576656E742E0D0A2020202A2F0D0A2020636F6E73742062696E644576656E7473203D2066756E6374696F6E202829207B0D0A20202020242E656163682870726F70732E62696E644974656D732C20';
wwv_flow_api.g_varchar2_table(126) := '66756E6374696F6E202829207B0D0A202020202020696628746869732E6576656E74203D3D20435F454E5445525F4556454E54297B0D0A202020202020202062696E644576656E7428746869732E69642C20435F4B455950524553535F4556454E542C20';
wwv_flow_api.g_varchar2_table(127) := '746869732E616374696F6E207C7C20656E74657243616C6C6261636B293B0D0A2020202020207D0D0A202020202020656C73657B0D0A202020202020202062696E644576656E7428746869732E69642C20746869732E6576656E742C20746869732E6163';
wwv_flow_api.g_varchar2_table(128) := '74696F6E293B0D0A202020202020202069662028746869732E6576656E74203D3D3D20435F4348414E47455F4556454E5429207B0D0A20202020202020202020616464506167654974656D28746869732E6964293B0D0A20202020202020207D0D0A2020';
wwv_flow_api.g_varchar2_table(129) := '202020207D0D0A202020207D293B0D0A20207D3B202F2F2062696E644576656E74730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20616464506167654974656D0D0A2020202020204D6574686F642061646473206120706167652069';
wwv_flow_api.g_varchar2_table(130) := '74656D20746F2061206C697374206F662070616765206974656D7320746F2062652073656E7420746F207468652073657276657220776974682065766572792063616C6C2E0D0A2020202020200D0A20202020506172616D657465723A0D0A2020202020';
wwv_flow_api.g_varchar2_table(131) := '20704974656D4964202D204944206F66207468652070616765206974656D20746861742061686F756C642062652061646465640D0A2020202A2F0D0A2020636F6E737420616464506167654974656D203D2066756E6374696F6E2028704974656D496429';
wwv_flow_api.g_varchar2_table(132) := '207B0D0A2020202069662028242E696E417272617928704974656D49642C2070726F70732E706167654974656D7329203D3D3D202D3129207B0D0A20202020202070726F70732E706167654974656D732E7075736828704974656D4964293B0D0A202020';
wwv_flow_api.g_varchar2_table(133) := '207D0D0A20207D3B202F2F20616464506167654974656D0D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2065786563757465436F64650D0A2020202020204D6574686F6420746F206578656375746520616C6C204A617661536372';
wwv_flow_api.g_varchar2_table(134) := '69707420636F64652070617373656420696E20776974682074686520726573706F6E7365206F66204144432E0D0A2020202020200D0A20202020202054686520636F646520697320616464656420746F2074686520646F63756D656E74207573696E6720';
wwv_flow_api.g_varchar2_table(135) := '3C242E617070656E643E20776869636820696D6D6564696174656C7920657865637574657320616E79204A6176615363726970742E0D0A202020202020416674657220617070656E64696E672C2074686520726573706F6E73652063616E206265206465';
wwv_flow_api.g_varchar2_table(136) := '6C65746564206265636175736520697420646F6573206E6F74206D616B6520616E792073656E736520746F2073746F7265206974206F6E20746865207061676520616E7920667572746865722E0D0A20202020202041667465722064656C6574696E672C';
wwv_flow_api.g_varchar2_table(137) := '207468652065786563757465206D6574686F642072616973657320746865206E657874206576656E74206F6E207468652071756575652028696620616E79292E0D0A2020202020200D0A20202020506172616D657465723A0D0A20202020202070436F64';
wwv_flow_api.g_varchar2_table(138) := '65202D204A61766153637269707420636F646520746F20657865637574650D0A2020202A2F0D0A2020636F6E73742065786563757465436F6465203D2066756E6374696F6E202870436F646529207B0D0A202020207661722053637269707453656C6563';
wwv_flow_api.g_varchar2_table(139) := '746F723B0D0A202020206966202870436F646529207B0D0A202020202020636F6E736F6C652E6C6F672827526573706F6E73652072656365697665643A205C6E27202B2070436F6465293B0D0A2020202020202428435F424F4459292E617070656E6428';
wwv_flow_api.g_varchar2_table(140) := '70436F6465293B0D0A20202020202053637269707453656C6563746F72203D20272327202B20242870436F6465292E617474722827696427293B0D0A202020202020242853637269707453656C6563746F72292E72656D6F766528293B0D0A202020207D';
wwv_flow_api.g_varchar2_table(141) := '0D0A202020202428435F424F4459292E6465717565756528293B0D0A20207D3B202F2F2065786563757465436F64650D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2067657454726967676572696E67456C656D656E740D0A2020';
wwv_flow_api.g_varchar2_table(142) := '202020204D6574686F6420746F20646573637269626520746865206576656E7420616E642063616C6C696E67206974656D20616674657220616E206576656E7420686173206F6363757265642E0D0A2020202020200D0A20202020506172616D65746572';
wwv_flow_api.g_varchar2_table(143) := '3A0D0A20202020202065202D204576656E7420746F20676574207468652074726967676572696E6720656C656D656E7420666F720D0A2020202A2F0D0A2020636F6E73742067657454726967676572696E67456C656D656E74203D66756E6374696F6E20';
wwv_flow_api.g_varchar2_table(144) := '28704576656E7429207B0D0A202020207661722024656C656D656E743B0D0A202020207661722024627574746F6E3B0D0A0D0A202020202F2F20436F7079206576656E74206461746120746F2061206C6F63616C207661726961626C6520746F20616C6C';
wwv_flow_api.g_varchar2_table(145) := '6F7720666F72207461796C6F72696E670D0A2020202070726F70732E74726967676572696E67456C656D656E742E6964203D20435F4E4F5F54524947474552494E475F4954454D3B0D0A2020202070726F70732E74726967676572696E67456C656D656E';
wwv_flow_api.g_varchar2_table(146) := '742E6576656E74203D20704576656E742E747970653B0D0A2020202070726F70732E74726967676572696E67456C656D656E742E64617461203D20704576656E742E646174613B0D0A2020202070726F70732E74726967676572696E67456C656D656E74';
wwv_flow_api.g_varchar2_table(147) := '2E6973436C69636B203D2066616C73653B202F2F2072657365742073746174757320746F206B6E6F776E2064656661756C740D0A0D0A2020202069662028747970656F6620704576656E742E74617267657420213D2027756E646566696E65642729207B';
wwv_flow_api.g_varchar2_table(148) := '0D0A202020202020737769746368202870726F70732E74726967676572696E67456C656D656E742E6576656E7429207B0D0A20202020202020206361736520435F415045585F41465445525F434C4F53455F4449414C4F473A0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(149) := '202F2F20436C6F73654469616C6F6720697320626F756E6420746F2063757272656E7454617267657420746F20616C6C6F7720666F722064656C656761746564206576656E74732E0D0A2020202020202020202070726F70732E74726967676572696E67';
wwv_flow_api.g_varchar2_table(150) := '456C656D656E742E6964203D20704576656E742E63757272656E745461726765742E69643B0D0A20202020202020202020627265616B3B0D0A20202020202020206361736520435F4348414E47455F4556454E543A0D0A2020202020202020202070726F';
wwv_flow_api.g_varchar2_table(151) := '70732E74726967676572696E67456C656D656E742E6964203D20704576656E742E7461726765742E69643B0D0A0D0A2020202020202020202024656C656D656E74203D2024286023247B70726F70732E74726967676572696E67456C656D656E742E6964';
wwv_flow_api.g_varchar2_table(152) := '7D60293B0D0A202020202020202020206966202824656C656D656E742E617474722827747970652729203D3D3D2027726164696F27207C7C2024656C656D656E742E617474722827747970652729203D3D3D2027636865636B626F782729207B0D0A2020';
wwv_flow_api.g_varchar2_table(153) := '202020202020202020202F2F20496E2063617365206F66206120726164696F2067726F7570206F72206120636865636B626F782C207468652069642068617320746F2062652074616B656E2066726F6D2074686520706172656E74206669656C64736574';
wwv_flow_api.g_varchar2_table(154) := '0D0A20202020202020202020202070726F70732E74726967676572696E67456C656D656E742E6964203D2024656C656D656E742E706172656E747328272E726164696F5F67726F75702C2E636865636B626F785F67726F757027292E6174747228276964';
wwv_flow_api.g_varchar2_table(155) := '27293B0D0A202020202020202020207D0D0A202020202020202020206966202870726F70732E74726967676572696E67456C656D656E742E69642026262070726F70732E74726967676572696E67456C656D656E742E69642E6D61746368282F6F6A2E2A';
wwv_flow_api.g_varchar2_table(156) := '2F29297B0D0A2020202020202020202020202F2F206974656D206973204F7261636C65204A6574206974656D2067726F75702C2074726176657273652075700D0A20202020202020202020202070726F70732E74726967676572696E67456C656D656E74';
wwv_flow_api.g_varchar2_table(157) := '2E6964203D2024286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E636C6F7365737428276469762E617065782D6974656D2D67726F757027292E617474722827696427293B0D0A202020202020202020207D0D0A20';
wwv_flow_api.g_varchar2_table(158) := '202020202020202020627265616B3B0D0A20202020202020206361736520435F434C49434B5F4556454E543A0D0A202020202020202020202F2F20466C6167206973207573656420746F20636C65617220746865206576656E7420717565756520746F20';
wwv_flow_api.g_varchar2_table(159) := '70726576656E74206D756C7469706C6520636C69636B730D0A2020202020202020202070726F70732E74726967676572696E67456C656D656E742E6973436C69636B203D20747275653B0D0A2020202020202020202070726F70732E7472696767657269';
wwv_flow_api.g_varchar2_table(160) := '6E67456C656D656E742E6964203D202828704576656E742E7461726765742E696420213D3D20272729203F20704576656E742E7461726765742E6964203A20704576656E742E63757272656E745461726765742E6964293B0D0A0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(161) := '20206966202870726F70732E74726967676572696E67456C656D656E742E6964203D3D3D20272729207B0D0A2020202020202020202020202F2F20536F6D652062726F77736572732073656E64206163636573734B65792D7370616E20696E7374656164';
wwv_flow_api.g_varchar2_table(162) := '206F662074726967676572696E6720656C656D656E7420696E20726573706F6E736520746F206120636C69636B0D0A2020202020202020202020202F2F204765742074686520706172656E7420656C656D656E7420696E2074686573652063617365730D';
wwv_flow_api.g_varchar2_table(163) := '0A20202020202020202020202070726F70732E74726967676572696E67456C656D656E742E6964203D20704576656E742E7461726765742E706172656E74456C656D656E742E69643B0D0A202020202020202020207D0D0A202020202020202020202462';
wwv_flow_api.g_varchar2_table(164) := '7574746F6E203D2024286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60293B0D0A202020202020202020202F2F20446570656E64696E67206F6E20686F77206120636C69636B206576656E742077617320726169736564';
wwv_flow_api.g_varchar2_table(165) := '20286D6F757365206F7220636F6465292C206120646966666572656E74206974656D206973206164647265737365640D0A20202020202020202020696620282124627574746F6E2E686173436C61737328435F415045585F425554544F4E2929207B0D0A';
wwv_flow_api.g_varchar2_table(166) := '20202020202020202020202024627574746F6E203D2024286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E706172656E7428435F425554544F4E293B0D0A202020202020202020207D0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(167) := '627265616B3B0D0A20202020202020206361736520435F4B455950524553535F4556454E543A0D0A2020202020202020202070726F70732E74726967676572696E67456C656D656E742E6964203D20704576656E742E7461726765742E69643B0D0A2020';
wwv_flow_api.g_varchar2_table(168) := '20202020202020202F2F2049662074686520454E5445522D6B65792077617320707265737365642C20746865206576656E742074797065206973206368616E67656420746F2027656E7465722720746F20616C6C6F7720666F7220656173792064657465';
wwv_flow_api.g_varchar2_table(169) := '6374696F6E2077697468696E204144430D0A202020202020202020207377697463682028704576656E742E6B6579436F646529207B0D0A202020202020202020202020636173652031333A0D0A202020202020202020202020202070726F70732E747269';
wwv_flow_api.g_varchar2_table(170) := '67676572696E67456C656D656E742E6576656E74203D20435F454E5445525F4556454E543B0D0A2020202020202020202020202020627265616B3B0D0A2020202020202020202020202F2F20616464206F74686572206B657920636F6465732068657265';
wwv_flow_api.g_varchar2_table(171) := '206966206E65636573736172790D0A202020202020202020207D0D0A20202020202020202020627265616B3B0D0A202020202020202064656661756C743A0D0A2020202020202020202070726F70732E74726967676572696E67456C656D656E742E6964';
wwv_flow_api.g_varchar2_table(172) := '203D20704576656E742E7461726765742E69643B0D0A2020202020207D0D0A202020202020617065782E64656275672E696E666F28604576656E742027247B70726F70732E74726967676572696E67456C656D656E742E6576656E747D27207261697365';
wwv_flow_api.g_varchar2_table(173) := '642061742054726967676572696E6720656C656D656E742027247B70726F70732E74726967676572696E67456C656D656E742E69647D2760293B0D0A202020207D0D0A20207D3B202F2F2067657454726967676572696E67456C656D656E740D0A0D0A0D';
wwv_flow_api.g_varchar2_table(174) := '0A20202F2A2A0D0A2020202046756E6374696F6E3A20686578546F436861720D0A2020202020204D6574686F6420746F20636173742061206865782D737472696E6720726570726573656E746174696F6E206372656174656420776974682055544C5F52';
wwv_flow_api.g_varchar2_table(175) := '41572E434153545F544F5F524157206261636B20746F20537472696E672E0D0A2020202020200D0A202020202020414443207375626D6974732069747320726573706F6E736520617320612068657820737472696E6720746F2063697263756D76656E74';
wwv_flow_api.g_varchar2_table(176) := '206573636170696E6720697373756573206265747765656E204A534F4E2C204A61766153637269707420616E64204A61766153637269707420636F6E7461696E696E67204A534F4E2E0D0A2020202020204173206120636F6E73657175656E63652C2074';
wwv_flow_api.g_varchar2_table(177) := '68652068657820737472696E67206D75737420626520636F6E766572746564206261636B20746F2061206E6F726D616C20737472696E6720696E206F7264657220746F20617070656E6420697420746F2074686520706167652E0D0A2020202020200D0A';
wwv_flow_api.g_varchar2_table(178) := '20202020506172616D657465723A0D0A20202020202070526177537472696E67202D204865782D656E636F64656420737472696E6720746F20636F6E76657274206261636B20746F2061206E6F726D616C20737472696E672E0D0A2020202020200D0A20';
wwv_flow_api.g_varchar2_table(179) := '20202052657475726E733A0D0A202020202020436F6E76657274656420537472696E670D0A2020202A2F0D0A2020636F6E737420686578546F43686172203D2066756E6374696F6E202870526177537472696E6729207B0D0A2020202076617220636F64';
wwv_flow_api.g_varchar2_table(180) := '65203D2027273B0D0A2020202076617220686578537472696E673B0D0A0D0A202020206966202870526177537472696E6729207B0D0A202020202020686578537472696E67203D2070526177537472696E672E746F537472696E6728293B0D0A20202020';
wwv_flow_api.g_varchar2_table(181) := '2020666F7220286C65742069203D20303B2069203C20686578537472696E672E6C656E6774683B2069202B3D203229207B0D0A2020202020202020636F6465202B3D20537472696E672E66726F6D43686172436F6465287061727365496E742868657853';
wwv_flow_api.g_varchar2_table(182) := '7472696E672E73756273747228692C2032292C20313629293B0D0A2020202020207D0D0A202020207D0D0A2020202072657475726E20636F64653B0D0A20207D3B202F2F686578546F436861720D0A20200D0A0D0A20202F2A2A200D0A2020202046756E';
wwv_flow_api.g_varchar2_table(183) := '6374696F6E3A206D61696E7461696E416E64436865636B4576656E744C6F636B0D0A2020202020204D6574686F6420746F2072656A656374207468652073616D65206576656E7420666F722061206365727461696E20616D6F756E74206F662074696D65';
wwv_flow_api.g_varchar2_table(184) := '20746F2070726576656E7420646F75626C6520657865637574696F6E206F66204144432072657175657374732E0D0A2020202020200D0A2020202020204576656E74732C207375636820617320454E544552206B6579206F7220636C69636B206D617920';
wwv_flow_api.g_varchar2_table(185) := '62652072616973656420717569636B6572207468616E204144432069732061626C6520746F20636F6E73756D65207468656E2C206C656164696E6720746F206120646F75626C650D0A2020202020207265717565737420616E64206120646F75626C6520';
wwv_flow_api.g_varchar2_table(186) := '657865637574696F6E206F662072756C65732E2054686973206D6179206C65616420746F2061206D6F64616C206469616C6F6720746F2062652073686F776E207477696365206F72206120646F75626C6520696E7365727420696E746F0D0A2020202020';
wwv_flow_api.g_varchar2_table(187) := '2061207461626C652C2072616973696E6720756E69717565206572726F7273206574632E0D0A2020202020200D0A202020202020546F20636174657220666F7220746869732C20616E206576656E7420697320707574206F6E20612070726F70732E7175';
wwv_flow_api.g_varchar2_table(188) := '6172616E74696E654C69737420666F722061206365727461696E20616D6F756E74206F662074696D652E2054686973206D6574686F642061646D696E69737465727320746869730D0A20202020202071756172616E74696E65206C69737420616E642063';
wwv_flow_api.g_varchar2_table(189) := '6865636B732077686574686572206974206973206F6B20746F20726169736520616E206576656E742E0D0A2020202A2F0D0A2020636F6E7374206D61696E7461696E416E64436865636B4576656E744C6F636B203D2066756E6374696F6E2028297B0D0A';
wwv_flow_api.g_varchar2_table(190) := '202020207661722069734F6B546F52616973654576656E74203D20747275653B0D0A202020207661722065203D2070726F70732E74726967676572696E67456C656D656E743B0D0A0D0A2020202069662028435F50524F5445435445445F4556454E5453';
wwv_flow_api.g_varchar2_table(191) := '2E696E6465784F6628652E6576656E7429203E202D31297B0D0A20202020202069662870726F70732E71756172616E74696E654C6973742E696E6465784F6628652E6576656E7429203E202D31297B0D0A20202020202020202F2F2049676E6F72652065';
wwv_flow_api.g_varchar2_table(192) := '76656E74206173206974206973206F6E2070726F70732E71756172616E74696E654C6973740D0A2020202020202020617065782E64656275672E696E666F286049676E6F72696E67204576656E742027247B652E6576656E747D272C206F6E2071756172';
wwv_flow_api.g_varchar2_table(193) := '616E74696E65206C69737460293B0D0A202020202020202069734F6B546F52616973654576656E74203D2066616C73653B0D0A2020202020207D0D0A202020202020656C73657B0D0A20202020202020202F2F2052656D6F766520616E79206578697374';
wwv_flow_api.g_varchar2_table(194) := '696E67206576656E74732066726F6D207468652071756575650D0A2020202020202020617065782E64656275672E696E666F2860436C656172206576656E74207175657565206166746572206C6F636B696E6720616E206576656E7460293B0D0A202020';
wwv_flow_api.g_varchar2_table(195) := '2020202020242827626F647927292E636C656172517565756528293B0D0A0D0A20202020202020202F2F20507574206576656E74206F6E2070726F70732E71756172616E74696E654C69737420746F2070726576656E7420646F75626C65206578656375';
wwv_flow_api.g_varchar2_table(196) := '74696F6E0D0A202020202020202070726F70732E71756172616E74696E654C6973742E7075736828652E6576656E74293B0D0A2020202020202020617065782E64656275672E696E666F28604576656E742027247B652E6576656E747D27207075736865';
wwv_flow_api.g_varchar2_table(197) := '64206F6E2071756172616E74696E6560293B0D0A0D0A20202020202020202F2F20506F70206576656E7420616674657220435F4C4F434B5F4C454E4754482066726F6D2071756172616E74696E650D0A202020202020202073657454696D656F7574280D';
wwv_flow_api.g_varchar2_table(198) := '0A2020202020202020202066756E6374696F6E28297B0D0A202020202020202020202070726F70732E71756172616E74696E654C697374203D205B5D3B0D0A2020202020202020202020617065782E64656275672E696E666F28604576656E742027247B';
wwv_flow_api.g_varchar2_table(199) := '652E6576656E747D2720706F707065642066726F6D2071756172616E74696E6560293B0D0A202020202020202020207D2C0D0A20202020202020202020435F4C4F434B5F4C454E4754480D0A2020202020202020293B0D0A0D0A20202020202020202F2F';
wwv_flow_api.g_varchar2_table(200) := '204164646974696F6E616C6C792064697361626C6520627574746F6E20746F2070726576656E7420646F75626C6520636C69636B2E2057696C6C20626520656E61626C65642062792074686520726573706F6E7365206F66204144430D0A202020202020';
wwv_flow_api.g_varchar2_table(201) := '202069662028652E6973436C69636B297B0D0A20202020202020202020617065782E64656275672E696E666F28604C6F636B696E6720627574746F6E2027247B652E69647D2760293B0D0A20202020202020202020617065782E6974656D28652E696429';
wwv_flow_api.g_varchar2_table(202) := '2E64697361626C6528293B0D0A20202020202020207D0D0A2020202020207D0D0A202020207D0D0A20202020656C736520696628435F50524F5445435445445F4556454E54532E696E6465784F662870726F70732E71756172616E74696E654C6973745B';
wwv_flow_api.g_varchar2_table(203) := '305D29203E202D31297B0D0A2020202020202F2F20436865636B207768657468657220616E206576656E742069732061637475616C6C7920696E20746865207175657565207468617420646F6573206E6F7420616C6C6F7720666F7220616E79206F7468';
wwv_flow_api.g_varchar2_table(204) := '6572206576656E7420746F206265207261697365640D0A202020202020617065782E64656275672E696E666F286049676E6F72696E67206576656E742027247B652E6576656E747D272C206576656E742027247B70726F70732E71756172616E74696E65';
wwv_flow_api.g_varchar2_table(205) := '4C6973745B305D7D27206973206F6E2071756172616E74696E65206C69737460293B0D0A20202020202069734F6B546F52616973654576656E74203D2066616C73653B0D0A202020207D0D0A2020202072657475726E2069734F6B546F52616973654576';
wwv_flow_api.g_varchar2_table(206) := '656E743B0D0A20207D3B202F2F206D61696E7461696E416E64436865636B4576656E744C6F636B0D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20616464427574746F6E48616E646C65720D0A20202020202042696E6473206120636F';
wwv_flow_api.g_varchar2_table(207) := '6E6669726D6174696F6E206F7220756E7361766564436F6E6669726D6174696F6E2063616C6C6261636B20746F206120627574746F6E0D0A0D0A20202020506172616D65746572733A0D0A20202020202070546172676574202D206A5175657279206974';
wwv_flow_api.g_varchar2_table(208) := '656D20726570726573656E74696E67207468652070616765206974656D20746F2062696E6420746F0D0A202020202020704D657373616765202D204D65737361676520746F2073686F772077697468696E2074686520636F6E6669726D6174696F6E0D0A';
wwv_flow_api.g_varchar2_table(209) := '202020202020704469616C6F675469746C65202D205469746C65206F6620746865206469616C6F670D0A2020202A2F0D0A2020636F6E737420616464427574746F6E48616E646C6572203D2066756E6374696F6E2028705461726765742C20704D657373';
wwv_flow_api.g_varchar2_table(210) := '6167652C20704469616C6F675469746C652C207043616C6C6261636B297B0D0A202020206C6574206576656E744C6973743B0D0A202020202F2F20456C656D656E7420697320616C736F2070726573656E74206F6E20706167652028636F756C64206265';
wwv_flow_api.g_varchar2_table(211) := '206D697373696E672064756520746F20636F6E646974696F6E290D0A202020206576656E744C697374203D20242E5F6461746128705461726765742E6765742830292C20276576656E747327293B0D0A2020202069662028747970656F66206576656E74';
wwv_flow_api.g_varchar2_table(212) := '4C69737420213D2027756E646566696E656427202626206576656E744C6973745B435F434C49434B5F4556454E545D29207B0D0A202020202020705461726765742E6F666628435F434C49434B5F4556454E54293B0D0A202020207D0D0A202020207054';
wwv_flow_api.g_varchar2_table(213) := '61726765742E6F6E28435F434C49434B5F4556454E542C0D0A2020202020207B2022616A61784964656E746966696572223A2070726F70732E616A61784964656E7469666965722C0D0A2020202020202020226D657373616765223A20704D6573736167';
wwv_flow_api.g_varchar2_table(214) := '652C0D0A20202020202020202270726F70732E706167654974656D73223A2070726F70732E706167654974656D732C0D0A2020202020202020227469746C65223A20704469616C6F675469746C650D0A2020202020207D2C0D0A2020202020207043616C';
wwv_flow_api.g_varchar2_table(215) := '6C6261636B293B0D0A20207D3B202F2F20616464427574746F6E48616E646C65720D0A0D0A0D0A20202F2A202B2B2B2B2B20454E44205052495641544520202B2B2B2B2B2B2B2B202A2F0D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B2B20434F52452046';
wwv_flow_api.g_varchar2_table(216) := '554E4354494F4E414C495459202B2B2B2B2B2B2B2B2B2B202A2F0D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2062696E644F627365727665724974656D730D0A2020202020204D6574686F64206964656E74696669657320616C';
wwv_flow_api.g_varchar2_table(217) := '6C20656C656D656E74732077686F73652076616C756573206D7573742062652073656E7420746F20746865206461746162617365207769746820616E7920726571756573742E0D0A20202020202054776F20706F737369626C6520776179732065786973';
wwv_flow_api.g_varchar2_table(218) := '7420746F2061646420616E206974656D20746F2074686973206F62736572766572206C6973743A0D0A2020202020200D0A2020202020202D20496E697469616C697A6174696F6E20636F6465206F662074686520706C7567696E2074686174206175746F';
wwv_flow_api.g_varchar2_table(219) := '6D61746963616C6C792064657465637473206974656D732074686174206861766520612076616C756520616E6420617265207265666572656E63656420627920706167652072756C65730D0A2020202020202D204578706C69636974206F627365727661';
wwv_flow_api.g_varchar2_table(220) := '74696F6E206173207265717565737465642062792061204144432072756C6520616374696F6E0D0A2020202020200D0A202020202020546865207365636F6E64206F7074696F6E2063616C6C732074686973206D6574686F642E0D0A202020200D0A2020';
wwv_flow_api.g_varchar2_table(221) := '2020506172616D657465723A0D0A2020202020207053656C6563746F72202D206A51756572792073656C6563746F7220746F206964656E7469667920746865206974656D2873292074686174206D757374206265206F62736572766564206578706C6963';
wwv_flow_api.g_varchar2_table(222) := '69746C790D0A2020202A2F0D0A202063746C2E62696E644F627365727665724974656D73203D2066756E6374696F6E20287053656C6563746F7229207B0D0A202020207661722073656C6563746F724C6973743B0D0A20202020696620287053656C6563';
wwv_flow_api.g_varchar2_table(223) := '746F7229207B0D0A20202020202073656C6563746F724C697374203D207053656C6563746F722E73706C697428272C27293B0D0A202020202020242E656163682873656C6563746F724C6973742C2066756E6374696F6E20286964782C20656C656D656E';
wwv_flow_api.g_varchar2_table(224) := '7429207B0D0A202020202020202069662028746869732E737562737472696E6728302C203129203D3D3D20272E2729207B0D0A202020202020202020202428656C656D656E74292E656163682866756E6374696F6E20286964782C20656C656D656E7429';
wwv_flow_api.g_varchar2_table(225) := '207B0D0A202020202020202020202020616464506167654974656D282428656C656D656E74292E61747472282769642729293B0D0A202020202020202020207D293B0D0A20202020202020207D0D0A2020202020202020656C7365207B0D0A2020202020';
wwv_flow_api.g_varchar2_table(226) := '202020202069662028242E696E417272617928656C656D656E742C2070726F70732E706167654974656D7329203D3D3D202D3129207B0D0A20202020202020202020202070726F70732E706167654974656D732E7075736828656C656D656E74293B0D0A';
wwv_flow_api.g_varchar2_table(227) := '202020202020202020207D0D0A20202020202020207D0D0A2020202020207D293B0D0A202020202020617065782E64656275672E696E666F28604164646974696F6E616C2070616765206974656D733A20247B7053656C6563746F727D60293B0D0A2020';
wwv_flow_api.g_varchar2_table(228) := '20207D0D0A20207D3B202F2F2062696E644F627365727665724974656D730D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A2062696E64436F6E6669726D6174696F6E48616E646C65720D0A20202020202053686F7773206120636F6E';
wwv_flow_api.g_varchar2_table(229) := '6669726D6174696F6E206469616C6F67207072696F7220746F2072616973696E672074686520414443206576656E74206E6F74696669636174696F6E2E0D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020705461726765';
wwv_flow_api.g_varchar2_table(230) := '74202D206A5175657279206974656D20726570726573656E74696E67207468652070616765206974656D20746F2062696E6420746F0D0A202020202020704D657373616765202D204D65737361676520746F2073686F772077697468696E207468652063';
wwv_flow_api.g_varchar2_table(231) := '6F6E6669726D6174696F6E0D0A202020202020704469616C6F675469746C65202D205469746C65206F6620746865206469616C6F670D0A2020202020207041706578416374696F6E202D204F7074696F6E616C204170657820616374696F6E20636F6D6D';
wwv_flow_api.g_varchar2_table(232) := '616E64206E616D650D0A2020202A2F0D0A202063746C2E62696E64436F6E6669726D6174696F6E48616E646C6572203D2066756E6374696F6E28705461726765742C20704D6573736167652C20704469616C6F675469746C652C20704170657841637469';
wwv_flow_api.g_varchar2_table(233) := '6F6E297B0D0A202020206C657420696E6E657243616C6C6261636B3B0D0A202020206C65742063616C6C6261636B3B0D0A202020202F2F2048616E646C65206576656E74206F6E6C7920616674657220636F6E6669726D6174696F6E2066726F6D207468';
wwv_flow_api.g_varchar2_table(234) := '6520757365720D0A20202020696620287041706578416374696F6E297B0D0A202020202020696E6E657243616C6C6261636B203D2066756E6374696F6E2829207B617065782E616374696F6E732E696E766F6B65287041706578416374696F6E293B7D3B';
wwv_flow_api.g_varchar2_table(235) := '0D0A202020207D20656C7365207B0D0A202020202020696E6E657243616C6C6261636B203D206368616E676543616C6C6261636B3B0D0A202020207D0D0A2020202063616C6C6261636B203D2066756E6374696F6E28704576656E7429207B6164632E72';
wwv_flow_api.g_varchar2_table(236) := '656E64657265722E636F6E6669726D5265717565737428704576656E742C20696E6E657243616C6C6261636B2C20705461726765742E61747472282769642729293B7D3B0D0A20202020616464427574746F6E48616E646C657228705461726765742C20';
wwv_flow_api.g_varchar2_table(237) := '704D6573736167652C20704469616C6F675469746C652C2063616C6C6261636B293B0D0A20207D3B202F2F2062696E64436F6E6669726D6174696F6E48616E646C65720D0A0D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A2062696E';
wwv_flow_api.g_varchar2_table(238) := '64556E7361766564436F6E6669726D6174696F6E48616E646C65720D0A20202020202053686F7773206120636F6E6669726D6174696F6E206469616C6F67207072696F7220746F2072616973696E672074686520414443206576656E74206E6F74696669';
wwv_flow_api.g_varchar2_table(239) := '636174696F6E20696620756E7361766564206368616E676573206578697374206F6E20706167652E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020202070546172676574202D206A5175657279206974656D207265707265';
wwv_flow_api.g_varchar2_table(240) := '73656E74696E67207468652070616765206974656D20746F2062696E6420746F0D0A202020202020704D657373616765202D204D65737361676520746F2073686F772077697468696E2074686520636F6E6669726D6174696F6E0D0A2020202020207044';
wwv_flow_api.g_varchar2_table(241) := '69616C6F675469746C65202D205469746C65206F6620746865206469616C6F670D0A2020202A2F0D0A202063746C2E62696E64556E7361766564436F6E6669726D6174696F6E48616E646C6572203D2066756E6374696F6E28705461726765742C20704D';
wwv_flow_api.g_varchar2_table(242) := '6573736167652C20704469616C6F675469746C65297B0D0A20202020616464427574746F6E48616E646C657228705461726765742C20704D6573736167652C20704469616C6F675469746C652C20756E736176656443616C6C6261636B293B0D0A20207D';
wwv_flow_api.g_varchar2_table(243) := '3B202F2F2062696E64556E7361766564436F6E6669726D6174696F6E48616E646C65720D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2066696E644974656D56616C75650D0A2020202020204D6574686F6420746F207065727369';
wwv_flow_api.g_varchar2_table(244) := '7374207468652076616C7565206F6620612070616765206974656D2E0D0A2020202020200D0A2020202020205768656E20612063616C6C20746F207265667265736820612070616765206974656D206973206973737565642C207468652076616C756520';
wwv_flow_api.g_varchar2_table(245) := '6F662074686973206974656D20697320726573657420746F204E554C4C20627920415045582E0D0A20202020202054686973206D6574686F6420616C6C6F777320746F2073746F7265207468652076616C7565206F6620746865206974656D206265666F';
wwv_flow_api.g_varchar2_table(246) := '72652072656672657368696E6720697420616E6420746F20726573657420697420746F20746869732076616C756520616674657220726566726573682E0D0A2020202020200D0A20202020506172616D657465723A0D0A202020202020704974656D4964';
wwv_flow_api.g_varchar2_table(247) := '202D204944206F66207468652070616765206974656D2E2050657263656976656420746F20626520756E697175650D0A2020202A2F0D0A202063746C2E66696E644974656D56616C7565203D2066756E6374696F6E28704974656D496429207B0D0A2020';
wwv_flow_api.g_varchar2_table(248) := '202076617220726573756C74203D20242E677265702870726F70732E6C6173744974656D56616C7565732C2066756E6374696F6E20286529207B0D0A20202020202072657475726E20652E6964203D3D3D20704974656D49643B0D0A202020207D293B0D';
wwv_flow_api.g_varchar2_table(249) := '0A0D0A2020202069662028726573756C742E6C656E677468203E203029207B0D0A20202020202072657475726E20726573756C745B305D2E76616C75653B0D0A202020207D0D0A20207D3B202F2F2066696E644974656D56616C75650D0A20200D0A0D0A';
wwv_flow_api.g_varchar2_table(250) := '20202F2A2A0D0A2020202046756E6374696F6E3A206765745061676553746174650D0A2020202020204D6574686F6420746F207265747269657665207468652061637475616C6C792076616C696420706167652073746174650D0A2020202A2F0D0A2020';
wwv_flow_api.g_varchar2_table(251) := '63746C2E676574506167655374617465203D2066756E6374696F6E2829207B0D0A2020202072657475726E2070726F70732E7061676553746174653B0D0A20207D3B202F2F206765745061676553746174650D0A20200D0A0D0A20202F2A2A0D0A202020';
wwv_flow_api.g_varchar2_table(252) := '2046756E6374696F6E3A207365745061676553746174650D0A2020202020204D6574686F6420746F20736574207468652061637475616C6C792076616C696420706167652073746174652E0D0A0D0A20202020506172616D657465723A0D0A2020202020';
wwv_flow_api.g_varchar2_table(253) := '2070506167655374617465202D20496E7374616E6365206F66207468652061637475616C6C792076616C696420706167652073746174650D0A2020202A2F0D0A202063746C2E736574506167655374617465203D2066756E6374696F6E28705061676553';
wwv_flow_api.g_varchar2_table(254) := '7461746529207B0D0A2020202070726F70732E706167655374617465203D20705061676553746174653B0D0A20207D3B202F2F206765745061676553746174650D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20707573685061676549';
wwv_flow_api.g_varchar2_table(255) := '74656D0D0A2020202020205075736820612070616765206974656D206F6E746F207468652070726F70732E706167654974656D732070726F70657274792E200D0A0D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D2049';
wwv_flow_api.g_varchar2_table(256) := '44206F66207468652070616765206974656D20746F20707573680D0A2020202A2F0D0A202063746C2E70757368506167654974656D203D2066756E6374696F6E28704974656D4964297B0D0A2020202069662028242E696E417272617928704974656D49';
wwv_flow_api.g_varchar2_table(257) := '642C2070726F70732E706167654974656D7329203D3D3D202D3129207B0D0A20202020202070726F70732E706167654974656D732E7075736828704974656D4964293B0D0A20202020202062696E644576656E7428704974656D49642C20435F4348414E';
wwv_flow_api.g_varchar2_table(258) := '47455F4556454E54293B0D0A202020207D0D0A20207D3B202F2F2070757368506167654974656D0D0A20200D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A20686173556E73617665644368616E6765730D0A2020202020204D657468';
wwv_flow_api.g_varchar2_table(259) := '6F6420746F2064657465637420756E7361766564206368616E676573206F6E2074686520706167652E0D0A2020202020200D0A2020202020204973207573656420696E20636F6E6A756E6374696F6E2077697468207B407365653A2072656D656D626572';
wwv_flow_api.g_varchar2_table(260) := '70726F70732E706167654974656D7374617475737D207768696368206861732073617665642074686520696E697469616C207061676520737461747573206265666F72652E0D0A202020202020436F6D7061726573207468652061637475616C2076616C';
wwv_flow_api.g_varchar2_table(261) := '75657320616761696E73742070726F70732E70616765537461746520616E642072657475726E732074727565206966206174206C65617374206F6E652076616C756520686173206368616E6765642E0D0A2020202020200D0A20202020506172616D6574';
wwv_flow_api.g_varchar2_table(262) := '65723A0D0A20202020202070506167654974656D73202D204F7074696F6E616C206172726179206F6620616C6C2070616765206974656D2069647320746F20636170747572652E20496620656D7074792C20616C6C2070616765206974656D7320617265';
wwv_flow_api.g_varchar2_table(263) := '2063617074757265642E0D0A2020202A2F0D0A202063746C2E686173556E73617665644368616E676573203D2066756E6374696F6E2870506167654974656D73297B0D0A20202020766172206974656D4C6973743B0D0A20202020766172206973446966';
wwv_flow_api.g_varchar2_table(264) := '666572656E74203D2066616C73653B0D0A202020200D0A202020202F2F20496E697469616C697A650D0A2020202041727261792E697341727261792870506167654974656D7329203F206974656D4C697374203D2070506167654974656D73203A206974';
wwv_flow_api.g_varchar2_table(265) := '656D4C697374203D202428435F494E5055545F53454C4543544F52293B0D0A202020200D0A20202020242E65616368286974656D4C6973742C2066756E6374696F6E286974656D297B0D0A2020202020206974656D203D206974656D4C6973745B697465';
wwv_flow_api.g_varchar2_table(266) := '6D5D3B0D0A2020202020206966286974656D2E6964297B0D0A20202020202020206974656D203D206974656D2E69643B0D0A2020202020207D3B0D0A202020202020617065782E64656275672E696E666F2860436F6D706172696E6720247B6974656D7D';
wwv_flow_api.g_varchar2_table(267) := '60293B0D0A2020202020206966202870726F70732E7061676553746174652E6974656D4D61702E686173286974656D292026262070726F70732E7061676553746174652E6974656D4D61702E676574286974656D2920213D20617065782E6974656D2869';
wwv_flow_api.g_varchar2_table(268) := '74656D292E67657456616C75652829297B0D0A20202020202020206973446966666572656E74203D20747275653B0D0A202020202020202072657475726E2066616C73653B0D0A2020202020207D0D0A202020207D293B0D0A2020202072657475726E20';
wwv_flow_api.g_varchar2_table(269) := '6973446966666572656E743B0D0A20207D3B202F2F20686173556E73617665644368616E6765730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2070617573654368616E67654576656E74447572696E67526566726573680D0A202020';
wwv_flow_api.g_varchar2_table(270) := '20202052656672657368207468726F77732061206368616E6765206576656E742077686963682063616E206C65616420746F20756E77616E746564204D414E4441544F525920636865636B73207072696F7220746F2073657474696E6720746865207661';
wwv_flow_api.g_varchar2_table(271) := '6C75650D0A2020202020206368616E6765206576656E747320617265207468657265666F72652072656D6F76656420616E6420726561747461636865642061667465722073657474696E67207468652076616C75652E0D0A0D0A20202020506172616D65';
wwv_flow_api.g_varchar2_table(272) := '746572733A0D0A202020202020704974656D4964202D204944206F66207468652070616765206974656D20746861742067657473207265667265736865640D0A202020202020704974656D56616C7565202D2041637475616C2076616C7565206F662074';
wwv_flow_api.g_varchar2_table(273) := '68652070616765206974656D0D0A2020202A2F0D0A202063746C2E70617573654368616E67654576656E74447572696E6752656672657368203D2066756E6374696F6E28704974656D49642C20704974656D56616C7565297B0D0A202020207661722024';
wwv_flow_api.g_varchar2_table(274) := '6974656D203D2024286023247B704974656D49647D60293B0D0A20202020766172206E6F6465203D20246974656D2E6765742830293B0D0A20202020766172206974656D4576656E74733B0D0A202020207661722074656D706F72616C4576656E74733B';
wwv_flow_api.g_varchar2_table(275) := '0D0A0D0A2020202069662028246974656D2E6C656E677468203E2030297B0D0A2020202020202F2F20706572736973742061637475616C6C792061737369676E6564206576656E742068616E646C6572730D0A2020202020206974656D4576656E747320';
wwv_flow_api.g_varchar2_table(276) := '3D20242E5F64617461286E6F64652C20276576656E747327293B0D0A2020202020200D0A2020202020202F2F204D616B652061206465657020636F7079206F66206576656E74732C2072656D6F7665206368616E676520616E642061737369676E206974';
wwv_flow_api.g_varchar2_table(277) := '20746F20746865206974656D0D0A20202020202074656D706F72616C4576656E7473203D20242E657874656E6428747275652C205B5D2C206974656D4576656E7473293B0D0A20202020202064656C6574652074656D706F72616C4576656E74732E6368';
wwv_flow_api.g_varchar2_table(278) := '616E67653B0D0A202020202020242E5F64617461286E6F64652C20276576656E7473272C2074656D706F72616C4576656E7473293B0D0A2020202020200D0A202020202020246974656D0D0A2020202020202E6F6E6528435F415045585F41465445525F';
wwv_flow_api.g_varchar2_table(279) := '524546524553482C2066756E6374696F6E2865297B0D0A202020202020202076617220706167655374617465203D2063746C2E67657450616765537461746528293B0D0A202020202020202069662028704974656D56616C7565297B0D0A202020202020';
wwv_flow_api.g_varchar2_table(280) := '20202020617065782E6974656D28704974656D4964292E73657456616C756528704974656D56616C75652C20704974656D56616C75652C2074727565293B0D0A202020202020202020202F2F20696620776520617265206F6273657276696E6720746869';
wwv_flow_api.g_varchar2_table(281) := '73206974656D20666F72206368616E6765732C20757064617465207468652076616C756520746F2070726576656E742066616C73652074727565206368616E6765206D657373616765730D0A20202020202020202020696620287061676553746174652E';
wwv_flow_api.g_varchar2_table(282) := '6974656D4D61702E68617328704974656D496429297B0D0A2020202020202020202020207061676553746174652E6974656D4D61702E73657428704974656D49642C20704974656D56616C7565293B0D0A20202020202020202020202063746C2E736574';
wwv_flow_api.g_varchar2_table(283) := '50616765537461746528706167655374617465293B0D0A202020202020202020207D3B0D0A20202020202020207D3B200D0A20202020202020202F2F20726573746F7265206F726967696E616C206576656E74730D0A2020202020202020242E5F646174';
wwv_flow_api.g_varchar2_table(284) := '61286E6F64652C20276576656E7473272C206974656D4576656E7473293B0D0A2020202020207D293B0D0A202020207D3B0D0A20207D3B202F2F2070617573654368616E67654576656E74447572696E67526566726573680D0A0D0A0D0A20202F2A2A0D';
wwv_flow_api.g_varchar2_table(285) := '0A2020202046756E6374696F6E3A207365744164646974696F6E616C4974656D730D0A2020202020204D6574686F6420746F20657874656E6420746865206C697374206F66206974656D7320746F20696E636C75646520696E2074686520706167652073';
wwv_flow_api.g_varchar2_table(286) := '746174652E200D0A0D0A20202020506161726D65746572733A0D0A202020202020704974656D4C697374202D204172726179206F66206974656D206E616D657320746F2061646420746F2074686520706167652073746174650D0A2020202A2F0D0A2020';
wwv_flow_api.g_varchar2_table(287) := '63746C2E7365744164646974696F6E616C4974656D73203D2066756E6374696F6E28704974656D4C697374297B0D0A2020202070726F70732E6164646974696F6E616C4974656D73203D20704974656D4C6973743B0D0A20207D202F2F20736574416464';
wwv_flow_api.g_varchar2_table(288) := '6974696F6E616C4974656D730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073657454726967676572696E67456C656D656E740D0A2020202020204D6574686F6420746F206F7665727772697465207468652070726F70732E747269';
wwv_flow_api.g_varchar2_table(289) := '67676572696E67456C656D656E742E20416C6C6F777320666F7220637573746F6D20414443206576656E742068616E646C696E672E200D0A0D0A20202020506161726D65746572733A0D0A202020202020704964202D204944206F662074686520747269';
wwv_flow_api.g_varchar2_table(290) := '67676572696E67207061676520656C656D656E742E204E6F74206E65636573736172696C7920612070616765206974656D0D0A2020202020207044617461202D204F7074696F6E616C206576656E74206461746120746F207061737320746F204144430D';
wwv_flow_api.g_varchar2_table(291) := '0A202020202020704576656E74202D204576656E7420746861742068617320746F206265207261697365642E204E6F74206E65636573736172696C7920612062726F77736572206F722041504558206576656E740D0A202020202020704973436C69636B';
wwv_flow_api.g_varchar2_table(292) := '202D20466C616720746F20696E6469636174652077686574686572206120636C69636B206576656E742068617320746F20626520626F756E642E20436F6E74726F6C732068616E646C696E67206F66206576656E742070726F74656374696F6E0D0A2020';
wwv_flow_api.g_varchar2_table(293) := '202A2F0D0A202063746C2E73657454726967676572696E67456C656D656E74203D2066756E6374696F6E287049642C20704576656E742C2070446174612C20704973436C69636B297B0D0A2020202070726F70732E74726967676572696E67456C656D65';
wwv_flow_api.g_varchar2_table(294) := '6E742E6964203D207049643B0D0A2020202070726F70732E74726967676572696E67456C656D656E742E6576656E74203D20704576656E743B0D0A2020202070726F70732E74726967676572696E67456C656D656E742E64617461203D2070446174613B';
wwv_flow_api.g_varchar2_table(295) := '0D0A2020202070726F70732E74726967676572696E67456C656D656E742E6973436C69636B203D20704973436C69636B207C7C2066616C73653B0D0A20207D202F2F2073657454726967676572696E67456C656D656E740D0A0D0A0D0A20202F2A2A0D0A';
wwv_flow_api.g_varchar2_table(296) := '2020202046756E6374696F6E3A207365744C6173744974656D56616C7565730D0A2020202020205365747320746865206C697374206F662070616765206974656D732074686174207265636569766564206368616E676573206C6174656C790D0A202020';
wwv_flow_api.g_varchar2_table(297) := '2A2F0D0A202063746C2E7365744C6173744974656D56616C756573203D2066756E6374696F6E2870506167654974656D73297B0D0A2020202070726F70732E6C6173744974656D56616C756573203D2070506167654974656D733B0D0A20207D3B0D0A20';
wwv_flow_api.g_varchar2_table(298) := '200D0A20200D0A20202F2A2A0D0A2020202046756E636474696F6E3A206765745374616E646172644D6573736167650D0A2020202020204D6574686F6420746F2072657472696576652061207374616E64617264206D657373616765206173206964656E';
wwv_flow_api.g_varchar2_table(299) := '74696669656420627920704D65737361676549440D0A2020202020200D0A20202020506172616D65746572733A0D0A202020202020704D6573736167654944202D204944206F6620746865207374616E64617264206D65737361676520746F2072657472';
wwv_flow_api.g_varchar2_table(300) := '696576650D0A2020202A2F0D0A202063746C2E6765745374616E646172644D657373616765203D2066756E6374696F6E28704D6573736167654944297B0D0A2020202072657475726E2070726F70732E7374616E646172644D657373616765735B704D65';
wwv_flow_api.g_varchar2_table(301) := '737361676549445D3B0D0A20207D3B0D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20657865637574650D0A20202020202043656E7472616C206576656E742068616E646C65722C2063616C6C7320414443206173796E6368726F';
wwv_flow_api.g_varchar2_table(302) := '6E6F75736C7920616E642068616E646C65732041444320726573706F6E73650D0A2020202A2F0D0A202063746C2E65786563757465203D2066756E6374696F6E28297B0D0A0D0A202020206966286D61696E7461696E416E64436865636B4576656E744C';
wwv_flow_api.g_varchar2_table(303) := '6F636B2829297B0D0A20202020202069662870726F70732E74726967676572696E67456C656D656E742E646174612026262070726F70732E6164646974696F6E616C4974656D73297B0D0A202020202020202070726F70732E706167654974656D73203D';
wwv_flow_api.g_varchar2_table(304) := '206E657720536574285B2E2E2E70726F70732E706167654974656D732C202E2E2E70726F70732E6164646974696F6E616C4974656D735D293B0D0A202020202020202070726F70732E706167654974656D73203D2041727261792E66726F6D2870726F70';
wwv_flow_api.g_varchar2_table(305) := '732E706167654974656D73293B0D0A2020202020207D0D0A2020202020200D0A202020202020617065782E64656275672E696E666F28604144432068616E646C6573206576656E7420247B70726F70732E74726967676572696E67456C656D656E742E65';
wwv_flow_api.g_varchar2_table(306) := '76656E747D60293B0D0A202020202020617065782E64656275672E696E666F28604144432073656E647320706167654974656D7320247B70726F70732E706167654974656D732E6A6F696E28297D60293B0D0A2020202020207365727665722E706C7567';
wwv_flow_api.g_varchar2_table(307) := '696E280D0A202020202020202070726F70732E616A61784964656E7469666965722C0D0A20202020202020207B0D0A2020202020202020202022783031223A2070726F70732E74726967676572696E67456C656D656E742E69642C0D0A20202020202020';
wwv_flow_api.g_varchar2_table(308) := '20202022783032223A2070726F70732E74726967676572696E67456C656D656E742E6576656E742C0D0A2020202020202020202022783033223A204A534F4E2E737472696E676966792870726F70732E74726967676572696E67456C656D656E742E6461';
wwv_flow_api.g_varchar2_table(309) := '7461292C0D0A2020202020202020202022706167654974656D73223A2070726F70732E706167654974656D730D0A20202020202020207D2C0D0A20202020202020207B0D0A20202020202020202020226461746154797065223A202268746D6C222C0D0A';
wwv_flow_api.g_varchar2_table(310) := '202020202020202020202273756363657373223A2066756E6374696F6E202870414443526573706F6E736529207B0D0A2020202020202020202020206966202870726F70732E74726967676572696E67456C656D656E742E6973436C69636B29207B0D0A';
wwv_flow_api.g_varchar2_table(311) := '2020202020202020202020202020617065782E6974656D2870726F70732E74726967676572696E67456C656D656E742E6964292E656E61626C6528293B0D0A2020202020202020202020207D0D0A20202020202020202020202065786563757465436F64';
wwv_flow_api.g_varchar2_table(312) := '652870414443526573706F6E7365293B0D0A202020202020202020207D0D0A20202020202020207D0D0A202020202020293B0D0A202020207D0D0A20207D3B202F2F20657865637574650D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F';
wwv_flow_api.g_varchar2_table(313) := '6E3A20696E69740D0A202020202020496E697469616C697A6174696F6E206D6574686F642E0D0A2020202020200D0A20202020202054686973206D6574686F642069732063616C6C656420647572696E672072656E646572696E67206F66207468652041';
wwv_flow_api.g_varchar2_table(314) := '50455820706167652E20497420696E7374616C6C732074686520706C7567696E206F6E20746865207061676520616E64206372656174657320746865206E6563657373617279206576656E742068616E646C65722E0D0A202020202020546F2061636869';
wwv_flow_api.g_varchar2_table(315) := '766520746869732C20706172616D65746572203C70416374696F6E3E207769746820746865206E656365737361727920617474726962757465732069732070617373656420696E20616E64206576616C75617465642E0D0A0D0A20202020506172616D65';
wwv_flow_api.g_varchar2_table(316) := '7465723A0D0A20202020202070416374696F6E202D204A736F6E206F626A6563742070617373656420696E20647572696E6720696E697469616C697A6174696F6E0D0A2020202A2F0D0A20206164632E696E6974203D2066756E6374696F6E2028704163';
wwv_flow_api.g_varchar2_table(317) := '74696F6E29207B0D0A0D0A202020202F2F2062696E6420616C6C2070616765206974656D73207265717569726564206279204144430D0A2020202070726F70732E62696E644974656D73203D20242E70617273654A534F4E2870416374696F6E2E617474';
wwv_flow_api.g_varchar2_table(318) := '72696275746530312E7265706C616365282F7E2F672C2027222729293B0D0A0D0A202020202F2F207265676973746572206164632E72656E6465726572206E616D657370616365206F626A65637420616E6420416A6178206964656E7469666965720D0A';
wwv_flow_api.g_varchar2_table(319) := '202020206164632E72656E6465726572203D206576616C2870416374696F6E2E6174747269627574653033293B0D0A2020202070726F70732E616A61784964656E746966696572203D2070416374696F6E2E616A61784964656E7469666965723B0D0A20';
wwv_flow_api.g_varchar2_table(320) := '20202070726F70732E6576656E74446174612E616A61784964656E746966696572203D2070726F70732E616A61784964656E7469666965723B0D0A2020202070726F70732E6576656E74446174612E706167654974656D73203D2070726F70732E706167';
wwv_flow_api.g_varchar2_table(321) := '654974656D733B0D0A0D0A202020206966202870416374696F6E2E617474726962757465303229207B0D0A202020202020617065782E64656275672E696E666F2827526571756972656420706167654974656D733A2027202B2070416374696F6E2E6174';
wwv_flow_api.g_varchar2_table(322) := '747269627574653032293B0D0A20202020202070726F70732E706167654974656D73203D2070416374696F6E2E61747472696275746530322E73706C697428272C27293B0D0A202020207D0D0A202020200D0A202020206966202870416374696F6E2E61';
wwv_flow_api.g_varchar2_table(323) := '7474726962757465303629207B0D0A20202020202070726F70732E7374616E646172644D65737361676573203D204A534F4E2E70617273652870416374696F6E2E6174747269627574653036293B0D0A202020207D0D0A0D0A2020202063746C2E62696E';
wwv_flow_api.g_varchar2_table(324) := '644F627365727665724974656D732870416374696F6E2E6174747269627574653035293B0D0A0D0A202020202F2F2050726570617265207061676520666F72204144432075736167650D0A2020202062696E644576656E747328293B0D0A202020206170';
wwv_flow_api.g_varchar2_table(325) := '65782E64656275672E696E666F282741444320696E697469616C697A656427293B0D0A0D0A202020202F2F206578656375746520696E697469616C204A61766153637269707420636F64652070617373656420696E2066726F6D20746865207365727665';
wwv_flow_api.g_varchar2_table(326) := '720D0A2020202065786563757465436F646528686578546F436861722870416374696F6E2E617474726962757465303429293B0D0A20207D3B202F2F20696E69740D0A0D0A20202F2A202B2B2B2B2B2B2B2B2B20454E4420434F52452046554E4354494F';
wwv_flow_api.g_varchar2_table(327) := '4E414C495459202B2B2B2B2B2B2B2B2B2B2B202A2F0D0A0D0A7D2864652E636F6E6465732E706C7567696E2E6164632C20617065782E6A51756572792C20617065782E73657276657229293B0D0A0D0A0D0A2F2F20496E7465726661636520746F204150';
wwv_flow_api.g_varchar2_table(328) := '455820706C7567696E206D656368616E69736D2E0D0A2F2F20466F7220736F6D6520726561736F6E204920646F6E2274207265616C6C7920756E6465727374616E642C20697420697320696D706F737369626C650D0A2F2F20746F2074656C6C20415045';
wwv_flow_api.g_varchar2_table(329) := '5820746F206469726563746C79207573652061206E616D657370616365206F626A65637420686572652E0D0A66756E6374696F6E2064655F636F6E6465735F706C7567696E5F6164632829207B0D0A202064652E636F6E6465732E706C7567696E2E6164';
wwv_flow_api.g_varchar2_table(330) := '632E696E697428746869732E616374696F6E293B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740441012972785499)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/controller.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722064653D64657C7C7B7D3B66756E6374696F6E2064655F636F6E6465735F706C7567696E5F61646328297B64652E636F6E6465732E706C7567696E2E6164632E696E697428746869732E616374696F6E297D64652E636F6E6465733D64652E636F';
wwv_flow_api.g_varchar2_table(2) := '6E6465737C7C7B7D2C64652E636F6E6465732E706C7567696E3D64652E636F6E6465732E706C7567696E7C7C7B7D2C64652E636F6E6465732E706C7567696E2E6164633D64652E636F6E6465732E706C7567696E2E6164637C7C7B7D2C66756E6374696F';
wwv_flow_api.g_varchar2_table(3) := '6E286164632C242C736572766572297B2275736520737472696374223B636F6E737420435F4348414E47455F4556454E543D226368616E6765222C435F434C49434B5F4556454E543D22636C69636B222C435F44424C434C49434B5F4556454E543D2264';
wwv_flow_api.g_varchar2_table(4) := '626C636C69636B222C435F454E5445525F4556454E543D22656E746572222C435F4B455950524553535F4556454E543D226B65797072657373222C435F415045585F4245464F52455F524546524553483D22617065786265666F72657265667265736822';
wwv_flow_api.g_varchar2_table(5) := '2C435F415045585F41465445525F524546524553483D2261706578616674657272656672657368222C435F415045585F41465445525F434C4F53455F4449414C4F473D22617065786166746572636C6F73656469616C6F67222C435F4E4F5F5452494747';
wwv_flow_api.g_varchar2_table(6) := '4552494E475F4954454D3D22444F43554D454E54222C435F4C4F434B5F4C454E4754483D3230302C435F50524F5445435445445F4556454E54533D5B435F434C49434B5F4556454E542C435F44424C434C49434B5F4556454E542C435F454E5445525F45';
wwv_flow_api.g_varchar2_table(7) := '56454E545D2C435F424F44593D22626F6479222C435F425554544F4E3D22627574746F6E222C435F415045585F425554544F4E3D22742D427574746F6E222C435F494E5055545F53454C4543544F523D223A696E7075743A76697369626C653A6E6F7428';
wwv_flow_api.g_varchar2_table(8) := '627574746F6E29223B6164632E636F6E74726F6C6C65723D7B7D3B7661722063746C3D6164632E636F6E74726F6C6C65722C70726F70733D7B616A61784964656E7469666965723A22222C71756172616E74696E654C6973743A5B5D2C74726967676572';
wwv_flow_api.g_varchar2_table(9) := '696E67456C656D656E743A7B69643A22222C646174613A22222C6576656E743A22222C6973436C69636B3A21317D2C6576656E74446174613A7B616A61784964656E7469666965723A22222C706167654974656D733A22227D2C7061676553746174653A';
wwv_flow_api.g_varchar2_table(10) := '7B6974656D4D61703A6E6577204D61707D2C706167654974656D733A5B5D2C62696E644974656D733A5B5D2C6C6173744974656D56616C7565733A5B5D2C6164646974696F6E616C4974656D733A5B5D2C7374616E646172644D657373616765733A7B7D';
wwv_flow_api.g_varchar2_table(11) := '7D3B636F6E7374206368616E676543616C6C6261636B3D66756E6374696F6E28652C742C6E297B67657454726967676572696E67456C656D656E742865292C2428435F424F4459292E7175657565282866756E6374696F6E28297B6164632E616374696F';
wwv_flow_api.g_varchar2_table(12) := '6E732E73686F77576169745370696E6E6572286E292C63746C2E6578656375746528652C74297D29297D2C656E74657243616C6C6261636B3D66756E6374696F6E28652C742C6E297B67657454726967676572696E67456C656D656E742865292C70726F';
wwv_flow_api.g_varchar2_table(13) := '70732E74726967676572696E67456C656D656E742E6576656E743D3D3D435F454E5445525F4556454E54262628617065782E64656275672E696E666F2860456E7175657565696E67204576656E742027247B435F454E5445525F4556454E547D2760292C';
wwv_flow_api.g_varchar2_table(14) := '242822626F647922292E7175657565282866756E6374696F6E28297B6164632E616374696F6E732E73686F77576169745370696E6E6572286E292C63746C2E657865637574652874297D2929297D2C756E736176656443616C6C6261636B3D66756E6374';
wwv_flow_api.g_varchar2_table(15) := '696F6E28652C74297B67657454726967676572696E67456C656D656E742865292C2428435F424F4459292E7175657565282866756E6374696F6E28297B6164632E616374696F6E732E73686F77576169745370696E6E65722874292C63746C2E68617355';
wwv_flow_api.g_varchar2_table(16) := '6E73617665644368616E67657328293F6164632E72656E64657265722E636F6E6669726D5265717565737428652C6368616E676543616C6C6261636B293A6368616E676543616C6C6261636B2865297D29297D2C62696E644576656E743D66756E637469';
wwv_flow_api.g_varchar2_table(17) := '6F6E28652C742C6E297B76617220692C613B652E736561726368282F5B5C2E235C75303032303A5C5B5C5D5D2B2F293C30262628653D6023247B657D60292C28693D24286529292E6C656E6774683E30262628613D2266756E6374696F6E223D3D747970';
wwv_flow_api.g_varchar2_table(18) := '656F66206E3F6E3A766F69642030213D3D6E26266E2E6C656E6774683E303F6E65772046756E6374696F6E286E293A6368616E676543616C6C6261636B2C692E6F66662874292E6F6E28742C70726F70732E6576656E74446174612C61292C743D3D3D43';
wwv_flow_api.g_varchar2_table(19) := '5F4348414E47455F4556454E542626692E6F6E28435F415045585F4245464F52455F524546524553482C2866756E6374696F6E2874297B242874686973292E6F666628435F4348414E47455F4556454E54292C617065782E64656275672E696E666F2860';
wwv_flow_api.g_varchar2_table(20) := '4576656E742027247B435F4348414E47455F4556454E547D272070617573656420617420247B657D60297D29292E6F6E28435F415045585F41465445525F524546524553482C2866756E6374696F6E2874297B242874686973292E6F6E28435F4348414E';
wwv_flow_api.g_varchar2_table(21) := '47455F4556454E542C70726F70732E6576656E74446174612C61292C617065782E64656275672E696E666F28604576656E742027247B435F4348414E47455F4556454E547D272072652D65737461626C697368656420617420247B657D60297D2929297D';
wwv_flow_api.g_varchar2_table(22) := '2C62696E644576656E74733D66756E6374696F6E28297B242E656163682870726F70732E62696E644974656D732C2866756E6374696F6E28297B746869732E6576656E743D3D435F454E5445525F4556454E543F62696E644576656E7428746869732E69';
wwv_flow_api.g_varchar2_table(23) := '642C435F4B455950524553535F4556454E542C746869732E616374696F6E7C7C656E74657243616C6C6261636B293A2862696E644576656E7428746869732E69642C746869732E6576656E742C746869732E616374696F6E292C746869732E6576656E74';
wwv_flow_api.g_varchar2_table(24) := '3D3D3D435F4348414E47455F4556454E542626616464506167654974656D28746869732E696429297D29297D2C616464506167654974656D3D66756E6374696F6E2865297B2D313D3D3D242E696E417272617928652C70726F70732E706167654974656D';
wwv_flow_api.g_varchar2_table(25) := '7329262670726F70732E706167654974656D732E707573682865297D2C65786563757465436F64653D66756E6374696F6E2865297B76617220743B65262628636F6E736F6C652E6C6F672822526573706F6E73652072656365697665643A205C6E222B65';
wwv_flow_api.g_varchar2_table(26) := '292C2428435F424F4459292E617070656E642865292C743D2223222B242865292E617474722822696422292C242874292E72656D6F76652829292C2428435F424F4459292E6465717565756528297D2C67657454726967676572696E67456C656D656E74';
wwv_flow_api.g_varchar2_table(27) := '3D66756E6374696F6E2865297B76617220743B69662870726F70732E74726967676572696E67456C656D656E742E69643D435F4E4F5F54524947474552494E475F4954454D2C70726F70732E74726967676572696E67456C656D656E742E6576656E743D';
wwv_flow_api.g_varchar2_table(28) := '652E747970652C70726F70732E74726967676572696E67456C656D656E742E646174613D652E646174612C70726F70732E74726967676572696E67456C656D656E742E6973436C69636B3D21312C766F69642030213D3D652E746172676574297B737769';
wwv_flow_api.g_varchar2_table(29) := '7463682870726F70732E74726967676572696E67456C656D656E742E6576656E74297B6361736520435F415045585F41465445525F434C4F53455F4449414C4F473A70726F70732E74726967676572696E67456C656D656E742E69643D652E6375727265';
wwv_flow_api.g_varchar2_table(30) := '6E745461726765742E69643B627265616B3B6361736520435F4348414E47455F4556454E543A70726F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E69642C22726164696F22213D3D28743D24286023247B70726F70';
wwv_flow_api.g_varchar2_table(31) := '732E74726967676572696E67456C656D656E742E69647D6029292E617474722822747970652229262622636865636B626F7822213D3D742E6174747228227479706522297C7C2870726F70732E74726967676572696E67456C656D656E742E69643D742E';
wwv_flow_api.g_varchar2_table(32) := '706172656E747328222E726164696F5F67726F75702C2E636865636B626F785F67726F757022292E61747472282269642229292C70726F70732E74726967676572696E67456C656D656E742E6964262670726F70732E74726967676572696E67456C656D';
wwv_flow_api.g_varchar2_table(33) := '656E742E69642E6D61746368282F6F6A2E2A2F2926262870726F70732E74726967676572696E67456C656D656E742E69643D24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E636C6F7365737428226469762E61';
wwv_flow_api.g_varchar2_table(34) := '7065782D6974656D2D67726F757022292E61747472282269642229293B627265616B3B6361736520435F434C49434B5F4556454E543A70726F70732E74726967676572696E67456C656D656E742E6973436C69636B3D21302C70726F70732E7472696767';
wwv_flow_api.g_varchar2_table(35) := '6572696E67456C656D656E742E69643D2222213D3D652E7461726765742E69643F652E7461726765742E69643A652E63757272656E745461726765742E69642C22223D3D3D70726F70732E74726967676572696E67456C656D656E742E69642626287072';
wwv_flow_api.g_varchar2_table(36) := '6F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E706172656E74456C656D656E742E6964292C24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E686173436C61737328435F41';
wwv_flow_api.g_varchar2_table(37) := '5045585F425554544F4E297C7C24286023247B70726F70732E74726967676572696E67456C656D656E742E69647D60292E706172656E7428435F425554544F4E293B627265616B3B6361736520435F4B455950524553535F4556454E543A69662870726F';
wwv_flow_api.g_varchar2_table(38) := '70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E69642C31333D3D3D652E6B6579436F64652970726F70732E74726967676572696E67456C656D656E742E6576656E743D435F454E5445525F4556454E543B627265616B';
wwv_flow_api.g_varchar2_table(39) := '3B64656661756C743A70726F70732E74726967676572696E67456C656D656E742E69643D652E7461726765742E69647D617065782E64656275672E696E666F28604576656E742027247B70726F70732E74726967676572696E67456C656D656E742E6576';
wwv_flow_api.g_varchar2_table(40) := '656E747D27207261697365642061742054726967676572696E6720656C656D656E742027247B70726F70732E74726967676572696E67456C656D656E742E69647D2760297D7D2C686578546F436861723D66756E6374696F6E2865297B76617220742C6E';
wwv_flow_api.g_varchar2_table(41) := '3D22223B69662865297B743D652E746F537472696E6728293B666F72286C657420653D303B653C742E6C656E6774683B652B3D32296E2B3D537472696E672E66726F6D43686172436F6465287061727365496E7428742E73756273747228652C32292C31';
wwv_flow_api.g_varchar2_table(42) := '3629297D72657475726E206E7D2C6D61696E7461696E416E64436865636B4576656E744C6F636B3D66756E6374696F6E28297B76617220653D21302C743D70726F70732E74726967676572696E67456C656D656E743B72657475726E20435F50524F5445';
wwv_flow_api.g_varchar2_table(43) := '435445445F4556454E54532E696E6465784F6628742E6576656E74293E2D313F70726F70732E71756172616E74696E654C6973742E696E6465784F6628742E6576656E74293E2D313F28617065782E64656275672E696E666F286049676E6F72696E6720';
wwv_flow_api.g_varchar2_table(44) := '4576656E742027247B742E6576656E747D272C206F6E2071756172616E74696E65206C69737460292C653D2131293A28617065782E64656275672E696E666F2822436C656172206576656E74207175657565206166746572206C6F636B696E6720616E20';
wwv_flow_api.g_varchar2_table(45) := '6576656E7422292C242822626F647922292E636C656172517565756528292C70726F70732E71756172616E74696E654C6973742E7075736828742E6576656E74292C617065782E64656275672E696E666F28604576656E742027247B742E6576656E747D';
wwv_flow_api.g_varchar2_table(46) := '2720707573686564206F6E2071756172616E74696E6560292C73657454696D656F7574282866756E6374696F6E28297B70726F70732E71756172616E74696E654C6973743D5B5D2C617065782E64656275672E696E666F28604576656E742027247B742E';
wwv_flow_api.g_varchar2_table(47) := '6576656E747D2720706F707065642066726F6D2071756172616E74696E6560297D292C435F4C4F434B5F4C454E475448292C742E6973436C69636B262628617065782E64656275672E696E666F28604C6F636B696E6720627574746F6E2027247B742E69';
wwv_flow_api.g_varchar2_table(48) := '647D2760292C617065782E6974656D28742E6964292E64697361626C65282929293A435F50524F5445435445445F4556454E54532E696E6465784F662870726F70732E71756172616E74696E654C6973745B305D293E2D31262628617065782E64656275';
wwv_flow_api.g_varchar2_table(49) := '672E696E666F286049676E6F72696E67206576656E742027247B742E6576656E747D272C206576656E742027247B70726F70732E71756172616E74696E654C6973745B305D7D27206973206F6E2071756172616E74696E65206C69737460292C653D2131';
wwv_flow_api.g_varchar2_table(50) := '292C657D2C616464427574746F6E48616E646C65723D66756E6374696F6E28652C742C6E2C69297B6C657420613B613D242E5F6461746128652E6765742830292C226576656E747322292C766F69642030213D3D612626615B435F434C49434B5F455645';
wwv_flow_api.g_varchar2_table(51) := '4E545D2626652E6F666628435F434C49434B5F4556454E54292C652E6F6E28435F434C49434B5F4556454E542C7B616A61784964656E7469666965723A70726F70732E616A61784964656E7469666965722C6D6573736167653A742C2270726F70732E70';
wwv_flow_api.g_varchar2_table(52) := '6167654974656D73223A70726F70732E706167654974656D732C7469746C653A6E7D2C69297D3B63746C2E62696E644F627365727665724974656D733D66756E6374696F6E2865297B76617220743B65262628743D652E73706C697428222C22292C242E';
wwv_flow_api.g_varchar2_table(53) := '6561636828742C2866756E6374696F6E28652C74297B222E223D3D3D746869732E737562737472696E6728302C31293F242874292E65616368282866756E6374696F6E28652C74297B616464506167654974656D28242874292E61747472282269642229';
wwv_flow_api.g_varchar2_table(54) := '297D29293A2D313D3D3D242E696E417272617928742C70726F70732E706167654974656D7329262670726F70732E706167654974656D732E707573682874297D29292C617065782E64656275672E696E666F28604164646974696F6E616C207061676520';
wwv_flow_api.g_varchar2_table(55) := '6974656D733A20247B657D6029297D2C63746C2E62696E64436F6E6669726D6174696F6E48616E646C65723D66756E6374696F6E28652C742C6E2C69297B6C657420612C723B613D693F66756E6374696F6E28297B617065782E616374696F6E732E696E';
wwv_flow_api.g_varchar2_table(56) := '766F6B652869297D3A6368616E676543616C6C6261636B2C723D66756E6374696F6E2874297B6164632E72656E64657265722E636F6E6669726D5265717565737428742C612C652E61747472282269642229297D2C616464427574746F6E48616E646C65';
wwv_flow_api.g_varchar2_table(57) := '7228652C742C6E2C72297D2C63746C2E62696E64556E7361766564436F6E6669726D6174696F6E48616E646C65723D66756E6374696F6E28652C742C6E297B616464427574746F6E48616E646C657228652C742C6E2C756E736176656443616C6C626163';
wwv_flow_api.g_varchar2_table(58) := '6B297D2C63746C2E66696E644974656D56616C75653D66756E6374696F6E2865297B76617220743D242E677265702870726F70732E6C6173744974656D56616C7565732C2866756E6374696F6E2874297B72657475726E20742E69643D3D3D657D29293B';
wwv_flow_api.g_varchar2_table(59) := '696628742E6C656E6774683E302972657475726E20745B305D2E76616C75657D2C63746C2E6765745061676553746174653D66756E6374696F6E28297B72657475726E2070726F70732E7061676553746174657D2C63746C2E7365745061676553746174';
wwv_flow_api.g_varchar2_table(60) := '653D66756E6374696F6E2865297B70726F70732E7061676553746174653D657D2C63746C2E70757368506167654974656D3D66756E6374696F6E2865297B2D313D3D3D242E696E417272617928652C70726F70732E706167654974656D73292626287072';
wwv_flow_api.g_varchar2_table(61) := '6F70732E706167654974656D732E707573682865292C62696E644576656E7428652C435F4348414E47455F4556454E5429297D2C63746C2E686173556E73617665644368616E6765733D66756E6374696F6E2865297B76617220742C6E3D21313B726574';
wwv_flow_api.g_varchar2_table(62) := '75726E20743D41727261792E697341727261792865293F653A2428435F494E5055545F53454C4543544F52292C242E6561636828742C2866756E6374696F6E2865297B69662828653D745B655D292E6964262628653D652E6964292C617065782E646562';
wwv_flow_api.g_varchar2_table(63) := '75672E696E666F2860436F6D706172696E6720247B657D60292C70726F70732E7061676553746174652E6974656D4D61702E686173286529262670726F70732E7061676553746174652E6974656D4D61702E676574286529213D617065782E6974656D28';
wwv_flow_api.g_varchar2_table(64) := '65292E67657456616C756528292972657475726E206E3D21302C21317D29292C6E7D2C63746C2E70617573654368616E67654576656E74447572696E67526566726573683D66756E6374696F6E28652C74297B766172206E2C692C613D24286023247B65';
wwv_flow_api.g_varchar2_table(65) := '7D60292C723D612E6765742830293B612E6C656E6774683E302626286E3D242E5F6461746128722C226576656E747322292C64656C65746528693D242E657874656E642821302C5B5D2C6E29292E6368616E67652C242E5F6461746128722C226576656E';
wwv_flow_api.g_varchar2_table(66) := '7473222C69292C612E6F6E6528435F415045585F41465445525F524546524553482C2866756E6374696F6E2869297B76617220613D63746C2E67657450616765537461746528293B74262628617065782E6974656D2865292E73657456616C756528742C';
wwv_flow_api.g_varchar2_table(67) := '742C2130292C612E6974656D4D61702E686173286529262628612E6974656D4D61702E73657428652C74292C63746C2E73657450616765537461746528612929292C242E5F6461746128722C226576656E7473222C6E297D2929297D2C63746C2E736574';
wwv_flow_api.g_varchar2_table(68) := '4164646974696F6E616C4974656D733D66756E6374696F6E2865297B70726F70732E6164646974696F6E616C4974656D733D657D2C63746C2E73657454726967676572696E67456C656D656E743D66756E6374696F6E28652C742C6E2C69297B70726F70';
wwv_flow_api.g_varchar2_table(69) := '732E74726967676572696E67456C656D656E742E69643D652C70726F70732E74726967676572696E67456C656D656E742E6576656E743D742C70726F70732E74726967676572696E67456C656D656E742E646174613D6E2C70726F70732E747269676765';
wwv_flow_api.g_varchar2_table(70) := '72696E67456C656D656E742E6973436C69636B3D697C7C21317D2C63746C2E7365744C6173744974656D56616C7565733D66756E6374696F6E2865297B70726F70732E6C6173744974656D56616C7565733D657D2C63746C2E6765745374616E64617264';
wwv_flow_api.g_varchar2_table(71) := '4D6573736167653D66756E6374696F6E2865297B72657475726E2070726F70732E7374616E646172644D657373616765735B655D7D2C63746C2E657865637574653D66756E6374696F6E28297B6D61696E7461696E416E64436865636B4576656E744C6F';
wwv_flow_api.g_varchar2_table(72) := '636B282926262870726F70732E74726967676572696E67456C656D656E742E64617461262670726F70732E6164646974696F6E616C4974656D7326262870726F70732E706167654974656D733D6E657720536574285B2E2E2E70726F70732E7061676549';
wwv_flow_api.g_varchar2_table(73) := '74656D732C2E2E2E70726F70732E6164646974696F6E616C4974656D735D292C70726F70732E706167654974656D733D41727261792E66726F6D2870726F70732E706167654974656D7329292C617065782E64656275672E696E666F2860414443206861';
wwv_flow_api.g_varchar2_table(74) := '6E646C6573206576656E7420247B70726F70732E74726967676572696E67456C656D656E742E6576656E747D60292C617065782E64656275672E696E666F28604144432073656E647320706167654974656D7320247B70726F70732E706167654974656D';
wwv_flow_api.g_varchar2_table(75) := '732E6A6F696E28297D60292C7365727665722E706C7567696E2870726F70732E616A61784964656E7469666965722C7B7830313A70726F70732E74726967676572696E67456C656D656E742E69642C7830323A70726F70732E74726967676572696E6745';
wwv_flow_api.g_varchar2_table(76) := '6C656D656E742E6576656E742C7830333A4A534F4E2E737472696E676966792870726F70732E74726967676572696E67456C656D656E742E64617461292C706167654974656D733A70726F70732E706167654974656D737D2C7B64617461547970653A22';
wwv_flow_api.g_varchar2_table(77) := '68746D6C222C737563636573733A66756E6374696F6E2865297B70726F70732E74726967676572696E67456C656D656E742E6973436C69636B2626617065782E6974656D2870726F70732E74726967676572696E67456C656D656E742E6964292E656E61';
wwv_flow_api.g_varchar2_table(78) := '626C6528292C65786563757465436F64652865297D7D29297D2C6164632E696E69743D66756E6374696F6E2870416374696F6E297B70726F70732E62696E644974656D733D242E70617273654A534F4E2870416374696F6E2E6174747269627574653031';
wwv_flow_api.g_varchar2_table(79) := '2E7265706C616365282F7E2F672C27222729292C6164632E72656E64657265723D6576616C2870416374696F6E2E6174747269627574653033292C70726F70732E616A61784964656E7469666965723D70416374696F6E2E616A61784964656E74696669';
wwv_flow_api.g_varchar2_table(80) := '65722C70726F70732E6576656E74446174612E616A61784964656E7469666965723D70726F70732E616A61784964656E7469666965722C70726F70732E6576656E74446174612E706167654974656D733D70726F70732E706167654974656D732C704163';
wwv_flow_api.g_varchar2_table(81) := '74696F6E2E6174747269627574653032262628617065782E64656275672E696E666F2822526571756972656420706167654974656D733A20222B70416374696F6E2E6174747269627574653032292C70726F70732E706167654974656D733D7041637469';
wwv_flow_api.g_varchar2_table(82) := '6F6E2E61747472696275746530322E73706C697428222C2229292C70416374696F6E2E617474726962757465303626262870726F70732E7374616E646172644D657373616765733D4A534F4E2E70617273652870416374696F6E2E617474726962757465';
wwv_flow_api.g_varchar2_table(83) := '303629292C63746C2E62696E644F627365727665724974656D732870416374696F6E2E6174747269627574653035292C62696E644576656E747328292C617065782E64656275672E696E666F282241444320696E697469616C697A656422292C65786563';
wwv_flow_api.g_varchar2_table(84) := '757465436F646528686578546F436861722870416374696F6E2E617474726962757465303429297D7D2864652E636F6E6465732E706C7567696E2E6164632C617065782E6A51756572792C617065782E736572766572293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740441497024785500)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/controller.min.js'
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
wwv_flow_api.g_varchar2_table(3) := '0A0D0A2F2A2A0D0A202046756E6374696F6E3A20414443205468656D6520616461707465720D0A20202020496E74657266616365206265747765656E207468652041444320706C7567696E20616374696F6E7320616E6420746865204150455820757365';
wwv_flow_api.g_varchar2_table(4) := '7220696E7465726661636520666F72205468656D6520343220696E2056657273696F6E2032302E320D0A0D0A20202020414443206E6565647320746F20696E746572616374207769746820746865204150455820554920746F2061636869657665207468';
wwv_flow_api.g_varchar2_table(5) := '652076697375616C2065666665637473207265717565737465642062792074686520706167652072756C65732E2041504558206F6E20746865206F746865722068616E640D0A20202020636F6D657320696E20646966666572656E742076657273696F6E';
wwv_flow_api.g_varchar2_table(6) := '7320616E64207468656D65732C206D616B696E6720697420646966666963756C7420666F722067656E6572696320636F646520746F2074616B652063617265206F6620616C6C2074686520646966666572656E7420737472617465676965730D0A202020';
wwv_flow_api.g_varchar2_table(7) := '207573656420746F20646973706C617920636F6E74656E742E0D0A202020200D0A202020204144432063617465727320666F7220746869732062792064656C65676174696E6720746865205549207370656369666963206D6574686F647320696E746F20';
wwv_flow_api.g_varchar2_table(8) := '612073657061726174652072656E64657265722C20696D706C656D656E74696E67207468652076697375616C20636F646520666F7220612073706563696669630D0A20202020636F6D62696E6174696F6E206F6620415045582076657273696F6E20616E';
wwv_flow_api.g_varchar2_table(9) := '64207468656D652E205468652072657175697265642072656E64657265722069732073656C6563746564206279206120636F6D706F6E656E7420706172616D65746572206F662074686520706C7567696E207768657265200D0A20202020746865206E61';
wwv_flow_api.g_varchar2_table(10) := '6D657370616365206F66207468652072657175697265642072656E646572657220636F646520696D706C656D656E746174696F6E2063616E206265207365742E0D0A202020200D0A20202020546869732066696C6520696D706C656D656E747320746865';
wwv_flow_api.g_varchar2_table(11) := '2076697375616C2065666665637473206F662076657273696F6E2032302E322C205468656D652034322E20496620796F7520757365207468652073616D652076657273696F6E20627574206120646966666572656E742074656D706C617465206F720D0A';
wwv_flow_api.g_varchar2_table(12) := '20202020696620796F7520657874656E64656420796F7572207468656D652062792061646472657373696E67207370656369666963206E6565647320666F7220796F757220636F6D70616E792C20796F75206D6179206861766520746F20616464206F72';
wwv_flow_api.g_varchar2_table(13) := '206F76657277726974652066756E6374696F6E616C697479206F662074686973206F626A6563742E0D0A202020200D0A20202020546F2070726F7669646520796F7572206F776E2076657273696F6E2C206974206973207265636F6D6D656E6465642074';
wwv_flow_api.g_varchar2_table(14) := '6F206372656174652061206E6577206F626A656374207468617420696E6865726974732066726F6D2074686973206F626A65637420616E64206F766572777269746573207468652066756E6374696F6E616C69747920796F75206E6565642E0D0A200D0A';
wwv_flow_api.g_varchar2_table(15) := '20202020466F722061206465736372697074696F6E206F662074686520737472756374757265206F6620746865206F626A656374732070617373656420696E207365652074686520646F63756D656E746174696F6E206F66206164632E6A730D0A0D0A20';
wwv_flow_api.g_varchar2_table(16) := '20506172616D65746572733A0D0A20202020616463202D204E616D657370616365206F626A65637420746F2061646F70742041444320746F2074686520676976656E20415045582076657273696F6E20616E64207468656D650D0A202020206D7367202D';
wwv_flow_api.g_varchar2_table(17) := '204D657373616765206F626A6563742070726F766964656420627920415045582C20696E7374616E6365206F6620617065782E6D6573736167650D0A202A2F0D0A2866756E6374696F6E2872656E64657265722C206D7367297B0D0A0D0A2020636F6E73';
wwv_flow_api.g_varchar2_table(18) := '7420435F415045585F4552524F525F434C4153535F53454C203D20276469762E612D4E6F74696669636174696F6E2D2D6572726F72273B0D0A2020636F6E737420435F56495349424C45203D2027752D76697369626C65273B0D0A2020636F6E73742043';
wwv_flow_api.g_varchar2_table(19) := '5F48494444454E203D2027752D68696464656E273B0D0A2020636F6E737420435F4144435F44495341424C4544203D20276164632D64697361626C6564273B0D0A2020636F6E737420435F415045585F44495341424C4544203D2027617065785F646973';
wwv_flow_api.g_varchar2_table(20) := '61626C6564273B0D0A0D0A2020636F6E737420435F524547494F4E5F4352203D2027436C61737369635265706F7274273B0D0A2020636F6E737420435F524547494F4E5F4952203D2027496E7465726163746976655265706F7274273B0D0A2020636F6E';
wwv_flow_api.g_varchar2_table(21) := '737420435F524547494F4E5F4947203D2027496E74657261637469766547726964273B0D0A2020636F6E737420435F524547494F4E5F54524545203D202754726565273B0D0A2020636F6E737420435F524547494F4E5F544142203D2027546162273B0D';
wwv_flow_api.g_varchar2_table(22) := '0A0D0A20202F2F20436C61737320636F6E7374616E74730D0A2020636F6E737420435F52455155495245445F434C415353203D202769732D7265717569726564273B0D0A0D0A20202F2F2053656C6563746F7220636F6E7374616E74730D0A2020636F6E';
wwv_flow_api.g_varchar2_table(23) := '737420435F524547494F4E5F424F44595F53454C4543544F52203D2027202E742D526567696F6E2D626F64792C2E742D436F6E74656E74426C6F636B2D626F6479273B0D0A2020636F6E737420435F524547494F4E5F5449544C455F53454C4543544F52';
wwv_flow_api.g_varchar2_table(24) := '203D2027202E742D526567696F6E2D7469746C65273B0D0A2020636F6E737420435F4D4F44414C5F4449414C4F475F5449544C455F53454C4543544F52203D2027202E75692D6469616C6F672D7469746C65273B0D0A2020636F6E737420435F504F5055';
wwv_flow_api.g_varchar2_table(25) := '505F4C4F565F53454C4543544F52203D20272E612D427574746F6E2D2D706F7075704C4F56273B0D0A0D0A20202F2F2041747472696275746520636F6E7374616E74730D0A2020636F6E737420435F524541444F4E4C595F50524F50203D202772656164';
wwv_flow_api.g_varchar2_table(26) := '6F6E6C79273B0D0A2020636F6E737420435F44495341424C45445F50524F50203D202764697361626C6564273B0D0A0D0A20202F2F204576656E7420636F6E7374616E74730D0A2020636F6E737420435F49475F53454C454354494F4E5F4348414E4745';
wwv_flow_api.g_varchar2_table(27) := '203D2027696E7465726163746976656772696473656C656374696F6E6368616E6765273B0D0A2020636F6E737420435F545245455F53454C454354494F4E5F4348414E4745203D2027747265657669657773656C656374696F6E6368616E6765273B0D0A';
wwv_flow_api.g_varchar2_table(28) := '2020636F6E737420435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368273B0D0A2020636F6E737420435F434C49434B203D2027636C69636B273B0D0A20200D0A0D0A0D0A20202F2A2A0D0A2020202046';
wwv_flow_api.g_varchar2_table(29) := '756E6374696F6E3A20616C69676E5265706F7274566572746963616C546F700D0A2020202020204D6574686F642061646A75737473207265706F72742063656C6C7320766572746963616C6C7920746F20746F700D0A0D0A20202020506172616D657465';
wwv_flow_api.g_varchar2_table(30) := '723A0D0A202020202020705265706F72744964202D20537461746963204944206F6620746865207265706F727420746F2061646A7573740D0A2020202A2F0D0A202072656E64657265722E616C69676E5265706F7274566572746963616C546F70203D20';
wwv_flow_api.g_varchar2_table(31) := '66756E6374696F6E28705265706F72744964297B0D0A2020202076617220247265706F7274203D2024286023247B705265706F727449647D60293B0D0A092020247265706F72742E66696E642827746427292E616464436C6173732827752D616C69676E';
wwv_flow_api.g_varchar2_table(32) := '546F7027293B0D0A0920200D0A092020247265706F72742E6F6E28435F415045585F41465445525F52454652455348292C2066756E6374696F6E28297B0D0A0920202020616C69676E5265706F7274566572746963616C546F7028705265706F72744964';
wwv_flow_api.g_varchar2_table(33) := '293B0D0A202020207D09090D0A20207D3B202F2F20616C69676E5265706F7274566572746963616C546F700D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636C6561724572726F72730D0A20202020202052656D6F7665732061';
wwv_flow_api.g_varchar2_table(34) := '6C6C206D6573736167657320696E20746865206E6F74696669636174696F6E20726567696F6E0D0A2020202A2F0D0A202072656E64657265722E636C6561724572726F7273203D2066756E6374696F6E28297B0D0A20202020674572726F7273203D205B';
wwv_flow_api.g_varchar2_table(35) := '5D3B0D0A20202020675761726E696E6773203D205B5D3B0D0A202020206D73672E636C6561724572726F727328293B0D0A20207D3B202F2F636C6561724572726F72730D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20636C6561';
wwv_flow_api.g_varchar2_table(36) := '724E6F74696669636174696F6E0D0A20202020202052656D6F76657320616C6C206D6573736167657320696E20746865206E6F74696669636174696F6E20726567696F6E0D0A2020202A2F0D0A202072656E64657265722E636C6561724E6F7469666963';
wwv_flow_api.g_varchar2_table(37) := '6174696F6E203D2066756E6374696F6E28297B0D0A202020206D73672E68696465506167655375636365737328293B0D0A20207D3B202F2F20636C6561724E6F74696669636174696F6E0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2063';
wwv_flow_api.g_varchar2_table(38) := '6F6E6669726D526571756573740D0A20202020202053686F7773206120636F6E6669726D6174696F6E206469616C6F6720746F207468652075736572206265666F72652063616C6C696E672074686520696E74656E6465642066756E6374696F6E616C69';
wwv_flow_api.g_varchar2_table(39) := '74792E0D0A0D0A20202020506172616D65746572733A0D0A202020202020704576656E744F724D657373616765202D204576656E7420746F206578747261637420746865206D65737361676520746578742066726F6D206F72206120706C61696E206D65';
wwv_flow_api.g_varchar2_table(40) := '73736167650D0A2020202020207043616C6C6261636B202D204D6574686F6420746F2062652063616C6C656420696620746865207573657220636F6E6669726D65732074686973206469616C6F670D0A20202020202070466F6375734974656D202D2049';
wwv_flow_api.g_varchar2_table(41) := '74656D20746F207365742074686520666F63757320746F206966206E6F20636F6E6669726D6174696F6E20697320676976656E0D0A2020202A2F0D0A202072656E64657265722E636F6E6669726D52657175657374203D2066756E6374696F6E28704576';
wwv_flow_api.g_varchar2_table(42) := '656E744F724D6573736167652C207043616C6C6261636B2C2070466F6375734974656D297B0D0A202020206C6574206D6573736167653B0D0A202020206C6574206469616C6F675469746C653B0D0A202020200D0A20202020696628747970656F662870';
wwv_flow_api.g_varchar2_table(43) := '4576656E744F724D65737361676529203D3D3D2022737472696E6722297B0D0A2020202020206D657373616765203D20704576656E744F724D6573736167653B0D0A202020207D656C73657B0D0A2020202020206D657373616765203D20704576656E74';
wwv_flow_api.g_varchar2_table(44) := '4F724D6573736167652E646174612E6D6573736167653B0D0A2020202020206469616C6F675469746C65203D20704576656E744F724D6573736167652E646174612E7469746C653B0D0A0D0A202020207D0D0A20202020617065782E6D6573736167652E';
wwv_flow_api.g_varchar2_table(45) := '636F6E6669726D286D6573736167652C2066756E6374696F6E202870416E7377657229207B0D0A20202020202069662870416E73776572297B0D0A20202020202020207043616C6C6261636B28704576656E744F724D657373616765293B0D0A20202020';
wwv_flow_api.g_varchar2_table(46) := '20207D0D0A202020202020656C7365207B0D0A2020202020202020617065782E6974656D2870466F6375734974656D292E736574466F63757328293B0D0A2020202020207D3B0D0A202020207D293B0D0A2020202072656E64657265722E7365744D6F64';
wwv_flow_api.g_varchar2_table(47) := '616C4469616C6F675469746C65286469616C6F675469746C65293B0D0A20207D3B202F2F20636C6561724E6F74696669636174696F6E0D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A2064697361626C65456C656D656E740D0A20';
wwv_flow_api.g_varchar2_table(48) := '202020202044697361626C657320612070616765206974656D2E2048616E646C657320646561637469766174696F6E206F66200D0A0D0A2020202020202D2070616765206974656D7320776974682076616C75657320746F20616C6C6F7720746F20696E';
wwv_flow_api.g_varchar2_table(49) := '636C756465207468656D20696E2061207375626D69740D0A2020202020202D2073656C656374206C697374730D0A2020202020202D20627574746F6E730D0A0D0A20202020506172616D657465720D0A202020202020704974656D4964202D204944206F';
wwv_flow_api.g_varchar2_table(50) := '66207468652070616765206974656D20746F2064697361626C650D0A2020202A2F0D0A202072656E64657265722E64697361626C65456C656D656E74203D2066756E6374696F6E2028704974656D4964297B0D0A2020202076617220246974656D203D20';
wwv_flow_api.g_varchar2_table(51) := '2428272327202B20704974656D4964293B0D0A2020202076617220246974656D4C6162656C203D202428272327202B20704974656D4964202B20275F4C4142454C27293B0D0A20202020617065782E6974656D28704974656D4964292E73686F7728293B';
wwv_flow_api.g_varchar2_table(52) := '0D0A0D0A202020202F2F204E6F726D616C20656C656D656E742C20646F206E6F742064697361626C652C206F74686572776973652073657373696F6E73746174652077696C6C206E6F742062652066696C6C65642E0D0A202020202F2F20496E73746561';
wwv_flow_api.g_varchar2_table(53) := '642C2073657420726561646F6E6C7920616E642043535320636C61737320736F2074686174206974206C6F6F6B73206C696B652064697361626C65642E0D0A20202020246974656D0D0A2020202020202E70726F7028435F524541444F4E4C595F50524F';
wwv_flow_api.g_varchar2_table(54) := '502C2074727565290D0A2020202020202E616464436C61737328435F415045585F44495341424C4544290D0A2020202020202E617474722827617269612D64697361626C6564272C20277472756527290D0A2020202020202E617474722827746162696E';
wwv_flow_api.g_varchar2_table(55) := '646578272C20222D3122293B0D0A0D0A202020202F2F20696620746865207061676520656C656D656E7420697320612073656C656374696F6E206C6973742C20726561646F6E6C79206D75737420626520616464656420646966666572656E746C790D0A';
wwv_flow_api.g_varchar2_table(56) := '2020202069662028246974656D2E686173436C617373282273656C6563746C697374222929207B0D0A202020202020246974656D2E6174747228435F524541444F4E4C595F50524F502C20435F524541444F4E4C595F50524F50293B0D0A202020202020';
wwv_flow_api.g_varchar2_table(57) := '2F2F20696E2073656C656374696F6E206C6973747320616C736F2070726F7669646520746865206C6162656C2077697468207468697320636C6173732C20736F2074686174207768656E20636C69636B696E67206F6E20746865206C6162656C0D0A2020';
wwv_flow_api.g_varchar2_table(58) := '202020202F2F207468652073656C656374696F6E206C69737420646F6573206E6F74206265636F6D652061637469766520616E6420616E6F746865722076616C75652063616E2062652073656C656374656420766961206B6579626F6172640D0A202020';
wwv_flow_api.g_varchar2_table(59) := '202020246974656D4C6162656C2E616464436C61737328435F4144435F44495341424C4544293B0D0A202020207D0D0A0D0A202020202F2F20696620746865207061676520656C656D656E7420697320612064617465206669656C642C207468656E2061';
wwv_flow_api.g_varchar2_table(60) := '6C736F20646561637469766174652074686520627574746F6E20666F722074686520646174652073656C656374696F6E0D0A20202020656C73652069662028246974656D2E686173436C6173732822686173446174657069636B65722229207C7C202469';
wwv_flow_api.g_varchar2_table(61) := '74656D2E686173436C6173732822636F6C6F725F7069636B65722229207C7C20246974656D2E686173436C6173732822706F7075705F6C6F76222929207B0D0A202020202020246974656D2E706172656E7428292E66696E642822627574746F6E22292E';
wwv_flow_api.g_varchar2_table(62) := '70726F7028435F44495341424C45445F50524F502C2074727565293B0D0A202020207D0D0A20207D3B202F2F2064697361626C65456C656D656E740D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20656E61626C65456C656D656E';
wwv_flow_api.g_varchar2_table(63) := '740D0A202020202020456E61626C657320612070616765206974656D2E2048616E646C65732061637469766174696F6E206F66200D0A0D0A2020202020202D2070616765206974656D7320776974682076616C75657320746F20616C6C6F7720746F2069';
wwv_flow_api.g_varchar2_table(64) := '6E636C756465207468656D20696E2061207375626D69740D0A2020202020202D2073656C656374206C697374730D0A2020202020202D20627574746F6E730D0A0D0A20202020506172616D657465723A0D0A202020202020704974656D4964202D204944';
wwv_flow_api.g_varchar2_table(65) := '206F66207468652070616765206974656D20746F2064697361626C650D0A2020202A2F0D0A202072656E64657265722E656E61626C65456C656D656E74203D2066756E6374696F6E2028704974656D4964297B0D0A2020202076617220246974656D203D';
wwv_flow_api.g_varchar2_table(66) := '2024286023247B704974656D49647D60293B0D0A20202020246974656D0D0A2020202020202E70726F7028435F524541444F4E4C595F50524F502C2066616C7365290D0A2020202020202E72656D6F7665436C61737328435F4144435F44495341424C45';
wwv_flow_api.g_varchar2_table(67) := '44290D0A2020202020202E72656D6F7665417474722827746162696E64657827293B0D0A0D0A2020202069662028246974656D2E6973282773656C6563742729297B0D0A20202020202024286023247B704974656D49647D3A6E6F74283A73656C656374';
wwv_flow_api.g_varchar2_table(68) := '65642960290D0A20202020202020202E70726F7028435F524541444F4E4C595F50524F502C2066616C7365293B0D0A202020207D0D0A20202020617065782E6974656D28704974656D4964292E73686F7728293B0D0A20202020617065782E6974656D28';
wwv_flow_api.g_varchar2_table(69) := '704974656D4964292E656E61626C6528293B0D0A202020200D0A202020202F2F2069662070616765206974656D20697320612064617465207069636B65722C20656E61626C6520627574746F6E2061732077656C6C0D0A2020202069662028246974656D';
wwv_flow_api.g_varchar2_table(70) := '2E686173436C6173732822686173446174657069636B65722229207C7C20246974656D2E686173436C6173732822636F6C6F725F7069636B65722229207C7C20246974656D2E686173436C6173732822706F7075705F6C6F76222929207B0D0A20202020';
wwv_flow_api.g_varchar2_table(71) := '2020246974656D2E706172656E7428292E66696E642822627574746F6E22290D0A20202020202020202E70726F7028435F44495341424C45445F50524F502C2066616C7365290D0A20202020202020202E72656D6F7665436C61737328435F4144435F44';
wwv_flow_api.g_varchar2_table(72) := '495341424C4544290D0A20202020202020202E72656D6F7665417474722827746162696E64657827293B0D0A202020207D0D0A0D0A202020202F2F2069662070616765206974656D206973206120636F6C6F7572207069636B65722C20656E61626C6520';
wwv_flow_api.g_varchar2_table(73) := '627574746F6E2061732077656C6C0D0A20202020656C73652069662028246974656D2E686173436C6173732822636F6C6F725F7069636B6572222929207B0D0A2020202020202428272327202B20704974656D4964202B20275F6669656C647365742729';
wwv_flow_api.g_varchar2_table(74) := '0D0A20202020202020202E70726F7028435F524541444F4E4C595F50524F502C2066616C7365290D0A20202020202020202E72656D6F7665436C61737328435F4144435F44495341424C4544290D0A20202020202020202E72656D6F7665417474722827';
wwv_flow_api.g_varchar2_table(75) := '746162696E64657827293B0D0A202020207D0D0A0D0A202020202F2F2069662070616765206974656D206973206120706F707570206C6973742C20656E61626C6520627574746F6E2061732077656C6C0D0A20202020656C73652069662028246974656D';
wwv_flow_api.g_varchar2_table(76) := '2E686173436C6173732822706F7075705F6C6F76222929207B0D0A202020202020246974656D2E636C6F7365737428272327202B20704974656D4964202B20275F6669656C6473657427290D0A20202020202020202E66696E6428435F504F5055505F4C';
wwv_flow_api.g_varchar2_table(77) := '4F565F53454C4543544F52290D0A20202020202020202E70726F7028435F524541444F4E4C595F50524F502C2066616C7365290D0A20202020202020202E72656D6F7665436C61737328435F4144435F44495341424C4544290D0A20202020202020202E';
wwv_flow_api.g_varchar2_table(78) := '72656D6F7665417474722827746162696E64657827293B0D0A202020207D3B0D0A20207D3B202F2F20656E61626C65456C656D656E740D0A20200D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E3A20686964655265706F727446696C74657250';
wwv_flow_api.g_varchar2_table(79) := '616E656C0D0A20202020202052656D6F7665732066696C74657220617265612066726F6D20696E746572616374697665207265706F7274206F7220696E74657261637469766520677269642E0D0A0D0A20202020506172616D65746572733A0D0A202020';
wwv_flow_api.g_varchar2_table(80) := '20202070526567696F6E4964202D20537461746963206964206F662074686520696E746572616374697665207265706F7274206F7220677269640D0A20202020202070526567696F6E54797065202D2054797065206F6620746865207265706F72740D0A';
wwv_flow_api.g_varchar2_table(81) := '2020202A2F0D0A202072656E64657265722E686964655265706F727446696C74657250616E656C203D2066756E6374696F6E2870526567696F6E49642C2070526567696F6E54797065297B0D0A202020207377697463682870526567696F6E5479706529';
wwv_flow_api.g_varchar2_table(82) := '7B0D0A2020202020206361736520435F524547494F4E5F49523A0D0A202020202020202024286023247B70526567696F6E49647D5F636F6E726F6C5F70616E656C60292E6869646528293B202F2F20696E746572616374697665207265706F72740D0A20';
wwv_flow_api.g_varchar2_table(83) := '20202020202020627265616B3B0D0A2020202020206361736520435F524547494F4E5F49473A0D0A202020202020202024286023247B70526567696F6E49647D202E612D4D65646961426C6F636B60292E6869646528293B202F2F20696E746572616374';
wwv_flow_api.g_varchar2_table(84) := '69766520677269640D0A2020202020202020627265616B3B0D0A202020207D0D0A202020200D0A2020202024286023247B70526567696F6E49647D60292E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E28297B0D0A';
wwv_flow_api.g_varchar2_table(85) := '20202020202072656E64657265722E686964655265706F727446696C74657250616E656C2870526567696F6E49642C2070526567696F6E54797065293B0D0A202020207D293B0D0A20207D3B202F2F20686964655265706F727446696C74657250616E65';
wwv_flow_api.g_varchar2_table(86) := '6C0D0A20200D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20686967686C69676874526F770D0A2020202020204D6574686F6420746F206F70746963616C6C792073656C656374206120726F7720696E2061207265706F72740D0A2020';
wwv_flow_api.g_varchar2_table(87) := '2020200D0A20202020506172616D65746572733A0D0A20202020202070526F77202D206A5175657279206F626A65637420706F696E74696E6720746F20746865206461746120726F7720746F20686967686C696768740D0A20202020202070536574466F';
wwv_flow_api.g_varchar2_table(88) := '637573202D20466C616720746F20696E64696361746520776865746865722074686520726F772068617320746F20626520666F6375737365640D0A2020202A2F0D0A202072656E64657265722E686967686C69676874526F77203D2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(89) := '2870526F772C2070536574466F637573297B0D0A2020202070526F772E616464436C61737328226164632D73656C65637465642D726F7722292E7369626C696E677328292E72656D6F7665436C61737328226164632D73656C65637465642D726F772229';
wwv_flow_api.g_varchar2_table(90) := '3B0D0A202020200D0A202020206966202870536574466F637573297B0D0A20202020202070526F772E66696E64282774643A66697273742D6368696C64206127292E666F63757328293B0D0A202020207D3B0D0A20207D3B202F2F20686967686C696768';
wwv_flow_api.g_varchar2_table(91) := '74526F770D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F774572726F72730D0A2020202020204D61696E7461696E7320746865206572726F72206C697374206F6E2074686520706167652E0D0A0D0A2020202050617261';
wwv_flow_api.g_varchar2_table(92) := '6D657465723A0D0A202020202020704572726F7273202D204172726179206F66206572726F72732C20696E7374616E636573206F66203C6572726F723E0D0A2020202A2F0D0A202072656E64657265722E73686F774572726F7273203D2066756E637469';
wwv_flow_api.g_varchar2_table(93) := '6F6E28704572726F7273297B0D0A2020202020200D0A2020202020206D73672E636C6561724572726F727328293B0D0A2020202020202F2F2052656D6F7665207761726E696E67206D61726B75700D0A2020202020202428272E742D466F726D2D776172';
wwv_flow_api.g_varchar2_table(94) := '6E696E6727290D0A20202020202020202E72656D6F7665436C6173732827617065782D706167652D6974656D2D7761726E696E6727290D0A20202020202020202E706172656E747328272E742D466F726D2D696E707574436F6E7461696E657227292E66';
wwv_flow_api.g_varchar2_table(95) := '696E6428272E742D466F726D2D7761726E696E6727290D0A20202020202020202E72656D6F7665436C6173732827742D466F726D2D7761726E696E6727293B0D0A202020202020202020200D0A2020202020206D73672E73686F774572726F7273287045';
wwv_flow_api.g_varchar2_table(96) := '72726F7273293B0D0A2020202020202F2F204368616E6765206D61726B7570206F66207761726E696E67730D0A202020202020242E6561636828704572726F72732C2066756E6374696F6E28696E6465782C20704572726F72297B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(97) := '2069662028704572726F722E74797065203D3D20277761726E696E6727297B0D0A2020202020202020202024286023247B704572726F722E706167654974656D7D60290D0A2020202020202020202020202E72656D6F7665436C6173732827617065782D';
wwv_flow_api.g_varchar2_table(98) := '706167652D6974656D2D6572726F7227292E616464436C6173732827617065782D706167652D6974656D2D7761726E696E6727290D0A2020202020202020202020202E706172656E747328272E742D466F726D2D696E707574436F6E7461696E65722729';
wwv_flow_api.g_varchar2_table(99) := '2E66696E6428272E742D466F726D2D6572726F7227290D0A2020202020202020202020202E72656D6F7665436C6173732827742D466F726D2D6572726F7227292E616464436C6173732827742D466F726D2D7761726E696E6727293B0D0A202020202020';
wwv_flow_api.g_varchar2_table(100) := '20207D0D0A2020202020207D293B0D0A20207D3B202F2F2073686F774572726F72730D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744974656D4C6162656C0D0A2020202020205365747320746865206C6162656C206F66';
wwv_flow_api.g_varchar2_table(101) := '20612070616765206974656D2E0D0A0D0A20202020506172616D65746572733A0D0A202020202020704974656D4964202D204944206F66207468652070616765206974656D20746F2073657420746865206C6162656C206F660D0A202020202020704974';
wwv_flow_api.g_varchar2_table(102) := '656D4C6162656C202D204E6577206974656D206C6162656C0D0A2020202A2F0D0A202072656E64657265722E7365744974656D4C6162656C203D2066756E6374696F6E28704974656D49642C20704974656D4C6162656C297B0D0A09202024286023247B';
wwv_flow_api.g_varchar2_table(103) := '704974656D49647D5F4C4142454C60292E7465787428704974656D4C6162656C293B0D0A20207D3B202F2F207365744974656D4C6162656C0D0A0D0A202020200D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744974656D4D616E646174';
wwv_flow_api.g_varchar2_table(104) := '6F72790D0A202020202020436F6E74726F6C7320746865206D616E6461746F727920737461747573206F6620612070616765206974656D2E0D0A0D0A20202020506172616D65746572733A0D0A202020202020704974656D4964202D2050616765206974';
wwv_flow_api.g_varchar2_table(105) := '656D204944206F6620746865206974656D20746F20736574206D616E6461746F7279206F72206F7074696F6E616C0D0A2020202020207049734D616E6461746F7279202D20466C616720746F2073657420612070616765206974656D206D616E6461746F';
wwv_flow_api.g_varchar2_table(106) := '727920287472756529206F72206F7074696F6E616C202866616C7365290D0A2020202A2F0D0A202072656E64657265722E7365744974656D4D616E6461746F7279203D2066756E6374696F6E28704974656D49642C207049734D616E6461746F7279297B';
wwv_flow_api.g_varchar2_table(107) := '0D0A0D0A2020202076617220246D616E6461746F72794974656D203D2024286023247B704974656D49647D5F434F4E5441494E455260293B0D0A0D0A20202020246D616E6461746F72794974656D2E72656D6F7665436C61737328435F52455155495245';
wwv_flow_api.g_varchar2_table(108) := '445F434C415353293B0D0A202020200D0A202020206966287049734D616E6461746F7279297B0D0A202020202020246D616E6461746F72794974656D2E616464436C61737328435F52455155495245445F434C415353293B0D0A202020207D0D0A20207D';
wwv_flow_api.g_varchar2_table(109) := '3B202F2F207365744974656D4D616E6461746F72790D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A207365744D6F64616C4469616C6F675469746C650D0A2020202020205365747320746865207469746C65206F662061206D6F64';
wwv_flow_api.g_varchar2_table(110) := '616C206469616C6F672077696E646F772E0D0A0D0A20202020506172616D657465723A0D0A202020202020704974656D4C6162656C202D204E6577206974656D206C6162656C0D0A2020202A2F0D0A202072656E64657265722E7365744D6F64616C4469';
wwv_flow_api.g_varchar2_table(111) := '616C6F675469746C65203D2066756E6374696F6E28705469746C65297B0D0A20202020706172656E742E2428435F4D4F44414C5F4449414C4F475F5449544C455F53454C4543544F52292E6C61737428292E68746D6C28705469746C65293B0D0A20207D';
wwv_flow_api.g_varchar2_table(112) := '3B202F2F207365744D6F64616C4469616C6F675469746C650D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F774469616C6F670D0A20202020202053686F77732061206D657373616765206F6E2074686520706167650D0A';
wwv_flow_api.g_varchar2_table(113) := '0D0A20202020506172616D657465723A0D0A202020202020705374796C65202D204F6E65206F662074686520707265646566696E6564207374796C657320696E666F726D6174696F6E7C7761726E696E677C7375636573737C6572726F720D0A20202020';
wwv_flow_api.g_varchar2_table(114) := '2020704D657373616765202D204D657373616765206F6620746865206469616C6F670D0A202020202020705469746C65202D204F7074696F6E616C207469746C65206F6620746865206469616C6F670D0A20202020202070466F6375734974656D202D20';
wwv_flow_api.g_varchar2_table(115) := '466C616720746F20696E64696361746520776865746865722074686973206469616C6F67206973206120636F6E6669726D6174696F6E206469616C6F670D0A2020202A2F0D0A202072656E64657265722E73686F774469616C6F67203D2066756E637469';
wwv_flow_api.g_varchar2_table(116) := '6F6E28705374796C652C20704D6573736167652C20705469746C652C2070466F6375734974656D297B0D0A202020206966202870466F6375734974656D20213D20756E646566696E6564297B0D0A20202020202070466F6375734974656D20203D202428';
wwv_flow_api.g_varchar2_table(117) := '272E742D426F647927292E66696E642827696E7075742C20627574746F6E27292E6E6F7428273A68696464656E27292E666972737428292E617474722827696427293B0D0A202020207D3B0D0A20202020636F6E73742063616C6C6261636B203D206675';
wwv_flow_api.g_varchar2_table(118) := '6E6374696F6E28297B0D0A20202020202024286023247B70466F6375734974656D7D60292E666F63757328293B0D0A202020207D3B0D0A20202020636F6E7374206F7074696F6E73203D207B0D0A202020202020226D6F6465726E223A747275652C0D0A';
wwv_flow_api.g_varchar2_table(119) := '202020202020227469746C65223A705469746C652C0D0A2020202020202263616C6C6261636B223A63616C6C6261636B7D3B0D0A202020207377697463682028705374796C65297B0D0A202020202020636173652027414C455254273A0D0A2020202020';
wwv_flow_api.g_varchar2_table(120) := '2020206F7074696F6E732E7374796C65203D20276572726F72273B0D0A20202020202020206D73672E73686F774469616C6F67282222202B20704D6573736167652C206F7074696F6E73293B0D0A2020202020202020627265616B3B0D0A202020202020';
wwv_flow_api.g_varchar2_table(121) := '63617365202753554343455353273A0D0A20202020202020206D73672E73686F77506167655375636365737328704D657373616765293B0D0A20202020202020202428272E742D427574746F6E2D2D636C6F7365416C65727427292E6F6E652827636C69';
wwv_flow_api.g_varchar2_table(122) := '636B272C2066756E6374696F6E28297B0D0A2020202020202020202024286023247B70466F6375734974656D7D60292E666F63757328293B0D0A20202020202020207D293B0D0A2020202020202020627265616B3B0D0A20202020202063617365202757';
wwv_flow_api.g_varchar2_table(123) := '41524E494E47273A0D0A20202020202020206F7074696F6E732E7374796C65203D20277761726E696E67273B0D0A20202020202020206D73672E73686F774469616C6F67282222202B20704D6573736167652C206F7074696F6E73293B0D0A2020202020';
wwv_flow_api.g_varchar2_table(124) := '202020627265616B3B0D0A202020202020636173652027494E464F273A0D0A20202020202020206F7074696F6E732E7374796C65203D2027696E666F726D6174696F6E273B0D0A20202020202020206D73672E73686F774469616C6F67282222202B2070';
wwv_flow_api.g_varchar2_table(125) := '4D6573736167652C206F7074696F6E73293B0D0A2020202020202020627265616B3B0D0A202020207D3B0D0A202020200D0A20207D3B202F2F2073686F774469616C6F670D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F';
wwv_flow_api.g_varchar2_table(126) := '77537563636573730D0A20202020202053686F777320612073756363657373206D657373616765206F6E2074686520706167650D0A0D0A20202020506172616D657465723A0D0A202020202020704D657373616765202D204D65737361676520746F2064';
wwv_flow_api.g_varchar2_table(127) := '6973706C61790D0A2020202A2F0D0A202072656E64657265722E73686F7753756363657373203D2066756E6374696F6E28704D6573736167652C20705469746C652C20705374796C652C2070436F6E6669726D297B0D0A202020206D73672E73686F7750';
wwv_flow_api.g_varchar2_table(128) := '6167655375636365737328704D657373616765293B0D0A20207D3B202F2F2073686F77537563636573730D0A0D0A0D0A20202F2A2A0D0A2020202046756E6374696F6E20736574526567696F6E436F6E74656E740D0A2020202020204D6574686F642074';
wwv_flow_api.g_varchar2_table(129) := '6F207365742074686520636F6E74656E74206F6620612073746174696320726567696F6E0D0A0D0A20202020506172616D657465723A0D0A20202020202070526567696F6E4964202D20537461746963204944206F662074686520726567696F6E20746F';
wwv_flow_api.g_varchar2_table(130) := '207365742074686520636F6E74657874206F660D0A20202020202070436F6E74656E74202D20436F6E74656E74206F662074686520726567696F6E0D0A2020202A2F0D0A202072656E64657265722E736574526567696F6E436F6E74656E74203D206675';
wwv_flow_api.g_varchar2_table(131) := '6E6374696F6E2870526567696F6E49642C2070436F6E74656E74297B0D0A202020202428272327202B2070526567696F6E4964202B20435F524547494F4E5F424F44595F53454C4543544F52292E68746D6C2870436F6E74656E74293B0D0A20207D3B20';
wwv_flow_api.g_varchar2_table(132) := '2F2F20736574526567696F6E436F6E74656E740D0A20200D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A20736574526567696F6E4865616465720D0A2020202020204D6574686F6420746F2061646A7573742074686520726567696F6E';
wwv_flow_api.g_varchar2_table(133) := '206865616465722E20576F726B732077697468206E6F726D616C20726567696F6E7320616E642074616220726567696F6E732E0D0A2020202020200D0A20202020506172616D65746572733A0D0A20202020202070526567696F6E4964202D204944206F';
wwv_flow_api.g_varchar2_table(134) := '662074686520726567696F6E0D0A20202020202070486561646572202D20486561646572206F662074686520726567696F6E0D0A20202020202070526567696F6E54797065202D2054797065206F662074686520526567696F6E20285461622D206F7220';
wwv_flow_api.g_varchar2_table(135) := '706C61696E20726567696F6E290D0A2020202A2F0D0A202072656E64657265722E736574526567696F6E486561646572203D2066756E6374696F6E2870526567696F6E49642C20704865616465722C2070526567696F6E54797065297B0D0A2020202073';
wwv_flow_api.g_varchar2_table(136) := '77697463682870526567696F6E54797065297B0D0A2020202020206361736520435F524547494F4E5F5441423A0D0A20202020202020202428602353525F247B70526567696F6E49647D5F7461622061207370616E60292E68746D6C2870486561646572';
wwv_flow_api.g_varchar2_table(137) := '290D0A2020202020202020627265616B3B0D0A20202020202064656661756C743A0D0A20202020202020202428272327202B2070526567696F6E4964202B20435F524547494F4E5F5449544C455F53454C4543544F52292E68746D6C2870486561646572';
wwv_flow_api.g_varchar2_table(138) := '293B0D0A2020202020202020627265616B3B0D0A202020207D0D0A20207D3B202F2F20736574526567696F6E4865616465720D0A0D0A20200D0A20202F2A2A0D0A2020202046756E6374696F6E3A2073686F77576169745370696E6E65720D0A20202020';
wwv_flow_api.g_varchar2_table(139) := '202053686F777320612077616974207370696E6E6572206F6E2074686520706167650D0A0D0A20202020506172616D657465723A0D0A20202020202070466C6167202D20466C616720746F20696E646963617465207768657468657220746F2073686F77';
wwv_flow_api.g_varchar2_table(140) := '2028747275652920612077616974207370696E6E6572206F72206E6F74202866616C7365290D0A2020202A2F0D0A202072656E64657265722E73686F77576169745370696E6E6572203D2066756E6374696F6E2870466C6167297B0D0A20202020696628';
wwv_flow_api.g_varchar2_table(141) := '70466C6167297B0D0A202020202020617065782E7574696C2E73686F775370696E6E657228293B0D0A202020207D0D0A20202020656C73657B0D0A20202020202024282223617065785F776169745F6F7665726C617922292E72656D6F766528293B0D0A';
wwv_flow_api.g_varchar2_table(142) := '2020202020202428222E752D50726F63657373696E6722292E72656D6F766528293B0D0A202020207D3B0D0A20207D3B202F2F2073686F77576169745370696E6E65720D0A0D0A20200D0A20202F2A2A200D0A2020202046756E6374696F6E3A20737562';
wwv_flow_api.g_varchar2_table(143) := '6D6974506167650D0A2020202020204D6574686F64207375626D697473207061676520776974682074686520676976656E2072657175657374206966206E6F206572726F727320617265206F6E2074686520706167652E0D0A0D0A20202020506172616D';
wwv_flow_api.g_varchar2_table(144) := '65746572733A0D0A2020202020207052657175657374202D205265717565737420666F7220746865207365727665720D0A202020202020704D657373616765202D20416C657274206D657373616765207761726E696E6720746865207573657220696620';
wwv_flow_api.g_varchar2_table(145) := '7375626D697420636F756C646E27742062652065786563757465642064756520746F206572726F7273206F6E20706167650D0A2020202A2F0D0A202072656E64657265722E7375626D697450616765203D2066756E6374696F6E2870526571756573742C';
wwv_flow_api.g_varchar2_table(146) := '20704D657373616765297B0D0A20202020696620282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D203029207B0D0A202020202020617065782E706167652E7375626D6974287B0D0A2020202020202020227265';
wwv_flow_api.g_varchar2_table(147) := '717565737422203A2070526571756573742C0D0A20202020202020202273686F775761697422203A20747275650D0A2020202020207D293B0D0A202020207D0D0A20202020656C73657B0D0A2020202020206D73672E616C65727428704D657373616765';
wwv_flow_api.g_varchar2_table(148) := '293B0D0A202020207D0D0A20207D3B202F2F207375626D6974506167650D0A0D0A7D292864652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F322C20617065782E6D657373616765293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740441832304785502)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/renderer.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722064653D64657C7C7B7D3B64652E636F6E6465733D64652E636F6E6465737C7C7B7D2C64652E636F6E6465732E706C7567696E3D64652E636F6E6465732E706C7567696E7C7C7B7D2C64652E636F6E6465732E706C7567696E2E6164633D64652E';
wwv_flow_api.g_varchar2_table(2) := '636F6E6465732E706C7567696E2E6164637C7C7B7D2C64652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F323D7B7D2C66756E6374696F6E28652C61297B636F6E737420743D226164632D64697361626C6564222C6F3D2269';
wwv_flow_api.g_varchar2_table(3) := '732D7265717569726564222C733D22726561646F6E6C79222C6E3D2264697361626C6564222C693D2261706578616674657272656672657368223B652E616C69676E5265706F7274566572746963616C546F703D66756E6374696F6E2865297B76617220';
wwv_flow_api.g_varchar2_table(4) := '613D24286023247B657D60293B612E66696E642822746422292E616464436C6173732822752D616C69676E546F7022292C612E6F6E2869297D2C652E636C6561724572726F72733D66756E6374696F6E28297B674572726F72733D5B5D2C675761726E69';
wwv_flow_api.g_varchar2_table(5) := '6E67733D5B5D2C612E636C6561724572726F727328297D2C652E636C6561724E6F74696669636174696F6E3D66756E6374696F6E28297B612E68696465506167655375636365737328297D2C652E636F6E6669726D526571756573743D66756E6374696F';
wwv_flow_api.g_varchar2_table(6) := '6E28612C742C6F297B6C657420732C6E3B22737472696E67223D3D747970656F6620613F733D613A28733D612E646174612E6D6573736167652C6E3D612E646174612E7469746C65292C617065782E6D6573736167652E636F6E6669726D28732C286675';
wwv_flow_api.g_varchar2_table(7) := '6E6374696F6E2865297B653F742861293A617065782E6974656D286F292E736574466F63757328297D29292C652E7365744D6F64616C4469616C6F675469746C65286E297D2C652E64697361626C65456C656D656E743D66756E6374696F6E2865297B76';
wwv_flow_api.g_varchar2_table(8) := '617220613D24282223222B65292C6F3D24282223222B652B225F4C4142454C22293B617065782E6974656D2865292E73686F7728292C612E70726F7028732C2130292E616464436C6173732822617065785F64697361626C656422292E61747472282261';
wwv_flow_api.g_varchar2_table(9) := '7269612D64697361626C6564222C227472756522292E617474722822746162696E646578222C222D3122292C612E686173436C617373282273656C6563746C69737422293F28612E6174747228732C73292C6F2E616464436C617373287429293A28612E';
wwv_flow_api.g_varchar2_table(10) := '686173436C6173732822686173446174657069636B657222297C7C612E686173436C6173732822636F6C6F725F7069636B657222297C7C612E686173436C6173732822706F7075705F6C6F762229292626612E706172656E7428292E66696E6428226275';
wwv_flow_api.g_varchar2_table(11) := '74746F6E22292E70726F70286E2C2130297D2C652E656E61626C65456C656D656E743D66756E6374696F6E2865297B76617220613D24286023247B657D60293B612E70726F7028732C2131292E72656D6F7665436C6173732874292E72656D6F76654174';
wwv_flow_api.g_varchar2_table(12) := '74722822746162696E64657822292C612E6973282273656C6563742229262624286023247B657D3A6E6F74283A73656C65637465642960292E70726F7028732C2131292C617065782E6974656D2865292E73686F7728292C617065782E6974656D286529';
wwv_flow_api.g_varchar2_table(13) := '2E656E61626C6528292C612E686173436C6173732822686173446174657069636B657222297C7C612E686173436C6173732822636F6C6F725F7069636B657222297C7C612E686173436C6173732822706F7075705F6C6F7622293F612E706172656E7428';
wwv_flow_api.g_varchar2_table(14) := '292E66696E642822627574746F6E22292E70726F70286E2C2131292E72656D6F7665436C6173732874292E72656D6F7665417474722822746162696E64657822293A612E686173436C6173732822636F6C6F725F7069636B657222293F24282223222B65';
wwv_flow_api.g_varchar2_table(15) := '2B225F6669656C6473657422292E70726F7028732C2131292E72656D6F7665436C6173732874292E72656D6F7665417474722822746162696E64657822293A612E686173436C6173732822706F7075705F6C6F7622292626612E636C6F73657374282223';
wwv_flow_api.g_varchar2_table(16) := '222B652B225F6669656C6473657422292E66696E6428222E612D427574746F6E2D2D706F7075704C4F5622292E70726F7028732C2131292E72656D6F7665436C6173732874292E72656D6F7665417474722822746162696E64657822297D2C652E686964';
wwv_flow_api.g_varchar2_table(17) := '655265706F727446696C74657250616E656C3D66756E6374696F6E28612C74297B7377697463682874297B6361736522496E7465726163746976655265706F7274223A24286023247B617D5F636F6E726F6C5F70616E656C60292E6869646528293B6272';
wwv_flow_api.g_varchar2_table(18) := '65616B3B6361736522496E74657261637469766547726964223A24286023247B617D202E612D4D65646961426C6F636B60292E6869646528297D24286023247B617D60292E6F6E28692C2866756E6374696F6E28297B652E686964655265706F72744669';
wwv_flow_api.g_varchar2_table(19) := '6C74657250616E656C28612C74297D29297D2C652E686967686C69676874526F773D66756E6374696F6E28652C61297B652E616464436C61737328226164632D73656C65637465642D726F7722292E7369626C696E677328292E72656D6F7665436C6173';
wwv_flow_api.g_varchar2_table(20) := '7328226164632D73656C65637465642D726F7722292C612626652E66696E64282274643A66697273742D6368696C64206122292E666F63757328297D2C652E73686F774572726F72733D66756E6374696F6E2865297B612E636C6561724572726F727328';
wwv_flow_api.g_varchar2_table(21) := '292C2428222E742D466F726D2D7761726E696E6722292E72656D6F7665436C6173732822617065782D706167652D6974656D2D7761726E696E6722292E706172656E747328222E742D466F726D2D696E707574436F6E7461696E657222292E66696E6428';
wwv_flow_api.g_varchar2_table(22) := '222E742D466F726D2D7761726E696E6722292E72656D6F7665436C6173732822742D466F726D2D7761726E696E6722292C612E73686F774572726F72732865292C242E6561636828652C2866756E6374696F6E28652C61297B227761726E696E67223D3D';
wwv_flow_api.g_varchar2_table(23) := '612E74797065262624286023247B612E706167654974656D7D60292E72656D6F7665436C6173732822617065782D706167652D6974656D2D6572726F7222292E616464436C6173732822617065782D706167652D6974656D2D7761726E696E6722292E70';
wwv_flow_api.g_varchar2_table(24) := '6172656E747328222E742D466F726D2D696E707574436F6E7461696E657222292E66696E6428222E742D466F726D2D6572726F7222292E72656D6F7665436C6173732822742D466F726D2D6572726F7222292E616464436C6173732822742D466F726D2D';
wwv_flow_api.g_varchar2_table(25) := '7761726E696E6722297D29297D2C652E7365744974656D4C6162656C3D66756E6374696F6E28652C61297B24286023247B657D5F4C4142454C60292E746578742861297D2C652E7365744974656D4D616E6461746F72793D66756E6374696F6E28652C61';
wwv_flow_api.g_varchar2_table(26) := '297B76617220743D24286023247B657D5F434F4E5441494E455260293B742E72656D6F7665436C617373286F292C612626742E616464436C617373286F297D2C652E7365744D6F64616C4469616C6F675469746C653D66756E6374696F6E2865297B7061';
wwv_flow_api.g_varchar2_table(27) := '72656E742E242822202E75692D6469616C6F672D7469746C6522292E6C61737428292E68746D6C2865297D2C652E73686F774469616C6F673D66756E6374696F6E28652C742C6F2C73297B6E756C6C213D73262628733D2428222E742D426F647922292E';
wwv_flow_api.g_varchar2_table(28) := '66696E642822696E7075742C20627574746F6E22292E6E6F7428223A68696464656E22292E666972737428292E61747472282269642229293B636F6E7374206E3D7B6D6F6465726E3A21302C7469746C653A6F2C63616C6C6261636B3A66756E6374696F';
wwv_flow_api.g_varchar2_table(29) := '6E28297B24286023247B737D60292E666F63757328297D7D3B7377697463682865297B6361736522414C455254223A6E2E7374796C653D226572726F72222C612E73686F774469616C6F672822222B742C6E293B627265616B3B63617365225355434345';
wwv_flow_api.g_varchar2_table(30) := '5353223A612E73686F7750616765537563636573732874292C2428222E742D427574746F6E2D2D636C6F7365416C65727422292E6F6E652822636C69636B222C2866756E6374696F6E28297B24286023247B737D60292E666F63757328297D29293B6272';
wwv_flow_api.g_varchar2_table(31) := '65616B3B63617365225741524E494E47223A6E2E7374796C653D227761726E696E67222C612E73686F774469616C6F672822222B742C6E293B627265616B3B6361736522494E464F223A6E2E7374796C653D22696E666F726D6174696F6E222C612E7368';
wwv_flow_api.g_varchar2_table(32) := '6F774469616C6F672822222B742C6E297D7D2C652E73686F77537563636573733D66756E6374696F6E28652C742C6F2C73297B612E73686F7750616765537563636573732865297D2C652E736574526567696F6E436F6E74656E743D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(33) := '28652C61297B24282223222B652B22202E742D526567696F6E2D626F64792C2E742D436F6E74656E74426C6F636B2D626F647922292E68746D6C2861297D2C652E736574526567696F6E4865616465723D66756E6374696F6E28652C612C74297B696628';
wwv_flow_api.g_varchar2_table(34) := '22546162223D3D3D74292428602353525F247B657D5F7461622061207370616E60292E68746D6C2861293B656C73652024282223222B652B22202E742D526567696F6E2D7469746C6522292E68746D6C2861297D2C652E73686F77576169745370696E6E';
wwv_flow_api.g_varchar2_table(35) := '65723D66756E6374696F6E2865297B653F617065782E7574696C2E73686F775370696E6E657228293A2824282223617065785F776169745F6F7665726C617922292E72656D6F766528292C2428222E752D50726F63657373696E6722292E72656D6F7665';
wwv_flow_api.g_varchar2_table(36) := '2829297D2C652E7375626D6974506167653D66756E6374696F6E28652C74297B303D3D2428226469762E612D4E6F74696669636174696F6E2D2D6572726F7222292E6C656E6774683F617065782E706167652E7375626D6974287B726571756573743A65';
wwv_flow_api.g_varchar2_table(37) := '2C73686F77576169743A21307D293A612E616C6572742874297D7D2864652E636F6E6465732E706C7567696E2E6164632E617065785F34325F32305F322C617065782E6D657373616765293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(740442230179785502)
,p_plugin_id=>wwv_flow_api.id(43931307690644833305)
,p_file_name=>'adc/js/renderer.min.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(800468936563812491)
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
,p_navigation_list_id=>wwv_flow_api.id(800329166210812392)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(800432363465812456)
,p_nav_list_template_options=>'#DEFAULT#:js-defaultCollapsed:js-navCollapsed--hidden:t-TreeNav--styleA'
,p_css_file_urls=>'#APP_IMAGES#app-icon.css?version=#APP_VERSION#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(800468628234812491)
,p_nav_bar_list_template_id=>wwv_flow_api.id(800435172231812456)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Global Page - Desktop'
,p_step_title=>'Global Page - Desktop'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221218084018'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(799844067107981240)
,p_name=>'ADC'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'CURRENT_PAGE_NOT_IN_CONDITION'
,p_display_when_cond=>'100,101,9999'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(799844163494981241)
,p_event_id=>wwv_flow_api.id(799844067107981240)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Startseite'
,p_alias=>'HOME'
,p_step_title=>'ADC Beispielanwendung'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221005111538'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(799844492507981244)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800479825320812539)
,p_plug_name=>'ADC Beispielanwendung'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800374063382812427)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(804125730077470836)
,p_plug_name=>'Main Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(804125492796470817)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(873705288021814346)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_OVERVIEW'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(799844658584981245)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(799844492507981244)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'ADC verwenden'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:USEADC:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(518398445700061470)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(873705288021814346)
,p_button_name=>'ADPTI'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Anwendungstexte bearbeiten'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_button_redirect_url=>'f?p=&APP_ID.:ADPTI:&SESSION.::&DEBUG.:::'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'ADC verwenden'
,p_alias=>'USEADC'
,p_step_title=>'ADC verwenden'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220122084351'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800529935353604403)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(873751270494507976)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(947611117041280499)
,p_plug_name=>'ADC in ihre Anwendung einbinden'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h1:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(800531853320668556)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(873751270494507976)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(799844761098981246)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(873751270494507976)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
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
 p_id=>wwv_flow_api.id(799844953016981248)
,p_plug_name=>unistr('Dynamische Anwendungsseite ohne Anwendungsf\00E4lle')
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(799845039971981249)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(874438484986146192)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(879271855670165663)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(947659820127049765)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1021519666673822288)
,p_plug_name=>'Die ADC Administartionsanwendung'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(799844817676981247)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1021519666673822288)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804526829432752852)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(947659820127049765)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804526559955751878)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(947659820127049765)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(799845128609981250)
,p_name=>'P3_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(799845039971981249)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445418675812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(799845248921981251)
,p_name=>'P3_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(799845039971981249)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(799845287329981252)
,p_name=>'P3_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(799845039971981249)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_alias=>'ADANF'
,p_step_title=>unistr('Einfache Anwendungsf\00E4lle')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221004174353'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(873765380812466737)
,p_plug_name=>'Anmerkungen zum Formular'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(873765467767466738)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(948358912781631681)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(958699763269373698)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1021580247922535254)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1095440094469307777)
,p_plug_name=>unistr('Einfache Anwendungsf\00E4lle')
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(800546476626627334)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1095440094469307777)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804529613633784492)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1021580247922535254)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804529341081783334)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1021580247922535254)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800548567433627336)
,p_name=>'P4_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(873765467767466738)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800548987672627338)
,p_name=>'P4_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(873765467767466738)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800549366291627339)
,p_name=>'P4_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(873765467767466738)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
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
 p_id=>wwv_flow_api.id(947706618363318437)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
 p_id=>wwv_flow_api.id(947706705318318438)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(1022300150332483381)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1038128482996619973)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1095521485473386954)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1169381332020159477)
,p_plug_name=>'Einfache Validierungen erstellen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(800567287612993544)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1169381332020159477)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804530978783789108)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1095521485473386954)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804530743931788038)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1095521485473386954)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800569377923993547)
,p_name=>'P5_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(947706705318318438)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800569857627993547)
,p_name=>'P5_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(947706705318318438)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800570198914993549)
,p_name=>'P5_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(947706705318318438)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Komplexere Validierungen'
,p_alias=>'ADVAL2'
,p_step_title=>'Komplexere Validierungen'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220706164052'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1021909227090732097)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1021909314045732098)
,p_plug_name=>'Beispieldialog (keine Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(1096502759059897041)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1117559466682879757)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1169724094200800614)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1243583940747573137)
,p_plug_name=>'Komplexere Validierungen einrichten'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(800828724313555506)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1243583940747573137)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804532410074793939)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1169724094200800614)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.:P7_EMP_ID:118'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804532076544792778)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1169724094200800614)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800830854804555508)
,p_name=>'P6_REQUIRED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1021909314045732098)
,p_prompt=>'Pflichtfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800831168011555511)
,p_name=>'P6_NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(1021909314045732098)
,p_prompt=>'Zahlenfeld'
,p_format_mask=>'fm99999990'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800831585230555511)
,p_name=>'P6_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(1021909314045732098)
,p_prompt=>'Datumsfeld'
,p_format_mask=>'dd.mm.yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Kontrolle des Seitenstatus'
,p_alias=>'ADSTA'
,p_step_title=>'Kontrolle des Seitenstatus'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220706170530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(799846794802981267)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1096410645571899698)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1096410732526899699)
,p_plug_name=>'Beispieldialog (Formularregion)'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(1171004177541064642)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1244225512681968215)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1318085359228740738)
,p_plug_name=>'Kontrolle des Seitenstatus'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(801127452150309452)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1318085359228740738)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804533786007799730)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1244225512681968215)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(804533510464798533)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1244225512681968215)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.::'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258278850792330)
,p_name=>'P7_EMP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Mitarbeiternummer'
,p_source=>'EMP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_read_only_when=>'P7_EMP_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258357991792331)
,p_name=>'P7_EMP_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Vorname'
,p_source=>'EMP_FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258394729792332)
,p_name=>'P7_EMP_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Nachname'
,p_source=>'EMP_LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258514006792333)
,p_name=>'P7_EMP_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Email'
,p_source=>'EMP_EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258613250792334)
,p_name=>'P7_EMP_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Telefon'
,p_source=>'EMP_PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258765467792335)
,p_name=>'P7_EMP_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Einstelldatum'
,p_source=>'EMP_HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258857618792336)
,p_name=>'P7_EMP_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Beruf'
,p_source=>'EMP_JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_JOBS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615258917675792337)
,p_name=>'P7_EMP_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Gehalt'
,p_source=>'EMP_SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259075890792338)
,p_name=>'P7_EMP_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Boni'
,p_source=>'EMP_COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259114070792339)
,p_name=>'P7_EMP_MGR_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Manager'
,p_source=>'EMP_MGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259230732792340)
,p_name=>'P7_EMP_DEP_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_item_source_plug_id=>wwv_flow_api.id(1096410732526899699)
,p_prompt=>'Abteilung'
,p_source=>'EMP_DEP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_DEPARTMENTS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(799845518930981254)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(1096410732526899699)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Seitenkommandos'
,p_alias=>'ADACT'
,p_step_title=>'Seitenkommandos'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221004171441'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(879447987068334660)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1176011837837253091)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1176011924792253092)
,p_plug_name=>'Mitarbeiterliste (Interactive Grid)'
,p_region_name=>'R8_EMPLOYEES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(615259379679792341)
,p_name=>'EMP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Mitarbeiternummer'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(615259478756792342)
,p_name=>'EMP_FIRST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_FIRST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(615259501412792343)
,p_name=>'EMP_LAST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_LAST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nachname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(615259660135792344)
,p_name=>'DEP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEP_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Abteilung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(803327913225804448)
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
 p_id=>wwv_flow_api.id(803326613118804435)
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
 p_id=>wwv_flow_api.id(806325969315585352)
,p_interactive_grid_id=>wwv_flow_api.id(803326613118804435)
,p_static_id=>'797013'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(806326252329585352)
,p_report_id=>wwv_flow_api.id(806325969315585352)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615593794014800157)
,p_view_id=>wwv_flow_api.id(806326252329585352)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(615259379679792341)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615594693139800164)
,p_view_id=>wwv_flow_api.id(806326252329585352)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(615259478756792342)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615595613906800167)
,p_view_id=>wwv_flow_api.id(806326252329585352)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(615259501412792343)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615596519776800170)
,p_view_id=>wwv_flow_api.id(806326252329585352)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(615259660135792344)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(806330280677585367)
,p_view_id=>wwv_flow_api.id(806326252329585352)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(803327913225804448)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1250605369806418035)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1323826704947321608)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1397686551494094131)
,p_plug_name=>'Seitenkommandos'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(806227522926495258)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1397686551494094131)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(803328146252804450)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1176011924792253092)
,p_button_name=>'EDIT_EMP'
,p_button_static_id=>'B8_EDIT_EMP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Edit Emp'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806228576219495261)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1323826704947321608)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806228243473495258)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1323826704947321608)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMP_ID:118'
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Mitarbeiter bearbeiten'
,p_alias=>'EDEMP'
,p_page_mode=>'MODAL'
,p_step_title=>'Mitarbeiter bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220706162736'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(806425165437847042)
,p_plug_name=>'Mitarbeiter bearbeiten'
,p_region_name=>'R9_EDEMP_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
 p_id=>wwv_flow_api.id(806433261565847081)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806433662520847083)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(806433261565847081)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806435200541847088)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(806433261565847081)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P7_EMP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806435601223847088)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(806433261565847081)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_EMP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(806435963533847088)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(806433261565847081)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P7_EMP_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259716186792345)
,p_name=>'P9_EMP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_source=>'EMP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259840371792346)
,p_name=>'P9_EMP_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Vorname'
,p_source=>'EMP_FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259895558792347)
,p_name=>'P9_EMP_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Nachname'
,p_source=>'EMP_LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615259997277792348)
,p_name=>'P9_EMP_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Email'
,p_source=>'EMP_EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260122397792349)
,p_name=>'P9_EMP_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Telefon'
,p_source=>'EMP_PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260243524792350)
,p_name=>'P9_EMP_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Einstelldatum'
,p_source=>'EMP_HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260338679792351)
,p_name=>'P9_EMP_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Beruf'
,p_source=>'EMP_JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_JOBS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260434344792352)
,p_name=>'P9_EMP_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Gehalt'
,p_source=>'EMP_SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260572518792353)
,p_name=>'P9_EMP_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Boni'
,p_source=>'EMP_COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260659154792354)
,p_name=>'P9_EMP_MGR_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Manager'
,p_source=>'EMP_MGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615260721521792355)
,p_name=>'P9_EMP_DEP_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(806425165437847042)
,p_item_source_plug_id=>wwv_flow_api.id(806425165437847042)
,p_prompt=>'Abteilung'
,p_source=>'EMP_DEP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_DEPARTMENTS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(806433713694847083)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(806433662520847083)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(806434483343847086)
,p_event_id=>wwv_flow_api.id(806433713694847083)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(806436843882847089)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(806425165437847042)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Mitarbeiter bearbeiten'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(806437183886847089)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(806436432111847089)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(806425165437847042)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Zeile in Bericht erkennen'
,p_alias=>'ADREP'
,p_step_title=>'Zeile in Bericht erkennen'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220706172030'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(816425561945927027)
,p_plug_name=>'Beispielbericht (Interactive Report)'
,p_region_name=>'R10_EMPLOYEE_IR'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(816425602003927028)
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
 p_id=>wwv_flow_api.id(615261266630792360)
,p_db_column_name=>'EMP_ID'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Mitarbeiternummer'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(615261283685792361)
,p_db_column_name=>'EMP_FIRST_NAME'
,p_display_order=>30
,p_column_identifier=>'G'
,p_column_label=>'Vorname'
,p_column_html_expression=>'<span data-id="#EMP_ID#">#EMP_FIRST_NAME#</span>'
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
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(615261435973792362)
,p_db_column_name=>'EMP_LAST_NAME'
,p_display_order=>40
,p_column_identifier=>'H'
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
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(816426137919927033)
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
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(615261545848792363)
,p_db_column_name=>'DEP_NAME'
,p_display_order=>60
,p_column_identifier=>'I'
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
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(817932016151820155)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'913073'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'JOB_TITLE:EMP_ID:EMP_FIRST_NAME:EMP_LAST_NAME:DEP_NAME'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(816426267695927035)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(816426434185927036)
,p_name=>'Beispielbericht (Classic Report)'
,p_region_name=>'R10_EMPLOYEE_CR'
,p_template=>wwv_flow_api.id(800383684570812430)
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
,p_query_row_template=>wwv_flow_api.id(800406163128812441)
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
 p_id=>wwv_flow_api.id(615261675999792364)
,p_query_column_id=>1
,p_column_alias=>'EMP_ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(615261692085792365)
,p_query_column_id=>2
,p_column_alias=>'EMP_FIRST_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'Vorname'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span data-id="#EMP_ID#">#EMP_FIRST_NAME#</span>'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(615261878662792366)
,p_query_column_id=>3
,p_column_alias=>'EMP_LAST_NAME'
,p_column_display_sequence=>40
,p_column_heading=>'Nachname'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(615261940304792367)
,p_query_column_id=>4
,p_column_alias=>'DEP_NAME'
,p_column_display_sequence=>60
,p_column_heading=>'Abteilung'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(816426912468927041)
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
 p_id=>wwv_flow_api.id(816427019997927042)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_ADREP_PAGE3'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(970730485937664499)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1267294336706582930)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1267294423661582931)
,p_plug_name=>'Beispielbericht (Interactive Grid)'
,p_region_name=>'R10_EMPLOYEES_IG'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(615260817422792356)
,p_name=>'EMP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(615260950471792357)
,p_name=>'EMP_FIRST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_FIRST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
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
 p_id=>wwv_flow_api.id(615261026160792358)
,p_name=>'EMP_LAST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_LAST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nachname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
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
 p_id=>wwv_flow_api.id(615261167106792359)
,p_name=>'DEP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEP_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Abteilung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
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
 p_id=>wwv_flow_api.id(894610412095134287)
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
 p_id=>wwv_flow_api.id(894609111988134274)
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
 p_id=>wwv_flow_api.id(897608468184915191)
,p_interactive_grid_id=>wwv_flow_api.id(894609111988134274)
,p_static_id=>'797013'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(897608751198915191)
,p_report_id=>wwv_flow_api.id(897608468184915191)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615614226002839281)
,p_view_id=>wwv_flow_api.id(897608751198915191)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(615260817422792356)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615615167294839282)
,p_view_id=>wwv_flow_api.id(897608751198915191)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(615260950471792357)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615615995816839285)
,p_view_id=>wwv_flow_api.id(897608751198915191)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(615261026160792358)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(615616976673839289)
,p_view_id=>wwv_flow_api.id(897608751198915191)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(615261167106792359)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(897612779546915206)
,p_view_id=>wwv_flow_api.id(897608751198915191)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(894610412095134287)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1341895009867750260)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>60
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1415109203816651447)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1488969050363423970)
,p_plug_name=>'Zeile in Berichten erkennen'
,p_region_name=>'Berichte'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(817908366711471663)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1488969050363423970)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(817909484912471664)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1415109203816651447)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(817909140349471664)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1415109203816651447)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMP_ID:118'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(816426206809927034)
,p_name=>'P10_EMP_ID_IR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(816425561945927027)
,p_prompt=>unistr('gew\00E4hlte ID')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(817913632465471666)
,p_name=>'P10_EMP_ID_IG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1267294423661582931)
,p_prompt=>unistr('gew\00E4hlte ID')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_alias=>'PSEUDO'
,p_step_title=>unistr('\00DCbersicht \00FCber die Pseudospalten')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210818121000'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(884239114096094557)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1031320295783770653)
,p_plug_name=>'Use ADC'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Tutorial'
,p_alias=>'TUTORIAL'
,p_step_title=>'Tutorial'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210818115805'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(818328861609856339)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(891546506896695722)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(892181839709527017)
,p_plug_name=>'ADC Tutorial'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800374063382812427)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(895827744466185314)
,p_plug_name=>'Tutorial Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(818332938981970511)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(965407302410528824)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_TUTORIAL'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(818327423026856331)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(891546506896695722)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Dokumentation'
,p_alias=>'DOC'
,p_step_title=>'Dokumentation'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210819103929'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(910039279163856081)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(983892257263526759)
,p_plug_name=>'ADC Dokumentation'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800374063382812427)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(987538162020185056)
,p_plug_name=>'Documentation Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(818338631204147724)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1057117719964528566)
,p_plug_name=>'Overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Mitgelieferte Aktionstypen'
,p_alias=>'MENU_CAT'
,p_step_title=>'Mitgelieferte Aktionstypen'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210819123222'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(818528308662393813)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1079539021533890801)
,p_plug_name=>'ActionType Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayIcons:t-Cards--3cols:t-Cards--desc-2ln:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(818626033203850222)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(800435656587812456)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00015
begin
wwv_flow_api.create_page(
 p_id=>15
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_alias=>'CATPI'
,p_step_title=>unistr('Aktionstypen f\00FCr Seitenelemente')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230131092448'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(816427193366927044)
,p_plug_name=>'Aktionstypen'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(823026422135704552)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(800429403973812455)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(816427352104927045)
,p_plug_name=>'Details'
,p_region_name=>'R15_CAT_LIST'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(818627718123864880)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
end;
/
prompt --application/pages/page_00016
begin
wwv_flow_api.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Erweiterte Initialisierung'
,p_alias=>'EINIT'
,p_step_title=>'Erweiterte Initialisierung'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230131092142'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(923576044815250812)
,p_plug_name=>'Mitarbeiter bearbeiten'
,p_region_name=>'R9_EDEMP_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>5
,p_plug_display_column=>3
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
 p_id=>wwv_flow_api.id(999021595041449697)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_INIT_PAGE'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1286556842895681686)
,p_plug_name=>'Erweiterte Initialisierung'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_source=>'sadc_ui.print_text(''UI_INIT_S1'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1295585834104369551)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_source=>'sadc_ui.print_text(''UI_INIT_S2'');'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1443395707444426056)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(615262706762792375)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(923576044815250812)
,p_button_name=>'RELOAD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'In Modus COMMISSION laden'
,p_button_position=>'ABOVE_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:extended_initialization:&SESSION.::&DEBUG.::P16_PAGE_MODE:COMMISSION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(616054115840508426)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(923576044815250812)
,p_button_name=>'RELOAD_STD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'In Normalmodus laden'
,p_button_position=>'ABOVE_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:extended_initialization:&SESSION.::&DEBUG.::P16_PAGE_MODE:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(616062810647553534)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1286556842895681686)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618456370738135776)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(1443395707444426056)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618456753015135778)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1443395707444426056)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMP_ID:118'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(615262673844792374)
,p_name=>'P16_PAGE_MODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616038838736435118)
,p_name=>'P16_EMP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_source=>'EMP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616039232904435120)
,p_name=>'P16_EMP_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Vorname'
,p_source=>'EMP_FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616039589512435120)
,p_name=>'P16_EMP_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Nachname'
,p_source=>'EMP_LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'adc-mandatory'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616040030436435121)
,p_name=>'P16_EMP_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Email'
,p_source=>'EMP_EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>25
,p_tag_css_classes=>'adc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616040389639435121)
,p_name=>'P16_EMP_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Telefon'
,p_source=>'EMP_PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616040802920435121)
,p_name=>'P16_EMP_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Einstelldatum'
,p_source=>'EMP_HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_tag_css_classes=>'adc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616041227386435121)
,p_name=>'P16_EMP_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Beruf'
,p_source=>'EMP_JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_JOBS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- bitte w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'adc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616041584966435121)
,p_name=>'P16_EMP_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Gehalt'
,p_source=>'EMP_SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616042054145435121)
,p_name=>'P16_EMP_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Boni'
,p_source=>'EMP_COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616042462429435123)
,p_name=>'P16_EMP_MGR_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Manager'
,p_source=>'EMP_MGR_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(616042793122435123)
,p_name=>'P16_EMP_DEP_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(923576044815250812)
,p_item_source_plug_id=>wwv_flow_api.id(923576044815250812)
,p_prompt=>'Abteilung'
,p_source=>'EMP_DEP_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_DEPARTMENTS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- optional w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(616046575332435126)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(923576044815250812)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Mitarbeiter bearbeiten'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00017
begin
wwv_flow_api.create_page(
 p_id=>17
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>unistr('Seitenkommandos ausf\00FChren')
,p_alias=>'CAAEX'
,p_step_title=>unistr('Seitenkommandos ausf\00FChren')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20230131092201'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(999039652611944741)
,p_plug_name=>'Auf der Seite'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--shadowBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1295603503380863172)
,p_plug_name=>'Anmerkungen'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(1295603590335863173)
,p_plug_name=>'Mitarbeiterliste (Interactive Grid)'
,p_region_name=>'R8_EMPLOYEES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(734851045223402422)
,p_name=>'EMP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Mitarbeiternummer'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(734851144300402423)
,p_name=>'EMP_FIRST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_FIRST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Vorname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(734851166956402424)
,p_name=>'EMP_LAST_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMP_LAST_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Nachname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(734851325679402425)
,p_name=>'DEP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEP_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Abteilung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(922919578769414529)
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
 p_id=>wwv_flow_api.id(922918278662414516)
,p_internal_uid=>424031295258383191
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
 p_id=>wwv_flow_api.id(925917634859195433)
,p_interactive_grid_id=>wwv_flow_api.id(922918278662414516)
,p_static_id=>'797013'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(925917917873195433)
,p_report_id=>wwv_flow_api.id(925917634859195433)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(735185459558410238)
,p_view_id=>wwv_flow_api.id(925917917873195433)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(734851045223402422)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(735186358683410245)
,p_view_id=>wwv_flow_api.id(925917917873195433)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(734851144300402423)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(735187279450410248)
,p_view_id=>wwv_flow_api.id(925917917873195433)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(734851166956402424)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(735188185320410251)
,p_view_id=>wwv_flow_api.id(925917917873195433)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(734851325679402425)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(925921946221195448)
,p_view_id=>wwv_flow_api.id(925917917873195433)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(922919578769414529)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1370197035350028116)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1443418370490931689)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
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
 p_id=>wwv_flow_api.id(1517278217037704212)
,p_plug_name=>'Seitenkommandos'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h2:t-ContentBlock--lightBG'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
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
 p_id=>wwv_flow_api.id(618485033904641437)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1517278217037704212)
,p_button_name=>'ADC_APP'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'ADC-Administrationsanwendung aufrufen'
,p_button_position=>'BODY'
,p_button_redirect_url=>'&SADC_ADC_URL.'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618482976061641435)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(1295603590335863173)
,p_button_name=>'EDIT_EMP'
,p_button_static_id=>'B8_EDIT_EMP'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Edit Emp'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618483899431641435)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(1443418370490931689)
,p_button_name=>'NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_NEXT_TITLE.'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_NEXT_TARGET.:&SESSION.::&DEBUG.:&SADC_NEXT_ID.::'
,p_button_condition=>'SADC_NEXT_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618484367665641437)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(1443418370490931689)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(800446299544812463)
,p_button_image_alt=>'&SADC_PREV_TITLE.'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:&SADC_PREV_TARGET.:&SESSION.::&DEBUG.:&SADC_PREV_ID.:P7_EMP_ID:118'
,p_button_condition=>'SADC_PREV_TARGET'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
end;
/
prompt --application/pages/page_00050
begin
wwv_flow_api.create_page(
 p_id=>50
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Elemente mit ADC'
,p_alias=>'ELEMS'
,p_step_title=>'Elemente mit ADC'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20221218094349'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(510921904818287241)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(510922059221287242)
,p_plug_name=>'Hinweise'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h1'
,p_plug_template=>wwv_flow_api.id(800363678294812424)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('<p>Diese Seite dient der schnellen \00DCberpr\00FCfung von ADC. Es stellt alle Seitenelemente auf den beschriebenen Seitenzustand. Deaktive Elemente m\00FCssen deaktiv sein, aktive aktiv. Pflichtelemente m\00FCssen die, f\00FCr das Theme festgelegte, Visualisierung von ')
||'Pflichtfeldern aufweisen.</p>',
'<p>Der Fokus liegt im ersten Eingabefeld, "aktives Textfeld".</p>',
unistr('<p>Die Schaltfl\00E4chen m\00FCssen aktiv oder deaktiv sein, die Schaltfl\00E4che "Meldung anzeigen" zeigt eine Benachrichtigung, w\00E4hrend die Schaltfl\00E4che "Speichern" eine Validierungsfehlermeldung f\00FCr alle leeren Pflichtfelder ausgeben soll.</p>'),
unistr('<p>Alle Pflicht-, Zahl- und Datumsfelder m\00FCssen dynamisch validieren.</p>')))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(44412026379437991107)
,p_plug_name=>'Elemente'
,p_region_name=>'R7_ELEMENTE'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(44412037602502991134)
,p_plug_name=>'Navigationspfad'
,p_region_name=>'R7_NAVPFAD'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800393146634812434)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(800328672976812391)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(800447587622812464)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618551700215446979)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(510921904818287241)
,p_button_name=>'ZURUECK'
,p_button_static_id=>'B50_ZURUECK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>unistr('Zur\00FCck zur Startseite')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:50::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618552174922446981)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(510921904818287241)
,p_button_name=>'SPEICHERN'
,p_button_static_id=>'B50_SPEICHERN'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Speichern'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618552513857446981)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(510921904818287241)
,p_button_name=>'BUTTON'
,p_button_static_id=>'B50_BUTTON'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Spielbutton'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618552917191446981)
,p_button_sequence=>180
,p_button_plug_id=>wwv_flow_api.id(510921904818287241)
,p_button_name=>'MLD'
,p_button_static_id=>'B50_MLD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Meldung anzeigen'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618540027833446960)
,p_button_sequence=>310
,p_button_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_button_name=>'SCHALTFLAECHE'
,p_button_static_id=>'B50_SCHALTFLAECHE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>unistr('aktive Schaltfl\00E4che')
,p_button_position=>'BODY'
,p_grid_new_row=>'N'
,p_grid_column=>11
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(618540435589446962)
,p_button_sequence=>340
,p_button_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_button_name=>'SCHALTFLAECHE_DEAKTIV'
,p_button_static_id=>'B50_SCHALTFLAECHE_DEAKTIV'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>unistr('deaktive Schaltfl\00E4che')
,p_button_position=>'BODY'
,p_grid_new_row=>'N'
,p_grid_column=>11
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618540810257446965)
,p_name=>'P50_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktives Textfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618541214096446967)
,p_name=>'P50_TEXT_DEAKTIV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktives Textfeld'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618541672997446967)
,p_name=>'P50_TEXT_PFLICHT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Textfeld (Pflicht)'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_attribute_06=>'LOWER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618542076991446968)
,p_name=>'P50_ZAHL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktives Zahlenfeld'
,p_format_mask=>'9999999999'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618542432702446968)
,p_name=>'P50_ZAHL_DEAKTIV'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktives Zahlenfeld'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618542837628446968)
,p_name=>'P50_ZAHL_PFLICHT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Zahlenfeld (Pflicht)'
,p_format_mask=>'9999999999'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618543277619446968)
,p_name=>'P50_DATUM'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive Datumsauswahl'
,p_format_mask=>'DD.MM.YYYY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_02=>'+1d'
,p_attribute_03=>'+10d'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618543660533446968)
,p_name=>'P50_DATUM_DEAKTIV'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive Datumsauswahl'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618544078992446970)
,p_name=>'P50_DATUM_PFLICHT'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Datumsauswahl (Pflicht)'
,p_format_mask=>'DD.MM.YYYY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618544468615446970)
,p_name=>'P50_FARBE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive Farbauswahl'
,p_display_as=>'NATIVE_COLOR_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618544827161446970)
,p_name=>'P50_FARBE_DEAKTIV'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive Farbauswahl'
,p_display_as=>'NATIVE_COLOR_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618545269333446970)
,p_name=>'P50_FARBE_PFLICHT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Farbauswahl (Pflicht)'
,p_display_as=>'NATIVE_COLOR_PICKER'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618545639653446970)
,p_name=>'P50_LISTE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive Popup Werteliste'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Display1;Return1,Display2;Return2'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'keine Auswahl'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618545999747446971)
,p_name=>'P50_LISTE_DEAKTIV'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive Popup Werteliste'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Display1;Return1,Display2;Return2'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('optional ausw\00E4hlen')
,p_cSize=>20
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618546465557446971)
,p_name=>'P50_LISTE_PFLICHT'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Popup Werteliste (Pflicht)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Display1;Return1,Display2;Return2'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('bitte ausw\00E4hlen')
,p_cSize=>20
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618546862790446971)
,p_name=>'P50_ANZEIGE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Anzeigefeld'
,p_source=>'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618547204783446971)
,p_name=>'P50_OPTION'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive Optionsgruppe'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_ELEMENTS_RADIO'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618547616083446973)
,p_name=>'P50_OPTION_DEAKTIV'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive Optionsgruppe'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_ELEMENTS_RADIO'
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618548064917446973)
,p_name=>'P50_AUSWAHL'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive Auswahlliste'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ELEMENTS_CHECKBOX'
,p_cHeight=>1
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618548459016446973)
,p_name=>'P50_AUSWAHL_DEAKTIV'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive Auswahlliste'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ELEMENTS_CHECKBOX'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('optional ausw\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618548875911446973)
,p_name=>'P50_AUSWAHL_PFLICHT'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'Auswahlliste (Pflicht)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ELEMENTS_CHECKBOX'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('bitte ausw\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'ek-pflicht'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618549207630446973)
,p_name=>'P50_JA_NEIN'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'aktive "Ja-Nein"-Liste'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_label_column_span=>2
,p_read_only_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618549611782446973)
,p_name=>'P50_JA_NEIN_DEAKTIV'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>'deaktive "Ja-Nein"-Liste'
,p_display_as=>'NATIVE_YES_NO'
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618550001517446973)
,p_name=>'P50_KONTROLLE'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>unistr('aktive Kontrollk\00E4stchen')
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_ELEMENTS_CONTROL'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(618550482653446973)
,p_name=>'P50_KONTROLLE_DEAKTIV'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(44412026379437991107)
,p_prompt=>unistr('deaktive Kontrollk\00E4stchen')
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_ELEMENTS_CONTROL'
,p_tag_css_classes=>'ek-deaktiv'
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(800444911164812461)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'3'
);
end;
/
prompt --application/pages/page_00099
begin
wwv_flow_api.create_page(
 p_id=>99
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Unit Test Testseite'
,p_alias=>'UNITTEST'
,p_step_title=>'Unit Test Testseite'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(800472128340812513)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220712124434'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(908062854659086599)
,p_plug_name=>'Mitarbeiter bearbeiten'
,p_region_name=>'R99_UNITTEST_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
 p_id=>wwv_flow_api.id(908078974181087738)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(828270828705382481)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(908078974181087738)
,p_button_name=>'CANCEL'
,p_button_static_id=>'B99_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(828271204143382483)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(908078974181087738)
,p_button_name=>'DELETE'
,p_button_static_id=>'B99_DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(828271595834382483)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(908078974181087738)
,p_button_name=>'SAVE'
,p_button_static_id=>'B99_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(828272051110382483)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(908078974181087738)
,p_button_name=>'CREATE'
,p_button_static_id=>'B99_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P99_EMPLOYEE_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828262711971381388)
,p_name=>'P99_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Employee Id'
,p_source=>'EMPLOYEE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828263125050381391)
,p_name=>'P99_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'First Name'
,p_source=>'FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828263536632381391)
,p_name=>'P99_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Last Name'
,p_source=>'LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828263943900381391)
,p_name=>'P99_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Email'
,p_source=>'EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>25
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828264268513381391)
,p_name=>'P99_PHONE_NUMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Phone Number'
,p_source=>'PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828264705897381392)
,p_name=>'P99_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Hire Date'
,p_source=>'HIRE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828265139958381392)
,p_name=>'P99_JOB_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Job Id'
,p_source=>'JOB_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828265504981381392)
,p_name=>'P99_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Salary'
,p_source=>'SALARY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_css_classes=>'sadc-mandatory'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828265935824381392)
,p_name=>'P99_COMMISSION_PCT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Commission Pct'
,p_source=>'COMMISSION_PCT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828266318026381392)
,p_name=>'P99_MANAGER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Manager Id'
,p_source=>'MANAGER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(828266752958381392)
,p_name=>'P99_DEPARTMENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(908062854659086599)
,p_item_source_plug_id=>wwv_flow_api.id(908062854659086599)
,p_prompt=>'Department Id'
,p_source=>'DEPARTMENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(800445102736812461)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Anwendungstexte verwalten'
,p_alias=>'ADPTI'
,p_step_title=>'Anwendungstexte verwalten'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(800472128340812513)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210508103803'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800495276250021342)
,p_plug_name=>'Anwendungstexte'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(800383684570812430)
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
 p_id=>wwv_flow_api.id(800495746193021342)
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
 p_id=>wwv_flow_api.id(800495847289021344)
,p_db_column_name=>'PTI_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(800496090516021347)
,p_db_column_name=>'PTI_PMG_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Pti Pmg Name'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(800496475483021347)
,p_db_column_name=>'PTI_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(800496882979021347)
,p_db_column_name=>'PTI_DISPLAY_NAME'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Bezeichner'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(800497287090021349)
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
 p_id=>wwv_flow_api.id(800524910596439184)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'739002'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PTI_ID:PTI_PMG_NAME:PTI_NAME:PTI_DISPLAY_NAME:PTI_DESCRIPTION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800499444634021352)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(800495276250021342)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anwendungstext erstellen'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:101:&SESSION.::&DEBUG.:101'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(800498418532021352)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(800495276250021342)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(800498898183021352)
,p_event_id=>wwv_flow_api.id(800498418532021352)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(800495276250021342)
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Anwendungstext bearbeiten'
,p_alias=>'EDPTI'
,p_page_mode=>'MODAL'
,p_step_title=>'Anwendungstext bearbeiten'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(800472128340812513)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20220706165034'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800486867017021299)
,p_plug_name=>'Anwendungstext bearbeiten'
,p_region_name=>'EDPTI_FORM'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
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
 p_id=>wwv_flow_api.id(800490664396021319)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800365712347812424)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800491102705021320)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(800490664396021319)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800492672119021324)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(800490664396021319)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800493145868021325)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(800490664396021319)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800493524866021325)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(800490664396021319)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P101_PTI_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800487191979021299)
,p_name=>'P101_PTI_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_source_plug_id=>wwv_flow_api.id(800486867017021299)
,p_prompt=>'ID'
,p_source=>'PTI_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P101_PTI_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800487602923021305)
,p_name=>'P101_PTI_PMG_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_source_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_default=>'SADC'
,p_source=>'PTI_PMG_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800488035341021311)
,p_name=>'P101_PTI_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_source_plug_id=>wwv_flow_api.id(800486867017021299)
,p_source=>'PTI_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800488396464021314)
,p_name=>'P101_PTI_DISPLAY_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_source_plug_id=>wwv_flow_api.id(800486867017021299)
,p_source=>'PTI_DISPLAY_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800488791911021319)
,p_name=>'P101_PTI_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(800486867017021299)
,p_item_source_plug_id=>wwv_flow_api.id(800486867017021299)
,p_prompt=>'Beschreibung'
,p_source=>'PTI_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cSize=>60
,p_cMaxlength=>32767
,p_cHeight=>15
,p_tag_attributes=>'style="height:480px;"'
,p_field_template=>wwv_flow_api.id(800445102736812461)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_02=>'Full'
,p_attribute_07=>'480'
,p_attribute_09=>'html'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(799844375599981243)
,p_validation_name=>'Validate EDPTI'
,p_validation_sequence=>10
,p_validation=>'return sadc_ui.validate_edpti;'
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Foo'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(800491182130021320)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(800491102705021320)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(800491988563021322)
,p_event_id=>wwv_flow_api.id(800491182130021320)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(800494266739021325)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(800486867017021299)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process ADPTI'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'sadc_ui.process_edpti;'
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(800494666523021325)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(800493894995021325)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(800486867017021299)
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
,p_user_interface_id=>wwv_flow_api.id(800468936563812491)
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'ADC Sample Application - Sign In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(800342242346812409)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'ADC_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210513142901'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800473057538812524)
,p_plug_name=>'ADC Sample Application'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800382437173812430)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(800477701218812534)
,p_plug_name=>'Language Selector'
,p_parent_plug_id=>wwv_flow_api.id(800473057538812524)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(800355301558812419)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>'apex_lang.emit_language_selector_list;'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(800475787394812530)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(800473057538812524)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(800446202938812463)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800473453934812525)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(800473057538812524)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(800444843960812459)
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
 p_id=>wwv_flow_api.id(800473796200812525)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(800473057538812524)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(800444843960812459)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(800474927132812528)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(800473057538812524)
,p_prompt=>'Remember username'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOGIN_REMEMBER_USERNAME'
,p_lov=>'.'||wwv_flow_api.id(800474118459812525)||'.'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_api.id(800444843960812459)
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
 p_id=>wwv_flow_api.id(800476648331812531)
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
 p_id=>wwv_flow_api.id(800476251098812531)
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
 p_id=>wwv_flow_api.id(800477382030812531)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(800476964502812531)
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
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(498886983433311012)
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_home
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983404956769)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_home'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 1'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 1);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(962),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 1,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(964),',
'    p_cru_crg_id => adc_admin.map_id(962),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(962));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_useadc
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983404964481)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_useadc'
,p_sequence=>20
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 2'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 2);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(966),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 2,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(968),',
'    p_cru_crg_id => adc_admin.map_id(966),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(966));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adadc
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983404972225)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adadc'
,p_sequence=>30
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 3'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 3);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(970),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 3,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(972),',
'    p_cru_crg_id => adc_admin.map_id(970),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(970));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adanf
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983404980001)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adanf'
,p_sequence=>40
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 4'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 4);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(974),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 4,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(976),',
'    p_cru_crg_id => adc_admin.map_id(974),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(978),',
'    p_cra_cru_id => adc_admin.map_id(976),',
'    p_cra_crg_id => adc_admin.map_id(974),',
'    p_cra_cpi_id => ''P4_DATE'',',
'    p_cra_cat_id => ''SET_VISUAL_STATE'',',
'    p_cra_param_1 => q''|SHOW_DISABLE|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 20,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(980),',
'    p_cra_cru_id => adc_admin.map_id(976),',
'    p_cra_crg_id => adc_admin.map_id(974),',
'    p_cra_cpi_id => ''P4_REQUIRED'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(974));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adval
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983404995649)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adval'
,p_sequence=>50
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 5'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 5);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(982),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 5,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(984),',
'    p_cru_crg_id => adc_admin.map_id(982),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(986),',
'    p_cra_cru_id => adc_admin.map_id(984),',
'    p_cra_crg_id => adc_admin.map_id(982),',
'    p_cra_cpi_id => ''P5_REQUIRED'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(988),',
'    p_cru_crg_id => adc_admin.map_id(982),',
'    p_cru_name => ''ein Datum in der Vergangenheit eingibt'',',
'    p_cru_condition => q''|P5_DATE < sysdate|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(990),',
'    p_cra_cru_id => adc_admin.map_id(988),',
'    p_cra_crg_id => adc_admin.map_id(982),',
'    p_cra_cpi_id => ''P5_DATE'',',
'    p_cra_cat_id => ''SHOW_ERROR'',',
'    p_cra_param_1 => q''|Das Datum muss in der Zukunft liegen.|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(992),',
'    p_cru_crg_id => adc_admin.map_id(982),',
'    p_cru_name => ''eine nicht erlaubte Zahl eingibt'',',
'    p_cru_condition => q''|P5_NUMBER not between 100 and 1000|'',',
'    p_cru_sort_seq => 30,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(994),',
'    p_cra_cru_id => adc_admin.map_id(992),',
'    p_cra_crg_id => adc_admin.map_id(982),',
'    p_cra_cpi_id => ''P5_NUMBER'',',
'    p_cra_cat_id => ''SHOW_ERROR'',',
'    p_cra_param_1 => q''|Die Zahl muss zwischen 100 und 1000 liegen.|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(982));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adval2
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405023341)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adval2'
,p_sequence=>60
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 6'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 6);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(996),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 6,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(998),',
'    p_cru_crg_id => adc_admin.map_id(996),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1000),',
'    p_cra_cru_id => adc_admin.map_id(998),',
'    p_cra_crg_id => adc_admin.map_id(996),',
'    p_cra_cpi_id => ''P6_REQUIRED'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1002),',
'    p_cru_crg_id => adc_admin.map_id(996),',
'    p_cru_name => ''eine Zahl eingibt'',',
'    p_cru_condition => q''|P6_NUMBER is not null|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1004),',
'    p_cra_cru_id => adc_admin.map_id(1002),',
'    p_cra_crg_id => adc_admin.map_id(996),',
'    p_cra_cpi_id => ''P6_NUMBER'',',
'    p_cra_cat_id => ''PLSQL_CODE'',',
'    p_cra_param_1 => q''|sadc_ui.validate_p6_number|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1006),',
'    p_cru_crg_id => adc_admin.map_id(996),',
'    p_cru_name => ''ein Datum eingibt'',',
'    p_cru_condition => q''|P6_DATE is not null|'',',
'    p_cru_sort_seq => 30,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1008),',
'    p_cra_cru_id => adc_admin.map_id(1006),',
'    p_cra_crg_id => adc_admin.map_id(996),',
'    p_cra_cpi_id => ''P6_DATE'',',
'    p_cra_cat_id => ''PLSQL_CODE'',',
'    p_cra_param_1 => q''|sadc_ui.validate_p6_date;|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(996));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adsta
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405051425)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adsta'
,p_sequence=>70
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 7'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 7);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1010),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 7,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1012),',
'    p_cru_crg_id => adc_admin.map_id(1010),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1014),',
'    p_cra_cru_id => adc_admin.map_id(1012),',
'    p_cra_crg_id => adc_admin.map_id(1010),',
'    p_cra_cpi_id => ''DOCUMENT'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''|.sadc-mandatory|'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1016),',
'    p_cra_cru_id => adc_admin.map_id(1012),',
'    p_cra_crg_id => adc_admin.map_id(1010),',
'    p_cra_cpi_id => ''P7_EMP_JOB_ID'',',
'    p_cra_cat_id => ''RAISE_ITEM_EVENT'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 20,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1018),',
'    p_cru_crg_id => adc_admin.map_id(1010),',
unistr('    p_cru_name => ''einen Beruf mit Bonusberechtigung w\00E4hlt'','),
'    p_cru_condition => q''|sadc_ui.is_comm_eligible(P7_EMP_JOB_ID) = C_TRUE|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1020),',
'    p_cra_cru_id => adc_admin.map_id(1018),',
'    p_cra_crg_id => adc_admin.map_id(1010),',
'    p_cra_cpi_id => ''P7_EMP_COMMISSION_PCT'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1022),',
'    p_cru_crg_id => adc_admin.map_id(1010),',
unistr('    p_cru_name => ''einen Beruf ohne Bonusberechtigung w\00E4hlt'','),
'    p_cru_condition => q''|sadc_ui.is_comm_eligible(P7_EMP_JOB_ID) = C_FALSE|'',',
'    p_cru_sort_seq => 30,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1024),',
'    p_cra_cru_id => adc_admin.map_id(1022),',
'    p_cra_crg_id => adc_admin.map_id(1010),',
'    p_cra_cpi_id => ''P7_EMP_COMMISSION_PCT'',',
'    p_cra_cat_id => ''IS_OPTIONAL'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1026),',
'    p_cra_cru_id => adc_admin.map_id(1022),',
'    p_cra_crg_id => adc_admin.map_id(1010),',
'    p_cra_cpi_id => ''P7_EMP_COMMISSION_PCT'',',
'    p_cra_cat_id => ''SET_VISUAL_STATE'',',
'    p_cra_param_1 => q''|SHOW_DISABLE|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 20,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1010));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adact
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405088109)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adact'
,p_sequence=>80
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 8'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 8);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1028),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 8,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1030),',
'    p_cru_crg_id => adc_admin.map_id(1028),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1032),',
'    p_cra_cru_id => adc_admin.map_id(1030),',
'    p_cra_crg_id => adc_admin.map_id(1028),',
'    p_cra_cpi_id => ''R8_EMPLOYEES'',',
'    p_cra_cat_id => ''GET_REPORT_SELECTION'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1034),',
'    p_cru_crg_id => adc_admin.map_id(1028),',
unistr('    p_cru_name => ''einen Mitarbeiter ausw\00E4hlt'','),
'    p_cru_condition => q''|selection_changed = ''R8_EMPLOYEES''|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1036),',
'    p_cra_cru_id => adc_admin.map_id(1034),',
'    p_cra_crg_id => adc_admin.map_id(1028),',
'    p_cra_cpi_id => ''B8_EDIT_EMP'',',
'    p_cra_cat_id => ''PLSQL_CODE'',',
'    p_cra_param_1 => q''|sadc_ui.adact_control_action;|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_apex_action(    ',
'    p_caa_id => adc_admin.map_id(1038),',
'    p_caa_crg_id => adc_admin.map_id(1028),',
'    p_caa_caat_id => ''ACTION'',',
'    p_caa_name => ''edit-employee'',',
'    p_caa_label => ''Mitarbeiter bearbeiten'',',
'    p_caa_confirm_message_name => '''',',
'    p_caa_context_label => '''',',
'    p_caa_icon => '''',',
'    p_caa_icon_type => '''',',
'    p_caa_title => '''',',
'    p_caa_shortcut => '''',',
'    p_caa_initially_disabled => adc_util.C_FALSE,',
'    p_caa_initially_hidden => adc_util.C_FALSE,',
'    p_caa_href => '''',',
'    p_caa_action => '''');',
'  ',
'  adc_admin.merge_apex_action_item(',
'    p_caai_caa_id => adc_admin.map_id(1038),',
'    p_caai_cpi_crg_id => adc_admin.map_id(1028),',
'    p_caai_cpi_id => ''B8_EDIT_EMP'',',
'    p_caai_active => adc_util.C_TRUE);',
'',
'',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1028));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_edemp
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405112925)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_edemp'
,p_sequence=>90
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 9'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 9);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1040),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 9,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1042),',
'    p_cru_crg_id => adc_admin.map_id(1040),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1040));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_adrep
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405121261)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_adrep'
,p_sequence=>100
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 10'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 10);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1044),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 10,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1046),',
'    p_cru_crg_id => adc_admin.map_id(1044),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1048),',
'    p_cra_cru_id => adc_admin.map_id(1046),',
'    p_cra_crg_id => adc_admin.map_id(1044),',
'    p_cra_cpi_id => ''R10_EMPLOYEES_IG'',',
'    p_cra_cat_id => ''GET_REPORT_SELECTION'',',
'    p_cra_param_1 => q''|P10_EMP_ID_IG|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1050),',
'    p_cra_cru_id => adc_admin.map_id(1046),',
'    p_cra_crg_id => adc_admin.map_id(1044),',
'    p_cra_cpi_id => ''R10_EMPLOYEE_IR'',',
'    p_cra_cat_id => ''GET_REPORT_SELECTION'',',
'    p_cra_param_1 => q''|P10_EMP_ID_IR|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 20,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1052),',
'    p_cra_cru_id => adc_admin.map_id(1046),',
'    p_cra_crg_id => adc_admin.map_id(1044),',
'    p_cra_cpi_id => ''R10_EMPLOYEE_CR'',',
'    p_cra_cat_id => ''GET_REPORT_SELECTION'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''|1|'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 30,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1054),',
'    p_cru_crg_id => adc_admin.map_id(1044),',
unistr('    p_cru_name => ''eine Zeile im klassischen Bericht w\00E4hlt'','),
'    p_cru_condition => q''|selection_changed = ''R10_EMPLOYEE_CR''|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1056),',
'    p_cra_cru_id => adc_admin.map_id(1054),',
'    p_cra_crg_id => adc_admin.map_id(1044),',
'    p_cra_cpi_id => ''DOCUMENT'',',
'    p_cra_cat_id => ''NOTIFY'',',
'    p_cra_param_1 => q''|p_event_data|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1044));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_pseudo
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405150689)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_pseudo'
,p_sequence=>110
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 11'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 11);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1058),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 11,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1060),',
'    p_cru_crg_id => adc_admin.map_id(1058),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1058));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_tutorial
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405159169)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_tutorial'
,p_sequence=>120
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 12'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 12);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1062),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 12,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1064),',
'    p_cru_crg_id => adc_admin.map_id(1062),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1062));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_doc
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405167681)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_doc'
,p_sequence=>130
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 13'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 13);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1066),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 13,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1068),',
'    p_cru_crg_id => adc_admin.map_id(1066),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1066));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_menu_cat
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405176225)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_menu_cat'
,p_sequence=>140
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 14'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 14);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1070),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 14,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1072),',
'    p_cru_crg_id => adc_admin.map_id(1070),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1070));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_cat_page_item
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405184801)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_cat_page_item'
,p_sequence=>150
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 15'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 15);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1074),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 15,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1076),',
'    p_cru_crg_id => adc_admin.map_id(1074),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1074));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_extended_initialization
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405193409)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_extended_initialization'
,p_sequence=>160
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 16'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 16);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1078),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 16,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1080),',
'    p_cru_crg_id => adc_admin.map_id(1078),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1082),',
'    p_cra_cru_id => adc_admin.map_id(1080),',
'    p_cra_crg_id => adc_admin.map_id(1078),',
'    p_cra_cpi_id => ''DOCUMENT'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''|.adc-mandatory|'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1084),',
'    p_cru_crg_id => adc_admin.map_id(1078),',
unistr('    p_cru_name => ''eine Seite im Modus COMMISSION \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true and P16_PAGE_MODE = ''COMMISSION''|'',',
'    p_cru_sort_seq => 20,',
'    p_cru_fire_on_page_load => adc_util.C_TRUE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1086),',
'    p_cra_cru_id => adc_admin.map_id(1084),',
'    p_cra_crg_id => adc_admin.map_id(1078),',
'    p_cra_cpi_id => ''P16_EMP_COMMISSION_PCT'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1088),',
'    p_cru_crg_id => adc_admin.map_id(1078),',
unistr('    p_cru_name => ''die Seite in einem anderen Modus \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true and coalesce(P16_PAGE_MODE, ''FOO'') != ''COMMISSION''|'',',
'    p_cru_sort_seq => 30,',
'    p_cru_fire_on_page_load => adc_util.C_TRUE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1090),',
'    p_cra_cru_id => adc_admin.map_id(1088),',
'    p_cra_crg_id => adc_admin.map_id(1078),',
'    p_cra_cpi_id => ''P16_EMP_COMMISSION_PCT'',',
'    p_cra_cat_id => ''SET_VISUAL_STATE'',',
'    p_cra_param_1 => q''|HIDE|'',',
'    p_cra_param_2 => q''||'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1078));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/install/install_merge_rule_group_unittest
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(498886983405223789)
,p_install_id=>wwv_flow_api.id(498886983433311012)
,p_name=>'merge_rule_group_unittest'
,p_sequence=>170
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'  l_foo number;',
'  l_app_id number;',
'begin',
'  l_foo := adc_admin.map_id;',
'  l_app_id := apex_application_install.get_application_id;',
'',
'  dbms_output.put_line(''Rulegroup page 99'');',
'',
'  adc_admin.prepare_rule_group_import(',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 99);',
'',
'  adc_admin.merge_rule_group(',
'    p_crg_id => adc_admin.map_id(1092),',
'    p_crg_app_id => l_app_id,',
'    p_crg_page_id => 99,',
'    p_crg_with_recursion => adc_util.C_TRUE,',
'    p_crg_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule(',
'    p_cru_id => adc_admin.map_id(1094),',
'    p_cru_crg_id => adc_admin.map_id(1092),',
unistr('    p_cru_name => ''die Seite \00F6ffnet'','),
'    p_cru_condition => q''|initializing = c_true|'',',
'    p_cru_sort_seq => 10,',
'    p_cru_fire_on_page_load => adc_util.C_FALSE,',
'    p_cru_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.merge_rule_action(',
'    p_cra_id => adc_admin.map_id(1096),',
'    p_cra_cru_id => adc_admin.map_id(1094),',
'    p_cra_crg_id => adc_admin.map_id(1092),',
'    p_cra_cpi_id => ''DOCUMENT'',',
'    p_cra_cat_id => ''IS_MANDATORY'',',
'    p_cra_param_1 => q''||'',',
'    p_cra_param_2 => q''|.sadc-mandatory|'',',
'    p_cra_param_3 => q''||'',',
'    p_cra_sort_seq => 10,',
'    p_cra_on_error => adc_util.C_FALSE,',
'    p_cra_raise_recursive => adc_util.C_TRUE,',
'    p_cra_active => adc_util.C_TRUE);',
'  ',
'  adc_admin.propagate_rule_change(adc_admin.map_id(1092));',
'',
'  commit;',
'end;',
'/',
'',
''))
);
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
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
