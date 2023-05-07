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
  C_ADC constant adc_util.ora_name_type := 'ADC';
  C_CMD constant adc_util.ora_name_type := 'begin :x := to_char(#CMD#); end;';
  C_CAPT_VIEW_NAME_PREFIX constant adc_util.ora_name_type := 'ADC_PARAM_LOV_';
  C_STATIC_LIST constant adc_util.ora_name_type := 'STATIC_LIST';
  g_special_values char_table := char_table(adc_util.C_PARAM_ITEM_VALUE, adc_util.C_PARAM_EVENT_DATA);


  C_APEX_ACTION constant adc_action_param_types.capt_id%type := 'APEX_ACTION';
  C_FUNCTION constant adc_action_param_types.capt_id%type := 'FUNCTION';
  C_JAVA_SCRIPT constant adc_action_param_types.capt_id%type := 'JAVA_SCRIPT';
  C_JAVA_SCRIPT_FUNCTION constant adc_action_param_types.capt_id%type := 'JAVA_SCRIPT_FUNCTION';
  C_JQUERY_SELECTOR constant adc_action_param_types.capt_id%type := 'JQUERY_SELECTOR';
  C_PAGE_ITEM constant adc_action_param_types.capt_id%type := 'PAGE_ITEM';
  C_PIT_MESSAGE constant adc_action_param_types.capt_id%type := 'PIT_MESSAGE';
  C_PROCEDURE constant adc_action_param_types.capt_id%type := 'PROCEDURE';
  C_SEQUENCE constant adc_action_param_types.capt_id%type := 'SEQUENCE';
  C_SQL_STATEMENT constant adc_action_param_types.capt_id%type := 'SQL_STATEMENT';
  C_STRING constant adc_action_param_types.capt_id%type := 'STRING';
  C_STRING_OR_FUNCTION constant adc_action_param_types.capt_id%type := 'STRING_OR_FUNCTION';
  C_STRING_OR_JAVASCRIPT constant adc_action_param_types.capt_id%type := 'STRING_OR_JAVASCRIPT';
  C_STRING_OR_PIT_MESSAGE constant adc_action_param_types.capt_id%type := 'STRING_OR_PIT_MESSAGE';
  C_STRING_ON_PARAMETER constant adc_action_param_types.capt_id%type := 'STRING_ON_PARAMETER';
  C_EVENT constant adc_action_param_types.capt_id%type := 'EVENT';
  C_ITEM_STATUS constant adc_action_param_types.capt_id%type := 'ITEM_STATUS';
  C_SUBMIT_TYPE constant adc_action_param_types.capt_id%type := 'SUBMIT_TYPE';
  C_SWITCH constant adc_action_param_types.capt_id%type := 'SWITCH';

  /**
    Group: Helper Methods
   */
  /**
    Procedure: validate_is_simple_sql_name
      Validate that p_value is a simple sql name that might be executed as a method

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_simple_sql_name(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
    l_value adc_util.sql_char;
    l_position binary_integer;
  begin
    pit.enter_detailed('validate_is_simple_sql_name',
      p_params => msg_params(msg_param('p_value', p_value)));
      
    l_value := trim(';' from p_value);
    l_position := instr(p_value, '(') - 1;
    if l_position > 0 then
      l_value := substr(l_value, 1, l_position);
    end if;
    l_value := dbms_assert.sql_object_name(l_value);
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('OK', l_value)));
  exception
    when NO_DATA_FOUND then
      pit.leave_detailed;
      pit.error(msg.ADC_PARAM_VALIDATION_FAILED, p_error_code => msg.ADC_INVALID_SEQUENCE);
  end validate_is_simple_sql_name;


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
    when msg.ORA_SQL_ACCESS_DENIED_ERR then
      dbms_sql.close_cursor(l_ctx);
      pit.leave_detailed;
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

    l_stmt := replace(replace(replace(replace(replace(C_STMT_TMPL,
                '#STMT#', p_stmt),
                '#ITEM#', null),
                '#PARAM_1#', null),
                '#PARAM_2#', null),
                '#PARAM_3#', null);
    parse(l_stmt);

    pit.leave_detailed;
  end parse_sql;


  /**
    Procedure: parse_string
      Validate that p_value is a string

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
    Procedure: parse_method
      Validate that p_calue is an executable method

    Parameters:
      p_method - Method to check.
      p_is_function - Flag to indicate whether p_value is a function
      p_is_boolean_function - Flag to indicate whether the function returns a boolean value
   */
  procedure parse_method(
    p_method in out nocopy varchar2,
    p_is_function in boolean default true,
    p_is_boolean_function in boolean default false)
  as
    C_FUNCTION_STMT constant varchar2(200) := q'^declare l_foo utl_apex.max_char; begin l_foo := #STMT#; end;^';
    C_BOOL_FUNCTION_STMT constant varchar2(200) := q'^declare l_foo boolean; begin l_foo := #STMT#; end;^';
    C_PROCEDURE_STMT constant varchar2(200) := q'^begin #STMT#; end;^';
    l_ctx binary_integer;
    l_stmt varchar2(2000);
  begin
    pit.enter_detailed('parse_method',
      p_params => msg_params(
                    msg_param('p_method', p_method)));

    p_method := rtrim(p_method, ';');
    case
    when p_is_boolean_function then
      l_stmt := C_BOOL_FUNCTION_STMT;
    when p_is_function then
      l_stmt := C_FUNCTION_STMT;
    else
      l_stmt := C_PROCEDURE_STMT;
    end case;
    l_stmt := replace(l_stmt, '#STMT#', p_method);
    pit.log_state(
      p_params => msg_params(msg_param('Statement', l_stmt)));
      
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_ctx);

    pit.leave_detailed;
  exception
    when others then
      dbms_sql.close_cursor(l_ctx);
      pit.leave_detailed;
      pit.error(
        p_message_name => msg.ADC_PARAM_VALIDATION_FAILED,
        p_msg_args => msg_args(substr(SQLERRM, instr(SQLERRM, ':', 1, 3) + 1)),
        p_error_code => msg.ADC_METHOD_PARSE_EXCEPTION);
  end parse_method;


  /**
    Procedure: validate_is_apex_action
      Validate that p_value is an APEX Action

    Parameters:
      p_value - Method to check.
   */
  procedure validate_is_apex_action(
    p_value in out nocopy varchar2)
  as
    l_exists binary_integer;
    l_environment adc_util.environment_rec;
  begin
    pit.enter_optional('validate_is_apex_action',
      p_params => msg_params(msg_param('p_value', p_value)));
      
    l_environment := adc_util.get_environment;
    select count(*)
      into l_exists
      from dual
     where exists(
           select null
             from adc_apex_actions
            where caa_crg_id = l_environment.crg_id
              and caa_name = p_value);
              
    if l_exists = 0 then
      adc_api.register_error(
        p_cpi_id => p_value,
        p_message_name => msg.ADC_APEX_ACTION_UNKNOWN,
        p_msg_args => msg_args(p_value));
    end if;
    
    pit.leave_optional;
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
    Procedure: validate_is_event
      Validate that p_value is an event

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_event(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    pit.assert_exists('select null from adc_event_types where cet_id = ''' || p_value || '''');
  end validate_is_event;


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
    parse_method(p_value);
  end validate_is_function;


  /**
    Procedure: validate_is_bool_function
      Validate that p_value is a function

    Parameters:
      p_value - Value to check.
      p_target - Page item to link the execption to
   */
  procedure validate_is_bool_function(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_method(
      p_method => p_value,
      p_is_boolean_function => true);
  end validate_is_bool_function;


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
                    
    parse_method(
      p_method => p_value, 
      p_is_function => false);

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
      parse_method(p_value);
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
      p_target - Page item to link the exception to
   */
  procedure validate_is_sql_statement(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
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
    p_target in varchar2)
  as
    l_environment adc_util.environment_rec;
  begin
    pit.enter_optional('validate_is_selector',
      p_params => msg_params(msg_param('p_value', p_value)));
      
    l_environment := adc_util.get_environment;
    p_value := trim(p_value);
    -- If selector starts with # or ., take it as is, otherwise try to find item and prefix it with #
    if not substr(p_value, 1, 1) in ('#', '.') then
      select '#' || cpi_id
        into p_value
        from adc_page_items
       where cpi_crg_id = l_environment.crg_id
         and cpi_id = upper(p_value);
    end if;
    
    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      pit.error(msg.ADC_PARAM_VALIDATION_FAILED, p_error_code => msg.ADC_INVALID_JQUERY);
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
    p_target in varchar2)
  as
    l_environment adc_util.environment_rec;
  begin
    pit.enter_optional('validate_is_page_item',
      p_params => msg_params(msg_param('p_value', p_value)));
      
    l_environment := adc_util.get_environment;
    select cpi_id
      into p_value
      from adc_page_items
     where cpi_crg_id = l_environment.crg_id
       and cpi_id = upper(p_value);
    
    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      pit.error(msg.ADC_INVALID_JQUERY, p_error_code => msg.ADC_INVALID_PAGE_ITEM);
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
      pit.error(msg.ADC_PARAM_VALIDATION_FAILED, p_error_code => msg.ADC_INVALID_SEQUENCE);
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
    parse_method(l_stmt);
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
    pit.enter_detailed('execute_function_as_varchar2',
      p_params => msg_params(msg_param('p_plsql_code', p_plsql_code)));

    l_stmt := rtrim(p_plsql_code, ';');
    --validate_is_simple_sql_name(l_stmt, null);
    parse_method(l_stmt);
    l_stmt := replace(C_STMT, '#EXPRESSION#', l_stmt);
    execute immediate l_stmt using out l_result;

    pit.leave_detailed;
    return l_result;
  exception
    when others then
      return p_plsql_code;
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
    parse_method(l_stmt);
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
    parse_method(l_stmt);
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
    pit.assert_exists(l_ctx, p_error_code => 'SQL_EXPRESSION');
  end evaluate_sql_expression;


  /**
    Function: get_apex_action_name
      Returns the name of an apex action based on its internal ID

    Parameter:
      p_caa_id - ID of the APEX actions as maintained by ADC

    Returns:
      Apex action name
   */
  function get_apex_action_name(
    p_caa_id in adc_apex_actions.caa_id%type)
    return adc_apex_actions.caa_name%type
  as
    l_caa_name adc_apex_actions.caa_name%type;
  begin
    select caa_name
      into l_caa_name
      from adc_apex_actions
     where caa_id = p_caa_id;

    return l_caa_name;
  end get_apex_action_name;


  /**
    Function: get_pit_message
      Returns the message text of a PIT message if it exists and the name enquoted if not.

    Parameters:
      p_message_name - Name of the message

    Returns:
      Message text, if the message exists, enquoted message name if not.
   */
  function get_pit_message(
    p_message_name in varchar2,
    p_msg_args in msg_args)
    return varchar2
  as
    l_pms_name adc_util.ora_name_type;
    l_message adc_util.max_char;
  begin
    pit.enter_detailed('get_pit_message');

    select pms_name
      into l_pms_name
      from pit_message_v
     where pms_name = replace(upper(p_message_name), 'MSG.');
    l_message := pit.get_message_text(l_pms_name);

    pit.leave_optional;
    return l_message;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional(
        p_params => msg_params(msg_param('Not Found', l_message)));
      return p_message_name;
  end get_pit_message;


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
    p_crg_id in adc_rule_groups.crg_id%type,
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
        l_result := adc_page_state.get_string(p_crg_id, p_cpi_id);
      when instr(p_param, adc_util.C_PARAM_ITEM_VALUE) > 0 then
        l_result := replace(p_param, adc_util.C_PARAM_ITEM_VALUE, adc_page_state.get_string(p_crg_id, p_cpi_id));
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
    return coalesce(l_stmt, 'null');
  exception
    when others then
      return p_function;
  end execute_function;


  /**
    Group: Public methods
   */
  /**
    Procedure: validate_param_lov
      See <ADC_PARAMETER.validate_param_lov>
   */
  procedure validate_param_lov(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_capt_capvt_id in adc_action_param_types.capt_capvt_id%type)
  as
    C_SELECT_LIST constant utl_apex.ora_name_type := 'SELECT_LIST';
    C_VIEW_PATTERN constant utl_apex.ora_name_type := 'ADC_PARAM_LOV_';
    C_COLUMN_LIST constant char_table := char_table('D', 'R', 'CRG_ID');

    l_view_exists number;
    l_column_count number;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_capt_id', p_capt_id),
                    msg_param('p_sp_capt_capvt_idpt_id', p_capt_capvt_id)));

    if p_capt_capvt_id = C_SELECT_LIST then
      select count(distinct table_name) view_exists, count(*) column_count
        into l_view_exists, l_column_count
        from user_tab_columns
       where table_name = C_VIEW_PATTERN || p_capt_id
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
    p_capt_id in adc_action_param_types.capt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    l_error_msg adc_util.max_char;
    l_error message_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_value', p_value),
                    msg_param('p_capt_id', p_capt_id),
                    msg_param('p_cpi_id', p_cpi_id)));

    case p_capt_id
      when C_APEX_ACTION then
        validate_is_apex_action(p_value);
      when C_FUNCTION then
        begin
          validate_is_function(p_value, p_cpi_id);
        exception
          when msg.ADC_PARAM_VALIDATION_FAILED_ERR then
            validate_is_bool_function(p_value, p_cpi_id);
        end;
      when C_JAVA_SCRIPT_FUNCTION then
        validate_is_function(p_value, p_cpi_id);
      when C_JQUERY_SELECTOR then
        validate_is_selector(p_value, p_cpi_id);
      when C_PAGE_ITEM then
        validate_is_page_item(p_value, p_cpi_id);
      when C_PIT_MESSAGE then
        validate_is_pit_message(p_value, p_cpi_id);
      when C_PROCEDURE then
        validate_is_procedure(p_value, p_cpi_id);
      when C_SEQUENCE then
        validate_is_sequence(p_value, p_cpi_id);
      when C_SQL_STATEMENT then
        validate_is_sql_statement(p_value, p_cpi_id);
      when C_STRING then
        validate_is_string(p_value, p_cpi_id);
      when C_STRING_OR_FUNCTION then
        validate_is_string_or_function(p_value, p_cpi_id);
      when C_STRING_OR_JAVASCRIPT then
        null;
      when C_STRING_OR_PIT_MESSAGE then
        validate_is_string_or_message(p_value, p_cpi_id);
      when C_EVENT then
        validate_is_event(p_value, p_cpi_id);
      else
        null;
      end case;

    pit.leave_mandatory;
  exception
    when msg.ADC_PARAM_VALIDATION_FAILED_ERR then
      l_error := pit.get_active_message;
      case l_error.error_code
        when msg.ADC_INVALID_JQUERY then
          adc_api.register_error(
            p_cpi_id => p_cpi_id,
            p_message_name => msg.ADC_INVALID_JQUERY,
            p_msg_args => msg_args(p_value));
        when msg.ADC_INVALID_PAGE_ITEM then
          adc_api.register_error(
            p_cpi_id => p_cpi_id,
            p_message_name => msg.ADC_INVALID_PAGE_ITEM,
            p_msg_args => msg_args(p_value));
        when msg.ADC_INVALID_SEQUENCE then
          adc_api.register_error(
            p_cpi_id => p_cpi_id,
            p_message_name => msg.ADC_INVALID_SEQUENCE,
            p_msg_args => msg_args(p_value));
        when msg.ADC_METHOD_PARSE_EXCEPTION then
          adc_api.register_error(
            p_cpi_id => p_cpi_id,
            p_message_name => msg.ADC_METHOD_PARSE_EXCEPTION,
            p_msg_args => msg_args(substr(sqlerrm, 12)));
      else
        null;
      end case;
    when msg.PIT_MSG_NOT_EXISTING_ERR then
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.PIT_MSG_NOT_EXISTING,
        p_msg_args => msg_args(p_value));
    when others then
      case when instr(sqlerrm, 'PLS') > 0 then
        l_error_msg := substr(sqlerrm, instr(sqlerrm, ':', 1, 3) + 1);
      else
        l_error_msg := substr(sqlerrm, 12);
      end case;
      adc_api.register_error(
        p_cpi_id => p_cpi_id,
        p_message_name => msg.ADC_PARAM_VALIDATION_FAILED,
        p_msg_args => msg_args(l_error_msg));
  end validate_parameter;


  /**
    Function: get_param_lov_query
      See <ADC_PARAMETER.get_param_lov_query>
   */
  function get_param_lov_query(
    p_row in out nocopy adc_action_param_types_v%rowtype)
                                             
    return varchar2
  as
    C_VIEW_STATEMENT_TEMPLATE constant adc_util.max_char := q'^create or replace force view #VIEW_NAME# as #QUERY##CR#^';
    C_VIEW_STATIC_LIST_TEMPLATE constant adc_util.max_char := q'^
  select pti_name d, substr(pti_id, #IDX#) r, null crg_id
    from pit_translatable_item_v
   where pti_pmg_name = 'ADC'
     and pti_id like '#VIEW_NAME#%'^';
                                                                                                           
    l_stmt adc_util.max_char;
                                  
    l_idx binary_integer;
  begin
    pit.enter_optional;

                               
                                          
           

    if p_row.capt_capvt_id = C_STATIC_LIST then

      with params as (
             select length(p_row.capt_id) p_position,
                    p_row.capt_id || '%' p_capt_id_pattern
               from dual)
      select p_position + case when substr(pti_id, p_position + 3, 1) = '_' then 4 else 2 end
        into l_idx
        from pit_translatable_item_v
        join params
          on pti_id like p_capt_id_pattern
       where pti_pmg_name = 'ADC'
         and rownum = 1;

      p_row.capt_select_list_query := replace(replace(C_VIEW_STATIC_LIST_TEMPLATE,
                                       '#VIEW_NAME#', p_row.capt_id),
                                       '#IDX#', to_char(l_idx));
    end if;

    if p_row.capt_select_list_query is not null then
      l_stmt := replace(replace(replace(C_VIEW_STATEMENT_TEMPLATE,
                  '#VIEW_NAME#', C_CAPT_VIEW_NAME_PREFIX || p_row.capt_id),
                  '#QUERY#', p_row.capt_select_list_query),
                  '#CR#', adc_util.C_CR);
    end if;
    
    pit.leave_optional;
    return l_stmt;
  end get_param_lov_query;
  
  
  /**
    Function: get_param_lov_comment
      See <ADC_PARAMETER.get_param_lov_comment>
   */
  function get_param_lov_comment(
    p_row in out nocopy adc_action_param_types_v%rowtype)
    return varchar2
  as
    C_VIEW_COMMENT_TEMPLATE constant adc_util.max_char := q'^comment on table #VIEW_NAME# is '#COMMENT##CR#'^';
    l_stmt adc_util.max_char;
  begin
    pit.enter_optional;
    
    if p_row.capt_select_view_comment is not null then
      l_stmt := l_stmt 
             || adc_util.C_CR 
             || replace(replace(replace(C_VIEW_COMMENT_TEMPLATE,
                  '#VIEW_NAME#', C_CAPT_VIEW_NAME_PREFIX || p_row.capt_id),
                  '#COMMENT#', p_row.capt_select_view_comment),
                  '#CR#', adc_util.C_CR);
    end if;
    
    pit.leave_optional;
    return l_stmt;
  end get_param_lov_comment;


   /**
    Function: analyze_selector_parameter
      See <ADC_PARAMETER.analyze_selector_parameter>
   */
  function analyze_selector_parameter(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param in adc_rule_actions.cra_param_2%type)
    return varchar2
  as
    l_result adc_util.max_char;
  begin
    pit.enter_optional('analyze_selector_parameter',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param', p_param)));

    l_result := p_param;
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM then
      if l_result is not null then
        case substr(l_result, 1, 1)
          when '.' then null; -- class selector
          when '#' then null; -- ID selector
          when '''' then l_result := trim('''' from l_result); -- remove unneccessary apostrophes
          else
            -- function call to retrieve the selector
            execute immediate replace(C_CMD, '#CMD#', trim(';' from l_result))
              using out l_result;
        end case;
      end if;
    else
      l_result := p_cpi_id;
    end if;

    pit.leave_optional(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  exception
    when others then
      -- no valid function, treat the value as an ID
      return '#' || l_result;
  end analyze_selector_parameter;


  /**
    Function: evaluate_parameter
      See <ADC_PARAMETER.evaluate_parameter>
   */
  function evaluate_parameter(
    p_capt_id adc_action_param_types.capt_id%type,
    p_param_value adc_rule_actions.cra_param_1%type,
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_value adc_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_capt_id', p_capt_id),
                    msg_param('p_param_value', p_param_value),
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id)));

    -- Initialize
    if p_param_value is not null then
      l_value := p_param_value;

      if l_value member of g_special_values or instr(l_value, '#') > 0 then
        l_value := analyze_parameter_value(l_value, p_crg_id, p_cpi_id);
      else
        if p_capt_id is not null then
          case p_capt_id
            when C_STRING then
              l_value := trim(adc_util.C_APOS from l_value);
            when C_STRING_OR_FUNCTION then
              if substr(l_value, 1, 1) != adc_util.C_APOS then
                l_value := execute_function_as_varchar2(l_value);
              else
                l_value := trim(adc_util.C_APOS from l_value);
              end if;
            when C_STRING_OR_PIT_MESSAGE then
              if substr(l_value, 1, 1) != adc_util.C_APOS then
                l_value := get_pit_message(l_value, null);
              else
                l_value := trim(adc_util.C_APOS from l_value);
              end if;
            when C_STRING_ON_PARAMETER then
              l_value := param.get_string(C_ADC, l_value);
            else
              null;
            end case;
        end if;
      end if;
    end if;

    pit.leave_optional(msg_params(msg_param('Parameter', l_value)));
    return l_value;
  end evaluate_parameter;

end adc_parameter;
/