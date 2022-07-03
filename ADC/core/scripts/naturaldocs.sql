/**
Table: Tables.ADC_ACTION_ITEM_FOCUS
  Table to store ADC Action Item focus, used to define the kind of ITEMS that may be referenced by the action. Not maintained by the UI, as entries require Views or logic to populate them.

Fields:
  cif_id - PK, technical key
  cif_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cif_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cif_actual_page_only - Flag to indicate whether only items of the actual page should be shown
  cif_item_types - Optional default value for the item focus
  cif_default - no comment available
  cif_active - Flag to indicate whether rule group is in use

Table: Tables.ADC_UI_MAP_DESIGNER_ACTIONS
  Decision table for the page state of the ADC designer in response to a combination of Mode and APEX action raised by the user. See <Views.ADC_BL_DESIGNER_ACTION_V>

Fields:
  mda_alm_id - Reference to ADC_LU_DESIGNER_MODES, part of PK
  mda_ald_id - Reference to ADC_LU_DESIGNER_ACTIONSS, part of PK
  mda_comment - Optional comment for the mapping
  mda_id_value - Target mode for create operations
  mda_remember_page_state - Flag to indicate whether switching to this mode requires the actual page state to be saved
  mda_create_button_visible - Flag to indicate whether CREATE action is visible
  mda_create_target_mode - Mode the designer switches to after performing a CREATE
  mda_update_button_visible - Flag to indicate whether UPDATE action is visible
  mda_delete_button_visible - Flag to indicate whether DELETE action is visible
  mda_delete_mode - Mode the designer uses when performing a DELETE
  mda_delete_target_mode - Mode the designer switches to after performing a DELETE
  mda_cancel_button_active - Flag to indicate whether CANCEL action is visible
  mda_cancel_target_mode - Mode the designer switches to after performing a CANCEL

Table: Tables.ADC_RULE_GROUPS
  Table to store ADC Rule Groups

Fields:
  cgr_id - PK, technical key
  cgr_app_id - ID of the APEX application the rule group referes to
  cgr_page_id - ID of the APEX page the rule group referes to
  cgr_decision_table - Decision logic to decide upon the rule to execute based on session state and event meta data
  cgr_initialization_code - Generated code to calculate the initial data of page items
  cgr_with_recursion - Flag to indicate whether rule group allows recursive execution
  cgr_active - Flag to indicate whether rule group is in use

Table: Tables.ADC_RULE_ACTIONS
  Table to store activities per rule

Fields:
  cra_id - PK
  cra_cgr_id - Unique, references ADC_RULE
  cra_cru_id - Unique, references ADC_RULE
  cra_cpi_id - Unique, references ADC_PAGE_ITEM
  cra_cat_id - Unique, references ADC_ACTION_TYPE
  cra_on_error - Unique Flag to indicate whether RULE_ACTION shall be executed only in case of PL/SQL error
  cra_param_1 - Optional first parameter, passed to ACTION_TYPE
  cra_param_2 - Optional second parameter, passed to ACTION_TYPE
  cra_param_3 - Optional third parameter, passed to ACTION_TYPE
  cra_comment - Optional comment to describe the action. Used if something unusual happens.
  cra_raise_recursive - Flag to indicate whether this action is executed when validating a page
  cra_raise_on_validation - no comment available
  cra_sort_seq - Sorting criteria to control execution flow
  cra_active - Flag to indicate whether RULE_ACTION is in use actually
  cra_has_error - Flag to indicate whether RULE_ACTION has got an error

Table: Tables.ADC_RULES
  Table to store a single rule

Fields:
  cru_id - PK, technical key
  cru_cgr_id - FK, reference to ADC_GROUP
  cru_name - Descriptive Name
  cru_condition - Condition, syntactically in the form of a partial where-clause
  cru_sort_seq - Sortierkriterium, definiert Ausführungsreihenfolge
  cru_firing_items - List of page items that are referenced within cru_condition
  cru_active - Flag, das anzeigt, ob die Regel aktuell verwendet werden soll
  cru_fire_on_page_load - Flag, das anzeigt, ob diese Regel beim Initialisiern der Seite gefeuert werden soll
  cru_has_error - Flag, das anzeigt, ob diese Regel einen Fehler enthaelt oder nicht

Table: Tables.ADC_PAGE_ITEM_TYPE_GROUPS
  Table to store page item type groups which are supported by ADC. An item type group is a grouping criteria one or more item types.

Fields:
  cig_id - PK, alphanumerical key
  cig_has_value - Flag to indicate whether item types of this group contain a session state
  cig_include_in_view - Flag to indicate whether item types of this group have to be added to the decision table regardless of whether they contain a session state value.

Table: Tables.ADC_PAGE_ITEM_TYPES
  Table to store page item types which are supported by ADC.

Fields:
  cit_id - PK, alphanumerical key
  cit_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cit_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cit_event - JavaScript event to be bound to this element type by the plugin. If null, ADC won't react on changes.
  cit_col_template - Template for creating a column in the decision table.
  cit_init_template - Flag to indicate whether this event has to be observed explicitly by a rule action.
  cit_is_custom_event - no comment available
  cit_cig_id - Group of the item type, reference to ADC_PAGE_ITEM_TYPE_GROUPS

Table: Tables.ADC_PAGE_ITEMS
  Table to store all page items of the referenced page

Fields:
  cpi_cgr_id - FK, reference to ADC_GROUP
  cpi_id - PK, technical key
  cpi_cit_id - FK, reference to ADC_APEX_ACTION_TYPE, mapping to a potential APEX action type to assign to this page item
  cpi_cty_id - no comment available
  cpi_label - Item label
  cpi_conversion - Conversion pattern to convert item value to required data type. Requires format mask in APEX to function.
  cpi_item_default - Optional default value as entered in APEX
  cpi_css - CSS classes per page item as entered in APEX
  cpi_is_required - Flag to indicate whether rule conditions reference this item and therefore must be bound by ADC
  cpi_is_mandatory - Flag to indicate whether item is mandatory element and therefore must be checked prior to submitting the page
  cpi_mandatory_message - Message that is emitted if this element is null
  cpi_has_error - Flag to indicate whether actions reference non existent page items

Table: Tables.ADC_LU_DESIGNER_MODES
  Lookup for modes the ADC designer can be at

Fields:
  alm_id - Technical Key
  alm_name - Display name
  alm_active - Flag to indicate whether this mode is actually in use

Table: Tables.ADC_LU_DESIGNER_ACTIONS
  Lookup for actions the ADC designer supports

Fields:
  ald_id - Technical Key
  ald_name - Display name
  ald_active - Flag to indicate whether this action is actually in use

Table: Tables.ADC_APEX_ACTION_TYPES
  Table to store the allowed apex action types (ACTION|TOGGLE|RADIO_GROUP)

Fields:
  cty_id - Primary Key. One of the allowed apex action types
  cty_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cty_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cty_active - Flag to indicate whether data is actually in use

Table: Tables.ADC_APEX_ACTION_ITEMS
  Table to store initial references between page items and apex actions

Fields:
  cai_caa_id - Part of PK, Refrence to ADC_APEX_ACTION
  cai_cpi_cgr_id - Part of PK, Refrence to ADC_PAGE_ITEM
  cai_cpi_id - Part of PK, Refrence to ADC_PAGE_ITEM
  cai_active - Flag to indicate whether page item shall be connected with this action initially

Table: Tables.ADC_APEX_ACTIONS
  Table to store apex actions to be maintained by ADC

Fields:
  caa_id - no comment available
  caa_cgr_id - Part of Unique, Reference to ADC_RULE_GROUP
  caa_cty_id - Type of the action. Reference to adc_apex_actions_TYPE
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

Table: Tables.ADC_ACTION_TYPE_GROUPS
  Table to store ADC Action Type groups

Fields:
  ctg_id - PK, technical key
  ctg_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  ctg_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  ctg_active - Flag to indicate whether rule group is in use

Table: Tables.ADC_ACTION_TYPES
  Tabel to store different action types as template for actions

Fields:
  cat_id - PK, alphanumeric key
  cat_ctg_id - FK, Reference to adc_action_types_GROUP, used to group action types on the UI
  cat_cif_id - FK, Reference to ADC_ACTION_ITEM_FOCUS, used to limit the kind of items the action may reference
  cat_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cat_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cat_pl_sql - PL/SQL pattern to implement the functionality in PL/SQL
  cat_js - JavaScript pattern to implement the functionality in JS
  cat_is_editable - Flag to indicate whether developer is allowed to change this action type (others are required by ADC
  cat_raise_recursive - Flag to indicate whether action is executed if recursive level is greater than 1
  cat_active - Flag to indicate whether data is actually in use

Table: Tables.ADC_ACTION_PARAM_VISUAL_TYPES
  Table to store how a parameter type has to be displayed. Options are TEXT, TEXT_AREA, SELECT_LIST and SWITCH

Fields:
  cpv_id - PK, technical key
  cpv_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cpv_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cpv_active - Flag to indicate whether visual type is in use
  cpv_sort_seq - no comment available

Table: Tables.ADC_ACTION_PARAM_TYPES
  Table to store ADC Action Parameter types. Is not maintained by the UI, as entries require package methods for validation

Fields:
  cpt_id - PK, technical key
  cpt_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cpt_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cpt_cpv_id - Reference to ADC_ACTION_PARAM_VISUAL_TYPES, type of visual control to use for this parameter type
  cpt_active - Flag to indicate whether parameter type is in use
  cpt_sort_seq - Sort criteria

Table: Tables.ADC_ACTION_PARAMETERS
  Table to store ADC Action Parameters

Fields:
  cap_cat_id - Part of PK, Reference to ADC_ACTION_TYPE
  cap_cpt_id - Part of PK, Reference to ADC_ACTION_PARAM_TYPE
  cap_sort_seq - Part of PK, Sort criterium, limits number of attributes according to check constraint
  cap_default - Optional default value for parameter
  cap_pti_id - Reference to PIT_TRANSLATABLE_ITEM, translatable NAME
  cap_pmg_name - Reference to PIT_TRANSLATABLE_ITEM, Fixed value ADC
  cap_mandatory - Flag to indicate whether action parameter is mandatory for the action type
  cap_active - Flag to indicate whether action parameter is in use

View: Views.ADC_ACTION_ITEM_FOCUS_V
  Wrapper with with translated column values

Fields:
  cif_id - no comment available
  cif_name - no comment available
  cif_description - no comment available
  cif_actual_page_only - no comment available
  cif_item_types - no comment available
  cif_default - no comment available
  cif_active - no comment available

View: Views.ADC_ACTION_PARAMETERS_V
  

Fields:
  cap_cat_id - no comment available
  cap_cpt_id - no comment available
  cap_display_name - no comment available
  cap_description - no comment available
  cap_sort_seq - no comment available
  cap_default - no comment available
  cap_mandatory - no comment available
  cap_active - no comment available

View: Views.ADC_ACTION_PARAM_TYPES_V
  Wrapper with with translated column values

Fields:
  cpt_id - no comment available
  cpt_name - no comment available
  cpt_display_name - no comment available
  cpt_description - no comment available
  cpt_cpv_id - no comment available
  cpt_select_list_query - no comment available
  cpt_select_view_comment - no comment available
  cpt_sort_seq - no comment available
  cpt_active - no comment available

View: Views.ADC_ACTION_PARAM_VISUAL_TYPES_V
  Wrapper with with translated column values

Fields:
  cpv_id - no comment available
  cpv_name - no comment available
  cpv_display_name - no comment available
  cpv_description - no comment available
  cpv_sort_seq - no comment available
  cpv_active - no comment available

View: Views.ADC_ACTION_TYPES_V
  Wrapper with with translated column values

Fields:
  cat_id - no comment available
  cat_ctg_id - no comment available
  cat_cif_id - no comment available
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
  ctg_id - no comment available
  ctg_name - no comment available
  ctg_description - no comment available
  ctg_active - no comment available

View: Views.ADC_APEX_ACTIONS_V
  

Fields:
  caa_id - no comment available
  caa_cgr_id - no comment available
  caa_cty_id - no comment available
  caa_name - no comment available
  caa_label - no comment available
  caa_context_label - no comment available
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
  cty_id - no comment available
  cty_name - no comment available
  cty_description - no comment available
  cty_active - no comment available

View: Views.ADC_BL_CAT_HELP
  

Fields:
  cat_id - no comment available
  help_text - no comment available

View: Views.ADC_BL_DESIGNER_ACTION_V
      This view enriches the data from the decision table <Tables.ADC_UI_MAP_DESIGNER_ACTIONS> with translated label data and
    session state information, such as the actual page and region prefix.    
    The decision is based on a mode the ADC Designer is actually in and the command to execute. As an example, if the
    designer shows a rule group, because the user clicked on a dynamic page in the tree control, The mode is CGR and the
    command is SHOW. Based on this information, this view is queried and the status and labels of the respective buttons
    are taken and sent to the page. The decision table also defines the target mode to switch to if a button is clicked.    
    If the user decides to click the CREATE button in the ADC Designer, this then is interpreted as target mode CRU and
    the command is CREATE-ACTION. This again filters this view, controling the state of the buttons and labels as well
    as the target modes of the buttons.

Fields:
  mda_actual_mode - Mode the designer is in actually, fi. when showing a rule, the mode is CRU.
  mda_actual_id - Name of the command to execute (or show) Together with MDA_ACTUAL_MODE, this decides on the row to execute.
  mda_comment - Comment explaining the use case of the specific row.
  mda_id_value - Actual ID of the asset shown.
  mda_form_id - ID of the form to show next.
  mda_remember_page_state - Flag to indicate whether the form to show next needs to survey element changes.
  mda_create_button_visible - Flag to indicate whether the create button is visible.
  mda_create_button_label - Label fo the create button, translated.
  mda_create_target_mode - Mode to enter if the create button is pressed.
  mda_update_button_visible - Flag to indicate whether the upddate button is visible.
  mda_update_button_label - Label fo the update button, translated.
  mda_update_target_mode - Mode to enter if the update button is pressed.
  mda_update_value - ID of the asset to update.
  mda_delete_button_visible - Flag to indicate whether the delete button is visible.
  mda_delete_button_label - Label fo the delete button, translated.
  mda_delete_mode - Actual mode when the delete button was pressed.
  mda_delete_target_mode - Mode to enter if the delete button is pressed.
  mda_delete_value - ID of the asset to delete.
  mda_cancel_button_active - Flag to indicate whether the cancel button is visible.
  mda_cancel_target_mode - Mode to enter if the cancel button is pressed.
  mda_cancel_value - ID of the asset to return to after the dialog was canceled.

View: Views.ADC_BL_PAGE_ITEMS
  

Fields:
  item_name - no comment available
  item_id - no comment available
  app_id - no comment available
  page_id - no comment available
  item_type - no comment available

View: Views.ADC_BL_PAGE_TARGETS
  View to collect all page components that are accessible by ADC, along with an item type categorization for grouping in ITEM_FOCUS etc.

Fields:
  cpi_cgr_id - no comment available
  cpi_id - no comment available
  cpi_cit_id - no comment available
  cpi_cig_id - no comment available
  cpi_cty_id - no comment available
  cpi_label - no comment available
  cpi_conversion - no comment available
  cpi_item_default - no comment available
  cpi_css - no comment available
  cpi_is_mandatory - no comment available
  cpi_is_required - no comment available

View: Views.ADC_BL_RULES
  

Fields:
  cru_id - no comment available
  cgr_id - no comment available
  cru_sort_seq - no comment available
  cru_name - no comment available
  cru_firing_items - no comment available
  cru_fire_on_page_load - no comment available
  cra_raise_recursive - no comment available
  cra_cpi_id - no comment available
  item_css - no comment available
  cra_cat_id - no comment available
  cra_param_1 - no comment available
  cra_param_2 - no comment available
  cra_param_3 - no comment available
  cra_on_error - no comment available
  cra_sort_seq - no comment available

View: Views.ADC_PAGE_ITEM_TYPES_V
  Transated view on ADC_PAGE_ITEM_TYPES

Fields:
  cit_id - no comment available
  cit_name - no comment available
  cit_cig_id - no comment available
  cit_has_value - no comment available
  cit_include_in_view - no comment available
  cit_event - no comment available
  cit_col_template - no comment available
  cit_init_template - no comment available
  cit_is_custom_event - no comment available

View: Views.ADC_PARAM_LOV_APEX_ACTION
  List of apex actions, grouped by CGR_ID

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_EVENT
  Parameterview to display all custom events

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_ITEM_STATUS
  List of translatable items of for that parameter type

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_PAGE_ITEM
  List of page items, limited to input fields, grouped by CGR_ID

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_PIT_MESSAGE
  List of PIT messages

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_SEQUENCE
  List of sequences owned by the user

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_PARAM_LOV_SUBMIT_TYPE
  List of translatable items of type ADC, related to the SUBMIT_TYPE

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available

View: Views.ADC_RULE_GROUP_STATUS
  Wrapper view around the apex collection containing the list of mandatory items

Fields:
  cgs_cgr_id - no comment available
  cgs_id - no comment available
  cgs_cpi_id - no comment available
  cgs_cpi_label - no comment available
  cgs_cpi_mandatory_message - no comment available

View: Views.ADC_UI_ADMIN_CAT
  View for page ADMIN_CAT

Fields:
  ctg_name - no comment available
  cat_id - no comment available
  cat_name - no comment available
  cat_is_editable - no comment available
  cat_pl_sql - no comment available
  cat_js - no comment available
  cat_description - no comment available
  link_icon - no comment available
  link_target - no comment available

View: Views.ADC_UI_ADMIN_CIF
  View for APEX report page ADMIN_SIF

Fields:
  cif_id - no comment available
  cif_name - no comment available
  cif_description - no comment available
  cif_actual_page_only - no comment available
  cif_active - no comment available

View: Views.ADC_UI_ADMIN_CPT
  View for APEX report page ADMIN_CPT

Fields:
  cpt_id - no comment available
  cpt_name - no comment available
  cpt_active - no comment available
  cpt_parameter_type - no comment available

View: Views.ADC_UI_DESIGNER_APEX_ACTION
  View on ADC_APEX_ACTION.

Fields:
  caa_id - no comment available
  caa_cgr_id - no comment available
  caa_cty_id - no comment available
  caa_name - no comment available
  caa_label - no comment available
  caa_context_label - no comment available
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
  caa_cai_list - no comment available

View: Views.ADC_UI_DESIGNER_FINDINGS
  Analysis of the actually selected rule group. Displays violations of quality assurance rules

Fields:
  link - no comment available
  icon - no comment available
  message - no comment available
  title - no comment available
  region_icon - no comment available

View: Views.ADC_UI_DESIGNER_FLOWS
  

Fields:
  diagram_id - no comment available
  diagram_name - no comment available
  diagram_version - no comment available
  diagram_status_id - no comment available
  diagram_category - no comment available

View: Views.ADC_UI_DESIGNER_RULE
  Edit data for a rule

Fields:
  cru_id - no comment available
  cru_cgr_id - no comment available
  cru_name - no comment available
  cru_condition - no comment available
  cru_sort_seq - no comment available
  cru_active - no comment available
  cru_fire_on_page_load - no comment available

View: Views.ADC_UI_DESIGNER_RULES
  Overview over all rules of a rule group including a summary of the rule actions

Fields:
  application_name - no comment available
  page_name - no comment available
  cru_id - no comment available
  cru_cgr_id - no comment available
  cru_name - no comment available
  cru_condition - no comment available
  cru_firing_items - no comment available
  cru_sort_seq - no comment available
  cru_fire_on_page_load - no comment available
  cru_fire_on_page_load_title - no comment available
  cru_active - no comment available
  cru_action - no comment available

View: Views.ADC_UI_DESIGNER_RULE_ACTION
  Actual parameter values for a rule action, divided for the visualization types SELEWCT_LIST, TEXT_AREA, TEXT and SWITCH

Fields:
  cra_id - no comment available
  cra_cgr_id - no comment available
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
  cra_sort_seq - no comment available
  cra_active - no comment available

View: Views.ADC_UI_DESIGNER_RULE_GROUP
  Form data including an overview over the rule and a switch to disable the rule group

Fields:
  cgr_active - no comment available
  cru_amt - no comment available
  cra_amt - no comment available
  caa_amt - no comment available
  firing_items - no comment available

View: Views.ADC_UI_DESIGNER_TREE
  Hierarchical representation of rule groups with their related rules and rule actions

Fields:
  status - no comment available
  lvl - no comment available
  title - no comment available
  icon - no comment available
  value - no comment available
  tooltip - no comment available
  link - no comment available

View: Views.ADC_UI_EDIT_CAT
  View for APEX page EDIT_CAF

Fields:
  cat_id - no comment available
  cat_ctg_id - no comment available
  cat_cif_id - no comment available
  cat_name - no comment available
  cat_display_name - no comment available
  cat_description - no comment available
  cat_pl_sql - no comment available
  cat_js - no comment available
  cat_is_editable - no comment available
  cat_raise_recursive - no comment available
  cat_active - no comment available
  cap_cpt_id_1 - no comment available
  cap_display_name_1 - no comment available
  cap_description_1 - no comment available
  cap_default_1 - no comment available
  cap_mandatory_1 - no comment available
  cap_active_1 - no comment available
  cap_cpt_id_2 - no comment available
  cap_display_name_2 - no comment available
  cap_description_2 - no comment available
  cap_default_2 - no comment available
  cap_mandatory_2 - no comment available
  cap_active_2 - no comment available
  cap_cpt_id_3 - no comment available
  cap_display_name_3 - no comment available
  cap_description_3 - no comment available
  cap_default_3 - no comment available
  cap_mandatory_3 - no comment available
  cap_active_3 - no comment available

View: Views.ADC_UI_EDIT_CIF
  View for APEX page EDIT_SIF

Fields:
  cif_id - no comment available
  cif_name - no comment available
  cif_description - no comment available
  cif_actual_page_only - no comment available
  cif_item_types - no comment available
  cif_active - no comment available
  ref_amount - no comment available
  allowed_operations - no comment available

View: Views.ADC_UI_EDIT_CPT
  View for APEX page EDIT_CPT

Fields:
  cpt_id - no comment available
  cpt_name - no comment available
  cpt_display_name - no comment available
  cpt_description - no comment available
  cpt_cpv_id - no comment available
  cpt_select_list_query - no comment available
  cpt_select_view_comment - no comment available
  cpt_active - no comment available
  cpt_sort_seq - no comment available

View: Views.ADC_UI_EDIT_CPT_STATIC_LIST
  View for APEX page EDIT_CPT, Static values for a list

Fields:
  csl_cpt_id - no comment available
  csl_pti_id - no comment available
  csl_name - no comment available

View: Views.ADC_UI_EDIT_CTG
  View for APEX page EDIT_CTG

Fields:
  ctg_id - no comment available
  ctg_name - no comment available
  ctg_description - no comment available
  ctg_active - no comment available
  allowed_operations - no comment available

View: Views.ADC_UI_EDIT_DESIGNER_MAP
  

Fields:
  mda_alm_id - no comment available
  mda_ald_id - no comment available
  mda_comment - no comment available
  mda_id_value - no comment available
  mda_remember_page_state - no comment available
  mda_create_button_visible - no comment available
  mda_create_target_mode - no comment available
  mda_update_button_visible - no comment available
  mda_delete_button_visible - no comment available
  mda_delete_mode - no comment available
  mda_delete_target_mode - no comment available
  mda_cancel_button_active - no comment available
  mda_cancel_target_mode - no comment available

View: Views.ADC_UI_LIST_ACTION_TYPE
  List of all rule action types which have an item focus that exists on the page referenced by the rule group. This means, that an action related to a region is only displayed if at least one region is present on the page.

Fields:
  d - Display value
  r - Return value
  grp - no comment available

View: Views.ADC_UI_LOV_ACTION_ITEM_FOCUS
  

Fields:
  d - Display value
  r - Return value
  cif_active - no comment available

View: Views.ADC_UI_LOV_ACTION_PARAM_TYPE
  

Fields:
  d - Display value
  r - Return value
  cpt_active - no comment available
  cpt_sort_seq - no comment available

View: Views.ADC_UI_LOV_ACTION_PARAM_VISUAL_TYPE
  LOV-View for ADC_ACTION_PARAM_VISUAL_TYPE

Fields:
  d - Display value
  r - Return value
  cpv_active - no comment available
  cpv_sort_seq - no comment available

View: Views.ADC_UI_LOV_ACTION_TYPE_GROUP
  

Fields:
  d - Display value
  r - Return value
  ctg_active - no comment available

View: Views.ADC_UI_LOV_ALD
  

Fields:
  r - Return value
  d - Display value

View: Views.ADC_UI_LOV_ALM
  

Fields:
  r - Return value
  d - Display value

View: Views.ADC_UI_LOV_APEX_ACTION_ITEMS
  

Fields:
  d - Display value
  r - Return value
  cgr_id - no comment available
  cpi_cty_id - no comment available

View: Views.ADC_UI_LOV_APEX_ACTION_TYPE
  

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_APPLICATIONS
  LOV view that displays all user defined APEX applications. Application ADC is excluded, unless the user is Administrator

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_APP_PAGES
  

Fields:
  d - Display value
  r - Return value
  application_id - no comment available

View: Views.ADC_UI_LOV_CGR_APPLICATIONS
  

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_CGR_APP_PAGES
  

Fields:
  d - Display value
  r - Return value
  cgr_app_id - no comment available

View: Views.ADC_UI_LOV_CGR_PAGE_ITEMS
  Collection of all page items that are usable for the selected ADC action type

Fields:
  d - Display value
  r - Return value
  grp - no comment available

View: Views.ADC_UI_LOV_EXPORT_CAT
  

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_EXPORT_TYPES
  

Fields:
  d - Display value
  r - Return value
  sort_seq - no comment available

View: Views.ADC_UI_LOV_ITEM_TYPES
  LOV View for the item types referenced in ADC_ACTION_ITEM_FOCUS

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_PAGE_ITEMS
  

Fields:
  d - Display value
  r - Return value
  app_id - no comment available
  page_id - no comment available

View: Views.ADC_UI_LOV_PAGE_ITEMS_P11
  

Fields:
  d - Display value
  r - Return value

View: Views.ADC_UI_LOV_PAGE_ITEM_TYPE
  LOV view for all page item types.

Fields:
  d - Display value
  r - Return value
  is_event - no comment available

View: Views.ADC_UI_LOV_YES_NO
  

Fields:
  d - Display value
  r - Return value
*/