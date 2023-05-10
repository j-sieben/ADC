create or replace package adca_ui
  authid definer
as

  /** 
    Package: ADCA_UI
      Maintain ADC rules via an APEX frontend.
      This package implements the methods required to maintain ADC rule groups via an APEX application.
   
    Author:: Juergen Sieben, ConDeS GmbH
   */    

  /** 
    Procedure: process_export_crg
      Method to download one or many rule groups as a zip file
   */
  procedure process_export_crg;
  
  
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
    Procedure: validate_edit_cpit
      Method to validate page EDIT_CPIT
      
      Is called to validate user data if the page is submitted. (CPIT = ADC Page Item Type).
   */
  function validate_edit_cpit
    return boolean;


  /** 
    Procedure: process_edit_cpit
      Method to process page EDIT_CPIT
      
      Is called to persist user data if the page is submitted. (CPIT = ADC Page Item Type).
   */
  procedure process_edit_cpit;
  
  
  /** 
    Procedure: validate_edit_catg
      Method to validate page EDIT_CATG
      
      Is called to validate user data if the page is submitted. (CATG = ADC Action Type Groups).
   */
  function validate_edit_catg
    return boolean;


  /** 
    Procedure: process_edit_catg
      Method to process page EDIT_CATG
      
      Is called to persist user data if the page is submitted. (CATG = ADC Action Type Groups).
   */
  procedure process_edit_catg;
  
  
  /** 
    Procedure: validate_edit_cato
      Method to validate page EDIT_CATO
      
      Is called to validate user data if the page is submitted. (CATO = ADC Action Type Owners).
   */
  function validate_edit_cato
    return boolean;


  /** 
    Procedure: process_edit_cato
      Method to process page EDIT_CATO
      
      Is called to persist user data if the page is submitted. (CATO = ADC Action Type Owners).
   */
  procedure process_edit_cato;
  
  
  /** 
    Procedure: validate_edit_csm
      Method to validate page EDIT_CSM
      
      Is called to validate user data if the page is submitted. (CSM = ADC Standard Messages).
   */
  function validate_edit_csm
    return boolean;


  /** 
    Procedure: process_edit_csm
      Method to process page EDIT_CSM
      
      Is called to persist user data if the page is submitted. (CSM = ADC Standard Messages).
   */
  procedure process_edit_csm;
  
  
  /**
    Procedure: handle_capvt_changed
      Method is called if the user changes the Action Parameter Visual Type of a Action Parameter.
      
      It checks whether the parameter requires a select list or a static list. If so, it 
      shows and initializes these regions, otherwise it hides the regions.
   */
  procedure handle_capvt_changed;
  
  
  /** 
    Procedure: validate_edit_capt
      Method to validate page EDIT_CAPT
      
      Is called to validate user data if the page is submitted. (cpt = ADC Action Parameter Value Type).
   */
  function validate_edit_capt
    return boolean;


  /** 
    Procedure: process_edit_capt
      Method to process page EDIT_CAPT
      
      Is called to persist user data if the page is submitted. (CTG = ADC Action Type Groups).
   */
  procedure process_edit_capt;


  /** 
    Procedure: process_edit_capt_static_list
      Method to process page detail form R5_CAPT_STATIC_LIST_FORM
      
      Is called to persist user data if the page is submitted. (CTG = ADC Action Type Groups).
   */
  procedure process_edit_capt_static_list;


  /** 
    Procedure: set_action_export_crg
      Method to maintain APEX actions for page export_crg.
      
      Is called if relevant changes are reported to ADC.
   */
  procedure set_action_export_crg;

end adca_ui;
/