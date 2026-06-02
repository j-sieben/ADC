create or replace package body adc_plugin 
as


  /**
    Package: ADC_PLUGIN Body
      Implements the dynamic action plugin inteface for ADC.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  /**  Package constants */
  C_CS_UTF8 constant adc_util.ora_name_type := 'AL32UTF8';
  C_EVENT_INITIALIZE constant adc_util.ora_name_type := 'initialize';
  C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_adc';
  C_SET_STATE constant varchar2(50 byte) := 'set_session_state';
  
  
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
    Function: encode_clob_utf8_base64
      Convert a CLOB into an AL32UTF8 byte stream and base64-encode it for safe
      transport inside plugin attributes.

    Parameter:
      p_clob - CLOB to encode

    Returns:
      Base64 encoded UTF-8 representation of p_clob
   */
  function encode_clob_utf8_base64(
    p_clob in clob)
    return clob
  as
    l_encoded clob;
    l_length binary_integer;
  begin
    pit.enter_detailed('encode_clob_utf8_base64');

    l_encoded := utl_text.clob_to_base64(p_clob);
    l_length := dbms_lob.getlength(l_encoded);
    pit.assert(l_length <= 32000, msg.ADC_INITIALIZE_SCRIPT_TOO_LONG);

    pit.leave_detailed;
    return l_encoded;
  end encode_clob_utf8_base64;
  
  
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
    l_encoded_script clob;
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
      -- Response is JavaScript executed on the page and transported as
      -- AL32UTF8 base64 to avoid JSON and character set issues.
      l_java_script := adc_internal.process_request;
      l_java_script := encode_clob_utf8_base64(l_java_script);

      
      -- Compose Javascript for plugin instantiation on the page
      l_result.javascript_function := C_JS_FUNCTION;
      l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
      l_result.attribute_01 := adc_internal.get_bind_items_as_json;
      l_result.attribute_02 := adc_internal.get_page_items;
      l_result.attribute_03 := p_plugin.attribute_01;
      l_result.attribute_04 := l_java_script;
      l_result.attribute_05 := adc_internal.get_additional_items;
      l_result.attribute_06 := adc_internal.get_standard_messages;
    else
      l_result.javascript_function := C_JS_FUNCTION;      
    end if;
    
    pit.leave_mandatory;
    return l_result;
  exception
    when msg.ADC_INITIALIZE_SCRIPT_TOO_LONG_ERR then
      utl_apex.set_error(
        p_page_item => 'DOCUMENT',
        p_message => msg.ADC_INITIALIZE_SCRIPT_TOO_LONG);
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

    case 
    when apex_application.g_x02 = C_SET_STATE then
      -- Pre-filter specific use case SET_SESSION_STATE
      apex_util.set_session_state(
        p_name  => apex_application.g_x01,
        p_value => trim('"' from apex_application.g_x03));
    when -- Initialize
      adc_internal.read_settings(
        p_firing_item => apex_application.g_x01,
        p_event => apex_application.g_x02,
        p_event_data => apex_application.g_x03,
        p_client_id => apex_application.g_x07) then
    
      -- Process best matching rule of ADC for the actual page state. Response is a JavaScript that is executed on the page
      l_java_script := adc_internal.process_request;
      
      -- Return JavaScript response
      print_to_stream(l_java_script);
    else
      null;
    end case;
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
end adc_plugin;
/
