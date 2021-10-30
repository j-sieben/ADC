create or replace package body adc_api 
as

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
  
  
  procedure clear_page_state
  as
  begin
    pit.enter_mandatory;
    
    apex_util.clear_page_cache(utl_apex.get_page_id);
    adc_page_state.reset;
    
    pit.leave_mandatory;
  end clear_page_state;
  
  
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
    
    adc_internal.add_javascript(replace(l_result, 'javascript:'), adc_util.C_JS_CODE);

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
    adc_page_state.get_item_values_as_char_table(adc_internal.get_cgr_id, p_item_list, l_value_list);
    
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
    return adc_page_state.get_date(adc_internal.get_cgr_id, p_cpi_id, p_format_mask);
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
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2
  as
    C_STMT constant varchar2(200) := q'^select d, r
  from adc_param_lov_#CPT_ID#
 where cgr_id = #CGR_ID#
    or cgr_id is null^';
    l_stmt varchar2(1000);
  begin
    if p_cpt_id is not null then
      l_stmt := utl_text.bulk_replace(C_STMT, char_table(
                  'CPT_ID', lower(p_cpt_id),
                  'CGR_ID', coalesce(p_cgr_id, 0)));
    else
      l_stmt := 'select null d, null r from dual';
    end if;
    return l_stmt;
  end get_lov_sql;
  

  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.c_false)
    return number
  as
  begin
    return adc_page_state.get_number(adc_internal.get_cgr_id, p_cpi_id, p_format_mask);
  end get_number;
  
  
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
  begin
    return adc_page_state.get_string(adc_internal.get_cgr_id, p_cpi_id);
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
  
  
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type)
  as
    l_stmt adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_static_id', p_static_id)));

    with templates as(
           select uttm_text template, uttm_mode,
                  utl_apex.get_application_id g_app_id,
                  utl_apex.get_page_id g_page_id,
                  p_static_id g_static_id
             from utl_text_templates
            where uttm_type = 'ADC'
              and uttm_name = 'INITIALIZE_FORM')
    select /*+ no_merge (t) */utl_text.generate_text(cursor(
           select t.template, table_name "TABLE",
                  utl_text.generate_text(cursor(
                    select /*+ no_merge (s) */s.template, i.item_source column_name, i.item_name item_name,
                           case i.item_source_data_type when 'NUMBER' then 'number' when 'DATE' then 'date' else 'string' end data_type
                      from apex_application_page_items i
                      join templates s
                        on application_id = g_app_id
                       and page_id = g_page_id
                     where i.data_source_region_id = r.region_id
                       and is_primary_key = 'Yes'
                       and uttm_mode = 'STATE'),
                    ',' || chr(10), 8) session_state,
                  utl_text.generate_text(cursor(
                    select /*+ no_merge (s) */s.template, i.item_source column_name, i.item_name item_name
                      from apex_application_page_items i
                      join templates s
                        on application_id = g_app_id
                       and page_id = g_page_id
                     where i.data_source_region_id = r.region_id
                       and uttm_mode = 'COLUMNS'),
                    ', ') column_list
             from apex_application_page_regions r
             join templates t
               on application_id = g_app_id
              and page_id = g_page_id
              and static_id = g_static_id
            where uttm_mode = 'FRAME'))
      into l_stmt
      from dual;
      
    pit.log_state(msg_params(msg_param('Statement', l_stmt)));
    adc_internal.set_value_from_statement(
      p_cpi_id => null, 
      p_statement => l_stmt, 
      p_allow_recursion => adc_util.C_FALSE);
    
    pit.leave_mandatory;
  exception
    when no_data_found then
      pit.leave_mandatory;
  end initialize_form_region;
  
  
  function not_null(
    p_item_list in varchar2)
    return adc_util.flag_type
  as
    l_value_list char_table;
    l_value_counter binary_integer;
    l_result adc_util.flag_type := adc_util.C_FALSE;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_item_list', p_item_list)));
    
    -- Tracing done in ADC_API
    adc_page_state.get_item_values_as_char_table(adc_internal.get_cgr_id, p_item_list, l_value_list);
    select count(*)
      into l_value_counter
      from table(l_value_list)
     where column_value is not null
       and rownum < 2;
    if l_value_counter = 1 then
      l_result := adc_util.C_TRUE;
    end if;    
    
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
  
  
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_number_value', p_number_value),
                    msg_param('p_date_value', p_date_value),
                    msg_param('p_allow_recursion', p_allow_recursion),
                    msg_param('p_jquery_selector', p_jquery_selector)));
                    
    adc_internal.set_session_state(
      p_cpi_id => p_cpi_id,
      p_value => p_value,
      p_number_value => p_number_value,
      p_date_value => p_date_value,
      p_allow_recursion => p_allow_recursion,
      p_jquery_selector => p_jquery_selector);
      
    pit.leave_mandatory;
  end set_session_state;
  

  procedure set_value_from_statement(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_statement in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_statement', p_statement)));

    adc_internal.set_value_from_statement(
      p_cpi_id => p_cpi_id,
      p_statement => p_statement,
      p_allow_recursion => adc_util.C_FALSE);

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