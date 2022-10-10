@&tool_dir.set_folder sample_app
@&tool_dir.init.sql

prompt &h1.Create Sample Tables and Data
@&script_dir.install_hr.sql

prompt &h2.Create database objects
prompt &h3.Create views
@&tool_dir.create_view sadc_lov_department
@&tool_dir.create_view sadc_lov_job
@&tool_dir.create_view sadc_ui_adact
@&tool_dir.create_view sadc_ui_adpti
@&tool_dir.create_view sadc_ui_adrep
@&tool_dir.create_view sadc_ui_adsta
@&tool_dir.create_view sadc_ui_doc
@&tool_dir.create_view sadc_ui_edemp
@&tool_dir.create_view sadc_ui_home
@&tool_dir.create_view sadc_ui_menu_cat
@&tool_dir.create_view sadc_ui_menu_cat_items
@&tool_dir.create_view sadc_ui_tutorial

prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_SADC.sql

prompt &h2.Create PL/SQL objects
prompt &h3.Create packages
@&tool_dir.create_package sadc_ui

prompt &h3.Create package bodies
@&tool_dir.create_package_body sadc_ui

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql