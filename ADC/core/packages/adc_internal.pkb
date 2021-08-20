create or replace package body adc_internal 
as

  /** Private constants*/
  C_PARAM_GROUP constant adc_util.ora_name_type := 'ADC';
  C_MAX_LENGTH binary_integer := 32000;
  C_MODE_FRAME constant adc_util.ora_name_type := 'FRAME';
  
  C_DELIMITER constant varchar2(1 byte) := ',';
  C_EVENT_INITIALIZE constant adc_util.ora_name_type := 'initialize';
  
  C_JS_NAMESPACE constant adc_util.ora_name_type := 'de.condes.plugin.adc';
  C_JS_SCRIPT_FRAME constant adc_util.sql_char := q'^<script id="#ID#">#CR#  /** Init: #DURATION#hsec*/#CR#  #JS_FILE#.setItemValues(#ITEM_JSON#);#CR#  #JS_FILE#.setErrors(#ERROR_JSON#);#CR##SCRIPT##CR#</script>^';
  C_JS_COMMENT_STRING constant adc_util.sql_char := '// ';

  /** Private types */
  type error_stack_t is table of adc_util.max_char index by binary_integer;
  
  -- JavaScript stack
  type js_rec is record(
    script adc_util.max_char,
    javascript_hash raw(2000),
    debug_level binary_integer);
    
  type js_list is table of js_rec index by binary_integer;
  
  type level_length_t is table of binary_integer index by binary_integer;
  
  /** Record for recording the plugin attributes
   */
  type param_rec is record(
    cgr_id adc_rule_groups.cgr_id%type,               -- actual CGR_ID
    firing_item adc_page_items.cpi_id%type,           -- actual firing item (or adc_util.C_NO_FIRING_ITEM)
    firing_event adc_page_item_types.cit_event%type,  -- actual firing event (normally change or click, but can be any event)
    initialize_mode boolean,                          -- Flag to indicate whether automatic mandatory checks should be paused
    event_data adc_util.max_char,                     -- optional event data that is returned from modal dialog pages etc.
    bind_event_items char_table,                      -- List of items for which ADC binds event handlers
    error_stack error_stack_t,                        -- List errors that occurred ATTENTION: Don't refactor to CHAR_TABLE, the key is a hash to remove double entries
    js_action_stack js_list,                          -- JavaScript action stack, rule outcome of the rules executed so far
    level_length level_length_t,                      -- cumulated length of the strings on the respective severity levels
    notification_stack adc_util.max_char,             -- List of notifications to be shown in the browser console
    stop_flag adc_util.flag_type,                     -- Flag to indicate that all rule execution has to be stopped
    now binary_integer,                               -- timestamp, used to calculate the execution duration
    collection_name adc_util.ora_name_type            -- Collection used to maintain a list of mandatory items
  );
  
  
  /** Record for recording data of the actually executed rule and rule action
   */
  type rule_action_rec is record(
    cru_id adc_rules.cru_id%type,
    cru_sort_seq adc_rules.cru_sort_seq%type,
    cru_name adc_rules.cru_name%type,
    cru_firing_items adc_rules.cru_firing_items%type,
    cru_fire_on_page_load adc_rules.cru_fire_on_page_load%type,
    item adc_page_items.cpi_id%type,
    pl_sql adc_action_types.cat_pl_sql%type,
    js adc_action_types.cat_js%type,
    cra_sort_seq adc_rule_actions.cra_sort_seq%type,
    cra_param_1 adc_rule_actions.cra_param_1%type,
    cra_param_2 adc_rule_actions.cra_param_2%type,
    cra_param_3 adc_rule_actions.cra_param_3%type,
    cra_on_error adc_rule_actions.cra_on_error%type,
    cru_on_error adc_rule_actions.cra_on_error%type,
    is_first_row adc_util.flag_type
  );

  /** Privat global variables */
  g_has_errors boolean;
  g_param param_rec;
  g_json_error_template adc_util.sql_char;
    
    
  /*============ HELPER ============*/ 
  /** Adds a comment to the JavaScript answer if applicable
   * %param  p_message_name  Name of the Message
   * %param [p_msg_args]     Argument object
   * %usage  Is used to append comments about the inner workings to the JavaScript answer.
   *         Whether a message is added is dependent on the severity of the message and
   *         the debug level
   */
  procedure add_javascript_comment(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
    l_message message_type;
  begin
    -- Tracing done in ADC_API
    l_message := pit.get_message(p_message_name, p_msg_args);
    if pit.check_log_level_greater_equal(l_message.severity) then
      add_javascript(C_JS_COMMENT_STRING || l_message.message_text, l_message.severity);
    end if;
  end add_javascript_comment;
  
  
  /** Method returns all apex actions defined for the rule group as a JavaScript install script
   * %param  p_js  JavaScript code to add APEX actions to the JavaScript answer
   * @usage  Is used to register apex actions defined for the rule group on the page. Called during initialization.
   */
  procedure append_apex_actions(
    p_js in out nocopy adc_util.max_char)
  as
    l_actions_js adc_util.max_char;
    l_has_actions binary_integer;
    -- Default is to inform ADC about invoking an APEX action on the page
    C_DEFAULT_ACTION constant adc_apex_actions.caa_action%type := q'^function(){de.condes.plugin.adc.executeCommand('#CAA_NAME#');}^';
  begin
    pit.enter_detailed('get_apex_actions');
    
    -- excute only on initialization
    pit.assert(g_param.firing_event = C_EVENT_INITIALIZE);
    
    -- check whether APEX actions exist
    select count(*)
      into l_has_actions
      from adc_apex_action_items
     where cai_cpi_cgr_id = g_param.cgr_id
       and rownum = 1;
    pit.assert(l_has_actions > 0);
                
    -- Generate initalization JavaScript for APEX actions based on UTL_TEXT templates of name APEX_ACTION
    with templates as (
           select uttm_name, uttm_mode, uttm_text, g_param.cgr_id cgr_id
             from utl_text_templates
            where uttm_type = C_PARAM_GROUP
              and uttm_name = 'APEX_ACTION')
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    adc_util.C_CR cr,
                    pit.get_message_text(msg.ADC_APEX_ACTION_ORIGIN) apex_action_origin,
                    utl_text.generate_text(cursor(
                      select uttm_text template,
                             cpi_id, caa_name
                        from adc_apex_action_items
                        join adc_apex_actions
                          on cai_caa_id = caa_id
                        join adc_page_items
                          on cai_cpi_cgr_id = cpi_cgr_id
                         and cai_cpi_id = cpi_id
                        join adc_page_item_types
                          on cpi_cit_id = cit_id
                        join templates
                          on cit_id = uttm_mode
                         and cai_cpi_cgr_id = cgr_id),
                      p_delimiter => chr(10)
                    ) bind_action_items,
                    utl_text.generate_text(cursor(
                      select uttm_text template, chr(10) || '    ' cr,
                             caa_cgr_id, caa_cty_id, caa_name, 
                             apex_escape.json(caa_label) caa_label,
                             apex_escape.json(caa_label) caa_label_key, 
                             apex_escape.json(caa_context_label) caa_context_label, 
                             caa_icon, caa_icon_type,
                             apex_escape.json(coalesce(caa_title, caa_label)) caa_title,
                             apex_escape.json(coalesce(caa_title, caa_label)) caa_title_key,
                             caa_shortcut,
                             case caa_initially_disabled when adc_util.c_true then 'true' else 'false' end caa_initially_disabled,
                             case caa_initially_hidden when adc_util.c_true then 'true' else 'false' end caa_initially_hidden,
                             caa_href,
                             coalesce(caa_action, C_DEFAULT_ACTION) caa_action
                        from adc_apex_actions_v saa
                        join adc_rule_groups cgr
                          on saa.caa_cgr_id = cgr.cgr_id
                        join templates t
                          on t.cgr_id = cgr.cgr_id
                         and uttm_mode = caa_cty_id),
                      p_delimiter => C_DELIMITER || chr(10) || '   '
                    ) action_list
               from templates
              where uttm_mode = C_MODE_FRAME)
           ) resultat
      into p_js
      from dual;

    pit.leave_detailed(msg_params(msg_param('APEX_ACTIONS', p_js)));
  exception
    when msg.ASSERT_TRUE_ERR then
      -- not during initialization or no apex actions, ignore.
      null;
  end append_apex_actions;
  
   
  /** Method calculates all errors registered during rule evaluation and collects them as JSON
   * @return JSON instance for all page items referenced by the rule executed.
   * @usage  Is used to convert the list of error to a JSON structure with the following structure:
   *          {"type":"error","item":"#PAGE_ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}
   */
  function get_errors_as_json
    return varchar2
  as
    l_json adc_util.max_char;
    l_error_key binary_integer;
    l_error_count binary_integer;
  begin
    pit.enter_optional('get_errors_as_json');
    
    -- Initialization
    l_error_count := g_param.error_stack.count;
    if l_error_count > 0 then
      l_error_key := g_param.error_stack.first;

      while l_error_key is not null loop
        utl_text.append(l_json, g_param.error_stack(l_error_key), C_DELIMITER, true);
        l_error_key := g_param.error_stack.next(l_error_key);
      end loop;
    end if;
    
    l_json := replace(replace(g_json_error_template, 
                '#ERROR_COUNT#', l_error_count),
                '#JSON_ERRORS#', l_json);
                
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_errors_as_json;
  

  /** Method to retrieve a list of elements identified by the jQuery classes passed in
   * @param  p_cpi_id    Item ID or DOCUMENT.
   * @param  p_selector  jQuery expression that gets evaluated if P_CPI_ID is DOCUMENT
   * @return CHAR_TABLE instance with all item namens that match the jQuery expression
   * @usage  Analyses the jQuery expression and returns all items that match.
   *         Possible expressions:
   *         - comma separated list of CSS classes, including .-sign
   *           Identifies page items with matching CSS elements
   *         - comma separated list of ID selectors, including #-sign
   *           Identified page items with either matching name or static id
   */
  function get_items_with_selector(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_selector in adc_rule_actions.cra_param_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    pit.enter_optional('get_items_with_selector');
    
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM and (trim(p_selector) like '.%' or trim(p_selector) like '#%') 
    then
      -- attribute contains jQuery CSS- or ID-selector, search page items with corresponding CSS or ID
      with params as(
             select g_param.cgr_id P_cgr_id,
                    '|' || replace(column_value, '.') || '|' p_css,
                    replace(column_value, '#') p_cpi_id
               from table(utl_text.string_to_table(p_selector, C_DELIMITER)))
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
  end get_items_with_selector;
  
  
  /** Helper method to retrieve a list of session state values from a comma delimited item list
   * @param  p_cpi_list    comma-separated list of page item names for which the session state values have to be returned
   * @param  p_value_list  CHAR_TABLE instance with the session state values of the page items passed in via P_CPI_LIST
   * @usage  This method is used as a helper to get the session state values of a comma separated list of page item names.
   *         It is called by EXCLUSIVE_OR and NOT_NULL to check whether the respective rules are obeyed.
   */
  procedure get_item_values_as_char_table(
    p_cpi_list in varchar2,
    p_value_list out nocopy char_table)
  as
    l_filter adc_util.max_char;
    C_TMPLT constant varchar2(1000) := q'^begin :x := char_table('#FILTER#'); end;^';
    l_filter_list char_table;
  begin
    pit.enter_optional('get_item_values_as_char_table',
      p_params => msg_params(msg_param('p_cpi_list', p_cpi_list)));
    
    -- convert comma separated list to CHAR_TABLE instance
    l_filter := replace(replace(p_cpi_list, ' '), C_DELIMITER, ''',''');
    execute immediate replace(C_TMPLT, '#FILTER#', l_filter) using out l_filter_list;
    
    -- Get the session state values as CHAR_TABLE
    select cast(
             multiset(
               select v(cpi_id)
                 from adc_page_items spi
                 join table(l_filter_list) t
                   on t.column_value = cpi_id
                   or instr(cpi_css, '|' || replace(t.column_value, '.') || '|') > 0
                where cpi_cgr_id = g_param.cgr_id
             ) as char_table
           ) cpi_value
      into p_value_list
      from dual;
      
    pit.leave_optional;
  end get_item_values_as_char_table;
  
  
  /** Method to calculate up to which level the response fits into 32KByte
   * @return Max level
   * @usage  The responding JavaScript should not exceed C_MAX_LENGTH Byte. The response
   *         may still fit into this limit if more and more comments are left out.
   *         Comments are organized in levels. This method evaluates, up to which level
   *         comments may be integrated without braking the limit
   */
  procedure check_max_level(
    p_js in out nocopy adc_util.max_char,
    p_level out nocopy binary_integer)
  as
    l_length binary_integer := 1;
  begin
    pit.enter_detailed('check_max_level');
    
    for i in 1 .. g_param.level_length.count loop
      -- map indexer to PIT severity levels
      p_level := (i * 10) + 10;
      
      if g_param.level_length.exists(p_level) then
        l_length := l_length + g_param.level_length(p_level);
        if l_length > C_MAX_LENGTH then
          utl_text.append(p_js, pit.get_message_text(msg.ADC_OUTPUT_REDUCED, msg_args(to_char(p_level))));
          exit;
        end if;
      end if;
    end loop;
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('Level', p_level)));
  end check_max_level;
  
  
  /** Returns a default mandatory message for a page item
   * @param  p_cpi_id  ID of the mandatory page item
   * @return Error message for missing value
   * @usage  If a mandatory item is NULL, a message has to be generated which may have been excplicitly given or not.
   *         This method creates this message and returns a standard message if no explicit message is available.
   */
  function get_mandatory_message(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_mandatory_message adc_rule_group_status.srs_cpi_mandatory_message%type;
  begin
    pit.enter_optional('get_mandatory_message',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));       
       
    select coalesce(srs_cpi_mandatory_message, to_char(pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY, msg_args(srs_cpi_label))))
      into l_mandatory_message
      from adc_rule_group_status
     where collection_name = g_param.collection_name
       and srs_cpi_id = p_cpi_id;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Msg', l_mandatory_message)));
    return l_mandatory_message;
  exception
    when NO_DATA_FOUND then
      -- Not an available item, ignore
      pit.leave_optional;
      return null;
  end get_mandatory_message;
  

  /** Helper to analyze a rule action parameter
   * @param  p_cpi_id         Name of the referenced item or adc_util.C_NO_FIRING_ITEM
   * @param  p_selector       Selector to replace the parameter value with
   * @param  p_code_template  Code template to insert a calculated parameter value into
   * @param  p_param          Attribute value to analyze
   * @return result of the analysis, either static or dynamic 
   * @usage  Used to evaluate a rule action parameter. The following syntactical possibilities exist:
   *         - jQuery CSS selector
   *         - jQuery ID selector
   *         - static string, encapsulated in single quotes
   *         - PL/SQL-Block without single quotes, with or without terminating semicolon
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
  

  /** Helper to analyze an attribute
   * @param  p_cpi_id  Name of the referenced item or adc_uit.C_NO_FIRING_ITEM
   * @param  p_param   Attribute value to analyze
   * @return Result of the analysis, either static or dynamic 
   * @usage  Used to evaluate a parameter value. If it is one of the predefined
   *         special attribute values, the respective replacement value is calculated.
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
      when p_param = C_PARAM_ITEM_VALUE then
        l_result := adc_page_state.get_string(g_param.cgr_id, p_cpi_id);
      when p_param is null then
        l_result := null;
      else
        l_result := p_param;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  end analyze_parameter_value;


  /** Method to determine whether rule execution has to be checked for recursive allowance. 
   * This is not checked during initialization for rules that are set to FIRE_ON_PAGE_LOAD.
   * @param  p_action_rec  rule_action_rec instance of the actually selected rule
   * @return Flag to indicate whether a recursion has to be checked or not
   * @usage  Normally, any rule is checked whether it is allowed to be executed recursively. A rule that is set to 
   *         FIRE_ON_PAGE_LOAD is an exception in this regard if the page is in initialization process.
   *         Whether this is true for the actual rule is checked within this method.
   */
  function check_recursion(
    p_action_rec in rule_action_rec)
    return adc_util.flag_type
  as
    sResult adc_util.flag_type;
  begin
    pit.enter_detailed('check_recursion',
      p_params => msg_params(
                    msg_param('p_action_rec.item', p_action_rec.item),
                    msg_param('p_action_rec.cru_fire_on_page_load', to_char(p_action_rec.cru_fire_on_page_load))));
    
    case when p_action_rec.item = adc_util.C_NO_FIRING_ITEM and p_action_rec.cru_fire_on_page_load = adc_util.C_TRUE
      then sResult := adc_util.C_FALSE;
      else sResult := adc_util.C_TRUE;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Result', to_char(sResult))));
    return sResult;
  end check_recursion;
  
  
  /** Helper method to add a comment to the JavaScript stack to indicate the rule details the script originates from
   * and other useful information such as the recursive depth and so forth.
   * @param  p_action_rec  Rule record of the active rule
   */
  procedure add_javascript_comment(
    p_action_rec in rule_action_rec)
  as
    l_origin_msg varchar2(1000);
  begin
    pit.enter_optional('add_javascript_comment');
    
    if p_action_rec.is_first_row = adc_util.C_TRUE then
      -- first line, add origin message
      case 
      when g_has_errors then
        l_origin_msg := msg.ADC_ERROR_HANDLING;
      when p_action_rec.cru_fire_on_page_load = adc_util.C_TRUE then
        l_origin_msg := msg.ADC_INIT_ORIGIN;
      else
        l_origin_msg := msg.ADC_RULE_ORIGIN;
      end case;
      
      add_javascript_comment(
         p_message_name => l_origin_msg, 
         p_msg_args => msg_args(
                         to_char(adc_recursion_stack.get_level), 
                         to_char(p_action_rec.cru_sort_seq), 
                         convert(p_action_rec.cru_name, 'AL32UTF8'), 
                         g_param.firing_item,
                         adc_page_state.get_string(g_param.cgr_id, g_param.firing_item)));
    end if;
    
    add_javascript_comment(msg.ADC_ACTION_EXECUTED, msg_args(to_char(p_action_rec.cra_sort_seq)));

    pit.leave_optional;
  end add_javascript_comment;
  

  /** Method to prepare JavaScript contained in a rule action for execution
   * @param  p_action_rec  rule_action_rec instance of the actually selected rule
   * @usage  Is used to collect JavaScript code that is included in the rule actions.
   *         Before the JavaScript code can be collected, this method replaces all argument anchors.
   */
  procedure get_and_collect_js_code(
    p_action_rec in rule_action_rec)
  as
    l_js_code adc_util.max_char;

  begin
    pit.enter_optional('get_and_collect_js_code',
      p_params => msg_params(
                    msg_param('p_action_rec.js', p_action_rec.js),
                    msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                    msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                    msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                    msg_param('p_action_rec.item', p_action_rec.item)));

    -- Extract JavaScript chunk, replace parameters and register with response
    if g_param.stop_flag = adc_util.C_FALSE then
      l_js_code := utl_text.bulk_replace(p_action_rec.js, char_table(
                     'JS_FILE', C_JS_NAMESPACE,
                     'ITEM', p_action_rec.item,
                     'SELECTOR', analyze_selector_parameter(p_action_rec.item, p_action_rec.cra_param_2, l_js_code),
                     'PARAM_1', case when p_action_rec.cra_param_1 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_1) end,
                     'PARAM_2', case when p_action_rec.cra_param_2 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_2) end,
                     'PARAM_3', case when p_action_rec.cra_param_3 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_3) end,
                     'CRU_SORT_SEQ', case when p_action_rec.cru_sort_seq is not null then 'RULE_' || p_action_rec.cru_sort_seq else 'NO_RULE_FOUND' end,
                     'CRU_NAME', convert(p_action_rec.cru_name, 'WE8ISO8859P1'),
                     'EVENT_DATA', get_event_data(null),
                     'FIRING_ITEM', g_param.firing_item,
                     'CR', adc_util.C_CR));
      add_javascript(l_js_code, C_JS_CODE);
    else
      pit.info(msg.ADC_STOP_NO_JAVASCRIPT, msg_args(l_js_code));
    end if;
    
    pit.leave_optional;
  end get_and_collect_js_code;
  
  
  /** Method adds timing information and NO_JAVASCRIPT messages if no JS was found
   * %param  p_cru_name  Name of the rule
   * %param  p_start     Timestamp when the rule started examination
   * %usage  Is used to add missing information to the JavaScript answer block
   *         for this rule examination run
   */
  procedure finalize_javascript_answer(
    p_cru_name in varchar2,
    p_start in binary_integer)
  as
    l_has_js boolean default false;
  begin
  
    -- Add time measurement and collected notification messages to origin comments
    for i in 1 .. g_param.js_action_stack.count loop
      case when g_param.js_action_stack(i).debug_level = C_JS_RULE_ORIGIN then
        g_param.js_action_stack(i).script := adc_util.C_CR || 
                                             replace(replace(g_param.js_action_stack(i).script,
                                               '#NOTIFICATION#', g_param.notification_stack),
                                               '#TIME#', coalesce(dbms_utility.get_time - p_start, 0) || 'hsec');
      when g_param.js_action_stack(i).debug_level = C_JS_CODE then
        l_has_js := true;
      else
        null;
      end case;
    end loop;
    
    case 
      when p_cru_name is null then
        -- No rule found, notify if set to verbose
        add_javascript_comment(msg.ADC_NO_RULE_FOUND);
      when not l_has_js then
        -- No JavaScript found, notify if set to verbose
        add_javascript_comment(
          p_message_name => msg.ADC_NO_JAVASCRIPT, 
          p_msg_args => msg_args(p_cru_name));
      else
        null;
    end case;
    
  end finalize_javascript_answer;
  

  /** Helper to prepare and execute PL/SQL code
   * @param  p_action_rec  RULE_ACTION_REC instance of the actually selected rule
   * @usage  Is used to immediately execute PL/SQL code that is included in rule actions.
   *         The method prepares the PL/SQL code by replacing the parameter anchors and executes it. 
   *         If an error occurs, this is registered with ADC and the execution is stopped.
   */
  procedure get_and_execute_plsql_code(
    p_action_rec in out nocopy rule_action_rec)
  as
    -- Don't remove COMMIT from the PL/SQL code template. As this code is called using AJAX, no transaction control
    -- from APEX exists, so we need to control it ourselves.
    C_PLSQL_CODE_TEMPLATE constant adc_util.sql_char := 'begin #CODE#; commit; end;';
    C_PLSQL_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~v('#ITEM#')~';
    l_plsql_code adc_util.max_char;
  begin
    pit.enter_optional('get_and_execute_plsql_code',
      p_params => msg_params(
                    msg_param('p_action_rec.pl_sql', p_action_rec.pl_sql),
                    msg_param('p_action_rec.cra_param_1', p_action_rec.cra_param_1),
                    msg_param('p_action_rec.cra_param_2', p_action_rec.cra_param_2),
                    msg_param('p_action_rec.cra_param_3', p_action_rec.cra_param_3),
                    msg_param('p_action_rec.item', p_action_rec.item)));
                    
    -- create PL/QSL code from template
    if g_param.stop_flag = adc_util.C_FALSE then
      l_plsql_code := utl_text.bulk_replace(trim(';' from p_action_rec.pl_sql), char_table(
                        'PARAM_1', case when p_action_rec.cra_param_1 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_1) end,
                        'PARAM_2', case when p_action_rec.cra_param_2 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_2) end,
                        'PARAM_3', case when p_action_rec.cra_param_3 is not null then analyze_parameter_value(p_action_rec.item, p_action_rec.cra_param_3) end,
                        'ALLOW_RECURSION', check_recursion(p_action_rec),
                        'ITEM_VALUE', C_PLSQL_ITEM_VALUE_TEMPLATE,
                        'EVENT_DATA', get_event_data(null),
                        'ITEM', p_action_rec.item,
                        'CR', adc_util.C_CR));
                        
      l_plsql_code := replace(C_PLSQL_CODE_TEMPLATE, '#CODE#', l_plsql_code);      
      add_javascript_comment(msg.ADC_PLSQL_CODE, msg_args(l_plsql_code));

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Display error
          pit.handle_exception(msg.ADC_UNHANDLED_EXCEPTION, msg_args(l_plsql_code));
          register_error(p_action_rec.item, msg.ADC_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          stop_rule;
      end;
    else
      add_javascript_comment(msg.ADC_STOP_NO_PLSQL);
    end if;
    
    pit.leave_optional;
  end get_and_execute_plsql_code;
  
  
  /** Method calculates the answer for a given situation in the session state based on the ADC rules for the active page.
   * @usage  Is called from PROCESS_RULE. This method selects the applicable rule for the actual situation and executes it
   *         Querying the decision table of the requests rule group to
   *         - evaluate which rule to execute and 
   *         - execute all actions of that rule
   */
  procedure evaluate_and_execute_rule_action(
    p_rule_stmt in adc_util.max_char)
  as
    l_action_rec rule_action_rec;
    l_action_cur sys_refcursor;
    l_ignore_rule_errors boolean;
    l_action_is_error_handler boolean;
    l_loop_counter binary_integer;
  begin
    pit.enter_mandatory('evaluate_and_execute_rule_action');

    -- Initialization
    g_has_errors := false;
    g_param.now := dbms_utility.get_time;    
    
    -- Evaluate which rule to execute by querying the decision table
    open l_action_cur for p_rule_stmt;
    fetch l_action_cur into l_action_rec;
    pit.info(msg.ADC_PROCESSING_RULE, msg_args(to_char(l_action_rec.cru_sort_seq), l_action_rec.cru_name));
    
    -- Process rule actions
    adc_util.monitor_loop;
    while l_action_cur%FOUND loop
      $IF adc_util.C_WITH_UNIT_TESTS $THEN
      append_test_result(l_action_rec);
      $END
    
      add_javascript_comment(l_action_rec);
      
      -- Initialize
      -- Ignores rule errors if this rule has no exception handler action
      l_ignore_rule_errors := l_action_rec.cru_on_error = adc_util.C_FALSE;
      l_action_is_error_handler := l_action_rec.cra_on_error = adc_util.C_TRUE;
      -- check whether action has to be executed
      case   
        -- Normal execution. This is true in three possible cases:
        when (not g_has_errors and not l_action_is_error_handler) 
          or (g_has_errors and l_action_is_error_handler)
          or (l_ignore_rule_errors) 
        then
          if l_action_rec.pl_sql is not null then
            get_and_execute_plsql_code(l_action_rec);
          end if;
          if l_action_rec.js is not null then
            get_and_collect_js_code(l_action_rec);
          end if;
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        add_javascript_comment(msg.ADC_ACTION_REJECTED, msg_args(to_char(l_action_rec.cra_sort_seq)));
      end case;
      
      -- get next action
      fetch l_action_cur into l_action_rec;
      adc_util.monitor_loop(l_loop_counter, 'evaluate_and_execute_rule_action');
    end loop;
    adc_util.close_cursor(l_action_cur);
    
    finalize_javascript_answer(l_action_rec.cru_name, g_param.now);
    
    pit.leave_mandatory;
  exception
    when others then
      adc_util.close_cursor(l_action_cur);
      pit.handle_exception(msg.SQL_ERROR, msg_args(p_rule_stmt));
  end evaluate_and_execute_rule_action;
  
    
  /** Method analyzes the requested rule of the rule group
   * @return HTML script element with a JavaScript code containing the answer of the rule
   * @usage  is called if a rule has to be executed
   *         - Create a JavaScript script to execute on the page
   *         - analyzes whether changes the rule initiates causes other rules to be recursively called
   */
  procedure process_rule(
    p_rule_stmt in adc_util.max_char)
  as
  begin
    pit.enter_mandatory('process_rule');
    
    -- Initialization
    g_param.notification_stack := null;
    
    -- Any firing item needs to be chacked whether it is
    -- - possible to conert it to the required data type
    -- - a mandatory field (and, in that case, contains a value)
    adc_page_state.set_value(
      p_cgr_id => g_param.cgr_id, 
      p_cpi_id => g_param.firing_item,
      p_throw_error => adc_util.C_TRUE);
      
    check_mandatory(g_param.firing_item, adc_util.C_TRUE);
    
    evaluate_and_execute_rule_action(p_rule_stmt);
    
    -- remove processed item from recursive stack (or all, if requested)
    adc_recursion_stack.pop_firing_item(g_param.firing_item, g_param.stop_flag);
    
    -- Iterate over recursion stack. First firing item was pushed to the stack in READ_SETTINGS
    -- If a rule action changes the session state, the changed item will be pushed onto the recursive stack
    g_param.firing_item := adc_recursion_stack.get_next;
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
  
  
  /** Merthod to compose the JavaScript result of the rule evaluation
   * @return JavaScript response to be executed on the page as the response of the rule evaluation
   * @usage  Is used to compose the answer of ADC as a JavaScript to be executed by the browser.
   *         Depending on parameterization and length of the response, the response will contain more or lesse code.
   *         As the maximum response size is limited to 32KByte, the method may decide to skip comments in order to respect
   *         the size limit.
   */
  function get_java_script
    return varchar2
  as
    l_js adc_util.max_char;
    l_max_level binary_integer;
  begin
    pit.enter_optional('get_java_script');
                  
    append_apex_actions(l_js);
                        
    -- collect javascript from stack
    if g_param.js_action_stack.count > 0 then
      check_max_level(l_js, l_max_level);
      
      -- collect all javascript chunks
      for i in 1 .. g_param.js_action_stack.count + 1 loop
        if g_param.js_action_stack.exists(i)
          and coalesce(g_param.js_action_stack(i).debug_level, C_JS_CODE) <= l_max_level
          and not(g_param.js_action_stack(i).debug_level = C_JS_DEBUG and not(pit.check_log_level_greater_equal(pit.LEVEL_DEBUG)))
        then
          utl_text.append(l_js, g_param.js_action_stack(i).script || adc_util.C_CR);
        end if;
      end loop;
    end if;
    
    -- wrap JavaScript in <script> tag and add item value and error scripts
    -- Replace script explicitely to circumvent length limitation of CHAR_TABLE
    l_js := replace(C_JS_SCRIPT_FRAME, '#SCRIPT#', l_js);
    
    l_js := utl_text.bulk_replace(l_js, char_table(
              'ID', 'S_' || trunc(dbms_random.value * 10000000),
              'CR', adc_util.C_CR,
              'ITEM_JSON', adc_page_state.get_changed_items_as_json,
              'ERROR_JSON',  get_errors_as_json,
              'FIRING_ITEMS', adc_recursion_stack.get_firing_items_as_json,
              'JS_FILE', C_JS_NAMESPACE,
              'DURATION', to_char(dbms_utility.get_time - g_param.now)));
    
    -- BULK_REPLACE uses # as a control character, unmask it after conversion
    l_js := replace(l_js, adc_util.C_HASH, '#');
    
    pit.leave_optional(msg_params(msg_param('JavaScript', l_js)));
    return l_js;
  end get_java_script;
  
  
  /** Method
   */
  function check_data_type(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_cit_id adc_page_item_types.cit_id%type;
    l_cpi_conversion adc_page_items.cpi_conversion%type;
    l_string_value adc_util.max_char;
  begin
    pit.enter_optional('check_data_type',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
    
    select cpi_cit_id, cpi_conversion
      into l_cit_id, l_cpi_conversion
      from adc_page_items
     where cpi_id = p_cpi_id
       and instr(cpi_cit_id, 'ITEM') > 0
       and cpi_cgr_id = g_param.cgr_id;
     
    case l_cit_id
      when 'DATE_ITEM' then
        l_string_value := to_char(adc_page_state.get_date(g_param.cgr_id, p_cpi_id, l_cpi_conversion));
      when 'NUMBER_ITEM' then
        l_string_value := to_char(adc_page_state.get_number(g_param.cgr_id, p_cpi_id, l_cpi_conversion));
      else
        null;
    end case;
    
    l_string_value := adc_page_state.get_string(g_param.cgr_id, p_cpi_id);
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', l_string_value)));
    return l_string_value;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional(
        p_params => msg_params(
                      msg_param('WARNING', 'Item not found')));
      return null;
  end check_data_type;
  
  
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
    p_error.page_item_name := p_cpi_id;
    p_error.additional_info := apex_escape.json(p_error.additional_info || replace(dbms_utility.format_error_backtrace, chr(10), '<br/>'));
    if instr(p_error.message, C_LABEL_ANCHOR) > 0 then
      select replace(p_error.message, C_LABEL_ANCHOR, cpi_label)
        into p_error.message
        from adc_page_items
       where cpi_cgr_id = g_param.cgr_id
         and cpi_id = p_cpi_id;
    end if;
  end prepare_error;
  
  
  /** Method to create initial rule group and rule for a page that references ADC
   * %param  p_action_rec_group_row  Instance of the rule group row with predefined attributes
   * %usage  Is called if ADC detects that a page which references ADC does not yet 
   *         own a rule group and an initial rule. It then creates the default rule group and rule.
   */
  procedure create_initial_action_rec_group(
    p_action_rec_group_row in out nocopy adc_rule_groups%rowtype)
  as
    l_action_rec_row adc_rules%rowtype;
  begin
    pit.enter_optional('create_initial_action_rec_group');
    
    adc_admin.merge_rule_group(p_action_rec_group_row);
    l_action_rec_row.cru_cgr_id := p_action_rec_group_row.cgr_id;
    l_action_rec_row.cru_name := 'die Seite öffnet';
    l_action_rec_row.cru_condition := 'initializing = c_true';
    l_action_rec_row.cru_sort_seq := 10;
    l_action_rec_row.cru_active := adc_util.c_true;
    l_action_rec_row.cru_fire_on_page_load := adc_util.C_FALSE;
    adc_admin.merge_rule(l_action_rec_row);
    adc_admin.propagate_rule_change(p_action_rec_group_row.cgr_id);
    
    pit.leave_optional;
  end create_initial_action_rec_group;
  
    
  procedure initialize
  as
  begin
    g_param.collection_name := param.get_string('COLLECTION_NAME', C_PARAM_GROUP);
    select uttm_text 
      into g_json_error_template
      from utl_text_templates
     where uttm_type = C_PARAM_GROUP
       and uttm_name = 'JSON_ERRORS'
       and uttm_mode = C_MODE_FRAME;
  end initialize;
  

  /*============ INTERFACE ============*/  
  /** PLUGIN FUNCTIONALITY */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default C_JS_CODE)
  as
    C_COMMENT_OUT constant varchar2(20) := C_JS_COMMENT_STRING ||'(double) ';
    l_next_entry binary_integer;
    l_js js_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_java_script', p_java_script),
                    msg_param('p_debug_level', p_debug_level)));
                    
    if p_java_script is not null then
      l_next_entry := g_param.js_action_stack.count + 1;
      
      select p_java_script, standard_hash(p_java_script), p_debug_level
        into l_js
        from dual;
        
      -- comment out double JavaScript entries
      for i in 1 .. g_param.js_action_stack.count loop
        if g_param.js_action_stack.exists(i) then
          if g_param.js_action_stack(i).debug_level = C_JS_CODE and g_param.js_action_stack(i).javascript_hash = l_js.javascript_hash then
            g_param.js_action_stack(i).script := C_COMMENT_OUT || g_param.js_action_stack(i).script;
            g_param.js_action_stack(i).javascript_hash := null;
            g_param.js_action_stack(i).debug_level := C_JS_DEBUG;
          end if;
        end if;
      end loop;
      
      -- persist JavaScript action
      g_param.js_action_stack(l_next_entry) := l_js;
      
      -- Calculate length of comments and scripts
      g_param.level_length(l_js.debug_level) := g_param.level_length(l_js.debug_level) + length(l_js.script);
    end if;
  
    pit.leave_optional;
  end add_javascript;
  
  
  function get_error_flag
    return boolean
  as
  begin
    -- Tracing done in ADC_API
    return g_has_errors;
  end get_error_flag;
  
    
  function get_event
    return varchar2
  as
  begin
    -- Tracing done in ADC_API
    return g_param.firing_event;
  end get_event;
  
  
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
      pit.handle_exception(msg.ADC_PARSE_JSON, msg_args(g_param.event_data, p_key));
      return null;
  end get_event_data;
  
  
  function get_firing_item
    return varchar2
  as
  begin
    pit.enter_optional;
        
    pit.leave_optional(
      p_params => msg_params(msg_param('FiringItem', g_param.firing_item)));
    return g_param.firing_item;
  end get_firing_item;
  
  
  function get_bind_items_as_json
    return clob
  as
    C_BIND_JSON_TEMPLATE constant adc_util.sql_char := '[#JSON#]';
    C_BIND_JSON_ELEMENT constant adc_util.sql_char := '{"id":"#ID#","event":"#EVENT#","action":"#STATIC_ACTION#"}';
    -- List of item which need to bind an event
    cursor rule_group_cpi_ids(p_cgr_id adc_rule_groups.cgr_id%type) is
      select cpi_id, cit_event, cit_has_value, null static_action
        from adc_page_items spi
        join adc_page_item_types sit
          on spi.cpi_cit_id = sit.cit_id
        join adc_rule_groups cgr
          on spi.cpi_cgr_id = cgr.cgr_id
       where sit.cit_event is not null
         and spi.cpi_is_required = adc_util.C_TRUE
         and cgr.cgr_active = adc_util.C_TRUE
         and cgr.cgr_id = p_cgr_id
     union all
     -- List of items which are bound by other events already
     select coalesce(to_char(cra_param_2), cra_cpi_id), cit_event, cit_has_value, cra_param_1
       from adc_page_item_types
       join adc_rule_actions
         on cit_id = cra_cat_id
      where cra_cgr_id = p_cgr_id;
    l_json clob;
  begin
    pit.enter_optional;
    
    for item in rule_group_cpi_ids(g_param.cgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(C_BIND_JSON_ELEMENT, char_table(
          'ID', item.cpi_id,
          'EVENT', item.cit_event,
          'STATIC_ACTION', item.static_action)),
        C_DELIMITER, true);
    end loop;
    
    -- Create items with '~' as a replacement for '"' to prevent APEX from escaping it with an escape sequence.
    -- This assures that the browser is able to create a JavaScript object from it
    l_json := replace(replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json), '"', '~');
    
    pit.leave_optional;
    return l_json;
  end get_bind_items_as_json;
  
  
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
                  else cra_cpi_id end, C_DELIMITER) within group (order by cru_firing_items)
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


  function get_page_items
    return varchar2
  as
    l_changed_value_items adc_util.max_char;
  begin
    pit.enter_optional;
    
    -- concatenate list
    l_changed_value_items := adc_page_state.get_changed_items_as_json;
    
    pit.leave_optional;
    return trim(C_DELIMITER from l_changed_value_items);
  end get_page_items;
  
  
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
    
    -- Initialize internal APEX mandatory item collection
    begin
      apex_collection.create_or_truncate_collection(g_param.collection_name);
    exception
      when DUP_VAL_ON_INDEX then
        -- This error can occur with hectic, multiple clicks, ignore.
        null;
    end;
    
    -- Register all predefined mandatory items
    register_mandatory(
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_cpi_mandatory_message => null,
      p_is_mandatory => null);
    
    pit.leave_optional;
  end process_initialization_code;

  
  function process_request
    return clob
  as
    l_js_script adc_util.max_char;
    l_rule_stmt adc_util.max_char;
  begin      
    pit.enter_mandatory;
    
    adc_page_state.reset;
    
    -- get rule statement to evaluate the necessary actions
    select cgr_decision_table
      into l_rule_stmt
      from adc_rule_groups
     where cgr_id = g_param.cgr_id;
    process_rule(l_rule_stmt);
    
    l_js_script := get_java_script;
    
    adc_page_state.reset;
      
    pit.leave_mandatory(
      p_params => msg_params(msg_param('JavaScript', l_js_script)));
    return l_js_script;
  end process_request;
  
  
  procedure push_error(
    p_error in apex_error.t_error)
  as
    C_MAX_INTEGER constant number := 2147483647; -- Used to limit Hashfunktions to the max of BINARY_INTEGER
    l_error apex_error.t_error;
    l_error_json adc_util.max_char;
    l_error_hash binary_integer;
  begin
    pit.enter_optional;
  
    l_error := p_error;
    begin
      -- prepare message texts
      if l_error.message like ' Zeile 1%' then
        l_error.message := pit.get_trans_item_name(C_PARAM_GROUP, 'FAULTY_ERROR_MESSAGE');
      end if;
      l_error.additional_info := apex_escape.js_literal(l_error.additional_info);
      l_error.message := apex_escape.js_literal(l_error.message);
    exception
      when others then
        l_error.message := pit.get_trans_item_name(C_PARAM_GROUP, 'INVALID_ERROR_MESSAGE');
    end;
    
    select ora_hash(l_error.message || l_error.page_item_name, C_MAX_INTEGER)
      into l_error_hash
      from dual;
      
    if not g_param.error_stack.exists(l_error_hash) then    
      select utl_text.generate_text(cursor(
               select uttm_text template,
                      l_error.page_item_name page_item,
                      l_error.message message,
                      l_error.additional_info additional_info,
                      case l_error.page_item_name when adc_util.C_NO_FIRING_ITEM  then '"page"' else '["inline","page"]' end location
                 from utl_text_templates
                where uttm_type = C_PARAM_GROUP
                  and uttm_name = 'JSON_ERRORS'
                  and uttm_mode = 'ERROR'))
        into l_error_json
        from dual;
        
      g_param.error_stack(l_error_hash) := l_error_json;
      g_has_errors := true;
    end if;
    
    pit.leave_optional;
  end push_error;
  

  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2)
  as
    C_COLLECTION_NAME constant adc_util.ora_name_type := C_PARAM_GROUP || '_CGR_STATUS_';
    l_action_rec_group_row adc_rule_groups%rowtype;
    l_action_rec_row adc_rules%rowtype;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_firing_item', p_firing_item),
                    msg_param('p_event', p_event),
                    msg_param('p_event_data', p_event_data)));
                    
    l_action_rec_group_row.cgr_app_id := apex_application.g_flow_id;
    l_action_rec_group_row.cgr_page_id := apex_application.g_flow_step_id;
    
    -- Read rule group
    select cgr_id
      into g_param.cgr_id
      from adc_rule_groups
     where cgr_app_id = l_action_rec_group_row.cgr_app_id
       and cgr_page_id = l_action_rec_group_row.cgr_page_id;
    
        
    -- Initialize collections
    g_param.bind_event_items := char_table();
    g_param.error_stack.delete;
    g_param.js_action_stack.delete;
    g_param.level_length(C_JS_CODE) := 0;
    g_param.level_length(C_JS_RULE_ORIGIN) := 0;
    g_param.level_length(C_JS_DEBUG) := 0;
    g_param.level_length(C_JS_COMMENT) := 0;
    g_param.level_length(C_JS_DETAIL) := 0;
    g_param.level_length(C_JS_VERBOSE) := 0;
    g_param.firing_item := p_firing_item;
    g_param.initialize_mode := g_param.firing_item = adc_util.C_NO_FIRING_ITEM;
    g_param.firing_event := p_event;
    g_param.event_data := p_event_data;
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := adc_util.C_FALSE;
    g_param.collection_name := C_COLLECTION_NAME || g_param.cgr_id;
    
    adc_page_state.reset;
    adc_recursion_stack.reset(g_param.cgr_id, g_param.firing_item);--adc_util.C_NO_FIRING_ITEM);
    
    pit.leave_optional;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR then
      -- If conversion is impossible, this is not an issue during installation.
      g_param.error_stack.delete;
      pit.leave_optional;
    when NO_DATA_FOUND then
      create_initial_action_rec_group(l_action_rec_group_row);
      read_settings(p_firing_item, p_event, p_event_data);
  end read_settings;
    
    
  /*============ ADC FUNCTIONALITY ============*/
  procedure check_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stop in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_mandatory_message adc_page_items.cpi_mandatory_message%type;
    l_is_mandatory adc_util.flag_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_stop', p_stop)));
    
    if not g_param.initialize_mode then
      -- check whether item is mandatory
      select null
        into l_is_mandatory
        from apex_collections
       where collection_name = g_param.collection_name
         and c001 = p_cpi_id;
      
      if adc_page_state.get_string(g_param.cgr_id, p_cpi_id) is null then 
        l_mandatory_message := get_mandatory_message(p_cpi_id);
        register_error(p_cpi_id, l_mandatory_message, '');
        if p_stop = adc_util.C_TRUE then
          stop_rule;
        end if;
      end if;
    end if;
      
    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      -- item is not mandatory, ignore
      pit.leave_mandatory(
        p_params => msg_params(msg_param('Item', 'not mandatory')));
    when others then
      register_error(p_cpi_id, substr(sqlerrm, 12), '');
  end check_mandatory;
  
  
  procedure execute_action(
    p_cat_id in adc_action_types.cat_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_1 in adc_rule_actions.cra_param_1%type,
    p_param_2 in adc_rule_actions.cra_param_2%type,
    p_param_3 in adc_rule_actions.cra_param_3%type)
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
                            'PARAM_3', case when p_param_3 is not null then analyze_parameter_value(p_cpi_id, p_param_3) end));
      execute immediate l_row.cat_pl_sql;
    end if;

    if l_row.cat_js is not null then
      l_java_script := utl_text.bulk_replace(l_row.cat_js, char_table(
                         'ITEM', p_cpi_id,
                         'SELECTOR', analyze_selector_parameter(p_cpi_id, p_param_2, l_row.cat_js),
                         'PARAM_1', case when p_param_1 is not null then analyze_parameter_value(p_cpi_id, p_param_1) end,
                         'PARAM_2', case when p_param_2 is not null then analyze_parameter_value(p_cpi_id, p_param_2) end,
                         'PARAM_3', case when p_param_3 is not null then analyze_parameter_value(p_cpi_id, p_param_3) end));
      add_javascript(l_java_script);
    end if;
  exception
    when NO_DATA_FOUND then
      register_error('DOCUMENT', msg.ADC_ACTION_DOES_NOT_EXIST, msg_args(p_cat_id));
    when others then
      pit.handle_exception(msg.SQL_ERROR, msg_args(substr(sqlerrm, 12)));
  end execute_action;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #COMMAND#; end;';
    l_result adc_util.max_char;
    l_cmd adc_util.max_char;
  begin
    -- Tracing done in ADC_API
    l_cmd := replace(c_cmd_template, '#COMMAND#', replace(trim(p_plsql), ';'));
    execute immediate l_cmd using out l_result;
    add_javascript(replace(l_result, 'javascript:'), C_JS_CODE);
  end execute_javascript;
  
  
  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
    l_value_list char_table;
    l_value_counter binary_integer := -1;
    l_result adc_util.flag_type;
  begin
    -- Tracing done in ADC_API  
    get_item_values_as_char_table(p_value_list, l_value_list);
    select count(*)
      into l_value_counter
      from table(l_value_list)
     where column_value is not null
       and rownum < 3;
      
    l_result := case l_value_counter
                when 0 then null
                when 1 then adc_util.C_TRUE
                else adc_util.C_FALSE end;                
    return l_result;
  end exclusive_or;
    
    
  /* @see adc_api.get_string */
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
  begin
    return adc_page_state.get_string(g_param.cgr_id, p_cpi_id);
  end get_string;

  /* @see adc_api.get_date */
  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return date
  as
  begin
    return adc_page_state.get_date(g_param.cgr_id, p_cpi_id, p_format_mask);
  end get_date;
  
  
  /* @see adc_api.get_number */
  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return number
  as
  begin
    return adc_page_state.get_number(g_param.cgr_id, p_cpi_id, p_format_mask);
  end get_number;
    
    
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
    l_value_list char_table;
    l_value_counter binary_integer;
    l_result adc_util.flag_type := adc_util.C_FALSE;
  begin
    -- Tracing done in ADC_API
    get_item_values_as_char_table(p_value_list, l_value_list);
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
  
  
  procedure notify(
    p_text in varchar2,
    p_level in binary_integer default C_JS_COMMENT)
  as
    c_comment constant varchar2(10) := adc_util.C_CR || C_JS_COMMENT_STRING;
  begin
    -- Tracing done in ADC_API
    if pit.check_log_level_greater_equal(p_level) then
      utl_text.append(g_param.notification_stack, C_COMMENT || p_text);
    end if;
  end notify;


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
  

  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    l_has_rule number;
    l_dummy adc_util.max_char;
  begin
    pit.enter_detailed('register_item',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id), 
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));
                        
    -- Get the element value to make sure it is registered as a changed item
    l_dummy := adc_page_state.get_string(g_param.cgr_id, p_cpi_id);
    
    adc_recursion_stack.push_firing_item(g_param.cgr_id, p_cpi_id, p_allow_recursion);
    
    pit.leave_detailed;
  end register_item;  
  
  
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
    l_item_list char_table;
    l_srs_row adc_rule_group_status%rowtype;
    
    cursor mandatory_items_cur is
      select cpi_id, cpi_label, cpi_mandatory_message
        from adc_page_items
       where cpi_cgr_id = g_param.cgr_id
         and cpi_is_mandatory = adc_util.C_TRUE;
  begin
    -- Tracing done in ADC_API
    pit.assert_not_null(g_param.cgr_id);
    
    case
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is null then
      -- Called during initialization phase. Register permanent mandatory fields
      for item in mandatory_items_cur loop
        apex_collection.add_member(
          p_collection_name => g_param.collection_name,
          p_c001 => item.cpi_id,
          p_c002 => item.cpi_label,
          p_c003 => item.cpi_mandatory_message,
          p_generate_md5 => 'NO');
      end loop;
    when p_cpi_id != adc_util.C_NO_FIRING_ITEM then
      -- Item name directly passed in
      select collection_name, srs_id, cpi_id, cpi_label, srs_cpi_mandatory_message
        into l_srs_row
        from adc_page_items
        left join (
             select *
               from adc_rule_group_status
              where collection_name = g_param.collection_name)
          on cpi_id = srs_cpi_id
       where cpi_cgr_id = g_param.cgr_id
         and cpi_id = p_cpi_id;
      case when p_is_mandatory = adc_util.C_TRUE and l_srs_row.srs_id is null then
        -- Item has become a mandatory field, register in collection
        apex_collection.add_member(
          p_collection_name => g_param.collection_name,
          p_c001 => l_srs_row.srs_cpi_id,
          p_c002 => l_srs_row.srs_cpi_label,
          p_c003 => coalesce(p_cpi_mandatory_message, get_mandatory_message(l_srs_row.srs_cpi_id), 'null'),
          p_generate_md5 => 'NO');
      when p_is_mandatory = adc_util.C_FALSE and l_srs_row.srs_id is not null then
        -- Element must be removed from the list of mandatory elements
        apex_collection.delete_member(
          p_seq => l_srs_row.srs_id,
          p_collection_name => g_param.collection_name);
      else
        -- Status has not changed
        null;
      end case;
    when p_jquery_selector is not null then
      -- jQuery selector passed in. Read all elements affected by this selector
      l_item_list := get_items_with_selector(p_cpi_id, p_jquery_selector);
      for i in 1 .. l_item_list.count loop
        register_mandatory(
          p_cpi_id => l_item_list(i),
          p_cpi_mandatory_message => coalesce(p_cpi_mandatory_message, get_mandatory_message(l_item_list(i))), 
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
  
  
  procedure register_observer(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_optional;
    
    if not g_param.bind_event_items.exists(p_cpi_id) and g_param.initialize_mode then
      g_param.bind_event_items(g_param.bind_event_items.count + 1) := p_cpi_id;
    end if;
    
    pit.leave_optional;
  end register_observer;
  
  
  procedure set_initialize_mode(
    p_mode in boolean default true)
  as
  begin
   g_param.initialize_mode := p_mode;
  end set_initialize_mode;
      
    
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_selector in adc_rule_actions.cra_param_2%type default null)
  as
    l_item_list char_table;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_allow_recursion', p_allow_recursion)));
                    
    case
    when p_cpi_id != adc_util.C_NO_FIRING_ITEM then
      -- Page item, value can be set
      adc_page_state.set_value(
        p_cgr_id => g_param.cgr_id,
        p_cpi_id => p_cpi_id,
        p_value => p_value,
        p_number_value => p_number_value,
        p_date_value => p_date_value);
      register_item(p_cpi_id, p_allow_recursion);
      add_javascript_comment(msg.ADC_SESSION_STATE_SET, msg_args(p_cpi_id, p_value));
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
      l_item_list := get_items_with_selector(p_cpi_id, p_jquery_selector);
      -- recursively call SET_SESSION_STATE for each found item
      if l_item_list.count > 0 then
        for i in l_item_list.first .. l_item_list.last loop
          set_session_state(l_item_list(i), p_value, p_allow_recursion, null);
        end loop;
      end if;
    else
      null;
    end case;
      
    pit.leave_mandatory;
  end set_session_state;


  procedure set_value_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := 'select * from (#STMT#) where rownum = 1';
    l_stmt adc_util.max_char;
    l_result varchar2(4000);
    l_cur integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
  begin
    -- Tracing done in ADC_API
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    
    if p_cpi_id = adc_util.c_no_firing_item or p_cpi_id is null then
      -- Wird kein Element angegeben, werden die Elemente gemaess des Spaltennamens gesetzt
      l_cur := dbms_sql.open_cursor;
      -- SQL parsen, um Spaltenbezeichner zu ermitteln
      dbms_sql.parse(l_cur, l_stmt, dbms_sql.native);
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
        set_session_state(l_desc_tab(i).col_name, l_result);
      end loop;
      dbms_sql.close_cursor(l_cur);
    else
      -- Konkretes Element angefordert, laut Konvention ist nur eine Spalte enthalten
      execute immediate l_stmt into l_result;
      set_session_state(p_cpi_id, l_result, adc_util.C_TRUE, null);
    end if;
  exception
    when others then
      add_javascript_comment(msg.ADC_NO_DATA_FOR_ITEM, msg_args(p_cpi_id));
      set_session_state(p_cpi_id, '', adc_util.C_TRUE, null);
  end set_value_from_stmt;
  
  
  procedure stop_rule
  as
  begin
    -- Tracing done in ADC_API
    g_param.stop_flag := adc_util.C_TRUE;
  end stop_rule;
    
  
  procedure validate_page
  as
    cursor mandatory_item_cur is
      select srs_cpi_id, srs_cpi_mandatory_message
        from adc_rule_group_status
       where collection_name = g_param.collection_name;

    cursor validation_action_cur is
      select cra_cat_id, cra_cpi_id, cra_param_1, cra_param_2, cra_param_3
        from adc_rule_actions
       where cra_cgr_id = g_param.cgr_id
         and cra_raise_on_validation = adc_util.C_TRUE;
  begin
    -- Tracing done in ADC_API
    
    -- Check all mandatory fields (elements may not have triggered a CHANGE event)
    for itm in mandatory_item_cur loop
      if adc_page_state.get_string(g_param.cgr_id, itm.srs_cpi_id) is null then
        -- Mandatory field has no session status, throw error
        register_error(itm.srs_cpi_id, coalesce(itm.srs_cpi_mandatory_message, get_mandatory_message(itm.srs_cpi_id)), '');
      end if;
    end loop;

    -- Check all validations of the current ADC group
    for sra in validation_action_cur loop
      execute_action(
        p_cat_id => sra.cra_cat_id,
        p_cpi_Id => sra.cra_cpi_id,
        p_param_1 => sra.cra_param_1,
        p_param_2 => sra.cra_param_2,
        p_param_3 => sra.cra_param_3);
    end loop;
  end validate_page;
  
begin
  initialize;
end adc_internal;
/