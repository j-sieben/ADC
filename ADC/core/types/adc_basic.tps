create or replace type adc_basic force
  authid definer
as object (

  /**
    Type: ADC_BASIC
      Implements the public interface of ADC and a wrapper around ADC_API.EXECUTE_ACTION for system defined action types.
      Is called by ADC dynamic pages declaratively and directly from PL/SQL.
      
      This type wraps the action type which are delivered with ADC and which are callable by PL/SQL.
      
      They are not called from this type directly but by means of type ADC which inherits from this type. This way, it is
      easy to extend ADC with custom functionality by adding these methods to type ADC and implement them in type body ADC.
      
      If a new version of ADC ships, it is save to create this package and all system delivered action types are accessible
      through type ADC due to the inheritance without overwriting the custom extensions.

    Author::
      Juergen Sieben, ConDeS GmbH
   */

  foo char(1 byte),
     
  /**
    Group: Public constants 
      Implemented as function to be available for SQL
      
      C_HIDE - Status to hide a page item
      C_SHOW_ENABLE - Status to show and enable a page item
      C_SHOW_DISABLE - Status to show and disable a page item
   */
  static function C_HIDE
  return varchar2,
  
  static function C_SHOW_ENABLE
  return varchar2,
  
  static function C_SHOW_DISABLE
  return varchar2,
  
  
  /**
    Group: Public methods
   */
  /**
    Procedure: add_javascript
      Registers JavaScript code for execution. 
      Is used if PL/SQL code that is part of the application logic needs to register JavaScript for execution. 
      In that case, EXECUTE_JAVASCRIPT may not be as elegant to use.

    Parameters:
      p_javascript - JavaScript to execute on page
   */
  static procedure add_javascript(
    p_javascript in varchar2),
    
    
  /**
    Procedure: clear_page_state
      Method to clear the ADC page state for the actual page
   */
  static procedure clear_page_state,
  
  
  /**
    Procedure: confirm_click
      Registers a confirmation message prior to raising the click event.

    Parameters:
      p_javascript - JavaScript to execute on page
   */
  static procedure confirm_click(
    p_button_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_dialog_title in varchar2 default null),


  /** 
    Procedure: exclusive_or
      Method to assure that exactly one or at most one page item of a selection of page items contains a value.
      Is used to assert that at least one page item of a list of items contains a value. If an error is raised, this
      can be used to proceed with an exception handler within the ADC rule.
                 
    Parameters:
      p_cpi_id - Page item ID that is selected to show the error message
      p_value_list - List of page item IDs to check
      p_message - Optional PIT message name to show if the method throws an error. Defaults to 'ASSERTION_FAILED'
      p_error_on_null - Optional flag to indicate whether an error has to be thrown if all page items are NULL. Defaults to C_FALSE
      
    Errors:
      ASSERTION_FAILED_ERR - more than one page item is NOT NULL or all page items are NULL and P_ERROR_ON_NULL is set to C_TRUE
      MSG.<P_MESSAGE>_ERR - same as before, but here the custom message passed in as a parameter is thrown
   */
  static procedure exclusive_or(
    p_cpi_id in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default 'ASSERTION_FAILED',
    p_error_on_null in varchar2 default 1),


  /** Function: exclusive_or
        Function overload. Is used to be able to utilize EXCLUSIVE_OR within an ADC rule condition (used in SQL)
                
    Parameters: 
      p_value_list - colon-separated list of page item IDs to check
      
    Returns:
    - adc_util.C_TRUE if rule is satisfied
    - adc_util.C_FALSE if rule is not satisfied
    - NULL if all page item values are null
   */
  static function exclusive_or(
    p_value_list in varchar2)
    return varchar2,
    
    
  /**
    Function: firing_item_has_class
      Method returns adc_util.C_TRUE, if the firing item has class <p_class>.
      
      Is used to bind an observer to more than one item based on a CSS class attached to a 
      group of page items. This method allows to detect whether the actual firing item is part
      of that group. This method is used within technical conditions.
   */
  static function firing_item_has_class(
    p_class in varchar2)
    return varchar2,
    
  
  /**
    Function: get_date
      Retrieves the actual item value from the page state
      
    Parameters:
      p_cpi_id - Page item ID that is selected to show the error message
      
    Returns:
      Actual value from the page state
   */
  static function get_date(
    p_cpi_id in varchar2)
    return varchar2,


  /** 
    Function: get_event
      Method to retrieve the name of the event that has caused ADC to execute.

      ADC events differ from normal web browser or APEX events in that they can replace browser events with their own
      events, fi by replacing the keypress-event for keycode 13 with an "enter" event.

    Returns:
      Name of the event
   */
  static function get_event
    return varchar2,


  /** 
    Function: get_event_data
      Is called to retrieve additional event data information such as returned data from a modal dialog

      Event data can be a simple string or a JSON instance, depending on the client side code.

    Parameter:
      p_key - Optional name of a key. If the event data is JSON, P_KEY can be used to extract specific information
              IF P_KEY is NULL, the complete answer is returned

    Returns:
      Event data
   */
  static function get_event_data(
     p_key in varchar2 default null)
     return varchar2,


  /**
    Function: get_firing_item
      Method to get the page item id of the item that has fired ADC processing.

      Is used to get access to the ID of the page item that has fired the event.
      This information is used within the decision table to decide upon the rule
      to execute. If firing_item is adc_util.C_NO_FIRING_ITEM, it is assumed that
      the page is initializing. It is also used to populate event pseudo columns
      such as dialog_closed etc.

    Returns:
      ID of the firing item
   */
  static function get_firing_item
    return varchar2,
    
  
  /**
    Function: get_number
      Retrieves the actual item value from the page state
      
    Parameters:
      p_cpi_id - Page item ID that is selected to show the error message
      
    Returns:
      Actual value from the page state
   */
  static function get_number(
    p_cpi_id in varchar2)
    return varchar2,
    
  
  /** 
    Procedure: get_report_selection
      Registers an event handler on a region to report if the selection of the region changes
      
    Parameters:
      p_region_id - ID of the region to observe
      p_page_item - Optional page item to store the selected node id at. If NULL, the selected node is reported
                    to ADC via EVENT_DATA
      p_ordinal_nr - Optional ordinal number of the column that contains the node id information.
                     If NULL, a column must be marked as primary key (IG) or a column must contain an attribute data-id
                     containing the primary key information
   */
  static procedure get_report_selection(
    p_region_id in varchar2,
    p_page_item in varchar2 default null,
    p_ordinal_nr in binary_integer default null),
    
  
  /**
    Function: get_string
      Retrieves the actual item value from the page state
      
    Parameters:
      p_cpi_id - Page item ID that is selected to show the error message
      
    Returns:
      Actual value from the page state
   */
  static function get_string(
    p_cpi_id in varchar2)
    return varchar2,

  
  /** 
    Procedure: handle_bulk_errors
      Method to encapsulate PIT collection mode error treatment
      
      Is used to retrieve the collection of messages collected during validation of a use case in PIT collect mode.
      The method retrieves the messages and maps the error codes to page items passed in via <P_MAPPING>.
      If found, it shows the exception inline with field and notification to those items, otherwise it shows the
      message without item reference in the notification area only.
      Supports #LABEL# replacement, page item name may be passed in with or without page prefix.
      Similar to UTL_APEX.HANDLE_BULK_ERRORS, but uses ADC to show the messages dynamically as opposed to UTL_APEX
      that encapsulates the messages in the validation life cycle step of APEX.
                 
     Parameter: 
       p_mapping - CHAR_TABLE instance with error code - page item names couples, according to DECODE function
       p_filter_list - Optional list of items to filter the message collection. If NOT NULL, it reduces the
                       error output to those items which are both on the p_mapping list and the p_filter_list.
                       This allows to control which validations are taken into account for a specific page state.
                       Normal use of this filter would be to limit the validation to the firing item, but it is
                       also possible to pass more than one item name in, fi when validating a pair of
                       VALID_FROM and VALID_UNTIL date ranges or similar.
                       Several item names are passed in as a colon delimited list.
   */
  static procedure handle_bulk_errors(
    p_mapping in char_table default null,
    p_filter_list in varchar2 default null),
    
    
  /** 
    Procedure: initialize_form_region
      Method to initialize a form region with data
      Is used to dynamically initialize the values of a form region.
      It requires
      
      - An ID for the form region, as it is possible to have more than one form region on a page
      - At least one page item that is flagged as the primary key column
      - Flag EDITABLE of the form region set to true
                
    Parameter:
      p_static_id - ID of the form region to initialize
   */
  static procedure initialize_form_region(
    p_static_id in varchar2),
    

  /** 
    Procedure: not_null
      Method to assure that at least on page item of a list of page items contains a value.
      Is used to make sure that at least one page item of a list of page items contains a value.
                 
    Parameters:
      p_cpi_id - Page item ID that is selected to show the error message
      p_value_list - List of page item IDs to check
      p_message - Optional PIT message name to show if the method throws an error
      
    Errors:
      msg.ASSERTION_FAILED_ERR - if all page item values are NULL
      <P_MESSAGE>_ERR - if all page item values are NULL and <P_MESSAGE> is set
   */
  static procedure not_null(
    p_cpi_id in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default 'ASSERTION_FAILED'),


  /** 
    Function: not_null
      Overload as function. Is used to be able to utilize NOT_NULL within an ADC rule condition (used in SQL)
                
    Parameters:
      p_value_list - List of page item IDs to check
      
    Returns:
      - <adc_util.C_TRUE> if rule is satisfied
      - <adc_util.C_FALSE> if rule is not satisfied
      - NULL if all page item values are null
   */
  static function not_null(
    p_value_list in varchar2)
    return varchar2,
    
  
  /**
    Procedure: register_additional_item
      Register the item passed in as an additional page item, meaning that it reports
      its value with every round trip to the server but does not implement an event
      on this item.
      Is used to make sure that item values are present in the page state which are
      required for computations but which don't have rules attached to them.
  
    Parameter:
      p_cpi_id - Item to be added
   */
  static procedure register_additional_item(
    p_cpi_id in varchar2),
    
    
  /** 
    Procedure: remember_page_state
      Persists the value of the actually visible or explicitly requested input fields for later comparison.
      
      Is used to persist the actual page status of selected page items in an ADC internal MAP.
      After having persited the status, everal action types react if they detect changes
      between the persisted and actual page state.
      
      In contrast to the built in option of APEX, this method can be called at any time and will
      persist the actual status for later comparison. This is useful in dynamic forms if the content
      of the form is changed by ADC.
   
    Parameters:
      p_page_items - Optional JSON array containing a list of page item IDs that are to be persisted
      p_message - Message text to show if there are unsaved changes
      p_title - Optional title of the dialog box. Defaults to translatable item ADC_UNSAVED_ITEM_TITLE
   */
  static procedure remember_page_state(
    p_cpi_id in varchar2 default null,
    p_page_items in varchar2 default null),
    
    
  /**
    Procedure: remove_all_errors
      Method to remove all errors from the actual page.
   */
  static procedure remove_all_errors,


  /** 
    Procedure: refresh_item
      Updates an element and sets the session state.
      
      Is used to refresh a page item. In addition to the refresh methods, this method allows
      to set a page item to a defined value according to P_ITEM_VAL after refresh.
      Is usable for page items and refreshable regions
   
    Parameters:
      p_cpi_id - Page item to be updated
      p_item_value - Value of the element in the following format:
                     - constant in quotation marks or 
                     - JavaScript expression, which is calculated at runtime or 
                     - NULL In this case the value of the session state is used (this can be calculated in advance)
   */
  static procedure refresh_item(
    p_cpi_id in varchar2,
    p_item_value in varchar2 default null),


  /** 
    Procedure: register_error
      Method to register an error. Is called to register an error onto the error stack. 
      May be called from PL/SQL directly or implicitly as the consequence of an internal error.
                 
    Parameters:
      p_cpi_id - ID of the page item that is referenced by the error (or DOCUMENT)
      p_error_msg - Error message to register
      p_internal_error - Optional additional information, visible for developers
   */
  static procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null),


  /**
    Procedure: register_error
      Overload to allow for PIT messages to be used. Is called to register an error onto the error stack. 
      May be called from PL/SQL directly or implicitly as the consequence of an internal error.
                 
    Parameters:
      p_cpi_id - ID of the page item that is referenced by the error (or DOCUMENT)
      p_message_name - PIT message name to register
      p_msg_args - Optional message arguments as defined by PIT
   */
  static procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null),


  /** 
    Procedure: select_region_entry
      Selects a selectable in a region such as in an interactive grid, interactive report, classic report or tree region.
      Is used to select a selectable entry in a region that supports selection. As of now, interactive grid and tree are supported.
                
    Parameters:
      p_region_id - ID of the region you want to set a selectable at
      p_entry_id - ID of the entry to select
      p_set_focus - Flag to indicate whether selecting an entry should also set the focus to the first column (C_TRUE) or not (C_FALSE).
      p_no_event - Flag to indicate whether selecting an entry should suppress the onselectionchange event (C_TRUE) or not (C_FALSE)
   */
  static procedure select_region_entry(
    p_region_id in varchar2,
    p_entry_id in varchar2,
    p_set_focus in varchar2,
    p_no_event in varchar2),


  /** 
    Procedure: select_tab
      Selects a tab of a tabular region.
                
    Parameters:
      p_region_id - ID of the tabular region that contains the tab
      p_tab_id - ID of the tab to select
   */
  static procedure select_tab(
    p_region_id in varchar2,
    p_tab_id in varchar2),
    

  /** 
    Procedure: set_focus
      Sets the focus to the element defined in <p_cpi_id>
                 
    Parameter:
      p_cpi_id - element to focus on
   */
  static procedure set_focus(
    p_cpi_id in varchar2),


  /** 
    Procedure: set_item
      Sets the referenced page element to the value passed as parameter.
      Is used to set the value of a page item in session state. Overloaded versions to cater for String, Number and Date values.
      
      Parameter <p_allow_recursion> is used to surpress recursive execution of rules based on the page item.
      Default is to not surpress recursion, but in difficult rule situations, it may be necessary to set it to FALSE
   
    Parameters:
      p_cpi_id - Optional element ID to be set, defaults to 'DOCUMENT' if <p_jquery_selector> is set
      p_item_value - Value of the element in quotation marks or function that returns value. Overloaded versions for String, Number or Date
      p_jquery_selector - Optional jQuery expression to edit multiple elements. (Defaults to NULL, if <p_cpi_id> is set)
      p_allow_recursion - Optional flag indicating whether a Change Event should be triggered. (Defaults to adc_util.C_TRUE, event is triggered)
   */
  static procedure set_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in varchar2 default null,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 1),
    
  
  static procedure set_number_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in number,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 1),
    
    
  static procedure set_date_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in date,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 1),
 

  /** 
    Procedure: set_item_label
      Sets a field label to the transferred value
                 
    Parameters:
      p_cpi_id - Optional element ID to be set (defaults to 'DOCUMENT', if <p_jquery_selector> is set)
      p_item_label - Label of the element in quotation marks or function that returns value.
      p_jquery_selector - Optional jQuery expression to edit multiple elements. (Defaults to NULL, if <p_cpi_id> is set)
   */
  static procedure set_item_label(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_label in varchar2,
    p_jquery_selector in varchar2 default null),


  /** 
    Procedure: set_items_from_stmt
      static procedure to set the session state, based on an SQL statement.
      Is used to set one or more item values based on a SQL query.
      Two operation modes:
      
      - P_CPI_ID is set to a page item ID
        In this case the SQL query must return a scalar value
      - P_CPI_ID ist DOCUMENT oder NULL
        In this mode the query is allowed to return more than one column but one row only.
        The column names must match page item column source names. 
        If a match is found, the respective element is set to the column value
   
    Parameters:
      p_cpi_id - Optional ID of the page item. If NULL, the item ID is taken from the column names of <p_stmt>
      p_statement - SELECT statement to retrieve the new page item value or values
   */
  static procedure set_items_from_statement(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_statement in varchar2),


  /** 
    Procedure: set_items_from_cursor
      static procedure to set the session state, based on an SQL statement.
      
      The query is allowed to return more than one column but one row only.
      The column names must match page item column source names. 
      If a match is found, the respective element is set to the column value
   
    Parameters:
      p_cursor - Opened cursor with the respective column names and values
   */
  static procedure set_items_from_cursor(
    p_cursor in out nocopy sys_refcursor),


  /** 
    Procedure: set_mandatory
      Makes a page element a mandatory element and activates mandatory field validation.
                 
    Parameters:
      p_cpi_id - Optional element ID to be set (defaults to 'DOCUMENT', if <p_jquery_selector> is set)
      p_msg_text - Optional message text in quotation marks or function that returns a value (default NULL, then standard text)
      p_jquery_selector - Optional jQuery expression to edit multiple elements. (Defaults to NULL, if <p_cpi_id> is set)
   */
  static procedure set_mandatory(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_msg_text in varchar2 default null,
    p_jquery_selector in varchar2 default null),


  /** 
    Procedure: set_optional
      Makes a page element an optional element and suspends mandatory field validation.
                 
    Parameters:
      p_cpi_id - Optional element ID to be set (defaults to 'DOCUMENT', if <p_jquery_selector> is set)
      p_jquery_selector - Optional jQuery expression to edit multiple elements. (Defaults to NULL, if <p_cpi_id> is set)
   */
  static procedure set_optional(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_jquery_selector in varchar2 default null),
  
  
  /** 
    Procedure: set_region_content
      Sets the HTML content of a page region
   
    Parameters:
      p_region_id - ID of the page region
      p_html_code - HTML code of the region. Must not be escaped, this will be done within this method
   */
  static procedure set_region_content(
    p_region_id in varchar2,
    p_html_code in varchar2),


  /** 
    Procedure: set_visual_state
      Controls the visibility of a page item
   
    Parameters:
      p_cpi_id - Optional element ID to be set (defaults to 'DOCUMENT', if <p_jquery_selector> is set)
      p_visual_state - One of the visual state constants <C_SHOW_ENABLE>, <SHOW_DISABLE>, <HIDE>
      p_jquery_selector - Optional jQuery expression to edit multiple elements. (Defaults to NULL, if <p_cpi_id> is set)
   */
  static procedure set_visual_state(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_visual_state in varchar2,
    p_jquery_selector in varchar2 default null),


  /** 
    Procedure: show_hide_item
      Shows the element(s) from P_JQUERY_SEL_SHOW and hides the element(s) from P_JQUERY_SEL_HIDE
   
    Parameters:
      p_jquery_sel_show - jQuery expression to display multiple elements
      p_jquery_sel_hide - jQuery expression to hide multiple elements
   */
  static procedure show_hide_item(
    p_jquery_sel_show in varchar2,
    p_jquery_sel_hide in varchar2),


  /** 
    Procedure: show_notification
      Shows a success or failure dialog
   
    Parameters:
      p_message_name - Name of the message. Must be an existing PIT message name
      p_msg_args - Optional message arguments
   */
  static procedure show_notification(
    p_message_type in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_title in varchar2 default null,
    p_focus_item in varchar2 default null),
    
    
  /** 
    Procedure: submit_page
                 Method to submit the actual page. Allows ADC to determine on whether the actual page has to be processed or not
   
    Parameter:
      p_submit_type - Optional flag to indicate whether all validations should be performed. Defaults to VALIDATE_AND_SUBMIT.
                      Allowed values are taken from ADC_PARAM_LOV_SUBMIT_TYPE
      p_request - Optional request that is passed when the page is submitted
      p_msg_name - Optional name of a PIT message that is used if the validation fails
   */
  static procedure submit_page(
    p_submit_type in varchar2 default 'VALIDATE_AND_SUBMIT',
    p_request in varchar2 default 'SAVE',
    p_msg_name in varchar2 default null),


  /** 
    Procedure: stop_rule
      Method to stop further execution of the active rule. Is used to stop the execution of an ADC rule if an error occured.
   */
  static procedure stop_rule
  
) not instantiable not final;
/