create or replace package adc_api 
  authid definer
as


  /** Package ADC to implement the public interface to ADC
   * %author Juergen Sieben, ConDeS GmbH
   * %usage  Used to implement the public interface of ADC. Is called by PLUGIN_ADC, ADC rule views and directly from PL/SQL
   * %headcom
   * All methods in alphabetical order
   */
   
  $IF adc_util.C_WITH_UNIT_TESTS $THEN
  /* Setter/getter to switch package to test mode
   * %param  p_mode  Switch to toggle test mode
   * %usage  For automated tests, this switch controls wehther ADC fills an object structure with the outcome of
   *         the processing. This is easier and saver than parsing OWA streams
   */
  procedure set_test_mode(
    p_mode in boolean default false);    
    
  function get_test_mode
    return boolean;
    
  /** Method to retrieve the result of the last action
   * %return Object structure that contains the result of the process.
   */
  function get_test_result
    return ut_adc_result;
  $END
  
  /* CORE FUNCTIONALITY wrapper around ADC_INTERNAL */

  /* Method to incorporate a JavaScript chunk into the response
   * @param  p_script       JavaScript chunk to add
   * @usage  Is used to add a JavaScript chunk to an internal JavaScript collection.
   *         Any chunk is assigned to a debug level, allowing to control the amount of code ADC will produce as an answer.
   *         As for now, the answer is limited to 32KByte. To achieve that, ADC will reduce the level of the output if
   *         required to keep the answer below 32KByte.
   *         The method also looks for duplicate JavaScript and comments out earlier chunks with the same JavaScript. This
   *         can happen based on the flow of rules. Removing duplicates reduces the amount of code the browser has to execute,
   *         especially useful if a region is refreshed.
   */
  procedure add_javascript(
    p_javascript in varchar2);
    
  
  /** Method to execute a defined ACTION TYPE
   * %param  p_cat_id    ID of the action type
   * %param  p_cpi_id    page item the action refers to. If no page item is set, adc_util.C_NO_FIRING_ITEM is used
   * %param [p_param_1]  Optional first parameter value of the action
   * %param [p_param_2]  Optional second parameter value of the action
   * %param [p_param_3]  Optional third parameter value of the action
   * %usage  Is used allow PL/SQL code to execute predefined action types. This forms an API to the action types to be used from within PL/SQL.
   */
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_param_3 in adc_rule_actions.cra_param_3%type default null);
        

  /** Method to execute a PL/SQL block that returns JavaScript. This script will be part of the SCT answer and will get
   *  executed when SCT returns.
   * %param  p_plsql  PL/SQL block to calculate the JavaScript
   * %usage  Is used to let SCT calculate a JavaScript chunk (such as a call to open a modal dialog) and return it to SCT.
   *         SCT will then incorporate this script into the answer and execute it.
   */
  procedure execute_javascript(
    p_plsql in varchar2);
    
    
  /** Method to execute a PL/SQL block
   * %param  p_plsql  PL/SQL block to execute
   * %usage  Is used to execute dynamic PL/SQL blocks
   */
  procedure execute_plsql(
    p_plsql in varchar2);


  /** Method to assure that exactly one or at most one page item of a selection of page items contains a value
   * %param  p_value_list  colon-separated list of page item IDs to check
   * %return - adc_util.C_TRUE if rule is satisfied
   *         - adc_util.C_F if rule is not satisfied
   *         - NULL if all page item values are null
   * %usage  Is used to be able to utilize EXCLUSIVE_OR within an ADC rule condition (used in SQL)
   */
  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type;


  /** Method to retrieve the value of a page item as char
   * %param  p_cpi_id       ID of the page item
   * %param [p_format_mask] Format mask that is used to convert the string representation within the session state.
   *                        If NULL, ADC tries to get the format mask from the meta data
   * %param [p_throw_error] Flag to indicate whether a non successful conversion is treated as an error. Defaults to C_TRUE.
   *                        - C_TRUE: an error is registered and thrown
   *                        - C_FALSE: an error is registered but not thrown
   * %return DATE value
   * %usage  Is used to convert a session state string value into date
   *         Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
   *         This is useful if a rule cannot be processed any further if the conversion is not successful.
   *         If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata
   */
  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date;


  /* Getter to read the error status
   * %return TRUE if the execution of the ADC rule encountered an error, FALSE if not
   */
  function get_error_flag
    return boolean;
    
    
  /** Method to retrieve the name of the event that has caused ADC to execute
   * %return Name of the event
   * %usage  Is used to retrieve the ADC event name of the event that has fired.
   *         ADC events differ from normal web browser or APEX events in that they can replace browser events with their own
   *         events, fi by replacing the keypress-event for keycode 13 with an enter event.
   */
  function get_event
    return varchar2;
    
    
  /** Method to retrieve additional event data
   * %param [p_key] If the event data is a structured JSON, P_KEY is used to extract specific information
   *                IF P_KEY is NULL, the complete answer is returned
   * %return Event data
   * %usage  Is called to retrieve additional event data information such as returned data from a modal dialog
   */
  function get_event_data(
     p_key in varchar2 default null)
     return varchar2;


  /** Method to get the page item id of the item that has fired ADC processing
   * %return ID of the firing item
   * %usage  Is used to get access to the ID of the page item that has fired the event
   */
  function get_firing_item
    return varchar2;


  /** Method to retrieve the value of a page item as number
   * %param  p_cpi_id       ID of the page item
   * %param [p_format_mask] Format mask that is used to convert the string representation within the session state.
   *                        If NULL, ADC tries to get the format mask from the meta data
   * %param [p_throw_error] Flag to indicate whether a non successful conversion is treated as an error. Defaults to C_FALSE.
   *                        - C_TRUE: an error is registered and thrown
   *                        - C_FALSE: an error is registered but not thrown
   * %return NUMBER value
   * %usage  Is used to convert a session state string value into date
   *         Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
   *         This is useful if a rule cannot be processed any further if the conversion is not successful.
   *         If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata
   */
  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return number;
    
    
  /** Method to retrieve the value of a page item as char
   * %param  p_cpi_id  ID of the page item
   * %return Value of the requested page item
   * %usage  Is used to get the value of a page item.
   *         As an extension to V(P_CPI_ID) this method retrieves a default value as defined within the APEX data dictionary
   *         if the actual value of the page item is NULL
   */
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;


  /** Method to learn whether the actual rule flow has receieved errors
   * %return FALSE if no error has occured, TRUE otherwise
   * %usage  Is called from PL/SQL code to react if errors have occurred.
   */
  function has_errors
    return boolean;


  /** Method to learn whether the actual rule flow has receieved errors
   * %return TRUE if no error has occured, FALSE otherwise
   * %usage  Is called from PL/SQL code to assure that no errors have occurred so far.
   */
  function has_no_errors
    return boolean;


  /* @see adc.not_null */
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type;
    

  /** Method to write notifications to the developer console
   * %param  p_text  Notification text
   * %usage  Is called to allow for notifications to be passed to the UI during the execution of ADC rules.
   *         These messages are logged to the browser console as part of the response
   */
  procedure notify(
    p_text in varchar2);
    

  /** Method to write notifications to the developer console
   * %param  p_message_name  Name of a PIT message
   * %param  p_msg_args      optional message arguments
   * %usage  Is called to allow for notifications to be passed to the UI during the execution of ADC rules.
   *         These messages are logged to the browser console as part of the response
   */
  procedure notify(
    p_message_name in varchar2,
    p_msg_args in msg_args);
    
    
  /** Method to register an error with ADC
   * %param  p_cpi_id          page item to assign the error to
   * %param  p_error_msg       Main error text
   * %param  p_internal_error  Internal error text with additional information
   * %usage  Is used to register an error with ADC
   */ 
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);
    
    
  /** Method to register an error with ADC
   * %param  p_cpi_id        page item to assign the error to
   * %param  p_message_name  Name of a PIT message
   * %param  p_msg_args      optional message arguments
   * %usage  Is used to register an error with ADC
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
  
  /** Method to register items which have changed their value in the session state. If recursion is set to true, those elements
   *  will cause ADC to evaluate rules for that element by imitating that an event has thrown on that element.
   * %param  p_cpi_id             ID of the page item to register
   * %param [p_allow_recursion] Flag to indicate whether this element is allowed to cause a recursive ADC rule call
   * %usage  Is used to register page items that changed their value because of code executed in ADC. Two things have to happen:
   *         - Return the changed value to the browser to harmonize the UI with the session state
   *         - Have ADC evaluate any rules that fire based on the new value. This is true only if P_ALLOW_RECURSION is true.
   */
  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);
    
    
  /** Method to register a page item as mandatory or optional at ADC
   * %param  p_cpi_id                 page item to set mandatory or optional
   * %param  p_is_mandatory           Flag that indicates whether a page item is mandatory (adc_util.C_TRUE) or not (adc_util.C_FALSE)
   * %param  p_cpi_mandatory_message  optional message that is shown if a mandatory page item is null
   * %param  p_jquery_selector        Optional selector to set the mandatory status of many items at once
   * %usage  Is used to change the mandatory status of one or many page items dynamically
   */
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_is_mandatory in adc_util.flag_type,
    p_cpi_mandatory_message in varchar2,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);
    
    
  /** Wrapper around apex_util to set a value in the session state.
   * %param  p_cpi_id           page item to set
   * %param  p_value            page item to set mandatory or optional
   * %param  p_allow_recursion  page item to set mandatory or optional
   * %param  p_jquery_selector  Optional selector to set the mandatory status of many items at once
   * %usage  Is used to set a session state value. In extension to apex_util, setting a vlue using this method
   *         leads to recursive rule execution for the changed page items.
   */
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);


  /** Procedure to set the session state of one or many items based on a SQL statement.
   * %param  p_cpi_id ID of the page item
   * %param  p_stmt   SELECT statement to retrieve the new page item value or values
   * %usage  Is used to set one or more item values based on a SQL query.
   *         Two operation modes:
   *         - P_CPI_ID is set to a page item ID
   *           In this case the SQL query must return a scalar value
   *         - P_CPI_ID ist DOCUMENT oder NULL
   *           In this mode the query is allowed to return more than one column but one row only.
   *           The column names must match page item column source names. 
   *           If a match is found, the respective element is set to the column value
   */
  procedure set_value_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stmt in varchar2);
    
    
  /** Method to stop the execution of a rule
   * %usage  Is used to prevent further recursion or exeution steps in case of a failure
   */
  procedure stop_rule;
    
    
  /** Method to validate the actual page
   * %usage  Checks mandatory items and all actions whith the validation flag set
   */
  procedure validate_page;
  
end adc_api;
/