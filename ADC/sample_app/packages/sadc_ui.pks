create or replace package sadc_ui
  authid definer
as

  /** Maintain ADC rules via an APEX frontend
   * @author Juergen Sieben, ConDeS GmbH
   * @headcom
   * %usage  This package implements the methods required for the ADC Sample Application
   */
   
   
  /** Method for determining truth values
   */
  function C_TRUE
    return adc_util.flag_type;
    
  function C_FALSE
    return adc_util.flag_type;
    
  
  /** Method to automoatically calculate previous and next button values based on navigation list
   */
  procedure calculate_prev_next;
    
    
  /** Method to validate a date field
   * %usage  Is called to validate a date field
   *         Checks whether a date is in the future and wether it is a working day.
   */
  procedure validate_p6_date; 
    
    
  /** Method to validate a number field
   * %usage  Is called to validate a number field
   *         Checks whether a number is between 100 and 1000 and divisible by 3.
   */
  procedure validate_p6_number; 
    
  
  /** Method to check whether the supplied job is eligible for a commission_pct
   * %usage  Is called to check whether a job is eligible for commission. This is detected
   *         by queriying column JOBS.COMM_ELIGIBLE
   */
  function is_comm_eligible(
    p_job_id in jobs.job_id%type)
    return adc_util.flag_type;
    
  
  /** Method to print a description text SADC.<P_TEXT_ID>
   * %param  p_text_id  ID of the text
   * %usage  Is used to print html coded text into dynamic PL/SQL regions
   */
  procedure print_text(
    p_text_id in varchar2);
    
    
  /** Methods to maintain page edpti
   */
  function validate_edpti
    return boolean;

  procedure process_edpti;
  
  
  /** Methods to maintain page adact
   */
  procedure adact_control_action;
  
  
  /** Method prints the help text for a given action type
   * %param  p_cat_id  ID of the action type to print the help text for
   * %usage  Is used to display the help text for the documentation pages
   */
  procedure print_help_text(
    p_cat_id in adc_action_types.cat_id%type);
    
end sadc_ui;
/