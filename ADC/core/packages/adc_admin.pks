create or replace package adc_admin
  authid definer
as

  /**
    Package: ADC_ADMIN
      Main package to administer ADC metadata.
      Legacy wrapper methods for exported movement-data scripts remain for
      backward compatibility.

    Author::
      Juergen Sieben, ConDeS GmbH

   */

  -- Group: Constants
  /**
    Constants: Public Constants
      C_ALL_GROUPS - Export all ADC groups
      C_APEX_APP - Export all ADC groups of an APEX application including the application itself
      C_APP_GROUPS - Export all ADC group of an APEX application
      C_PAGE_GROUP - Export a single ADC group
      
      C_EXPORT_USER - Export all user defined action types
      C_EXPORT_SYSTEM - Export all ADC defined action types
      C_EXPORT_ALL - Export ADC and user defined action types
  */
  C_ALL_GROUPS constant adc_util.ora_name_type := 'ALL_GROUPS';
  C_APEX_APP constant adc_util.ora_name_type := 'APEX_APP';
  C_APP_GROUPS constant adc_util.ora_name_type := 'APP_GROUPS';
  C_PAGE_GROUP constant adc_util.ora_name_type := 'PAGE_GROUP';
  
  C_EXPORT_USER constant adc_util.ora_name_type := 'CAT_EXPORT_USER';
  C_EXPORT_SYSTEM constant adc_util.ora_name_type := 'CAT_EXPORT_SYSTEM';
  C_EXPORT_ALL constant adc_util.ora_name_type := 'CAT_EXPORT_ALL';

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
    p_pml_name in adc_util.ora_name_type,
    p_name in pit_translatable_item_v.pti_name%type,
    p_display_name in pit_translatable_item_v.pti_display_name%type,
    p_description in pit_translatable_item_v.pti_description%type);
    
  -- Group: Action Type Methods
  /**
    Procedure: merge_action_type_group
      Administration of ACTION TYPE GROUPS
                 
    Parameters:
      p_catg_id - ID of the action type group
      p_catg_name - Name of the action type group
      p_catg_description - Optional description of the action type group
      p_catg_active - Flag to indicate whether this action type group is actually in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_type_group(
    p_catg_id in adc_action_type_groups_v.catg_id%type,
    p_catg_name in adc_action_type_groups_v.catg_name%type,
    p_catg_description in adc_action_type_groups_v.catg_description%type,
    p_catg_active in adc_action_type_groups_v.catg_active%type default adc_util.C_TRUE);

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
      p_catg_id - ID of the action type group to delete
   */
  procedure delete_action_type_group(
    p_catg_id in adc_action_type_groups_v.catg_id%type);

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
      CATG_ID_MISSING - if parameter P_ROW.CATG_ID is null
      CATG_NAME_MISSING - if parameter P_ROW.CATG_NAME is null
   */
  procedure validate_action_type_group(
    p_row in adc_action_type_groups_v%rowtype);
    
    
  /**
    Procedure: merge_action_type_owner
      Administration of ACTION TYPE OWNERS
                 
    Parameters:
      p_cato_id - ID of the action type owner
      p_cato_description - Optional description of the action type owner
      p_cato_active - Flag to indicate whether this action type owner is actually in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_type_owner(
    p_cato_id in adc_action_type_owners_v.cato_id%type,
    p_cato_description in adc_action_type_owners_v.cato_description%type,
    p_cato_active in adc_action_type_owners_v.cato_active%type default adc_util.C_TRUE);

  /**
    Procedure: merge_action_type_owner
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_type_owner(
    p_row in out nocopy adc_action_type_owners_v%rowtype);

  /**
    Procedure: delete_action_type_owner
      Overload with a row record
                 
    Parameter:
      p_cato_id - ID of the action type owner to delete
   */
  procedure delete_action_type_owner(
    p_cato_id in adc_action_type_owners_v.cato_id%type);

  /**
    Procedure: delete_action_type_owner
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_type_owner(
    p_row in adc_action_type_owners_v%rowtype);

  /**
    Procedure: validate_action_type_owner
      Validates an Action Type Owner
                 
    Parameter:
      p_row - Row record
      
    Errors:
      CATO_ID_MISSING - if parameter P_ROW.CATO_ID is null
   */
  procedure validate_action_type_owner(
    p_row in adc_action_type_owners_v%rowtype);


  /**
    Procedure: merge_action_param_visual_type
      Administration of ACTION PARAMETER VISUAL TYPES.
      
      The visual types control how the parameter is displayed on the UI, whether it
      is shown as a text input field, a select list or a switch.
                 
    Parameters:
      p_capvt_id - ID of the action visual type
      p_capvt_name - Name of the action visual type
      p_capvt_display_name - Display name of the action visual type
      p_capvt_description - Optional description
      p_capvt_param_item_extension - Extension for the parameter item on the page
      p_capt_sort_seq - Optional sort criteria
      p_capvt_active - Flag to indicate whether this action parameter type is used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_param_visual_type(
    p_capvt_id in adc_action_param_visual_types_v.capvt_id%type,
    p_capvt_name in adc_action_param_visual_types_v.capvt_name%type,
    p_capvt_display_name in adc_action_param_visual_types_v.capvt_display_name%type default null,
    p_capvt_description in adc_action_param_visual_types_v.capvt_description%type default null,
    p_capvt_param_item_extension in adc_action_param_visual_types_v.capvt_param_item_extension%type default null,
    p_capvt_sort_seq in adc_action_param_visual_types_v.capvt_sort_seq%type default 10,
    p_capvt_active in adc_action_param_visual_types_v.capvt_active%type default ADC_UTIL.C_TRUE);

  /**
    Procedure: merge_action_param_visual_type
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_action_param_visual_type(
    p_row in out nocopy adc_action_param_visual_types_v%rowtype);

  /**
    Procedure: delete_action_param_visual_type
      Overload with a row record
                 
    Parameter:
      p_capvt_id - ID of the Action Parameter Type to delete
   */
  procedure delete_action_param_visual_type(
    p_capvt_id in adc_action_param_visual_types_v.capvt_id%type);

  /**
    Procedure: delete_action_param_visual_type
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_action_param_visual_type(
    p_row in adc_action_param_visual_types_v%rowtype);
    
  /**
    Procedure: validate_action_param_visual_type
      Validates and Action Parameter Type
                 
    Errors:
      msg.ADC_PARAM_LOV_MISSING - if LOV view is required but missing
      msg.ADC_PARAM_LOV_INCORRECT - if required LOV view exists but with the wrong structure
      capvt_ID_MISSING - if parameter P_capvt_ID is NULL
      capvt_NAME_MISSING - if parameter P_capvt_NAME is NULL
      capvt_ITEM_TYPE_MISSING - if parameter p_capvt_capvt_id is NULL
   */
  procedure validate_action_param_visual_type(
    p_row in adc_action_param_visual_types_v%rowtype);
    

  /**
    Procedure: merge_action_param_type
      Administration of ACTION PARAMETER TYPES
                 
    Parameters:
      p_capt_id - ID of the action parameter type
      p_capt_name - Name of the action parameter type
      p_capt_display_name - Display name of the action parameter type
      p_capt_description - Optional description
      p_capt_capvt_id - Reference to <ADC_ACTION_PARAM_VISUAL_TYPES>, controls how the parameter is displayed visually.
                     
                     If set to SELECT_LIST or STATIC_LIST, a view of name ADC_PARAM_LOV_<CAPT_ID> must be provided to calculate
                     the available values. This list may be filtered using CRG_ID.
      p_capt_select_list_query - Optional select statement for the parameter value list
      p_capt_select_view_comment - Optional comment for the select/static_list view
      p_capt_sort_seq - Optional sort criteria
      p_capt_active - Flag to indicate whether this action parameter type is used. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_param_type(
    p_capt_id in adc_action_param_types_v.capt_id%type,
    p_capt_name in adc_action_param_types_v.capt_name%type,
    p_capt_display_name in adc_action_param_types_v.capt_display_name%type default null,
    p_capt_description in adc_action_param_types_v.capt_description%type default null,
    p_capt_capvt_id in adc_action_param_types_v.capt_capvt_id%type default 'TEXT',
    p_capt_select_list_query in adc_action_param_types_v.capt_select_list_query%type default null, 
    p_capt_select_view_comment in adc_action_param_types_v.capt_select_view_comment%type default null,
    p_capt_sort_seq in adc_action_param_types_v.capt_sort_seq%type default 10,
    p_capt_active in adc_action_param_types_v.capt_active%type default ADC_UTIL.C_TRUE);

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
      p_capt_id - ID of the Action Parameter Type to delete
   */
  procedure delete_action_param_type(
    p_capt_id in adc_action_param_types_v.capt_id%type);

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
      Validates and Action Parameter Type
                 
    Errors:
      msg.ADC_PARAM_LOV_MISSING - if LOV view is required but missing
      msg.ADC_PARAM_LOV_INCORRECT - if required LOV view exists but with the wrong structure
      CAPT_ID_MISSING - if parameter P_CAPT_ID is NULL
      CAPT_NAME_MISSING - if parameter P_CAPT_NAME is NULL
      CAPT_ITEM_TYPE_MISSING - if parameter p_capt_capvt_id is NULL
   */
  procedure validate_action_param_type(
    p_row in adc_action_param_types_v%rowtype);
    

  /**
    Procedure: merge_action_item_focus
      Method for generating an ITEM focus. Used to define the ITEM focus of an action
                 
    Parameters:
      p_caif_id - ID of the item focus
      p_caif_name - Name of the item focus
      p_caif_description - Optional description
      p_caif_actual_page_only - Flag to indicate whether only items from the actual APEX page are recognized
      p_caif_item_types - List of item types to include
      p_caif_default - Optional default value for the item type
      p_caif_active - Flag, das anzeigt, ob dieser Parametertyp verwendet wird. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_item_focus(
    p_caif_id in adc_action_item_focus_v.caif_id%type,
    p_caif_name in adc_action_item_focus_v.caif_name%type,
    p_caif_description in adc_action_item_focus_v.caif_description%type,
    p_caif_actual_page_only in adc_action_item_focus_v.caif_actual_page_only%type default adc_util.C_TRUE,
    p_caif_item_types in adc_action_item_focus_v.caif_item_types%type,
    p_caif_default adc_action_item_focus_v.caif_default%type,
    p_caif_active in adc_action_item_focus_v.caif_active%type default adc_util.C_TRUE);

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
      p_caif_id - ID of the Action Item Focus to delete
   */
  procedure delete_action_item_focus(
    p_caif_id in adc_action_item_focus_v.caif_id%type);

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
      p_cat_catg_id - Reference to adc_action_type_groups
      p_cat_caif_id - Reference to ADC_ACTION_ITEM_FOCUS
      p_cat_cato_id - Reference to ADC_ACTION_TYPE_OWNERS. Defaults to ADC
      p_cat_name - Name of the action type
      p_cat_display_name - Optional verbose name of the action type
      p_cat_description - Optional description
      p_cat_pl_sql - PL/SQL code that is to be executed
      p_cat_js - JavaScript code that is to be executed
      p_cat_is_editable - Optional flag to indicate whether this action type is editable by the end user. Defaults to adc_util.C_TRUE.
      p_cat_raise_recursive - Optional flag to indicate whether this action type allow recursive calls of rules. Defaults to adc_util.C_TRUE.
      p_cat_active] - Optional flag to indicate whether this action type is actually used. Defaults to adc_util.C_TRUE.
   */    
  procedure merge_action_type(
    p_cat_id in adc_action_types_v.cat_id%type,
    p_cat_catg_id in adc_action_types_v.cat_catg_id%type,
    p_cat_caif_id in adc_action_types_v.cat_caif_id%type,
    p_cat_cato_id in adc_action_types_v.cat_cato_id%type default 'ADC',
    p_cat_name in adc_action_types_v.cat_name%type,
    p_cat_display_name in adc_action_types_v.cat_display_name%type default null,
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
    p_row in out nocopy adc_action_types_v%rowtype);

  /**
    Procedure: delete_action_type
      Deletes an Action Type
                 
    Parameter:
      p_cat_id - ID of the action type to delete
   */
  procedure delete_action_type(
    p_cat_id in adc_action_types_v.cat_id%type);

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
      CAT_CATG_ID_MISSING - if parameter P_CAT_CATG_ID is NULL
      CAT_CAIF_ID_MISSING - if parameter P_CAT_CAIF_ID is NULL
      CAT_NAME_MISSING - if parameter P_CAT_NAME is NULL
   */
  procedure validate_action_type(
    p_row in adc_action_types_v%rowtype);


  /**
    Function: export_action_types
      Method to export an action type. Creates a BLOB instance with the requested action types for export.
                
    Parameter:
      p_mode - Controls, which ADC rules to export:
      
               - C_EXPORT_USER: User defined action types
               - C_EXPORT_SYSTEM: Internally defined action types
               - C_EXPORT_ALL: Both, internally and user defined action types
   */
  function export_action_types(
    p_mode in varchar2)
    return blob;


  /**
    Procedure: merge_action_parameter
      Adminsitration of ACTION PARAMETERS
                 
    Parameters:
      p_cap_cat_id - Reference to ADC_ACTION_TYPE
      p_cap_capt_id - Reference to adc_action_parameters_TYPE
      p_cap_sort_seq - Sort order and restriction of number of parameters. Defaults to 1
      p_cap_default - Optional standard value of the parameter
      p_cap_description - Optional description
      p_cap_display_name - Optional display name of the Action Type
      p_cap_mandatory - Flag to indicate whether this action parameter is required. Defaults to ADC_UTIL.C_FALSE
      p_cap_active - Optional flag to indicate whether this action parameter is in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_capt_id in adc_action_parameters_v.cap_capt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type default 1,
    p_cap_default in adc_action_parameters_v.cap_default%type,
    p_cap_description in adc_action_parameters_v.cap_description%type,
    p_cap_display_name in adc_action_parameters_v.cap_display_name%type,
    p_cap_mandatory in adc_action_parameters_v.cap_mandatory%type default adc_util.C_FALSE,
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
      p_cap_capt_id - ID of the Parameter Type the parameter belongs to
      p_cap_sort_seq - Sort sequence of the parameter
   */
  procedure delete_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_capt_id in adc_action_parameters_v.cap_capt_id%type,
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
    Procedure: merge_page_item_type_group
      Administration of PAGE ITEM TYPE GROUPS
                 
    Parameters:
      p_cpitg_id - Technical ID of the item type
      p_cpitg_has_value - Flag to indicate whether this is an item containing a session state value. Defaults to ADC_UTIL.C_TRUE
      p_cpitg_include_in_view - Flag to indicate whether this item has to be included in the session state view. Defaults to ADC_UTIL.C_FALSE
   */
  procedure merge_page_item_type_group(
    p_cpitg_id              in adc_page_item_type_groups.cpitg_id%type,
    p_cpitg_has_value       in adc_page_item_type_groups.cpitg_has_value%type default adc_util.C_TRUE,
    p_cpitg_include_in_view in adc_page_item_type_groups.cpitg_include_in_view%type default adc_util.C_FALSE);
    
  /**
    Procedure: merge_page_item_type_group
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_page_item_type_group(
    p_row in out nocopy adc_page_item_type_groups%rowtype);

  /**
    Procedure: delete_page_item_type_group
      Deletes a Page Item Type Group
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_page_item_type_group(
    p_row in adc_page_item_type_groups%rowtype);
    
  /**
    Procedure: validate_page_item_type_group
      Validates an Page Item Type
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_page_item_type_group(
    p_row in adc_page_item_type_groups%rowtype);


  /**
    Procedure: merge_event_type
      Administration of EVENT TYPES
                 
    Parameters:
      p_cet_id - Name of the event. Used as a PK. Must be written exactly as the JavaScript event name
      p_cet_name - ID of the translatable Item for that event
      p_cet_column_name - Name of the column under which the firing item for that event is accessible
      p_cet_is_custom_event - Flag to indicate whether this event must be monitored explicitly by ADC. Defaults to ADC_UTIL.C_FALSE
   */
  procedure merge_event_type(
    p_cet_id in adc_event_types_v.cet_id%type,
    p_cet_name in adc_event_types_v.cet_name%type,
    p_cet_column_name in adc_event_types_v.cet_column_name%type,
    p_cet_is_custom_event in adc_event_types_v.cet_is_custom_event%type default adc_util.C_FALSE);
    
  /**
    Procedure: merge_event_type
      Overload with a row record
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_event_type(
    p_row in out nocopy adc_event_types_v%rowtype);

  /**
    Procedure: delete_event_type
      Deletes a Page Item Type Group
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_event_type(
    p_row in adc_event_types_v%rowtype);
    
  /**
    Procedure: validate_event_type
      Validates an Page Item Type
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_event_type(
    p_row in adc_event_types_v%rowtype);


  /**
    Procedure: merge_page_item_type
      Administration of PAGE ITEM TYPES
                 
    Parameters:
      p_cpit_id - Technical ID of the item type
      p_cpit_name - Display name
      p_cpit_cpitg_id - Grouping of the page item type, Reference to <PAGE_ITEM_TYPE_GROUPS>
      p_cpit_cet_id - Event thas has to be bound if a rule requires this item
      p_cpit_col_template - Template for the session state view to retrieve the session state value
      p_cpit_init_template . Template to get the initial session state value
   */
  procedure merge_page_item_type(
    p_cpit_id in adc_page_item_types_v.cpit_id%type,
    p_cpit_name in adc_page_item_types_v.cpit_name%type,
    p_cpit_cpitg_id in adc_page_item_types_v.cpit_cpitg_id%type,
    p_cpit_cet_id in adc_page_item_types_v.cpit_cet_id%type,
    p_cpit_col_template in adc_page_item_types_v.cpit_col_template%type,
    p_cpit_init_template in adc_page_item_types_v.cpit_init_template%type);
    
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
    

  -- Group: APEX Action Methods
  /**
    Procedure: merge_apex_action_type
      Administration of APEX ACTION TYPES
                 
    Parameters:
      p_caat_id - Technical ID
      p_caat_display_name - Display name of the action type
      p_caat_description - Description
      p_caat_active - Flag to indicate whether this action type is in use. Defaults to ADC_UTIL.C_TRUE
   */
  procedure merge_apex_action_type(
    p_caat_id in adc_apex_action_types_v.caat_id%type,
    p_caat_name in adc_apex_action_types_v.caat_name%type,
    p_caat_description in adc_apex_action_types_v.caat_description%type,
    p_caat_active in adc_apex_action_types_v.caat_active%type default adc_util.C_TRUE);

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
      p_caat_id - ID of the APEX Action Type
   */
  procedure delete_apex_action_type(
    p_caat_id in adc_apex_action_types_v.caat_id%type);

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
    Procedure: merge_standard_message
      Administration of ADC standard messages
                 
    Parameters:
      p_csm_name - Unique name of the standard message. Must begin with CSM_
      p_csm_message - Message to display. Max length is 200 characters
      p_csm_desription - Optional description to explain when this message is used
   */
  procedure merge_standard_message(
    p_csm_id in adc_standard_messages_v.csm_id%type,
    p_csm_message in adc_standard_messages_v.csm_message%type,
    p_csm_description in adc_standard_messages_v.csm_description%type default null);

  /**
    Procedure: merge_standard_message
      Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure merge_standard_message(
    p_row in out nocopy adc_standard_messages_v%rowtype);

  /**
    Procedure: delete_standard_message
      Deletes an APEX Action Item
                 
    Parameter:
      p_csm_id - ID of the APEX Action Item to delete
   */
  procedure delete_standard_message(
    p_csm_id in adc_standard_messages_v.csm_id%type);

  /**
    Procedure: delete_standard_message
      Overload with a row record.
                 
    Parameter:
      p_row - Row record
   */
  procedure delete_standard_message(
    p_row in adc_standard_messages_v%rowtype);

  /**
    Procedure: validate_standard_message
      Validates an APEX Action Item
                 
    Parameter:
      p_row - Row record
   */
  procedure validate_standard_message(
    p_row in adc_standard_messages_v%rowtype);

  -- Group: Deprecated Config Wrappers
  /**
    These wrappers exist only for compatibility with previously exported
    movement-data scripts. New code must use ADC_CONFIG directly.
    For documentation of the methods and parameters, please refer to ADC_CONFIG.
   */
   
  function map_id(
    p_id in number default null)
    return number;
  pragma deprecate(map_id, 'Use ADC_CONFIG.MAP_ID instead.');


  procedure merge_rule_group(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type,
    p_crg_id in adc_rule_groups.crg_id%type default null,
    p_crg_with_recursion in adc_rule_groups.crg_with_recursion%type default adc_util.C_TRUE,
    p_crg_active in adc_rule_groups.crg_active%type default adc_util.C_TRUE);
  pragma deprecate(merge_rule_group, 'Use ADC_CONFIG.MERGE_RULE_GROUP instead.');


  procedure delete_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type);
  pragma deprecate(delete_rule_group, 'Use ADC_CONFIG.DELETE_RULE_GROUP instead.');


  procedure propagate_rule_change(
    p_crg_id in adc_rule_groups.crg_id%type);
  pragma deprecate(propagate_rule_change, 'Use ADC_CONFIG.PROPAGATE_RULE_CHANGE instead.');


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2);
  pragma deprecate(prepare_rule_group_import, 'Use ADC_CONFIG.PREPARE_RULE_GROUP_IMPORT instead.');


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.crg_app_id%type);
  pragma deprecate(prepare_rule_group_import, 'Use ADC_CONFIG.PREPARE_RULE_GROUP_IMPORT instead.');


  procedure prepare_rule_group_import(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type);
  pragma deprecate(prepare_rule_group_import, 'Use ADC_CONFIG.PREPARE_RULE_GROUP_IMPORT instead.');


  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_crg_id in adc_rules.cru_crg_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type default adc_util.C_FALSE,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type default 10,
    p_cru_active in adc_rules.cru_active%type default adc_util.C_TRUE);
  pragma deprecate(merge_rule, 'Use ADC_CONFIG.MERGE_RULE instead.');


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
  pragma deprecate(merge_rule_action, 'Use ADC_CONFIG.MERGE_RULE_ACTION instead.');


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
  pragma deprecate(merge_apex_action, 'Use ADC_CONFIG.MERGE_APEX_ACTION instead.');


  procedure merge_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type,
    p_caai_cpi_crg_id in adc_apex_action_items.caai_cpi_crg_id%type,
    p_caai_cpi_id in adc_apex_action_items.caai_cpi_id%type,
    p_caai_active in adc_apex_action_items.caai_active%type default adc_util.C_TRUE);
  pragma deprecate(merge_apex_action_item, 'Use ADC_CONFIG.MERGE_APEX_ACTION_ITEM instead.');

end adc_admin;
/
