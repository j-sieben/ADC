create or replace package adc_page_state
  authid definer
  accessible by (package adc_internal)
as

  C_FROM_SESSION_STATE constant adc_util.sql_char := 'FROM_SESSION_STATE';

  /** Package to implement the page state API
   * The Page State is separated from the session state in that it contains all items required by the
   * ADC rule, not necessary anything that is in session state. It also persists date and number values
   * as the respective type and not as a string only as the session state does.
   * It is designed as a cache to prevent recurring conversion and environment switches during the 
   * processing of a request which may call the rule view more than once.
   * If a value is set via ADC, it harmonizes the cache and the session state for the changed items.
   */
   
  /** Helper method to reset the page state cache
   * %usage  Is called before and after a request is processed to reset any page state values
   */
  procedure reset;
  
  
  /** Method to set a page item value both in session state and in page state cache
   * @usage  Analyzes, whether the firing item has got a conversion mask. If so, ...
   *        - it tries to convert it and catches any conversion errors
   *        - it converts the item value and stores a formatted version in the session state
   */
  procedure set_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default C_FROM_SESSION_STATE,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE);
    
  
  /** Getter method to retrieve a page state value as string
   * %param  p_cpi_id  Id of the item to retrieve.
   * %return String value of the page state for the requested item.
   * %usage  Is called internally to retrieve the page state value as string.
   *         As this method is called during initialization as well and the firing item value is requested,
   *         it must assure that no value is returned if C_NO_FIRING_ITEM is requested.
   */
  function get_string(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;
  
    
  /** Getter method to retrieve a page state value as date
   * %param  p_cpi_id       Id of the item to retrieve.
   * %param  p_format_mask  Format mask in case the page state is not yet aware of the item value
   * %param  p_throw_error  Flag to indicate whether conversion errors are ignored (C_FALSE) or not (C_TRUE)
   * %return String value of the page state for the requested item.
   * %usage  Is called internally to retrieve the page state value as date.
   */
  function get_date(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return date;
  
    
  /** Getter method to retrieve a page state value as number
   * %param  p_cpi_id       Id of the item to retrieve.
   * %param  p_format_mask  Format mask in case the page state is not yet aware of the item value
   * %param  p_throw_error  Flag to indicate whether conversion errors are ignored (C_FALSE) or not (C_TRUE)
   * %return String value of the page state for the requested item.
   * %usage  Is called internally to retrieve the page state value as number.
   */
  function get_number(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return number;
    
end adc_page_state;
/