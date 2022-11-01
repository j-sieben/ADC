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
                    
    l_cmd := replace(c_cmd_template, '#PL_SQL#', replace(trim(p_plsql), ';'));
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
    C_CMD_TEMPLATE constant varchar2(100) := 'begin #PL_SQL# end;';
    l_plsql adc_util.max_char;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_cmd', substr(p_plsql, 1, 4000))));

    
    l_plsql := rtrim(trim(p_plsql), ';') || ';';
    pit.assert(l_plsql != ';');
    execute immediate replace(C_CMD_TEMPLATE, '#PL_SQL#', l_plsql);

    pit.leave_mandatory;
  exception
    when msg.ASSERT_TRUE_ERR then
      pit.handle_exception;
      adc_internal.register_error(adc_util.C_NO_FIRING_ITEM, msg.ASSERT_TRUE);
      -- surpress recursion
      adc_internal.stop_rule;
    when others then
      pit.handle_exception(msg.ADC_UNHANDLED_EXCEPTION, msg_args(l_plsql));
      adc_internal.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADC_UNHANDLED_EXCEPTION, 
        p_msg_args => msg_args(apex_escape.json(l_plsql)));
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
    adc_page_state.get_item_values_as_char_table(adc_internal.get_crg_id, p_item_list, l_value_list);
    
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
    return adc_page_state.get_date(adc_internal.get_crg_id, p_cpi_id, p_format_mask);
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
    C_STMT constant varchar2(200) := q'^select d, r
  from adc_param_lov_#CAPT_ID#
 where crg_id = #CRG_ID#
    or crg_id is null^';
    l_stmt varchar2(1000);
  begin
    if p_capt_id is not null then
      l_stmt := utl_text.bulk_replace(C_STMT, char_table(
                  'CAPT_ID', lower(p_capt_id),
                  'CRG_ID', coalesce(p_crg_id, 0)));
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
    return adc_page_state.get_number(adc_internal.get_crg_id, p_cpi_id, p_format_mask);
  end get_number;
  
  
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
  begin
    return adc_page_state.get_string(adc_internal.get_crg_id, p_cpi_id);
  end get_string;
  

  procedure handle_bulk_errors(
    p_mapping in char_table default null) 
  as
    type error_code_map_t is table of utl_apex.ora_name_type index by utl_apex.ora_name_type;
    l_error_code_map error_code_map_t;
    l_message_list pit_message_table;
    l_message message_type;
    l_item utl_apex.item_rec;
    l_processed_messages char_table := char_table();
  begin
    pit.enter_optional;
    
    l_message_list := pit.get_message_collection;
    
    if l_message_list.count > 0 then
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then
            l_error_code_map(p_mapping(i)) := p_mapping(i + 1);
          end if;
        end loop;
      end if;
      
      for i in 1 .. l_message_list.count loop
        l_message := l_message_list(i);
        if l_message.severity in (pit.level_fatal, pit.level_error) then
        
          if l_error_code_map.exists(l_message.error_code) then
            utl_apex.get_page_element(l_error_code_map(l_message.error_code), l_item);
          end if;
          
          if l_message.error_code not member of l_processed_messages then
            -- Push on local message list to remove doulbe errors
            l_processed_messages.extend;
            l_processed_messages(l_processed_messages.count) := l_message.error_code;
            
            adc_api.register_error(
              p_cpi_id => coalesce(l_item.item_name, adc_util.C_NO_FIRING_ITEM),
              p_error_msg => replace(l_message.message_text, '#LABEL#', l_item.item_label),
              p_internal_error => l_message.message_description);
          end if;
          
        end if;
      end loop;
    end if;
    
    pit.leave_optional;
  end handle_bulk_errors;
  
  
  function has_class(
    p_class in varchar2)
    return adc_util.flag_type
  as
    l_class_found binary_integer;
    l_result adc_util.flag_type;
    l_crg_id adc_rule_groups.crg_id%type;
    l_firing_item adc_util.ora_name_type;
  begin
    pit.enter_mandatory('has_class');

    l_crg_id := adc_internal.get_crg_id;
    l_firing_item := adc_internal.get_firing_item;
    
    select count(*)
      into l_class_found
      from adc_page_items
     where cpi_crg_id = l_crg_id
       and cpi_id = l_firing_item
       and instr(lower(cpi_css), '|' || lower(p_class) || '|') > 0;
     
    l_result := adc_util.bool_to_flag(l_class_found = 1);

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
    l_stmt adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_static_id', p_static_id)));

    with templates as(
           select /*+ no_merge */
                  uttm_text template, uttm_mode,
                  utl_apex.get_application_id g_app_id,
                  utl_apex.get_page_id g_page_id,
                  p_static_id g_static_id
             from utl_text_templates
            where uttm_type = 'ADC'
              and uttm_name = 'INITIALIZE_FORM')
    select utl_text.generate_text(cursor(
           select t.template, table_name,
                  utl_text.generate_text(cursor(
                    select s.template, i.item_source column_name, i.item_name item_name,
                           case i.item_source_data_type when 'NUMBER' then 'number' when 'DATE' then 'date' else 'string' end data_type
                      from apex_application_page_items i
                      join templates s
                        on application_id = g_app_id
                       and page_id = g_page_id
                     where i.data_source_region_id = r.region_id
                       and is_primary_key = 'Yes'
                       and uttm_mode = 'STATE'),
                    ',' || adc_util.C_CR, 8) session_state,
                  utl_text.generate_text(cursor(
                    select s.template, i.item_source column_name, i.item_name item_name
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
      
    pit.log_state(
      msg_params(
        msg_param('APP', utl_apex.get_application_id),
        msg_param('PAGE', utl_apex.get_page_id),
        msg_param('ID', p_static_id),
        msg_param('Statement', l_stmt)));
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
    adc_page_state.get_item_values_as_char_table(adc_internal.get_crg_id, p_item_list, l_value_list);
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


  procedure validate_page(
    p_submit_type in varchar2)
  as
  begin
    pit.enter_mandatory;
    
    if instr(p_submit_type, 'VALIDATE' ) > 0 then
      adc_internal.validate_page;
    end if;
    
    pit.leave_mandatory;
  end validate_page;

end adc_api;
/