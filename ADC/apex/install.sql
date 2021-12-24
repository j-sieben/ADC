@tools/set_folder apex

prompt &h2.Remove existing installation
@&install_dir.uninstall.sql

prompt &h2.Create database objects
prompt &h3.Create views
@&tool_dir.create_view adc_ui_lov_action_item_focus
@&tool_dir.create_view adc_ui_lov_action_param_type
@&tool_dir.create_view adc_ui_lov_action_type_group
@&tool_dir.create_view adc_ui_lov_apex_action_items
@&tool_dir.create_view adc_ui_lov_apex_action_type
@&tool_dir.create_view adc_ui_lov_apex_action
@&tool_dir.create_view adc_ui_lov_applications
@&tool_dir.create_view adc_ui_lov_app_pages
@&tool_dir.create_view adc_ui_lov_cgr_applications
@&tool_dir.create_view adc_ui_lov_cgr_app_pages
@&tool_dir.create_view adc_ui_lov_cgr_page_items
@&tool_dir.create_view adc_ui_lov_export_cat
@&tool_dir.create_view adc_ui_lov_export_types
@&tool_dir.create_view adc_ui_lov_page_item_type
@&tool_dir.create_view adc_ui_lov_page_items_p11
@&tool_dir.create_view adc_ui_lov_page_items
@&tool_dir.create_view adc_ui_lov_yes_no
@&tool_dir.create_view adc_ui_admin_cat
@&tool_dir.create_view adc_ui_admin_cif
@&tool_dir.create_view adc_ui_edit_cat
@&tool_dir.create_view adc_ui_edit_cif
@&tool_dir.create_view adc_ui_edit_ctg
@&tool_dir.create_view adc_ui_list_action_type


prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_ADC_UI.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages
@&tool_dir.create_package adc_ui
@&tool_dir.create_package splitter_plugin

prompt &h3.Create package bodies
@&tool_dir.create_package_body adc_ui
@&tool_dir.create_package_body splitter_plugin

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql
