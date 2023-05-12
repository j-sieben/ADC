@&tool_dir.set_folder apex

prompt &h2.Create database objects

prompt &h3.Create tables
@&tool_dir.create_table adca_lu_designer_modes
@&tool_dir.create_table adca_lu_designer_actions
@&tool_dir.create_table adca_map_designer_actions

prompt &h3.Create views
@&tool_dir.create_view adca_bl_cat_help
@&tool_dir.create_view adca_ui_designer_rule_action
@&tool_dir.create_view adca_bl_designer_actions
@&tool_dir.create_view adca_bl_cat_parameter_items
@&tool_dir.create_view adca_ui_lov_action_item_focus
@&tool_dir.create_view adca_ui_lov_action_param_type
@&tool_dir.create_view adca_ui_lov_action_param_visual_type
@&tool_dir.create_view adca_ui_lov_action_type_group
@&tool_dir.create_view adca_ui_lov_action_type_owner
@&tool_dir.create_view adca_ui_lov_adc_action_types
@&tool_dir.create_view adca_ui_lov_apex_action_items
@&tool_dir.create_view adca_ui_lov_apex_action_type
@&tool_dir.create_view adca_ui_lov_apex_action
@&tool_dir.create_view adca_ui_lov_applications
@&tool_dir.create_view adca_ui_lov_app_pages
@&tool_dir.create_view adca_ui_lov_crg_applications
@&tool_dir.create_view adca_ui_lov_crg_app_pages
@&tool_dir.create_view adca_ui_lov_crg_page_items
@&tool_dir.create_view adca_ui_lov_export_cat
@&tool_dir.create_view adca_ui_lov_export_types
@&tool_dir.create_view adca_ui_lov_item_types
@&tool_dir.create_view adca_ui_lov_page_item_type
@&tool_dir.create_view adca_ui_lov_page_item_type_group
@&tool_dir.create_view adca_ui_lov_page_items_p11
@&tool_dir.create_view adca_ui_lov_page_items
@&tool_dir.create_view adca_ui_lov_yes_no
@&tool_dir.create_view adca_ui_admin_cat
@&tool_dir.create_view adca_ui_admin_caif
@&tool_dir.create_view adca_ui_admin_capt
@&tool_dir.create_view adca_ui_designer_apex_action
@&tool_dir.create_view adca_ui_designer_findings
@&tool_dir.create_view adca_ui_designer_rule_action
@&tool_dir.create_view adca_ui_designer_rule_group
@&tool_dir.create_view adca_ui_designer_rule
@&tool_dir.create_view adca_ui_designer_rules
@&tool_dir.create_view adca_ui_designer_tree
@&tool_dir.create_view adca_ui_edit_cat
@&tool_dir.create_view adca_ui_edit_caif
@&tool_dir.create_view adca_ui_edit_cpit
@&tool_dir.create_view adca_ui_edit_catg
@&tool_dir.create_view adca_ui_edit_cato
@&tool_dir.create_view adca_ui_edit_capt
@&tool_dir.create_view adca_ui_edit_capt_static_list
@&tool_dir.create_view adca_ui_edit_csm
@&tool_dir.create_view adca_ui_list_action_type

prompt &h3.Create ADCA messages
@&msg_dir.MessageGroup_ADCA.sql

prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_ADCA.sql

prompt &h2.Create PL/SQL objects
prompt &h3.Create packages
@&tool_dir.create_package adca_ui
@&tool_dir.create_package adca_ui_designer
@&tool_dir.create_package splitter_plugin

prompt &h3.Create package bodies
@&tool_dir.create_package_body adca_ui
@&tool_dir.create_package_body adca_ui_designer
@&tool_dir.create_package_body splitter_plugin

prompt &h2.Scripts
@&tool_dir.run_script adca_lu_designer_modes
@&tool_dir.run_script adca_lu_designer_actions
@&tool_dir.run_script adca_map_designer_actions
--@&tool_dir.run_script splitter_plugin

define script_dir=apex/apex_20_2/scripts/

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql

-- Install Flows extension if necessary
@&tool_dir.check_flows_exists flows_extension/install.sql
