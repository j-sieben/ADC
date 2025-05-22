create or replace package body adc_api 
as

  /**
    Group: CORE FUNCTIONALITY wrapper around ADC_INTERNAL 
   */
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
  
  
  procedure clear_page_state
  as
  begin
    pit.enter_mandatory;
    
    apex_util.clear_page_cache(utl_apex.get_page_id);
    adc_page_state.reset(adc_internal.get_crg_id, adc_util.C_NO_FIRING_ITEM);
    
    pit.leave_mandatory;
  end clear_page_state;
  
  
  function get_javascript_for_action(
    p_cat_id in adc_action_types.cat_id%type default adc_util.C_NO_FIRING_ITEM,
    p_cpi_id in adc_page_items.cpi_id%type default null,
    p_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_param_3 in adc_rule_actions.cra_param_3%type default adc_util.C_FALSE)
    return varchar2
  as
    l_response adc_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param_1', p_param_1),
                    msg_param('p_param_2', p_param_2),
                    msg_param('p_param_3', p_param_3)));
        
    l_response := adc_internal.get_javascript_for_action(
                    p_cat_id => p_cat_id,
                    p_cpi_id => p_cpi_id,
                    p_param_1 => p_param_1,
                    p_param_2 => p_param_2,
                    p_param_3 => p_param_3);
      
    pit.leave_mandatory;
    return l_response;
  end get_javascript_for_action;
  
  
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_FALSE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param_1', p_param_1),
                    msg_param('p_param_2', p_param_2),
                    msg_param('p_param_3', p_param_3),
                    msg_param('p_allow_recursion', p_allow_recursion)));
                    
    adc_internal.execute_action(
      p_cat_id => p_cat_id,
      p_cpi_id => p_cpi_id,
      p_param_1 => p_param_1,
      p_param_2 => p_param_2,
      p_param_3 => p_param_3,
      p_allow_recursion => p_allow_recursion);
      
    pit.leave_mandatory;
  end execute_action;
  
  
  procedure execute_command(
    p_command in adc_apex_actions.caa_name%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_command', p_command)));
                    
    adc_internal.execute_command(p_command);
                    
    pit.leave_mandatory;
  end execute_command;
  

  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #PL_SQL#; end;';
    l_result adc_util.max_char;
    l_cmd adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_plsql', p_plsql)));
                    
    adc_actions.execute_javascript(
      p_plsql => p_plsql);
      
    pit.leave_mandatory;
  end execute_javascript;
    

  procedure execute_plsql(
    p_plsql in varchar2)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_plsql', p_plsql)));

    adc_actions.execute_plsql(
      p_plsql => p_plsql);
    
    pit.leave_mandatory;
  end execute_plsql;
  
  
  procedure exclusive_or(
    p_cpi_id in varchar2,
    p_item_list in varchar2,
    p_message in varchar2 default null,
    p_error_on_null in boolean default true)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_item_list', p_item_list)));
                    
    adc_actions.exclusive_or(
      p_cpi_id => p_cpi_id,
      p_item_list => p_item_list,
      p_message => p_message,
      p_error_on_null => p_error_on_null);
                    
    pit.leave_mandatory;
  end exclusive_or;
  
  
  function exclusive_or(
    p_item_list in varchar2)
    return adc_util.flag_type
  as
    l_value_list char_table;
    l_value_counter binary_integer := -1;
    l_result adc_util.flag_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_item_list', p_item_list)));
                    
    -- Tracing done in ADC_API  
    adc_page_state.get_item_values_as_char_table(p_item_list, l_value_list);
    
    select count(*)
      into l_value_counter
      from table(l_value_list)
     where column_value is not null
       and rownum < 3;
      
    l_result := case l_value_counter
                when 0 then null
                when 1 then adc_util.C_TRUE
                else adc_util.C_FALSE end;      
                    
    pit.leave_mandatory;
    return l_result;
  end exclusive_or;
  

  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date
  as
  begin
    return adc_page_state.get_date(p_cpi_id, p_format_mask);
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


  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    l_stmt adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_capt_id', p_capt_id),
                    msg_param('p_crg_id', p_crg_id)));
                    
    l_stmt := adc_actions.get_lov_sql(
                p_capt_id => p_capt_id,
                p_crg_id => p_crg_id);
                  
    pit.leave_mandatory;
    return l_stmt;
  end get_lov_sql;
  

  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.c_false)
    return number
  as
  begin
    return adc_page_state.get_number(p_cpi_id, p_format_mask);
  end get_number;
  
  
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
  begin
    return adc_page_state.get_string(p_cpi_id);
  end get_string;
  

  procedure handle_bulk_errors(
    p_mapping in char_table default null,
    p_filter_list in varchar2 default null) 
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_filter_list', p_filter_list)));
    
    adc_actions.handle_bulk_errors(
      p_mapping => p_mapping,
      p_filter_list => p_filter_list);
    
    pit.leave_optional;
  end handle_bulk_errors;
  
  
  procedure handle_event_data
  as
  begin
    pit.enter_mandatory;
    -- TODO: Implementierung hinzufügen
    pit.leave_mandatory;
  end handle_event_data;
  
  
  function has_class(
    p_class in varchar2)
    return adc_util.flag_type
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_mandatory;
     
    l_result := adc_actions.has_class(p_class);

    pit.leave_mandatory(p_params => msg_params(msg_param('Result', l_result)));
    return l_result;
  end has_class;
  
  
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
  
  
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_static_id', p_static_id)));

    adc_actions.initialize_form_region(p_static_id);
    
    pit.leave_mandatory;
  end initialize_form_region;
  
  
  function not_null(
    p_item_list in varchar2)
    return adc_util.flag_type
  as
    l_result adc_util.flag_type := adc_util.C_FALSE;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_item_list', p_item_list)));
    
    l_result := adc_actions.not_null(p_item_list);
    
    pit.leave_mandatory;    
    return l_result;
  end not_null;
  
  
  procedure raise_item_event(
    p_cpi_id in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_internal.raise_item_event(
      p_cpi_id => p_cpi_id);
      
    pit.leave_mandatory;
  end raise_item_event;
  
  
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
  begin
    -- Tracing done in ADC_INTERNAL, as this method is called from various
    -- places within ADC_API
                    
    adc_internal.register_error(
      p_cpi_id => p_cpi_id,
      p_error_msg => p_error_msg,
      p_internal_error => p_internal_error);
      
  end register_error;
  
  
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
  begin
    -- Tracing done in ADC_INTERNAL, as this method is called from various
    -- places within ADC_API
                    
    adc_internal.register_error(
      p_cpi_id => p_cpi_id,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
      
  end register_error;
  
  
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_is_mandatory in adc_util.flag_type,
    p_cpi_mandatory_message in varchar2,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null,
    p_visual_state in varchar2 default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_cpi_mandatory_message', p_cpi_mandatory_message),
                    msg_param('p_is_mandatory', p_is_mandatory),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_visual_state', p_visual_state)));
                    
    adc_internal.register_mandatory(
      p_cpi_id => p_cpi_id,
      p_cpi_mandatory_message => p_cpi_mandatory_message,
      p_is_mandatory => p_is_mandatory,
      p_jquery_selector => p_jquery_selector,
      p_visual_state => p_visual_state);
    
    pit.leave_mandatory;
  end register_mandatory;
  
  
  procedure remember_page_state(
    p_cpi_id in varchar2 default null,
    p_page_items in varchar2 default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_page_items', p_page_items)));
                    
    adc_actions.remember_page_state(
      p_cpi_id => p_cpi_id,
      p_page_items => p_page_items);
    
    pit.leave_mandatory;
  end remember_page_state;


  procedure remove_error_for_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null,
    p_check in boolean default true)
  as
    l_item_list char_table;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_jquery_selector', p_jquery_selector)));
                    
    if p_cpi_id is not null and p_check then
      adc_internal.register_touched_item(p_cpi_id, p_jquery_selector);
    end if;
    
    pit.leave_mandatory;
  end remove_error_for_item;
  
  
  procedure set_event_data(
    p_cpi_id in varchar2,
    p_event_type in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_event_type', p_event_type),
                    msg_param('p_message_name', p_message_name)));
                    
    adc_actions.set_event_data(
      p_cpi_id => p_cpi_id,
      p_event_type => p_event_type,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
                    
    pit.leave_mandatory;
  end set_event_data;
  
  
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null,
    p_visual_state in varchar2 default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_number_value', p_number_value),
                    msg_param('p_date_value', p_date_value),
                    msg_param('p_allow_recursion', p_allow_recursion),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_visual_state', p_visual_state)));
                    
    adc_internal.set_session_state(
      p_cpi_id => p_cpi_id,
      p_value => p_value,
      p_number_value => p_number_value,
      p_date_value => p_date_value,
      p_allow_recursion => p_allow_recursion,
      p_jquery_selector => p_jquery_selector,
      p_visual_state => p_visual_state);
      
    pit.leave_mandatory;
  end set_session_state;
  
  
  procedure reset_mandatory_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_throw_error in boolean,
    p_jquery_selector in adc_rule_actions.cra_param_2%type default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_visual_state in adc_rule_actions.cra_param_3%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_throw_error', p_throw_error),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_allow_recursion', p_allow_recursion),
                    msg_param('p_visual_state', p_visual_state)));
                    
    adc_internal.reset_mandatory_item(
      p_cpi_id => p_cpi_id,
      p_throw_error => utl_apex.get_bool(p_throw_error),
      p_jquery_selector => p_jquery_selector,
      p_allow_recursion => p_allow_recursion,
      p_visual_state => p_visual_state);
      
    pit.leave_mandatory;
  end reset_mandatory_item;
  

  procedure set_value_from_statement(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_statement in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_FALSE)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_statement', p_statement)));

    adc_internal.set_value_from_statement(
      p_cpi_id => p_cpi_id,
      p_statement => p_statement,
      p_allow_recursion => p_allow_recursion);

    pit.leave_mandatory;
  end set_value_from_statement;
  

  procedure set_value_from_cursor(
    p_cursor in out nocopy sys_refcursor)
  as
  begin
    pit.enter_mandatory;

    adc_internal.set_value_from_cursor(
      p_cursor => p_cursor);

    pit.leave_mandatory;
  end set_value_from_cursor;


  procedure stop(
    p_cpi_id in varchar2 default adc_util.C_NO_FIRING_ITEM,
    p_display_message_name in varchar2 default msg.PIT_SQL_ERROR,
    p_display_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null)
  as
  begin
    -- Log
    if pit.get_active_message is not null then
      -- Named exception raised, just pass it on
      pit.handle_exception;
    else
      -- Unhandled exception, map to a generic error
      pit.handle_exception(
        p_message_name => msg.PIT_SQL_ERROR,
        p_msg_args => msg_args(substr(sqlerrm, 12)),
        p_affected_id => p_affected_id,
        p_affected_ids => p_affected_ids);
    end if;
    -- Regardless of logging, show display message and stop execution
    adc_internal.register_error(
      p_cpi_id => p_cpi_id,
      p_message_name => p_display_message_name,
      p_msg_args => p_display_msg_args);
  end stop;
  
  
  procedure stop_rule
  as
  begin
    pit.enter_mandatory;
    
    adc_internal.stop_rule;
    
    pit.leave_mandatory;
  end stop_rule;


  procedure validate_page(
    p_submit_type in varchar2,
    p_request in varchar2 default 'SAVE',
    p_msg_name in varchar2 default null)
  as
  begin
    pit.enter_mandatory;
    
    adc_internal.validate_page(p_submit_type, p_request, p_msg_name);
    
    pit.leave_mandatory;
  end validate_page;

end adc_api;
/