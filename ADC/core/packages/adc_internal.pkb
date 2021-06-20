create or replace package body adc_internal 
as

  /** Private constants*/
  C_PARAM_GROUP constant adc_util.ora_name_type := 'ADC';
  C_MAX_LENGTH binary_integer := 32000;
  C_MODE_FRAME constant adc_util.ora_name_type := 'FRAME';
  C_MODE_DEFAULT constant adc_util.ora_name_type := 'DEFAULT';
  C_COLLECTION_NAME constant adc_util.ora_name_type := C_PARAM_GROUP || '_CGR_STATUS_';

  C_PAGE_ITEMS constant binary_integer := 1;
  C_FIRING_ITEMS constant binary_integer := 2;
  
  C_NUMBER_ITEM constant adc_page_item_types.cit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant adc_page_item_types.cit_id%type := 'DATE_ITEM';
  C_REGISTER_OBSERVER constant adc_action_types.cat_id%type := 'REGISTER_OBSERVER';
  C_DELIMITER constant varchar2(1 byte) := ',';
  C_EVENT_INITIALIZE constant adc_util.ora_name_type := 'initialize';
  
  C_BIND_JSON_TEMPLATE constant adc_util.sql_char := '[#JSON#]';
  C_BIND_JSON_ELEMENT constant adc_util.sql_char := '{"id":"#ID#","event":"#EVENT#","action":"#STATIC_ACTION#"}';
  C_PAGE_JSON_ELEMENT constant adc_util.sql_char := '{"id":"#ID#","value":"#VALUE#"}';  
  C_JS_NAMESPACE constant adc_util.ora_name_type := 'de.condes.plugin.adc';
  C_JS_SCRIPT_FRAME constant adc_util.sql_char := q'^<script id="#ID#" charset="utf-8">#CR#  /** Init: #DURATION#hsec*/#CR#  #JS_FILE#.setItemValues(#ITEM_JSON#);#CR#  #JS_FILE#.setErrors(#ERROR_JSON#);#CR##SCRIPT##CR#</script>^';

  /** Private types */
  type item_stack_t is table of number index by varchar2(50);
  
  -- Error stack
  type error_stack_t is table of adc_util.max_char index by binary_integer;
  
  -- JavaScript stack
  type js_rec is record(
    script adc_util.max_char,
    hash raw(2000),
    debug_level binary_integer);
    
  type js_list is table of js_rec index by binary_integer;
  
  -- Cache session state values during rule processing to prevent unnecessary fetches
  type session_value_rec is record(
    string_value adc_util.max_char,
    date_value date,
    number_value number);

  type session_value_tab is table of session_value_rec index by adc_util.ora_name_type;
  
  /** recursion stack
   * The recursion stack stores the page elements that were changed by the rules,
   * to subsequently call rule checking for those elements as well.
   */
  type recursive_stack_t is table of number index by adc_page_items.cpi_id%type;
  
  type level_length_t is table of binary_integer index by binary_integer;
  
  /** Record for recording the plugin attributes
   */
  type param_rec is record(
    id number,                                       -- internal ID of the record
    cgr_id adc_rule_groups.cgr_id%type,               -- actual CGR_ID
    firing_item adc_page_items.cpi_id%type,           -- actual firing item (or adc_util.C_NO_FIRING_ITEM)
    firing_event adc_page_item_types.cit_event%type,  -- actual firing event (normally change or click, but can be any event)
    event_data adc_util.max_char,                    -- optional event data that is returned from modal dialog pages etc.
    bind_items item_stack_t,                         -- List of items for which ADC binds event handlers
    page_items item_stack_t,                         -- List of items that changed their value in the session state
    firing_items item_stack_t,                       -- List of items which are connected with firing item within their rules
    error_stack error_stack_t,                       -- List errors that occurred
    recursive_stack recursive_stack_t,               -- List of items which were marked to recursively check rules for
    is_recursive adc_util.flag_type,                 -- Flag to indicate whether we're in a recursive rule run
    js_action_stack js_list,                         -- JavaScript action stack, rule outcome of the rules executed so far
    level_length level_length_t,                     -- cumulated length of the strings on the respective severity levels
    recursive_level binary_integer,                  -- actual recursive level
    allow_recursion boolean,                         -- Flag to indicate whether recursive calls are allowed for the active rule
    notification_stack adc_util.max_char,            -- List of notifications to be shown in the browser console
    stop_flag boolean,                               -- Flag to indicate that all rule execution has to be stopped
    now binary_integer,                              -- timestamp, used to calculate the execution duration
    collection_name adc_util.ora_name_type            -- Collection used to maintain a list of mandatory items
  );
  
  
  /** Record for recording data of the actually executed rule and rule action
   */
  type rule_rec is record(
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
  g_recursion_limit binary_integer;
  g_recursion_loop_is_error boolean;
  g_session_values session_value_tab;
    
  $IF adc_util.C_WITH_UNIT_TESTS $THEN
  /*============ UNIT TEST ============*/ 
  g_test_mode boolean := false;
  g_test_result ut_adc_result;
  
  procedure set_test_mode(
    p_mode in boolean default false)
  as
  begin
    g_test_mode := p_mode;
  end set_test_mode;
  
  function get_test_mode
    return boolean
  as
  begin
    return g_test_mode;
  end get_test_mode;
  
  
  function get_test_result
    return ut_adc_result
  as
  begin
    return g_test_result;
  end get_test_result;
  
  
  function to_char_table(
    p_list item_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list recursive_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list error_stack_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := p_list(i);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list level_length_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := to_char(p_list(i));
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_ut_adc_js_list(
    p_js_list js_list)
    return ut_adc_js_list
  as
    l_test_js_list ut_adc_js_list := ut_adc_js_list();
    l_js_rec js_rec;
    l_test_js_rec ut_adc_js_rec;
  begin
    for i in 1 .. p_js_list.count loop
      l_js_rec := p_js_list(i);
      l_test_js_rec := ut_adc_js_rec(substr(l_js_rec.script, 1, 4000), l_js_rec.hash, l_js_rec.debug_level);
      l_test_js_list.extend;
      l_test_js_list(l_test_js_list.count) := l_test_js_rec;
    end loop;
    return l_test_js_list;
  end to_ut_adc_js_list;
  
  
  function to_ut_adc_row(
    p_rule_rec rule_rec)
    return ut_adc_row
  as
    l_test_row ut_adc_row;
  begin
    l_test_row := ut_adc_row(
                    -- Rule
                    p_rule_rec.cru_id, p_rule_rec.cru_sort_seq, p_rule_rec.cru_name, p_rule_rec.cru_firing_items,
                    p_rule_rec.cru_fire_on_page_load, p_rule_rec.item, p_rule_rec.pl_sql, p_rule_rec.js, 
                    p_rule_rec.cra_sort_seq, p_rule_rec.cra_param_1, p_rule_rec.cra_param_2, p_rule_rec.cra_param_3, 
                    p_rule_rec.cra_on_error, p_rule_rec.cru_on_error, p_rule_rec.is_first_row,
                    -- Parameters
                    g_param.id, g_param.cgr_id, g_param.firing_item, g_param.firing_event, null,
                    to_char_table(g_param.bind_items), to_char_table(g_param.page_items), to_char_table(g_param.firing_items),
                    to_char_table(g_param.error_stack),  to_char_table(g_param.recursive_stack), g_param.is_recursive, 
                    to_ut_adc_js_list(g_param.js_action_stack), to_char_table(g_param.level_length),
                    g_param.recursive_level, adc_util.bool_to_flag(g_param.allow_recursion), g_param.notification_stack, 
                    adc_util.bool_to_flag(g_param.stop_flag), g_param.now);
    return l_test_row;
  end to_ut_adc_row;
  
  
  procedure initialize_test
  as
  begin
    null;
    if g_test_mode then
      g_test_result := ut_adc_result();
    end if;
  end initialize_test;
  
  
  procedure append_test_result(
    p_rule in rule_rec default null)
  as
    l_test_row ut_adc_row;
  begin
    null;
    if g_test_mode then      
      if p_rule.cru_id is not null then
        l_test_row := to_ut_adc_row(p_rule);
        g_test_result.rule_list.extend;
        g_test_result.rule_list(g_test_result.rule_list.count) := l_test_row;
      end if;
    end if;
  end append_test_result;
  $END
  /*============ HELPER ============*/ 

  
  /** Gets message text from PIT to integrate it as a comment into the response
   * @param  p_message_name  Message ID
   * @param [p_msg_args]     Optional message params
   * @return Message in the respective language
   * @usage  If in debug mode, this method adds descriptive messages to the response
   */
  procedure add_comment(
    p_message_name varchar2,
    p_msg_args msg_args default null)
  as
  begin
    pit.enter_detailed('add_comment',
      p_params => msg_params(msg_param('p_message_name', p_message_name)));
    
    add_javascript(pit.get_message_text(p_message_name, p_msg_args), C_JS_COMMENT);
    
    pit.leave_detailed;
  end add_comment;
  
  
  /** Method to append text to a given string, separated by C_DELIMITER
   * @param  p_text  Text to append P_WHAT to
   * @param  p_what  Text to append
   * @return Text with the appendix, delimited by C_DELIMITER
   * @usage  Is used to concatenate strings and to add line feed and indent
   */
  procedure append(
    p_text in out nocopy varchar2,
    p_what in varchar2)
  as
    c_delimiter constant varchar2(10) := adc_util.C_CR || '  ';
  begin
    pit.enter_detailed('append',
      p_params => msg_params(
                    msg_param('p_text', p_text),
                    msg_param('p_what', p_what)));
    if p_what is not null then                
    p_text := p_text || c_delimiter || replace(p_what, adc_util.C_CR, c_delimiter);
    end if;
    
    pit.leave_detailed;
  end append;
  
  
  /**  Method returns all apex actions defined for the rule group as a JavaScript install script
   * @return JavaScript script that installs the apex actions on the page
   * @usage  Is used to register apex actions defined for the rule group on the page. Called during initialization.
   */
  function get_apex_actions
    return varchar2
  as
    l_actions_js adc_util.max_char;
    l_has_actions binary_integer;  
    C_DEFAULT_ACTION constant adc_apex_actions.caa_action%type := q'^function(){de.condes.plugin.adc.executeCommand('#CAA_NAME#');}^';
  begin
    pit.enter_optional('get_apex_actions');
    
    -- excute only on initialization
    pit.assert(g_param.firing_event = C_EVENT_INITIALIZE);
    
    -- Check whether APEX actions exist
    select count(*)
      into l_has_actions
      from dual
     where exists(
           select null
             from adc_apex_action_items
            where cai_cpi_cgr_id = g_param.cgr_id);
            
    if l_has_actions = 1 then
      -- Generate initalization JavaScript for APEX actions based on UTL_TEXT templates of name APEX_ACTION
      with templates as (
           select uttm_name, uttm_mode, uttm_text, g_param.cgr_id cgr_id
             from utl_text_templates
            where uttm_type = C_PARAM_GROUP
              and uttm_name = 'APEX_ACTION')
    select utl_text.generate_text(cursor(
             select uttm_text template,
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
                      p_delimiter => ',' || chr(10) || '   '
                    ) action_list
               from templates
              where uttm_mode = C_MODE_FRAME)
           ) resultat
      into l_actions_js
      from dual;
    end if; 

    pit.leave_optional(msg_params(msg_param('APEX_ACTIONS', l_actions_js)));
    return l_actions_js;
  exception
    when msg.ASSERT_TRUE_ERR then
      return null;
  end get_apex_actions;
  
  
  /** Method retrieves conversion format mask for a given page item
   * @param  p_cpi_id ID of the page item
   * @return Conversion mask for the given item
   * @usage  If a page item is of type DATE or NUMBER, a format mask is required to convert it. As APEX allows to define
   *         format mask at several locations, this method retrieves the best matching format mask for that page item
   */
  function get_conversion(
    p_cpi_id in adc_page_items.cpi_conversion%type)
    return varchar2
  as
    l_conversion adc_page_items.cpi_conversion%type;
  begin
    pit.enter_detailed('get_conversion');
    
    select cpi_conversion
      into l_conversion
      from adc_page_items
     where cpi_id = p_cpi_id
       and cpi_cgr_id = g_param.cgr_id;
       
    pit.leave_optional(msg_params(msg_param('conversion', l_conversion)));
    return l_conversion;
  exception
    when NO_DATA_FOUND then
      /** TODO: Raise warning if format mask is missing? */
      pit.leave_optional;
      return null;
  end get_conversion;
  
   
  /** Method calculates all errors registered during rule evaluation and collects them as JSON
   * @return JSON instance for all page items referenced by the rule executed.
   * @usage  Is used to convert the list of error to a JSON structure with the following structure:
   *          {"type":"error","item":"#PAGE_ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}
   */
  function get_errors_as_json
    return varchar2
  as
    l_json adc_util.max_char;
    l_count binary_integer;
  begin
    pit.enter_optional('get_errors_as_json');
    
    l_count := g_param.error_stack.count;
    
    for i in 1 .. l_count loop
      utl_text.append(l_json, g_param.error_stack(i), C_DELIMITER, true);
    end loop;
    
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    to_char(l_count) error_count,
                    l_json json_errors
               from utl_text_templates
              where uttm_type = C_PARAM_GROUP
                and uttm_name = 'JSON_ERRORS'
                and uttm_mode = C_MODE_FRAME))
      into l_json
      from dual;
                
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_errors_as_json;
  

  /** Method to retrieve a list of elements identified by the jQuery expression passed in
   * @param  p_cpi_id   Item ID or DOCUMENT.
   * @param  p_param_2  jQuery expression that gets evaluated if P_CPI_ID is DOCUMENT
   * @return CHAR_TABLE instance with all item namens that match the jQuery expression
   * @usage  Analyses the jQuery expression and returns all items that match
   *         Possible expressions:
   *         - CSS class comma separated list of CSS classes, including .-sign
   *           Identifies page items with matching CSS elements
   *         - comma separated list of ID selectors, including #-sign
   */
  function get_firing_items(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param_2 in adc_rule_actions.cra_param_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    pit.enter_optional('get_firing_items');
    
    case 
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and trim(p_param_2) like '.%' then
      -- attribute contains jQuery CSS selector, search page items with corresponding CSS
        with params as(
             select apex_application.g_flow_id application_id,
                    apex_application.g_flow_step_id page_id,
                    replace(column_value, '.') css
               from table(utl_text.string_to_table(p_param_2, ',')))
      select /*+ NO_MERGE (params) */
             cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
     natural join params
       where (html_form_element_css_classes is not null
         and instr(html_form_element_css_classes || ' ', params.css || ' ') > 0)
          or (item_css_classes is not null 
         and instr(item_css_classes || ' ', params.css || ' ') > 0);

    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and trim(p_param_2) like '#%' then
      -- attribute is list of jQuery ID selectors. Find actions with matching ID
      select cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
       where application_id = apex_application.g_flow_id
         and page_id = apex_application.g_flow_step_id
         and instr(p_param_2 || ',', '#' || item_name || ',') > 0;
    else
      l_item_list := null;
    end case;
    
    pit.leave_optional;
    return l_item_list;
  end get_firing_items;
  

  /** Method calculates all items which are referenced by the rules executed and collects them as JSON
   * %param  p_item_list  List of items to convert to JSON 
   * @return JSON instance for all page items referenced by the rule executed.
   *         Structure: [{"id":"#ID#","value":"#VALUE#"}, ...]
   */  
  function get_items_as_json(
    p_item_list item_stack_t)
    return varchar2
  as
    l_json adc_util.max_char;
    l_item varchar2(50);
  begin
    pit.enter_optional('get_items_as_json');
    
    l_item := p_item_list.first;
    while l_item is not null loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(C_PAGE_JSON_ELEMENT, char_table(
          'ID', l_item,
          'VALUE', case l_item when 'COMMAND' then get_event_data(null) else htf.escape_sc(get_string(l_item)) end)),
        C_DELIMITER, true);
      l_item := p_item_list.next(l_item);
    end loop;
    
    l_json := replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json);
    
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_items_as_json;
  
  
  /** Helper method to retrieve a list of session state values for a comma delimited item list
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
    l_filter := replace(replace(p_cpi_list, ' '), ',', ''',''');
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
    l_length binary_integer := 1;
    l_max_level binary_integer := 0;
  begin
    pit.enter_optional('get_java_script');
                  
    -- add APEX actions, if existing
    append(l_js, get_apex_actions);
                        
    -- process rule javascript from stack
    if g_param.js_action_stack.count > 0 then
      -- Measure total char length of every level on stack and limit length to 32K max by emitting levels top down
      -- until length is below that barrier
      for i in 1 .. g_param.level_length.count loop
        if g_param.level_length.exists(i) then
          l_length := l_length + g_param.level_length(i);
          if l_length > C_MAX_LENGTH then
            append(l_js, pit.get_message_text(msg.ADC_OUTPUT_REDUCED, msg_args(to_char(l_max_level))));
            exit;
          end if;
          l_max_level := i;
        end if;
      end loop;
      
      -- collect all javascript chunks
      for i in 1 .. g_param.js_action_stack.count + 1 loop
        if g_param.js_action_stack.exists(i) then
          -- avoid buffer overflow and surpress comments if required
          if coalesce(length(l_js), 0) + length(g_param.js_action_stack(i).script) <= C_MAX_LENGTH 
             and coalesce(g_param.js_action_stack(i).debug_level, C_JS_CODE) <= l_max_level
          then
            append(l_js, g_param.js_action_stack(i).script);
          else
            append(l_js, pit.get_message_text(msg.ADC_OUTPUT_CLIPPED));
            exit; 
          end if;
        end if;
      end loop;
    end if;
    
    -- wrap JavaScript in <script> tag and add item value and error scripts
    -- Replace script explicitely to circumvent length limitation of CHAR_TABLE
    l_js := replace(C_JS_SCRIPT_FRAME, '#SCRIPT#', l_js);
    
    l_js := utl_text.bulk_replace(l_js, char_table(
              'ID', 'S_' || trunc(dbms_random.value * 10000000),
              'CR', adc_util.C_CR,
              'ITEM_JSON', get_items_as_json(g_param.page_items),
              'ERROR_JSON',  get_errors_as_json,
              'FIRING_ITEMS', get_items_as_json(g_param.firing_items),
              'JS_FILE', C_JS_NAMESPACE,
              'DURATION', to_char(dbms_utility.get_time - g_param.now)));
              
    l_js := replace(l_js, adc_util.C_HASH, '#');
    
    pit.leave_optional(msg_params(msg_param('JavaScript', l_js)));
    return l_js;
  end get_java_script;
  
  
  /** Helper method to create comments in JavaScript to indicate the rule details the script originates from
   * and other useful information such as the recursive depth an exception handler and so forth.
   * @param  p_rule  Rule record of the active rule
   */
  procedure get_java_script_comments(
    p_rule in rule_rec)
  as
    l_origin_msg varchar2(1000);
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_optional('get_java_script_comments');
    
    -- first line, add origin message
    if p_rule.is_first_row = adc_util.C_TRUE then
      l_actual_recursive_level := g_param.recursive_level - 1;
      
      if not g_has_errors then
        -- normal execution, add message
        if p_rule.cru_fire_on_page_load = adc_util.C_TRUE then
          l_origin_msg := msg.ADC_INIT_ORIGIN;
        else
          l_origin_msg := msg.ADC_RULE_ORIGIN;
        end if;
        add_javascript(
          p_java_script => pit.get_message_text(
                             p_message_name => l_origin_msg, 
                             p_msg_args => msg_args(
                                             to_char(l_actual_recursive_level), 
                                             to_char(p_rule.cru_sort_seq), 
                                             convert(p_rule.cru_name, 'WE8ISO8859P1'), 
                                             g_param.firing_item)),
          p_debug_level => C_JS_RULE_ORIGIN);
      else
        -- exception occurred, pass message
        add_comment(
          p_message_name => msg.ADC_ERROR_HANDLING, 
          p_msg_args => msg_args(
                          to_char(l_actual_recursive_level), 
                          to_char(p_rule.cru_sort_seq), 
                          convert(p_rule.cru_name, 'WE8ISO8859P1'), 
                          g_param.firing_item));
      end if;
    end if;

    pit.leave_optional;
  end get_java_script_comments;
  
  
  /** Method to retrieve a default value for a mandatory page item
   * @param  p_cpi_id  ID of the page item
   * @return Default value for that page item
   * @usage  Is used to retrieve the default value if a mandatory item is NULL and  a default value was defined.
   */
  function get_mandatory_default_value(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_default adc_page_items.cpi_item_default%type;
  begin
    pit.enter_optional('get_mandatory_default_value',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    select cpi_item_default
      into l_default
      from adc_page_items
     where cpi_is_mandatory = adc_util.c_true
       and cpi_id = p_cpi_id
       and cpi_cgr_id = g_param.cgr_id;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', l_default)));
    return l_default;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional;
      return null;
  end get_mandatory_default_value;
  
  
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
    l_mandatory_message adc_page_items.cpi_mandatory_message%type;
  begin
    pit.enter_optional('get_mandatory_message',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    select pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY, msg_args(cpi_label))
      into l_mandatory_message
      from adc_page_items
     where cpi_id = p_cpi_id
       and cpi_cgr_id = g_param.cgr_id;
    
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
  

  /** Helper to analyze an attribute
   * @param  p_cpi_id  Name of the referenced item or adc_uit.C_NO_FIRING_ITEM
   * @param  p_param   Attribute value to analyze
   * @return result of the analysis, either static or dynamic 
   * @usage  Used to evaluate an attribute. The following syntactical possibilities exist:
   *         - jQuery CSS selector
   *         - jQuery ID selector
   *         - static string, encapsulated in single quotes
   *         - PL/SQL-Block without single quotes, with or without terminating semicolon
   */
  function analyze_parameter(
    p_cpi_id in varchar2,
    p_replacement in varchar2,
    p_selector in varchar2,
    p_param in adc_rule_actions.cra_param_2%type)
    return varchar2
  as
    C_CMD constant varchar2(100) := 'begin :x := #CMD#; end;';
    l_result adc_util.max_char := p_param;
  begin
    pit.enter_detailed('analyze_parameter',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_replacement', p_replacement),
                    msg_param('p_selector', p_selector),
                    msg_param('p_param', p_param)));
                    
    if p_cpi_id = adc_util.C_NO_FIRING_ITEM then
      if p_param is not null and instr(p_replacement, p_selector) > 0 then 
        case substr(p_param, 1, 1)
          when '.' then null;
          when '#' then null;
          when '''' then l_result := trim('''' from p_param);
          else execute immediate replace(C_CMD, '#CMD#', trim(';' from p_param)) using out l_result;
        end case;
      else
        l_result := p_param;
      end if;
    else
      l_result := p_cpi_id;
    end if;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  end analyze_parameter;
  
  
  /** Method to format a firing item
   * @usage  Analyzes, whether the firing item has got a conversion mask. If so, ...
   *        - it tries to convert it and catches any conversion errors
   *        - it converts the item value and stores a formatted version in the session state
   */
  procedure format_firing_item
  as
    l_cpi_cit_id adc_page_items.cpi_cit_id%type;
    l_cpi_conversion adc_page_items.cpi_conversion%type;
    l_number_val number;
    l_date_val date;
    l_string_val adc_util.max_char;
  begin
    pit.enter_detailed('format_firing_item');
    
    -- get the format mask for the firing item
    select cpi_cit_id, cpi_conversion
      into l_cpi_cit_id, l_cpi_conversion
      from adc_page_items
     where cpi_cgr_id = g_param.cgr_id
       and cpi_id = g_param.firing_item
       and cpi_cit_id in ('ITEM', 'APP_ITEM');
    
    case l_cpi_cit_id
      when C_NUMBER_ITEM then
        -- convert to number
        l_number_val := get_number(g_param.firing_item, l_cpi_conversion, adc_util.C_FALSE);        
        -- conversion successful, set formatted string in session state
        set_session_state(g_param.firing_item, coalesce(to_char(l_number_val, l_cpi_conversion), get_string(g_param.firing_item)), adc_util.C_TRUE, null);
      when C_DATE_ITEM then
        -- convert to date
        l_date_val := get_date(g_param.firing_item, l_cpi_conversion, adc_util.C_FALSE);
        -- conversion successful, set formatted string in session state
        set_session_state(g_param.firing_item, coalesce(to_char(l_date_val, l_cpi_conversion), get_string(g_param.firing_item)), adc_util.C_TRUE, null);
      else
        l_string_val := get_string(g_param.firing_item);
    end case;
    
    pit.leave_detailed;
  exception
    when NO_DATA_FOUND then
      -- no session state value, ignore.
      pit.leave_detailed;
  end format_firing_item;


  /** Method to determine whether rule execution has to be checked for recursive allowance. 
   * This is not checked during initialization for rules that are set to FIRE_ON_PAGE_LOAD.
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @return Flag to indicate whether a recursion has to be checked or not
   * @usage  Normally, any rule is checked whether it is allowed to execute it recursively. A rule that is set to 
   *         FIRE_ON_PAGE_LOAD is an exception in this regard, if the page is in initialization process.
   *         Whether this is true for the actual rule is checked within this method.
   */
  function check_recursion(
    p_rule in rule_rec)
    return adc_util.flag_type
  as
    sResult adc_util.flag_type;
  begin
    pit.enter_detailed('check_recursion',
      p_params => msg_params(
                    msg_param('p_rule.item', p_rule.item),
                    msg_param('p_rule.cru_fire_on_page_load', to_char(p_rule.cru_fire_on_page_load))));
    
    case when p_rule.item = adc_util.C_NO_FIRING_ITEM and p_rule.cru_fire_on_page_load = adc_util.C_TRUE
      then sResult := adc_util.C_FALSE;
      else sResult := adc_util.C_TRUE;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Result', to_char(sResult))));
    return sResult;
  end check_recursion;
  

  /** Method to prepare JavaScript contained in a rule action for execution
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @usage  Is used to collect JavaScript code that is included in the rule actions.
   *         Before the JavaScript code can be collected, all arguments need to be replaced. This is done in this method.
   */
  procedure handle_js_code(
    p_rule in rule_rec)
  as
    C_JS_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~apex.item('#ITEM#').getValue()~';
    l_js_code adc_util.max_char;

  begin
    pit.enter_optional('handle_js_code',
      p_params => msg_params(
                    msg_param('p_rule.js', p_rule.js),
                    msg_param('p_rule.cra_param_1', p_rule.cra_param_1),
                    msg_param('p_rule.cra_param_2', p_rule.cra_param_2),
                    msg_param('p_rule.cra_param_3', p_rule.cra_param_3),
                    msg_param('p_rule.item', p_rule.item)));
    
    get_java_script_comments(p_rule);

    -- Extract JavaScript chunk, replace parameters and register with response
    if p_rule.js is not null then
      l_js_code := utl_text.bulk_replace(p_rule.js, char_table(
                     'JS_FILE', C_JS_NAMESPACE,
                     'ITEM_VALUE', C_JS_ITEM_VALUE_TEMPLATE,
                     'ITEM', p_rule.item,
                     'SELECTOR', analyze_parameter(p_rule.item, l_js_code, '#SELECTOR#', p_rule.cra_param_2),
                     'PARAM_1', p_rule.cra_param_1,
                     'PARAM_2', p_rule.cra_param_2,
                     'PARAM_3', p_rule.cra_param_3,
                     'CRU_SORT_SEQ', case when p_rule.cru_sort_seq is not null then 'RULE_' || p_rule.cru_sort_seq else 'NO_RULE_FOUND' end,
                     'CRU_NAME', convert(p_rule.cru_name, 'WE8ISO8859P1'),
                     'FIRING_ITEM', g_param.firing_item,
                     'CR', adc_util.C_CR));
      add_javascript(l_js_code, C_JS_CODE);
    end if;
    
    pit.leave_optional;
  end handle_js_code;
  

  /** Helper to execute PL/SQL code
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @usage  Is used to immediately execute PL/SQL code that is included in the rule actions.
   *         The method prepares the PL/SQL code by replacing the parameter anchors and executes it. If an error occurs,
   *         this is registered with ADC and the execution is stopped.
   */
  procedure handle_plsql_code(
    p_rule in out nocopy rule_rec)
  as
    C_PLSQL_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~v('#ITEM#')~';
    l_plsql_code adc_util.max_char;
  begin
    pit.enter_optional('handle_plsql_code',
      p_params => msg_params(
                    msg_param('p_rule.pl_sql', p_rule.pl_sql),
                    msg_param('p_rule.cra_param_1', p_rule.cra_param_1),
                    msg_param('p_rule.cra_param_2', p_rule.cra_param_2),
                    msg_param('p_rule.cra_param_3', p_rule.cra_param_3),
                    msg_param('p_rule.item', p_rule.item)));
                    
    -- create PL/QSL code from template
    if p_rule.pl_sql is not null then
      l_plsql_code := utl_text.bulk_replace(trim(';' from p_rule.pl_sql), char_table(
                        'PARAM_1', coalesce(p_rule.cra_param_1, 'null'),
                        'PARAM_2', p_rule.cra_param_2,
                        'PARAM_3', p_rule.cra_param_3,
                        'ALLOW_RECURSION', check_recursion(p_rule),
                        'ITEM_VALUE', C_PLSQL_ITEM_VALUE_TEMPLATE,
                        'ITEM', p_rule.item,
                        'CR', adc_util.C_CR));
                        
      -- Don't remove COMMIT from the code template. As this code is called using AJAX, no transaction control
      -- from APEX exists, so we need to control it ourselves.
      l_plsql_code := replace('begin #CODE#; commit; end;', '#CODE#', l_plsql_code);
      
      pit.verbose(msg.PIT_PASS_MESSAGE, msg_args('PL/SQL-Code: ' || l_plsql_code));

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Stop further execution for non exception handlers
          p_rule.cru_on_error := adc_util.C_TRUE;
          -- Display error
          pit.handle_exception(msg.ADC_UNHANDLED_EXCEPTION, msg_args(l_plsql_code));
          register_error(p_rule.item, msg.ADC_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          stop_rule;
      end;
      l_plsql_code := null;
    end if;
    
    pit.leave_optional;
  end handle_plsql_code;
  
  
  /** Method calculates the answer for a given situation in the session state based on the ADC rules for the active page.
   * @usage  Is called from PROCESS_RULE. This method selects the applicable rule for the actual situation and executes it
   */
  procedure create_action
  as
    l_rule rule_rec;
    l_action_cur sys_refcursor;
    l_stmt adc_util.max_char;
    l_now binary_integer;
    l_has_js boolean default false;
  begin
    pit.enter_mandatory('create_action');

    -- Initialization
    g_has_errors := false;
    l_now := dbms_utility.get_time;
    
    -- Prepare rule SQL
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    cgr_decision_table,
                    g_param.is_recursive is_recursive
               from utl_text_templates
              where uttm_type = C_PARAM_GROUP
                and uttm_name = 'RULE_STMT'
                and uttm_mode = C_MODE_DEFAULT))
      into l_stmt
      from adc_rule_groups
     where cgr_id = g_param.cgr_id;
    pit.verbose(msg.ADC_DEBUG_RULE_STMT, msg_args(l_stmt));
    
    -- Calculate the rule actions. Explicit cursor control because of dynamic SQL
    open l_action_cur for l_stmt;
    
    -- Fetching a row from the cursor evaluates which rule to execute and returns all actions of that rule
    -- During executiion, conversion of date and number fields apply. This may throw errors if an invalid 
    -- value is passed in
    fetch l_action_cur into l_rule;
    pit.verbose(msg.ADC_PROCESSING_RULE, msg_args(to_char(l_rule.cru_sort_seq), l_rule.cru_name));
    
    -- Process rule actions
    while l_action_cur%FOUND loop
      $IF adc_util.C_WITH_UNIT_TESTS $THEN
      append_test_result(l_rule);
      $END
      case when ((l_rule.cru_on_error = adc_util.C_FALSE or not g_has_errors) 
            and l_rule.cra_on_error = adc_util.C_FALSE) 
             or (l_rule.cra_on_error = adc_util.C_TRUE and g_has_errors) then
             -- Normal execution. This is true in three possible cases:
             -- 1: No exception occurred
             -- 2: Rule is set to ignore exceptions
             -- 3: Exception occurred and action is an exception handler
        -- calculate and execute PL/SQL code
        handle_plsql_code(l_rule);
        -- collect JavaScript code
        handle_js_code(l_rule);
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        null;
      end case;
      
      -- get next action
      fetch l_action_cur into l_rule;
    end loop;
    close l_action_cur;
    
    -- Add time measurement and collected notification messages to origin comments
    for i in 1 .. g_param.js_action_stack.count loop
      case when g_param.js_action_stack(i).debug_level = C_JS_RULE_ORIGIN then
        utl_text.bulk_replace(g_param.js_action_stack(i).script, char_table(
          'NOTIFICATION', g_param.notification_stack,
          'TIME', coalesce(dbms_utility.get_time - l_now, 0) || 'hsec'));
      when g_param.js_action_stack(i).debug_level = C_JS_CODE then
        l_has_js := true;
      else
        null;
      end case;
    end loop;
    
    if not l_has_js then
      -- No JavaScript found, notify if set to verbose
      add_comment(
        p_message_name => msg.ADC_NO_JAVASCRIPT, 
        p_msg_args => msg_args(l_rule.cru_name));
    end if;
    
    pit.leave_mandatory;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR or VALUE_ERROR or INVALID_NUMBER then
      -- Conversion errors where thrown, stop execution
      close l_action_cur;
      pit.handle_exception;
    when others then
      close l_action_cur;
      pit.handle_exception(msg.SQL_ERROR, msg_args(l_stmt));
  end create_action;
  

  /** Method pushes a page item onto the firing item stack.
   * %param  p_cpi_id  ID of the page item to push onto the stack
   * %usage  ADC maintains a list of all items that fired events.
   */  
  procedure push_firing_item(
    p_cpi_id in varchar2)
  as
    l_item varchar2(1000 char);
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
    
    if p_cpi_id is not null then
      for i in 1 .. regexp_count(p_cpi_id, C_DELIMITER) + 1 loop
        l_item := regexp_substr(p_cpi_id, '[^\' || C_DELIMITER || ']+', 1, i);
        if l_item is not null and not g_param.firing_items.exists(l_item) then
          g_param.firing_items(l_item) := 1;
        end if;
      end loop;
    end if;
    
    pit.leave_detailed;
  end push_firing_item;
  
    
  /** Method analyzes the requested rule of the rule group
   * @return HTML script element with a JavaScript code containing the answer of the rule
   * @usage  is called if a rule has to be executed
   *         - Create a JavaScript script to execute on the page
   *         - analyzes whether changes the rule initiates causes other rules to be recursively called
   */
  procedure process_rule
  as
    l_has_recursive_request boolean := false;
    l_processed_item adc_page_items.cpi_id%type;
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_optional('process_rule');
    
    -- Initialization
    l_actual_recursive_level := g_param.recursive_level;
    
    -- increments recursion level for »breadth first« execution: First execute all rules on active level before dealing with
    -- recursively called rules
    g_param.recursive_level := l_actual_recursive_level + 1;
    
    -- is_recursive flag indicates whether actually we're in a recursive run or not. Used to exclude rules or actions 
    -- which are not eligible for recursive execution
    g_param.is_recursive := case l_actual_recursive_level when 1 then adc_util.C_FALSE else adc_util.C_TRUE end;
    
    -- iterate over recursion stack
    g_param.firing_item := g_param.recursive_stack.first;

    while g_param.firing_item is not null loop
      begin

        -- Check in any case if the triggering element is a mandatory field
        check_mandatory(g_param.firing_item);
        
        --  raise all »events« on active recursion level
        if g_param.recursive_stack(g_param.firing_item) = l_actual_recursive_level then
          -- save item to pop it from the recursion stack later
          l_processed_item := g_param.firing_item;
          l_has_recursive_request := true;
          g_param.notification_stack := null;
          
          -- calculate action based on selected rule. Will immediately execute PL/SQL code and collect JavaScript as a response
          create_action;
          
          -- save processed item to firing item stack. Is used to harmonize its value with the page
          push_firing_item(l_processed_item);
        end if;
        
        -- process next element
        g_param.firing_item := g_param.recursive_stack.next(g_param.firing_item);
        
        -- Administer recursive stack
        case when g_param.stop_flag then
          g_param.recursive_stack.delete;
          exit;
        when l_processed_item is not null then
          -- pop processed element from recursion stack
          g_param.recursive_stack.delete(l_processed_item);
        else
          null;
        end case;
      exception
        when others then
          register_error(l_processed_item, msg.ADC_INTERNAL_ERROR);
          g_param.recursive_stack.delete;
          pit.handle_exception(msg.ADC_INTERNAL_ERROR, msg_args(substr(sqlerrm, 12)));
          exit;
      end;
    end loop;
    
    -- Recursively process all entries on call stack
    if l_has_recursive_request then
      process_rule;
    end if;
    
    pit.leave_optional;
  end process_rule;
  
  
  /** Method pushes a page item onto the page item stack.
   * @param  p_cpi_id  Name of the page item to push onto the stack
   * @usage  ADC maintains a list of page item it has worked on during the active rule evaluation. This is required to
   *         pass all possibly changed item values back to the browser
   */
  procedure push_page_item(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
    
    if not g_param.page_items.exists(p_cpi_id) then
      g_param.page_items(p_cpi_id) := 1;
    end if;
    
    pit.leave_detailed;
  end push_page_item;
  
  
  function get_mandatory_default(
    p_cpi_id in varchar2)
    return varchar2
  as
    l_default adc_page_items.cpi_item_default%type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));

    select cpi_item_default
      into l_default
      from adc_page_items
     where cpi_id = p_cpi_id
       and cpi_cgr_id = g_param.cgr_id;

    if l_default is not null then
      execute immediate 'begin :x := ' || coalesce(rtrim(l_default, ';'), 'null') || '; end;' using out l_default;
    end if;
    
    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('Default value, normal execution', l_default)));
    return l_default;
  exception
    when NO_DATA_FOUND then
      pit.leave_mandatory;
      return null;
    when others then
      -- Execute immediate did not work but a value was present, so return this.
      pit.leave_mandatory(
        p_params => msg_params(
                      msg_param('Default value, exception occurred', l_default)));
      return l_default;
  end get_mandatory_default;
  
  
  function check_data_type(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_cit_id adc_page_item_types.cit_id%type;
    l_string_value adc_util.max_char;
  begin
    pit.enter_optional('check_data_type',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
    
    select cpi_cit_id
      into l_cit_id
      from adc_page_items
     where cpi_id = p_cpi_id
       and instr(cpi_cit_id, 'ITEM') > 0
       and cpi_cgr_id = g_param.cgr_id;
     
    case l_cit_id
      when 'DATE_ITEM' then
        l_string_value := to_char(get_date(p_cpi_id, null, adc_util.C_FALSE));
      when 'NUMBER_ITEM' then
        l_string_value := to_char(get_number(p_cpi_id, null, adc_util.C_FALSE));
      else
        null;
    end case;
    
    l_string_value := utl_apex.get_string(p_cpi_id);
    
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
  
  
  procedure check_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    l_message adc_page_items.cpi_mandatory_message%type;
    l_item_value adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
       
    if p_cpi_id != adc_util.C_NO_FIRING_ITEM then
      -- Try to read session value to detect data type errors
      l_item_value := check_data_type(p_cpi_id);
      l_item_value := trim(coalesce(l_item_value, get_mandatory_default(p_cpi_id)));
                          
      select coalesce(srs_cpi_mandatory_message, to_char(pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY)))
        into l_message
        from adc_rule_group_status
       where collection_name = g_param.collection_name
         and srs_cpi_id = p_cpi_id;
         
      if l_item_value is not null then
        -- Mandatory field has a value, register to remove possible error message
        pit.verbose(msg.PIT_PASS_MESSAGE, msg_args('Value: "' || l_item_value || '"'));
        push_firing_item(g_param.firing_item);
      else
        register_error(g_param.firing_item, l_message, '');
      end if;
    end if;
      
    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      -- not mandatory, ignore
      pit.leave_mandatory;
    when too_many_rows then 
      htp.p(substr(sqlerrm, 12));
      pit.leave_mandatory;
  end check_mandatory;
  
  
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
  

  /** Method to register items which have changed their value in the session state. If recursion is set to true, those elements
   *  will cause ADC to evaluate rules for that element by imitating that an event has thrown on that element.
   * %param  p_cpi_id             ID of the page item to register
   * %param [p_allow_recursion] Flag to indicate whether this element is allowed to cause a recursive ADC rule call
   * %usage  Is used to register page items that changed their value because of code executed in ADC. List is used to ...
   *         - Return the changed value to the browser to harmonize the UI with the session state
   *         - Have ADC evaluate any rules that fire based on the new value. This is true only if P_ALLOW_RECURSION is true.
   *         - Remove any error from the page that reference this item. If the error still exists, it must be part of the answer
   */
  procedure register_item(
    p_cpi_id in varchar2,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    l_has_rule number;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id), 
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));
                    
    -- Register item to assure that the changed value is return to the browser
    push_page_item(p_cpi_id);
    
    if p_allow_recursion = adc_util.C_TRUE then
      -- If page item that is worked upon is referenced in rules, register recursive call for this page item
      select count(*)
        into l_has_rule
        from dual
       where exists(
             select 1
               from adc_page_items
              where cpi_id = p_cpi_id     
                -- Element ist relevant  
                and cpi_is_required = adc_util.C_TRUE
                -- und ruft sich nicht selbst auf
                and p_cpi_id != coalesce(g_param.firing_item, 'FOO'));
                
      if l_has_rule > 0 then   
        if g_param.recursive_level <= g_recursion_limit then
          if not g_param.recursive_stack.exists(p_cpi_id) then
            -- push element on recursive stack to evalualte its rule in the next recursion
            g_param.recursive_stack(p_cpi_id) := g_param.recursive_level;
          else
            -- Recursion loop occurred, cancel or notify
            if g_recursion_loop_is_error then
              register_error(p_cpi_id, msg.ADC_RECURSION_LOOP, msg_args(p_cpi_id, to_char(g_param.recursive_level)));
            else
              notify(pit.get_message_text(msg.ADC_RECURSION_LOOP, msg_args(p_cpi_id, to_char(g_param.recursive_level))));
            end if;
          end if;
        else
          -- max recursion level exceeded, cancel and throw error
          register_error(p_cpi_id, msg.ADC_RECURSION_LIMIT, msg_args(p_cpi_id, to_char(g_recursion_limit)));
        end if;
      end if;
    end if;
    pit.leave_detailed;
  end register_item;  
  
    
  procedure initialize
  as
  begin
    g_recursion_loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
    g_param.collection_name := param.get_string('COLLECTION_NAME', C_PARAM_GROUP);
  end initialize;


  /*============ INTERFACE ============*/  
  /** PLUGIN FUNCTIONALITY */
  procedure add_javascript(
    p_java_script in varchar2,
    p_debug_level in binary_integer default C_JS_CODE)
  as
    C_COMMENT_OUT constant varchar2(20) := '// (double) ';
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
          if g_param.js_action_stack(i).debug_level = C_JS_CODE and g_param.js_action_stack(i).hash = l_js.hash then
            g_param.js_action_stack(i).script := C_COMMENT_OUT || g_param.js_action_stack(i).script;
            g_param.js_action_stack(i).hash := null;
            g_param.js_action_stack(i).debug_level := C_JS_DEBUG;
          end if;
        end if;
      end loop;
      
      -- persist JavaScript action
      g_param.js_action_stack(l_next_entry) := l_js;
      
      -- Caculate length of comments and scripts
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
    when g_param.event_data in ('true', 'false') or g_param.event_data is  null then
      return null;
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
        ',', true);
      -- register relevant items with session state to make sure that their actual value is harmonized with the page
      -- (this task is served by REGISTER_ITEM after initialization)
      if item.cit_has_value = adc_util.c_true then
        push_page_item(item.cpi_id);
      end if;
    end loop;
    
    -- Create items with '~' as a replacement for '"' to prevent APEX from escaping it with an escape sequence.
    -- This assures that the browser is able to create a JavaScript object from it
    l_json := replace(replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json), '"', '~');
    
    pit.leave_optional;
    return l_json;
  end get_bind_items_as_json; 
  
  
  function get_string(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_value session_value_rec;
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
    
    if not g_session_values.exists(p_cpi_id) then
      l_value.string_value := coalesce(v(p_cpi_id), get_mandatory_default_value(p_cpi_id));
      g_session_values(p_cpi_id) := l_value;
    end if;
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
    return g_session_values(p_cpi_id).string_value;
  end get_string;
    
    
  function get_date(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_TRUE)
    return date
  as
    l_format_mask adc_util.ora_name_type;
    l_value session_value_rec;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', p_throw_error)));
                    
    if not g_session_values.exists(p_cpi_id) then
  
      /** TODO: Umbauen auf VALIDATE_CONVERSION, falls 12.2 vorausgesetzt werden kann und die Bugs hierzu behoben sind */
      l_value.string_value := get_string(p_cpi_id);
      if l_value.string_value is not null then
        l_format_mask := coalesce(p_format_mask, get_conversion(p_cpi_id), utl_apex.get_default_date_format);
        l_value.date_value := to_date(l_value.string_value, l_format_mask);
      end if;
    end if;
      
    pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
    return g_session_values(p_cpi_id).date_value;
  exception
    when msg.INVALID_DATE_ERR then
      register_error(p_cpi_id, msg.INVALID_DATE, msg_args(l_value.string_value, p_format_mask));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
    when msg.INVALID_DATE_FORMAT_ERR then
      register_error(p_cpi_id, msg.INVALID_DATE_FORMAT, msg_args(l_value.string_value, p_format_mask));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
    when msg.INVALID_YEAR_ERR or msg.INVALID_MONTH_ERR or msg.INVALID_DAY_ERR then
      register_error(p_cpi_id, msg.INVALID_YEAR, msg_args(substr(sqlerrm, 12)));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
    when others then
      register_error(p_cpi_id, msg.INVALID_DATE_FORMAT, msg_args(substr(sqlerrm, 12)));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
  end get_date;
  
  
  function get_number(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.c_false)
    return number
  as
    l_value session_value_rec;
    l_format_mask adc_util.ora_name_type;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', to_char(p_throw_error))));
    
    if not g_session_values.exists(p_cpi_id) then
      l_value.string_value := get_string(p_cpi_id);
      if l_value.string_value is not null then
        l_value.string_value := rtrim(ltrim(l_value.string_value, ', '));
        l_format_mask := replace(coalesce(p_format_mask, get_conversion(p_cpi_id), '99999999999999D9999999'), 'G');
        l_value.number_value := to_number(l_value.string_value, l_format_mask);
      end if;
    end if;
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
    return l_value.number_value;
  exception
    when msg.INVALID_NUMBER_FORMAT_ERR then
      register_error(p_cpi_id, msg.INVALID_NUMBER_FORMAT, msg_args(l_value.string_value, p_format_mask));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
    when INVALID_NUMBER or VALUE_ERROR then
      register_error(p_cpi_id, msg.ADC_INVALID_NUMBER_REMOVED, msg_args(l_value.string_value));
      if p_throw_error = adc_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', l_value.string_value)));
      return null;
    when others then
      register_error(p_cpi_id, msg.SQL_ERROR, msg_args(substr(sqlerrm, 12)));
  end get_number;


  function get_page_items
    return varchar2
  as
    l_item adc_util.ora_name_type;
    l_page_items adc_util.max_char;
  begin
    pit.enter_optional;
    
    -- concatenate list
    l_item := g_param.page_items.first;
    while l_item is not null loop
      l_page_items := l_page_items || C_DELIMITER || l_item;
      l_item := g_param.page_items.next(l_item);
    end loop;
    
    
    pit.leave_optional;
    return trim(C_DELIMITER from l_page_items);
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
  begin      
    pit.enter_optional;
    
      process_rule;
      
      l_js_script := get_java_script;
      
      -- reset session value cache
      g_session_values.delete;
      
    pit.leave_optional(
      p_params => msg_params(msg_param('JavaScript', l_js_script)));
    return l_js_script;
  end process_request;
  
  
  procedure push_error(
    p_error in apex_error.t_error)
  as
    l_error apex_error.t_error;
    l_error_json adc_util.max_char;
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
      
    g_param.error_stack(g_param.error_stack.count + 1) := l_error_json;
    g_has_errors := true;
    
    pit.leave_optional;
  end push_error;
  
  
  procedure create_initial_rule_group(
    p_rule_group_row in out nocopy adc_rule_groups%rowtype)
  as
    l_rule_row adc_rules%rowtype;
  begin 
    -- Rule does not yet exist, create
    adc_admin.merge_rule_group(p_rule_group_row);
    l_rule_row.cru_cgr_id := p_rule_group_row.cgr_id;
    l_rule_row.cru_name := 'die Seite öffnet';
    l_rule_row.cru_condition := 'initializing = c_true';
    l_rule_row.cru_sort_seq := 10;
    l_rule_row.cru_active := adc_util.c_true;
    l_rule_row.cru_fire_on_page_load := adc_util.c_false;
    adc_admin.merge_rule(l_rule_row);
  end create_initial_rule_group;
  

  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2)
  as
    l_allow_recursion adc_util.flag_type;
    l_rule_group_row adc_rule_groups%rowtype;
    l_rule_row adc_rules%rowtype;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_firing_item', p_firing_item),
                    msg_param('p_event', p_event),
                    msg_param('p_event_data', p_event_data)));
                    
    l_rule_group_row.cgr_app_id := utl_apex.get_application_id;
    l_rule_group_row.cgr_page_id := utl_apex.get_page_id;
    
    -- Read rule group
    select cgr_id, coalesce(cgr_with_recursion, adc_util.C_TRUE)
      into g_param.cgr_id, l_allow_recursion
      from adc_rule_groups
     where cgr_app_id = l_rule_group_row.cgr_app_id
       and cgr_page_id = l_rule_group_row.cgr_page_id;
    
    -- set recursion flag
    g_param.allow_recursion := l_allow_recursion = adc_util.C_TRUE;
        
    -- Initialize collections
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param.js_action_stack.delete;
    g_param.level_length(C_JS_CODE) := 0;
    g_param.level_length(C_JS_RULE_ORIGIN) := 0;
    g_param.level_length(C_JS_DEBUG) := 0;
    g_param.level_length(C_JS_COMMENT) := 0;
    g_param.firing_item := coalesce(p_firing_item, adc_util.C_NO_FIRING_ITEM);
    g_param.firing_event := coalesce(p_event, adc_util.C_INITIALIZE_EVENT);
    g_param.event_data := p_event_data;
    g_param.recursive_level := 1;
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := false;
    g_param.collection_name := C_COLLECTION_NAME || g_param.cgr_id;
    g_session_values.delete;
    
    format_firing_item;
    
    -- Register FIRING_ELEMENT on recursion level 1
    g_param.recursive_stack(g_param.firing_item) := g_param.recursive_level;
    
    pit.leave_optional;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR then
      -- If conversion is impossible, this is not an issue during installation.
      g_param.error_stack.delete;
      pit.leave_optional;
    when NO_DATA_FOUND then
      create_initial_rule_group(l_rule_group_row);
      read_settings(p_firing_item, p_event, p_event_data);
  end read_settings;
    
    
  /*============ ADC FUNCTIONALITY ============*/
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
                            'PARAM_1', p_param_1,
                            'PARAM_2', p_param_2,
                            'PARAM_3', p_param_3));
      execute immediate l_row.cat_pl_sql;
    end if;

    if l_row.cat_js is not null then
      l_java_script := utl_text.bulk_replace(l_row.cat_js, char_table(
                         'ITEM', p_cpi_id,
                         'SELECTOR', analyze_parameter(p_cpi_id, l_row.cat_js, '#SELECTOR#', p_param_2),
                         'PARAM_1', p_param_1,
                         'PARAM_2', p_param_2,
                         'PARAM_3', p_param_3));
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
    l_value_counter adc_util.flag_type := -1;
    l_result adc_util.flag_type;
    l_page_values char_table;
    cursor val_cur(p_value_list in char_table) is
      select column_value cpi_value
        from table(p_value_list);
  begin
    -- Tracing done in ADC_API    
    get_item_values_as_char_table(p_value_list, l_page_values);
    if p_value_list is not null then
      for v in val_cur(l_page_values) loop
        if v.cpi_value is not null then
          l_value_counter := l_value_counter + 1;
        end if;
        exit when l_value_counter > 1;
      end loop;
    end if;
    l_result := case l_value_counter
                when -1 then null
                when 0 then adc_util.C_TRUE
                else adc_util.C_FALSE end;
                
    return l_result;
  end exclusive_or;
    
    
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
    l_result number := adc_util.C_FALSE;
    l_value_list char_table;
    cursor val_cur(p_value_list in char_table) is
      select column_value cpi_value
        from table(p_value_list);
  begin
    -- Tracing done in ADC_API
    get_item_values_as_char_table(p_value_list, l_value_list);
    if p_value_list is not null then
      for v in val_cur(l_value_list) loop
        if v.cpi_value is not null then
          l_result := adc_util.C_TRUE;
          exit;
        end if;
      end loop;
    end if;
    
    return l_result;
  end not_null;
  
  
  procedure notify(
    p_text in varchar2)
  as
    c_comment constant varchar2(10) := adc_util.C_CR || '// ';
  begin
    -- Tracing done in ADC_API
    utl_text.append(g_param.notification_stack, C_COMMENT || p_text);
  end notify;


  procedure register_error(
    p_cpi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
    l_error apex_error.t_error;
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, 12);
  begin
    -- Tracing done in ADC_API
    push_firing_item(p_cpi_id);

    if p_error_msg is not null then
      l_error.message := p_error_msg;
      l_error.additional_info := p_internal_error;
      prepare_error(l_error, p_cpi_id);
      push_error(l_error);
    end if;
  end register_error;


  procedure register_error(
    p_cpi_id in varchar2,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
    l_error apex_error.t_error;  -- APEX-Fehler-Record
  begin
    -- Tracing done in ADC_API
    -- Register item to enable the browser to remove old errors for that item
    push_firing_item(p_cpi_id);

    if p_message_name is not null then
      -- Create the message
      l_error.message := pit.get_message_text(p_message_name, p_msg_args);
      prepare_error(l_error, p_cpi_id);
      push_error(l_error);
    end if;
    
  end register_error;
  
  
  procedure register_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type,
    p_jquery_selector in adc_rule_actions.cra_param_1%type default null)
  as
    l_is_mandatory adc_page_items.cpi_is_mandatory%type;
    l_mandatory_message adc_page_items.cpi_mandatory_message%type;
    l_label varchar2(100 char);
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
        apex_collection.add_member(
          p_collection_name => g_param.collection_name,
          p_c001 => l_srs_row.srs_cpi_id,
          p_c002 => l_srs_row.srs_cpi_label,
          p_c003 => case p_cpi_mandatory_message when 'null' then null else p_cpi_mandatory_message end,
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
      l_item_list := get_firing_items(p_cpi_id, p_jquery_selector);
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
  
  
  function register_observer
    return varchar2
  as
    l_observable_objects varchar2(2000);
  begin
    pit.enter_optional;
    
    select listagg(
             case when cra_cpi_id = adc_util.C_NO_FIRING_ITEM
                  then to_char(cra_param_2) 
                  else cra_cpi_id end, ',') within group (order by cru_firing_items)
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
  end register_observer;
  
  
  procedure set_session_state(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2,
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
      register_item(p_cpi_id, p_allow_recursion);
      apex_util.set_session_state(p_cpi_id, rtrim(p_value, ';'));
      notify(pit.get_message_text(msg.ADC_SESSION_STATE_SET, msg_args(p_cpi_id, p_value)));
    when p_cpi_id = adc_util.C_NO_FIRING_ITEM and p_jquery_selector is not null then
      -- P_ATTRUBTE_2 contains a jQuery selector for multiple elements
      l_item_list := get_firing_items(p_cpi_id, p_jquery_selector);
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
    l_stmt utl_apex.max_char;
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
      notify(pit.get_message_text(msg.ADC_NO_DATA_FOR_ITEM, msg_args(p_cpi_id)));
      set_session_state(p_cpi_id, '', adc_util.C_TRUE, null);
  end set_value_from_stmt;
  
  
  procedure stop_rule
  as
  begin
    -- Tracing done in ADC_API
    g_param.stop_flag := true;
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
      -- Register all required fields so that any error messages are correctly removed
      push_firing_item(itm.srs_cpi_id);
      if get_string(itm.srs_cpi_id) is null then
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
