define seq_dir=&core_dir.sequences/
define table_dir=&core_dir.tables/
define type_dir=&core_dir.types/
define view_dir=&core_dir.views/
define pkg_dir=&core_dir.packages/
define script_dir=&core_dir.scripts/
define msg_dir=&core_dir.messages/&DEFAULT_LANGUAGE./
define apex_version=&core_dir.&apex_path./

prompt &h2.Check installation prerequisites
@&core_dir.check_prerequisites.sql

prompt &h2.Remove existing installation
@&core_dir.clean_up_install.sql

prompt &h2.Checking whether utPLSQL is installed in usable version
@&tool_dir.check_unit_test_exists.sql "null.sql" "preparation"

prompt &h2.Create database objects
prompt &h3.Create sequences
prompt &s1.Create sequence ADC_SEQ
@&seq_dir.adc_seq.seq

prompt &h3.Create tables
prompt &s1.Create table ADC_RULE_GROUPS
@&table_dir.adc_rule_groups.tbl

prompt &s1.Create table ADC_ACTION_TYPE_GROUPS
@&table_dir.adc_action_type_groups.tbl

prompt &s1.Create table ADC_ACTION_ITEM_FOCUS
@&table_dir.adc_action_item_focus.tbl

prompt &s1.Create table ADC_ACTION_TYPES
@&table_dir.adc_action_types.tbl

prompt &s1.Create table ADC_ACTION_PARAM_TYPES
@&table_dir.adc_action_param_types.tbl

prompt &s1.Create table ADC_APEX_ACTION_TYPES
@&table_dir.adc_apex_action_types.tbl

prompt &s1.Create table ADC_PAGE_ITEM_TYPES
@&table_dir.adc_page_item_types.tbl

prompt &s1.Create table ADC_ACTION_PARAMETERS
@&table_dir.adc_action_parameters.tbl

prompt &s1.Create table ADC_PAGE_ITEMS
@&table_dir.adc_page_items.tbl

prompt &s1.Create table ADC_APEX_ACTIONS
@&table_dir.adc_apex_actions.tbl

prompt &s1.Create table ADC_APEX_ACTION_ITEMS
@&table_dir.adc_apex_action_items.tbl

prompt &s1.Create table ADC_RULES
@&table_dir.adc_rules.tbl

prompt &s1.Create table ADC_RULE_ACTIONS
@&table_dir.adc_rule_actions.tbl


prompt &h2.Predefine package ADC_UTIL for reference from views
prompt &s1.Create package ADC_UTIL
@&pkg_dir.adc_util.pks
show errors

prompt &h3.Create views
prompt &s1.Create view ADC_ACTION_ITEM_FOCUS_V
@&view_dir.adc_action_item_focus_v.vw

prompt &s1.Create view ADC_ACTION_PARAM_TYPES_V
@&view_dir.adc_action_param_types_v.vw

prompt &s1.Create view ADC_ACTION_PARAMETERS_V
@&view_dir.adc_action_parameters_v.vw

prompt &s1.Create view ADC_ACTION_TYPES_V
@&view_dir.adc_action_types_v.vw

prompt &s1.Create view ADC_ACTION_TYPE_GROUPS_V
@&view_dir.adc_action_type_groups_v.vw

prompt &s1.Create view ADC_APEX_ACTION_TYPES_V
@&view_dir.adc_apex_action_types_v.vw

prompt &s1.Create view ADC_APEX_ACTIONS_V
@&view_dir.adc_apex_actions_v.vw

prompt &s1.Create view ADC_PAGE_ITEM_TYPES_V
@&view_dir.adc_page_item_types_v.vw

prompt &s1.Create view ADC_BL_PAGE_ITEMS
@&view_dir.adc_bl_page_items.vw

prompt &s1.Create view ADC_BL_PAGE_TARGETS
@&view_dir.adc_bl_page_targets.vw

prompt &s1.Create view ADC_BL_RULES
@&view_dir.adc_bl_rules.vw

