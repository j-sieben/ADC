create or replace package adc_response
  authid definer
as

  /**
    Package: ADC_RESPONSE
    
      Implements the logic to collect and format the JavaScript response a call to ADC creates.
      
      ADC creates a response script that controls the visual effects of the rule execution client side.
      To achive that, the response is created as a script html element containing a JavaScript code
      to change the visual state with the following format:
      
      --- JavaScript
<script id="S_{random id}">
  // Total duration: {duration in hsec}
  de.condes.plugin.adc.setItemValues([{"id":"Item Name","value":"Item Value"},{...}]);  // List of items changed during the rule evaluation at the database
  de.condes.plugin.adc.setErrors({
    "count":0, // error counter of this evaluation
    "firingItems":["Item Names"], // list of "touched" items, i.e. items for which rules have been evaluated. Used to remoce their assigned errors on the page
    "errors":[]}); // List of APEX error instances to display on the page

  // During installation, creation of apex.actions instances and their wiring to page items is added
  
  // Recursion 1: Rule {sort sequence} ({Name of the rule}), Firing Item: "{Name of the firing item}", Duration: {Evaluation time of the rule in hsec}
  {JavaScript code}
</script>
      ---
      
      The script element is identified by an id attribute. This allows the client side ADC functionality
      to remove the script element after appending it to the DOM tree. Appending the element to the tree
      executes the contained JavaScript. As the JavaScript answer is executed only once in response to the
      request to the ADC, it may savely be deleted after execution of the script.
      
      The content of the script partly depends on the phase the page is in. During initialization,
      more information is contained, such as metadata for apex actions which have to be added to the page
      and other information.
      
      During dynamic response to page events, only the information necessary to change the visual state or 
      the behaviour of the page are sent.

    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  
  /**
    Procedure: add_error
      Pushes an APEX error instance onto an internal error stack. 
      All errors are integrated into the response when retrieving the JavaScript answer.
      
    Parameter:
      p_error - Instance of the error in format <apex_error.t_error>.
      p_severity - In addition to APEX errors ADC supports severity to differ between error and warning
   */
  procedure add_error(
    p_error in apex_error.t_error,
    p_severity in binary_integer default pit.level_error);
    
   
  /**
    Procedure: add_javascript
      Method to add a JavaScript code snippet to the response.
      
      May be used to add comments as well. Make sure to reduce p_debug_level in this case
      to allow for conditional display of the comment based on their severity.
      
    Parameters:
      p_java_script - JavaScript code.
      p_debug_level - Level of the JavaScript code. Only a subset of the <adc_util> constants are allowed:
                      <adc_util.C_JS_CODE>, <adc_util.C_JS_RULE_ORIGIN>, <adc_util.C_JS_DEBUG>, <adc_util.C_JS_COMMENT> and <adc_util.C_JS_DETAIL>.
                      If the level is not <adc_util.C_JS_CODE>, the JavaScript is treated as a comment (commented out).
   */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default adc_util.C_JS_CODE);
    
  
  /** 
    Procedure: add_comment
      Adds a comment to the JavaScript answer if applicable. Is used to append comments about 
      the inner workings to the JavaScript answer. Whether a message is added depends on the
      severity of the message and debug level.
      
    Parameters:
      p_message_name - Name of the Message
      p_msg_args - Optional argument object
   */
  procedure add_comment(
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
    
  /** 
    Function: get_response
      Method to compose the JavaScript result of the rule evaluation
      
      Depending on parameterization and length of the response, the response will contain more or lesse code.
      As the maximum response size is limited to 32KByte, the method may decide to skip comments in order to respect the size limit.
      
      Calling this method also terminates and resets the internal response structures.
   
    Returns:
      JavaScript code to execute in response to the rule evaluation request.
   */
  function get_response
    return clob;
    
  
  /**
    Procedure: initialize_response
      Method to initialize the ADC response before evaluating the rule set.
      
      If p_initialize_mode is set, this method also adds instantiation code to the response,
      such as apex.action code should apex actions exist for the rule group.
      
    Parameters:
      p_initialize_mode - Flag to indicate whether the page initializes.
      p_crg_id - ID of the rule group to evaluate. Is used to create the initialization JavaScript code.
   */
  procedure initialize_response(
    p_initialize_mode in boolean,
    p_crg_id in adc_rule_groups.crg_id%type);
    
    
  /**
    Procedure: register_recursion_end
      Method finalizes the response of the actual recursive rule evaluation.
            
      Main task is to add timing information.
      
    Parameter:
      p_rule_found - Flag to indicate whether a rule has been found for this request
   */
  procedure register_recursion_end(
    p_rule_found in boolean);
    
    
  /**
    Procedure: register_recursion_start
      Method initializes the response of the actual recursive rule evaluation.
            
      It also adds a comment to the JavaScript stack to indicate the rule details the script originates from
      and other useful information such as the recursive depth and so forth.
  
    Parameters:
      p_origin_message - Dependent on the environment, different origins are possible. This parameter contains the message to use
      p_run_count - Counter that indicates how often the decision table was queried. 
                    ADC suppresses repeated execution of a rule, so if this number is relatively high, this may be an indicator
                    for unnecessary rules or badly written technical conditions.
      p_cru_sort_seq - Sort sequence of the rule. Used to identify the rule evaluated
      p_cru_name - Name of the rule. Used to identify the rule evaluated
      p_firing_item - Item that caused the rule to be evaluated
   */
  procedure register_recursion_start(
    p_origin_message in adc_util.ora_name_type,
    p_run_count in binary_integer,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
    p_cru_name in adc_rules.cru_name%type,
    p_firing_item in adc_util.ora_name_type);
  
  
end adc_response;
/