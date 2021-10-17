create or replace package adc_ui
  authid definer
as

  /** 
    Package: ADC_UI
      Maintain ADC rules via an APEX frontend.
      This package implements the methods required to maintain ADC rule groups via an APEX application.
   
    Author:: Juergen Sieben, ConDeS GmbH
   */
   
   
  /**
    Function: C_TRUE
      Method for determining truth values. Wrapper around <ADC_UTIL.C_TRUE>
   */
  function C_TRUE
    return adc_util.flag_type;
    
  /**
    Function: C_FALSE
      Method for determining truth values. Wrapper around <ADC_UTIL.C_FALSE>
   */
  function C_FALSE
    return adc_util.flag_type;
    

  /** 
    Procedure: process_export_cgr
      Method to download one or many rule groups as a zip file
   */
  procedure process_export_cgr;
  
  
  /** 
    Procedure: process_export_cat
      Method to download action type definitions as a zip file
   */
  procedure process_export_cat;
  

  /** 
    Function: get_export_type
      Method to calculate the initial export state based on session state settings
   
    Returns:
      One of the states ALL|APP|SGR
   */
  function get_export_type
    return varchar2;


  /** 
    Procedure: validate_edit_cat
      Method to validate page EDIT_CAT
      
      Is called to validate user data if the page is submitted. (CAT = ADC Action Types).
   */
  function validate_edit_cat
    return boolean;


  /** 
    Procedure: process_edit_cat
      Method to process page EDIT_CAT
      
      Is called to persist user data if the page is submitted. (CAT = ADC Action Types).
   */
  procedure process_edit_cat;
  
  
  /** 
    Procedure: validate_edit_cif
      Method to validate page EDIT_CIF
      
      Is called to validate user data if the page is submitted. (CIF = ADC Action Item Focus).
   */
  function validate_edit_cif
    return boolean;


  /** 
    Procedure: process_edit_cif
      Method to process page EDIT_CIF
      
      Is called to persist user data if the page is submitted. (CIF = ADC Action Item Focus).
   */
  procedure process_edit_cif;
  
  
  /** 
    Procedure: validate_edit_ctg
      Method to validate page EDIT_CTG
      
      Is called to validate user data if the page is submitted. (CTG = ADC Action Type Groups).
   */
  function validate_edit_ctg
    return boolean;


  /** 
    Procedure: process_edit_ctg
      Method to process page EDIT_CTG
      
      Is called to persist user data if the page is submitted. (CTG = ADC Action Type Groups).
   */
  procedure process_edit_ctg;

  /** 
    Procedure: set_action_export_cgr
      Method to maintain APEX actions for page EXPORT_CGR.
      
      Is called if relevant changes are reported to ADC.
   */
  procedure set_action_export_cgr;

end adc_ui;
/