prompt &s1.Create view ADC_BL_PAGE_TARGETS
@&view_dir.adc_bl_page_targets.vw

prompt &s1.Create view ADC_BL_CAT_HELP
@&view_dir.adc_bl_cat_help.vw

prompt &s1.Create view ADC_PARAM_LOV_APEX_ACTION
@&view_dir.adc_param_lov_apex_action.vw

prompt &s1.Create view ADC_PARAM_LOV_PAGE_ITEM
@&view_dir.adc_param_lov_page_item.vw

prompt &s1.Create view ADC_PARAM_LOV_PIT_MESSAGE
@&view_dir.adc_param_lov_pit_message.vw

prompt &s1.Create view ADC_PARAM_LOV_SEQUENCE
@&view_dir.adc_param_lov_sequence.vw

prompt &s1.Create view ADC_RULE_GROUP_STATUS
@&view_dir.adc_rule_group_status.vw


prompt &h2.Merge default data
prompt &h3.Create ADC parameters
@&script_dir.ParameterGroup_ADC.sql

prompt &h3.Create ADC messages
@&msg_dir.MessageGroup_ADC.sql

prompt &h3.Create generic ORACLE messages
@&msg_dir.MessageGroup_ORACLE.sql

prompt &h3.Create ADC translatable items
@&msg_dir.TranslatableItemGroup_ADC.sql

prompt &h3.Create UTL_TEXT templates
@&script_dir.merge_utl_text_templates.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package ADC_VALIDATION
@&pkg_dir.adc_validation.pks
show errors

prompt &s1.Create package ADC_ADMIN
@&pkg_dir.adc_admin.pks
show errors

prompt &s1.Create package Body ADC_UTIL
@&pkg_dir.adc_util.pkb
show errors

prompt &s1.Create package ADC_INTERNAL
@&pkg_dir.adc_internal.pks
show errors

prompt &s1.Create package ADC_RECURSION_STACK
@&pkg_dir.adc_recursion_stack.pks
show errors

prompt &s1.Create package ADC_PAGE_STATE
@&pkg_dir.adc_page_state.pks
show errors

prompt &s1.Create package ADC
@&pkg_dir.adc.pks
show errors

prompt &s1.Create package ADC_API
@&pkg_dir.adc_api.pks
show errors

prompt &s1.Create package ADC_APEX_ACTION
@&pkg_dir.adc_apex_action.pks
show errors

prompt &h3.Create package bodies
prompt &s1.Create package Body ADC_ADMIN
@&pkg_dir.adc_admin.pkb
show errors

prompt &s1.Create package Body ADC_INTERNAL
@&pkg_dir.adc_internal.pkb
show errors

prompt &s1.Create package Body ADC_RECURSION_STACK
@&pkg_dir.adc_recursion_stack.pkb
show errors

prompt &s1.Create package Body ADC_PAGE_STATE
@&pkg_dir.adc_page_state.pkb
show errors

prompt &s1.Create package Body ADC_API
@&pkg_dir.adc_api.pkb
show errors

prompt &s1.Create package Body ADC
@&pkg_dir.adc.pkb
show errors

prompt &s1.Create package Body ADC_VALIDATION
@&pkg_dir.adc_validation.pkb
show errors

prompt &s1.Create package Body ADC_APEX_ACTION
@&pkg_dir.adc_apex_action.pkb
show errors

@tools/check_unit_test_exists &pkg_dir.adc_ut.pks
@tools/check_unit_test_exists &pkg_dir.adc_ut.pkb

prompt &h2.Create parameters
prompt &s1.Create ADC parameters
@&script_dir.ParameterGroup_ADC.sql

prompt &h2.Merge initial data
prompt &s1.Create ADC Action types
@&script_dir.action_types_system.sql

-- Additional installation for pecific APEX versions
prompt &h2.Installation for specific APEX versions
@&apex_version.install.sql