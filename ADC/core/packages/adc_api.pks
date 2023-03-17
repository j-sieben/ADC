create or replace package adc_api 
  authid definer
as

  /**
    Package: ADC_API

      Implements the internal interface of ADC and a wrapper around <ADC_INTERNAL>.
      ADC_API serves as the technical interface to ADC in that it publishes
      the most significant methods of <ADC_INTERNAL>. It is called by the PL/SQL interface
      in package ADC and partly from <ADC_UI>.
      
      It is designed to form an API between the internal package to implement trivial
      functionality directly and calling <ADC_INTERNAL> support for more advanced functionality.
      
      All other packages with the exception of <ADC_PLUGIN> are not allowed to directly address <ADC_INTERNAL>.

    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /* CORE FUNCTIONALITY wrapper around <ADC_INTERNAL>
   * Methods are in alphabetical order.
   */
  
  /**
    Procedure: add_javascript
      Method to incorporate a JavaScript chunk into the response.
      
      Each script is assigned a debug level that allows to control 
      the amount of code ADC produces in response. Right now, the response
      is limited to 32KBytes. To achieve this, ADC reduces the level 
      of the output if necessary (removing any comments etc) to keep 
      the response below 32KBytes. 
      
      The method also comments out duplicate JavaScript statements.
      Removing duplicates reduces the amount of code the browser has to execute.

    Parameter:
      p_script - JavaScript chunk to add
   */
  procedure add_javascript(
    p_javascript in varchar2);
    
  
  /**
    Procedure: clear_page_state
      Method to clear the actual page state
   */
  procedure clear_page_state;
  
  
  /**
    Procedure: execute_action
      Method to execute a defined <ACTION TYPE>.
      
      Is used to allow PL/SQL code to execute predefined action types. 
      This forms an API to the action types to be used from within PL/SQL
      Don't use this method directly, but wrap the action type in package ADC to 
      allow for action type specific parameter naming.
                 
    Parameters:
      p_cat_id - ID of the action type
      p_cpi_id - Optional page item the action refers to. If no page item is set, adc_util.C_NO_FIRING_ITEM is used
      p_param_1 - Optional first parameter value of the action
      p_param_2 - Optional second parameter value of the action
      p_param_3 - Optional third parameter value of the action
   */
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_FALSE);
        
        
  /**
    Procedure: execute_command
      Method to directly execute a command (APEX action) from within a page rule.
      By executing a command it is simulated that the uses executes a command.
      ADC will recursively execute the command rather than asking the browser to 
      execute it, creating an unnecessary roundtrip.
      
      If a command is not bound to any page item, such as a button, it won't be
      generated on the page but is callable only from within a rule. This helps in 
      organizing complex dynamic functionality by creating "sub routines" for 
      dynamic behaviour.
      
    Parameter:
      p_command - Name of the command to execute
   */
  procedure execute_command(
    p_command in adc_apex_actions.caa_name%type);
    

  /** 
    Procedure: execute_javascript
      Method to execute a PL/SQL block that returns JavaScript that will be part of the ADC answer.
      
      Is used to let ADC calculate a JavaScript chunk (such as a call to open a modal dialog) and return it to ADC.
      ADC will then incorporate this script into the answer and execute it.
   
    Parameter:
      p_plsql - PL/SQL block to calculate the JavaScript
   */
  procedure execute_javascript(
    p_plsql in varchar2);
    
    
  /**
    Procedure: execute_plsql
      Method to execute a PL/SQL block.
      
      In contrast to <execute_javascript>, this method will exiectue the PL/SQL block
      to change the session state or do something else on the database side. If the
      PL/SQL block changes the session state, this may cause recursive rules to be executed.
   
    Parameter:
      p_plsql  PL/SQL block to execute
   */
  procedure execute_plsql(
    p_plsql in varchar2);


  /** 
    Function: exclusive_or
      Method to assure that exactly one or at most one page item of a selection of page items contains a value.
      Is used to be able to utilize EXCLUSIVE_OR within an ADC rule condition (used in SQL).

    Parameter:
      p_item_list - colon-separated list of page item IDs to check
   
    Returns:
      - adc_util.C_TRUE if rule is satisfied
      - adc_util.C_FALSE if rule is not satisfied
      - NULL if all page item values are null
   */
  function exclusive_or(
    p_item_list in varchar2)
    return adc_util.flag_type;


  /**
    Function: get_date
      Method to retrieve the value of a page item as char.
      
      Is used to convert a session state string value into date.
      Depending on parameter P_THROW_ERROR an error is not only registered upon unsuccessful conversion but thrown as well.
      This is useful if a rule cannot be processed any further if the conversion is not successful.
      
      If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata. If no such default
      value exists, an exception is registered with ADC.
   
    Parameters:
      p_cpi_id - ID of the page item
      p_format_mask - Optional format mask that is used to convert the string representation within the session state.
                      If NULL, ADC tries to get the format mask from the meta data
      p_throw_error - Optional flag to indicate whether a non successful conversion is treated as an error. Defaults to C_TRUE.
                      
                    - adc_util.C_TRUE: an error is registered and thrown
                    - adc_util.C_FALSE: an error is registered but not thrown
                    
    Returns:
      DATE value
   */
  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date;
    
    
  /** 
    Function: get_event
      Method to retrieve the name of the event that has caused ADC to execute.
      
      ADC events differ from normal web browser or APEX events in that they can replace browser events with their own
      events, fi by replacing the keypress-event for keycode 13 with an "enter" event.
   
    Returns:
      Name of the event
   */
  function get_event
    return varchar2;
    
    
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
  function get_event_data(
     p_key in varchar2 default null)
     return varchar2;


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
  function get_firing_item
    return varchar2;


  /**
    Function: get_lov_sql
      Method to retrieve a select statement that reads values for a given
      Action Parameter of type <SELECT_LIST>
      
    Parameters:
      p_capt_id - Type of the Action Parameter
      p_crg_id - ID of the rule group. Is used to filter the LOV statement
    
    Returns:
      Select statement to be executed by the ADC_UI to retrieve values for an Action Parameter#
      of type <SELECT_LIST>
   */
  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2;


  /** 
    Function: get_number
      Method to retrieve the value of a page item as number.
      
      Is used to convert a session state string value into number.
      Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
      This is useful if a rule cannot be processed any further if the conversion is not successful.
      
      If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata. If no such default
      value exists, an exception is registered with ADC.
   
    Parameters:
      p_cpi_id - ID of the page item
      p_format_mask - Optional format mask that is used to convert the string representation within the session state.
                      If NULL, ADC tries to get the format mask from the meta data
      p_throw_error - Optional flag to indicate whether a non successful conversion is treated as an error. Defaults to C_TRUE.
                      
                      - adc_util.C_TRUE: an error is registered and thrown
                      - adc_util.C_FALSE: an error is registered but not thrown
                    
    Returns:
      NUMBER value
   */
  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return number;
    
    
  /**
    Function: get_string
      Method to retrieve the value of a page item as char.
      
      As an extension to V(P_CPI_ID) this method retrieves a default value as defined within the APEX data dictionary
      if the actual value of the page item is NULL.

    Parameter:
      p_cpi_id - ID of the page item
   
    Returns:
      Value of the requested page item
   */
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;

  
  /** 
    Procedure: handle_bulk_errors
      Method to encapsulate PIT collection mode error treatment
      
      Is used to retrieve the collection of messages collected during validation of a use case in PIT collect mode.
      The method retrieves the messages and maps the error codes to page items passed in via <P_MAPPING>.
      If found, it shows the exception inline with field and notification to those items, otherwise it shows the
      message without item reference in the notification area only.
      Supports #LABEL# replacement, page item name may be passed in with or without page prefix.
      Similar to UTL_APEX.HANDLE_BULK_ERRORS, but uses SCT to show the messages dynamically as opposed to UTL_APEX
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
  procedure handle_bulk_errors(
    p_mapping in char_table default null,
    p_filter_list in varchar2 default null);


  /**
    Function: has_class
      Method to check whether the actual firing item has got a css class passed in as parameter
      
      Is used within technical conditions to bind all items with a given class
      
    Parameter:
      p_class - Class that is checked against the firing item.
                
    Returns:
      adc_util.C_TRUE, if firing item has got the actual class, adc_util.C_FALSE otherwise
   */
  function has_class(
    p_class in varchar2)
    return adc_util.flag_type;


  /**
    Function: has_errors
      Method to learn whether the actual rule flow has receieved errors.
      
      Is called from PL/SQL code to react if errors have occurred.
                
    Returns:
      FALSE if no error has occured, TRUE otherwise
   */
  function has_errors
    return boolean;


  /** 
    Function: has_no_errors
      Method to learn whether the actual rule flow has receieved errors.
      
      Is called from PL/SQL code to react if errors have occurred.
                
    Returns:
      TRUE if no error has occured, FALSE otherwise
   */
  function has_no_errors
    return boolean;
    
    
  /**
    Procedure: initialize_form_region
      Method to initialize a form region with data.
      
      Is used to dynamically initialize the values of a form region.
      It requires:
      
      - A static ID for the form region, as it is possible to have more than one form region on a page
      - At least one page item that is flagged as the priomary key column
      - the form region must have the flag EDITABLE set to true
   
    Parameter:
      p_static_id - Static ID of the form region to initialize
   */
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type);


  /** 
    Function: not_null
      Method to check whether at least one of the page items provided in <p_value_list> is not null
                
    Parameter:
      p_item_list - colon-separated list of page item IDs to check
   
    Returns:
      - adc_util.C_TRUE if rule is satisfied
      - adc_util.C_FALSE if rule is not satisfied
   */
  function not_null(
    p_item_list in varchar2)
    return adc_util.flag_type;
    
    
  /**
    Procedure: raise_item_event
      Method to register an item as a firing item, effectively raising its related event. 
      
      Registering an item as a firing explicitly serves as a mechanism to evaluate 
      all ADC rules related to this item. Effectively, this simulates raising
      the assigned event on the given item. This is useful  if it is required to execute
      ADC rules without changing the item's value.

    Parameter:
      p_cpi_id - page item to raise the event for
   */
  procedure raise_item_event(
    p_cpi_id in varchar2);
    
    
  /** 
    Procedure: register_error
      Method to register an error with ADC.
   
    Parameters:
      p_cpi_id - page item to assign the error to
      p_error_msg - Main error text
      p_internal_error - Internal error text with additional information
   */ 
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);
    
    
  /** 
    Procedure: register_error
      Method to register an error with ADC.
      
      Overloaded version to accept a PIT message

    Parameters:
      p_cpi_id - page item to assign the error to
      p_message_name - Name of a PIT message
      p_msg_args - Optional message arguments
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
    
  /**
    Procedure: register_mandatory
      Method to register a page item as mandatory or optional at ADC.
      
      ADC maintains APEX collections with all mandatory items per ADC rule group. 
      This way, mandatory items can differ between sessions.
   
    Parameters:
      p_cpi_id - Page item to set mandatory or optional
      p_is_mandatory - Flag that indicates whether a page item is mandatory (adc_util.C_TRUE) or not (adc_util.C_FALSE)
      p_cpi_mandatory_message - Optional message that is shown if a mandatory page item is null
      p_jquery_selector - Optional selector to set the mandatory status of many items at once
   */
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_is_mandatory in adc_util.flag_type,
    p_cpi_mandatory_message in varchar2,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);
    
    
  /**
    Procedure: register_observer
      Method to register a page item as to be observed.
      
      Is used to register a page item with ADC. This is necessary only if:
      
      - ADC action require the actually set value at the session state with every roundtrip
      - no technical condition references this item
      
      If these requirements are met, this method allows to register a page item for observation
      This method is only applicable during page initialization, as lateron no event handlers
      are added to the page
      
    Parameter:
      p_cpi_id  page item to observe
   */
  procedure register_observer(
    p_cpi_id in adc_page_items.cpi_id%type);
    
    
  /** 
    Procedure: set_session_state
      Wrapper around apex_util to set a value in the session state.
      
      Is used to set a session state value. In extension to apex_util, setting a value using this method
      leads to recursive rule execution for the changed page items if allowed an it gives the possibility
      to set the value of many items using a jQuery selector.

    Parameters:
      p_cpi_id - page item to set
      p_value - Optional string value to set the item to.
      p_number_value - Optional number value to set the item to.
      p_date_value - Optional date value to set the item to.
      p_allow_recursion - Flag to indicate whether changing the item value is allowed 
                          to raise recursive rule execution. Defaults to adc_util.C_TRUE
      p_jquery_selector - Optional selector to set many items at once
   */
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);


  /** 
    Procedure: set_value_from_statement
      Procedure to set the session state of one or many items based on a SQL statement.
      
      Is used to set one or more item values based on a SQL query. Two operation modes:
      
      - P_CPI_ID is set to a page item ID
        In this case the SQL query must return a scalar value
      - P_CPI_ID ist DOCUMENT oder NULL
        In this mode the query is allowed to return more than one column but one row only.
        The column names must match page item column source names. 
        If a match is found, the respective element is set to the column value
   
    Parameters:
      p_cpi_id - ID of the page item
      p_statement - SELECT statement to retrieve the new page item value or values
   */
  procedure set_value_from_statement(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_statement in varchar2);


  /** 
    Procedure: set_value_from_cursor
      Procedure to set the session state of one or many items based on a SQL statement.
      
      The query is allowed to return more than one column but one row only.
      The column names must match page item column source names. 
      If a match is found, the respective element is set to the column value
   
    Parameters:
      p_cursor - Opened cursor with the respective column names and values
   */
  procedure set_value_from_cursor(
    p_cursor in out nocopy sys_refcursor);
    
    
  /** 
    Procedure: stop_rule
      Method to stop the execution of a rule.
      
      Is used to prevent further recursion or exeution steps in case of a failure.
      This method is normally called as an exception handler in a rule.
      It may also be called from within PL/SQL to prevent recursive rule execution.
   */
  procedure stop_rule;


  /**
    Procedure: validate_page
      Method to validate user data for a page.
      
      It checks the following actions
      
      - all mandatory items (in case an initially empty item did not receive a change event)
      - all actions that are marked as validations (in case an exception that is shown on the
        page has not been fixed before submitting the page)
      
      This method is only useful if ADC controls the whole page completely. It can not intercept
      a apex.submit call raised by a button or a Dynamic Action on the page. Rather, validate
      the page using this method and submit the page in case of success using ADC.
      
    Parameter:
      p_submit_type - Indicates the type of submission. Is used to decide whether a validation is
                      requested or not. One of the submission types of ADC_PARAM_LOV_SUBMIT_TYPE.
   */
  procedure validate_page(
    p_submit_type in varchar2);
  
  
end adc_api;
/