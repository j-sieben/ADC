@tools/set_folder core

prompt &h2.Create database objects
prompt &h3.Create sequences
@&tool_dir.create_sequence adc_seq


prompt &h3.Create tables
@&tool_dir.create_table adc_rule_groups
@&tool_dir.create_table adc_action_type_groups
@&tool_dir.create_table adc_action_type_owners
@&tool_dir.create_table adc_action_item_focus
@&tool_dir.create_table adc_action_types
@&tool_dir.create_table adc_action_param_visual_types
@&tool_dir.create_table adc_action_param_types
@&tool_dir.create_table adc_apex_action_types
@&tool_dir.create_table adc_page_item_type_groups
--muss vor adc_page_item_types installiert werden
@&tool_dir.create_table adc_event_types
@&tool_dir.create_table adc_page_item_types
@&tool_dir.create_table adc_action_parameters
@&tool_dir.create_table adc_page_items
@&tool_dir.create_table adc_apex_actions
@&tool_dir.create_table adc_apex_action_items
@&tool_dir.create_table adc_rules
@&tool_dir.create_table adc_rule_actions

-- Migrationsskripte
@&table_dir.alter_adc_page_items.sql
@&table_dir.alter_adc_action_types.sql

prompt &h2.Predefine package ADC_UTIL for reference from views
@&tool_dir.create_package adc_util

prompt &h3.Create views
@&tool_dir.create_view adc_rule_group_status
@&tool_dir.create_view adc_action_item_focus_v
@&tool_dir.create_view adc_action_param_types_v
@&tool_dir.create_view adc_action_param_visual_types_v
@&tool_dir.create_view adc_action_parameters_v
@&tool_dir.create_view adc_action_types_v
@&tool_dir.create_view adc_action_type_groups_v
@&tool_dir.create_view adc_action_type_owners_v
@&tool_dir.create_view adc_apex_action_types_v
@&tool_dir.create_view adc_apex_actions_v
@&tool_dir.create_view adc_page_item_types_v
@&tool_dir.create_view adc_event_types_v
@&tool_dir.create_view adc_standard_messages_v
@&tool_dir.create_view adc_bl_bind_items
@&tool_dir.create_view adc_bl_page_items
@&tool_dir.create_view adc_bl_page_targets
@&tool_dir.create_view adc_bl_page_targets

prompt &h3.Create parameter lov views
@&tool_dir.create_lov_view adc_param_lov_apex_action
@&tool_dir.create_lov_view adc_param_lov_event
@&tool_dir.create_lov_view adc_param_lov_free_page_items
@&tool_dir.create_lov_view adc_param_lov_input_fields
@&tool_dir.create_lov_view adc_param_lov_item_status
@&tool_dir.create_lov_view adc_param_lov_page_item
@&tool_dir.create_lov_view adc_param_lov_pit_message
@&tool_dir.create_lov_view adc_param_lov_sequence
@&tool_dir.create_lov_view adc_param_lov_string_on_parameter
@&tool_dir.create_lov_view adc_param_lov_submit_type

@&tool_dir.recompile.sql

prompt &h2.Merge default data
prompt &h3.Create ADC parameters
@&tool_dir.run_script ParameterGroup_ADC

prompt &h3.Create ADC messages from &msg_dir.
@&msg_dir.MessageGroup_ADC.sql

prompt &h3.Create generic ORACLE messages
--@&msg_dir.MessageGroup_ORA.sql

prompt &h3.Create ADC translatable items
@&msg_dir.TranslatableItemGroup_ADC.sql

prompt &h3.Create UTL_TEXT templates
@&tool_dir.run_script utl_text_templates_ADC


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages
@&tool_dir.create_package adc_admin
@&tool_dir.create_package adc_apex_action
@&tool_dir.create_package adc_api
@&tool_dir.create_package adc_internal
@&tool_dir.create_package adc_page_state
@&tool_dir.create_package adc_recursion_stack
@&tool_dir.create_package adc_response
@&tool_dir.create_package adc_util
@&tool_dir.create_package adc_parameter

prompt &h3.Access types
@&tool_dir.create_type adc_basic
@&tool_dir.check_type_exists adc

prompt &h3.Create package bodies
@&tool_dir.create_package_body adc_admin
@&tool_dir.create_package_body adc_apex_action
@&tool_dir.create_package_body adc_api
@&tool_dir.create_package_body adc_internal
@&tool_dir.create_package_body adc_page_state
@&tool_dir.create_package_body adc_recursion_stack
@&tool_dir.create_package_body adc_response
@&tool_dir.create_package_body adc_util
@&tool_dir.create_package_body adc_parameter

prompt &h3.Access type bodies
@&tool_dir.create_type_body adc_basic

prompt &h2.Create parameters
prompt &s1.Create ADC parameters
@&tool_dir.run_script ParameterGroup_ADC

prompt &h2.Merge initial data
@&tool_dir.run_script action_types_system

-- Additional installation for pecific APEX versions
prompt &h2.Installation for specific APEX versions
@&apex_version_dir.install.sql

prompt &h1.Finished ADC Core Installation
