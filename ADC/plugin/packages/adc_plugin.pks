create or replace package adc_plugin
  authid definer
as

  /**
    Package: ADC_PLUGIN
      Implements the dynamic action plugin inteface for ADC.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */

  
  /** 
    Function: render
                Standard plugin render method 
   */
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result;


  /** 
    Function: ajax
                Standard plugin ajax method 
   */
  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result;

end adc_plugin;
/