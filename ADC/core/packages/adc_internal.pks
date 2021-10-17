create or replace package adc_internal
  authid definer
  --accessible by (package adc_plugin, package adc_api)
as
  
  
  /** 
    Package: ADC_INTERNAL 
      Implements a dynamic controller for APEX pages. Internal package, may only be called
      from package <ADC_PLUGIN> and <ADC_API>.
      
    How it works::
      When ADC is used to dynamically control an APEX page, it must distinguish two scenarios:
      
      - The page is initially rendered
      - A dynamic request must be processed
      
    The page is rendered::
      When the page is rendered, ADC must understand which page elements to bind event handlers to.
      This information can be taken from table <ADC_PAGE_ITEMS> which is maintained during administration
      of the page rules. ADC detects "relevant" page items by examining the technical condition of a rule
      against the APEX data dictionary. If it finds page items which are referenced within the technical
      condition, those will be marked as relevant.
      
      Another reason for a page item to become relevant is that it has been set to be initially mandatory
      or if it was recognized that the page item is a number or date item. In these cases, ADC must assure
      that mandatory items are automatically checked and values entered in number or date items are valid
      numbers or dates.
      
      It must also perform business rules to compute the initial visual state of the page.
      This is achieved by performing the same steps as explained below for the dynamic request. If the
      page is rendered, no firing item is known. ADC uses <ADC_UTIL.C_NO_FIRING_ITEM> in this case.
      
    ADC responses to a dynamic request::
      When ADC responds to a dynamic request, the main task is to analyze the actual "page state"
      The page state is maintained by package <ADC_PAGE_STATE>. See there for further information on the page state.
      
      The flow is that all page state values are provided to a decision table that is stored in <ADC_RULE_GROUPS>.CGR_DECISION_TABLE
      for the rule group of the APEX page actually executed. Based on this page state, a rule is selected from
      the set of rules. If more than one rule matches the page state (a match is reached if the technical
      condition is true and the triggering element is included in the rule's list of triggering elements), the first rule
      (i.e. the rule with the lowest sort order) is selected. If no rule matches, nothing happens.
      When a rule is found, all attached rule actions of that rule are executed in sort order.
      Each rule action can contain JavaScript snippets and/or PL/SQL code. The PL/SQL code is enriched by the
      requested parameter values and executed immediately. JavaScript is also enriched, but collected in a
      JavaScript response stack.
      
      A PL/SQL block can change the page state of a page element. When this happens, that page element is pushed onto a 
      recursion stack. The recursion stack is maintained in package <ADC_RECURSION_STACK>.  See there for further information on the recursion stack.
      After processing all rule actions, the recursion stack is examined to find all page elements
      on the stack. If one is found, it becomes the firing item, and recursively the decision table of the rule group is
      is executed based on the changed page state, likely resulting in a new rule to be executed.
      This continues until there is no page element left on the recursion stack. To avoid infinite loops, some restrictive rules apply
      for the recursion stack. See the documentation of the <ADC_RECURSION_STACK> package for details.
      
      Upon completion, the JavaScript answer stack is serialized into a HTML script element and passed back to the calling environment.
      To avoid problems with JavaScript embedded into a JSON document, the JavaScript code is converted to a hex code representation
      and re-converted client side.
      When the re-converted script is appended to the page using jQuery, the script is immediately executed. After this, the HTML script element is
      deleted from the page.
               
    Author::
      Juergen Sieben, ConDeS GmbH
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
  
  /**
    Group: Getter
   */
  /**
    Function: get_cgr_id
      Method to retreive the actually processed rule group id
                
    Returns:
      CGR_ID actually in use.
   */
  function get_cgr_id
    return adc_rule_groups.cgr_id%type;


  /**
    Function: get_event
      Getter to get the event that was raised.
                
    Returns:
      Name of the event.
   */
  function get_event
    return varchar2;
    
    
  /** 
    Function: get_event_data
      Method to retrieve additional event data information such as returned data from a modal dialog.
      If the event data is a structured JSON, <p_key> is used to extract specific information.
      IF <p_key> is NULL, the complete answer is returned
    
    Parameter:
      p_key - Optional key to filter event data.
   
    Returns:
      Complete event data string or a portion of the event data identified by <p_key>.
   */
  function get_event_data(
     p_key in varchar2)
     return varchar2;


  /* 
    Function: get_error_flag
      Getter to read the error status.
   
    Returns:
      TRUE if the execution of the ADC rule encountered an error, FALSE if not
   */
  function get_error_flag
    return boolean;
    

  /**
    Function: get_firing_item
      Getter to get the name of the firing item. If NULL, <ADC_UTIL.C_NO_FIRING_ITEM> is returned.
   
    Returns:
      Name of the firing item or <ADC_UTIL.C_NO_FIRING_ITEM> if NULL
   */
  function get_firing_item
    return varchar2;
    

  /**
    Group: ADC plugin methods
   */
  /** 
    Function: get_bind_items_as_json
      Getter to retrieve all elements that needs to be bound to an event handler as JSON.
      
      Is called during plugin initialization.
      The instance contains all relevant elements ADC needs to observe, along with the event it watches. 
      For these items ADC will instantiate an event handler that calls ADC.
      This method is called from the ADC plugin
   
    Returns: JSON instance containing name and event of all relevant page items
   */
  function get_bind_items_as_json
    return clob;
    

  /**
    Function: get_items_to_observe
      Method to retrieve a list of items that need to pass their actual value to ADC although they are not bound to an event handler.
      
      Is called during plugin initialization.
      Items which need to pass their actual value but need not be bound by an event handler are registered as observable items.
      They don't call ADC when they are changed but pass their actual value with every call to ADC raised by other items.
      This method is called from the ADC plugin
   
    Returns:
      Comma separated list of item selectors to register for observation
   */
  function get_items_to_observe
    return varchar2;
    

  /**
    Function: get_page_items
      Getter to retrieve a list of elements that potentially have changed during execution of ADC.
      
      Is used to put together a adc_util.C_DELIMITER delimited list of page items.
      This method is called from the ADC plugin
                
    Returns: C_DELIMITER delimited list of page items that potentially have changed
   */
  function get_page_items
    return varchar2;
    
    
  /** 
    Function: process_request
      Method to process an ADC request.
      
      Is used to calculate the new status of the page based on the page state values and the underlying ADC rules.
      
      Flow:
      
      - Make session state and metadata (firing item, event, event data etc.) available for the decision table
        (this data is referenced to as the page state)
      - Query decision table (ADC_RULE_GROUPS.CGR_DECISION_TABLE) against the page state
      - If a rule has to be executed, perform all assigned actions:
        - execute actions PL/SQL code immediately and 
        - collect all JavaScript
      - If a PL/SQL code changes the page state, recursively check rules to determine whether further rules have to be processed
      - If no further rule has to be processed, return all collected JavaScript snippets within a <script> element
      
      This method is called from the ADC plugin
   
    Returns:
      JavaScript code in response to the request
   */
  function process_request
    return clob;
    
    
  /**
    Procedure: read_settings
      Helper to copy plugin settings to an internal record G_PARAM.
      
      Is called before the actual rule action takes place (at the beginning of render and AJAX methods)
      to copy the plugin parameters and status to a package record.
      
      This method is called from the ADC plugin. Published separately to allow for the plugin to call
      PROCESS_INITIALIZATION_CODE if required before calling PROCESS_REQUEST.
                 
    Parameters:
      p_firing_item - Firing item
      p_event - Firing event
      p_event_data - Additional event information
   */
  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2);
  
  
  /**
    Group: ADC functionality support
   */    
  /**
    Procedure: add_javascript
      See <adc_api.add_javascript>
   */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default adc_util.C_JS_CODE);


  /**
    Procedure: check_mandatory
      See <adc_api.check_mandatory>
   */
  procedure check_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stop in adc_util.flag_type default adc_util.C_FALSE);


  /**
    Procedure: execute_action
      See <adc_api.execute_action>
   */
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type);


  /**
    Procedure: register_error
      See <adc_api.register_error>
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);


  /**
    Procedure: register_error
      See <adc_api.register_error>
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null);


  /**
    Procedure: register_item
      See <adc_api.register_item>
   */
  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);


  /**
    Procedure: register_mandatory
      See <adc_api.register_mandatory>
   */
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null);
    
  
  /**
    Procedure: register_observer
      See <adc_api.register_observer>
   */
  procedure register_observer(
    p_cpi_id in adc_page_items.cpi_id%type);


  /**
    Procedure: set_session_state
      See <adc_api.set_session_state>
   */
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_2%type default null);


  /**
    Procedure: set_value_from_statement
      See <adc_api.set_value_from_statement>
   */
  procedure set_value_from_statement(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_statement in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);


  /**
    Procedure: set_value_from_cursor
      See <adc_api.set_value_from_cursor>
   */
  procedure set_value_from_cursor(
    p_cursor in out nocopy sys_refcursor);


  /**
    Procedure: stop_rule
      See <adc_api.stop_rule>
   */
  procedure stop_rule;


  /* <adc_api.validate_page> */
  procedure validate_page;
end adc_internal;
/
