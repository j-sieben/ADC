create or replace package adc_admin
  authid definer
as

  /** Package to implement all functionality around maintaining ADC rules
   * @headcom
   **/

  /** Package constants */
  C_ALL_GROUPS constant adc_util.ora_name_type := 'ALL_GROUPS';
  C_APEX_APP constant adc_util.ora_name_type := 'APEX_APP';
  C_APP_GROUPS constant adc_util.ora_name_type := 'APP_GROUPS';
  C_PAGE_GROUP constant adc_util.ora_name_type := 'PAGE_GROUP';

  /** Method to map technical IDs upon import or copying of rule groups
   * %param [p_id] ID to map to a new ID. If NULL, the mapping list is initialized
   * %usage  As it is not known beforhand which ID an entry in a table will get, this method maintains a mapping table
   *         that maps the original ID to the newly created IDs from a sequence.
   *         If the ID passed in is not found in the table, it returns the newly created ID.
   *         If the ID is found in the table, the method returns the mapped ID.
   *         Before an import of a rule group can take place, this method needs to be called with a NULL parameter to
   *         initialize a new mapping table.
   */
  function map_id(
    p_id in number default null)
    return number;
    
    
  /** Administration of RULE GROUPS
   * %param  p_cgr_app_id          APEX application id
   * %param  p_cgr_page_id         APEX application page id
   * %param [p_cgr_id]             Technical ID of the rule group. Upon script based import this parameter is used as
   *                               a foreign key for rules in order to organize the relationship even if new IDs are created
   * %param [p_cgr_with_recursion] Flag to indicate whehter this rule allows recursive calls
   * %param [p_cgr_active]         Flag to indicate, whether this rule group is actually used. Defaults to ADC_UTIL.C_TRUE
   * %usage  Is used to create a rule group.
   */
  procedure merge_rule_group(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type default null,
    p_cgr_with_recursion in adc_rule_groups.cgr_with_recursion%type default adc_util.C_TRUE,
    p_cgr_active in adc_rule_groups.cgr_active%type default adc_util.C_TRUE);

  /** Overload with a record to make communication with the UI easier */
  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);


  /** Method to delete a rule group
   * %param  p_cgr_id  Technical ID of the rule group to delete
   * %usage  Is called from the ADC UI to remove a rule group
   */
  procedure delete_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type);

  /** Overlaod with a rowtype record. This is sometimes easier, fi if a composed PK exists or a rowtype record exists anyway */
  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype);

  /** Method validates a newly created or updated rule group tupel
   * %raises Error Codes
   *         - CGR_APP_ID_MISSING, if Parameter CGR_APP_ID IS NULL
   *         - CGR_PAGE_ID_MISSING, if Parameter CGR_PAGE_ID IS NULL
   *         - ADC_CGR_MUST_BE_UNIQUE, if provided CGR_APP_ID/CGR_PAGE_ID combination already exists as a dynamic page
   */
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype);


  /** Method checks all rules of a rule group to find invalid rules
   * %param  p_cgr_id  Rule group ID to check
   * %return Returns an error message if any error has occurred
   * %usage  Is called before a rule group is exported.
   */
  function validate_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2;


  /** Method to propagate that a rule has changed.
   * %paramn p_cgr_id  ID of the rule group that has changed
   * %usage  Is used to propagate any rule change after a rule has been edited.
   *         Method checks whether rule group is valid, maintains the internal page item mappings and
   *         recreates the rule group view with the conditions of the rule group.
   *         The export script calls this method automatically after a rule group has been imported completely
   */
  procedure propagate_rule_change(
    p_cgr_id in adc_rule_groups.cgr_id%type);


  /** Method to export one rule group
   * %param  p_cgr_id  Rule group ID of the rule group that is to be exported
   * %param [p_mode]   Optional information, needed to switch the frame template accordingly
   * %usage  If called, the respective rule group is exported as a CLOB instance
   * %return Script to import a rule group, including all necessary information, excluding action type definitions
   */
  function export_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_mode in varchar2 default C_APP_GROUPS)
    return clob;


  /** Method to export one or many rule groups
   * %param [p_cgr_app_id]  APEX application ID of the application of which all rule groups are to be exported
   * %param [p_cgr_page_id] If a rule group is copied, this parameter defines the target application page id
   * %param [p_mode]        Flag to indicate what to export. Options include:
   *                        - C_ALL_GROUPS: Exports all rule groups of that workspace
   *                        - C_APEX_APP: Exports apex application including all rule groups of that application
   *                        - C_APP_GROUPS: Exports all rule groups of an APEX application
   *                        - C_PAGE_GROUP: Exports rule group of a single APEX application page
   * %usage  Based on the parameters passed in this method will export one or more rule groups.
   *         If no parameter is passed in, all existing rule groups are exported.
   *         If only parameter P_CGR_APP_ID is passed in all rule groups of the respective APEX application are exported.
   *         If parameters P_CGR_APP_ID and P_CGR_PAGE_ID is passed in only the rule group of the respecite APEX application page are exported.
   * %return BLOB instance of all files, separated by rule group name as a ZIP file instance
   * %raises Error Codes:
   *         APP_ID_MISSING if export mode is set to C_APP_GROUPS or C_PAGE_GROUPS and no application id was provided
   *         PAGE_ID_MISSING if export mode is set to C_PAGE_GROUPS and no application page id was provided
   *         msg.ADC_UNKNOWN_EXPORT_MODE if an export mode other than C_ALL_GROUPS, C_APP_GROUPS, C_PAGE_GROUPS was requested
   */
  function export_rule_groups(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type default null,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type default null,
    p_mode in varchar2 default C_APP_GROUPS)
    return blob;

  /** Method to prepare a rule group import
   * %param  p_workspace  Workspace name of the workspace the application is to be installed at
   * %param  p_app_alias  Application alias, used to gather the actual application ID
   * %usage  This method is called before a script based import of a rule group occurs to make sur that the actual
   *         application ID of the referenced application is used. This ID is taken using the application alias
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2);

  /** Overload, is used when no application alias is used but the ID of the application is known upon installation time
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.cgr_app_id%type);

  /** Another overload */
  procedure prepare_rule_group_import(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type);


  /** Administration of APEX ACTION TYPES
   * %param  p_cty_id            Technical ID
   * %param  p_cty_display_name  Display name of the action type
   * %param  p_cty_description   Optional description
   */
  procedure merge_apex_action_type(
    p_cty_id in adc_apex_action_types.cty_id%type,
    p_cty_name in pit_translatable_item.pti_name%type,
    p_cty_description in pit_translatable_item.pti_description%type,
    p_cty_active in adc_apex_action_types.cty_active%type);

  procedure merge_apex_action_type(
    p_row in out nocopy adc_apex_action_types_v%rowtype);

  procedure delete_apex_action_type(
    p_cty_id in adc_apex_action_types.cty_id%type);

  procedure delete_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype);

  procedure validate_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype);


  /** Administration of APEX ACTIONS
   * %param  p_caa_cgr_id               Reference to a rule group
   * %param  p_caa_name                 APEX action name as referenced by apex.actions as data-<name> attribute.
   * %param  p_caa_cty_id                 Type of Action (ACTION|TOGGLE|RADIO_GROUP),
   * %param  p_caa_label                Display name,
   * %param [p_caa_context_label]       Extended name, is used in select list or on the UI
   * %param [p_caa_icon]                Icon of the action
   * %param [p_caa_icon_type]           Icontype. Standard: fa
   * %param [p_caa_title]               Tooltip of the action
   * %param [p_caa_shortcut]            Shortcut as defined in apex.actions, fi. ALT-A
   * %param [p_caa_href]                (Type ACTION only): HREF attribute of the action. Only one of HREF or ACTION allowed
   * %param [p_caa_action]              (Type ACTION only): JavaScript function that is executed if the action is invoked. Only one of HREF or ACTION allowed
   * %param [p_caa_on_label]            (Type TOGGLE only): Label if apex action is enabled
   * %param [p_caa_off_label]           (Type TOGGLE only): Label if apex action is disabled
   * %param [p_caa_get]                 (Type TOGGLE and RADIO_GROUP only):
   *                                      If TOGGLE: Method that returns true or false
   *                                      If RADIO_GROUP: Method that returns the actual value of the item
   * %param [p_caa_set]                 (Type TOGGLE and RADIO_GROUP only):
   *                                      If TOGGLE: Method that sets the value to TRUE|FALSE
   *                                      If RADIO_GROUP: Method that sets the item value
   * %param [p_caa_choices]             (Type RADIO_GROUP only): List of options
   * %param [p_caa_label_classes]       (Type RADIO_GROUP only): CSS label classes for all entries
   * %param [p_caa_label_start_classes] (Type RADIO_GROUP only): CSS label classes for first entry
   * %param [p_caa_label_end_classes]   (Type RADIO_GROUP only): CSS label classes for last entry
   * %param [p_caa_item_wrap_class]     (Type RADIO_GROUP only): CSS label classes for wrapping elements
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


  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_cai_list in char_table default null);

  procedure delete_apex_action(
    p_caa_id adc_apex_actions.caa_id%type);

  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype);

  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype);
    

  /** Administration of APEX ACTION ITEMS
   * %param  p_cai_caa_id      Reference to a adc_apex_actions
   * %param  p_cai_cpi_cgr_id  ID of the rule group, Reference to ADC_PAGE_ITEM
   * %param  p_cai_cpi_id      Page item, Reference to ADC_PAGE_ITEM
   * %param [p_cai_active]     Flag to indicate whether this apex action item is actually used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type,
    p_cai_cpi_cgr_id in adc_apex_action_items.cai_cpi_cgr_id%type,
    p_cai_cpi_id in adc_apex_action_items.cai_cpi_id%type,
    p_cai_active in adc_apex_action_items.cai_active%type default adc_util.C_TRUE);

  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype);

  procedure delete_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type);

  procedure delete_apex_action_item(
    p_row in adc_apex_action_items%rowtype);

  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype);


  /** Administration of RULES *
   * %param  p_cru_id         ID of the rule
   * %param  p_cru_cgr_id     ID of the rule group
   * %param  p_cru_name       Name of the rule
   * %param  p_cru_condition  rule condition
   * %param  p_sort_seq       Sort criteria for the rule
   * %param [p_cru_active]    Flag to indicate whether this rule is actually executed. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_cgr_id in adc_rule_groups.cgr_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
    p_cru_active in adc_rules.cru_active%type default adc_util.C_TRUE);

  procedure merge_rule(
    p_row in out nocopy adc_rules%rowtype);


  procedure delete_rule(
    p_cru_id in adc_rules.cru_id%type);

  procedure delete_rule(
    p_row in adc_rules%rowtype);
    
  /** Method to validate a rule condition. Is called from VALIDATE_RULE as well
   * %raises - msg.SQL_ERROR if any invalid conditions are entered
   *         - msg.ADC_PARAM_MISSING
   *           Error-Codes:
               - CRU_CONDITION_MISSING, if Parameter CRU_CONDITION IS NULL
   */
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype);

  /** Method to validate a rule
   * %raises - msg.SQL_ERROR if any invalid conditions are entered
   *         - msg.ADC_PARAM_MISSING
   *           Error-Codes:
   *           - CRU_CGR_ID_MISSING, if Parameter CRU_CGR_ID IS NULL
   *           - CRU_NAME_MISSING, if Parameter CRU_NAME IS NULL
   *           - CRU_CONDITION_MISSING, if Parameter CRU_CONDITION IS NULL
   */
  procedure validate_rule(
    p_row in adc_rules%rowtype);


  /** Helper to resequence rules and rule actions
   * %param  p_cru_id  Rule group ID
   * %usage  Is called automatically upon change of a rule to resequence all entries in steps of 10
   */
  procedure resequence_rule(
    p_cru_id in adc_rules.cru_id%type);


  /** Administration of ACTION TYPE GROUPS
   * %param  p_ctg_id           ID of the action type group
   * %param  p_srg_name         Name of the action type group
   * %param  p_ctg_description  Optional description of the action type group
   * %param [p_ctg_active]      Flag to indicate whether this action type group is actually in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_type_group(
    p_ctg_id in adc_action_type_groups.ctg_id%type,
    p_ctg_name in pit_translatable_item.pti_name%type,
    p_ctg_description in pit_translatable_item.pti_description%type,
    p_ctg_active in adc_action_type_groups.ctg_active%type default adc_util.C_TRUE);

  procedure merge_action_type_group(
    p_row in out nocopy adc_action_type_groups_v%rowtype);


  procedure delete_action_type_group(
    p_ctg_id in adc_action_type_groups.ctg_id%type);

  procedure delete_action_type_group(
    p_row in adc_action_type_groups_v%rowtype);

  /**
   * %throws  msg.ADC_PARAM_MISSING
   *          error codes 
   *            CTG_ID_MISSING if parameter P_ROW.CTG_ID is null
   *            CTG_NAME_MISSING if parameter P_ROW.CTG_NAME is null
   */
  procedure validate_action_type_group(
    p_row in adc_action_type_groups_v%rowtype);


  /** Administration of ACTION PARAMETER TYPES
   * %param  p_cpt_id            ID of the action parameter type
   * %param  p_cpt_name          Name of the action parameter type
   * %param  p_cpt_display_name  Display name of the action parameter type
   * %param  p_cpt_description   Optional description
   * %param  p_cpt_item_type     Choice of input item type for this parameter type, one of SELECT_LIST|TEXT_AREA|TEXT
   *                             If set to SELECT_LIST, a view of name ADC_PARAM_LOV_<CPT_ID> must be provided to calculate
   *                             the available values. This list may be filtered using CGR_ID.
   * %param [p_cpt_active]       Flag to indicate whether this action parameter type is used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_param_type(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpt_name in pit_translatable_item.pti_name%type,
    p_cpt_display_name in pit_translatable_item.pti_display_name%type default null,
    p_cpt_description in pit_translatable_item.pti_description%type default null,
    p_cpt_item_type in adc_action_param_types.cpt_item_type%type,
    p_cpt_active in adc_action_param_types.cpt_active%type default ADC_UTIL.C_TRUE);

  procedure merge_action_param_type(
    p_row in out nocopy adc_action_param_types_v%rowtype);


  procedure delete_action_param_type(
    p_cpt_id in adc_action_param_types.cpt_id%type);

  procedure delete_action_param_type(
    p_row in adc_action_param_types_v%rowtype);
    
  /**
   * %raises msg.ADC_PARAM_LOV_MISSING if LOV view is required but missing
   *         msg.ADC_PARAM_LOV_INCORRECT if required LOV view exists but with the wrong structure
   *         Error-Codes:
   *         CPT_ID_MISSING if parameter P_CPT_ID is NULL
   *         CPT_NAME_MISSING if parameter P_CPT_NAME is NULL
   *         CPT_ITEM_TYPE_MISSING if parameter P_CPT_ITEM_TYPE is NULL
   */
  procedure validate_action_param_type(
    p_row in adc_action_param_types_v%rowtype);
    

  /** Administration of ACTION ITEM FOCUS */
  /** Method for generating an ITEM focus
   * %param  p_cif_id                ID of the item focus
   * %param  p_cif_name              Name of the item focus
   * %param  p_cif_description       Optional description
   * %param  p_cif_actual_page_only  Flag to indicate whether only items from the actual APEX page are recognized
   * %param  p_cif_item_types        List of item types to include
   * %param [p_cif_default]          Optional default value for the item type
   * %param [p_cif_active]           Flag, das anzeigt, ob dieser Parametertyp verwendet wird. Defaults to ADC_UTIL.C_TRUE
   * %usage  Used to define the ITEM focus of an action
   */
  procedure merge_action_item_focus(
    p_cif_id in adc_action_item_focus.cif_id%type,
    p_cif_name in pit_translatable_item.pti_name%type,
    p_cif_description in pit_translatable_item.pti_description%type,
    p_cif_actual_page_only in adc_action_item_focus.cif_actual_page_only%type default adc_util.C_TRUE,
    p_cif_item_types in adc_action_item_focus.cif_item_types%type,
    p_cif_default adc_action_item_focus.cif_default%type,
    p_cif_active in adc_action_item_focus.cif_active%type default adc_util.C_TRUE);

  procedure merge_action_item_focus(
    p_row in out nocopy adc_action_item_focus_v%rowtype);


  procedure delete_action_item_focus(
    p_cif_id in adc_action_item_focus.cif_id%type);

  procedure delete_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype);

  procedure validate_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype);


  /** Administration of ACTION TYPES
   * %param  p_cat_id               ID of the action type
   * %param  p_cat_ctg_id           Reference to adc_action_type_groups
   * %param  p_cat_cif_id           Reference to ADC_ACTION_ITEM_FOCUS
   * %param  p_cat_name             Name of the action type
   * %param  p_cat_display_name     Verbose name of the action type
   * %param  p_cat_description      Optional description
   * %param  p_cat_pl_sql           PL/SQL code that is to be executed
   * %param  p_cat_js               JavaScript code that is to be executed
   * %param [p_cat_is_editable]     Flag to indicate whether this action type is editable by the end user
   * %param [p_cat_raise_recursive] Flag to indicate whether this action type allow recursive calls of rules
   * %param [p_cat_active]          Flag to indicate whether this action type is actually used
   */    
  procedure merge_action_type(
    p_cat_id in adc_action_types.cat_id%type,
    p_cat_ctg_id in adc_action_type_groups.ctg_id%type,
    p_cat_cif_id in adc_action_item_focus.cif_id%type,
    p_cat_name in pit_translatable_item.pti_name%type,
    p_cat_display_name in pit_translatable_item.pti_display_name%type,
    p_cat_description in pit_translatable_item.pti_description%type default null,
    p_cat_pl_sql in adc_action_types.cat_pl_sql%type,
    p_cat_js in adc_action_types.cat_js%type,
    p_cat_is_editable in adc_action_types.cat_is_editable%type default adc_util.C_TRUE,
    p_cat_raise_recursive in adc_action_types.cat_raise_recursive%type default adc_util.C_TRUE,
    p_cat_active in adc_action_types.cat_active%type default adc_util.C_TRUE);

  procedure merge_action_type(
    p_row in adc_action_types_v%rowtype);

  procedure delete_action_type(
    p_cat_id in adc_action_types.cat_id%type);

  procedure delete_action_type(
    p_row in adc_action_types_v%rowtype);
    
  /**
   * %raises Error-Codes:
   *         CAT_ID_MISSING if parameter P_CAT_ID is NULL
   *         CAT_CTG_ID_MISSING if parameter P_CAT_CTG_ID is NULL
   *         CAT_CIF_ID_MISSING if parameter P_CAT_CIF_ID is NULL
   *         CAT_NAME_MISSING if parameter P_CAT_NAME is NULL
   */
  procedure validate_action_type(
    p_row in adc_action_types_v%rowtype);


  /** Method to export an action type
   * %param  p_cat_is_editable  Controls, which ADC rules to export:
   *                            - C_TRUE: User defined action types
   *                            - C_FALSE: Internally defined action types
   *                            - NULL: Both, internally and user defined action types
   * %usage  Creates a BLOB instance with the requested action types for export
   */
  function export_action_types(
    p_cat_is_editable in adc_action_types.cat_is_editable%type default adc_util.C_TRUE)
    return blob;


  /** Adminsitration of ACTION PARAMETERS
   * %param  p_cap_cat_id      Reference to ADC_ACTION_TYPE
   * %param  p_cap_cpt_id      Reference to adc_action_parameters_TYPE
   * %param  p_cap_sort_seq    Sort order and restriction of number of parameters
   * %param  p_cap_default     Optional standard value of the parameter
   * %param  p_cap_description Optional description
   * %param  p_cap_mandatory   Flag to indicate whether this action parameter is required
   * %param [p_cap_active]     Flag to indicate whether this action parameter is in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_parameter(
    p_cap_cat_id in adc_action_parameters.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters.cap_sort_seq%type,
    p_cap_default in adc_action_parameters.cap_default%type,
    p_cap_description in pit_translatable_item.pti_description%type,
    p_cap_display_name in pit_translatable_item.pti_name%type,
    p_cap_mandatory in adc_action_parameters.cap_mandatory%type,
    p_cap_active in adc_action_parameters.cap_active%type default adc_util.C_TRUE);

  procedure merge_action_parameter(
    p_row in out nocopy adc_action_parameters_v%rowtype);

  procedure delete_action_parameter(
    p_cap_cat_id in adc_action_parameters.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters.cap_sort_seq%type);

  procedure delete_action_parameter(
    p_row in adc_action_parameters_v%rowtype);

  procedure validate_action_parameter(
    p_row in adc_action_parameters_v%rowtype);


  /** Administration of PAGE ITEM TYPES
   * %param  p_cit_id               Technical ID of the item type
   * %param  p_cit_name             Display name
   * %param  p_cit_has_value        Flag to indicate whether this is an item containing a session state value
   * %param  p_cit_include_in_view  Flag to indicate whether this item has to be included in the session state view
   * %param  p_cit_event            Event thas has to be bound if a rule requires this item
   * %param  p_cit_col_template     Template for the session state view to retrieve the session state value
   * %param  p_cit_init_template    Template to get the initial session state value
   */
  procedure merge_page_item_type(
    p_cit_id              in adc_page_item_types_v.cit_id%type,
    p_cit_name            in adc_page_item_types_v.cit_name%type,
    p_cit_has_value       in adc_page_item_types_v.cit_has_value%type,
    p_cit_include_in_view in adc_page_item_types_v.cit_include_in_view%type,
    p_cit_event           in adc_page_item_types_v.cit_event%type,
    p_cit_col_template    in adc_page_item_types_v.cit_col_template%type,
    p_cit_init_template   in adc_page_item_types_v.cit_init_template%type);
    
  procedure merge_page_item_type(
    p_row in out nocopy adc_page_item_types_v%rowtype);

  procedure delete_page_item_type(
    p_row in adc_page_item_types_v%rowtype);
    
  procedure validate_page_item_type(
    p_row in adc_page_item_types_v%rowtype);
    

  /** Administration of RULE ACTIONS
   * %param  p_cra_id               ID of the rule action
   * %param  p_cra_cru_id           Reference to adc_rules
   * %param  p_cra_cgr_id           Reference to adc_rule_groups
   * %param  p_cra_cpi_id           Reference to ADC_PAGE_ITEM
   * %param  p_cra_cat_id           Reference to ADC_ACTION_TYPE
   * %param  p_sort_seq             Sort criteria to organize the order of execution
   * %param [p_cra_param_1]         Optional parameter 1
   * %param [p_cra_param_2]         Optional parameter 2
   * %param [p_cra_param_3]         Optional parameter 3
   * %param [p_cra_on_error]        Flag to indicate whether this action is executed as an error handler for that rule.
   *                                Defaults to ADC_UTIL.C_FALSE
   * %param [p_cra_raise_recursive] Flag to indicate whether this action allows recursive executions of other rules.
   *                                Defaults to ADC_UTIL.C_TRUE
   * %param [p_cra_active]          Flag to indicate whether this rule action is in use. Defaults to ADC_UTIL.C_TRUE
   * %param [p_cra_comment]         Optional developer comment
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type,
    p_cra_cru_id in adc_rules.cru_id%type,
    p_cra_cgr_id in adc_rule_groups.cgr_id%type,
    p_cra_cpi_id in adc_page_items.cpi_id%type,
    p_cra_cat_id in adc_action_types.cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null);

  procedure merge_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype);

  procedure delete_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type);

  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype);

  /** Method to validate a rule action
   * %raises Error Codes
   *         - CRA_CRU_ID_MISSING if Parameter CRA_CRU_ID IS NULL
   *         - CRA_CGR_ID_MISSING if Parameter CRA_CGR_ID IS NULL
   *         - CRA_CPI_ID_MISSING if Parameter CRA_CPI_ID IS NULL
   *         - CRA_CAT_ID_MISSING if Parameter CRA_CAT_ID IS NULL
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype);


  /** Method to add translated data
   * %param  p_table_shortcut  Prefix that is used in the respective table. Will prefix the translated PTI_ID
   * %param  p_item_id         Name of the item for which a translation needs to be added
   * %param  p_pmg_name        Name of the language. One of the Oracle supported language names
   * %param  p_name            Translation for names
   * %param  p_display_name    Translation for display names
   * %param  p_description     Translation for descriptions and help texts
   * %usage  Is used to add translated names and descriptions for existing entries in the tables of ADC
   */
  procedure add_translation(
    p_table_shortcut in varchar2,
    p_item_id in varchar2,
    p_pml_name adc_util.ora_name_type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type);

end adc_admin;
/