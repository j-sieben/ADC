create or replace package adc_page_state
  authid definer
  accessible by (package adc_internal, package adc_api, package adc_response, package ut_adc_page_state)
as

  /** 
    Package: ADC_PAGE_STATE
      Package to implement the page state API. It is accessible by packages <ADC_INTERNAL>, <ADC_RESPONSE> and <ADC_API> only.
      This package separates the maintenance of the page state from the core functionality.
      
      The Page State differs from the session state in that it contains all items required by the
      ADC rule, not necessary anything that is in session state. It also persists date and number values
      as the respective type and not as a string only as the session state does.
      It is designed as a cache to prevent recurring conversion and environment switches during the 
      processing of a request which may call the page state more than once.
      
      If a value is set via ADC, it harmonizes the cache and the session state for the changed items.
      Any changed value in the page state is reported back to the APEX page as part of the response
      and thus harmonized with the visual state on the page.
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  /**
    Group: Public constants
   */
  /**
    Constants:
      C_FROM_SESSION_STATE - Indicator to retrieve the actual item value from the session state
   */
  C_FROM_SESSION_STATE constant adc_util.ora_name_type := 'FROM_SESSION_STATE';

  /**
    Group: Public methods
   */    
  /**
    Function: item_may_have_value
      Method checks whether an item is allowed to have a page state value.
      
    Parameters:
      p_cgr_id - ID of the rule group.
      p_cpi_id - ID of the page item
      
    Returns:
      Flag to indicate whether this item is allowed to have a value (TRUE) or not (FALSE).
   */
  function item_may_have_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
    return boolean;
 

  /**
    Function: check_mandatory
      Method checks whether an item is actually mandatory.
      
    Parameters:
      p_cgr_id - ID of the rule group.
      p_cpi_id - ID of the page item
      
    Errors:
      msg.ADC_IS_MANDATORY_ERR - Error with the mandatory message. Either the message passed in or a default mandatory message
   */
  procedure check_mandatory(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type);
    
    
  /**
    Procedure: register_mandatory
      Registers a page item to be mandatory or optional
      
    Parameters:
      p_cgr_id - ID of the rule group.
      p_cpi_id - ID of the page item
      p_cpi_mandatory_message - Optional mandatory message. If NULL, a predefined mandatory message is used
      p_is_mandatory - Flag to indicate whether this item is mandatory (C_TRUE) or optional (C_FALSE)
   */
  procedure register_mandatory(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type);
    
    
  /**
    Procedure: reset
      Method to reset the page state cache.
      
      Is called before and after a request is processed to reset any page state values
   */
  procedure reset;
  
  
  /** 
    Procedure: set_value
      Method to set a page item value both in session state and in page state cache.
      
      Analyzes, whether the firing item has got a conversion mask. If so,
      
      - it tries to convert it and catches any conversion errors
      - it converts the item value and stores a formatted version in the session state
                 
    Parameters:
      p_cgr_id - ID of the rule group, necessary to read format masks from the ADC metadata
      p_cpi_id - ID of the page item to set
      p_value - Optional string value. May be NULL, but if omitted, it will default to C_FROM_SESSION_STATE, 
                meaning that the value will be taken from the actual APEX session state value.
      p_number_value - Optional number value, will be converted back to the requested format mask for that page item.
      p_date_value - Optional date value, will be converted back to the requested format mask for that page item.
      p_format_mask - Optional format mask. If NULL, it will be taken from the ADC metadata
      p_throw_error - Optional flag to indicate whether a conversion error is raised or silently ignorede. Defaults to ignore.
      
    Errors:
      msg.INVALID_NUMBER_FORMAT_ERR - if the value can not be converted by that format mask
      msg.ADC_INVALID_NUMBER_ERR - if the value is not a valid number
      msg.INVALID_DATE_ERR - if the value is not a valid date
      msg.INVALID_DATE_FORMAT_ERR - if the value cannot be converted to a date using the format mask
      msg.INVALID_YEAR_ERR - if the value contains an invalid year, month or day
      msg.SQL_ERROR_ERR - if any other exception occurs
   */
  procedure set_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE);
    
  
  /** 
    Function: get_string
      Getter method to retrieve a page state value as string.
      
      As this method is called during initialization as well and the firing item value is requested,
      it must assure that no value is returned if C_NO_FIRING_ITEM is requested.
   
    Parameters:
      p_cgr_id - Id of the rule group to enable the logic to decide upon possible conversion and format masks
      p_cpi_id - Id of the item to retrieve.
      
    Returns:
      String value of the page state for the requested item.
   */
  function get_string(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;
  
    
  /** 
    Function: get_date
      Getter method to retrieve a page state value as date.
   
    Parameters:
      p_cgr_id - Id of the rule group to enable the logic to decide upon possible conversion and format masks
      p_cpi_id - Id of the item to retrieve.
      p_format_mask - Format mask in case the page state is not yet aware of the item value
   
   
    Returns:
      Date value of the page state for the requested item.
   */
  function get_date(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return date;
  
    
  /** 
    Function: get_number
      Getter method to retrieve a page state value as number.
   
    Parameters:
      p_cgr_id - Id of the rule group to enable the logic to decide upon possible conversion and format masks
      p_cpi_id - Id of the item to retrieve.
      p_format_mask - Format mask in case the page state is not yet aware of the item value
   
   
    Returns:
      Number value of the page state for the requested item.
   */
  function get_number(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return number;
    
    
  /**
    Function: get_changed_items_as_json
      Method get all changed items back in JSON
      
      --- Code
      [{"id":"#ID#","value":"#VALUE#"},..]
      ---
      
      Is used to collect all changed items along with their value in JSON to send it back to the client.
                
    Returns:
      JSON string containing the JSON representation of the CHAR_TABLE
   */
  function get_changed_items_as_json
    return varchar2;  
    
  
  /**
    Procedure: get_item_values_as_char_table
      Method to retrieve a list of session state values from a comma delimited item list.
      
      This method is used as a helper to get the session state values of a comma separated list of page item names.
      It is called by EXCLUSIVE_OR and NOT_NULL to check whether the respective rules are obeyed.
                 
    Parameters:
      p_cgr_id - Id of the rule group to enable the logic to decide upon possible conversion and format masks
      p_cpi_list - comma-separated list of page item names for which the session state values have to be returned
      p_value_list - CHAR_TABLE instance with the session state values of the page items passed in via P_CPI_LIST
   */
  procedure get_item_values_as_char_table(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_list in varchar2,
    p_value_list out nocopy char_table);
    
    
end adc_page_state;
/