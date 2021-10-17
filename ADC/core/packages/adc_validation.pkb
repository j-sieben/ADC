create or replace package body adc_validation
as

  /**
    Package: ADC_VALIDATION Body
      Implements validation functionality for the internal meta data adminsitration.
      
      Accessible by ADC_PLUGIN, ADC_UI, ADC_INTERNAL and ADC_ADMIN only.
    
    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  /**
    Group: Private methods
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
    l_cur binary_integer;
  begin
    pit.enter_detailed('parse',
      p_params => msg_params(msg_param('p_stmt', p_stmt)));
    
    l_cur := dbms_sql.open_cursor(p_stmt);
    dbms_sql.parse(l_cur, p_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
    
    pit.leave_detailed;
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
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
    l_cur binary_integer;
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
    C_PROCEDURE_STMT constant varchar2(200) := q'^declare l_foo utl_apex.max_char; begin #STMT#; end;^';
    l_cur binary_integer;
    l_stmt varchar2(2000);
  begin
    p_method := rtrim(p_method, ';');
    if p_is_function then
      l_stmt := C_FUNCTION_STMT;
    else
      l_stmt := C_PROCEDURE_STMT;
    end if;
    l_stmt := replace(l_stmt, 'STMT', p_method);
    l_cur := dbms_sql.open_cursor(l_stmt);
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
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
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_value,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => '');
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
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
    parse_function(p_value, false);
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
  exception
    when msg.PIT_MSG_NOT_EXISTING_ERR then
      -- TODO: refactor to MSG
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => 'Invalid PIT message name',
        p_internal_error => '');
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
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
    l_cur binary_integer;
  begin
    l_stmt := replace(C_STMT, '#STMT#', p_value);
    l_cur := dbms_sql.open_cursor;
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
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
      -- TODO: refactor to MSG
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => 'Invalid jQuery-Selektor',
        p_internal_error => null);
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
      -- TODO: refactor to MSG
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => 'Invalid Page Item name',
        p_internal_error => null);
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
      -- TODO: refactor to MSG
      adc_api.register_error(
        p_cpi_id => p_target,
        p_error_msg => 'Invalid Sequence name',
        p_internal_error => '');
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
    l_cur sys_refcursor;
  begin
    open l_cur for replace(C_STMT, '#EXPRESSION#', p_stmt);
    pit.assert_exists(l_cur);
  end evaluate_sql_expression;


  /**
    Group: Public methods
   */
  /**
    Procedure: validate_param_lov
      See <ADC_VALIDATION.validate_param_lov>
   */
  procedure validate_param_lov(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpt_item_type in adc_action_param_types.cpt_item_type%type)
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
                    msg_param('p_sp_cpt_item_typept_id', p_cpt_item_type)));

    if p_cpt_item_type = C_SELECT_LIST then
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
      See <ADC_VALIDATION.validate_parameter>
   */
  procedure validate_parameter(
    p_value in out nocopy adc_rule_actions.cra_param_1%type,
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_environment in adc_util.environment_rec)
  as
  begin
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
  end validate_parameter;

end adc_validation;
/