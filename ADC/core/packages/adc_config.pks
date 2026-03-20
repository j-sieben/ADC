create or replace package adc_config
  authid definer
as

  /**
    Package: ADC_CONFIG
      API to administer ADC configuration and movement data.
   */

  C_ALL_GROUPS constant adc_util.ora_name_type := 'ALL_GROUPS';
  C_APEX_APP constant adc_util.ora_name_type := 'APEX_APP';
  C_APP_GROUPS constant adc_util.ora_name_type := 'APP_GROUPS';
  C_PAGE_GROUP constant adc_util.ora_name_type := 'PAGE_GROUP';

  -- Group: Helper Methods
  /**
    Function: map_id
      Method to map technical IDs upon import of rule groups.
      As it is not known beforhand which ID an entry in a table will get, this method maintains a mapping table
      that maps the original ID to the newly created IDs from a sequence.

      If the ID passed in is not found in the table, it returns the newly created ID.
      If the ID is found in the table, the method returns the mapped ID.
      Before an import of a rule group can take place, this method needs to be called with a NULL parameter to
      initialize a new mapping table.

    Parameter:
      p_id - Optional ID to map to a new ID. If NULL, the mapping list is initialized
   */
  function map_id(
    p_id in number default null)
    return number;

  /**
    Function: get_crg_id
      Getter for the actually relevant crg_id, is used in views to speed up
      processing

    Returns:
      CRG_ID that is actually worked on
   */
  function get_crg_id
    return adc_rule_groups.crg_id%type;

  -- Group: Rule Group Methods
  /**
    Procedure; merge_rule_group
      Administration of RULE GROUPS. Is used to create a rule group.

    Parameters:
      p_crg_app_id - APEX application id
      p_crg_page_id - APEX application page id
      p_crg_id - Optional technical ID of the rule group. Upon script based import this parameter is used as
                 a foreign key for rules in order to organize the relationship even if new IDs are created
     p_crg_with_recursion - Optional flag to indicate whehter this rule allows recursive calls
     p_crg_active - Optional flag to indicate, whether this rule group is actually used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_rule_group(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type,
    p_crg_id in adc_rule_groups.crg_id%type default null,
    p_crg_with_recursion in adc_rule_groups.crg_with_recursion%type default adc_util.C_TRUE,
    p_crg_active in adc_rule_groups.crg_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_rule_group
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);

  /**
    Procedure: delete_rule_group
      Is called from the ADC UI to remove a rule group

    Parameter:
      p_crg_id - Technical ID of the rule group to delete
   */
  procedure delete_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type);

  /**
    Procedure: delete_rule_group
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);

  /**
    Procedure: validate_rule_group
      Validates a rule group.

    Parameter:
      p_row - Row record
   */
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype);

  /**
    Procedure: toggle_rule_group
      Method to set the activity status of the rule group to its opposite state

    Parameter:
      p_crg_id - ID of the rule group to toggle
   */
  procedure toggle_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type);

  /**
    Function: validate_rule_group
      Method checks all rules of a rule group to find invalid rules. Is called before a rule group is exported.

    Parameter:
      p_crg_id - Rule group ID to check

    Returns:
      Returns an error message if any error has occurred
   */
  function validate_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2;

  /**
    Procedure: propagate_rule_change
      Method to propagate that a rule has changed.

      Is used to propagate any rule change after a rule has been edited.
      Method checks whether rule group is valid, maintains the internal page item mappings and
      recreates the rule group decision table of the rule group.

      The export script calls this method automatically after a rule group has been imported completely

    Parameter:
      p_crg_id - ID of the rule group that has changed
   */
  procedure propagate_rule_change(
    p_crg_id in adc_rule_groups.crg_id%type);

  /**
    Function: export_rule_group
      Method to export one rule group. If called, the respective rule group is exported as a CLOB instance.

    Parameters:
      p_crg_id  Rule group ID of the rule group that is to be exported
      p_mode - Optional information, needed to switch the frame template accordingly
      p_ionstall_id - Optional Installation ID of the supporting install scripts. Used internally

    Returns:
      Script to import a rule group, including all necessary information, excluding action type definitions
   */
  function export_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_mode in varchar2 default C_APP_GROUPS,
    p_install_id in number default null)
    return clob;

  /**
    Function: export_rule_groups
      Method to export one or many rule groups.

      Based on the parameters passed in this method will export one or more rule groups.

      - If no parameter is passed in, all existing rule groups are exported.
      - If only parameter P_CRG_APP_ID is passed in all rule groups of the respective APEX application are exported.
      - If parameters P_CRG_APP_ID and P_CRG_PAGE_ID is passed in only the rule group of the respecite APEX application page are exported.

    Parameters:
      p_crg_app_id - APEX application ID
      p_mode - Optional flag to indicate what to export. Options include:

                - C_ALL_GROUPS: Exports all rule groups of that workspace
                - C_APEX_APP: Exports apex application including all rule groups of that application
                - C_APP_GROUPS: Exports all rule groups of an APEX application
                - C_PAGE_GROUP: Exports rule group of a single APEX application page

    Returns:
      BLOB instance of all files, separated by rule group name as a ZIP file instance

    Errors:
      APP_ID_MISSING - if export mode is set to C_APP_GROUPS or C_PAGE_GROUPS and no application id was provided
      PAGE_ID_MISSING - if export mode is set to C_PAGE_GROUPS and no application page id was provided
      msg.ADC_UNKNOWN_EXPORT_MODE - if an export mode other than C_ALL_GROUPS, C_APP_GROUPS, C_PAGE_GROUPS was requested
   */
  function export_rule_groups(
    p_crg_app_id in adc_rule_groups.crg_app_id%type default null,
    p_mode in varchar2 default C_APP_GROUPS)
    return blob;

  /**
    Procedure: preoare_rule_group_import
      Method to prepare a rule group import.
      This method is called before a script based import of a rule group occurs to make sur that the actual
      application ID of the referenced application is used. This ID is taken using the application alias

    Parameters:
      p_workspace - Workspace name of the workspace the application is to be installed at
      p_app_alias - Application alias, used to gather the actual application ID
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2);

  /**
    Procedure: prepare_rule_group_import
      Overload, is used when no application alias is used but the ID of the application is known upon installation time

    Parameters:
      p_workspace - Workspace name of the workspace the application is to be installed at
      p_app_id - Application ID
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.crg_app_id%type);

  /**
    Procedure: prepare_rule_group_import
      Overload, is used when application ID and page ID is known

    Parameters:
      p_crg_app_id - Application ID
      p_crg_page_id - Application Page ID
   */
  procedure prepare_rule_group_import(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type);

  -- Group: Rule Methods
  /**
    Procedure: merge_rule
      Administration of RULES

    Parameters:
      p_cru_id - ID of the rule
      p_cru_crg_id - ID of the rule group
      p_cru_name - Name of the rule
      p_cru_condition - rule condition
      p_cru_fire_on_page_load - Flag to indicate whether this rule is part of the page initialization. Defaults to ADC_UTIL.C_FALSE
      p_sort_seq - Sort criteria for the rule. Defaults to 10
      p_cru_active - Flag to indicate whether this rule is actually executed. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_crg_id in adc_rules.cru_crg_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type default adc_util.C_FALSE,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type default 10,
    p_cru_active in adc_rules.cru_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_rule
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure merge_rule(
    p_row in out nocopy adc_rules%rowtype);

  /**
    Procedure: delete_rule
      Deletes a rule

    Parameter:
      p_cru_id - ID of the rule to delete
   */
  procedure delete_rule(
    p_cru_id in adc_rules.cru_id%type);

  /**
    Procedure: delete_rule
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure delete_rule(
    p_row in adc_rules%rowtype);

  /**
    Procedure: validate_rule_condition
      Validates the condition of a rule.

    Parameter:
      p_row - Row record
   */
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype);

  /**
    Procedure: validate_rule
      Validates a rule.

    Parameter:
      p_row - Row record
   */
  procedure validate_rule(
    p_row in adc_rules%rowtype);

  /**
    Procedure: resequence_rule
      Helper to resequence rules and rule actions.
      Is called automatically upon change of a rule to resequence all entries in steps of 10

    Parameter:
      p_cru_id - Rule group ID
   */
  procedure resequence_rule(
    p_cru_id in adc_rules.cru_id%type);

  -- Group: Rule Action Methods
  /**
    Procedure: merge_rule_action
      Administration of RULE ACTIONS

    Parameters:
      p_cra_id - ID of the rule action
      p_cra_cru_id - Reference to adc_rules
      p_cra_crg_id - Reference to adc_rule_groups
      p_cra_cpi_id - Reference to ADC_PAGE_ITEM
      p_cra_cat_id - Reference to ADC_ACTION_TYPE
      p_sort_seq - Sort criteria to organize the order of execution. Defaults to 10
      p_cra_param_1 - Optional parameter 1
      p_cra_param_2 - Optional parameter 2
      p_cra_param_3 - Optional parameter 3
      p_cra_on_error - Optional flag to indicate whether this action is executed as an error handler for that rule. Defaults to ADC_UTIL.C_FALSE
      p_cra_raise_recursive - Optional flag to indicate whether this action allows recursive executions of other rules. Defaults to ADC_UTIL.C_TRUE
      p_cra_raise_on_validation - Optional flag to indicate whether this action has to be executed when the page is validated. Defaults to ADC_UTIL.C_FALSE
      p_cra_active - Optional flag to indicate whether this rule action is in use. Defaults to ADC_UTIL.C_TRUE
      p_cra_comment - Optional developer comment
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type default null,
    p_cra_cru_id in adc_rule_actions.cra_cru_id%type,
    p_cra_crg_id in adc_rule_actions.cra_crg_id%type,
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cra_cat_id in adc_rule_actions.cra_cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type default 10,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_raise_on_validation in adc_rule_actions.cra_raise_on_validation%type default adc_util.C_FALSE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null);

  /**
    Procedure: merge_rule_action
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure merge_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype);

  /**
    Procedure: delete_rule_action
      Deletes a Rule Action

    Parameter:
      p_cra_id - ID of the rule action to delete
   */
  procedure delete_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type);

  /**
    Procedure: delete_rule_action
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype);

  /**
    Procedure: validate_rule_action
      Validates a Rule Action.

    Parameter:
      p_row - Row record
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype);

  -- Group: APEX Action Methods
  /**
    Procedure: merge_apex_action
      Administration of APEX ACTIONS

    Parameters:
      p_caa_id - ID of the apex action
      p_caa_crg_id - Reference to adc_rule_groups
      p_caa_caat_id - Reference to adc_apex_action_types
      p_caa_name - Internal name of the action
      p_caa_confirm_message_name - Optional PIT message name for confirm dialogs
      p_caa_label - User visible label
      p_caa_context_label - Optional context label
      p_caa_icon - Optional icon name
      p_caa_icon_type - Optional icon type. Defaults to fa
      p_caa_title - Optional title
      p_caa_shortcut - Optional keyboard shortcut
      p_caa_initially_disabled - Optional flag to indicate whether the action starts disabled. Defaults to ADC_UTIL.C_FALSE
      p_caa_initially_hidden - Optional flag to indicate whether the action starts hidden. Defaults to ADC_UTIL.C_FALSE
      p_caa_href - Optional href for link actions
      p_caa_action - Optional javascript action
      p_caa_on_label - Optional label for toggle on state
      p_caa_off_label - Optional label for toggle off state
      p_caa_get - Optional getter function
      p_caa_set - Optional setter function
      p_caa_choices - Optional choice definition
      p_caa_label_classes - Optional CSS classes for the label
      p_caa_label_start_classes - Optional CSS classes at the start of the label
      p_caa_label_end_classes - Optional CSS classes at the end of the label
      p_caa_item_wrap_class - Optional wrapping CSS class
   */
  procedure merge_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type default null,
    p_caa_crg_id in adc_apex_actions_v.caa_crg_id%type,
    p_caa_caat_id in adc_apex_actions_v.caa_caat_id%type,
    p_caa_name in adc_apex_actions_v.caa_name%type,
    p_caa_confirm_message_name in adc_apex_actions_v.caa_confirm_message_name%type,
    p_caa_label in adc_apex_actions_v.caa_label%type,
    p_caa_context_label in adc_apex_actions_v.caa_context_label%type default null,
    p_caa_icon in adc_apex_actions_v.caa_icon%type default null,
    p_caa_icon_type in adc_apex_actions_v.caa_icon_type%type default 'fa',
    p_caa_title in adc_apex_actions_v.caa_title%type default null,
    p_caa_shortcut in adc_apex_actions_v.caa_shortcut%type default null,
    p_caa_initially_disabled in adc_apex_actions_v.caa_initially_disabled%type default adc_util.C_FALSE,
    p_caa_initially_hidden in adc_apex_actions_v.caa_initially_hidden%type default adc_util.C_FALSE,
    p_caa_href in adc_apex_actions_v.caa_href%type default null,
    p_caa_action in adc_apex_actions_v.caa_action%type default null,
    p_caa_on_label in adc_apex_actions_v.caa_on_label%type default null,
    p_caa_off_label in adc_apex_actions_v.caa_off_label%type default null,
    p_caa_get in adc_apex_actions_v.caa_get%type default null,
    p_caa_set in adc_apex_actions_v.caa_set%type default null,
    p_caa_choices in adc_apex_actions_v.caa_choices%type default null,
    p_caa_label_classes in adc_apex_actions_v.caa_label_classes%type default null,
    p_caa_label_start_classes in adc_apex_actions_v.caa_label_start_classes%type default null,
    p_caa_label_end_classes in adc_apex_actions_v.caa_label_end_classes%type default null,
    p_caa_item_wrap_class in adc_apex_actions_v.caa_item_wrap_class%type default null);

  /**
    Procedure: merge_apex_action
      Overload with a row record and optional item list

    Parameters:
      p_row - Row record
      p_caa_caai_list - Optional list of affected apex action items
   */
  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_caai_list in char_table default null);

  /**
    Procedure: delete_apex_action
      Deletes an apex action.

    Parameter:
      p_caa_id - ID of the apex action to delete
   */
  procedure delete_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type);

  /**
    Procedure: delete_apex_action
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype);

  /**
    Procedure: validate_apex_action
      Validates an apex action.

    Parameter:
      p_row - Row record
   */
  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype);

  /**
    Procedure: merge_apex_action_item
      Administration of APEX ACTION ITEMS

    Parameters:
      p_caai_caa_id - Reference to adc_apex_actions
      p_caai_cpi_crg_id - Reference to adc_page_items.crg_id
      p_caai_cpi_id - Reference to adc_page_items.cpi_id
      p_caai_active - Optional flag to indicate whether this entry is active. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type,
    p_caai_cpi_crg_id in adc_apex_action_items.caai_cpi_crg_id%type,
    p_caai_cpi_id in adc_apex_action_items.caai_cpi_id%type,
    p_caai_active in adc_apex_action_items.caai_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_apex_action_item
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype);

  /**
    Procedure: delete_apex_action_item
      Deletes apex action items for an apex action.

    Parameter:
      p_caai_caa_id - ID of the apex action
   */
  procedure delete_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type);

  /**
    Procedure: delete_apex_action_item
      Overload with a row record

    Parameter:
      p_row - Row record
   */
  procedure delete_apex_action_item(
    p_row in adc_apex_action_items%rowtype);

  /**
    Procedure: validate_apex_action_item
      Validates an apex action item.

    Parameter:
      p_row - Row record
   */
  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype);
end adc_config;
