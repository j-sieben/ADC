create or replace package sadc_ui
  authid definer
as

  /** 
    Package: ADC_UI
      This package implements the methods required for the ADC Sample Application
   
    Author:: Juergen Sieben, ConDeS GmbH
   */
   
  /** 
    Group: Methods for determining truth values
   */
  /**
    Function: C_TRUE
  
    Returns:
      ADC_UTIL.C_TRUE value as parameterized.
   */
  function C_TRUE
  return adc_util.flag_type;
    
  /**
    Function: C_TRUE
  
    Returns:
      ADC_UTIL.C_TRUE value as parameterized.
   */
  function C_FALSE
  return adc_util.flag_type;
    
  /**
    Group: Application support methods
   */
  /**
    Procedure: calculate_prev_next
      Method to automoatically calculate previous and next button values based on navigation list
   */
  procedure calculate_prev_next;
  
  /**
    Function: get_adc_admin_url
      Method calculates for the UTL to address the ADC rule in the ADC administration application.
      This method is called from an application process to set the URL for a page button
  
    Returns:
      URL for the ADC admin designer page of the actual application page
   */
  function get_adc_admin_url
  return varchar2;
  
  
  /** 
    Procedure: validate_p6_date
      Method to validate a date field.
      
      Checks whether a date is in the future and wether it is a working day.
   */
  procedure validate_p6_date; 
    
    
  /**
    Procedure: validate_p6_number
      Method to validate a number field
      
      Checks whether a number is between 100 and 1000 and divisible by 3.
   */
  procedure validate_p6_number; 
    
  
  /**
    Procedure: is_comm_eligible
      Method to check whether the supplied job is eligible for a commission_pct.
      This is detected by queriying column JOBS.COMM_ELIGIBLE
   */
  function is_comm_eligible(
    p_job_id in hr_jobs.job_id%type)
  return adc_util.flag_type;
    
  
  /**
    Procedure: print_text
      Method to print a description text SADC.<P_TEXT_ID>. Is used to print html coded text into dynamic PL/SQL regions
      
    Parameter:
      p_text_id - ID of the text
   */
  procedure print_text(
    p_text_id in varchar2);
    
    
  /**
    Function: validate_edpti
      Methods to validate page edpti
      
    Returns:
      Always true. If any exception occurred, this is registered in the APEX exception stack.
   */
  function validate_edpti
  return boolean;
    
    
  /**
    Procedure: process_edpti
      Methods to process changes to page edpti
   */
  procedure process_edpti;
  
  
  /**
    Procedure: adact_control_action
      Methods to maintain page adact
   */
  procedure adact_control_action;
  
  
  /**
    Procedure: print_help_text
      Method prints the help text for a given action type on the documentation pages
      
    Parameter:
      p_cat_id - ID of the action type to print the help text for
   */
  procedure print_help_text(
    p_cat_id in adc_action_types.cat_id%type);
  
  
  /**
    Function: get_help_text
      Method returns the help text for a given action type on the documentation pages
      
    Parameter:
      p_cat_id - ID of the action type to print the help text for
      
    Returns:
      Help text, if available.
   */    
  function get_help_text(
    p_cat_id in adc_action_types.cat_id%type)
  return varchar2;
  
  
  /**
    Function: valbulk_validate
      Method validates page VALBULK
      
    Returns:
      Always TRUE, exceptions are integrated into the APEX error stack.
   */
  function valbulk_validate
    return boolean;
  
  
  /**
    Procedure: valdyn_validate
      Method validates page VALDYN
   */
  procedure valdyn_validate(
    p_filter in varchar2 default null);
    
end sadc_ui;
/