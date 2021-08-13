create or replace package adc_util
  authid definer
as

  /* Types */
  subtype ora_name_type is varchar2(128 byte);
  subtype sql_char is varchar2(4000 byte);
  subtype max_char is varchar2(32767 byte);
  subtype flag_type is &FLAG_TYPE.;
   
  /* Record with environmental information about the actually executed rule
   * @usage  Is used in adc_validation for checks against the meta data of ADC
   */
  type environment_rec is record(
    cgr_id adc_rule_groups.cgr_id%type,
    app_id adc_rule_groups.cgr_app_id%type,
    page_id adc_rule_groups.cgr_page_id%type);
  

  /* Package constants */
  C_WITH_UNIT_TESTS constant boolean := &WITH_UT.;
  C_NO_FIRING_ITEM constant varchar2(30 byte) := 'DOCUMENT';
  C_INITIALIZE_EVENT constant varchar2(25) := 'initialize';    
  
  C_ADC constant ora_name_type := 'ADC';
  C_CR constant varchar2(2 byte) := chr(10);
  
  /** Method for determining truth values
   */
  function C_TRUE
    return flag_type;
    
  function C_FALSE
    return flag_type;
    
  
  /** Method to retrieve a replacement char for # character
   * %usage  Used to mask the # character to avoid page effects in UTL_TEXT.
   *         When delivering the JavaScript code, the character will be replaced by the # character again
   */
  function C_HASH
    return varchar2;
  
  /* Helper to map different boolean values to TRUE or FALSE 
   * %param  p_bool  Boolean value that is to be converted
   * %return adc_util.C_TRUE | adc_util.C_TRUE
   * %usage  Is used to map "TRUTHY" values to true and "FALSY" value to false.
   *         Used to stabilize im- and export of meta data between versions of ADC
   */
  function get_boolean(
    p_bool in varchar2)
    return adc_util.flag_type;
    
  
  function bool_to_flag(
    p_bool in boolean)
    return adc_util.flag_type;
    
  
  /* Wrapper around TO_NUMBER that extracts a GROUP selector from the conversion map
   * @param  p_number      Number string to convert
   * @param  p_conversion  Conversion mask, possibly containing a group selector
   * @return Converted number
   * @usage  Is used to extract a group selector from the conversion mask to avoid errors
   */
  function to_number(
    p_number in varchar2,
    p_conversion in varchar2)
    return number;
  
  /* Helper to create a string adc_util.C_TRUE/FALSE based upon parameter value.
   * %param  p_bool  Flag to indicate which string is required
   * %usage  Is used in export scripts to replace the actual boolean value with a reference to this package
   *         This is required to make the export scripts eligible for any FLAG_TYPE
   */
  function to_bool(
    p_bool in flag_type)
    return varchar2;


  /** Helper to sanitize any ADC name to comply with internal naming rules
   * @param  p_name  Name to sanitize
   * @return Name that adheres to the following naming conventions:
   *         - no quotes
   *         - no blanks (replaced by underscores)
   *         - all uppercase
   *         - legnth limit 50
   */
  function clean_adc_name(
    p_name in varchar2)
    return varchar2;
    
  
  /** Wrapper around PIT.get_trans_item_name that sets the trans item group to ADC
   * @param  p_item      Item to translate
   * @param [p_msg_args] Optional list of arguments to incorporate into the translated item name
   * @return Translated item name
   */
  function get_trans_item_name(
    p_item in varchar2,
    p_msg_args in msg_args default null)
    return varchar2;
  
  
  /** Method to savely close a cursor
   * @param  p_cur  Cursor which may still be open
   * @usage  The method checks whether the cursor is still open and closes it in this case.
   */
  procedure close_cursor(
    p_cur in sys_refcursor);
  
  
  /** Method to monitor that loops can't go into infinite loop mode
   * @param [p_counter]   Variable that holds the amount of loops
   * @param [p_loop_name] Information required to identify the loop that has gone wild
   * @usage  If the parameters are NULL, a new monitor is instantiated. Within the 
   *         loop this method is called with a variable holding the amount of loops so far
   *         The method increments this variable and checks it against the maximally allowed
   *         loop operations. If it exceeds this limit, an exception is thrown
   */
  procedure monitor_loop(
    p_counter in number default null,
    p_loop_name in varchar2 default null);

end adc_util;
/