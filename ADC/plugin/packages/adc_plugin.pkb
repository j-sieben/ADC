create or replace package body adc_plugin 
as

  /**  Package constants */
  C_CS adc_util.ora_name_type; -- Semi-constant, defaults to database character set
  C_CS_ISO constant adc_util.ora_name_type := 'WE8ISO8859P1';
  C_EVENT_INITIALIZE constant adc_util.ora_name_type := 'initialize';
  C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_adc';
  
  procedure initialize
  as
  begin
    select value
      into C_CS
      from nls_database_parameters 
     where parameter='NLS_CHARACTERSET';
  exception
    when NO_DATA_FOUND then
      -- character set is UTF8 already, no need to convert
      null;
  end initialize;
  
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    l_result apex_plugin.t_dynamic_action_render_result;
    l_java_script adc_util.max_char;
  begin
    pit.enter_mandatory;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialize
    adc_internal.read_settings(
      p_firing_item => coalesce(apex_application.g_x01, adc_util.C_NO_FIRING_ITEM),
      p_event => coalesce(apex_application.g_x02, C_EVENT_INITIALIZE),
      p_event_data => apex_application.g_x03);
    
    -- Process initialization rules of ADC for that page. 
    -- Response is a JavaScript that is executed on the page, converted to C_CS_ISO if necessary.
    -- The respoonse gets converted to a hex representation to circumvent JSON formatting problems
    l_java_script := adc_internal.process_request;
    if C_CS != C_CS_ISO then
      l_java_script := convert(l_java_script, C_CS_ISO);
    end if;
    l_java_script := utl_raw.cast_to_raw(l_java_script);
    
    -- Compose Javascript for plugin instantiation on the page
    l_result.javascript_function := C_JS_FUNCTION;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    l_result.attribute_01 := adc_internal.get_bind_items_as_json;
    l_result.attribute_02 := adc_internal.get_page_items;
    l_result.attribute_03 := p_plugin.attribute_01;
    l_result.attribute_04 := l_java_script;
    l_result.attribute_05 := adc_internal.get_items_to_observe;
    
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
    
    -- Initialize
    adc_internal.read_settings(
      p_firing_item => apex_application.g_x01,
      p_event => apex_application.g_x02,
      p_event_data => apex_application.g_x03);
    
    -- Process best matching rule of ADC for the actual page state. Response is a JavaScript that is executed on the page
    l_java_script := adc_internal.process_request;
    
    -- Return JavaScript response
    htp.prn(l_java_script);
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
begin
  initialize;
end adc_plugin;
/
