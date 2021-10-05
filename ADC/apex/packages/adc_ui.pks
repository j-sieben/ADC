create or replace package adc_ui
  authid definer
as

  /** 
    Package: ADC_UI
               Maintain ADC rules via an APEX frontend.
               This package implements the methods required to maintain ADC rule groups via an APEX application
   
    Author: Juergen Sieben, ConDeS GmbH
   */
   
   
  /**
    Function: C_TRUE
      Method for determining truth values. Wrapper around adc_util.C_TRUE
   */
  function C_TRUE
    return adc_util.flag_type;
    
  /**
    Function: C_FALSE
      Method for determining truth values. Wrapper around adc_util.C_FALSE
   */
  function C_FALSE
    return adc_util.flag_type;
    
    
  /** 
    Procedure: designer_selection_changed
                 Handles selection changes in the hierarchy tree to control the visual appearance of the page.
                 
                 Is used to deduct the cgr from the selected entry in the designer tree.
                 It then sets the value and refreshes the rule group report if the value has changed.
                 Plus, it analyzes which level has been selected and calls the respective DESIGNER_SHOW_FORM method
   */
  procedure designer_selection_changed;
  
  
  /** Method to show and populate a rule form
   * %usage  Is used to show the rule form section of the designer and populate it with the values selected.
   */
  procedure designer_show_form_cru;
  
  
  /** Method to show and populate a rule action form
   * %usage  Is used to show the rule action form section of the designer and populate it with the values selected.
   */
  procedure designer_show_form_cra;
    
    
  /** Toggle active flag from rule group
   * %usage  Is called to activate or deactivate a rule group
   */
  procedure toggle_cgr_active;
    

  /** Method to download one or many rule groups as a zip file
   */
  procedure process_export_cgr;
  
  
  /** Method to download action type definitions as a zip file
   */
  procedure process_export_cat;
  

  /** Method to calculate the initial export state based on session state settings
   * %return One of the states ALL|APP|SGR
   */
  function get_export_type
    return varchar2;
    
    
  /** Method to generate an apex action href attribute to create a new action
   * %usage  Is called upon page initialization of page EDIT_CRU
   */
  procedure get_url_edit_cra;


  /** Method toi initialize an APEX collection for SRA (ADC Rule Actions)
   * %usage  Is called upon initialization of page EDIT_CRU to copy existing rule actions to an APEX collection.
   *         Required to capture new rule actions without  saving them to the target table directly
   */
  procedure initialize_cra_collection;
  

  /** Method to validate page EDIT_CRU
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_cru
    return boolean;
    
  /** Method to check a rule condition
   */
  procedure validate_rule_condition;

  /** Method to process page EDIT_CRU
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_cru;


  /** Method to prepare or update page EDIT_CRA based on Action Type selection
   * %usage  Is called if relevant changes are reported to ADC
   */
  procedure configure_edit_cra;


  /** Method to validate page EDIT_CRA
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_cra
    return boolean;

  /** Method to process page EDIT_CRA
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_cra;


  /** Method to validate page EDIT_CAT
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_cat
    return boolean;

  /** Method to process page EDIT_CAT
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_cat;


  /** Method to print SAT help text to help region
   * %usage  Is called to dynamically show the help text for a given SAT
   */
  procedure print_cat_help;


  /** Method to validate page EDIT_CAA
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_caa
    return boolean;

  /** Method to process page EDIT_CAA
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_caa;
  
  
  /** Method to validate page EDIT_SIF
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_cif
    return boolean;

  /** Method to process page EDIT_SIF
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_cif;


  /** Method to validate page EDIT_STG
   * %usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_ctg
    return boolean;
  
  /** Method to process page EDIT_STG
   * %usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_ctg;
  
  
  /** Helper to calculate the next sort sequence number for a Rule
   * %return Next sort sequence value
   * %usage  Is used to preset the sort sequence if a new rule is added.
   *         Calculated in steps of 10
   */
  function get_cru_sort_seq
    return number;


  /** Helper to calculate the next sort sequence number for a Rule Action
   * %return Next sort sequence value
   * %usage  Is used to preset the sort sequence if a new rule action is added.
   *         Calculated in steps of 10
   */
  function get_cra_sort_seq
    return number;


  /** Method to calculate a help text for an Action Type
   * %usage  Prints a help text based on action type metadata via the http stream.
   */
  procedure get_action_type_help;
  
  
  /** Method to set the CGR_ID based on APP- and PAGE_ID selected
   */
  procedure set_cgr_id;


  /** Method to maintain APEX actions for page ADMIN_CGR
   * %usage  Is called if relevant changes are reported to ADC
   */
  procedure set_action_admin_cgr;

  /** Method to maintain APEX actions for page EDIT_CGR
   * %usage  Is called if relevant changes are reported to ADC
   */
  procedure set_action_edit_cgr;

  /** Method to maintain APEX actions for page EXPORT_CGR
   * %usage  Is called if relevant changes are reported to ADC
   */
  procedure set_action_export_cgr;

  /** Method to maintain APEX actions for page EDIT_CRU
   * %usage  Is called if relevant changes are reported to ADC
   */
  procedure set_action_edit_cru;

end adc_ui;
/