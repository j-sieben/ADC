create or replace package body ut_adc 
as

  C_APEX_USER constant utl_apex.ora_name_type := $$PLSQL_UNIT_OWNER;
  
  C_DATE constant date := timestamp '2020-05-31 10:30:00';
  C_VALID_DATE_STRING constant utl_apex.ora_name_type := '31-05-2020 10:30';
  C_INVALID_DATE_STRING constant utl_apex.ora_name_type := '31.05.2020 10:30:45';
  C_NUMBER constant number := 123456.78;
  C_VALID_NUMBER_STRING constant utl_apex.ora_name_type := to_char(C_NUMBER, 'fm999G999D00');
  C_INVALID_NUMBER_STRING constant utl_apex.ora_name_type := '123 456:78';
  
  -- Aplication pages
  C_PAGE_TEST constant number := 98;
  C_PAGE_ADMIN_CGR constant number := 1;
  
  -- Rule groups
  C_CGR_ADMIN_CGR constant utl_apex.ora_name_type := 'ADC_ADMIN_CGR';
  C_CGR_EDIT_CRU constant utl_apex.ora_name_type := 'ADC_EDIT_CRU';
  C_CGR_TEST constant utl_apex.ora_name_type := 'ADC_TEST';
  
  -- Events
  C_EVENT_CHANGE constant utl_apex.ora_name_type := 'change';
  C_EVENT_INITIALIZE constant utl_apex.ora_name_type := 'initialize';
  
  -- Items
  C_NO_ITEM constant utl_apex.ora_name_type := 'DOCUMENT';
  C_ITEM_CGR_ID constant utl_apex.ora_name_type := 'P1_CGR_ID';
  C_ITEM_CRU_ACTIVE constant utl_apex.ora_name_type := 'P5_CRU_ACTIVE';
  C_ITEM_TEST_DATE constant utl_apex.ora_name_type := 'P98_TEST_DATE';
  C_ITEM_TEST_NUMBER constant utl_apex.ora_name_type := 'P98_TEST_NUMBER';
  
  g_cgr_id adc_rule_group.cgr_id%type;
  g_application_id number;  
  g_da_type apex_plugin.t_dynamic_action;
  g_plugin_type apex_plugin.t_plugin;
  g_render_result apex_plugin.t_dynamic_action_render_result;
  g_ajax_result apex_plugin.t_dynamic_action_ajax_result;
  g_test_name varchar2(128 byte);
  g_test_run number;
  g_group_delimiter char(1 byte);
  g_decimal_delimiter char(1 byte);

  procedure get_session(
    p_page_id in number default C_PAGE_ADMIN_CGR)
  as
  begin
    rollback;
    utl_dev_apex.create_session(
       p_app_id => g_application_id,
       p_app_page_id => p_page_id,
       p_app_user => c_apex_user);
    apex_application.g_flow_step_id := p_page_id;
    commit;
  end get_session;


  procedure drop_session
  as
  begin
    rollback;
    $IF utl_apex.ver_le_05 $THEN
    $ELSE
    utl_dev_apex.drop_session;
    $END
  end drop_session;
  
  
  procedure before_all
  as
    pragma autonomous_transaction;
  begin
    delete ut_adc_outcome;
    commit;
    g_test_run := 0;
    pit.initialize;
    utl_dev_apex.init_owa;
    adc.set_test_mode(true);
    pit.set_context('DEBUG');
    get_session;
    null;
  end before_all;
  
  
  procedure after_all
  as
  begin
    pit.reset_context;

  end after_all;
  
  
  procedure before_each
  as
  begin
    null;
  end before_each;
  
  
  procedure after_each
  as
  begin
    drop_session;
  end after_each;
  

  /** Method to control the plugin environment of ADC. Sets apex_plugin.t_dynamic_action and apex_plugin.t_plugin instances
   * @param  p_rule_group_name  Name of the rule group to test
   * @param  p_firing_item      Name of the page item that has caused ADC to react
   * @param  p_event            Event such as CHANGE, CLICK, DIALOG_CLOSED etc.
   * @usage  Is used to set the call environment for the plugin to enable tests. Is used along with the session state
   */
  procedure set_environment(
    p_rule_group_name in varchar2,
    p_firing_item in varchar2,
    p_event in varchar2)
  as    
  begin
    g_da_type.attribute_01 := p_rule_group_name;
    apex_application.g_x01 := p_firing_item;
    apex_application.g_x02 := p_event;
    g_da_type.attribute_02 := null;
  end set_environment;
  
  
  /** Method to retrieve the actual number of the test
   * @return Test number as stored in G_TEST_RUN
   */
  function get_test_run
    return number
  as
  begin
    g_test_run := g_test_run + 100;
    return g_test_run;
  end get_test_run;
  
  
  /** Method to initialize the test environment
   * @usage  Is used to read some primary key information from the APEX meta data
   */
  procedure initialize
  as
  begin
    select application_id
      into g_application_id
      from apex_applications
     where alias = 'ADC';
     
    select cgr_id
      into g_cgr_id
      from adc_rule_group
     where cgr_name = C_CGR_ADMIN_CGR;     
  end initialize;
  
  
  /** Helper method to write the outcome of to table UT_ADC_OUTCOME
   * @usage  Is used to log any movement of ADC and the outcome.
   *         It is not called from within the test, but ADC writes to it if in test mode
   */
  procedure persist_outcome
  as
    l_run number := get_test_run;
  begin
    insert into ut_adc_outcome(test_name, sort_seq, cru_id, cru_sort_seq, cru_name, cru_firing_items, cru_fire_on_page_load, 
             item, pl_sql, js, cra_sort_seq, cra_param_1, cra_param_2, cra_param_3, cra_on_error, cru_on_error, is_first_row, 
             id, cgr_id, firing_item, firing_event, error_dependent_items, bind_items, page_items, firing_items, error_stack, 
             recursive_stack, js_action_stack, is_recursive, level_length, allow_recursion, notification_stack, stop_flag, now)
          with data as(
           select adc.get_test_result result
             from dual)
    select g_test_name test_name, l_run + rownum sort_seq, 
           cru_id, cru_sort_seq, cru_name, cru_firing_items, cru_fire_on_page_load, item, pl_sql, js, cra_sort_seq, cra_param_1, cra_param_2, cra_param_3,
           cra_on_error, cru_on_error, is_first_row, id, cgr_id, firing_item, firing_event, error_dependent_items, 
           utl_text.table_to_string(bind_items, chr(10)) bind_items, 
           utl_text.table_to_string(page_items, chr(10)) page_items, 
           utl_text.table_to_string(firing_items, chr(10)) firing_items, 
           utl_text.table_to_string(error_stack, chr(10)) error_stack, 
           utl_text.table_to_string(recursive_stack, chr(10)) recursive_stack,
           (select listagg (rtrim(rtrim(script, chr(13)), chr(10)), chr(10)) within group (order by rownum) script
              from table(x.js_action_stack)) js_action_stack,
           is_recursive, 
           utl_text.table_to_string(level_length, ', ') level_length,
           allow_recursion, notification_stack, stop_flag, now
      from data d
     cross join table(d.result.rule_list) x;
    commit;
  end persist_outcome;
  
  
  --
  -- test get_char case 1: Checks whether the initialization of page 1 returns 3 well known firing items
  --
  procedure render_plugin
  as
  begin
    g_test_name := 'render_plugin';
    get_session;
    set_environment(C_CGR_ADMIN_CGR, C_NO_ITEM, C_EVENT_INITIALIZE);
    
    g_render_result := plugin_adc.render(g_da_type, g_plugin_type);
    
    ut.expect(g_render_result.attribute_02).to_equal('P1_CGR_APP_ID,P1_CGR_ID,P1_CGR_PAGE_ID');
  end render_plugin;
  
  
  --
  -- test refresh_plugin: Checks whether setting P1_CGR_ID to 1 leads to 1 executed rule with 1 action
  --
  procedure refresh_plugin
  as
    l_action_count binary_integer;
    l_rule_count binary_integer;
    l_result ut_adc_result;
  begin
    -- populate actual
    g_test_name := 'refresh_plugin';
    get_session;
    utl_apex.set_value(C_ITEM_CGR_ID, g_cgr_id);
    set_environment(C_CGR_ADMIN_CGR, C_ITEM_CGR_ID, C_EVENT_CHANGE);
    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    l_result := adc.get_test_result;
    
    -- populate expected
    select count(*), count(distinct cru_id)
      into l_action_count, l_rule_count
      from table(l_result.rule_list);
      
    -- assert
    ut.expect(l_action_count).to_equal(1);
    ut.expect(l_rule_count).to_equal(1);
  end refresh_plugin;

  --
  -- test get_event: Checks if the event passed in gets read correctly
  --
  procedure get_event is
  begin
    g_test_name := 'get_event';
    get_session;
    utl_apex.set_value(C_ITEM_CGR_ID, g_cgr_id);
    set_environment(C_CGR_ADMIN_CGR, C_ITEM_CGR_ID, C_EVENT_CHANGE);    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    
    ut.expect(adc.get_event()).to_equal(C_EVENT_CHANGE);
  end get_event;

  --
  -- test get_firing_item: Reads the firing item that is passed in
  --
  procedure get_firing_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'get_firing_item';
    get_session;
    utl_apex.set_value(C_ITEM_CGR_ID, g_cgr_id);
    set_environment(C_CGR_ADMIN_CGR, C_ITEM_CGR_ID, C_EVENT_CHANGE);    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    
    ut.expect(adc.get_event()).to_equal(C_EVENT_CHANGE);
  end get_firing_item;

  --
  -- test get_char: Checks whether ADC is able to pass back the string value
  --
  procedure get_char is
  begin
    g_test_name := 'get_char';
    get_session;
    utl_apex.set_value(C_ITEM_CGR_ID, g_cgr_id);
    set_environment(C_CGR_ADMIN_CGR, C_ITEM_CGR_ID, C_EVENT_CHANGE);    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    
    ut.expect(adc.get_char(C_ITEM_CGR_ID)).to_equal(to_char(g_cgr_id));
  end get_char;

  --
  -- test get_char_default: Checks whether ADC is able to pass back a default value on NULL
  --
  procedure get_char_default is
  begin
    g_test_name := 'get_char_default';
    get_session;
    set_environment(C_CGR_EDIT_CRU, C_NO_ITEM, C_EVENT_INITIALIZE);    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    ut.expect(adc.get_char(C_ITEM_CRU_ACTIVE)).to_equal(adc_util.C_TRUE);
  end get_char_default;

  --
  -- test get_date: Reads a date with an unusual date format defined on the page
  --
  procedure get_date is
  begin
    g_test_name := 'get_date';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_DATE, C_VALID_DATE_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_DATE, C_EVENT_CHANGE);    
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    ut.expect(adc.get_date(C_ITEM_TEST_DATE)).to_equal(C_DATE);
  end get_date;

  --
  -- test check_date: Controls if a page item contains a date
  --
  procedure check_date is
  begin
    g_test_name := 'check_date';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_DATE, C_VALID_DATE_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_DATE, C_EVENT_CHANGE);
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
  end check_date;

  --
  -- test check_no_date: Throws an exception if a page item contains an invalid date
  --
  procedure check_no_date is
    l_date date;
  begin
    g_test_name := 'check_no_date';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_DATE, C_INVALID_DATE_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_DATE, C_EVENT_CHANGE);
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
  end check_no_date;

  --
  -- test get_number: Reads a number with an unusual date format defined on the page
  --
  procedure get_number is
  begin
    g_test_name := 'get_number';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_NUMBER, C_VALID_NUMBER_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_NUMBER, C_EVENT_CHANGE);    
    --g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
    ut.expect(adc.get_number(C_ITEM_TEST_NUMBER)).to_equal(C_NUMBER);
  end get_number;

  --
  -- test check_number: Controls if a page item contains a date
  --
  procedure check_number is
  begin
    g_test_name := 'check_number';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_NUMBER, C_VALID_NUMBER_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_NUMBER, C_EVENT_CHANGE);
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
  end check_number;

  --
  -- test check_no_number: Throws an exception if a page item contains an invalid date
  --
  procedure check_no_number is
  begin
    g_test_name := 'check_no_number';
    get_session(C_PAGE_TEST);
    utl_apex.set_value(C_ITEM_TEST_NUMBER, C_INVALID_NUMBER_STRING);
    set_environment(C_CGR_TEST, C_ITEM_TEST_NUMBER, C_EVENT_CHANGE);
    g_ajax_result := plugin_adc.ajax(g_da_type, g_plugin_type);
  end check_no_number;

  --
  -- test add_javascript: If ADC adds a javascript chunk explicitily, it gets passed to the browser
  --
  procedure add_javascript is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'add_javascript';
    -- populate actual
    -- adc.add_javascript;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end add_javascript;

  --
  -- test check_mandatory case 1: ...
  --
  procedure check_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'check_mandatory';
    -- populate actual
    -- adc.check_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end check_mandatory;

  --
  -- test exclusive_or case 1: ...
  --
  procedure exclusive_or is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'exclusive_or';
    -- populate actual
    -- adc.exclusive_or;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end exclusive_or;

  --
  -- test execute_javascript case 1: ...
  --
  procedure execute_javascript is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_javascript';
    -- populate actual
    -- adc.execute_javascript;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_javascript;

  --
  -- test execute_plsql case 1: ...
  --
  procedure execute_plsql is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_plsql';
    -- populate actual
    -- adc.execute_plsql;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_plsql;

  --
  -- test has_errors case 1: ...
  --
  procedure has_errors is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'has_errors';
    -- populate actual
    -- adc.has_errors;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end has_errors;

  --
  -- test has_no_errors case 1: ...
  --
  procedure has_no_errors is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'has_no_errors';
    -- populate actual
    -- adc.has_no_errors;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end has_no_errors;

  --
  -- test not_null case 1: ...
  --
  procedure not_null is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'not_null';
    -- populate actual
    -- adc.not_null;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end not_null;

  --
  -- test notify case 1: ...
  --
  procedure notify is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'notify';
    -- populate actual
    -- adc.notify;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end notify;

  --
  -- test register_error case 1: ...
  --
  procedure register_error is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_error';
    -- populate actual
    -- adc.register_error;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_error;

  --
  -- test register_mandatory case 1: ...
  --
  procedure register_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_mandatory';
    -- populate actual
    -- adc.register_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_mandatory;

  --
  -- test register_notification case 1: ...
  --
  procedure register_notification is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_notification';
    -- populate actual
    -- adc.register_notification;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_notification;

  --
  -- test set_list_from_stmt case 1: ...
  --
  procedure set_list_from_stmt is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_list_from_stmt';
    -- populate actual
    -- adc.set_list_from_stmt;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_list_from_stmt;

  --
  -- test set_session_state case 1: ...
  --
  procedure set_session_state is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_session_state';
    -- populate actual
    -- adc.set_session_state;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_session_state;

  --
  -- test set_session_state_or_error case 1: ...
  --
  procedure set_session_state_or_error is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_session_state_or_error';
    -- populate actual
    -- adc.set_session_state_or_error;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_session_state_or_error;

  --
  -- test set_value_from_stmt case 1: ...
  --
  procedure set_value_from_stmt is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_value_from_stmt';
    -- populate actual
    -- adc.set_value_from_stmt;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_value_from_stmt;

  --
  -- test stop_rule case 1: ...
  --
  procedure stop_rule is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'stop_rule';
    -- populate actual
    -- adc.stop_rule;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_rule;

  --
  -- test validate_page case 1: ...
  --
  procedure validate_page is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'validate_page';
    -- populate actual
    -- adc.validate_page;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end validate_page;

  --
  -- test toggle_item_mandatory case 1: ...
  --
  procedure toggle_item_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_mandatory';
    -- populate actual
    -- adc.toggle_item_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_mandatory;

  --
  -- test toggle_item_status case 1: ...
  --
  procedure toggle_item_status is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_status';
    -- populate actual
    -- adc.toggle_item_status;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_status;

  --
  -- test toggle_item_visibility case 1: ...
  --
  procedure toggle_item_visibility is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_visibility';
    -- populate actual
    -- adc.toggle_item_visibility;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_visibility;

  --
  -- test refresh_item case 1: ...
  --
  procedure refresh_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'refresh_item';
    -- populate actual
    -- adc.refresh_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end refresh_item;

  --
  -- test set_item case 1: ...
  --
  procedure set_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_item';
    -- populate actual
    -- adc.set_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_item;

  --
  -- test set_focus case 1: ...
  --
  procedure set_focus is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_focus';
    -- populate actual
    -- adc.set_focus;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_focus;

  --
  -- test execute_apex_action case 1: ...
  --
  procedure execute_apex_action is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_apex_action';
    -- populate actual
    -- adc.execute_apex_action;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_apex_action;

  --
  -- test execute_java_script case 1: ...
  --
  procedure execute_java_script is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_java_script';
    -- populate actual
    -- adc.execute_java_script;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_java_script;

  --
  -- test write_to_console case 1: ...
  --
  procedure write_to_console is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'write_to_console';
    -- populate actual
    -- adc.write_to_console;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end write_to_console;


  procedure tear_down
  as
  begin
    adc.set_test_mode(false);
    pit.reset_context;

  end tear_down;

begin
  initialize;
end ut_adc;
/
