create or replace package adc_apex_action
  authid definer
as

  /**
    Package: ADC_APEX_ACTIONS
    
             Helper package to maintain APEX Actions from within ADC. The package offers a set of methods
             to adjust the APEX Action and creates a JavaScript snippet to change the APEX Action code on the page

    Author: Juergen Sieben, ConDeS GmbH

   */

  /*+
    Procedure: action_init
                 Method initializes an ACTION JavaScript code. This method is called first before setting action options.
                 
    Parameter:
      p_action_name - Name of the action
   */
  procedure action_init(
    p_action_name in adc_apex_actions_v.caa_name%type);


  /**
    Function: get_action_script
                Method to retrieve the created JavaScript 
   
    Returns:
      JavaScript code to include in the ADC answer to adjust APEX Action settings on the page.
   */
  function get_action_script
    return varchar2;


  /**
    Procedure: set_href
                 Method to set the HREF param in an ACTION type APEX-Action and resets the
                 ACTION attribute to NULL
   
    Parameter:
      p_href  Link that is set within the action
   */
  procedure set_href(
    p_href in adc_apex_actions_v.caa_href%type);


  /**
    Procedure: set_action
                 Method to set the ACTION param in an ACTION type APEX-Action and resets the
                 HREF attribute to NULL
   
    Parameter:
      p_href - Link that is set within the action
   */
  procedure set_action(
    p_action in adc_apex_actions_v.caa_action%type);


  /**
    Procedure: execute_immediate
                 Method to execute the action, either immediately or after setting all attributes first.
                 Use this method to execute the action you're working on directly.
                 When calling this method with <p_inline> = TRUE it is possible to execute the action and
                 adjust action settings directly afterwards, e.g. disabling the action.
   
    Parameter:
      p_inline - Optional flag to indicate whether the command to execute the action shall be
      
                 - TRUE: included directly when this method is called or
                 - FALSE (Default): after all action settings, before the additional JavaScript code
   */
  procedure execute_immediate(
    p_inline in boolean default false);


  /**
    Procedure set_label
                Method to adjust the action label.
                
    Parameter:
      p_label - Label that is to be set for this action
      p_is_key - Flag to distinguish plain label text (false) from reference to APEX_MESSAGE (true). Default to true.
   */
  procedure set_label(
    p_label in adc_apex_actions_v.caa_label%type,
    p_is_key in boolean default false);


  /**
    Procedure: set_title
                 Method to adjust the action title

    Parameters:
      p_title - Title that is to be set for this action
      p_is_key - Flag to distinguish plain label text (false) from reference to APEX_MESSAGE (true). Default to true.
   */
  procedure set_title(
    p_title in adc_apex_actions_v.caa_title%type,
    p_is_key in boolean default false);


  /**
    Procedure: set_disabled
                 Method to disable or enable an action

    Parameter:
      p_disabled  Flag to indicate whether
      
                  - TRUE: The action is disabled or
                  - FALSE: The action is enabled
   */
  procedure set_disabled(
    p_disabled in boolean);


  /**
    Procedure: set_visible
                 Method to control the visibility of the UI-elements attached to the action
   
    Parameter:
      p_visible  Flag to indicate whether
      
                 - TRUE: The action is invisible or
                 - FALSE: The action is visible
   */
  procedure set_visible(
    p_visible in boolean);


  /**
    Procedure: add_script
                 Method to add a script that shall be executed after the settings for the actions have taken place.
                 
    Parameter:
      p_script  JavaScript-chunk (without javascript:-Prefix) that shall be executed
   */
  procedure add_script(
    p_script in varchar2);

end adc_apex_action;
/