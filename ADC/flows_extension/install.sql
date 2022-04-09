@&tool_dir.set_folder flows_extension

prompt &h2.Remove existing installation
@&install_dir.uninstall.sql

prompt &h2.Create database objects

prompt &h2.Create Package dependent Views
@&tool_dir.create_view adc_ui_designer_tree