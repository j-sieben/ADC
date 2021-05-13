create or replace package body adc_plugin 
as
  
  /* DEFAULT PLUGIN FUNCTIONALITY */
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_adc';
    l_result apex_plugin.t_dynamic_action_render_result;
    l_java_script adc_util.max_char;
  begin
    pit.enter_mandatory;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    $IF adc_util.C_WITH_UNIT_TESTS $THEN
    adc_internal.initialize_test;
    $END
    
    -- Initialize
    adc_internal.read_settings(
      p_firing_item => apex_application.g_x01,
      p_event => apex_application.g_x02,
      p_event_data => apex_application.g_x03);
    
    -- Initialize session status with page item default values
    adc_internal.process_initialization_code;
    
    -- Process initialization rules of ADC for that page. Response is a JavaScript that is executed on the page
    l_java_script := adc_internal.process_request;
    
    -- Compose response
    l_result.javascript_function := C_JS_FUNCTION;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    l_result.attribute_01 := adc_internal.get_bind_items_as_json;
    l_result.attribute_02 := adc_internal.get_page_items;
    l_result.attribute_03 := p_plugin.attribute_01;
    l_result.attribute_04 := utl_raw.cast_to_raw(l_java_script);
    l_result.attribute_05 := adc_internal.register_observer;
    
    pit.leave_mandatory;
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
    l_java_script adc_util.max_char;
  begin
    pit.enter_mandatory;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    $IF adc_util.C_WITH_UNIT_TESTS $THEN
    adc_internal.initialize_test;
    $END
    
    -- Initialize
    adc_internal.read_settings(
      p_firing_item => apex_application.g_x01,
      p_event => apex_application.g_x02,
      p_event_data => apex_application.g_x03);
    
    -- Process best matching rule of ADC for the actual page state. Response is a JavaScript that is executed on the page
    l_java_script := adc_internal.process_request;
    
    -- Return response
    htp.prn(l_java_script);
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
end adc_plugin;
/
