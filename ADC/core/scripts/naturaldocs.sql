/**
Table: Tables.ADCA_LU_DESIGNER_ACTIONS
  Lookup for actions the ADC designer supports

Fields:
  alda_id - Technical Key
  alda_name - Display name
  alda_active - Flag to indicate whether this action is actually in use

Table: Tables.ADC_RULE_GROUPS
  Table to store ADC Rule Groups

Fields:
  crg_id - PK, technical key
  crg_app_id - ID of the APEX application the rule group referes to
  crg_page_id - ID of the APEX page the rule group referes to
  crg_decision_table - Decision logic to decide upon the rule to execute based on session state and event meta data
  crg_initialization_code - Generated code to calculate the initial data of page items
  crg_with_recursion - Flag to indicate whether rule group allows recursive execution
  crg_active - Flag to indicate whether rule group is in use

Table: Tables.ADC_RULE_ACTIONS
  Table to store activities per rule

Fields:
  cra_id - PK
  cra_crg_id - Unique, references ADC_RULE
  cra_cru_id - Unique, references ADC_RULE
  cra_cpi_id - Unique, references ADC_PAGE_ITEM
  cra_cat_id - Unique, references ADC_ACTION_TYPE
  cra_on_error - Unique Flag to indicate whether RULE_ACTION shall be executed only in case of PL/SQL error. Defaults to TRUE
  cra_param_1 - Optional first parameter, passed to ACTION_TYPE
  cra_param_2 - Optional second parameter, passed to ACTION_TYPE
  cra_param_3 - Optional third parameter, passed to ACTION_TYPE
  cra_comment - Optional comment to describe the action. Used if something unusual happens.
  cra_raise_recursive - Flag to indicate whether RULE_ACTION triggers recursive rul execution. Defaults to FALSE
  cra_raise_on_validation - Flag to indicate whether this action is executed when validating a page. Defaults to FALSE
  cra_sort_seq - Sorting criteria to control execution flow. Defaults to 10
  cra_active - Flag to indicate whether RULE_ACTION is in use actually. Defaults to TRUE
  cra_has_error - Flag to indicate whether RULE_ACTION has got an error. Defaults to FALSE

Table: Tables.ADC_RULES
  Table to store a single rule

Fields:
  cru_id - PK, technical key
  cru_crg_id - FK, reference to ADC_GROUP
  cru_name - Descriptive Name
  cru_condition - Condition, syntactically in the form of a partial where-clause
  cru_sort_seq - Sort criterion, defines execution order. Defaults to 10
  cru_firing_items - List of page items that are referenced within cru_condition
  cru_active - Flag indicating whether the rule should be used currently. Defaults to TRUE
  cru_fire_on_page_load - Flag indicating whether this rule should be fired when the page is initialized. Defaults to FALSE
  cru_has_error - flag indicating whether this rule contains an error or not. Defaults to FALSE

Table: Tables.ADC_PAGE_ITEM_TYPE_GROUPS
  Table to store page item type groups which are supported by ADC. An item type group is a grouping criteria one or more item types.

Fields:
  cpitg_id - PK, alphanumerical key
  cpitg_has_value - Flag to indicate whether item types of this group contain a session state
  cpitg_include_in_view - Flag to indicate whether item types of this group have to be added to the decision table regardless of whether they contain a session state value.

Table: Tables.ADC_PAGE_ITEM_TYPES
  Table to store page item types which are supported by ADC.

Fields:
  cpit_id - PK, alphanumerical key
  cpit_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cpit_pmg_name - Part of the FK, reference to PIT_TRANSLATABLE_ITEM, criteria to group messages and translatables items per group
  cpit_cpitg_id - Group of the page item type, reference to ADC_PAGE_ITEM_TYPE_GROUPS
  cpit_cet_id - JavaScript event to be bound to this element type by the plugin. If null, ADC won't react on changes.. Reference to PIT_EVENT_TYPES
  cpit_col_template - Template for creating a column in the decision table.
  cpit_init_template - Template for generating the initialization code

Table: Tables.ADC_PAGE_ITEMS
  Table to store all page items of the referenced page

Fields:
  cpi_crg_id - FK, reference to ADC_GROUP
  cpi_id - PK, technical key
  cpi_cpit_id - FK, reference to ADC_APEX_ACTION_TYPE, mapping to a potential APEX action type to assign to this page item
  cpi_caat_id - no comment available
  cpi_label - Item label
  cpi_conversion - Conversion pattern to convert item value to required data type. Requires format mask in APEX to function.
  cpi_item_default - Optional default value as entered in APEX
  cpi_css - CSS classes per page item as entered in APEX
  cpi_is_required - Flag to indicate whether rule conditions reference this item and therefore must be bound by ADC
  cpi_is_mandatory - Flag to indicate whether item is mandatory element and therefore must be checked prior to submitting the page
  cpi_mandatory_message - Message that is emitted if this element is null
  cpi_has_error - Flag to indicate whether actions reference non existent page items

Table: Tables.ADC_EVENT_TYPES
  Table to store page item types which are supported by ADC.

Fields:
  cet_id - PK, alphanumerical key
  cet_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cet_pmg_name - Part of the FK, reference to PIT_TRANSLATABLE_ITEM, criteria to group messages and translatables items per group
  cet_cpitg_id - Reference to ADC_PAGE_ITEM_TYPE_GROUPS
  cet_column_name - Name of the event column in the decision table.
  cet_is_custom_event - Flag to indicate whether this event has to be observed explicitly by a rule action.

Table: Tables.ADC_APEX_ACTION_TYPES
  Table to store the allowed apex action types (ACTION|TOGGLE|RADIO_GROUP)

Fields:
  caat_id - Primary Key. One of the allowed apex action types
  caat_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  caat_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  caat_active - Flag to indicate whether data is actually in use

Table: Tables.ADC_APEX_ACTION_ITEMS
  Table to store initial references between page items and apex actions

Fields:
  caai_caa_id - Part of PK, Refrence to ADC_APEX_ACTION
  caai_cpi_crg_id - Part of PK, Refrence to ADC_PAGE_ITEM
  caai_cpi_id - Part of PK, Refrence to ADC_PAGE_ITEM
  caai_active - Flag to indicate whether page item shall be connected with this action initially

Table: Tables.ADC_APEX_ACTIONS
  Table to store apex actions to be maintained by ADC

Fields:
  caa_id - no comment available
  caa_crg_id - Part of Unique, Reference to ADC_RULE_GROUP
  caa_caat_id - Type of the action. Reference to adc_apex_actions_TYPE
  caa_name - Part of Unique, a unique name for the action within that ADC_RULE_GROPU. By convention the style of names uses a dash to separate words as in clear-log. Name must not contain spaces, >, :, quote, or double quote, or non-printing characters.
  caa_pti_id - no comment available
  caa_pmg_name - no comment available
  caa_icon - The icon for action may be used in buttons and menus
  caa_icon_type - The icon type. Defaults to fa (FontApex). Updates to the iconType may not be supported by all control types that can be associated with actions.
  caa_shortcut - The keyboard shortcut to invoke action (not allowed for radio group actions).
  caa_initially_disabled - Flag to indicate whether this action is initially disabled. Default 0 = initially enabled
  caa_initially_hidden - Flag to indicate whether this action is initially hidded. Default 0 = initially visible
  caa_href - For actions that navigate set href to the URL to navigate to and don't set an action function. An action of type action must have an href or action property set.
  caa_action - function(event, focusElement):boolean The function that is called when the action is invoked with actions#invoke. The action must return true if it sets focus. An action of type action must have an href or action property set.
  caa_on_label - Only for dynamic antonyms toggle actions. This is the label when the value is true.
  caa_off_label - Only for dynamic antonyms toggle actions. This is the label when the value is false.
  caa_get - For toggle actions this function should return true or false. For radio group actions this should return the current value.
  caa_set - For toggle actions this receives a boolean value. For radio group actions this function receives the new value.
  caa_choices - This is only for radio group actions. SQL statement that creates a list of objects. Each object has properties: label, value, icon, iconType, shortcut, disabled, group (for select lists only)
  caa_label_classes - This is only for radio group actions. Classes to add to all radio labels. This and the next two label properties are only used when rendering radio group choices.
  caa_label_start_classes - Only for radio group actions. Classes to add to last radio label
  caa_label_end_classes - Only for radio group actions. Classes to add to last radio label
  caa_item_wrap_class - Only for radio group actions. Classes to add to a span wrapper element. Or to change the span use one of these prefixes: p:, li:, div:, span: For example li:myRadio
  caa_confirm_message_name - no comment available

Table: Tables.ADC_ACTION_TYPE_GROUPS
  Table to store ADC Action Type groups

Fields:
  catg_id - PK, technical key
  catg_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  catg_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  catg_active - Flag to indicate whether rule group is in use

Table: Tables.ADC_ACTION_TYPES
  Tabel to store different action types as template for actions

Fields:
  cat_id - PK, alphanumeric key
  cat_catg_id - FK, Reference to adc_action_types_GROUP, used to group action types on the UI
  cat_caif_id - FK, Reference to ADC_ACTION_ITEM_FOCUS, used to limit the kind of items the action may reference
  cat_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cat_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cat_pl_sql - PL/SQL pattern to implement the functionality in PL/SQL
  cat_js - JavaScript pattern to implement the functionality in JS
  cat_is_editable - Flag to indicate whether developer is allowed to change this action type (others are required by ADC
  cat_raise_recursive - Flag to indicate whether action is executed if recursive level is greater than 1
  cat_active - Flag to indicate whether data is actually in use

Table: Tables.ADC_ACTION_PARAM_VISUAL_TYPES
  Table to store how a parameter type has to be displayed. Options are TEXT, TEXT_AREA, SELECT/STATIC_LIST and SWITCH

Fields:
  capvt_id - PK, technical key
  capvt_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  capvt_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  capvt_sort_seq - Sort criteria
  capvt_active - Flag to indicate whether visual type is in use

Table: Tables.ADC_ACTION_PARAM_TYPES
  Table to store ADC Action Parameter types. Is not maintained by the UI, as entries require package methods for validation

Fields:
  capt_id - PK, technical key
  capt_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  capt_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  capt_capvt_id - Reference to ADC_ACTION_PARAM_VISUAL_TYPES, type of visual control to use for this parameter type
  capt_sort_seq - Sort criteria
  capt_active - Flag to indicate whether parameter type is in use

Table: Tables.ADC_ACTION_PARAMETERS
  Table to store ADC Action Parameters

Fields:
  cap_cat_id - Part of PK, Reference to ADC_ACTION_TYPE
  cap_capt_id - Part of PK, Reference to ADC_ACTION_PARAM_TYPE
  cap_sort_seq - Part of PK, Sort criterium, limits number of attributes according to check constraint. Defaults to 1
  cap_default - Optional default value for parameter
  cap_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cap_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cap_mandatory - Flag to indicate whether action parameter is mandatory for the action type. Defafults to FALSE
  cap_active - Flag to indicate whether action parameter is in use. Defaults to TRUE

Table: Tables.ADC_ACTION_ITEM_FOCUS
  Table to store ADC Action Item focus, used to define the kind of ITEMS that may be referenced by the action. Not maintained by the UI, as entries require Views or logic to populate them.

Fields:
  caif_id - PK, technical key
  caif_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  caif_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  caif_actual_page_only - Flag to indicate whether only items of the actual page should be shown
  caif_item_types - Colon separated list of item types to show
  caif_default - Optional default value for the item focus
  caif_active - Flag to indicate whether rule group is in use

Table: Tables.ADCA_MAP_DESIGNER_ACTIONS
  Decision table for the page state of the ADC designer in response to a combination of Mode and APEX action raised by the user. See <Views.ADC_BL_DESIGNER_ACTION_V>

Fields:
  amda_aldm_id - Reference to ADCA_LU_DESIGNER_MODES, part of PK
  amda_alda_id - Reference to ADCA_LU_DESIGNER_ACTIONSS, part of PK
  amda_comment - Optional comment for the mapping
  amda_id_value - Target mode for create operations
  amda_remember_page_state - Flag to indicate whether switching to this mode requires the actual page state to be saved
  amda_create_button_visible - Flag to indicate whether CREATE action is visible
  amda_create_target_mode - Mode the designer switches to after performing a CREATE
  amda_update_button_visible - Flag to indicate whether UPDATE action is visible
  amda_delete_button_visible - Flag to indicate whether DELETE action is visible
  amda_delete_mode - Mode the designer uses when performing a DELETE
  amda_delete_target_mode - Mode the designer switches to after performing a DELETE
  amda_cancel_button_active - Flag to indicate whether CANCEL action is visible
  amda_cancel_target_mode - Mode the designer switches to after performing a CANCEL

Table: Tables.ADCA_LU_DESIGNER_MODES
  Lookup for modes the ADC designer can be at

Fields:
  aldm_id - Technical Key
  aldm_name - Display name
  aldm_active - Flag to indicate whether this mode is actually in use

View: Views.ADCA_BL_CAT_HELP
  Business logic view to put together a help text for the UI Designer

Fields:
  cat_id - ID of the action type, reference to <Tables.ADC_ACTION_TYPES>
  help_text - Translated and combined help text from the action type, their parameters and other sources.

View: Views.ADCA_BL_DESIGNER_ACTIONS
      This view enriches the data from the decision table <Tables.ADCA_MAP_DESIGNER_ACTIONS> with translated label data and
    session state information, such as the actual page and region prefix.    
    The decision is based on a mode the ADC Designer is actually in and the command to execute. As an example, if the
    designer shows a rule group, because the user clicked on a dynamic page in the tree control, The mode is CGR and the
    command is SHOW. Based on this information, this view is queried and the status and labels of the respective buttons
    are taken and sent to the page. The decision table also defines the target mode to switch to if a button is clicked.    
    If the user decides to click the CREATE button in the ADC Designer, this then is interpreted as target mode CRU and
    the command is CREATE-ACTION. This again filters this view, controling the state of the buttons and labels as well
    as the target modes of the buttons.

Fields:
  amda_actual_mode - Mode the designer has to move to, fi. when showing a rule, the mode is CRU.
  amda_actual_id - Name of the command that was executed (either an apex action name or SHOW) Together with AMDA_ACTUAL_MODE, this decides on the row to execute.
  amda_comment - Comment explaining the use case of the specific row.
  amda_id_value - Actual ID of the asset shown.
  amda_form_id - ID of the form to show next.
  amda_remember_page_state - Flag to indicate whether the form to show next needs to survey element changes.
  amda_create_button_visible - Flag to indicate whether the create button is visible.
  amda_create_button_label - Label fo the create button, translated.
  amda_create_target_mode - Mode to enter if the create button is pressed.
  amda_update_button_visible - Flag to indicate whether the upddate button is visible.
  amda_update_button_label - Label fo the update button, translated.
  amda_update_target_mode - Mode to enter if the update button is pressed.
  amda_update_value - ID of the asset to update.
  amda_delete_button_visible - Flag to indicate whether the delete button is visible.
  amda_delete_button_label - Label fo the delete button, translated.
  amda_delete_mode - Actual mode when the delete button was pressed.
  amda_delete_target_mode - Mode to enter if the delete button is pressed.
  amda_delete_confirm_message - Translated message for the confirm dialog of the delete action
  amda_delete_value - ID of the asset to delete.
  amda_cancel_button_active - Flag to indicate whether the cancel button is visible.
  amda_cancel_target_mode - Mode to enter if the cancel button is pressed.
  amda_cancel_value - ID of the asset to return to after the dialog was canceled.

View: Views.ADCA_UI_ADMIN_CAIF
  View for APEX report page ADMIN_CIF

Fields:
  caif_id - no comment available
  caif_name - no comment available
  caif_description - no comment available
  caif_actual_page_only - no comment available
  caif_active - no comment available

View: Views.ADCA_UI_ADMIN_CAPT
  View for APEX report page ADMIN_CAPT

Fields:
  capt_id - no comment available
  capt_name - no comment available
  capt_active - no comment available
  capt_parameter_type - no comment available

View: Views.ADCA_UI_ADMIN_CAT
  View for page ADMIN_CAT

Fields:
  catg_name - no comment available
  cat_id - no comment available
  cat_name - no comment available
  cat_is_editable - no comment available
  cat_pl_sql - no comment available
  cat_js - no comment available
  cat_description - no comment available
  link_icon - no comment available
  link_target - no comment available

View: Views.ADCA_UI_DESIGNER_APEX_ACTION
  View on ADC_APEX_ACTION.

Fields:
  caa_id - no comment available
  caa_crg_id - no comment available
  caa_caat_id - no comment available
  caa_name - no comment available
  caa_label - no comment available
  caa_context_label - no comment available
  caa_confirm_message_name - no comment available
  caa_icon - no comment available
  caa_icon_type - no comment available
  caa_title - no comment available
  caa_shortcut - no comment available
  caa_initially_disabled - no comment available
  caa_initially_hidden - no comment available
  caa_href - no comment available
  caa_action - no comment available
  caa_on_label - no comment available
  caa_off_label - no comment available
  caa_get - no comment available
  caa_set - no comment available
  caa_choices - no comment available
  caa_label_classes - no comment available
  caa_label_start_classes - no comment available
  caa_label_end_classes - no comment available
  caa_item_wrap_class - no comment available
  caa_caai_list - no comment available

View: Views.ADCA_UI_DESIGNER_FINDINGS
  Analysis of the actually selected rule group. Displays violations of quality assurance rules

Fields:
  link - no comment available
  icon - no comment available
  message - no comment available
  title - no comment available
  region_icon - no comment available

View: Views.ADCA_UI_DESIGNER_RULE
  Edit data for a rule

Fields:
  cru_id - no comment available
  cru_crg_id - no comment available
  cru_name - no comment available
  cru_condition - no comment available
  cru_sort_seq - no comment available
  cru_active - no comment available
  cru_fire_on_page_load - no comment available

View: Views.ADCA_UI_DESIGNER_RULES
  Overview over all rules of a rule group including a summary of the rule actions

Fields:
  application_name - no comment available
  page_name - no comment available
  cru_id - no comment available
  cru_crg_id - no comment available
  cru_name - no comment available
  cru_condition - no comment available
  cru_firing_items - no comment available
  cru_sort_seq - no comment available
  cru_fire_on_page_load - no comment available
  cru_fire_on_page_load_title - no comment available
  cru_active - no comment available
  cru_action - no comment available

View: Views.ADCA_UI_DESIGNER_RULE_ACTION
  Actual parameter values for a rule action, divided for the visualization types SELEWCT_LIST, TEXT_AREA, TEXT and SWITCH

Fields:
  cra_id - no comment available
  cra_crg_id - no comment available
  cra_cru_id - no comment available
  cra_cpi_id - no comment available
  cra_cat_id - no comment available
  cra_on_error - no comment available
  cra_param_1 - no comment available
  cra_param_lov_1 - no comment available
  cra_param_area_1 - no comment available
  cra_param_switch_1 - no comment available
  cra_param_2 - no comment available
  cra_param_lov_2 - no comment available
  cra_param_area_2 - no comment available
  cra_param_switch_2 - no comment available
  cra_param_3 - no comment available
  cra_param_lov_3 - no comment available
  cra_param_area_3 - no comment available
  cra_param_switch_3 - no comment available
  cra_comment - no comment available
  cra_raise_recursive - no comment available
  cra_raise_on_validation - no comment available
  cra_sort_seq - no comment available
  cra_active - no comment available

View: Views.ADCA_UI_DESIGNER_RULE_GROUP
  Form data including an overview over the rule and a switch to disable the rule group

Fields:
  crg_active - no comment available
  cru_amt - no comment available
  cra_amt - no comment available
  caa_amt - no comment available
  firing_items - no comment available

View: Views.ADCA_UI_DESIGNER_TREE
  Hierarchical representation of rule groups with their related rules and rule actions

Fields:
  status - no comment available
  lvl - no comment available
  title - no comment available
  icon - no comment available
  value - no comment available
  tooltip - no comment available
  link - no comment available

View: Views.ADCA_UI_EDIT_CAIF
  View for APEX page EDIT_CIF

Fields:
  caif_id - no comment available
  caif_name - no comment available
  caif_description - no comment available
  caif_actual_page_only - no comment available
  caif_item_types - no comment available
  caif_active - no comment available
  ref_amount - no comment available
  allowed_operations - no comment available

View: Views.ADCA_UI_EDIT_CAPT
  View for APEX page EDIT_CAPT

Fields:
  capt_id - no comment available
  capt_name - no comment available
  capt_display_name - no comment available
  capt_description - no comment available
  capt_capvt_id - no comment available
  capt_select_list_query - no comment available
  capt_select_view_comment - no comment available
  capt_active - no comment available
  capt_sort_seq - no comment available

View: Views.ADCA_UI_EDIT_CAPT_STATIC_LIST
  View for APEX page EDIT_CPT, Static values for a list

Fields:
  csl_capt_id - no comment available
  csl_pti_id - no comment available
  csl_name - no comment available

View: Views.ADCA_UI_EDIT_CAT
  View for APEX page EDIT_CAF

Fields:
  cat_id - no comment available
  cat_catg_id - no comment available
  cat_caif_id - no comment available
  cat_name - no comment available
  cat_display_name - no comment available
  cat_description - no comment available
  cat_pl_sql - no comment available
  cat_js - no comment available
  cat_is_editable - no comment available
  cat_raise_recursive - no comment available
  cat_active - no comment available
  cap_capt_id_1 - no comment available
  cap_display_name_1 - no comment available
  cap_description_1 - no comment available
  cap_default_1 - no comment available
  cap_mandatory_1 - no comment available
  cap_active_1 - no comment available
  cap_capt_id_2 - no comment available
  cap_display_name_2 - no comment available
  cap_description_2 - no comment available
  cap_default_2 - no comment available
  cap_mandatory_2 - no comment available
  cap_active_2 - no comment available
  cap_capt_id_3 - no comment available
  cap_display_name_3 - no comment available
  cap_description_3 - no comment available
  cap_default_3 - no comment available
  cap_mandatory_3 - no comment available
  cap_active_3 - no comment available

View: Views.ADCA_UI_EDIT_CATG
  View for APEX page EDIT_CATG

Fields:
  catg_id - no comment available
  catg_name - no comment available
  catg_description - no comment available
  catg_active - no comment available
  allowed_operations - no comment available

View: Views.ADCA_UI_EDIT_CPIT
  View for APEX page EDIT_CPIT

Fields:
  cpit_id - no comment available
  cpit_name - no comment available
  cpit_cpitg_id - no comment available
  cpit_has_value - no comment available
  cpit_include_in_view - no comment available
  cpit_cet_id - no comment available
  cpit_col_template - no comment available
  cpit_init_template - no comment available
  ref_amount - no comment available
  allowed_operations - no comment available

View: Views.ADCA_UI_LIST_ACTION_TYPE
  List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.

Fields:
  d - Display value
  r - Return value
  grp - no comment available

View: Views.ADCA_UI_LOV_ACTION_ITEM_FOCUS
  

Fields:
  d - Display value
  r - Return value
  caif_active - no comment available

View: Views.ADCA_UI_LOV_ACTION_PARAM_TYPE
  

Fields:
  d - Display value
  r - Return value
  capt_active - no comment available
  capt_sort_seq - no comment available

View: Views.ADCA_UI_LOV_ACTION_PARAM_VISUAL_TYPE
  LOV-View for ADC_ACTION_PARAM_VISUAL_TYPE

Fields:
  d - Display value
  r - Return value
  capvt_active - no comment available
  capvt_sort_seq - no comment available

View: Views.ADCA_UI_LOV_ACTION_TYPE_GROUP
  

Fields:
  d - Display value
  r - Return value
  catg_active - no comment available

View: Views.ADCA_UI_LOV_APEX_ACTION_ITEMS
  

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available
  cpi_caat_id - no comment available

View: Views.ADCA_UI_LOV_APEX_ACTION_TYPE
  

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_APPLICATIONS
  LOV view that displays all user defined APEX applications. Application ADC is excluded, unless the user is Administrator

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_APP_PAGES
  

Fields:
  d - Display value
  r - Return value
  application_id - no comment available

View: Views.ADCA_UI_LOV_CRG_APPLICATIONS
  

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_CRG_APP_PAGES
  

Fields:
  d - Display value
  r - Return value
  crg_app_id - no comment available

View: Views.ADCA_UI_LOV_CRG_PAGE_ITEMS
  Collection of all page items that are usable for the selected ADC action type

Fields:
  d - Display value
  r - Return value
  grp - no comment available

View: Views.ADCA_UI_LOV_EXPORT_CAT
  

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_EXPORT_TYPES
  

Fields:
  d - Display value
  r - Return value
  sort_seq - no comment available

View: Views.ADCA_UI_LOV_ITEM_TYPES
  LOV View for the item types referenced in ADC_ACTION_ITEM_FOCUS

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_PAGE_ITEMS
  

Fields:
  d - Display value
  r - Return value
  app_id - no comment available
  page_id - no comment available

View: Views.ADCA_UI_LOV_PAGE_ITEMS_P11
  

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_PAGE_ITEM_TYPE
  LOV view for all page item types.

Fields:
  d - Display value
  r - Return value
  is_event - no comment available

View: Views.ADCA_UI_LOV_PAGE_ITEM_TYPE_GROUP
  LOV-Views for page item types

Fields:
  d - Display value
  r - Return value

View: Views.ADCA_UI_LOV_YES_NO
  

Fields:
  d - Display value
  r - Return value

View: Views.ADC_ACTION_ITEM_FOCUS_V
  Wrapper with with translated column values

Fields:
  caif_id - no comment available
  caif_name - no comment available
  caif_description - no comment available
  caif_actual_page_only - no comment available
  caif_item_types - no comment available
  caif_default - no comment available
  caif_active - no comment available

View: Views.ADC_ACTION_PARAMETERS_V
  

Fields:
  cap_cat_id - no comment available
  cap_capt_id - no comment available
  cap_display_name - no comment available
  cap_description - no comment available
  cap_sort_seq - no comment available
  cap_default - no comment available
  cap_mandatory - no comment available
  cap_active - no comment available

View: Views.ADC_ACTION_PARAM_TYPES_V
  Wrapper with with translated column values

Fields:
  capt_id - no comment available
  capt_name - no comment available
  capt_display_name - no comment available
  capt_description - no comment available
  capt_capvt_id - no comment available
  capt_select_list_query - no comment available
  capt_select_view_comment - no comment available
  capt_sort_seq - no comment available
  capt_active - no comment available

View: Views.ADC_ACTION_PARAM_VISUAL_TYPES_V
  Wrapper with with translated column values

Fields:
  capvt_id - no comment available
  capvt_name - no comment available
  capvt_display_name - no comment available
  capvt_description - no comment available
  capvt_sort_seq - no comment available
  capvt_active - no comment available

View: Views.ADC_ACTION_TYPES_V
  Wrapper with with translated column values

Fields:
  cat_id - no comment available
  cat_catg_id - no comment available
  cat_caif_id - no comment available
  cat_name - no comment available
  cat_display_name - no comment available
  cat_description - no comment available
  cat_pl_sql - no comment available
  cat_js - no comment available
  cat_is_editable - no comment available
  cat_raise_recursive - no comment available
  cat_active - no comment available

View: Views.ADC_ACTION_TYPE_GROUPS_V
  

Fields:
  catg_id - no comment available
  catg_name - no comment available
  catg_description - no comment available
  catg_active - no comment available

View: Views.ADC_APEX_ACTIONS_V
  

Fields:
  caa_id - no comment available
  caa_crg_id - no comment available
  caa_caat_id - no comment available
  caa_name - no comment available
  caa_label - no comment available
  caa_context_label - no comment available
  caa_confirm_message_name - no comment available
  caa_icon - no comment available
  caa_icon_type - no comment available
  caa_title - no comment available
  caa_shortcut - no comment available
  caa_initially_disabled - no comment available
  caa_initially_hidden - no comment available
  caa_href - no comment available
  caa_action - no comment available
  caa_on_label - no comment available
  caa_off_label - no comment available
  caa_get - no comment available
  caa_set - no comment available
  caa_choices - no comment available
  caa_label_classes - no comment available
  caa_label_start_classes - no comment available
  caa_label_end_classes - no comment available
  caa_item_wrap_class - no comment available
  caa_pti_id - no comment available

View: Views.ADC_APEX_ACTION_TYPES_V
  

Fields:
  caat_id - no comment available
  caat_name - no comment available
  caat_description - no comment available
  caat_active - no comment available

View: Views.ADC_BL_PAGE_ITEMS
  View to collect metadata from the APEX dictionary for all ADC supported kinds of page items

Fields:
  item_name - Name of the page item, along with its translated item type
  item_id - Static ID of the page item
  app_id - APEX application ID
  page_id - APEX application page ID
  item_type - Type of the page ITEM

View: Views.ADC_BL_PAGE_TARGETS
  View to collect all page components that are accessible by ADC, along with an item type categorization for grouping in ITEM_FOCUS etc.

Fields:
  cpi_crg_id - ID to the rule group
  cpi_id - Static ID to the page item
  cpi_cpit_id - Item type of the page item, reference to ADC_PAGE_ITEM_TYPES
  cpi_cpitg_id - Item group of the page item, reference to ADC_PAGE_ITEM_TYPE_GROUPS
  cpi_caat_id - Optional APEX action type of the page item, if an APEX action, reference to ADC_APEX_ACTION_TYPES
  cpi_label - Label of the page item
  cpi_conversion - Optional format mask of the page item
  cpi_item_default - Optional default item value for a mandatory item
  cpi_css - Any CSS class attatched to the page item, separated by |-signs
  cpi_is_mandatory - Flag to indicate whether this page item is initially mandatory. Taken from the APEX metadata
  cpi_is_required - Flag to indicate whether this page item is necessary for ADC. A page item is necessary, if ADC has to react on item value changes

View: Views.ADC_BL_RULES
  View to collect common data for rules and their respective actions. Is used as the basis for ADC to execute the rule logic

Fields:
  cru_id - ID of the rule, reference to <Tables.ADC_RULES>
  crg_id - ID of the rule group, reference to <Tables.ADC_RULE_GROUPS>
  cru_sort_seq - Sort criteria of the rule
  cru_name - Name of the rule
  cru_firing_items - List of page items that are considered firing, separated by comma
  cru_fire_on_page_load - Flag to indicate whether this rule should be considere upon page initialization additionally to the initialize rule
  cra_raise_recursive - Flag to indicate whether this rule allows for recursive execution
  cra_cpi_id - Page item the rule action refers to, reference to <Tables.ADC_PAGE_ITEMS>
  item_css - All CSS classes attached to the page item
  cra_cat_id - ADC action type of the action. Reference to <Tables.ADC_ACTION_TYPES>
  cra_param_1 - Actual value of parameter 1 of the action
  cra_param_2 - Actual value of parameter 2 of the action
  cra_param_3 - Actual value of parameter 3 of the action
  cra_on_error - Flag to indicate whether this action is an error handler
  cra_sort_seq - Sort criteria of the action

View: Views.ADC_EVENT_TYPES_V
  Transated view on ADC_EVENT_TYPES

Fields:
  cet_id - no comment available
  cet_name - no comment available
  cet_cpitg_id - no comment available
  cet_column_name - no comment available
  cet_is_custom_event - no comment available

View: Views.ADC_PAGE_ITEM_TYPES_V
  Transated view on ADC_PAGE_ITEM_TYPES

Fields:
  cpit_id - no comment available
  cpit_name - no comment available
  cpit_cpitg_id - no comment available
  cpit_has_value - no comment available
  cpit_include_in_view - no comment available
  cpit_cet_id - no comment available
  cpit_col_template - no comment available
  cpit_init_template - no comment available

View: Views.ADC_PARAM_LOV_APEX_ACTION
  

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_EVENT
  Parameterview to display all custom events

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_ITEM_STATUS
  List of translatable items of for that parameter type

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_PAGE_ITEM
  List of page items, limited to input fields, grouped by crg_ID

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_PIT_MESSAGE
  List of PIT messages

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_SEQUENCE
  List of sequences owned by the user

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_PARAM_LOV_SUBMIT_TYPE
  List of translatable items of type ADC, related to the SUBMIT_TYPE

Fields:
  d - Display value
  r - Return value
  crg_id - no comment available

View: Views.ADC_RULE_GROUP_STATUS
  Wrapper view around the apex collection containing the list of mandatory items

Fields:
  cgs_crg_id - CRG_ID of the mandatory items list
  cgs_id - Collection PK (SEQ_ID)
  cgs_cpi_id - ID of the page item
  cgs_cpi_label - Label of the page item
  cgs_cpi_mandatory_message - Message to display if the page item violates the mandatory rule
  
*/