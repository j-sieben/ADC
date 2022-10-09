create or replace package body adc_parameter 
as

  /** 
    Package: ADC_PARAMETER Body
      Package to handle parameter values. There are two main tasks to perform:
      
        - Validate any parameter upon creation or changing of the rule action
        - Evaluate the parameter value upon execution
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  C_CMD constant adc_util.ora_name_type := 'begin :x := to_char(#CMD#); end;';
  C_CPT_VIEW_NAME_PREFIX constant adc_util.ora_name_type := 'ADC_PARAM_LOV_';  
  C_STATIC_LIST constant adc_util.ora_name_type := 'STATIC_LIST';
  g_special_values char_table := char_table(adc_util.C_PARAM_ITEM_VALUE, adc_util.C_PARAM_EVENT_DATA);
  
  
  /**
    Group: Helper Methods
   */
  /**
    Procedure: parse
      Method to parse a statement and throw and exception if parsing fails.

    Parameter:
      p_stmt - Statement to parse.

    Errors:
      SQL_ERROR - if parsing fails.
   */
  procedure parse(
    p_stmt in varchar2)
  as
    l_ctx binary_integer;
  begin
    pit.enter_detailed('parse',
      p_params => msg_params(msg_param('p_stmt', p_stmt)));

    l_ctx := dbms_sql.open_cursor(p_stmt);
    dbms_sql.parse(l_ctx, p_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_ctx);

    pit.leave_detailed;
  exception
    when others then
      dbms_sql.close_cursor(l_ctx);
      pit.leave_detailed;
      raise;
  end parse;


  /**
    Procedure: parse_sql
      Method to parse a statement and throw and exception if parsing fails.

      Only select statements are allowed and correctly parsed.

    Parameter:
      p_stmt - Statement to parse.

    Errors:
      SQL_ERROR - if parsing fails.
   */
  procedure parse_sql(
    p_stmt in varchar2)
  as
    l_stmt utl_apex.max_char;
    C_STMT_TMPL constant varchar2(200) := 'select * from (#STMT#)';
  begin
    pit.enter_detailed('parse_sql',
      p_params => msg_params(msg_param('p_stmt', p_stmt)));

    l_stmt := utl_text.bulk_replace(C_STMT_TMPL, char_table(
                'STMT', p_stmt,
                'ITEM', null,
                'PARAM_1', null,
                'PARAM_2', null,
                'PARAM_3', null));
    parse(l_stmt);

    pit.leave_detailed;
  end parse_sql;


  /**
    Procedure: parse_string
      Validate that p_calue is a string

    Parameter:
      p_value - Value to check.
   */
  procedure parse_string(
    p_value in out nocopy varchar2)
  as
    l_stmt utl_apex.max_char;
    l_ctx binary_integer;
    C_STMT_TMPL constant varchar2(200) := q'~declare
  l_string utl_apex.max_char;
begin
  select #VALUE#
    into l_string
    from dual;
