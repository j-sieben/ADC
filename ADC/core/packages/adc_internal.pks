create or replace package adc_internal
  authid definer
  --accessible by (package adc_plugin, package adc_validation, package adc_api)
as

  
  C_JS_CODE constant binary_integer := 1;
  C_JS_RULE_ORIGIN constant binary_integer := 2;
  C_JS_DEBUG constant binary_integer := 3;
  C_JS_COMMENT constant binary_integer := 4;
  
  
  /** Package ADC_INTERNAL to maintain State Charts as a dynamic action plugin
   * @author Juergen Sieben, ConDeS GmbH
   * %usage  Used to implement the internal logic of ADC.
   * @headcom
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

  procedure initialize_test;
  $END
  
  
  /* Method to incorporate a JavaScript chunk into the response
   * @param  p_script       JavaScript chunk to add
   * @param [p_debug_level] Optional level indicator to control the output
   * @usage  Is used to add a JavaScript chunk to an internal JavaScript collection.
   *         Any chunk is assigned to a debug level, allowing to control the amount of code ADC will produce as an answer.
   *         As for now, the answer is limited to 32KByte. To achieve that, SADC will reduce the level of the output if
   *         required to keep the answer below 32KByte.
   *         The method also looks for duplicate JavaScript and comments out earlier chunks with the same JavaScript. This
   *         can happen based on the flow of rules. Removing duplicates reduces the amount of code the browser has to execute,
   *         especially useful if a region is refreshed.
   */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default C_JS_CODE);
    

  /** Getter to retriece all elements that needs to be bound to an event handler as JSON
   * %return JSON instance containing name and event of all relevant page items
   * %usage  Is called during plugin initialization.
   *         The instance contains all relevant elements ADC needs to observe, along with the event it watches. For these items
   *         ADC will instantiate an event handler that calls ADC.
   */
  function get_bind_items_as_json
    return clob;
    
    
  /* @see adc_api.get_string */
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;
    

  /* @see adc_api.get_date */
  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date;
  
  
  /* @see adc_api.get_number */
  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.c_false)
    return number;


  /* Getter to read the error status
   * %return TRUE if the execution of the ADC rule encountered an error, FALSE if not
   */
  function get_error_flag
    return boolean;


  /** Getter to get the event that was raised.
   * %return Name of the event
   */
  function get_event
    return varchar2;
    
    
  /** Method to retrieve additional event data
   * %param  p_key  Optional key to filter event data
   * %return Event data
   * %usage  Is called to retrieve additional event data information such as returned data from a modal dialog
   *         If the event data is a structured JSON, P_KEY is used to extract specific information
   *         IF P_KEY is NULL, the complete answer is returned
   */
  function get_event_data(
     p_key in varchar2)
     return varchar2;
    

  /** Getter to get the name of the firing item. If NULL, DOCUMENT is returned
   * %return Name of the firing item or DOCUMENT if NULL
   */
  function get_firing_item
    return varchar2;
    

  /** Getter to retrieve a list of elements that potentially have changed during execution of ADC
   * %return C_DELIMITER delimited list of page items that potentially have changed
   * %usage  Is used to put together a C_DELIMITER delimited list of page items.
   */
  function get_page_items
    return varchar2;
    

  /** Method executes any initialization code of the rule group
   * %usage Called by the ADC plugin during initialization of the dynamic pages. 
   *        ADC requires the initial values of the page items and needs to compute them, 
   *        as APEX does not store them during initialization in an accessible manner.
   *        To allow for this, ADC re-executes any page computation and row fetch process as far as possible.
   */
  procedure process_initialization_code;


  /** Method to process a ADC request
   * %return JavaScript code in response to the request
   * %usage  Is used to calculate the new status of the page based on the session state values and the underlying ADC rules.
   *         Flow:
   *         - Make session state and metadata (firing item, event, event data etc.) available for the decision table
   *         - Query decision table (ADC_RULE_GROUPS.CGR_DECISION_TABLE) against actual session state
   *         - If a rule has to be executed, perform all assigned actions:
   *           - execute actions PL/SQL code immediately and 
   *           - collect all JavaScript
   *         - If a PL/SQL code changes session state, recursively check rules to determine whether further 
   *           rules have to be processed
   *         - If no further rule has to be processed, return all collected JavaScript within a <script> element
   *         This method is called from the ADC plugin
   */
  function process_request
    return clob;


  /** Method pushes a page item onto the error stack.
   * %param  p_error  APEX error of type APEX_ERROR.T_ERROR to push onto the stack
   * %usage  Is called during execution of a rule, if an error is registered.
   *         All errors are collected on an error stack and sent to the page as part of the answer.
   */
  procedure push_error(
    p_error in apex_error.t_error);
    
    
  /** Helper to copy plugin settings to an internal record G_PARAM
   * %param  p_firing_item  Firing item
   * %param  p_event        Firing event
   * %param  p_event_data   Additional event information
   * %usage  Is called before the actual rule action takes place (at the beginning of render and AJAX methods)
   *         to copy the plugin parameters and status to a package record.
   *         This method is called from the ADC plugin
   */
  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2);


  /* Methods to implement the ADC specific functionality */
  /* @see adc_api.execute_action */
  procedure check_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type);


  /* @see adc_api.execute_action */
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type);


  /* @see adc_api.execute_javascript */
  procedure execute_javascript(
    p_plsql in varchar2);


  /* @see adc_api.exclusive_or */
  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type;


  /* @see adc_api.not_null */
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type;
    
    
  /* @see adc_api.notify */
  procedure notify(
    p_text in varchar2);


  /* @see adc_api.register_error */
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);


  /* @see adc_api.register_error */
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null);


  /* @see adc_api.register_error */
  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);


  /* @see adc_api.register_mandatory */
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);
    
  
  /* @see adc_api.register_observer */
  function register_observer
    return varchar2;


  /* @see adc_api.set_session_state */
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_2%type default null);


  /* @see adc_api.set_value_from_stmt */
  procedure set_value_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stmt in varchar2);


  /* @see adc_api.stop_rule */
  procedure stop_rule;


  /* @see adc_api.validate_page */
  procedure validate_page;
end adc_internal;
/
