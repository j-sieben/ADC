create or replace package body adc_plugin 
as

  /**  Package constants */
  C_CS_ISO constant adc_util.ora_name_type := 'WE8ISO8859P1';
  C_EVENT_INITIALIZE constant adc_util.ora_name_type := 'initialize';
  C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_adc';
  
  
  /**
    Procedure: print_to_stream
      Helper method to print JavaScript code larger than 32KByte to the http stream
    
    Parameter:
      p_script - CLOB to print. Realistic maximum size is around 100KByte.
   */
  procedure print_to_stream(
    p_script in clob)
  as
    l_temp adc_util.max_char;
    l_amount number := 32000;
    l_offset number := 1;
    l_length number := dbms_lob.getlength(p_script);
  begin
    pit.enter_detailed('print_to_stream');
    
    while l_length >= l_offset loop
        l_temp:= dbms_lob.substr(p_script, l_amount, l_offset);
        htp.prn(l_temp);
        l_offset := l_offset + length(l_temp);
    end loop;
    
    pit.leave_detailed;
  end print_to_stream;
  
  
  /**
    Function: get_database_character_set (result_cache)
      
    Returns: Character set of the database
   */
  function get_database_character_set
    return adc_util.ora_name_type
    result_cache
  as
    l_cs adc_util.ora_name_type;
  begin
    select value
      into l_cs
      from nls_database_parameters 
     where parameter='NLS_CHARACTERSET';
    return l_cs;
  exception
    when NO_DATA_FOUND then
      -- character set is UTF8 already, no need to convert
      return null;
  end get_database_character_set;
  
  
  /**
    Function: render
      See <ADC_PLUGIN.render>
   */
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
    if adc_internal.read_settings(
         p_firing_item => coalesce(apex_application.g_x01, adc_util.C_NO_FIRING_ITEM),
         p_event => coalesce(apex_application.g_x02, C_EVENT_INITIALIZE),
         p_event_data => apex_application.g_x03) then
    
      -- Process initialization rules of ADC for that page. 
      -- Response is a JavaScript that is executed on the page, converted to C_CS_ISO if necessary.
      -- The respoonse gets converted to a hex representation to circumvent JSON formatting problems
      l_java_script := adc_internal.process_request;
      if get_database_character_set != C_CS_ISO then
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
      l_result.attribute_06 := adc_internal.get_standard_messages;
    else
      l_result.javascript_function := C_JS_FUNCTION;      
    end if;
    
    pit.leave_mandatory;
    return l_result;
  end render;
  
  
  /**
    Function: ajax
      See <ADC_PLUGIN.ajax>
   */
  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
    l_java_script adc_util.max_char;
  begin
    
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    pit.enter_mandatory;
    -- Initialize
    if adc_internal.read_settings(
         p_firing_item => apex_application.g_x01,
         p_event => apex_application.g_x02,
         p_event_data => apex_application.g_x03) then
    
      -- Process best matching rule of ADC for the actual page state. Response is a JavaScript that is executed on the page
      l_java_script := adc_internal.process_request;
      
      -- Return JavaScript response
      print_to_stream(l_java_script);
    end if;
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
end adc_plugin;
/