end;~';
  begin
    l_stmt := replace(C_STMT_TMPL, '#VALUE#', p_value);
    execute immediate l_stmt;
  end parse_string;


  /**
    Procedure: parse_function
      Validate that p_calue is a string

    Parameters:
      p_method - Method to check.
      p_is_function - Flag to indicate whether p_value is a function
   */
  procedure parse_function(
    p_method in out nocopy varchar2,
    p_is_function in boolean default true)
  as
    C_FUNCTION_STMT constant varchar2(200) := q'^declare l_foo utl_apex.max_char; begin l_foo := #STMT#; end;^';
    C_PROCEDURE_STMT constant varchar2(200) := q'^begin #STMT#; end;^';
    l_ctx binary_integer;
    l_stmt varchar2(2000);
  begin
    pit.enter_detailed('parse_function',
      p_params => msg_params(
                    msg_param('p_method', p_method)));
                    
    p_method := rtrim(p_method, ';');
    if p_is_function then
      l_stmt := C_FUNCTION_STMT;
    else
      l_stmt := C_PROCEDURE_STMT;
    end if;
    l_stmt := replace(l_stmt, '#STMT#', p_method);
    pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Statement: ' || l_stmt));
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_ctx);
    
    pit.leave_detailed;
  exception
    when others then
      dbms_sql.close_cursor(l_ctx);
      pit.leave_detailed;
      raise;
  end parse_function;


  /**
    Procedure: validate_is_apex_action
      Validate that p_value is an APEX Action

    Parameters:
      p_value - Method to check.
      p_environment - Calling environment
   */
  procedure validate_is_apex_action(
    p_value in out nocopy varchar2,
    p_environment in adc_util.environment_rec)
  as
    l_exists binary_integer;
  begin
    select count(*)
      into l_exists
      from dual
     where exists(
           select null
             from adc_apex_actions
            where caa_cgr_id = p_environment.cgr_id
              and caa_name = p_value);
    if l_exists = 0 then
      adc_api.register_error(
        p_cpi_id => p_value,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => '');
    end if;
  end validate_is_apex_action;


  /**
    Procedure: validate_is_string
      Validate that p_value is aString

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_string(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_string(p_value);
  end validate_is_string;


  /**
    Procedure: validate_is_function
      Validate that p_value is a function

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_function(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_function(p_value);
  end validate_is_function;


  /**
    Procedure: validate_is_procedure
      Validate that p_value is a procedure

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_procedure(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    pit.enter_detailed('validate_is_procedure',
      p_params => msg_params(
                    msg_param('p_value', p_value),
                    msg_param('p_target', p_target)));
    parse_function(p_value, false);
    
    pit.leave_detailed;
  end validate_is_procedure;


  /**
    Procedure: validate_is_pit_message
      Validate that p_value is a PIT message

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_pit_message(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
    l_message clob;
  begin
    l_message := pit.get_message_text(upper(p_value));
  end validate_is_pit_message;


  /**
    Procedure: validate_is_string_or_function
      Validate that p_value is a String or a function

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_string_or_function(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    p_value := trim(p_value);
    if substr(trim(p_value), 1, 1) =  '''' then
      parse_string(p_value);
    else
      parse_function(p_value);
    end if;
  end validate_is_string_or_function;


  /**
    Procedure: validate_is_string_or_message
      Validate that p_value is a String or a PIT message

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_string_or_message(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    p_value := trim(p_value);
    if substr(trim(p_value), 1, 1) =  '''' then
      parse_string(p_value);
    else
      validate_is_pit_message(p_value, p_target);
    end if;
  end validate_is_string_or_message;


  /**
    Procedure: validate_is_sql_statement
      Validate that p_value is a SQL statement

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_sql_statement(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
    C_STMT constant varchar2(100) := 'select * from (#STMT#)';
    l_stmt utl_apex.max_char;
    l_ctx binary_integer;
  begin
    parse_sql(p_value);
  end validate_is_sql_statement;


  /**
    Procedure: validate_is_selector
      Validate that p_value is a jQuery selector

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_selector(
    p_value in out nocopy varchar2,
    p_target in varchar2,
    p_environment in adc_util.environment_rec)
  as
  begin
    p_value := trim(p_value);
    -- If selector starts with # or ., take it as is, otherwise try to find item and prefix it with #
    if not substr(p_value, 1, 1) in ('#', '.') then
      select '#' || cpi_id
        into p_value
        from adc_page_items
       where cpi_cgr_id = p_environment.cgr_id
         and cpi_id = upper(p_value);
    end if;
  exception
    when NO_DATA_FOUND then
      pit.error(msg.ADC_UI_INVALID_JQUERY);
  end validate_is_selector;


  /**
    Procedure: validate_is_page_item
      Validate that p_value is a APEX page item

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_page_item(
    p_value in out nocopy varchar2,
    p_target in varchar2,
    p_environment in adc_util.environment_rec)
  as
  begin
    select cpi_id
      into p_value
      from adc_page_items
     where cpi_cgr_id = p_environment.cgr_id
       and cpi_id = upper(p_value);
  exception
    when NO_DATA_FOUND then
      pit.error(msg.ADC_UI_INVALID_PAGE_ITEM);
  end validate_is_page_item;


  /**
    Procedure: validate_is_sequence
      Validate that p_value is an existing sequence

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_sequence(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    select sequence_name
      into p_value
      from user_sequences
     where sequence_name = upper(p_value);
  exception
    when NO_DATA_FOUND then
      pit.error(msg.ADC_UI_INVALID_SEQUENCE);
  end validate_is_sequence;


  /**
    Procedure: execute_plsql_code
      Execute the PL/SQL block passed in

    Parameters:
      p_plsql_code - PL/SQL block to execute
   */
  procedure execute_plsql_code(
    p_plsql_code in varchar2)
  as
    C_STMT constant varchar2(100) := 'begin #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt;
  end execute_plsql_code;


  /**
    Function: execute_function_as_varchar2
      Execute the PL/SQL block passed in and return result as VARCHAR2

    Parameters:
      p_plsql_code - PL/SQL function to execute

    Returns:
      The result of the function as VARCHAR2
   */
  function execute_function_as_varchar2(
    p_plsql_code in varchar2)
    return varchar2
  as
    C_STMT constant varchar2(100) := 'begin :x := #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result utl_apex.max_char;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end execute_function_as_varchar2;


  /**
    Function: execute_function_as_boolean
      Execute the PL/SQL block passed in and return result as BOOLEAN

    Parameters:
      p_plsql_code - PL/SQL function to execute

    Returns:
      A boolean flag the expression evaluates to
   */
  function execute_function_as_boolean(
    p_plsql_code in varchar2)
    return boolean
  as
    C_STMT constant varchar2(100) := q'^declare function bool return boolean as begin #EXPRESSION#; end; begin :x := bool; end;^';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end execute_function_as_boolean;


  /**
    Function: evaluate_plsql_expression
      Execute the PL/SQL block passed in and return result as BOOLEAN

    Parameters:
      p_plsql_code - PL/SQL expression to execute

    Returns:
      A boolean flag the expression evaluates to
   */
  function evaluate_plsql_expression(
    p_plsql_code in varchar2)
    return boolean
  as
    C_STMT constant varchar2(100) := 'begin :x := #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end evaluate_plsql_expression;


  /**
    Procedure: evaluate_sql_expression
      Execute the PL/SQL block passed in and return result as BOOLEAN

    Parameters:
      p_plsql_code - SQL expression to execute
   */
  procedure evaluate_sql_expression(
    p_stmt in varchar2)
  as
    C_STMT constant varchar2(100) := 'select count(*) from dual where #EXPRESSION#';
    l_ctx sys_refcursor;
  begin
    open l_ctx for replace(C_STMT, '#EXPRESSION#', p_stmt);
    pit.assert_exists(l_ctx);
  end evaluate_sql_expression;
  
  
  /** 
    Function: analyze_parameter_value
      Helper to analyze a parameter value.
      
      If it is one of the predefined special attribute values, the respective replacement value is calculated.
      
    Parameters:
      p_cpi_id - Name of the referenced item or <Adc_UTIL.C_NO_FIRING_ITEM>
      p_param - Attribute value to analyze
      
    Returns:
      Result of the analysis, either static or dynamic 
   */
  function analyze_parameter_value(
    p_param in adc_rule_actions.cra_param_1%type,
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in varchar2)
    return varchar2
  as
    l_result adc_util.max_char;
  begin
    pit.enter_detailed('analyze_parameter_value',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param', p_param)));

    case 
      when p_param = adc_util.C_PARAM_ITEM_VALUE then
        l_result := adc_page_state.get_string(p_cgr_id, p_cpi_id);
      when instr(p_param, adc_util.C_PARAM_ITEM_VALUE) > 0 then
        l_result := replace(p_param, adc_util.C_PARAM_ITEM_VALUE, adc_page_state.get_string(p_cgr_id, p_cpi_id));
      when p_param = adc_util.C_PARAM_EVENT_DATA then
        l_result := adc_api.get_event_data(null);
      when instr(p_param, adc_util.C_PARAM_EVENT_DATA) > 0 then
        l_result := replace(p_param, adc_util.C_PARAM_ITEM_VALUE, adc_api.get_event_data(null));
      else
        l_result := p_param;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  exception
    when others then
      return p_param;
  end analyze_parameter_value;
  
  
  /**
    Function: execute_function
      Helper to execute a PL/SQL function and return its value.
      The resulting value is casted to char.
      
    Parameter:
      p_function - Function call to execute.
      
    Returns:
      Calculated value as string
   */
  function execute_function(
    p_function in varchar2)
    return varchar2
  as
    l_stmt adc_util.max_char;
  begin
    pit.enter_detailed('execute_function',
      p_params => msg_params(
                    msg_param('p_function', p_function)));
                    
    l_stmt := replace(C_CMD, '#CMD#', p_function);
    execute immediate l_stmt using out l_stmt;
    
    pit.leave_detailed(
      p_params => msg_params(
                    msg_param('Result', l_stmt)));
    return coalesce(dbms_assert.enquote_literal(l_stmt), 'null');
  exception
    when others then
      pit.handle_exception(msg.ADC_PLSQL_ERROR, msg_args(p_function));
      return dbms_assert.enquote_literal(l_stmt);
  end execute_function;
  
   
  /**
    Group: Public methods
   */
  /**
    Procedure: validate_param_lov
      See <ADC_PARAMETER.validate_param_lov>
   */
  procedure validate_param_lov(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpt_cpv_id in adc_action_param_types.cpt_cpv_id%type)
  as
    C_SELECT_LIST constant utl_apex.ora_name_type := 'SELECT_LIST';
    C_VIEW_PATTERN constant utl_apex.ora_name_type := 'ADC_PARAM_LOV_';
    C_COLUMN_LIST constant char_table := char_table('D', 'R', 'CGR_ID');

    l_view_exists number;
    l_column_count number;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpt_id', p_cpt_id),
                    msg_param('p_sp_cpt_cpv_idpt_id', p_cpt_cpv_id)));

    if p_cpt_cpv_id = C_SELECT_LIST then
      select count(distinct table_name) view_exists, count(*) column_count
        into l_view_exists, l_column_count
        from user_tab_columns
       where table_name = C_VIEW_PATTERN || p_cpt_id
         and column_name member of C_COLUMN_LIST;

      pit.assert(l_view_exists = 1, msg.ADC_PARAM_LOV_MISSING);
      pit.assert(l_column_count = 3, msg.ADC_PARAM_LOV_INCORRECT);
    end if;

    pit.leave_optional;
  end validate_param_lov;


  /**
    Procedure: validate_parameter
      See <ADC_PARAMETER.validate_parameter>
   */
  procedure validate_parameter(
    p_value in out nocopy adc_rule_actions.cra_param_1%type,
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_environment in adc_util.environment_rec)
  as
    l_error_msg adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_value', p_value),
                    msg_param('p_cpt_id', p_cpt_id),
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    case p_cpt_id
    when 'APEX_ACTION' then
      validate_is_apex_action(p_value, p_environment);
    when 'FUNCTION' then
      validate_is_function(p_value, p_cpi_id);
    when 'JAVA_SCRIPT' then
      null;
    when 'JAVA_SCRIPT_FUNCTION' then
      null;
    when 'JQUERY_SELECTOR' then
      validate_is_selector(p_value, p_cpi_id, p_environment);
    when 'PAGE_ITEM' then
      validate_is_page_item(p_value, p_cpi_id, p_environment);
    when 'PIT_MESSAGE' then
      validate_is_pit_message(p_value, p_cpi_id);
    when 'PROCEDURE' then
      validate_is_procedure(p_value, p_cpi_id);
    when 'SEQUENCE' then
      validate_is_sequence(p_value, p_cpi_id);
    when 'SQL_STATEMENT' then
      validate_is_sql_statement(p_value, p_cpi_id);
    when 'STRING' then
      validate_is_string(p_value, p_cpi_id);
    when 'STRING_OR_FUNCTION' then
      validate_is_string_or_function(p_value, p_cpi_id);
    when 'STRING_OR_JAVASCRIPT' then
      null;
    when 'STRING_OR_PIT_MESSAGE' then
      validate_is_string_or_message(p_value, p_cpi_id);
    else
      pit.error(msg.ADC_UNKNOWN_CPT, msg_args(p_cpt_id));
    end case;
    
    pit.leave_mandatory;
  exception
    when msg.PIT_MSG_NOT_EXISTING_ERR then
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.PIT_MSG_NOT_EXISTING,
        p_msg_args => msg_args(p_value));
    when msg.ADC_UI_INVALID_JQUERY_ERR then
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.ADC_UI_INVALID_JQUERY,
        p_msg_args => msg_args(p_value));
    when msg.ADC_UI_INVALID_PAGE_ITEM_ERR then
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.ADC_UI_INVALID_PAGE_ITEM,
        p_msg_args => msg_args(p_value));
    when msg.ADC_UI_INVALID_SEQUENCE_ERR then
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.ADC_UI_INVALID_SEQUENCE,
        p_msg_args => msg_args(p_value));
    when others then
      case when instr(sqlerrm, 'PLS') > 0 then
        l_error_msg := substr(sqlerrm, instr(sqlerrm, ':', 1, 3) + 1);
      else
        l_error_msg := substr(sqlerrm, 12);
      end case;
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.ADC_UI_PARAM_VALIDATION_FAILED,
        p_msg_args => msg_args(l_error_msg));
  end validate_parameter;
  
  
  /**
    Function: get_param_lov_query
      See <ADC_PARAMETER.get_param_lov_query>
   */
  function get_param_lov_query(
    p_row in out nocopy adc_action_param_types_v%rowtype,
    p_for_immediate in boolean default false)
    return varchar2
  as
    C_VIEW_STATEMENT_TEMPLATE constant adc_util.max_char := q'^create or replace view #VIEW_NAME# as #QUERY#^';
    C_VIEW_STATIC_LIST_TEMPLATE constant adc_util.max_char := q'^
  select pti_name d, substr(pti_id, #IDX#) r, null cgr_id
    from pit_translatable_item_v
   where pti_pmg_name = 'ADC'
     and pti_id like '#VIEW_NAME#%'^';
    C_VIEW_COMMENT_TEMPLATE constant adc_util.max_char := q'^comment on table #VIEW_NAME# is '#COMMENT#'^';
    l_stmt adc_util.max_char;
    l_delimiter varchar2(10 byte);
    l_idx binary_integer;
  begin
    pit.enter_optional('get_param_lov_query');
    
    if not p_for_immediate then
      l_delimiter := ';' || adc_util.C_CR;
    end if;
  
    if p_row.cpt_cpv_id = C_STATIC_LIST then
    
      with params as (
             select length(p_row.cpt_id) p_position,
                    p_row.cpt_id || '%' p_cpt_id_pattern
               from dual)
      select p_position + case when substr(pti_id, p_position + 3, 1) = '_' then 4 else 2 end
        into l_idx
        from pit_translatable_item_v
        join params
          on pti_id like p_cpt_id_pattern
       where pti_pmg_name = 'ADC'
         and rownum = 1;
         
      p_row.cpt_select_list_query := utl_text.bulk_replace(C_VIEW_STATIC_LIST_TEMPLATE, char_table(
                                       '#VIEW_NAME#', p_row.cpt_id,
                                       '#IDX#', to_char(l_idx)));
    end if;
    
    if p_row.cpt_select_list_query is not null then
      l_stmt := utl_text.bulk_replace(C_VIEW_STATEMENT_TEMPLATE || l_delimiter, char_table(
                  '#VIEW_NAME#', C_CPT_VIEW_NAME_PREFIX || p_row.cpt_id,
                  '#QUERY#', p_row.cpt_select_list_query));
    end if;
          
    if p_row.cpt_select_view_comment is not null then
      l_stmt := l_stmt || adc_util.C_CR || 
                utl_text.bulk_replace(C_VIEW_COMMENT_TEMPLATE || l_delimiter, char_table(
                  '#VIEW_NAME#', C_CPT_VIEW_NAME_PREFIX || p_row.cpt_id,
                  '#COMMENT#', p_row.cpt_select_view_comment));
    end if;
    return l_stmt;
    
  end get_param_lov_query;
  
  
   /** 
    Function: analyze_selector_parameter
      See <ADC_PARAMETER.analyze_selector_parameter>
   */
  function analyze_selector_parameter(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param in adc_rule_actions.cra_param_2%type,
    p_code_template in varchar2 default null)
    return varchar2
  as
    l_result adc_util.max_char;
  begin
    pit.enter_optional('analyze_selector_parameter',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param', p_param),
                    msg_param('p_code_template', p_code_template)));
                    
    l_result := p_param;
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM then
      if l_result is not null then 
        case substr(l_result, 1, 1)
          when '.' then null;
          when '#' then null;
          when '''' then l_result := trim('''' from l_result);
          else execute immediate replace(C_CMD, '#CMD#', trim(';' from l_result)) using out l_result;
        end case;
      end if;
    else
      l_result := p_cpi_id;
    end if;
    
    pit.leave_optional(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  exception
    when others then
      return dbms_assert.enquote_literal(l_result);
  end analyze_selector_parameter;
  
   
  /**
    Function: evaluate_parameter
      See <ADC_PARAMETER.evaluate_parameter>
   */
  function evaluate_parameter(
    p_cpt_id adc_action_param_types.cpt_id%type,
    p_param_value adc_rule_actions.cra_param_1%type,
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_value adc_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpt_id', p_cpt_id),
                    msg_param('p_param_value', p_param_value),
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id)));
         
    -- Initialize
    if p_param_value is not null then
      l_value := p_param_value;
                      
      if l_value member of g_special_values or instr(l_value, '#') > 0 then
        l_value := analyze_parameter_value(l_value, p_cgr_id, p_cpi_id);
      else
        case p_cpt_id
          when 'STRING_OR_FUNCTION' then
            if substr(l_value, 1, 1) = adc_util.C_APOS then
              l_value := execute_function(l_value);
            end if;
          when 'FUNCTION' then
            l_value := execute_function(l_value);
        else
          null;
        end case;
      end if;
    end if;
    
    pit.leave_optional(msg_params(msg_param('Parameter', l_value)));
    return l_value;
  end evaluate_parameter;
  
  
end adc_parameter;
/