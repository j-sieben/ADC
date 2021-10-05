create or replace package adc_admin
  authid definer
as

  /**
    Package: ADC_ADMIN
    
             Main package to administer ADC rules and related metadata.

    Author: Juergen Sieben, ConDeS GmbH

   */

  -- Group: Constants
  /**
    Constants: Public Constants
      C_ALL_GROUPS - Export all ADC groups
      C_APEX_APP - Export all ADC groups of an APEX application including the application itself
      C_APP_GROUPS - Export all ADC group of an APEX application
      C_PAGE_GROUP - Export a single ADC group
  */
  C_ALL_GROUPS constant adc_util.ora_name_type := 'ALL_GROUPS';
  C_APEX_APP constant adc_util.ora_name_type := 'APEX_APP';
  C_APP_GROUPS constant adc_util.ora_name_type := 'APP_GROUPS';
  C_PAGE_GROUP constant adc_util.ora_name_type := 'PAGE_GROUP';

  -- Group: Helper Functions
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
    
  
  -- Group: Rule Group Functions
  /**
    Procedure; merge_rule_group
                 Administration of RULE GROUPS. Is used to create a rule group.

    Parameters:
      p_cgr_app_id - APEX application id
      p_cgr_page_id - APEX application page id
      p_cgr_id - Optional technical ID of the rule group. Upon script based import this parameter is used as
   *             a foreign key for rules in order to organize the relationship even if new IDs are created
     p_cgr_with_recursion - Optional flag to indicate whehter this rule allows recursive calls
     p_cgr_active - Optional flag to indicate, whether this rule group is actually used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_rule_group(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type default null,
    p_cgr_with_recursion in adc_rule_groups.cgr_with_recursion%type default adc_util.C_TRUE,
    p_cgr_active in adc_rule_groups.cgr_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_rule_group
                 Overlaod with a rowtype record.
    
    Parameter:
      p_row - Row record
   */
  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);


  /**
    Procedure: delete_rule_group
                 Is called from the ADC UI to remove a rule group

    Parameter:
      p_cgr_id - Technical ID of the rule group to delete
   */
  procedure delete_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type);

  /**
    Procedure: delete_rule_group
                 Overlaod with a rowtype record.
    
    Parameter:
      p_row - Row record
   */
  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);

  /**
    Procedure: validate_rule_group
                 Method validates a newly created or updated rule group tupel
    
    Parameter:
      p_row - Row record
      
    Errors:
      CGR_APP_ID_MISSING - if Parameter CGR_APP_ID IS NULL
      CGR_PAGE_ID_MISSING - if Parameter CGR_PAGE_ID IS NULL
      ADC_CGR_MUST_BE_UNIQUE - if provided CGR_APP_ID/CGR_PAGE_ID combination already exists as a dynamic page
   */
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype);


  /**
    Function: validate_rule_group
                Method checks all rules of a rule group to find invalid rules. Is called before a rule group is exported.
   
    Parameter:
      p_cgr_id - Rule group ID to check
      
    Returns:
      Returns an error message if any error has occurred
   */
  function validate_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2;


  /**
    Procedure: propagate_rule_change
                 Method to propagate that a rule has changed.
                 
                 Is used to propagate any rule change after a rule has been edited.
                 Method checks whether rule group is valid, maintains the internal page item mappings and
                 recreates the rule group decision table of the rule group.
                 
                 The export script calls this method automatically after a rule group has been imported completely
   
    Parameter:
      p_cgr_id - ID of the rule group that has changed
   */
  procedure propagate_rule_change(
    p_cgr_id in adc_rule_groups.cgr_id%type);


  /** 
    Function: export_rule_group
                Method to export one rule group. If called, the respective rule group is exported as a CLOB instance.
                
    Parameters:
      p_cgr_id  Rule group ID of the rule group that is to be exported
      p_mode - Optional information, needed to switch the frame template accordingly
      
    Returns:
      Script to import a rule group, including all necessary information, excluding action type definitions
   */
  function export_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_mode in varchar2 default C_APP_GROUPS)
    return clob;


  /** 
    Function: export_rule_groups
                Method to export one or many rule groups.
                
                Based on the parameters passed in this method will export one or more rule groups.
                
                - If no parameter is passed in, all existing rule groups are exported.
                - If only parameter P_CGR_APP_ID is passed in all rule groups of the respective APEX application are exported.
                - If parameters P_CGR_APP_ID and P_CGR_PAGE_ID is passed in only the rule group of the respecite APEX application page are exported.
   
    Parameters:
      p_cgr_app_id - Optional APEX application ID of the application of which all rule groups are to be exported
      p_cgr_page_id - Optional APEX page ID
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
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type default null,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type default null,
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
    p_app_id in adc_rule_groups.cgr_app_id%type);

  /**
    Procedure: prepare_rule_group_import
                 Overload, is used when application ID and page ID is known
                 
    Parameters:
      p_cgr_app_id - Application ID
      p_cgr_page_id - Application Page ID
   */
  procedure prepare_rule_group_import(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type);



  -- Group: Rule Functions
  /**
    Procedure: merge_rule
                 Administration of RULES
    
    Parameters:
      p_cru_id - ID of the rule
      p_cru_cgr_id - ID of the rule group
      p_cru_name - Name of the rule
      p_cru_condition - rule condition
      p_cru_fire_on_page_load - Flag to indicate whether this rule is part of the page initialization
      p_sort_seq - Sort criteria for the rule
      p_cru_active - Flag to indicate whether this rule is actually executed. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_cgr_id in adc_rules.cru_cgr_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
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
                 Method to validate a rule condition. Is called from VALIDATE_RULE as well
                 
    Parameter:
      p_row - Row record
      
    Errors:
      msg.SQL_ERROR - if any invalid conditions are entered
      CRU_CONDITION_MISSING - if Parameter CRU_CONDITION IS NULL
   */
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype);

  /**
    Procedure: validate_rule
                 Method to validate a rule
                 
    Parameter:
      p_row - Row record
      
    Errors:
      msg.ADC_INVALID_SQL - if any invalid conditions are entered
      CRU_CGR_ID_MISSING - if Parameter CRU_CGR_ID IS NULL
      CRU_NAME_MISSING - if Parameter CRU_NAME IS NULL
      CRU_CONDITION_MISSING - if Parameter CRU_CONDITION IS NULL
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


  -- Group: Rule Action Functions
  /**
    Procedure: merge_rule_action
                 Administration of RULE ACTIONS
                 
    Parameters:
      p_cra_id - ID of the rule action
      p_cra_cru_id - Reference to adc_rules
      p_cra_cgr_id - Reference to adc_rule_groups
      p_cra_cpi_id - Reference to ADC_PAGE_ITEM
      p_cra_cat_id - Reference to ADC_ACTION_TYPE
      p_sort_seq - Sort criteria to organize the order of execution
      p_cra_param_1 - Optional parameter 1
      p_cra_param_2 - Optional parameter 2
      p_cra_param_3 - Optional parameter 3
      p_cra_on_error - Optional flag to indicate whether this action is executed as an error handler for that rule. Defaults to ADC_UTIL.C_FALSE
      p_cra_raise_recursive - Optional flag to indicate whether this action allows recursive executions of other rules. Defaults to ADC_UTIL.C_TRUE
      p_cra_active - Optional flag to indicate whether this rule action is in use. Defaults to ADC_UTIL.C_TRUE
      p_cra_comment - Optional developer comment
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type,
    p_cra_cru_id in adc_rule_actions.cra_cru_id%type,
    p_cra_cgr_id in adc_rule_actions.cra_cgr_id%type,
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cra_cat_id in adc_rule_actions.cra_cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null);

  /**
    Procedure: merge_rule_action
                 Overload with a row record.
                 
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
                 Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype);

  /** 
    Procedure: validate_rule_action
                 Method to validate a rule action
                 
    Parameter:
      p_row - Row record
    
    Errors
      CRA_CRU_ID_MISSING - if Parameter CRA_CRU_ID IS NULL
      CRA_CGR_ID_MISSING - if Parameter CRA_CGR_ID IS NULL
      CRA_CPI_ID_MISSING - if Parameter CRA_CPI_ID IS NULL
      CRA_CAT_ID_MISSING - if Parameter CRA_CAT_ID IS NULL
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype);


  -- Group: Action Type Functions
  /**
    Procedure: merge_action_type_group
                 Administration of ACTION TYPE GROUPS
                 
    Parameters:
      p_ctg_id - ID of the action type group
      p_srg_name - Name of the action type group
      p_ctg_description - Optional description of the action type group
      p_ctg_active - Flag to indicate whether this action type group is actually in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_type_group(
    p_ctg_id in adc_action_type_groups_v.ctg_id%type,
    p_ctg_name in adc_action_type_groups_v.ctg_name%type,
    p_ctg_description in adc_action_type_groups_v.ctg_description%type,
    p_ctg_active in adc_action_type_groups_v.ctg_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_action_type_group
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_type_group(
    p_row in out nocopy adc_action_type_groups_v%rowtype);

  /**
    Procedure: delete_action_type_group
                 Overload with a row record
                 
    Parameter:
      p_ctg_id - ID of the action type group to delete
   */
  procedure delete_action_type_group(
    p_ctg_id in adc_action_type_groups.ctg_id%type);

  /**
    Procedure: delete_action_type_group
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_type_group(
    p_row in adc_action_type_groups_v%rowtype);

  /**
    Procedure: validate_action_type_group
                 Validates an Action Type Group
                 
    Parameter:
      p_row - Row record
      
    Errors:
      CTG_ID_MISSING - if parameter P_ROW.CTG_ID is null
      CTG_NAME_MISSING - if parameter P_ROW.CTG_NAME is null
   */
  procedure validate_action_type_group(
    p_row in adc_action_type_groups_v%rowtype);


  /**
    Procedure: merge_action_param_type
                 Administration of ACTION PARAMETER TYPES
                 
    Parameters:
      p_cpt_id - ID of the action parameter type
      p_cpt_name - Name of the action parameter type
      p_cpt_display_name - Display name of the action parameter type
      p_cpt_description - Optional description
      p_cpt_item_type - Choice of input item type for this parameter type, one of SELECT_LIST|TEXT_AREA|TEXT
                        If set to SELECT_LIST, a view of name ADC_PARAM_LOV_<CPT_ID> must be provided to calculate
                        the available values. This list may be filtered using CGR_ID.
      p_cpt_active - Flag to indicate whether this action parameter type is used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_param_type(
    p_cpt_id in adc_action_param_types_v.cpt_id%type,
    p_cpt_name in adc_action_param_types_v.cpt_name%type,
    p_cpt_display_name in adc_action_param_types_v.cpt_display_name%type default null,
    p_cpt_description in adc_action_param_types_v.cpt_description%type default null,
    p_cpt_item_type in adc_action_param_types_v.cpt_item_type%type,
    p_cpt_active in adc_action_param_types_v.cpt_active%type default ADC_UTIL.C_TRUE);

  /**
    Procedure: merge_action_param_type
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_param_type(
    p_row in out nocopy adc_action_param_types_v%rowtype);

  /**
    Procedure: delete_action_param_type
                 Overload with a row record
                 
    Parameter:
      p_cpt_id - ID of the Action Parameter Type to delete
   */
  procedure delete_action_param_type(
    p_cpt_id in adc_action_param_types.cpt_id%type);

  /**
    Procedure: delete_action_param_type
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_param_type(
    p_row in adc_action_param_types_v%rowtype);
    
  /**
    Procedure: validate_action_param_type
                 VAlidates and Action Parameter Type
                 
    Errors:
      msg.ADC_PARAM_LOV_MISSING - if LOV view is required but missing
      msg.ADC_PARAM_LOV_INCORRECT - if required LOV view exists but with the wrong structure
      CPT_ID_MISSING - if parameter P_CPT_ID is NULL
      CPT_NAME_MISSING - if parameter P_CPT_NAME is NULL
      CPT_ITEM_TYPE_MISSING - if parameter P_CPT_ITEM_TYPE is NULL
   */
  procedure validate_action_param_type(
    p_row in adc_action_param_types_v%rowtype);
    

  /**
    Procedure: merge_action_item_focus
                 Method for generating an ITEM focus. Used to define the ITEM focus of an action
                 
    Parameters:
      p_cif_id - ID of the item focus
      p_cif_name - Name of the item focus
      p_cif_description - Optional description
      p_cif_actual_page_only - Flag to indicate whether only items from the actual APEX page are recognized
      p_cif_item_types - List of item types to include
      p_cif_default - Optional default value for the item type
      p_cif_active - Flag, das anzeigt, ob dieser Parametertyp verwendet wird. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_item_focus(
    p_cif_id in adc_action_item_focus_v.cif_id%type,
    p_cif_name in adc_action_item_focus_v.cif_name%type,
    p_cif_description in adc_action_item_focus_v.cif_description%type,
    p_cif_actual_page_only in adc_action_item_focus_v.cif_actual_page_only%type default adc_util.C_TRUE,
    p_cif_item_types in adc_action_item_focus_v.cif_item_types%type,
    p_cif_default adc_action_item_focus_v.cif_default%type,
    p_cif_active in adc_action_item_focus_v.cif_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_action_item_focus
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_item_focus(
    p_row in out nocopy adc_action_item_focus_v%rowtype);

  /**
    Procedure: delete_action_item_focus
                 Overload with a row record
                 
    Parameter:
      p_cif_id - ID of the Action Item Focus to delete
   */
  procedure delete_action_item_focus(
    p_cif_id in adc_action_item_focus.cif_id%type);

  /**
    Procedure: delete_action_item_focus
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype);

  /**
    Procedure: validate_action_item_focus
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype);


  /**
    Procedure: merge_action_type
                 Administration of ACTION TYPES
                 
    Paarmeters:
      p_cat_id - ID of the action type
      p_cat_ctg_id - Reference to adc_action_type_groups
      p_cat_cif_id - Reference to ADC_ACTION_ITEM_FOCUS
      p_cat_name - Name of the action type
      p_cat_display_name - Verbose name of the action type
      p_cat_description - Optional description
      p_cat_pl_sql - PL/SQL code that is to be executed
      p_cat_js - JavaScript code that is to be executed
      p_cat_is_editable - Optional flag to indicate whether this action type is editable by the end user. Defaults to adc_util.C_TRUE.
      p_cat_raise_recursive - Optional flag to indicate whether this action type allow recursive calls of rules. Defaults to adc_util.C_TRUE.
      p_cat_active] - Optional flag to indicate whether this action type is actually used. Defaults to adc_util.C_TRUE.
   */    
  procedure merge_action_type(
    p_cat_id in adc_action_types_v.cat_id%type,
    p_cat_ctg_id in adc_action_types_v.cat_ctg_id%type,
    p_cat_cif_id in adc_action_types_v.cat_cif_id%type,
    p_cat_name in adc_action_types_v.cat_name%type,
    p_cat_display_name in adc_action_types_v.cat_display_name%type,
    p_cat_description in adc_action_types_v.cat_description%type default null,
    p_cat_pl_sql in adc_action_types_v.cat_pl_sql%type,
    p_cat_js in adc_action_types_v.cat_js%type,
    p_cat_is_editable in adc_action_types_v.cat_is_editable%type default adc_util.C_TRUE,
    p_cat_raise_recursive in adc_action_types_v.cat_raise_recursive%type default adc_util.C_TRUE,
    p_cat_active in adc_action_types_v.cat_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_action_type
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_type(
    p_row in adc_action_types_v%rowtype);

  /**
    Procedure: delete_action_type
                 Deletes an Action Type
                 
    Parameter:
      p_cat_id - ID of the action type to delete
   */
  procedure delete_action_type(
    p_cat_id in adc_action_types.cat_id%type);

  /**
    Procedure: delete_action_type
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_type(
    p_row in adc_action_types_v%rowtype);
    
  /**
    Procedure: validate_action_type
                 Validates and Action Type
                 
    Parameter:
      p_row - Row record
      
    Errors:
      CAT_ID_MISSING - if parameter P_CAT_ID is NULL
      CAT_CTG_ID_MISSING - if parameter P_CAT_CTG_ID is NULL
      CAT_CIF_ID_MISSING - if parameter P_CAT_CIF_ID is NULL
      CAT_NAME_MISSING - if parameter P_CAT_NAME is NULL
   */
  procedure validate_action_type(
    p_row in adc_action_types_v%rowtype);


  /**
    Function: export_action_types
                Method to export an action type. Creates a BLOB instance with the requested action types for export.
                
    Parameter:
      p_cat_is_editable - Controls, which ADC rules to export:
      
                          - C_TRUE: User defined action types
                          - C_FALSE: Internally defined action types
                          - NULL: Both, internally and user defined action types
   */
  function export_action_types(
    p_cat_is_editable in adc_action_types.cat_is_editable%type default adc_util.C_TRUE)
    return blob;


  /**
    Procedure: merge_action_parameter
                 Adminsitration of ACTION PARAMETERS
                 
    Parameters:
      p_cap_cat_id - Reference to ADC_ACTION_TYPE
      p_cap_cpt_id - Reference to adc_action_parameters_TYPE
      p_cap_sort_seq - Sort order and restriction of number of parameters
      p_cap_default - Optional standard value of the parameter
      p_cap_description - Optional description
      p_cap_display_name - Optional display name of the Action Type
      p_cap_mandatory - Flag to indicate whether this action parameter is required
      p_cap_active - Optional flag to indicate whether this action parameter is in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters_v.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type,
    p_cap_default in adc_action_parameters_v.cap_default%type,
    p_cap_description in adc_action_parameters_v.cap_description%type,
    p_cap_display_name in adc_action_parameters_v.cap_display_name%type,
    p_cap_mandatory in adc_action_parameters_v.cap_mandatory%type,
    p_cap_active in adc_action_parameters_v.cap_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_action_parameter
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_parameter(
    p_row in out nocopy adc_action_parameters_v%rowtype);

  /**
    Procedure: delete_action_parameter
                 Deletes an Action Parameter
                 
    Parameter:
      p_cap_cat_id - ID of the Action Type the parameter belongs to
      p_cap_cpt_id - ID of the Parameter Type the parameter belongs to
      p_cap_sort_seq - Sort sequence of the parameter
   */
  procedure delete_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters_v.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type);

  /**
    Procedure: delete_action_parameter
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_parameter(
    p_row in adc_action_parameters_v%rowtype);

  /**
    Procedure: delete_action_parameters
                 Method to remove all parameters for an action type.
                 Is used to remove any existing action parameters prior to adding then again.
                 This is necessary to prevent PK violations and to remove any parameters
                 which are no longer required.
                 
    Parameter:
      p_cap_cat_id - Reference to ADC_ACTION_TYPE
   */
  procedure delete_action_parameters(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type);

  /**
    Procedure: validate_action_parameter
                 Validates an Action Parameter
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_action_parameter(
    p_row in adc_action_parameters_v%rowtype);


  /**
    Procedure: merge_page_item_type
                 Administration of PAGE ITEM TYPES
                 
    Parameters:
      p_cit_id - Technical ID of the item type
      p_cit_name - Display name
      p_cit_has_value - Flag to indicate whether this is an item containing a session state value
      p_cit_include_in_view - Flag to indicate whether this item has to be included in the session state view
      p_cit_event - Event thas has to be bound if a rule requires this item
      p_cit_col_template - Template for the session state view to retrieve the session state value
      p_cit_init_template . Template to get the initial session state value
      p_cit_init_template . Flag that indicates whether this event has to be observered explicitly by a rule action
   */
  procedure merge_page_item_type(
    p_cit_id              in adc_page_item_types_v.cit_id%type,
    p_cit_name            in adc_page_item_types_v.cit_name%type,
    p_cit_has_value       in adc_page_item_types_v.cit_has_value%type,
    p_cit_include_in_view in adc_page_item_types_v.cit_include_in_view%type,
    p_cit_event           in adc_page_item_types_v.cit_event%type,
    p_cit_col_template    in adc_page_item_types_v.cit_col_template%type,
    p_cit_init_template   in adc_page_item_types_v.cit_init_template%type,
    p_cit_is_custom_event in adc_page_item_types_v.cit_is_custom_event%type);
    
  /**
    Procedure: merge_page_item_type
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_page_item_type(
    p_row in out nocopy adc_page_item_types_v%rowtype);

  /**
    Procedure: delete_page_item_type
                 Deletes a Page Item Type
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_page_item_type(
    p_row in adc_page_item_types_v%rowtype);
    
  /**
    Procedure: validate_page_item_type
                 Validates an Page Item Type
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_page_item_type(
    p_row in adc_page_item_types_v%rowtype);
    

  -- Group: APEX Action Functions
  /**
    Procedure: merge_apex_action_type
                 Administration of APEX ACTION TYPES
                 
    Parameters:
      p_cty_id - Technical ID
      p_cty_display_name - Display name of the action type
      p_cty_description - Description
      p_cty_active - Flag to indicate whether this action type is in use
   */
  procedure merge_apex_action_type(
    p_cty_id in adc_apex_action_types_v.cty_id%type,
    p_cty_name in adc_apex_action_types_v.cty_name%type,
    p_cty_description in adc_apex_action_types_v.cty_description%type,
    p_cty_active in adc_apex_action_types_v.cty_active%type);

  /**
    Procedure: merge_apex_action_type
                 Overload with a rowtype record.
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_apex_action_type(
    p_row in out nocopy adc_apex_action_types_v%rowtype);

  /**
    Procedure: delete_apex_action_type
                 Deletes an APEX Action Type
                 
    Parameter:
      p_cty_id - ID of the APEX Action Type
   */
  procedure delete_apex_action_type(
    p_cty_id in adc_apex_action_types_v.cty_id%type);

  /**
    Procedure: delete_apex_action_type
                 Overload with a rowtype record.
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype);

  /**
    Procedure: validate_apex_action_type
                 Validates an APEX Action Type
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype);


  /**
    Procedure: merge_apex_action
                 Administration of APEX ACTIONS
                 
    Parameters:
      p_caa_cgr_id - Reference to a rule group
      p_caa_name - APEX action name as referenced by apex.actions as data-<name> attribute.
      p_caa_cty_id - Type of Action (ACTION|TOGGLE|RADIO_GROUP),
      p_caa_label - Display name,
      p_caa_context_label - Extended name, is used in select list or on the UI
      p_caa_icon - Icon of the action
      p_caa_icon_type - Icontype. Standard: fa
      p_caa_title - Tooltip of the action
      p_caa_shortcut - Shortcut as defined in apex.actions, fi. ALT-A
      p_caa_href - (Type ACTION only): HREF attribute of the action. Only one of HREF or ACTION allowed
      p_caa_action - (Type ACTION only): JavaScript function that is executed if the action is invoked. Only one of HREF or ACTION allowed
      p_caa_on_label - (Type TOGGLE only): Label if apex action is enabled
      p_caa_off_label - (Type TOGGLE only): Label if apex action is disabled
      p_caa_get] - (Type TOGGLE and RADIO_GROUP only):
                   If TOGGLE: Method that returns true or false
                   If RADIO_GROUP: Method that returns the actual value of the item
      p_caa_set - (Type TOGGLE and RADIO_GROUP only):
                  If TOGGLE: Method that sets the value to TRUE|FALSE
                  If RADIO_GROUP: Method that sets the item value
      p_caa_choices - (Type RADIO_GROUP only): List of options
      p_caa_label_classes - (Type RADIO_GROUP only): CSS label classes for all entries
      p_caa_label_start_classes - (Type RADIO_GROUP only): CSS label classes for first entry
      p_caa_label_end_classes - (Type RADIO_GROUP only): CSS label classes for last entry
      p_caa_item_wrap_class - (Type RADIO_GROUP only): CSS label classes for wrapping elements
   */
  procedure merge_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type,
    p_caa_cgr_id in adc_apex_actions_v.caa_cgr_id%type,
    p_caa_cty_id in adc_apex_actions_v.caa_cty_id%type,
    p_caa_name in adc_apex_actions_v.caa_name%type,
    p_caa_label in adc_apex_actions_v.caa_label%type,
    p_caa_context_label in adc_apex_actions_v.caa_context_label%type default null,
    p_caa_icon in adc_apex_actions_v.caa_icon%type default null,
    p_caa_icon_type in adc_apex_actions_v.caa_icon_type%type default 'fa',
    p_caa_title in adc_apex_actions_v.caa_title%type default null,
    p_caa_shortcut in adc_apex_actions_v.caa_shortcut%type default null,
    p_caa_initially_disabled in adc_apex_actions_v.caa_initially_disabled%type default 0,
    p_caa_initially_hidden in adc_apex_actions_v.caa_initially_hidden%type default 0,
    -- ACTION
    p_caa_href in adc_apex_actions_v.caa_href%type default null,
    p_caa_action in adc_apex_actions_v.caa_action%type default null,
    -- TOGGLE
    p_caa_on_label in adc_apex_actions_v.caa_on_label%type default null,
    p_caa_off_label in adc_apex_actions_v.caa_off_label%type default null,
    -- TOGGLE | RADIO_GROUP
    p_caa_get in adc_apex_actions_v.caa_get%type default null,
    p_caa_set in adc_apex_actions_v.caa_set%type default null,
    -- RADIO_GROUP
    p_caa_choices in adc_apex_actions_v.caa_choices%type default null,
    p_caa_label_classes in adc_apex_actions_v.caa_label_classes%type default null,
    p_caa_label_start_classes in adc_apex_actions_v.caa_label_start_classes%type default null,
    p_caa_label_end_classes in adc_apex_actions_v.caa_label_end_classes%type default null,
    p_caa_item_wrap_class in adc_apex_actions_v.caa_item_wrap_class%type default null);

  /**
    Procedure: merge_apex_action
                 Overload with a row record
                 
    Parameter:
      p_row - Row record
      p_caa_cai_list - Optionasl list of page item an APEX action has to be attached to (such as buttons)
   */
  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_cai_list in char_table default null);

  /**
    Procedure: delete_apex_action
                 Deletes an APEX Action
                 
    Parameter:
      p_caa_id - ID of the APEX Action to delete
   */
  procedure delete_apex_action(
    p_caa_id adc_apex_actions_v.caa_id%type);

  /**
    Procedure: delete_apex_action
                 Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype);

  /**
    Procedure: validate_apex_action
                 Validates an APEX Action Type
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype);
    

  /** 
    Procedure: merge_apex_action_item
                 Administration of APEX ACTION ITEMS
                 
    Parameters:
      p_cai_caa_id - Reference to a adc_apex_actions
      p_cai_cpi_cgr_id - ID of the rule group, Reference to ADC_PAGE_ITEM
      p_cai_cpi_id - Page item, Reference to ADC_PAGE_ITEM
      p_cai_active - Optional flag to indicate whether this apex action item is actually used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type,
    p_cai_cpi_cgr_id in adc_apex_action_items.cai_cpi_cgr_id%type,
    p_cai_cpi_id in adc_apex_action_items.cai_cpi_id%type,
    p_cai_active in adc_apex_action_items.cai_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_apex_action_item
                 Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype);

  /**
    Procedure: delete_apex_action_item
                 Deletes an APEX Action Item
                 
    Parameter:
      p_cai_caa_id - ID of the APEX Action Item to delete
   */
  procedure delete_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type);

  /**
    Procedure: delete_apex_action_item
                 Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_apex_action_item(
    p_row in adc_apex_action_items%rowtype);

  /**
    Procedure: validate_apex_action_item
                 Validates an APEX Action Item
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype);
    

  -- Group: Translation Functions
  /**
    Procedure: add_translation
                 Method to add translated data.
                 Is used to add translated names and descriptions for existing entries in the tables of ADC
                 
    Parameters:
      p_table_shortcut - Prefix that is used in the respective table. Will prefix the translated PTI_ID
      p_item_id - Name of the item for which a translation needs to be added
      p_pmg_name - Name of the language. One of the Oracle supported language names
      p_name - Translation for names
      p_display_name - Translation for display names
      p_description - Translation for descriptions and help texts
   */
  procedure add_translation(
    p_table_shortcut in adc_util.ora_name_type,
    p_item_id in adc_util.ora_name_type,
    p_pml_name pit_translatable_item.pti_pml_name%type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type);

end adc_admin;
/