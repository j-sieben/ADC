create or replace package body adc_response
as

  /**
    Package: ADC_RESPONSE Body
      Implementation of the response related logic for ADC
    
    Author::
      Juergen Sieben, ConDeS GmbH
  */

  
  /**
    Group: Private package constants
   */
  /**
    Constants: JavaScript constants
      C_JS_NAMESPACE - Namespace of the core JavaScript functionality
      C_JS_COMMENT_STRING - Comment string to comment unneeded or double JavaScript snippets
   */    
  C_JS_NAMESPACE constant adc_util.ora_name_type := 'de.condes.plugin.adc.actions';
  C_JS_PLACEHOLDER constant adc_util.ora_name_type := 'ADC_PLUGIN';
  C_JS_SHORTCUT constant adc_util.ora_name_type := 'a';
  C_APEX_ACTION_NAMESPACE constant adc_util.ora_name_type := 'apex.actions';
  C_APEX_ACTION_PLACEHOLDER constant adc_util.ora_name_type := 'APEX_ACTION';
  C_APEX_ACTION_SHORTCUT constant adc_util.ora_name_type := 'aa';
  C_JS_COMMENT_STRING constant adc_util.sql_char := '// ';
  C_COMMENT_OUT constant varchar2(20) := C_JS_COMMENT_STRING || '(double)';
  C_ERR_LOCATION_PAGE constant adc_util.ora_name_type := '"page"';
  C_ERR_LOCATION_INLINE constant adc_util.ora_name_type := '"inline"';
  C_ERR_LOCATION_BOTH constant adc_util.ora_name_type := '["inline","page"]';
  
  /**
    Group: Private package types
   */
  /**
    Type: javascript_rec
      JavaScript snippet with hash and debug level as entry for <javascript_list>.
      
    Properties:
      script - Java Script snippet
      javascript_hash - Hashcode over <script> to remove duplicate entries
      debug_level - Level indicating the importance of the <script> entry.
                  Is used to distinguish between "real" code and comments of
                  different importance. Allows to reduce the output size.
   */
  type javascript_rec is record(
    script adc_util.max_char,
    javascript_hash raw(2000),
    debug_level binary_integer);  
  
  /**
    Type: javascript_list
      Stack of <javascript_rec> containing all collected JavaScript snippets for the response.
   */
  type javascript_list is table of javascript_rec index by binary_integer;    
  
  
  /**
    Type: level_length_t
      Table to store the length of the JavaScript entries per level.
      
      Is used to calculate the overall answer length and exclude snippets of lower
      importance if the answer would be too large otherwise.
   */
  type level_length_t is table of binary_integer index by binary_integer;
  
  
  /**
    Type: error_stack_t
      Stack to store error messages
   */
  type error_stack_t is table of adc_util.max_char index by binary_integer;
  
  
  /** 
    Type: param_rec
      Record for response attributes.
      
    Properties:
      js_action_stack - JavaScript action stack, rule outcome of the rules executed so far
      error_stack - List errors that occurred ATTENTION: Don't refactor to CHAR_TABLE, the key is a hash to remove double entries
      level_length - cumulated length of the strings on the respective severity levels
      cru_name - Cached name of the actually evaluated rule
      request_start - Timing information of the overall start time of the evaluation
      rule_start - Timing information of the recursive rule evaluation start time
   */
  type param_rec is record(
    js_action_stack javascript_list,
    error_stack error_stack_t,
    level_length level_length_t,
    crg_id adc_rule_groups.crg_id%type,
    cru_name adc_rules.cru_name%type,
    request_start binary_integer,
    rule_start binary_integer);
  
  g_param param_rec;
  
  
  /**
    Group: Private methods
   */
  /**
    Function: test_condition
      Wrapper around a boolean expression to enhance documentation and tracing capabilities
      
    Parameters:
      p_test - boolean expression to evaluate
      p_meaning - short description of the fact that is tested
      
    Returns:
      Boolean value of p_test
   */
  function test_condition(
    p_test in boolean,
    p_meaning in varchar2)
    return boolean
  as
    l_result boolean;
  begin
    l_result := p_test;
    
    if not l_result then
      apex_debug.warn('Condition failed: ' || p_meaning);
    end if;
    
    return l_result;
  end test_condition;
  
  
  /** 
    Function: get_max_level
      Method to calculate up to which level the response fits into 32KByte
      
      The responding JavaScript should not exceed <ADC_UTIL.C_MAX_LENGTH> Byte. The response
      may still fit into this limit if more and more comments are left out.
      Comments are organized in levels. This method evaluates, up to which level
      comments may be integrated without breaking the limit.
      
      Maximum level is also dependent on the PIT settings actually valid. It can not exceed
      the actual log level of PIT.
      
    Returns:
      Maximum level up to which the response remains under <ADC_UTIL.C_MAX_LENGTH> or the log level
      PIT allows, whatever is less.
   */
  function get_max_level
    return binary_integer
  as
    l_length binary_integer := 1;
    l_level binary_integer;
  begin
    pit.enter_detailed('get_max_level');
    
    l_level := pit.get_log_level;
    
    for i in 1 .. g_param.level_length.count loop
      if g_param.level_length.exists(l_level) then
        l_length := l_length + g_param.level_length(l_level);
        if l_length > adc_util.C_MAX_LENGTH then
          add_comment(pit.get_message_text(msg.ADC_OUTPUT_REDUCED, msg_args(to_char(l_level))));
          exit;
        end if;
      end if;
    end loop;
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('Level', l_level)));
    return l_level;
  end get_max_level;
  
  
  /**
    Function: get_java_script
      Method collects all JavaScript chunks for the response
      
    Returns:
      Script containing all JavaScript chunks for the page
   */
  function get_java_script
    return varchar2
  as
    l_java_script adc_util.max_char;
    l_max_level binary_integer;
    l_result boolean;
  begin
    pit.enter_optional('get_java_script');
    pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Funktionstest'));
    
    if g_param.js_action_stack.count > 0 then
      l_max_level := get_max_level;
      
      -- collect all javascript chunks
      for i in 1 .. g_param.js_action_stack.count loop
        if test_condition(g_param.js_action_stack.exists(i), 'Entry ' || i || ' does not exist')
          and test_condition(coalesce(g_param.js_action_stack(i).debug_level, adc_util.C_JS_CODE) <= l_max_level, 'Level not allowed')
          and test_condition(not(g_param.js_action_stack(i).debug_level = adc_util.C_JS_DEBUG), 'Level is debug')
          --and test_condition(not pit.check_log_level_greater_equal(pit.LEVEL_DEBUG), 'Log settings are higher than message')
          and test_condition(coalesce(length(l_java_script) + length(g_param.js_action_stack(i).script), 0) < adc_util.C_MAX_LENGTH, 'Max length exceeded')
          and test_condition(length(replace(replace(g_param.js_action_stack(i).script, ' '), adc_util.C_CR)) > 0, 'no entry detected')
        then
          utl_text.append(l_java_script, replace(g_param.js_action_stack(i).script, adc_util.C_CR) || adc_util.C_CR);
        end if;
      end loop;
    end if;
    
    pit.leave_optional(
      p_params => msg_params(msg_param('JavaScript', l_java_script)));
    return l_java_script;
  end get_java_script;
  
   
  /** 
    Function: get_errors_as_json
      Method calculates all errors registered during rule evaluation and collects them as JSON.
      Creates a JSON instance according to the APEX requirements with the following structure:
      
      --- JavaScript
      {"type":"error","item":"#PAGE_ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}
      ---
      
    Returns:
      JSON instance for all page items referenced by the rule executed.
   */
  function get_errors_as_json(
    p_max_length in binary_integer)
    return varchar2
  as
    l_json adc_util.max_char;
    l_error_key binary_integer;
    l_error_count binary_integer;
    l_has_space boolean := true;
    l_json_error_template adc_util.sql_char;
  begin
    pit.enter_optional('get_errors_as_json',
      p_params => msg_params(
                    msg_param('p_max_length', p_max_length)));
    
    -- Initialization
    l_error_count := g_param.error_stack.count;    
    l_json_error_template := utl_text.get_text_template(
                               p_type => adc_util.C_PARAM_GROUP,
                               p_name => 'JSON_ERRORS',
                               p_mode => 'FRAME');
                               
    l_error_key := g_param.error_stack.first;
    while l_error_key is not null loop
      l_has_space := coalesce(length(l_json), 0) + length(g_param.error_stack(l_error_key)) < coalesce(p_max_length, 30000);
      utl_text.append(l_json, g_param.error_stack(l_error_key), adc_util.C_DELIMITER, true);
      l_error_key := g_param.error_stack.next(l_error_key);
    end loop;
  
    l_json := replace(replace(l_json_error_template, 
                '#ERROR_COUNT#', l_error_count),
                '#JSON_ERRORS#', l_json);
        
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_errors_as_json;
  
  
  /** 
    Procedure: reset
      Helper method to reset the internal memory structures
   */
  procedure reset
  as
  begin
    pit.enter_detailed('reset');
    
    g_param.error_stack.delete;
    g_param.js_action_stack.delete;
    g_param.level_length(adc_util.C_JS_CODE) := 0;
    g_param.level_length(adc_util.C_JS_RULE_ORIGIN) := 0;
    g_param.level_length(adc_util.C_JS_DEBUG) := 0;
    g_param.level_length(adc_util.C_JS_COMMENT) := 0;
    g_param.level_length(adc_util.C_JS_DETAIL) := 0;
    g_param.level_length(adc_util.C_JS_VERBOSE) := 0;
    g_param.crg_id := null;
    
    pit.leave_detailed;
  end reset;
  

  /**
    Group: Public methods
   */
  /**
    Procedure: add_javascript
      See <adc_response.add_javascript>
   */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default adc_util.C_JS_CODE)
  as
    l_next_entry binary_integer;
    l_response javascript_rec;
  begin
    pit.enter_optional('add_javascript',
      p_params => msg_params(
                    msg_param('p_java_script', p_java_script),
                    msg_param('p_debug_level', p_debug_level)));
                    
    if p_java_script is not null then
      pit.assert(p_debug_level in (adc_util.C_JS_CODE, adc_util.C_JS_RULE_ORIGIN, adc_util.C_JS_DEBUG, adc_util.C_JS_COMMENT, adc_util.C_JS_DETAIL), msg.ADC_INVALID_DEBUG_LEVEL);
      
      l_next_entry := g_param.js_action_stack.count + 1;
        
      select p_java_script, standard_hash(p_java_script), p_debug_level
        into l_response
        from dual;
      
      l_response.script := adc_util.bulk_replace(p_java_script, adc_util.string_table(
                             '#JS_FILE#', C_JS_SHORTCUT,
                             C_JS_NAMESPACE, C_JS_SHORTCUT,
                             C_APEX_ACTION_NAMESPACE, C_APEX_ACTION_SHORTCUT,
                             C_JS_PLACEHOLDER, C_JS_NAMESPACE,
                             C_APEX_ACTION_PLACEHOLDER, C_APEX_ACTION_NAMESPACE)); 
        
      if p_debug_level not in (adc_util.C_JS_CODE, adc_util.C_JS_RULE_ORIGIN) then
        l_response.script := C_JS_COMMENT_STRING || ltrim(l_response.script, C_JS_COMMENT_STRING);
      end if;
        
      -- comment out double JavaScript entries
      for i in 1 .. g_param.js_action_stack.count loop
        if g_param.js_action_stack.exists(i) then
          if g_param.js_action_stack(i).debug_level = adc_util.C_JS_CODE and g_param.js_action_stack(i).javascript_hash = l_response.javascript_hash then
            g_param.js_action_stack(i).script := C_COMMENT_OUT || g_param.js_action_stack(i).script;
            g_param.js_action_stack(i).javascript_hash := null;
            g_param.js_action_stack(i).debug_level := adc_util.C_JS_DETAIL;
          end if;
        end if;
      end loop;
      
      -- persist JavaScript action
      g_param.js_action_stack(l_next_entry) := l_response;
      
      -- Calculate length of comments and scripts
      g_param.level_length(l_response.debug_level) := g_param.level_length(l_response.debug_level) + length(l_response.script);
    end if;
  
    pit.leave_optional(
      p_params => msg_params(msg_param('Script added', l_response.script)));
  end add_javascript;
  
  
  /** 
    Procedure: add_additional_items
      See <adc_response.add_additional_items>
   */
  procedure add_additional_items(
    p_items in varchar2)
  as  
    C_ADDITIONAL_ITEMS constant adc_util.max_char := '#JS_FILE#.registerPageItemsOnce(#ITEMS#);';
    l_items adc_util.max_char;
  begin
    pit.enter_optional;
    l_items := replace(replace(p_items, ' '), chr(10));
    add_javascript(replace(C_ADDITIONAL_ITEMS, '#ITEMS#', l_items));
    pit.leave_optional;
  end add_additional_items;
  
  
  /** 
    Procedure: add_comment
      See <adc_response.add_comment>
   */
  procedure add_comment(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
    l_message message_type;
  begin
    pit.enter_optional('add_comment',
      p_params => msg_params(
                    msg_param('p_message_name', p_message_name)));
                    
    l_message := pit.get_message(p_message_name, p_msg_args);
    if pit.check_log_level_greater_equal(l_message.severity) then
      add_javascript(C_JS_COMMENT_STRING || l_message.message_text, l_message.severity);
    end if;
    
    pit.leave_optional;
  end add_comment;
  
  
  /**
    Procedure: add_error
      See <adc_response.add_error>
   */
  procedure add_error(
    p_error in apex_error.t_error,
    p_severity in binary_integer default pit.level_error)
  as
    C_MAX_INTEGER constant number := 2147483647; -- Used to limit Hashfunktions to the max of BINARY_INTEGER
    l_error apex_error.t_error;
    l_error_json adc_util.max_char;
    l_error_hash binary_integer;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_error', p_error.message)));
  
    l_error := p_error;
    begin
      -- prepare message texts
      if l_error.message like ' Zeile 1%' then
        l_error.message := pit.get_trans_item_name(adc_util.C_PARAM_GROUP, 'FAULTY_ERROR_MESSAGE');
      end if;
      l_error.additional_info := apex_escape.js_literal(l_error.additional_info);
      l_error.message := apex_escape.js_literal(l_error.message);
    exception
      when others then
        l_error.message := pit.get_trans_item_name(adc_util.C_PARAM_GROUP, 'INVALID_ERROR_MESSAGE');
    end;
    l_error.display_location := case when l_error.page_item_name = adc_util.C_NO_FIRING_ITEM 
                                  then C_ERR_LOCATION_PAGE
                                  else C_ERR_LOCATION_INLINE end;
    
    select ora_hash(l_error.message || l_error.page_item_name, C_MAX_INTEGER)
      into l_error_hash
      from dual;
      
    if not g_param.error_stack.exists(l_error_hash) then
      l_error_json := utl_text.get_text_template(adc_util.C_PARAM_GROUP, 'JSON_ERRORS', 'ERROR');
      l_error_json := adc_util.bulk_replace(l_error_json, adc_util.string_table(
                        '#ERROR_TYPE#', case p_severity when pit.level_warn then 'warning' else 'error' end,
                        '#PAGE_ITEM#', l_error.page_item_name,
                        '#MESSAGE#', l_error.message,
                        '#ADDITIONAL_INFO#', l_error.additional_info,
                        '#LOCATION#', l_error.display_location));
        
      g_param.error_stack(l_error_hash) := l_error_json;
    end if;
    
    pit.leave_mandatory;
  end add_error;
  
  
  /**
    Function: get_response
      See <adc_response.get_response>
   */
  function get_response
    return clob
  as
    l_response clob;
    l_remaining_length binary_integer := 30000;
    l_js_script_frame_template adc_util.sql_char;
    l_changed_items adc_util.max_char;
    l_firing_items adc_util.max_char;
  begin
    pit.enter_optional('get_response');
  
    l_js_script_frame_template := utl_text.get_text_template(
                                      p_type => adc_util.C_PARAM_GROUP,
                                      p_name => 'JS_SCRIPT_FRAME',
                                      p_mode => 'FRAME');
       
    -- wrap JavaScript in <script> tag and add item value and error scripts
    l_response := adc_util.bulk_replace(l_js_script_frame_template, adc_util.string_table(
                    '#SCRIPT#', get_java_script,
                    '#JS_FILE#', C_JS_SHORTCUT,
                    '#JS_SHORTCUT#', C_JS_SHORTCUT,
                    '#JS_NAMESPACE#', C_JS_NAMESPACE,
                    '#AA_SHORTCUT#', C_APEX_ACTION_SHORTCUT,
                    '#AA_NAMESPACE#', C_APEX_ACTION_NAMESPACE,
                    '#ID#', 'S_' || trunc(dbms_random.value(1, 100000)),
                    '#CR#', adc_util.C_CR,
                    '#DURATION#', to_char(dbms_utility.get_time - g_param.request_start)));
    
    -- Prepare remaining chunks and check overall length
    l_remaining_length := l_remaining_length - coalesce(length(l_response), 0);
    l_changed_items := adc_page_state.get_changed_items_as_json;
    l_remaining_length := l_remaining_length - coalesce(length(l_changed_items), 0);
    l_firing_items := adc_recursion_stack.get_firing_items_as_json;
    l_remaining_length := l_remaining_length - coalesce(length(l_response), 0);
    
    l_response := adc_util.bulk_replace(l_response, adc_util.string_table(
                    '#ERROR_JSON#', get_errors_as_json(l_remaining_length),
                    '#ITEM_JSON#', l_changed_items,
                    '#FIRING_ITEMS#', l_firing_items));
    
    reset;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('JavaScript', l_response)));
    return l_response;
  end get_response;
  
  
  /**
    Procedure: initialize_response
      See <adc_respnse.initialize_response>
   */
  procedure initialize_response(
    p_initialize_mode in boolean,
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_initialize_mode', adc_util.bool_to_flag(p_initialize_mode)),
                    msg_param('p_crg_id', p_crg_id)));
    
    reset;
    
    g_param.crg_id := p_crg_id;
    g_param.request_start := dbms_utility.get_time;
    
    if p_initialize_mode then
      add_javascript(adc_apex_action.get_crg_apex_actions(g_param.crg_id));
    end if;
    
    pit.leave_optional;
  end initialize_response;
  
  
  /**
    Procedure: register_recursion_end
      See <adc_response.register_recursion_end>
   */
  procedure register_recursion_end(
    p_rule_found in boolean)
  as
    l_javascript_exists boolean default false;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_rule_found', adc_util.bool_to_flag(p_rule_found))));
  
    -- Add time measurement and collected notification messages to origin comments
    for i in reverse 1 .. g_param.js_action_stack.count loop
      case when g_param.js_action_stack(i).debug_level = adc_util.C_JS_RULE_ORIGIN then
        g_param.js_action_stack(i).script := '#CR#' 
                                          || replace(g_param.js_action_stack(i).script, '#TIME#', coalesce(dbms_utility.get_time - g_param.rule_start, 0));
        exit;
      when g_param.js_action_stack(i).debug_level = adc_util.C_JS_CODE then
        l_javascript_exists := true;
      else
        null;
      end case;
    end loop;
    
    case 
      when not p_rule_found then
        -- No rule found, notify if set to verbose
        add_comment(msg.ADC_NO_RULE_FOUND);
      when not l_javascript_exists then
        -- No JavaScript found, notify if set to verbose
        add_comment(msg.ADC_NO_JAVASCRIPT, msg_args(g_param.cru_name));
      else
        null;
    end case;
    
    pit.leave_optional;  
  end register_recursion_end;
  
  
  /**
    Procedure: register_recursion_start
      See <adc_response.register_recursion_start>
   */
  procedure register_recursion_start(
    p_origin_message in adc_util.ora_name_type,
    p_recursive_depth in binary_integer,
    p_run_count in binary_integer,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
    p_cru_name in adc_rules.cru_name%type,
    p_firing_item in adc_util.ora_name_type)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_origin_message', p_origin_message),
                    msg_param('p_run_count', p_run_count),
                    msg_param('p_cru_sort_seq', p_cru_sort_seq),
                    msg_param('p_cru_name', p_cru_name),
                    msg_param('p_firing_item', p_firing_item)));
    
    g_param.rule_start := dbms_utility.get_time;
    g_param.cru_name := p_cru_name;
    
    add_comment(
       p_message_name => p_origin_message, 
       p_msg_args => msg_args(
                       to_char(adc_recursion_stack.get_level),
                       to_char(p_run_count),
                       to_char(p_cru_sort_seq), 
                       convert(p_cru_name, 'AL32UTF8'), 
                       p_firing_item,
                       adc.get_string(p_firing_item)));
                       
    pit.leave_optional;
  end register_recursion_start;

end adc_response;
/