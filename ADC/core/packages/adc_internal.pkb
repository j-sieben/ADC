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
    Type: rule_action_rec
      Record for recording data of the actually executed rule and rule action.
      Type matches ADC_RULE_GROUP.crg_decision_table statements.
      
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
    cra_on_error adc_rule_actions.cra_on_error%type,
    cra_param_1 adc_rule_actions.cra_param_1%type,
    cra_param_1_type adc_action_param_types.capt_id%type,
    cra_param_2 adc_rule_actions.cra_param_2%type,
    cra_param_2_type adc_action_param_types.capt_id%type,
    cra_param_3 adc_rule_actions.cra_param_3%type,
    cra_param_3_type adc_action_param_types.capt_id%type,
    cru_has_error_handler adc_rule_actions.cra_on_error%type,
    is_first_action adc_util.flag_type
  );

  
  /** 
    Type: param_rec
      Central record for the plugin attributes.
      
    Properties:
      crg_id adc_rule_groups.crg_id%type - actual CRG_ID
      firing_item adc_page_items.cpi_id%type - actual firing item (or adc_util.C_NO_FIRING_ITEM)
      firing_event adc_page_item_types.cpit_cet_id%type - actual firing event (normally change or click, but can be any event)
      initialize_mode boolean - Flag to indicate whether automatic mandatory checks should be paused
      event_data adc_util.max_char - optional event data that is returned from modal dialog pages etc.
      bind_event_items char_table - List of items for which ADC binds event handlers
      additional_items char_table - List of items for which ADC maintains page state in addition to 
      stop_flag adc_util.flag_type - Flag to indicate that all rule execution has to be stopped
      now binary_integer - timestamp, used to calculate the execution duration
      has_errors boolean - Flag to indicate whether a rule has encounterd an error so far. Is reset per rule execution
   */
  type param_rec is record(
    crg_id adc_rule_groups.crg_id%type, 
    crg_is_active boolean,
    firing_item adc_page_items.cpi_id%type,
    firing_event adc_page_item_types.cpit_cet_id%type,
    initialize_mode boolean,
    event_data adc_util.max_char,
    bind_event_items char_table,
    additional_items char_table,
    stop_flag adc_util.flag_type,
    has_errors boolean,
    rule_counter binary_integer
  );
  g_param param_rec;
  
  C_CMD constant varchar2(100) := 'begin :x := #CMD#; end;';
    
  /**
    Group: Private Methods
   */  
  /** 
    Procedure: create_initial_rule_group_and_rule
      Method to create initial rule group and rule for a page that references ADC
      
      Is called if ADC detects that a page which references ADC does not yet 
      own a rule group and an initial rule. It then creates the default rule group and rule.
   */
  procedure create_initial_rule_group_and_rule
  as
    l_rule_group_rec adc_rule_groups%rowtype;
    l_rule_rec adc_rules%rowtype;
  begin
    pit.enter_optional('create_initial_rule_group_and_rule');
    
    -- create rule group entry
    l_rule_group_rec.crg_app_id := utl_apex.get_application_id;
    l_rule_group_rec.crg_page_id := utl_apex.get_page_id;    
    adc_admin.merge_rule_group(l_rule_group_rec);
    
    -- create intial rule
    g_param.crg_id := l_rule_group_rec.crg_id;
    l_rule_rec.cru_crg_id := l_rule_group_rec.crg_id;
    l_rule_rec.cru_name := adc_util.get_trans_item_name('CRU_INITIAL_RULE_NAME');
    l_rule_rec.cru_condition := 'initializing = c_true';
    l_rule_rec.cru_sort_seq := 10;
    l_rule_rec.cru_active := adc_util.C_TRUE;
    l_rule_rec.cru_fire_on_page_load := adc_util.C_FALSE;
    adc_admin.merge_rule(l_rule_rec);
    
    adc_admin.propagate_rule_change(l_rule_group_rec.crg_id);
    
    pit.leave_optional;
  end create_initial_rule_group_and_rule;
  
  
  /**
    Function: generate_parameterized_code
      Method to calculate the concrete resulting javascript or pl/sql code based 
      on rule action settings.
      
    Parameter:
      p_row - Instance of <rule_action_rec> with actual parameter values
      
    Returns:
      String containing the javascript or pl/sql code.
   */
  function generate_parameterized_code(
    p_mode in varchar2,
    p_row in rule_action_rec)
    return varchar2
  as
    l_template adc_util.max_char;
    l_code adc_util.max_char;
  begin
    pit.enter_detailed('generate_parameterized_code');
    
    if p_mode = 'JAVASCRIPT' then
      l_template := p_row.cat_js;
    else
      l_template := trim(';' from p_row.cat_pl_sql);
    end if;
    
    l_code := utl_text.bulk_replace(l_template, char_table(
                'ITEM', p_row.cra_item,
                'SELECTOR', adc_parameter.analyze_selector_parameter(p_row.cra_item, p_row.cra_param_2),
                'PARAM_1', adc_parameter.evaluate_parameter(p_row.cra_param_1_type, p_row.cra_param_1, g_param.crg_id, p_row.cra_item),
                'PARAM_2', adc_parameter.evaluate_parameter(p_row.cra_param_2_type, p_row.cra_param_2, g_param.crg_id, p_row.cra_item),
                'PARAM_3', adc_parameter.evaluate_parameter(p_row.cra_param_3_type, p_row.cra_param_3, g_param.crg_id, p_row.cra_item),
                'CRU_SORT_SEQ', case when p_row.cru_sort_seq is not null then 'RULE_' || p_row.cru_sort_seq else 'NO_RULE_FOUND' end,
                'CRU_NAME', p_row.cru_name,
                'FIRING_ITEM', g_param.firing_item,
                'ALLOW_RECURSION', adc_recursion_stack.check_recursion(p_row.cra_item, p_row.cru_fire_on_page_load),
                'CR', adc_util.C_CR));
                
    pit.leave_detailed(
      p_params => msg_params(msg_param('Code', l_code)));
    return l_code;
  end generate_parameterized_code;
  

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
  begin
    if p_action_rec.cat_js is not null then
      pit.enter_optional('get_and_collect_js_code',
        p_params => msg_params(
                      msg_param('p_action_rec.cat_js', p_action_rec.cat_js),
                      msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                      msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                      msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                      msg_param('p_action_rec.item', p_action_rec.cra_item)));
  
      -- Extract JavaScript chunk, replace parameters and register with response
      if g_param.stop_flag = adc_util.C_FALSE then
        adc_response.add_javascript(generate_parameterized_code('JAVASCRIPT', p_action_rec));
      else
        pit.info(msg.ADC_STOP_NO_JAVASCRIPT, msg_args(p_action_rec.cat_js));
      end if;
      
      pit.leave_optional;
    else
      pit.verbose(msg.ADC_NO_JAVASCRIPT_ACTION);
    end if;
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
    l_plsql_code adc_util.max_char;
  begin
    if p_action_rec.cat_pl_sql is not null then
      pit.enter_optional('get_and_execute_plsql_code',
        p_params => msg_params(
                      msg_param('p_action_rec.cat_pl_sql', p_action_rec.cat_pl_sql),
                      msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                      msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                      msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                      msg_param('p_action_rec.item', p_action_rec.cra_item)));
                      
      -- create PL/QSL code from template
      if g_param.stop_flag = adc_util.C_FALSE then
        l_plsql_code := generate_parameterized_code('PLSQL', p_action_rec);
                          
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
        adc_response.add_comment(msg.ADC_STOP_NO_PLSQL, msg_args(p_action_rec.cat_pl_sql));
      end if;
      
      pit.leave_optional;
    end if;
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
             select g_param.crg_id P_crg_id,
                    '|' || replace(column_value, '.') || '|' p_css,
                    replace(column_value, '#') p_cpi_id
               from table(utl_text.string_to_table(p_selector, adc_util.C_DELIMITER)))
      select /*+ NO_MERGE (params) */
             cast(collect(cpi_id) as char_table)
        into l_item_list
        from adc_page_items
        join params
          on cpi_crg_id = p_crg_id
         and (instr(cpi_css, p_css) > 0 or cpi_id = p_cpi_id);
    else
      l_item_list := char_table(p_cpi_id);
    end if;
    
    pit.leave_optional;
    return l_item_list;
  end get_items_by_selector;
  
  
  /**
    Procedure: add_origin_comment
      Adds a comment that indicates the origin of a rule execution
      
    Parameter:
      p_action_rec - Record of the active rule execution
   */
  procedure add_origin_comment(
    p_action_rec rule_action_rec)
  as
    l_origin_msg adc_util.max_char;
  begin
    pit.enter_detailed('add_origin_comment');
    
    case 
    when g_param.has_errors then
      l_origin_msg := msg.ADC_ERROR_HANDLING;
    when g_param.initialize_mode and p_action_rec.cru_fire_on_page_load = adc_util.C_TRUE then
      l_origin_msg := msg.ADC_INIT_ORIGIN;
    else
      l_origin_msg := msg.ADC_RULE_ORIGIN;
    end case;
    
    adc_response.register_recursion_start(
      p_origin_message => l_origin_msg,
      p_run_count => g_param.rule_counter,
      p_cru_sort_seq => p_action_rec.cru_sort_seq,
      p_cru_name => p_action_rec.cru_name,
      p_firing_item => g_param.firing_item);
      
    pit.leave_detailed;
  end add_origin_comment;
  
  
  /**
    Function: check_execute_rule
      Method checks whether a found rule has to be executed
      
    Parameter:
      p_action_rec - Record of the active rule execution
      
    Returns:
      TRUE, if the rule has to be executed, FALSE otherwise
   */
  function check_execute_rule(
    p_action_rec rule_action_rec)
    return boolean
  as
    l_ignore_rule_errors boolean;
    l_action_is_error_handler boolean;
    l_result boolean;
    l_message adc_util.ora_name_type;
  begin
    pit.enter_detailed('check_execute_rule');
    
    l_ignore_rule_errors := p_action_rec.cru_has_error_handler = adc_util.C_FALSE;
    l_action_is_error_handler := p_action_rec.cra_on_error = adc_util.C_TRUE;
    
    case
      when (not g_param.has_errors and not l_action_is_error_handler) -- normal execution
             or (g_param.has_errors and l_action_is_error_handler)    -- error handler
             or (l_ignore_rule_errors)                                -- errors are ignored
      then 
        l_result := true;
      when not g_param.has_errors and l_action_is_error_handler then
        -- Execution rejected, because no exception occured and action is an exception handler
        l_result := false;
        l_message := msg.ADC_NO_ERROR;
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        l_result := false;
        l_message := msg.ADC_ACTION_REJECTED;
    end case;
    
    if not l_result then         
      adc_response.add_comment(l_message, msg_args(to_char(p_action_rec.cra_sort_seq)));
    end if;
    
    pit.leave_detailed;
    return l_result;
  end check_execute_rule;
  
  
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
    l_loop_counter binary_integer;
    l_rule_found boolean;
  begin
    pit.enter_mandatory('evaluate_and_execute_rule_action');

    -- Initialization
    l_rule_found := false;
    g_param.has_errors := false;
    
    -- Evaluate which rule to execute by querying the decision table
    open l_action_cur for p_rule_stmt;
    fetch l_action_cur into l_action_rec;
    pit.info(msg.ADC_PROCESSING_RULE, msg_args(to_char(l_action_rec.cru_sort_seq), l_action_rec.cru_name));
    
    -- Process rule actions
    adc_util.monitor_loop;
    while l_action_cur%FOUND loop
      if not l_rule_found then        
        l_rule_found := true;
        add_origin_comment(l_action_rec);
      end if;
      
      -- execute rule action if possible
      if check_execute_rule(l_action_rec) then
        get_and_execute_plsql_code(l_action_rec);
        get_and_collect_js_code(l_action_rec);
        adc_response.add_comment(msg.ADC_ACTION_EXECUTED, msg_args(to_char(l_action_rec.cra_sort_seq)));
      end if;
      
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
      pit.handle_exception(msg.PIT_SQL_ERROR, msg_args(p_rule_stmt));
  end evaluate_and_execute_rule_action;
  
  
  /** Method to prepare an exception for APEX
   * %param  p_error   APEX Error instance
   * %param  p_cpi_id  Name of the page item the error relates to
   * %usage  Is used to add meta information to an APEX error
   */
  procedure prepare_error(
    p_error in out nocopy apex_error.t_error,
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    C_LABEL_ANCHOR constant adc_util.ora_name_type := '#LABEL#';
  begin
    pit.enter_optional('prepare_error');
    
    p_error.page_item_name := p_cpi_id;
    if pit.check_log_level_greater_equal(pit.level_debug) then
      p_error.additional_info := apex_escape.json(p_error.additional_info || replace(dbms_utility.format_error_backtrace, adc_util.C_CR, '<br/>'));
    end if;
    if instr(p_error.message, C_LABEL_ANCHOR) > 0 then
      select replace(p_error.message, C_LABEL_ANCHOR, cpi_label)
        into p_error.message
        from adc_page_items
       where cpi_crg_id = g_param.crg_id
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
    l_initialization_code adc_rule_groups.crg_initialization_code%type;
  begin
    pit.enter_optional;
    
    select crg_initialization_code
      into l_initialization_code
      from adc_rule_groups
     where crg_id = g_param.crg_id;
  
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
    adc_recursion_stack.get_next(g_param.firing_item, g_param.firing_event, g_param.event_data);
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
    Function: evaluate_action_type
      Method retrieve the parameters and other meta data for the requested action type.
      Is called when an action is evaluated
      
    Returns:
      row record for the requeste action type
   */
  function evaluate_action_type(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type,
    p_allow_recursion in adc_util.flag_type default null)
    return rule_action_rec
  as
    l_row rule_action_rec;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id)));
                    
    select null cru_id, null cru_sort_seq, null cru_name, null cru_firing_items, null cru_fire_on_page_load,
           p_cpi_id cra_item, cat_pl_sql, cat_js, null cra_sort_seq, null cra_on_error,
           p_param_1 cra_param_1, max(decode(cap_sort_seq, 1, cap_capt_id)) cra_param_1_type,
           p_param_2 cra_param_2, max(decode(cap_sort_seq, 2, cap_capt_id)) cra_param_2_type,
           p_param_3 cra_param_3, max(decode(cap_sort_seq, 3, cap_capt_id)) cra_param_3_type,
           null cru_has_error_handler, null is_first_action
      into l_row
      from adc_action_types
      left join adc_action_parameters
        on cat_id = cap_cat_id
     where cat_id = p_cat_id
     group by cat_pl_sql, cat_js;
     
    pit.leave_detailed;
    return l_row;
  end evaluate_action_type;
  
  
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
    Function: get_crg_id
      See <ADC_INTERNAL.get_crg_id>
   */
  function get_crg_id
    return adc_rule_groups.crg_id%type
  as
    l_active adc_util.flag_type;                 
  begin
    pit.enter_optional;
    
    if g_param.crg_id is null then
        with params as (
             select /*+ no_merge */
                    utl_apex.get_application_id g_app_id,
                    utl_apex.get_page_id g_page_id
               from dual)
      select crg_id, crg_active
        into g_param.crg_id, l_active
        from adc_rule_groups
        join params p
          on crg_app_id = g_app_id
         and crg_page_id = g_page_id;
      g_param.crg_is_active := case l_active when adc_util.C_TRUE then true else false end;                                               
    end if;
    
    pit.leave_optional(
      p_params => msg_params(msg_param('CRG_ID', g_param.crg_id)));
    return g_param.crg_id;
  end get_crg_id;
  
    
  /**
    Function: get_event
      See <ADC_INTERNAL.get_event>
   */
  function get_event
    return varchar2
  as
  begin
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
    cursor rule_group_cpi_ids(p_crg_id adc_rule_groups.crg_id%type) is
      select cpi_id, cpit_cet_id, cpit_has_value, static_action
        from adc_bl_bind_items
       where crg_id = p_crg_id;
    l_json clob;
  begin
    pit.enter_optional('get_bind_items_as_json',
      p_params => msg_params(
                    msg_param('crg_id', g_param.crg_id)));
                    
    for item in rule_group_cpi_ids(g_param.crg_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(C_BIND_JSON_ELEMENT, char_table(
          'ID', item.cpi_id,
          'EVENT', item.cpit_cet_id,
          'STATIC_ACTION', item.static_action)),
        adc_util.C_DELIMITER, true);
    end loop;
    
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
    
    select listagg(distinct 
             case when cra_cpi_id = adc_util.C_NO_FIRING_ITEM
                  then to_char(cra_param_2) 
                  else cra_cpi_id end, adc_util.C_DELIMITER) within group (order by cru_firing_items)
      into l_observable_objects
      from adc_bl_rules
     where cra_cat_id = C_REGISTER_OBSERVER
       and crg_id = g_param.crg_id;
       
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
    
    pit.leave_optional(
      p_params => msg_params(msg_param('changed_value_items', l_changed_value_items)));
    return l_changed_value_items;
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
    
    if g_param.crg_is_active then
      if g_param.firing_event = adc_util.C_INITIALIZE_EVENT then
        -- Initialize session state with page item default values
        process_initialization_code;
      end if;
      
      -- get rule statement to evaluate the necessary actions
      select crg_decision_table
        into l_rule_stmt
        from adc_rule_groups
       where crg_id = g_param.crg_id;
      -- recursively evaluate all applicable rules and execute them
      process_rule(l_rule_stmt);
      
      -- Collect the response and clean up
      l_js_script := adc_response.get_response;
      adc_page_state.reset;
    end if;
      
    pit.leave_mandatory(
      p_params => msg_params(msg_param('JavaScript', l_js_script)));
    return l_js_script;
  end process_request;
  
  
  /**
    Procedure: push_error
      See <ADC_INTERNAL.push_error>
   */
  procedure push_error(
    p_error in apex_error.t_error,
    p_severity in binary_integer)
  as
  begin
    pit.enter_optional;
  
    adc_response.add_error(p_error, p_severity);
    g_param.has_errors := true;
    
    pit.leave_optional;
  end push_error;
  

  /**
    Procedure: read_settings
      See <ADC_INTERNAL.read_settings>
   */
  function read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2)
    return boolean
  as
    l_rule_rec adc_rules%rowtype;
    l_message message_type;
    l_dummy_result boolean;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_firing_item', p_firing_item),
                    msg_param('p_event', p_event),
                    msg_param('p_event_data', p_event_data)));
                              
    g_param.crg_id := get_crg_id;
    pit.assert_not_null(g_param.crg_id);                          
    
    if g_param.crg_is_active then
      pit.assert_not_null(p_firing_item);
      pit.assert_not_null(p_event);
           
      -- Initialize collections
      g_param.bind_event_items := char_table();
      g_param.firing_item := p_firing_item;
      g_param.initialize_mode := g_param.firing_item = adc_util.C_NO_FIRING_ITEM;
      g_param.firing_event := p_event;
      g_param.event_data := p_event_data;
      g_param.stop_flag := adc_util.C_FALSE;
      g_param.has_errors := false;
      g_param.rule_counter := 0;
      adc_recursion_stack.reset(g_param.crg_id, g_param.firing_item);    
      adc_page_state.reset;
      adc_response.initialize_response(g_param.initialize_mode, g_param.crg_id);
      
      -- Any firing item that may have a page state value needs to be checked whether it is
      -- - possible to convert it to the required data type
      -- - a mandatory field (and, in that case, contains a value)
      adc_page_state.set_value(
        p_crg_id => g_param.crg_id, 
        p_cpi_id => g_param.firing_item,
        p_value => adc_page_state.C_FROM_SESSION_STATE,
        p_throw_error => adc_util.C_TRUE);
      
      adc_page_state.dynamically_validate_value(
        p_crg_id => g_param.crg_id, 
        p_cpi_id => g_param.firing_item);
    end if;
    
                                        
    pit.leave_optional;
    return g_param.crg_is_active;
  exception
    when msg.ADC_INVALID_NUMBER_ERR or msg.ADC_INVALID_DATE_ERR then
      -- conversion could not be applied. Raise exception and stop rule
      l_message := pit.get_active_message;
      register_error(g_param.firing_item, l_message.message_name, l_message.message_args);
      stop_rule;
      pit.leave_mandatory;
      return true;
    when NO_DATA_FOUND then
      -- page is run for the first time, no ADC rule group exists for it. Create and initialize again
      create_initial_rule_group_and_rule;
      l_dummy_result := read_settings(p_firing_item, p_event, p_event_data);
      pit.leave_mandatory;
      return true;
    when msg.ADC_ITEM_IS_MANDATORY_ERR then
      -- firing item is mandatory and contains NULL
      l_message := pit.get_active_message;
      register_error(g_param.firing_item, msg.ADC_ITEM_IS_MANDATORY);
      stop_rule;
      pit.leave_mandatory;
      return true;
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
          p_crg_id => g_param.crg_id,
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
    Procedure: get_javascript_for_action
      See <ADC_API.get_javascript_for_action>
   */
  function get_javascript_for_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type)
    return varchar2
  as
    l_row rule_action_rec;
    l_java_script adc_util.max_char;
  begin
    l_row := evaluate_action_type(
      p_cat_id => p_cat_id,
      p_cpi_id => p_cpi_id,
      p_param_1 => p_param_1,
      p_param_2 => p_param_2,
      p_param_3 => p_param_3);

    if l_row.cat_js is not null then 
      l_java_script := generate_parameterized_code('JAVASCRIPT', l_row);    
    end if;
    
    return l_java_script;
  end get_javascript_for_action;
  
  
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
    l_row rule_action_rec;
    l_pl_sql adc_util.max_char;
    l_java_script adc_util.max_char;
    
    C_PLSQL_CODE_TEMPLATE constant adc_util.sql_char := 'begin #CODE#; commit; end;';
  begin
    -- Tracing done in ADC_API      
    l_row := evaluate_action_type(
      p_cat_id => p_cat_id,
      p_cpi_id => p_cpi_id,
      p_param_1 => p_param_1,
      p_param_2 => p_param_2,
      p_param_3 => p_param_3,
      p_allow_recursion => p_allow_recursion);
    
    if l_row.cat_pl_sql is not null then
      l_pl_sql := generate_parameterized_code('PLSQL', l_row);
      l_pl_sql := replace(C_PLSQL_CODE_TEMPLATE, '#CODE#', l_pl_sql);
      execute immediate l_pl_sql;
    end if;

    if l_row.cat_js is not null then 
      l_java_script := generate_parameterized_code('JAVASCRIPT', l_row);      
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
    select replace(C_JSON_COMMAND, '#COMMAND#', caa_name)
      into g_param.event_data
      from adc_apex_actions
     where caa_id = p_command;
    g_param.firing_event := 'command';
    pit.log_state(
      msg_params(
        msg_param('Command', g_param.event_data)));
    adc_recursion_stack.push_firing_item(
      p_crg_id => g_param.crg_id,
      p_cpi_id => C_COMMAND,
      p_event => 'command',
      p_event_data => g_param.event_data);
  end execute_command;
  

  /**
    Procedure: raise_item_event
      See <ADC_API.raise_item_event>
   */
  procedure raise_item_event(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    l_has_rule number;
    l_dummy adc_util.max_char;
  begin
    pit.enter_detailed('raise_item_event',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_recursion_stack.push_firing_item(g_param.crg_id, p_cpi_id, 'change');
    
    pit.leave_detailed;
  end raise_item_event;  


  /**
    Procedure: register_error
      See <ADC_API.register_error>
   */
  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_error_msg in varchar2,
    p_internal_error in varchar2,
    p_severity in binary_integer default pit.level_error)
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
    l_dummy := adc_page_state.get_string(g_param.crg_id, p_cpi_id);

    if p_error_msg is not null then
      l_error.message := p_error_msg;
      l_error.additional_info := p_internal_error;
      prepare_error(l_error, p_cpi_id);
      push_error(l_error, p_severity);
    end if;
    
    pit.leave_optional;
  end register_error;


  /**
    Procedure: register_error
      See <ADC_API.register_error>
   */
  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
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
      p_internal_error => l_message.message_description,
      p_severity => l_message.severity);    
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
    pit.assert_not_null(g_param.crg_id);
    
    case
    when p_cpi_id != adc_util.C_NO_FIRING_ITEM or (p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is null) then
      adc_page_state.register_mandatory(
        p_crg_id => g_param.crg_id,
        p_cpi_id => p_cpi_id,
        p_cpi_mandatory_message => p_cpi_mandatory_message,
        p_is_mandatory => p_is_mandatory);
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
      -- jQuery selector passed in. Read all elements affected by this selector
      l_item_list := get_items_by_selector(p_cpi_id, p_jquery_selector);
      for i in 1 .. l_item_list.count loop
        adc_page_state.register_mandatory(
          p_crg_id => g_param.crg_id,
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
                    
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
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
      adc_page_state.set_value(
        p_crg_id => g_param.crg_id,
        p_cpi_id => p_cpi_id,
        p_value => p_value,
        p_number_value => p_number_value,
        p_date_value => p_date_value,
        p_throw_error => p_allow_recursion);
      if p_allow_recursion = adc_util.C_TRUE then
        raise_item_event(p_cpi_id);
      end if;
      adc_response.add_comment(msg.ADC_SESSION_STATE_SET, msg_args(p_cpi_id, adc_page_state.get_string(g_param.crg_id, p_cpi_id)));
    end if;
      
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
    C_ADDITIONAL_ITEMS constant adc_util.max_char := 'de.condes.plugin.adc.controller.setAdditionalItems(#ITEMS#);';                                    
    l_stmt adc_util.max_char;
    l_result varchar2(4000);
    l_cur integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
    l_additional_items adc_util.max_char;
  begin
    l_stmt := replace(C_STMT, '#STMT#', p_statement);
    apex_json.initialize_clob_output;
    apex_json.open_array;   
    if p_cpi_id = adc_util.c_no_firing_item or p_cpi_id is null then
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Executing item statement'));
      -- If no element is specified, the elements are set according to the column name
      l_cur := dbms_sql.open_cursor;
      -- SQL parsen, um Spaltenbezeichner zu ermitteln
      dbms_sql.parse(l_cur, l_stmt, dbms_sql.native);
      dbms_sql.describe_columns2(l_cur, l_col_cnt, l_desc_tab);
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('... ' || l_col_cnt || ' column(s) found'));
      for i in 1 .. l_col_cnt loop
        dbms_sql.define_column(l_cur, i, l_result, 4000);
      end loop;
      
      -- Execute SQL and load the first row
      l_cnt := dbms_sql.execute_and_fetch(l_cur);
      -- Alle Spaltenwerte in Seitenelemente mit entsprechendem Spaltennamen kopieren
      for i in 1 .. l_col_cnt loop
        dbms_sql.column_value(l_cur, i, l_result);
        pit.debug(msg.PIT_PASS_MESSAGE, msg_args('... ' || l_desc_tab(i).col_name || ': ' || l_result));
        -- Copy value to session status
        set_session_state(
          p_cpi_id => l_desc_tab(i).col_name,  
          p_value => l_result, 
          p_allow_recursion => p_allow_recursion);
        apex_json.write(l_desc_tab(i).col_name);
      end loop;
      dbms_sql.close_cursor(l_cur);
    else
      -- Concrete element requested, according to convention only one column is included
      execute immediate l_stmt into l_result;
      set_session_state(
        p_cpi_id => p_cpi_id, 
        p_value => l_result, 
        p_allow_recursion => p_allow_recursion);
        apex_json.write(p_cpi_id);
    end if;
    apex_json.close_array;
    add_javascript(replace(C_ADDITIONAL_ITEMS, '#ITEMS#', apex_json.get_clob_output));
    apex_json.free_output;
  exception
    when NO_DATA_FOUND then
      apex_json.free_output;
    when others then
      adc_response.add_comment(msg.ADC_NO_DATA_FOR_ITEM, msg_args(coalesce(p_cpi_id, replace(p_statement, adc_util.C_CR))));
      set_session_state(
        p_cpi_id => p_cpi_id, 
        p_value => '');
      apex_json.free_output; 
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
    -- Parse SQL to get column identifiers
    dbms_sql.describe_columns2(l_cur, l_col_cnt, l_desc_tab);
    for i in 1 .. l_col_cnt loop
      dbms_sql.define_column(l_cur, i, l_result, 4000);
    end loop;
    
    -- Execute SQL and load the first row
    l_cnt := dbms_sql.execute_and_fetch(l_cur);
    -- Copy all column values to page elements with corresponding column name
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
       where cgs_crg_id = g_param.crg_id;

    cursor validation_action_cur is
      select cra_cat_id, cra_cpi_id, cra_param_1, cra_param_2, cra_param_3
        from adc_rule_actions
       where cra_crg_id = g_param.crg_id
         and cra_raise_on_validation = adc_util.C_TRUE;
    l_exception message_type;
    l_stmt adc_util.sql_char;
    l_result boolean;
  begin
    -- Tracing done in ADC_API
    
    -- Check all mandatory fields (elements may not have triggered a CHANGE event)
    for itm in mandatory_item_cur loop
      begin
        adc_recursion_stack.register_touched_item(itm.cgs_cpi_id);
        adc_page_state.check_mandatory(
          p_crg_id => g_param.crg_id,
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
      adc_recursion_stack.register_touched_item(sra.cra_cpi_id);
    end loop;
    
    if g_param.has_errors then
      g_param.stop_flag := adc_util.C_TRUE;
    end if;
  end validate_page;
  
begin
  initialize;
end adc_internal;
/