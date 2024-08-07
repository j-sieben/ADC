create or replace package body splitter_plugin
as
  
  g_in_error_handling_callback boolean := false;  
    
  /**
    Function: is_numeric
      Checks whether p_str is numeric
    
    Returns:
      TRUE, if p_str is numeric and FALSE if not
   */
  function is_numeric(
    p_str varchar2)
  return boolean
  as
    l_number number := p_str;
  begin
    return true;
  exception
    when others then
      return false;
  end is_numeric;
  
  
  /**
    Function: error_function_callback
      Private function to include the apex error handling function, if one is
      defined on application or page level.
    
    Parameter:
      p_error - Error type as defined in APEX_ERROR
      
    Returns:
      Error result as defined in APEX_ERROR.
   */
  function error_function_callback(
    p_error in apex_error.t_error)
  return apex_error.t_error_result
  as
    C_CR constant adc_util.tiny_char := chr(10);
    C_STMT_TEMPLATE adc_util.max_char := 'declare #CR#  l_error apex_error.t_error;#CR#begin#CR#  l_error := apex_error.g_error;#CR#  apex_error.g_error_result := #FCT# (#CR    p_error => l_error );#CR#end;';
      
    l_error_handling_function apex_application_pages.error_handling_function%type;
    l_statement adc_util.max_char;
    l_result apex_error.t_error_result;
  begin
    pit.enter_optional('error_function_callback');
    
    if not g_in_error_handling_callback then
      g_in_error_handling_callback := true;
    
      begin
        select /*+ result_cache */
               coalesce(p.error_handling_function, f.error_handling_function)
          into l_error_handling_function
          from apex_applications f
          left join apex_application_pages p
            on f.application_id = p.application_id
           and p.page_id = apex_application.g_flow_step_id
         where f.application_id = apex_application.g_flow_id;
      exception when NO_DATA_FOUND then
        null;
      end;
    end if;
    
    if l_error_handling_function is not null then    
      l_statement := replace(replace(C_STMT_TEMPLATE, '#CR#', C_CR), '#FCT#', l_error_handling_function);
    
      apex_error.g_error := p_error;
    
      begin
        apex_exec.execute_plsql(
          p_plsql_code => l_statement);
      exception when others then
        pit.raise_error(msg.PIT_SQL_ERROR);
      end;
    
      l_result := apex_error.g_error_result;
    
      if l_result.message is null
      then
        l_result.message := coalesce(l_result.message, p_error.message);
        l_result.additional_info := coalesce(l_result.additional_info, p_error.additional_info);
        l_result.display_location := coalesce(l_result.display_location, p_error.display_location);
        l_result.page_item_name := coalesce(l_result.page_item_name, p_error.page_item_name);
        l_result.column_alias := coalesce(l_result.column_alias, p_error.column_alias);
      end if;
    else
      l_result.message := p_error.message;
      l_result.additional_info := p_error.additional_info;
      l_result.display_location := p_error.display_location;
      l_result.page_item_name := p_error.page_item_name;
      l_result.column_alias := p_error.column_alias;
    end if;
    
    if l_result.message = l_result.additional_info then
      l_result.additional_info := null;
    end if;
    
    g_in_error_handling_callback := false;
    
    pit.leave_optional;
    return l_result;    
  exception
    when others then
      l_result.message := 'custom apex error handling function failed !!';
      l_result.additional_info := null;
      l_result.display_location := apex_error.c_on_error_page;
      l_result.page_item_name := null;
      l_result.column_alias := null;
      g_in_error_handling_callback := false;
      
      pit.leave_optional;
      return l_result;  
  end error_function_callback;
  

  /**
    Function: get_preference_key
      Helper function for getting the preference key based on the region id.
      
    Parameter:
      p_region_id - ID of the region the splitter is shown at
   */
  function get_preference_key(
    p_region_id varchar2)
  return varchar2
  as
    l_preference_key adc_util.ora_name_type;
  begin
    pit.enter_detailed('get_preference_key',
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id)));
                    
    l_preference_key := 'F' || utl_apex.get_application_id || '_' || p_region_id || '_SPLITTER_STATE';
    
    pit.leave_detailed;
    return l_preference_key;
  end;
  
  
  /**
    Function: get_preference
      Helper function for getting the preference value based on the region id.
      
    Parameter:
      p_region_id - ID of the region the splitter is shown at      
   */
  function get_preference(
    p_region_id varchar2)
  return varchar2
  as
    l_preference adc_util.ora_name_type;
  begin
    pit.enter_detailed('get_preference_key',
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id)));
                                        
    l_preference := apex_util.get_preference(get_preference_key(p_region_id));
    
    pit.leave_detailed;
    return l_preference;
  end;
  
  
  /**
    Procedure: set_preference
      Helper function for storing the preference
      
    Parameters:
      p_region_id - ID of the region the splitter is shown at
      p_position - Position of the divider bar
      p_collapsed - Status of the splitter region
   */
  procedure set_preference(
    p_region_id varchar2,
    p_position varchar2,
    p_collapsed varchar2)
  as
    l_preference adc_util.ora_name_type;
  begin
    pit.enter_optional('set_preference',
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id),
                    msg_param('p_position', p_position),
                    msg_param('p_collapsed', p_collapsed)));
  
    if is_numeric(p_position) and lower(p_collapsed) in ('true', 'false') then
      l_preference := p_position || ':' || lower(p_collapsed);
      apex_util.set_preference(get_preference_key(p_region_id), l_preference);
    else
      apex_debug.warn(
        p_message => 'Splitter preference for region %s is expected as nnn:[true|false] but received %s:%s',
        p0 => p_region_id,
        p1 => p_position,
        p2 => p_collapsed);
    end if;
    
    pit.leave_optional;
  end set_preference;
  
  
  /**
    Function: get_message
      Helper function for getting the title, collapse and restore messages
      
    Parameters:
      p_type - Type of the message [collapse | restore]
      p_attribute - Optional overwrites of the standard messages
    
    Returns:
      Names of the messages used for collapsing and restoring controls on the page
   */
  function get_message(
    p_type varchar2,
    p_attribute varchar2)
  return varchar2
  as
    l_collapse_text_msg varchar2(100) := 'APEX.SPLITTER.COLLAPSE_TEXT';
    l_restore_text_msg  varchar2(100) := 'APEX.SPLITTER.RESTORE_TEXT';
    l_message varchar2(1000);
  begin
    pit.enter_optional('get_message',
      p_params => msg_params(
                    msg_param('p_type', p_type),
                    msg_param('p_attribute', p_attribute)));
    
    case p_type 
    when 'collapse' then
      l_message := coalesce(p_attribute, apex_lang.message(l_collapse_text_msg));
      if l_message = l_collapse_text_msg then
          l_message := 'Collapse';
      end if;
    when 'restore' then
      l_message := coalesce(p_attribute, apex_lang.message(l_restore_text_msg));
      if l_message = l_restore_text_msg then
          l_message := 'Restore';
      end if;
    else
      null;
    end case;
  
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Message', l_message)));
    return l_message;
  end get_message;
  
  
  -- INTERFACE
  -- main plug-in entry point
  function render(
    p_region apex_plugin.t_region,
    p_plugin apex_plugin.t_plugin,
    p_is_printer_friendly boolean)
  return apex_plugin.t_region_render_result
  as
    l_result apex_plugin.t_region_render_result;
  
    -- attributes
    l_orientation p_region.attribute_01%type := p_region.attribute_01;
    l_direction p_region.attribute_02%type := p_region.attribute_02;
  
    -- position specific attributes
    l_position p_region.attribute_03%type := p_region.attribute_03;
    l_position_function p_region.attribute_04%type := 'function(){ return ' || p_region.attribute_04 || '; }';
    
    l_min_size number := p_region.attribute_05;
    l_height_function p_region.attribute_06%type := 'function(){ return ' || p_region.attribute_06 || '; }';
  
    -- preference specific attributes
    l_pos_pref apex_t_varchar2 := apex_string.split(get_preference(p_region.id), ':');
    l_has_pref boolean := l_pos_pref.count = 2;
    l_pos_pref_pos number  := case when l_has_pref then l_pos_pref(1) else null end;
    l_pos_pref_col boolean := case when l_has_pref then l_pos_pref(2) = 'true' else null end;
  
    -- options
    l_options apex_t_varchar2 := apex_string.split(p_region.attribute_10, ':');
  
    l_persist_state_pref boolean := 'persist-state' member of l_options;
    l_persist_state_local boolean := 'persist-state-local' member of l_options;
    l_continuous_resize boolean := 'continuous-resize' member of l_options;
    l_can_collapse boolean := 'can-collapse' member of l_options;
    l_drag_collapse boolean := 'drag-collapse' member of l_options;
    l_contains_iframe boolean := 'contains-iframe' member of l_options;
    l_lazy_render boolean := 'lazy-render' member of l_options;
    l_resize_jet_charts boolean := 'responsive-jet-charts' member of l_options;
  
    -- advanced options
    l_advanced_options boolean := coalesce(p_region.attribute_15, 'N') = 'Y';
  
    l_custom_selector p_region.attribute_16%type := p_region.attribute_16;
    l_step_size number := p_region.attribute_17;  
    l_key_step_size number := p_region.attribute_18;
  
    -- title messages
    l_title p_region.attribute_19%type := p_region.attribute_19;
    l_title_collapse p_region.attribute_20%type := get_message('collapse',p_region.attribute_20);
    l_title_restore p_region.attribute_21%type := get_message('restore', p_region.attribute_21);
  
    l_change_function p_region.attribute_22%type := coalesce(p_region.attribute_22, 'function(){}');
  
    l_padding_first number := coalesce(p_region.attribute_23, 16);
    l_padding_second number := coalesce(p_region.attribute_24, 16);
  
    l_region_id p_region.static_id%type := p_region.static_id;
  
    -- Javascript Initialization Code
    l_init_js_fn adc_util.max_char;
  begin
    pit.enter_mandatory;
  
    -- Initialization
    l_init_js_fn := coalesce(apex_plugin_util.replace_substitutions(p_region.init_javascript_code), 'undefined');
    
    
    if apex_application.g_debug then
      apex_plugin_util.debug_region(
        p_plugin => p_plugin,
        p_region => p_region);
    end if;   
  
    -- Initialization
    apex_json.initialize_clob_output;  
    apex_json.open_object;
  
    apex_json.write('regionId', l_region_id);
    apex_json.write('orientation', l_orientation);
    apex_json.write('direction', l_direction);
  
    -- either position+collapsed, positionCode or positionFunction must be provided
    if l_persist_state_pref and l_has_pref then
      apex_json.write('position', l_pos_pref_pos);
      apex_json.write('collapsed', l_pos_pref_col);
    else
      if l_position != 'custom' then
        apex_json.write('positionCode', l_position);
      else
        apex_json.write_raw('positionFunction', l_position_function);
      end if;
    end if;
  
    apex_json.write('minSize', l_min_size);
    apex_json.write_raw('heightFunction', l_height_function);
    apex_json.write('persistStatePref', l_persist_state_pref);
    apex_json.write('persistStateLocal', l_persist_state_local);
  
    -- the AJAX identifier is only passed along if we persist the position on the server
    if l_persist_state_pref then
      apex_json.write('ajaxIdentifier', apex_plugin.get_ajax_identifier);
    end if;
  
    apex_json.write('continuousResize', l_continuous_resize);
    apex_json.write('canCollapse', l_can_collapse);
    apex_json.write('dragCollapse', l_drag_collapse);
    apex_json.write('containsIframe', l_contains_iframe);
    apex_json.write('lazyRender', l_lazy_render);
    apex_json.write('resizeJetCharts', l_resize_jet_charts);
    apex_json.write('customSelector', l_custom_selector);
    apex_json.write('stepSize', l_step_size);
    apex_json.write('keyStepSize', l_key_step_size);
    apex_json.write('title', l_title);
    apex_json.write('titleCollapse', l_title_collapse);
    apex_json.write('titleRestore', l_title_restore);
    apex_json.write_raw('changeFunction', l_change_function);
    apex_json.write('paddingFirst', l_padding_first);
    apex_json.write('paddingSecond', l_padding_second);
  
    apex_json.close_object;
  
    apex_javascript.add_onload_code(
      p_code => 'FOS.splitter(' || apex_json.get_clob_output|| ', '|| l_init_js_fn || ');');
  
    apex_json.free_output;
  
    pit.leave_mandatory;
    return l_result;
  end;
  
  -- ajax callback for storing the current splitter position as a user preference
  function ajax(
    p_region apex_plugin.t_region,
    p_plugin apex_plugin.t_plugin)
  return apex_plugin.t_region_ajax_result
  as
    l_apex_error apex_error.t_error;
    l_result apex_error.t_error_result;
    l_return apex_plugin.t_region_ajax_result;
  begin
    pit.enter_mandatory;
    
    if apex_application.g_debug then
      apex_plugin_util.debug_region(
        p_plugin => p_plugin,
        p_region => p_region);
    end if;
  
    set_preference(
      p_region_id => p_region.id,
      p_position => apex_application.g_x01,
      p_collapsed => apex_application.g_x02);
  
    htp.p('{"status": "success"}');
  
    pit.leave_mandatory;
    return l_return;
  exception
    when others then
      apex_json.initialize_output;
      l_apex_error.message := sqlerrm;
      l_apex_error.region_id := p_region.id;
      l_apex_error.ora_sqlcode := sqlcode;
      l_apex_error.ora_sqlerrm := sqlerrm;
      l_apex_error.error_backtrace := dbms_utility.format_error_backtrace;
      
      l_result := error_function_callback(l_apex_error);

      apex_json.open_object;
      apex_json.write('status', 'error');
      apex_json.write('message', l_result.message);
      apex_json.write('additional_info', l_result.additional_info);
      apex_json.write('display_location', l_result.display_location);
      apex_json.write('page_item_name', l_result.page_item_name);
      apex_json.write('column_alias', l_result.column_alias);
      apex_json.close_object;
      
      pit.leave_mandatory;
      return l_return;
  end ajax;

end splitter_plugin;
/
