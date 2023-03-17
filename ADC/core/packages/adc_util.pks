create or replace package adc_util
  authid definer
as

  /**
    Package: ADC_UTIL
      Provides data types, constants and generic helper functions for ADC.

    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Public types
   */
  /**
    Types: Package types
      ora_name_type - Varchar2 with the same length as an Oracle name (varying between 30 byte in Oracle until version 11 and 128 byte starting with version 12)
      sql_char - Max length of a sql varchar2.
      max_char - Max length of a PL/SQL varchar2
      flag_type - Persistable representation of a boolean flag. May be defined upon installation of ADC.
  */
  subtype ora_name_type is varchar2(128 byte);
  subtype sql_char is varchar2(4000 byte);
  subtype max_char is varchar2(32767 byte);
  subtype flag_type is &FLAG_TYPE.;
  subtype tiny_char is varchar2(5 byte);
   
   
  /**
    Type: environment_rec
      Record that defines environmental information about the actually executed rule
      Is used in adc_validation for checks against the meta data of ADC
      
    Properties:
      crg_id - ID of the rule group actually in use
      app_id - APEX application ID
      page_id - APEX application page ID
   */
  type environment_rec is record(
    crg_id adc_rule_groups.crg_id%type,
    app_id adc_rule_groups.crg_app_id%type,
    page_id adc_rule_groups.crg_page_id%type);
  

  /**
    Group: Public constants
   */
  /**
    Constants: Public constants
      C_PARAM_GROUP - Name of the parameter group used to bundle the ADC parameters;
      C_ADC - Name of the UI message group name used for translatable items
      
      C_WITH_UNIT_TESTS - Flag to indicate whether utPLSQL is installed in a sufficient version;
      
      C_MAX_LENGTH - Integer value to indicate a length limit for certain operations;
      C_NO_FIRING_ITEM - Name of the firing item that is used if no firing item is present, required when initializing a page;
      C_INITIALIZE_EVENT - Event that is used if the page initializes;
        
      C_JS_CODE - Output level for JavaScript executable scripts. All levels are used to decide whether the respective information is to be integrated into the answer of ADC
      C_JS_RULE_ORIGIN - Output level for Rule origin messages
      C_JS_DEBUG - Output level for debug informations
      C_JS_COMMENT - Output level for additional comments
      C_JS_DETAIL - Output level for detailed comments
      C_JS_VERBOSE - Output level for verbose comments
      
      C_PARAM_ITEM_VALUE - Constant used in parameter values to indicate that the actual item value should be inserted.
      
      C_DELIMITER - Limiter used for certain text operations
      C_CR - Carriage return 
  */
  C_PARAM_GROUP constant adc_util.ora_name_type := 'ADC';
  C_ADC constant ora_name_type := 'ADCA';
  
  C_WITH_UNIT_TESTS constant boolean := &WITH_UT.;
  C_WITH_FLOWS constant boolean := &WITH_FLOWS.;
  
  C_MAX_LENGTH constant binary_integer := 24000;
  C_NO_FIRING_ITEM constant varchar2(30 byte) := 'DOCUMENT';
  C_INITIALIZE_EVENT constant varchar2(25) := 'initialize';
    
  C_JS_CODE constant binary_integer := pit.LEVEL_FATAL;
  C_JS_RULE_ORIGIN constant binary_integer := pit.LEVEL_ERROR;
  C_JS_DEBUG constant binary_integer := pit.LEVEL_WARN;
  C_JS_COMMENT constant binary_integer := pit.LEVEL_INFO;
  C_JS_DETAIL constant binary_integer := pit.LEVEL_DEBUG;
  C_JS_VERBOSE constant binary_integer := pit.LEVEL_ALL;
  
  C_PARAM_ITEM_VALUE constant adc_util.ora_name_type := 'ITEM_VALUE';
  C_PARAM_EVENT_DATA constant adc_util.ora_name_type := 'EVENT_DATA';
  C_PARAM_METHOD constant adc_util.ora_name_type := '#METHOD#';
  C_PARAM_SELECTOR constant adc_util.ora_name_type := '#SELECTOR#';
  
  C_DELIMITER constant varchar2(1 byte) := ',';
  
  /**
    Group: Public methods
   */
  /**
    Function: C_CR
      Getter method to retrive a operation system aware return character
   */
  function C_CR
    return varchar2;
    
    
  /**
    Function: C_APOS
      Getter method to retrive an apostrophe character
   */
  function C_APOS
    return varchar2;
    
    
  /** 
    Function: C_TRUE
      Getter method to retrieve a TRUE value as a flag_type
   */
  function C_TRUE
    return flag_type;    
  
  /** 
    Function: C_FALSE
      Getter method to retrieve a FALSE value as a flag_type
   */
  function C_FALSE
    return flag_type;
    
  
  /** 
    Function: C_HASH
      Method to retrieve a replacement char for # character
      Used to mask the # character to avoid page effects in UTL_TEXT.
      When delivering the JavaScript code, the character will be replaced by the # character again
   */
  function C_HASH
    return varchar2;
  
  
  /**
    Function: get_boolean
      Helper to map different boolean values to TRUE or FALSE.
      Is used to map "TRUTHY" values to true and "FALSY" value to false.
      Used to stabilize im- and export of meta data between versions of ADC
                
    Parameter:
      p_bool - Boolean value that is to be converted
      
    Returns: adc_util.C_TRUE | adc_util.C_TRUE
   */
  function get_boolean(
    p_bool in varchar2)
    return adc_util.flag_type;
    
  
  /** 
    Function: bool_to_flag
      Method to cast a boolean value to it's flag_type representation
                  
    Parameter: 
      p_bool - Boolean value to convert
   */
  function bool_to_flag(
    p_bool in boolean)
    return adc_util.flag_type;
  
  /**
    Function: to_bool
      Helper to create a string adc_util.C_TRUE/FALSE based upon parameter value.
      Is used in export scripts to replace the actual boolean value with a reference to this package.
      This is required to make the export scripts eligible for any FLAG_TYPE.
                
    Parameter:
      p_bool - Flag to indicate which string is required
   */
  function to_bool(
    p_bool in flag_type)
    return varchar2;


  /**
    Function: to_javascript_boolean
      Method to retrieve a JavaScript boolean value from a adc_util.FLAG_TYPE.
      
    Parameter: 
      p_flag - Flag to convert
      
    Returns:
      String containing true or false
   */
  function to_javascript_boolean(
    p_flag in adc_util.flag_type)
    return varchar2;
    

  /** 
    Function: clean_adc_name
      Helper to sanitize any ADC name to comply with internal naming rules
      Name that adheres to the following naming conventions:
      - no quotes
      - no blanks (replaced by underscores)
      - all uppercase
      - length limit 50
    
    Parameter:
      p_name - Name to sanitize
      
    Returns:
      sanitized name
   */
  function clean_adc_name(
    p_name in varchar2)
    return varchar2;
    
    
  /**
    Function: harmonize_page_item_name
      Method to assure that a page item has got a page prefix
      
    Parameter:
      p_cpi_id - Name of the page item to harmonize
      
    Returns: Page item name with page prefix
   */
  function harmonize_page_item_name(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;
    
  
  /** 
    Function: get_trans_item_name
      Wrapper around PIT.get_trans_item_name that sets the trans item group to ADC
                
    Parameters:
      p_item - Item to translate
      p_msg_args - Optional list of arguments to incorporate into the translated item name
      
    Returns:
      Translated item name
   */
  function get_trans_item_name(
    p_item in varchar2,
    p_msg_args in msg_args default null)
    return varchar2;
  
  
  /**
    Procedure: close_cursor
      Method to savely close a cursor
      The method checks whether the cursor is still open and closes it in this case.
      
    Parameter:
      p_cur - Cursor which may still be open
   */
  procedure close_cursor(
    p_cur in sys_refcursor);
  
  
  /**
    Procedure: monitor_loop
      Method to monitor that loops can't go into infinite loop mode.
      If the parameters are NULL, a new monitor is instantiated. Within the 
      loop this method is called with a variable holding the amount of loops so far
      The method increments this variable and checks it against the maximally allowed
      loop operations. If it exceeds this limit, an exception is thrown
      
    Parameters:
      p_counter - Optional variable that holds the amount of loops
      p_loop_name - Optional name of the the loop to monitor
   */
  procedure monitor_loop(
    p_counter in number default null,
    p_loop_name in varchar2 default null);
    
    
  /**
    Function: get_additional_nd_comments
      Method collects additional comments in NaturalDocs syntax and returns them
      as CLOB. The content of the comments describes tables and views and picks up
      their comments and column names.
      
      Add the resulting comments to a sql file that is not executed or commented out
      to make these available for NaturalDocs.
   */
  function get_additional_nd_comments
    return clob;


  /**
    Function: get_test_mode
      Method to retrieve the actual test mode state
      
    Returns:
      - TRUE, if package is in test mode
      - FALSE otherwise
   */
  function get_test_mode
    return boolean;
    
    
  /**
    Procedure: set_test_mode
      Method to set the actual test mode state
    
    Parameters:
      p_flag - Flag to indicate whether test mode is set to TRUE or FALSE
   */
  procedure set_test_mode(
    p_flag in boolean);
    
    
  /**
    Function: get_environment
      Method to populate an instance of <environment_rec> with actual information.
      
    Returns:
      Instance of <environment_rec>
   */
  function get_environment
    return environment_rec;
    
end adc_util;
/