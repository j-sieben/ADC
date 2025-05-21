create or replace package body adc_actions
as
  
  /** 
    Package: ADC_ACTIONS Body
      Implementation of the adc api logic
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  /**
    Group: Private methods
   */
  
  /**
    Group: Public methods
   */
  /**
    Procedure: exclusive_or
      See: <ADC_API.exclusive_or
   */
  procedure exclusive_or(
    p_cpi_id in varchar2,
    p_item_list in varchar2,
    p_message in varchar2 default null,
    p_error_on_null in boolean default true)
  as
    l_value_list char_table;
    l_value_counter binary_integer := -1;
    l_result adc_util.flag_type;
    l_message adc_util.ora_name_type;
  begin
    -- Tracing done in ADC_API  
                    
    l_message := coalesce(p_message, msg.ADC_MIN_ONE_VALUE);
    adc_page_state.get_item_values_as_char_table(replace(p_item_list, ':', ','), l_value_list);
    
    select count(*)
      into l_value_counter
      from table(l_value_list)
     where column_value is not null
       and rownum < 3;
      
    case
      when l_value_counter = 0 and p_error_on_null then
        adc_internal.register_error(p_cpi_id, l_message, msg_args(''));
      when l_value_counter > 1 then
        adc_internal.register_error(p_cpi_id, msg.ADC_MAX_ONE_VALUE, msg_args(''));
      else
        null;
    end case;
                    
    pit.leave_mandatory;
  end exclusive_or;
  
  
  /**
    Procedure: execute_javascript
      See: <ADC_API.execute_javascript
   */
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #PL_SQL#; end;';
    l_result adc_util.max_char;
    l_cmd adc_util.max_char;
  begin
    -- Tracing done in ADC_API  
    
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
  
  
  /**
    Procedure: execute_plsql
      See: <ADC_API.execute_plsql
   */
  procedure execute_plsql(
    p_plsql in varchar2)
  as
    C_CMD_TEMPLATE constant varchar2(100) := 'begin #PL_SQL# end;';
    l_plsql adc_util.max_char;
  begin
    -- Tracing done in ADC_API  
    
    l_plsql := rtrim(trim(p_plsql), ';') || ';';
    pit.assert(l_plsql != ';');
    execute immediate replace(C_CMD_TEMPLATE, '#PL_SQL#', l_plsql);
  exception
    when msg.PIT_ASSERT_TRUE_ERR then
      pit.handle_exception;
      adc_internal.register_error(adc_util.C_NO_FIRING_ITEM, msg.PIT_ASSERT_TRUE);
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
  
  
  /**
    Function: get_lov_sql
      See: <ADC_API.get_lov_sql
   */
  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    C_STMT constant varchar2(200) := q'^select d, r
  from (#SELECT_LIST_QUERY#)
 where crg_id = #CRG_ID#
    or crg_id is null^';
    l_stmt varchar2(1000);
  begin
    -- Tracing done in ADC_API  
    
    if p_capt_id is not null then
      select replace(replace(C_STMT,
              '#SELECT_LIST_QUERY#', capt_select_list_query),
              '#CRG_ID#', coalesce(p_crg_id, 0))
        into l_stmt
        from adc_action_param_types
       where capt_id = p_capt_id;
    else
      l_stmt := 'select null d, null r from dual';
    end if;
    return replace(l_stmt, chr(10));
  end get_lov_sql;
  
  
  /**
    Function: handle_bulk_errors
      See <ADC_API.handle_bulk_errors>
   */
  procedure handle_bulk_errors(
    p_mapping in char_table default null,
    p_filter_list in varchar2 default null) 
  as
    type error_code_map_t is table of utl_apex.ora_name_type index by utl_apex.ora_name_type;
    l_error_code_map error_code_map_t;
    l_filter_items char_table;
    l_has_filter boolean;
    l_allow_message boolean;
    l_message_list pit_message_table;
    l_message message_type;
    l_item utl_apex.item_rec;
    l_processed_messages char_table := char_table();
    l_related_item adc_util.ora_name_type;
  begin
    -- Tracing done in ADC_API  
    
    l_message_list := pit.get_message_collection;
    
    if l_message_list.count > 0 then
      -- Initialize
      utl_text.string_to_table(p_filter_list, l_filter_items);
      l_has_filter := l_filter_items.count > 0;
      
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then            
            l_error_code_map(p_mapping(i)) := adc_util.harmonize_page_item_name(p_mapping(i + 1));
          end if;
        end loop;
      end if;
      
      for i in 1 .. l_message_list.count loop
        l_item := null;
        l_message := l_message_list(i);
        l_allow_message := not l_has_filter;
        
        if l_message.severity in (pit.level_fatal, pit.level_error) then
        
          if l_error_code_map.exists(l_message.error_code) then
            if l_has_filter then
              l_related_item := l_error_code_map(l_message.error_code);
              l_allow_message := l_related_item member of l_filter_items or l_related_item = 'DOCUMENT';
            end if;
            if l_allow_message then
              utl_apex.get_page_element(l_error_code_map(l_message.error_code), l_item);
            end if;
          end if;
          
          if l_message.error_code not member of l_processed_messages and l_allow_message then
            -- Push on local message list to remove double errors
            l_processed_messages.extend;
            l_processed_messages(l_processed_messages.count) := l_message.error_code;
            
            adc_internal.register_error(
              p_cpi_id => coalesce(l_item.item_name, adc_util.C_NO_FIRING_ITEM),
              p_error_msg => regexp_replace(replace(l_message.message_text, 
                               '#LABEL#', l_item.item_label),
                               '(\[.*\])', l_item.item_label),
              p_internal_error => l_message.message_description);
          end if;          
        end if;
      end loop;
    end if;
  end handle_bulk_errors;
  
  
  /**
    Function: has_class
      See <ADC_API.has_class>
   */
  function has_class(
    p_class in varchar2)
    return adc_util.flag_type
  as
    l_class_found binary_integer;
    l_crg_id adc_rule_groups.crg_id%type;
    l_firing_item adc_util.ora_name_type;
  begin
    -- Tracing done in ADC_API  
    
    l_crg_id := adc_internal.get_crg_id;
    l_firing_item := adc_internal.get_firing_item;
    
    select count(*)
      into l_class_found
      from adc_page_items
     where cpi_crg_id = l_crg_id
       and cpi_id = l_firing_item
       and instr(lower(cpi_css), '|' || lower(p_class) || '|') > 0;
     
    return adc_util.bool_to_flag(l_class_found = 1);
  end has_class;
  
  
  /**
    Procedure: initialize_form_region
      See <ADC_API.initialize_form_region>
   */
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type)
  as
    l_stmt adc_util.max_char;
  begin
    -- Tracing done in ADC_API  
    
    with templates as(
           select /*+ no_merge */
                  uttm_text template, uttm_mode,
                  utl_apex.get_application_id g_app_id,
                  utl_apex.get_page_id g_page_id,
                  p_static_id g_static_id
             from utl_text_templates_v
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
    
  exception
    when no_data_found then
      null;
  end initialize_form_region;
  
  
  /**
    Function: not_null
      See <ADC_API.not_null>
   */
  function not_null(
    p_item_list in varchar2)
    return adc_util.flag_type
  as
    l_value_list char_table;
    l_value_counter binary_integer;
    l_result adc_util.flag_type := adc_util.C_FALSE;
  begin
    -- Tracing done in ADC_API  
    
    adc_page_state.get_item_values_as_char_table(p_item_list, l_value_list);
    
    select count(*)
      into l_value_counter
      from table(l_value_list)
     where column_value is not null
       and rownum < 2;
    if l_value_counter = 1 then
      l_result := adc_util.C_TRUE;
    end if;    
    
    return l_result;
  end not_null;
  
  
  /**
    Procedure: remember_page_state
      See <ADC_API.remember_page_state>
   */
  procedure remember_page_state(
    p_cpi_id in varchar2 default null,
    p_page_items in varchar2 default null)
  as
    l_page_item_json adc_util.max_char;
    C_ACTION_TEMPLATE constant adc_util.sql_char := 
      q'^de.condes.plugin.adc.actions.rememberPageItemStatus(#PARAM_1#);^';
  begin
    -- Tracing done in ADC_API  
    
    l_page_item_json := adc_page_state.get_page_items_as_json(
                          p_cpi_id => p_cpi_id,
                          p_page_items => p_page_items);
    l_page_item_json := replace(C_ACTION_TEMPLATE, '#PARAM_1#', l_page_item_json);
    
    adc_internal.add_javascript(l_page_item_json);
    
  end remember_page_state;
  
  
  /**
    Procedure: set_event_data
      See <ADC_API.set_event_data>
   */
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
                    
    -- TODO Implementierung erforderlich
                    
    pit.leave_mandatory;
  end set_event_data;
  
end adc_actions;
/