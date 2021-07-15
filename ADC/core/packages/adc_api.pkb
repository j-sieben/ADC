create or replace package body adc_api 
as

  /* Helper */
  
  $IF adc_util.C_WITH_UNIT_TESTS $THEN
  procedure set_test_mode(
    p_mode in boolean default false)
  as
  begin
    adc_internal.set_test_mode(p_mode);
  end set_test_mode;
  
  function get_test_mode
    return boolean
  as
  begin
    return adc_internal.get_test_mode;
  end get_test_mode;
  
  
  function get_test_result
    return ut_adc_result
  as
  begin
    return adc_internal.get_test_result;
  end get_test_result;
  $END
  
  
  /* CORE FUNCTIONALITY wrapper around ADC_INTERNAL */
  procedure add_javascript(
    p_javascript in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_javascript', p_javascript)));

    adc_internal.add_javascript(p_javascript);

    pit.leave_mandatory;
  end add_javascript;
  
  
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_param_3 in adc_rule_actions.cra_param_3%type default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param_1', p_param_1),
                    msg_param('p_param_2', p_param_2),
                    msg_param('p_param_3', p_param_3)));
        
    adc_internal.execute_action(
      p_cat_id => p_cat_id,
      p_cpi_id => p_cpi_id,
      p_param_1 => p_param_1,
      p_param_2 => p_param_2,
      p_param_3 => p_param_3);
      
    pit.leave_mandatory;
  end execute_action;
  

  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #COMMAND#; end;';
    l_result adc_util.max_char;
    l_cmd adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_plsql', p_plsql)));
                    
    l_cmd := replace(c_cmd_template, '#COMMAND#', replace(trim(p_plsql), ';'));
    execute immediate l_cmd using out l_result;
    
    adc_internal.add_javascript(replace(l_result, 'javascript:'), adc_internal.C_JS_CODE);

    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_UNHANDLED_EXCEPTION, msg_args(l_cmd));
      adc_internal.register_error(adc_util.C_NO_FIRING_ITEM, msg.ADC_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_cmd)));
      -- surpress recursion
      adc_internal.stop_rule;
  end execute_javascript;
    

  procedure execute_plsql(
    p_plsql in varchar2)
  as
    C_CMD_TEMPLATE constant varchar2(100) := 'begin #COMMAND# end;';
    l_plsql adc_util.max_char;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_cmd', substr(p_plsql, 1, 4000))));

    l_plsql := rtrim(p_plsql, ';') || ';';
    execute immediate replace(C_CMD_TEMPLATE, '#COMMAND#', l_plsql);

    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_UNHANDLED_EXCEPTION, msg_args(l_plsql));
      adc_internal.register_error(adc_util.C_NO_FIRING_ITEM, msg.ADC_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql)));
      -- surpress recursion
      adc_internal.stop_rule;
  end execute_plsql;
  
  
  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_value_list', p_value_list)));
                    
    pit.leave_mandatory;
    return adc_internal.exclusive_or(p_value_list);
  end exclusive_or;
  

  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date
  as
  begin
    return adc_internal.get_date(
             p_cpi_id => p_cpi_id,
             p_format_mask => p_format_mask,
             p_throw_error => p_throw_error);
  end get_date;
    
    
  function get_event
    return varchar2
  as
  begin
    return adc_internal.get_event;
  end get_event;
    
    
  function get_event_data(
    p_key in varchar2 default null)
    return varchar2
  as
  begin
    return adc_internal.get_event_data(p_key);
  end get_event_data;


  function get_firing_item
    return varchar2
  as
  begin
    return adc_internal.get_firing_item;
  end get_firing_item;


  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.c_false)
    return number
  as
  begin
    return adc_internal.get_number(
             p_cpi_id => p_cpi_id,
             p_format_mask => p_format_mask,
             p_throw_error => p_throw_error);
  end get_number;
  
  
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
  begin
    return adc_internal.get_string(
             p_cpi_id => p_cpi_id);
  end get_string;
  
  
  function has_errors
    return boolean
  as
    l_bool boolean;
  begin
    pit.enter_mandatory('has_errors');

    l_bool := adc_internal.get_error_flag;

    pit.leave_mandatory(p_params => msg_params(msg_param('Result', adc_util.bool_to_flag(l_bool))));
    return l_bool;
  end has_errors;


  function has_no_errors
    return boolean
  as
  begin
    return not has_errors;
  end has_no_errors;
  
  
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
  begin
    pit.enter_mandatory;
    
    pit.leave_mandatory;    
    return adc_internal.not_null(p_value_list);
  end not_null;


  procedure notify(
    p_text in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_text', p_text)));

    adc_internal.notify(p_text);

    pit.leave_mandatory;
  end notify;
  
  
  procedure notify(
    p_message_name in varchar2,
    p_msg_args in msg_args)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_message_name', p_message_name)));
                    
    notify(
      p_text => pit.get_message_text(p_message_name, p_msg_args));
      
    pit.leave_mandatory;
  end notify;
  
  
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_error_msg', p_error_msg),
                    msg_param('p_internal_error', p_internal_error)));
                    
    adc_internal.register_error(
      p_cpi_id => p_cpi_id,
      p_error_msg => p_error_msg,
      p_internal_error => p_internal_error);
      
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_message_name', p_message_name)));
                    
    adc_internal.register_error(
      p_cpi_id => p_cpi_id,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
      
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_internal.register_item(
      p_cpi_id => p_cpi_id,
      p_allow_recursion => p_allow_recursion);
      
    pit.leave_mandatory;
  end register_item;
  
  
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_is_mandatory in adc_util.flag_type,
    p_cpi_mandatory_message in varchar2,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_cpi_mandatory_message', p_cpi_mandatory_message),
                    msg_param('p_is_mandatory', p_is_mandatory),
                    msg_param('p_jquery_selector', p_jquery_selector)));
                    
    adc_internal.register_mandatory(
      p_cpi_id => p_cpi_id,
      p_cpi_mandatory_message => p_cpi_mandatory_message,
      p_is_mandatory => p_is_mandatory,
      p_jquery_selector => p_jquery_selector);
    
    pit.leave_mandatory;
  end register_mandatory;
  
  
  procedure register_observer(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_internal.register_observer(p_cpi_id);
    
    pit.leave_mandatory;
  end register_observer;
    
    
  procedure set_initialize_mode(
    p_mode in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_mode', p_mode)));
                    
    adc_internal.set_initialize_mode(p_mode = adc_util.C_TRUE);
    
    pit.leave_mandatory;
  end set_initialize_mode;
  
  
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_allow_recursion', p_allow_recursion),
                    msg_param('p_jquery_selector', p_jquery_selector)));
                    
    adc_internal.set_session_state(
      p_cpi_id => p_cpi_id,
      p_value => p_value,
      p_allow_recursion => p_allow_recursion,
      p_jquery_selector => p_jquery_selector);
      
    pit.leave_mandatory;
  end set_session_state;
  

  procedure set_value_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stmt in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_stmt', p_stmt)));

    adc_internal.set_value_from_stmt(
      p_cpi_id => p_cpi_id,
      p_stmt => p_stmt);

    pit.leave_mandatory;
  end set_value_from_stmt;
  
  
  procedure stop_rule
  as
  begin
    pit.enter_mandatory;
    
    adc_internal.stop_rule;
    
    pit.leave_mandatory;
  end stop_rule;


  procedure validate_page
  as
  begin
    pit.enter_mandatory;
    
    adc_internal.validate_page;
    
    pit.leave_mandatory;
  end validate_page;

end adc_api;
/