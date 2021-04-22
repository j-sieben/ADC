create or replace package adc_apex_action
  authid definer
as

  /* Method initializes an ACTION JavaScript code
   * %param  p_action_name  Name of the action
   * %usage  This method is called first before setting action options
   */
  procedure action_init(
    p_action_name in adc_apex_actions_v.caa_name%type);


  /* Method to retrieve the created JavaScript */
  function get_action_script
    return varchar2;


  /* Method to set the HREF param in an ACTION type APEX-Action
   * %param  p_href  Link that is set within the action
   * %usage  This method sets the HREF attribute of the actual action and resets the
   *         ACTION attribute to NULL
   */
  procedure set_href(
    p_href in adc_apex_actions_v.caa_href%type);


  /* Method to set the ACTION param in an ACTION type APEX-Action
   * %param  p_href  Link that is set within the action
   * %usage  This method sets the ACTION attribute of the actual action and resets the
   *         HREF attribute to NULL
   */
  procedure set_action(
    p_action in adc_apex_actions_v.caa_action%type);


  /* Method to execute the action, either immediately or after setting all attributes first
   * %param [p_inline] Flag to indicate whether the command to execute the action shall be
   *                   - TRUE: included directly when this method is called or
   *                   - FALSE (Default): after all action settings, before the additional JavaScript code
   * %usage  Use this method to execute the action you're working on directly.
   *         When calling this method with P_INLINE = TRUE it is possible to execute the action and
   *         adjust action settings directly afterwards, e.g. disabling the action.
   */
  procedure execute_immediate(
    p_inline in boolean default false);


  /* Method to adjust the action label
   * %param  p_label   Label that is to be set for this action
   * %param  p_is_key  Flag to distinguish plain label text (false) from reference to APEX_MESSAGE (true). Default to true.
   * %usage  Allows to change the label of an action on the fly, based on some condition.
   */
  procedure set_label(
    p_label in adc_apex_actions_v.caa_label%type,
    p_is_key in boolean default false);


  /* Method to adjust the action title
   * %param  p_title   Title that is to be set for this action
   * %param  p_is_key  Flag to distinguish plain label text (false) from reference to APEX_MESSAGE (true). Default to true.
   * %usage  Allows to change the label of an action on the fly, based on some condition.
   */
  procedure set_title(
    p_title in adc_apex_actions_v.caa_title%type,
    p_is_key in boolean default false);


  /* Method to disable or enable an action
   * %param  p_disabled  Flag to indicate whether
   *                     - TRUE: The action is disabled or
   *                     - FALSE: The action is enabled
   * %usage  Is used to adjust the availability of the action
   */
  procedure set_disabled(
    p_disabled in boolean);


  /* Method to control the visibility of the UI-elements attached to the action
   * %param  p_visible  Flag to indicate whether
   *                    - TRUE: The action is invisible or
   *                    - FALSE: The action is visible
   * %usage  Is used to adjust the visibility of the action.
   *         ATTENTION: This feature is available starting with APEX 5.1 only.
   */
  procedure set_visible(
    p_visible in boolean);


  /* Method to add a script that shall be executed after the settings for the actions have taken place
   * %param  p_script  JavaScript-chunk (without javascript:-Prefix) that shall be executed
   * %usage  Is used to add a non action related JavaScript command
   *         These additional script are executed after all settings for the action
   */
  procedure add_script(
    p_script in varchar2);

end adc_apex_action;
/