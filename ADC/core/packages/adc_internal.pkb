create or replace package body adc_internal 
as
  /**
    Package: ADC_INTERNAL Body
      Implementation of the core logic of the ADC functionality
    
    Author::
      Juergen Sieben, ConDeS GmbH
  */

  /**
    Group: Private type definitions
   */
  
  /** 
    Type: param_rec
      Central record for the plugin attributes.
      
    Properties:
      cgr_id adc_rule_groups.cgr_id%type - actual CGR_ID
      firing_item adc_page_items.cpi_id%type - actual firing item (or adc_util.C_NO_FIRING_ITEM)
      firing_event adc_page_item_types.cit_cet_id%type - actual firing event (normally change or click, but can be any event)
      initialize_mode boolean - Flag to indicate whether automatic mandatory checks should be paused
      event_data adc_util.max_char - optional event data that is returned from modal dialog pages etc.
      bind_event_items char_table - List of items for which ADC binds event handlers
      stop_flag adc_util.flag_type - Flag to indicate that all rule execution has to be stopped
      now binary_integer - timestamp, used to calculate the execution duration
      has_errors boolean - Flag to indicate whether a rule has encounterd an error so far. Is reset per rule execution
   */
  type param_rec is record(
    cgr_id adc_rule_groups.cgr_id%type, 
    firing_item adc_page_items.cpi_id%type,
    firing_event adc_page_item_types.cit_cet_id%type,
    initialize_mode boolean,
    event_data adc_util.max_char,
    bind_event_items char_table,
    stop_flag adc_util.flag_type,
    has_errors boolean,
    rule_counter binary_integer
  );
  
  
  /**
    Type: rule_action_rec
      Record for recording data of the actually executed rule and rule action.
      Type matches ADC_RULE_GROUP.cgr_decision_table statements.
      
    Properties:
      cru_sort_seq - Sort sequence of the rule
      cru_name - Name of the rule
      cru_fire_on_page_load - Flag to indicate whether this rule is executed in addition to the initialization code
      cra_item - Item attribute of the action to execute
      cat_pl_sql - PL/SQL code of the action type to execute
      cat_js - JavaScript snippet of the action type to execute
      cra_sort_seq - Sort sequence of the rule action
      cra_param_1 - First parameter of the rule action
      cra_param_2 - Second parameter of the rule action
      cra_param_3 - Third parameter of the rule action
      cra_on_error - Flag to indicate whether this rule action is an error handler
      cru_has_error_handler - Flag to indicate whether this rule has got at least one error handler
      is_first_action - Flag to indicate whether this action is the first to execute.
   */
  type rule_action_rec is record(
    cru_id adc_rules.cru_id%type,
    cru_sort_seq adc_rules.cru_sort_seq%type,
    cru_name adc_rules.cru_name%type,
    cru_firing_items adc_rules.cru_firing_items%type,
    cru_fire_on_page_load adc_rules.cru_fire_on_page_load%type,
    cra_item adc_page_items.cpi_id%type,
    cat_pl_sql adc_action_types.cat_pl_sql%type,
    cat_js adc_action_types.cat_js%type,
    cra_sort_seq adc_rule_actions.cra_sort_seq%type,
    cra_param_1 adc_rule_actions.cra_param_1%type,
    cra_param_2 adc_rule_actions.cra_param_2%type,
    cra_param_3 adc_rule_actions.cra_param_3%type,
    cra_on_error adc_rule_actions.cra_on_error%type,
    cru_has_error_handler adc_rule_actions.cra_on_error%type,
    is_first_action adc_util.flag_type
  );

  g_param param_rec;
    
  /**
    Group: Private Methods
   */
   /** 
    Function: analyze_selector_parameter
      Helper to analyze a rule action parameter.
      
      The following syntactical possibilities exist:
      
      - jQuery CSS selector
      - jQuery ID selector
      - static string, encapsulated in single quotes
      - PL/SQL-Block without single quotes, with or without terminating semicolon
      
    Parameters:
      p_cpi_id - Name of the referenced item or <ADC_UTIL.C_NO_FIRING_ITEM>
      p_selector - Selector to replace the parameter value with
      p_code_template - Code template to insert a calculated parameter value into
      p_param - Attribute value to analyze
      
    Returns:
      Result of the analysis, either static or dynamic.
   */
  function analyze_selector_parameter(
    p_cpi_id in varchar2,
    p_param in adc_rule_actions.cra_param_2%type,
    p_code_template in varchar2 default null)
    return varchar2
  as
    C_CMD constant varchar2(100) := 'begin :x := #CMD#; end;';
    C_SELECTOR constant adc_util.ora_name_type := '#SELECTOR#';
    l_result adc_util.max_char;
  begin
    pit.enter_detailed('analyze_selector_parameter',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_param', p_param),
                    msg_param('p_code_template', p_code_template)));
                    
    l_result := p_param;
    case 
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM then
      if l_result is not null and instr(p_code_template, C_SELECTOR) > 0 then 
        case substr(l_result, 1, 1)
          when '.' then null;
          when '#' then null;
          when '''' then l_result := trim('''' from l_result);
          else execute immediate replace(C_CMD, '#CMD#', trim(';' from l_result)) using out l_result;
        end case;
      end if;
    else
      l_result := p_cpi_id;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  end analyze_selector_parameter;
  

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
    p_cpi_id in varchar2,
    p_param in adc_rule_actions.cra_param_2%type)
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
        l_result := adc_page_state.get_string(g_param.cgr_id, p_cpi_id);
      when p_param = adc_util.C_PARAM_EVENT_DATA then
        l_result := get_event_data(null);
      when p_param is null then
        l_result := null;
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
    Function: calculate_parameter_value
      Method to dynamically calculate the parameter value. Expects either a valid PL/SQL function
      returning a string value or a constant string.
      
    Parameter:
      p_param - Parameter value to analyze
      
    Returns:
      The enriched parameter value if applicable, <p_param> otherwise.
   */
  function calculate_parameter_value(
    p_param in adc_rule_actions.cra_param_2%type)
    return varchar2
  as
    C_CMD constant varchar2(100) := 'begin :x := #CMD#; end;';
    l_result adc_util.max_char;
  begin
    pit.enter_detailed('calculate_parameter_value',
      p_params => msg_params(
                    msg_param('p_param', p_param)));
                    
    execute immediate replace(C_CMD, '#CMD#', trim(';' from p_param)) using out l_result;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result; -- apex_escape.json(l_result);
  exception
    when others then
      return p_param;
  end calculate_parameter_value;
  
  
  /** 
    Procedure: create_initial_rule_group_and_rule
      Method to create initial rule group and rule for a page that references ADC
      
      Is called if ADC detects that a page which references ADC does not yet 
      own a rule group and an initial rule. It then creates the default rule group and rule.
      
    Parameter:
      p_rule_group_row - Instance of the rule group row with predefined attributes
   */
  procedure create_initial_rule_group_and_rule(
    p_rule_group_row in out nocopy adc_rule_groups%rowtype)
  as
    l_rule_row adc_rules%rowtype;
  begin
    pit.enter_optional('create_initial_rule_group_and_rule');
    
    adc_admin.merge_rule_group(p_rule_group_row);
    l_rule_row.cru_cgr_id := p_rule_group_row.cgr_id;
    l_rule_row.cru_name := 'die Seite öffnet';
    l_rule_row.cru_condition := 'initializing = c_true';
    l_rule_row.cru_sort_seq := 10;
    l_rule_row.cru_active := adc_util.c_true;
    l_rule_row.cru_fire_on_page_load := adc_util.C_FALSE;
    adc_admin.merge_rule(l_rule_row);
    adc_admin.propagate_rule_change(p_rule_group_row.cgr_id);
    
    pit.leave_optional;
  end create_initial_rule_group_and_rule;
  

  /** 
    Procedure: get_and_collect_js_code
      Method to prepare JavaScript contained in a rule action for execution.
      
      Before the JavaScript code can be collected, this method replaces all argument anchors.
      The JavaScript Code is then handed over to <adc_response.add_javascript>.
      
    Parameter:
    p_action_rec - <rule_action_rec> instance of the actually selected rule.
   *         
   */
  procedure get_and_collect_js_code(
    p_action_rec in rule_action_rec)
  as
    l_java_script adc_util.max_char;
  begin
    pit.enter_optional('get_and_collect_js_code',
      p_params => msg_params(
                    msg_param('p_action_rec.js', p_action_rec.cat_js),
                    msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                    msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                    msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                    msg_param('p_action_rec.item', p_action_rec.cra_item)));

    -- Extract JavaScript chunk, replace parameters and register with response
    if g_param.stop_flag = adc_util.C_FALSE then
      l_java_script := utl_text.bulk_replace(p_action_rec.cat_js, char_table(
                         'ITEM', p_action_rec.cra_item,
                         'PARAM_1', case when p_action_rec.cra_param_1 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_1) end,
                         'PARAM_2', case when p_action_rec.cra_param_2 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_2) end,
                         'PARAM_3', case when p_action_rec.cra_param_3 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_3) end,
                         'CRU_SORT_SEQ', case when p_action_rec.cru_sort_seq is not null then 'RULE_' || p_action_rec.cru_sort_seq else 'NO_RULE_FOUND' end,
                         'CRU_NAME', p_action_rec.cru_name, --convert(p_action_rec.cru_name, 'WE8ISO8859P1'),
                         'EVENT_DATA', get_event_data(null),
                         'FIRING_ITEM', g_param.firing_item,
                         'CR', adc_util.C_CR));
                         
      if instr(l_java_script, '#SELECTOR#') > 0 then
        l_java_script := replace(l_java_script, '#SELECTOR#', analyze_selector_parameter(p_action_rec.cra_item, p_action_rec.cra_param_2, l_java_script));
      end if;
                         
      if instr(l_java_script, '#METHOD#') > 0 then
        l_java_script := replace(l_java_script, '#METHOD#', calculate_parameter_value(p_action_rec.cra_param_1));
      end if;
      
      adc_response.add_javascript(l_java_script);
    else
      pit.info(msg.ADC_STOP_NO_JAVASCRIPT, msg_args(l_java_script));
    end if;
    
    pit.leave_optional;
  end get_and_collect_js_code;
  

  /** 
    Procedure: get_and_execute_plsql_code
      Helper to prepare and execute PL/SQL code.
      
      Is used to immediately execute PL/SQL code that is included in rule actions.
      The method prepares the PL/SQL code by replacing the parameter anchors and executes it.
      If an error occurs, this is registered with ADC and the execution is stopped.
   
    Parameter:
      p_action_rec - <rule_action_rec> instance of the actually selected rule
   */
  procedure get_and_execute_plsql_code(
    p_action_rec in out nocopy rule_action_rec)
  as
    -- Don't remove COMMIT from the PL/SQL code template. As this code is called using AJAX,
    -- no transaction control from APEX exists, so we need to control it ourselves.
    C_PLSQL_CODE_TEMPLATE constant adc_util.sql_char := 'begin #CODE#; commit; end;';
    C_PLSQL_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'^apex_util.get_session_state('#ITEM#')^';
    l_plsql_code adc_util.max_char;
  begin
    pit.enter_optional('get_and_execute_plsql_code',
      p_params => msg_params(
                    msg_param('p_action_rec.pl_sql', p_action_rec.cat_pl_sql),
                    msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                    msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                    msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                    msg_param('p_action_rec.item', p_action_rec.cra_item)));
                    
    -- create PL/QSL code from template
    if g_param.stop_flag = adc_util.C_FALSE then
      l_plsql_code := utl_text.bulk_replace(trim(';' from p_action_rec.cat_pl_sql), char_table(
                        'PARAM_1', case when p_action_rec.cra_param_1 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_1) end,
                        'PARAM_2', case when p_action_rec.cra_param_2 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_2) end,
                        'PARAM_3', case when p_action_rec.cra_param_3 is not null then analyze_parameter_value(p_action_rec.cra_item, p_action_rec.cra_param_3) end,
                        'ALLOW_RECURSION', adc_recursion_stack.check_recursion(p_action_rec.cra_item, p_action_rec.cru_fire_on_page_load),
                        'ITEM_VALUE', C_PLSQL_ITEM_VALUE_TEMPLATE,
                        'EVENT_DATA', get_event_data(null),
                        'ITEM', p_action_rec.cra_item,
                        'CR', adc_util.C_CR));
                        
      l_plsql_code := replace(C_PLSQL_CODE_TEMPLATE, '#CODE#', l_plsql_code);      
      adc_response.add_comment(msg.ADC_PLSQL_CODE, msg_args(l_plsql_code));

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Display error
          pit.handle_exception(msg.ADC_PLSQL_ERROR, msg_args(l_plsql_code));
          register_error(p_action_rec.cra_item, msg.ADC_PLSQL_ERROR, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          stop_rule;
      end;
    else
      adc_response.add_comment(msg.ADC_STOP_NO_PLSQL);
    end if;
    
    pit.leave_optional;
  end get_and_execute_plsql_code;
  

  /** 
    Function: get_items_by_selector
      Method to retrieve a list of elements identified by the jQuery classes passed in.
      
      Analyses the jQuery expression and returns all items that match.
      Possible expressions:
      
      - comma separated list of CSS classes, including .-sign. Identifies page items with matching CSS elements
      - comma separated list of ID selectors, including #-sign. Identifies page items with either matching name or static id
      
    Parameters:
      p_cpi_id - Item ID or DOCUMENT.
      p_selector - jQuery expression that gets evaluated if P_CPI_ID is DOCUMENT
      
    Returns:
      CHAR_TABLE instance with all item namens that match the jQuery expression.
   */
  function get_items_by_selector(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_selector in adc_rule_actions.cra_param_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    pit.enter_optional('get_items_by_selector',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_selector', p_selector)));
    
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM and (trim(p_selector) like '.%' or trim(p_selector) like '#%') 
    then
      -- attribute contains jQuery CSS- or ID-selector, search page items with corresponding CSS or ID
      with params as(
             select g_param.cgr_id P_cgr_id,
                    '|' || replace(column_value, '.') || '|' p_css,
                    replace(column_value, '#') p_cpi_id
               from table(utl_text.string_to_table(p_selector, adc_util.C_DELIMITER)))
      select /*+ NO_MERGE (params) */
             cast(collect(cpi_id) as char_table)
        into l_item_list
        from adc_page_items
        join params
          on cpi_cgr_id = p_cgr_id
         and (instr(cpi_css, p_css) > 0 or cpi_id = p_cpi_id);
    else
      l_item_list := char_table(p_cpi_id);
    end if;
    
    pit.leave_optional;
    return l_item_list;
  end get_items_by_selector;
  
  
  /** 
    Procedure: evaluate_and_execute_rule_action
      Method calculates the answer for a given situation in the session state based on the ADC rules for the active page.
      
      Is called from PROCESS_RULE. This method queries the decision table of the rule group for the actual APEX page to
      
      - evaluate which rule to execute and 
      - execute all actions of that rule
      
    Parameter:
      p_rule_stmt - SQL statment of the decision rule. Read from the metadata earlier and passed in as a parameter
                    to avoid several roundtrips to the SQL during a rule evaluation
   */
  procedure evaluate_and_execute_rule_action(
    p_rule_stmt in adc_util.max_char)
  as
    l_action_rec rule_action_rec;
    l_action_cur sys_refcursor;
    l_ignore_rule_errors boolean;
    l_action_is_error_handler boolean;
    l_loop_counter binary_integer;
    l_rule_found boolean;
    l_origin_msg adc_util.max_char;
  begin
    pit.enter_mandatory('evaluate_and_execute_rule_action');

    -- Initialization
    l_rule_found := false;
    g_param.has_errors := false;
    
    -- Evaluate which rule to execute by querying the decision table
    open l_action_cur for p_rule_stmt;
    fetch l_action_cur into l_action_rec;
    pit.info(msg.ADC_PROCESSING_RULE, msg_args(to_char(l_action_rec.cru_sort_seq), l_action_rec.cru_name));
    
    if l_action_cur%FOUND then
      l_rule_found := true;
      -- add origin message
      case 
      when g_param.has_errors then
        l_origin_msg := msg.ADC_ERROR_HANDLING;
      when l_action_rec.cru_fire_on_page_load = adc_util.C_TRUE then
        l_origin_msg := msg.ADC_INIT_ORIGIN;
      else
        l_origin_msg := msg.ADC_RULE_ORIGIN;
      end case;
      
      adc_response.register_recursion_start(
        p_origin_message => l_origin_msg,
        p_run_count => g_param.rule_counter,
        p_cru_sort_seq => l_action_rec.cru_sort_seq,
        p_cru_name => l_action_rec.cru_name,
        p_firing_item => g_param.firing_item);
    end if;
    
    -- Process rule actions
    adc_util.monitor_loop;
    while l_action_cur%FOUND loop
      -- Initialize
      adc_response.add_comment(msg.ADC_ACTION_EXECUTED, msg_args(to_char(l_action_rec.cra_sort_seq)));
      
      -- Ignores rule errors if this rule has no exception handler action
      l_ignore_rule_errors := l_action_rec.cru_has_error_handler = adc_util.C_FALSE;
      l_action_is_error_handler := l_action_rec.cra_on_error = adc_util.C_TRUE;
      -- check whether action has to be executed
      case   
        -- Normal execution. This is true in three possible cases:
        when (not g_param.has_errors and not l_action_is_error_handler) 
          or (g_param.has_errors and l_action_is_error_handler)
          or (l_ignore_rule_errors) 
        then
          if l_action_rec.cat_pl_sql is not null then
            get_and_execute_plsql_code(l_action_rec);
          end if;
          if l_action_rec.cat_js is not null then
            get_and_collect_js_code(l_action_rec);
          end if;
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        adc_response.add_comment(msg.ADC_ACTION_REJECTED, msg_args(to_char(l_action_rec.cra_sort_seq)));
      end case;
      
      -- get next action
      fetch l_action_cur into l_action_rec;
      adc_util.monitor_loop(l_loop_counter, 'evaluate_and_execute_rule_action');
    end loop;
    
    adc_response.register_recursion_end(l_rule_found);
    adc_util.close_cursor(l_action_cur);
    
    pit.leave_mandatory;
  exception
    when others then
      adc_util.close_cursor(l_action_cur);
      pit.handle_exception(msg.SQL_ERROR, msg_args(p_rule_stmt));
  end evaluate_and_execute_rule_action;
  
  
  /** Method to prepare an exception for APEX
   * %param  p_error   APEX Error instance
   * %param  p_cpi_id  Name of the page item the error relates to
   * %usage  Is used to add meta information to an APEX error
   */
  procedure prepare_error(
    p_error in out nocopy apex_error.t_error,
    p_cpi_id in varchar2)
  as
    C_LABEL_ANCHOR constant adc_util.ora_name_type := '#LABEL#';
  begin
    pit.enter_optional('prepare_error');
    
    p_error.page_item_name := p_cpi_id;
    p_error.additional_info := apex_escape.json(p_error.additional_info || replace(dbms_utility.format_error_backtrace, adc_util.C_CR, '<br/>'));
    if instr(p_error.message, C_LABEL_ANCHOR) > 0 then
      select replace(p_error.message, C_LABEL_ANCHOR, cpi_label)
        into p_error.message
        from adc_page_items
       where cpi_cgr_id = g_param.cgr_id
         and cpi_id = p_cpi_id;
    end if;
    
    pit.leave_optional;
  end prepare_error;
  
  
  /** 
    Procedure: process_initialization_code
      Method executes any initialization code of the rule group.
      
      Called during initialization of a dynamic page. 
      ADC requires the initial values of the page items and needs to compute them, 
      as APEX does not store them during initialization in an accessible manner.
      To allow for this, ADC re-executes any page computation and row fetch process as far as possible.
   */
  procedure process_initialization_code
  as
    l_initialization_code adc_rule_groups.cgr_initialization_code%type;
  begin
    pit.enter_optional;
    
    select cgr_initialization_code
      into l_initialization_code
      from adc_rule_groups
     where cgr_id = g_param.cgr_id;
  
    if l_initialization_code is not null then
      execute immediate l_initialization_code;
    end if;
    
    -- Register all predefined mandatory items
    register_mandatory(
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_cpi_mandatory_message => null,
      p_is_mandatory => null);
    
    pit.leave_optional;
  end process_initialization_code;
  
    
  /** 
    Procedure: process_rule
      Method analyzes the requested rule of the rule group.
      
      Is called if a rule has to be executed
      
      - Create a JavaScript script to execute on the page
      - analyzes whether changes the rule initiates causes other rules to be recursively called
      
    Returns:
      HTML script element with a JavaScript code containing the answer of the rule.
   */
  procedure process_rule(
    p_rule_stmt in adc_util.max_char)
  as
  begin
    pit.enter_mandatory('process_rule');
    
    g_param.rule_counter := g_param.rule_counter + 1;
    
    if g_param.stop_flag = adc_util.C_FALSE then
      evaluate_and_execute_rule_action(p_rule_stmt);
    end if;
    
    -- remove processed item from recursive stack (or all, if requested)
    adc_recursion_stack.pop_firing_item(g_param.firing_item, g_param.stop_flag);
    
    -- Iterate over recursion stack. First firing item was pushed to the stack in READ_SETTINGS
    -- If a rule action changes the session state, the changed item will be pushed onto the recursive stack
    adc_recursion_stack.get_next(g_param.firing_item, g_param.event_data);
    if g_param.firing_item is not null then
      process_rule(p_rule_stmt);
    end if;
    
    pit.leave_mandatory;
  exception
    when others then
      -- Emergency exit, stop rule execution and register error
      register_error(g_param.firing_item, msg.ADC_INTERNAL_ERROR);
      adc_recursion_stack.pop_firing_item(null, adc_util.C_TRUE);
      pit.handle_exception(msg.ADC_INTERNAL_ERROR, msg_args(substr(sqlerrm, 12)));
  end process_rule;
  
  
  /**
    Procedure: initialize
      Method to initalize the package
   */
  procedure initialize
  as
  begin       
    g_param := null;
    g_param.rule_counter := 0;
  end initialize;
  

  /**
    Group: Public methods - Getter
   */
  /**
    Function: get_cgr_id
      See <ADC_INTERNAL.get_cgr_id>
   */
  function get_cgr_id
    return adc_rule_groups.cgr_id%type
  as
  begin
    pit.enter_optional;
    
    if g_param.cgr_id is null then
        with params as (
             select /*+ no_merge */
                    utl_apex.get_application_id g_app_id,
                    utl_apex.get_page_id g_page_id
               from dual)
      select cgr_id
        into g_param.cgr_id
        from adc_rule_groups
        join params p
          on cgr_app_id = g_app_id
         and cgr_page_id = g_page_id;
    end if;
    
    pit.leave_optional(
      p_params => msg_params(msg_param('CGR_ID', g_param.cgr_id)));
    return g_param.cgr_id;
  end get_cgr_id;
  
    
  /**
    Function: get_event
      See <ADC_INTERNAL.get_event>
   */
  function get_event
    return varchar2
  as
  begin
    -- Tracing done in ADC_API
    return g_param.firing_event;
  end get_event;
  
  
  /**
    Function: get_event_data
      See <ADC_INTERNAL.get_event_data>
   */
  function get_event_data(
     p_key in varchar2)
     return varchar2
  as
    l_event_data adc_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(msg_param('p_key', p_key)));
      
    case
    when g_param.event_data in ('true', 'false') or g_param.event_data is null then
      l_event_data := null;
    when p_key is not null then
      -- Try to find item in JSON structure
      apex_json.parse(g_param.event_data);
      l_event_data := replace(apex_json.get_varchar2(p_key), '[object Object]');
    else
      -- If no key was requested, return complete response, even if it is NULL
      l_event_data := replace(g_param.event_data, '"');
    end case;
    
    pit.leave_optional(
      p_params => msg_params(msg_param('EventData', l_event_data)));
    return l_event_data;
  exception
    when others then
      register_error(adc_util.C_NO_FIRING_ITEM, msg.ADC_PARSE_JSON, msg_args(g_param.event_data, p_key));
      pit.leave_optional;
      return null;
  end get_event_data;
  
  
  /**
    Function: get_error_flag
      See <ADC_INTERNAL.get_error_flag>
   */
  function get_error_flag
    return boolean
  as
  begin
    -- Tracing done in ADC_API
    return g_param.has_errors;
  end get_error_flag;
  
  
  /**
    Function: get_firing_item
      See <ADC_INTERNAL.get_firing_item>
   */
  function get_firing_item
    return varchar2
  as
  begin
    pit.enter_optional;
        
    pit.leave_optional(
      p_params => msg_params(msg_param('FiringItem', g_param.firing_item)));
    return g_param.firing_item;
  end get_firing_item;
  
 
  /**
    Group: Public methods - ADC plugin support
   */
  /**
    Function: get_bind_items_as_json
      See <ADC_INTERNAL.get_bind_items_as_json>
   */
  function get_bind_items_as_json
    return clob
  as
    C_BIND_JSON_TEMPLATE constant adc_util.sql_char := '[#JSON#]';
    C_BIND_JSON_ELEMENT constant adc_util.sql_char := '{"id":"#ID#","event":"#EVENT#","action":"#STATIC_ACTION#"}';
    -- List of item which need to bind an event
    cursor rule_group_cpi_ids(p_cgr_id adc_rule_groups.cgr_id%type) is
      select cpi_id, cit_cet_id, cit_has_value, to_char(null) static_action
        from adc_page_items    
        join adc_page_item_types_v
          on cpi_cit_id = cit_id
        join adc_rule_groups
          on cpi_cgr_id = cgr_id
             -- List of mandatory items
        left join adc_rule_group_status
          on cgr_id = cgs_cgr_id
         and cpi_id = cgs_cpi_id
       where cit_cet_id is not null
         and (cpi_is_required = adc_util.C_TRUE
          or cgs_cpi_id is not null)
         and cgr_active = adc_util.C_TRUE
         and cgr_id = p_cgr_id
     union all
     -- List of items which have to be bound to custom specific events
     select cra_cpi_id, cet_id, adc_util.C_FALSE, to_char(cra_param_2)
       from adc_rule_actions
       join adc_event_types
         on cet_id member of utl_text.string_to_table(cra_param_1, ':')
      where cra_cat_id = 'MONITOR_EVENT'
        and cra_cgr_id = p_cgr_id;
    l_json clob;
  begin
    pit.enter_optional('get_bind_items_as_json',
      p_params => msg_params(
                    msg_param('cgr_id', g_param.cgr_id)));
                    
    for item in rule_group_cpi_ids(g_param.cgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(C_BIND_JSON_ELEMENT, char_table(
          'ID', item.cpi_id,
          'EVENT', item.cit_cet_id,
          'STATIC_ACTION', item.static_action)),
        adc_util.C_DELIMITER, true);
    end loop;
    
    -- Create items with '~' as a replacement for '"' to prevent APEX from escaping it with an escape sequence.
    -- This assures that the browser is able to create a JavaScript object from it
    l_json := replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json);
    
    pit.leave_optional(
      p_params => msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_bind_items_as_json;
  
  
  /**
    Function: get_items_to_observe
      See <ADC_INTERNAL.get_items_to_observe>
   */
  function get_items_to_observe
    return varchar2
  as
    C_REGISTER_OBSERVER constant adc_action_types.cat_id%type := 'REGISTER_OBSERVER';
    l_observable_objects varchar2(2000);
  begin
    pit.enter_optional;
    
    select listagg(
             case when cra_cpi_id = adc_util.C_NO_FIRING_ITEM
                  then to_char(cra_param_2) 
                  else cra_cpi_id end, adc_util.C_DELIMITER) within group (order by cru_firing_items)
      into l_observable_objects
      from adc_bl_rules
     where cra_cat_id = C_REGISTER_OBSERVER
       and cgr_id = g_param.cgr_id;
       
    pit.leave_optional(p_params => msg_params(msg_param('Observable objects', l_observable_objects)));
    return l_observable_objects;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional(p_params => msg_params(msg_param('Observable objects', 'None')));
      return null;
  end get_items_to_observe;    


  /**
    Function: get_page_items
      See <ADC_INTERNAL.get_page_items>
   */
  function get_page_items
    return varchar2
  as
    l_changed_value_items adc_util.max_char;
  begin
    pit.enter_optional;
    
    -- concatenate list
    l_changed_value_items := adc_page_state.get_changed_items_as_json;
    
    pit.leave_optional;
    return trim(adc_util.C_DELIMITER from l_changed_value_items);
  end get_page_items;
  
  
  /**
    Function: process_request
      See <ADC_INTERNAL.process_request>
   */
  function process_request
    return clob
  as
    l_js_script adc_util.max_char;
    l_rule_stmt adc_util.max_char;
  begin      
    pit.enter_mandatory;
    
    if g_param.firing_event = adc_util.C_INITIALIZE_EVENT then
      -- Initialize session state with page item default values
      process_initialization_code;
    end if;
    
    -- get rule statement to evaluate the necessary actions
    select cgr_decision_table
      into l_rule_stmt
      from adc_rule_groups
     where cgr_id = g_param.cgr_id;
    process_rule(l_rule_stmt);
    
    l_js_script := adc_response.get_response;
    
    adc_page_state.reset;
      
    pit.leave_mandatory(
      p_params => msg_params(msg_param('JavaScript', l_js_script)));
    return l_js_script;
  end process_request;
  
  
  /**
    Procedure: push_error
      See <ADC_INTERNAL.push_error>
   */
  procedure push_error(
    p_error in apex_error.t_error)
  as
  begin
    pit.enter_optional;
  
    adc_response.add_error(p_error);
    
    g_param.has_errors := true;
    
    pit.leave_optional;
  end push_error;
  

  /**
    Procedure: read_settings
      See <ADC_INTERNAL.read_settings>
   */
  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2)
  as
    l_rule_group_row adc_rule_groups%rowtype;
    l_rule_row adc_rules%rowtype;
    l_message message_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_firing_item', p_firing_item),
                    msg_param('p_event', p_event),
                    msg_param('p_event_data', p_event_data)));
                    
    pit.assert_not_null(p_firing_item);
    pit.assert_not_null(p_event);
    l_rule_group_row.cgr_app_id := apex_application.g_flow_id;
    l_rule_group_row.cgr_page_id := apex_application.g_flow_step_id;
    
    -- Read rule group
    select cgr_id
      into g_param.cgr_id
      from adc_rule_groups
     where cgr_app_id = l_rule_group_row.cgr_app_id
       and cgr_page_id = l_rule_group_row.cgr_page_id;
    
        
    -- Initialize collections
    g_param.bind_event_items := char_table();
    g_param.firing_item := p_firing_item;
    g_param.initialize_mode := g_param.firing_item = adc_util.C_NO_FIRING_ITEM;
    g_param.firing_event := p_event;
    g_param.event_data := p_event_data;
    g_param.stop_flag := adc_util.C_FALSE;
    g_param.has_errors := false;
    g_param.rule_counter := 0;
    adc_recursion_stack.reset(g_param.cgr_id, g_param.firing_item);    
    adc_page_state.reset;
    adc_response.initialize_response(g_param.initialize_mode, g_param.cgr_id);
    
    -- Any firing item that may have a page state value needs to be checked whether it is
    -- - possible to convert it to the required data type
    -- - a mandatory field (and, in that case, contains a value)
    if adc_page_state.item_may_have_value(
         p_cgr_id => g_param.cgr_id,
         p_cpi_id => g_param.firing_item) then
         
      adc_page_state.set_value(
        p_cgr_id => g_param.cgr_id, 
        p_cpi_id => g_param.firing_item,
        p_value => adc_page_state.C_FROM_SESSION_STATE,
        p_throw_error => adc_util.C_TRUE);
    end if;
    
    pit.assert_not_null(g_param.cgr_id);
    pit.leave_optional;
  exception
    when msg.ADC_INVALID_NUMBER_ERR or msg.ADC_INVALID_DATE_ERR then
      l_message := pit.get_active_message;
      register_error(g_param.firing_item, l_message.message_name, l_message.message_args);
      stop_rule;
    when NO_DATA_FOUND then
      create_initial_rule_group_and_rule(l_rule_group_row);
      -- recursivley read the settings for the new rule group
      read_settings(p_firing_item, p_event, p_event_data);
    when msg.ADC_ITEM_IS_MANDATORY_ERR then
      l_message := pit.get_active_message;
      register_error(
        p_cpi_id => g_param.firing_item, 
        p_message_name => msg.ADC_ITEM_IS_MANDATORY);
      stop_rule;
      pit.leave_mandatory;
  end read_settings;
    
    
  /** 
    Group: Public methods - ADC functionality support
   */
  /**
    Procedure: add_javascript
      See <ADC_API.add_javascript>
   */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default adc_util.C_JS_CODE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_java_script', p_java_script),
                    msg_param('p_debug_level', p_debug_level)));
                    
    adc_response.add_javascript(p_java_script, p_debug_level);
  
    pit.leave_optional;
  end add_javascript;
  
  
  /**
    Procedure: check_mandatory
      See <ADC_API.check_mandatory>
   */
  procedure check_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stop in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_message adc_util.max_char := 'not checked';
    l_exception message_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_stop', p_stop)));
    
    if not g_param.initialize_mode then
      begin
        adc_page_state.check_mandatory(
          p_cgr_id => g_param.cgr_id,
          p_cpi_id => p_cpi_id);
      exception
        when msg.ADC_ITEM_IS_MANDATORY_ERR then
          l_exception := pit.get_active_message;
          register_error(
            p_cpi_id => p_cpi_id, 
            p_error_msg => l_exception.message_text,
            p_internal_error => null);
          stop_rule;
      end;
      l_message := 'checked';
    end if;
      
    pit.leave_mandatory(
        p_params => msg_params(msg_param('Item', l_message)));
  exception
    when NO_DATA_FOUND then
      -- item is not mandatory, ignore
      pit.leave_mandatory(
        p_params => msg_params(msg_param('Item', 'not mandatory')));
    when others then
      register_error(p_cpi_id, substr(sqlerrm, 12), '');
  end check_mandatory;
  
  
  /**
    Procedure: execute_action
      See <ADC_API.execute_action>
   */
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type,
    p_allow_recursion in adc_util.flag_type)
  as
    l_row adc_action_types%rowtype;
    l_java_script adc_util.max_char;
  begin
    -- Tracing done in ADC_API
    select *
      into l_row
      from adc_action_types
     where cat_id = p_cat_id;

    if l_row.cat_pl_sql is not null then
      l_row.cat_pl_sql := utl_text.bulk_replace('begin #CODE#; end;', char_table(
                            'CODE', rtrim(l_row.cat_pl_sql, ';'),
                            'ITEM', p_cpi_id,
                            'PARAM_1', case when p_param_1 is not null then analyze_parameter_value(p_cpi_id, p_param_1) end,
                            'PARAM_2', case when p_param_2 is not null then analyze_parameter_value(p_cpi_id, p_param_2) end,
                            'PARAM_3', case when p_param_3 is not null then analyze_parameter_value(p_cpi_id, p_param_3) end,
                            'ALLOW_RECURSION', p_allow_recursion));
      execute immediate l_row.cat_pl_sql;
    end if;

    if l_row.cat_js is not null then
      l_java_script := utl_text.bulk_replace(l_row.cat_js, char_table(
                         'ITEM', p_cpi_id,
                         'PARAM_1', case when p_param_1 is not null then analyze_parameter_value(p_cpi_id, p_param_1) end,
                         'PARAM_2', case when p_param_2 is not null then analyze_parameter_value(p_cpi_id, p_param_2) end,
                         'PARAM_3', case when p_param_3 is not null then analyze_parameter_value(p_cpi_id, p_param_3) end));
                         
      if instr(l_java_script, '#METHOD#') > 0 then
        l_java_script := replace(l_java_script, '#METHOD#', calculate_parameter_value(p_param_1));
      end if;
                         
      if instr(l_java_script, '#SELECTOR#') > 0 then
        l_java_script := replace(l_java_script, '#SELECTOR#', analyze_selector_parameter(p_cpi_id, p_param_2, l_row.cat_js));
      end if;
      
      adc_response.add_javascript(l_java_script);
    end if;
  exception
    when NO_DATA_FOUND then
      register_error('DOCUMENT', msg.ADC_ACTION_DOES_NOT_EXIST, msg_args(p_cat_id));
    when others then
      pit.handle_exception(msg.ADC_PLSQL_ERROR, msg_args(l_row.cat_pl_sql));
  end execute_action;


  /**
    Procedure: execute_command
      See <ADC_API.execute_command>
   */
  procedure execute_command(
    p_command in adc_apex_actions.caa_id%type)
  as
    C_COMMAND constant adc_util.ora_name_type := 'COMMAND';
    C_JSON_COMMAND constant adc_util.ora_name_type := '{"command":"#COMMAND#"}';
  begin
    g_param.cgr_id := 67;
    select replace(C_JSON_COMMAND, '#COMMAND#', caa_name)
      into g_param.event_data
      from adc_apex_actions
     where caa_id = p_command;
    g_param.firing_event := 'command';
    pit.log_state(
      msg_params(
        msg_param('Command', g_param.event_data)));
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_param.cgr_id,
      p_cpi_id => C_COMMAND);
  end execute_command;
  

  /**
    Procedure: raise_item_event
      See <ADC_API.raise_item_event>
   */
  procedure raise_item_event(
    p_cpi_id in varchar2)
  as
    l_has_rule number;
    l_dummy adc_util.max_char;
  begin
    pit.enter_detailed('raise_item_event',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_recursion_stack.push_firing_item(g_param.cgr_id, p_cpi_id);
    
    pit.leave_detailed;
  end raise_item_event;  


  /**
    Procedure: register_error
      See <ADC_API.register_error>
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
    l_error apex_error.t_error;
    l_dummy adc_util.max_char;
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, 12);
  begin
    pit.enter_optional('register_error',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_error_msg', p_error_msg),
                    msg_param('p_internal_error', p_internal_error)));
    -- Tracing done in ADC_API
    
    -- Get the element value to make sure it is registered as a changed item
    l_dummy := adc_page_state.get_string(g_param.cgr_id, p_cpi_id);

    if p_error_msg is not null then
      l_error.message := p_error_msg;
      l_error.additional_info := p_internal_error;
      prepare_error(l_error, p_cpi_id);
      push_error(l_error);
    end if;
    
    pit.leave_optional;
  end register_error;


  /**
    Procedure: register_error
      See <ADC_API.register_error>
   */
  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
    l_message message_type;
  begin
    -- Tracing done in ADC_API
    l_message := pit.get_message(p_message_name, p_msg_args);
    register_error(
      p_cpi_id => p_cpi_id,
      p_error_msg => l_message.message_text,
      p_internal_error => l_message.message_description);    
  end register_error;
  
  
  /**
    Procedure: register_mandatory
      See <ADC_API.register_mandatory>
   */
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
    l_item_list char_table;
  begin
    -- Tracing done in ADC_API
    pit.assert_not_null(g_param.cgr_id);
    
    case
    when p_cpi_id != adc_util.C_NO_FIRING_ITEM or (p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is null) then
      adc_page_state.register_mandatory(
        p_cgr_id => g_param.cgr_id,
        p_cpi_id => p_cpi_id,
        p_cpi_mandatory_message => p_cpi_mandatory_message,
        p_is_mandatory => p_is_mandatory);
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
      -- jQuery selector passed in. Read all elements affected by this selector
      l_item_list := get_items_by_selector(p_cpi_id, p_jquery_selector);
      for i in 1 .. l_item_list.count loop
        adc_page_state.register_mandatory(
          p_cgr_id => g_param.cgr_id,
          p_cpi_id => l_item_list(i),
          p_cpi_mandatory_message => p_cpi_mandatory_message, 
          p_is_mandatory => p_is_mandatory);
      end loop;
    else
      -- wrong parameterization, ignore
      null;
    end case;
  exception
    when NO_DATA_FOUND then
      -- Item is not in mandatory list and is requested to be optional. Ignore
      null;
  end register_mandatory;
  
  
  /**
    Procedure: register_observer
      See <ADC_API.register_observer>
   */
  procedure register_observer(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_optional;
    
    if g_param.initialize_mode then
      g_param.bind_event_items.extend;
      g_param.bind_event_items(g_param.bind_event_items.last) := p_cpi_id;
    end if;
    
    pit.leave_optional;
  end register_observer;
      
    
  /**
    Procedure: set_session_state
      See <ADC_API.set_session_state>
   */
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_2%type default null)
  as
    l_item_list char_table := char_table();
    l_exception message_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_number_value', p_number_value),
                    msg_param('p_date_value', p_date_value),
                    msg_param('p_allow_recursion', p_allow_recursion),
                    msg_param('p_jquery_selector', p_jquery_selector)));
                    
    case
    when adc_page_state.item_may_have_value(g_param.cgr_id, p_cpi_id) then
      adc_page_state.set_value(
        p_cgr_id => g_param.cgr_id,
        p_cpi_id => p_cpi_id,
        p_value => p_value,
        p_number_value => p_number_value,
        p_date_value => p_date_value,
        p_throw_error => p_allow_recursion);
      if p_allow_recursion  = adc_util.C_TRUE then
        raise_item_event(p_cpi_id);
      end if;
      adc_response.add_comment(msg.ADC_SESSION_STATE_SET, msg_args(p_cpi_id, adc_page_state.get_string(g_param.cgr_id, p_cpi_id)));
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
      l_item_list := get_items_by_selector(p_cpi_id, p_jquery_selector);
      -- recursively call SET_SESSION_STATE for each found item
      for i in 1 .. l_item_list.count loop
        set_session_state(
          p_cpi_id => l_item_list(i), 
          p_value => p_value, 
          p_number_value => p_number_value, 
          p_date_value => p_date_value, 
          p_allow_recursion => p_allow_recursion, 
          p_jquery_selector => null);
      end loop;
    else
      -- page item can't have a value, ignore
      null;
    end case;
      
    pit.leave_mandatory;
  exception
    when msg.ADC_ITEM_IS_MANDATORY_ERR then
      l_exception := pit.get_active_message;
      register_error(
        p_cpi_id => p_cpi_id, 
        p_error_msg => l_exception.message_text,
        p_internal_error => null);
      pit.leave_mandatory;
    when others then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args('Error at ' || p_cpi_id || ' and value ' || p_value || ': ' || sqlerrm));
  end set_session_state;


  /**
    Procedure: set_value_from_stmt
      See <ADC_API.set_value_from_stmt>
   */
  procedure set_value_from_statement(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_statement in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    c_stmt constant varchar2(200) := 'select * from (#STMT#) where rownum = 1';
    l_stmt adc_util.max_char;
    l_result varchar2(4000);
    l_cur integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
  begin
    l_stmt := replace(c_stmt, '#STMT#', p_statement);
    
    if p_cpi_id = adc_util.c_no_firing_item or p_cpi_id is null then
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Executing item statement'));
      -- Wird kein Element angegeben, werden die Elemente gemaess des Spaltennamens gesetzt
      l_cur := dbms_sql.open_cursor;
      -- SQL parsen, um Spaltenbezeichner zu ermitteln
      dbms_sql.parse(l_cur, l_stmt, dbms_sql.native);
      dbms_sql.describe_columns2(l_cur, l_col_cnt, l_desc_tab);
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('... ' || l_col_cnt || ' column(s) found'));
      for i in 1 .. l_col_cnt loop
        dbms_sql.define_column(l_cur, i, l_result, 4000);
      end loop;
      
      -- SQL ausfuehren und erste Zeile laden
      l_cnt := dbms_sql.execute_and_fetch(l_cur);
      -- Alle Spaltenwerte in Seitenelemente mit entsprechendem Spaltennamen kopieren
      for i in 1 .. l_col_cnt loop
        dbms_sql.column_value(l_cur, i, l_result);
        pit.debug(msg.PIT_PASS_MESSAGE, msg_args('... ' || l_desc_tab(i).col_name || ': ' || l_result));
        -- Wert in Sessionstatus kopieren
        set_session_state(
          p_cpi_id => l_desc_tab(i).col_name,  
          p_value => l_result, 
          p_allow_recursion => p_allow_recursion);
      end loop;
      dbms_sql.close_cursor(l_cur);
    else
      -- Konkretes Element angefordert, laut Konvention ist nur eine Spalte enthalten
      execute immediate l_stmt into l_result;
      set_session_state(
        p_cpi_id => p_cpi_id, 
        p_value => l_result, 
        p_allow_recursion => p_allow_recursion);
    end if;
  exception
    when NO_DATA_FOUND then
      null;
    when others then
      adc_response.add_comment(msg.ADC_NO_DATA_FOR_ITEM, msg_args(coalesce(p_cpi_id, replace(p_statement, adc_util.C_CR))));
      set_session_state(
        p_cpi_id => p_cpi_id, 
        p_value => '');
  end set_value_from_statement;
  
  
  
  /**
    Procedure: set_value_from_cursor
      See <ADC_API.set_value_from_cursor>
   */
  procedure set_value_from_cursor(
    p_cursor in out nocopy sys_refcursor)
  as
    l_result varchar2(4000);
    l_cur binary_integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
  begin
    l_cur := dbms_sql.to_cursor_number(p_cursor);
    -- SQL parsen, um Spaltenbezeichner zu ermitteln
    dbms_sql.describe_columns2(l_cur, l_col_cnt, l_desc_tab);
    for i in 1 .. l_col_cnt loop
      dbms_sql.define_column(l_cur, i, l_result, 4000);
    end loop;
    
    -- SQL ausfuehren und erste Zeile laden
    l_cnt := dbms_sql.execute_and_fetch(l_cur);
    -- Alle Spaltenwerte in Seitenelemente mit entsprechendem Spaltennamen kopieren
    for i in 1 .. l_col_cnt loop
      dbms_sql.column_value(l_cur, i, l_result);
      -- Wert in Sessionstatus kopieren
      set_session_state(
        p_cpi_id => l_desc_tab(i).col_name,  
        p_value => l_result, 
        p_allow_recursion => adc_util.C_FALSE);
    end loop;
    dbms_sql.close_cursor(l_cur);
  end set_value_from_cursor;
  
  /**
    Procedure: stop_rule
      See <ADC_API.stop_rule>
   */
  procedure stop_rule
  as
  begin
    pit.enter_detailed('stop_rule');
    -- Tracing done in ADC_API
    pit.leave_detailed;
    g_param.stop_flag := adc_util.C_TRUE;
  end stop_rule;
    
  
  /**
    Procedure: validate_page
      See <ADC_API.validate_page>
   */
  procedure validate_page
  as
    cursor mandatory_item_cur is
      select cgs_cpi_id, cgs_cpi_mandatory_message
        from adc_rule_group_status
       where cgs_cgr_id = g_param.cgr_id;

    cursor validation_action_cur is
      select cra_cat_id, cra_cpi_id, cra_param_1, cra_param_2, cra_param_3
        from adc_rule_actions
       where cra_cgr_id = g_param.cgr_id
         and cra_raise_on_validation = adc_util.C_TRUE;
    l_exception message_type;
  begin
    -- Tracing done in ADC_API
    
    -- Check all mandatory fields (elements may not have triggered a CHANGE event)
    for itm in mandatory_item_cur loop
      begin
        adc_page_state.check_mandatory(
          p_cgr_id => g_param.cgr_id,
          p_cpi_id => itm.cgs_cpi_id);
      exception
        when msg.ADC_ITEM_IS_MANDATORY_ERR then
          l_exception := pit.get_active_message;
          register_error(
            p_cpi_id => itm.cgs_cpi_id, 
            p_error_msg => l_exception.message_text,
            p_internal_error => null);
      end;
    end loop;

    -- Check all validations of the current ADC group
    for sra in validation_action_cur loop
      execute_action(
        p_cat_id => sra.cra_cat_id,
        p_cpi_Id => sra.cra_cpi_id,
        p_param_1 => sra.cra_param_1,
        p_param_2 => sra.cra_param_2,
        p_param_3 => sra.cra_param_3,
        p_allow_recursion => adc_util.C_FALSE);
    end loop;
  end validate_page;
  
begin
  initialize;
end adc_internal;
/