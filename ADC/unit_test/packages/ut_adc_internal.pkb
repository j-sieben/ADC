create or replace package body ut_adc_internal
as

  C_APEX_USER constant adc_util.ora_name_type := $$PLSQL_UNIT_OWNER;  
  C_COLLECTION_NAME constant adc_util.ora_name_type := 'ADC_CRG_STATUS_';
  
  C_STRING constant adc_util.ora_name_type := 'WILLI';
  C_JSON_STRING constant adc_util.ora_name_type := '{"id":12345,"name": "WILLI"}';
  C_INVALID_JSON_STRING constant adc_util.ora_name_type := '{"id":12345,"name": "WILLI"';
  
  C_NUMBER constant number := 123456.78;
  C_NUMBER_FORMAT constant adc_util.ora_name_type := 'fm999G999D00';
  C_VALID_NUMBER_STRING constant adc_util.ora_name_type := to_char(C_NUMBER, C_NUMBER_FORMAT);
  C_INVALID_NUMBER_STRING constant adc_util.ora_name_type := '123 456:78';
  
  C_DATE constant date := timestamp '2020-05-31 10:30:00';
  C_DATE_FORMAT constant adc_util.ora_name_type := 'yyyy-mm-dd hh24:mi:ss';
  C_VALID_DATE_STRING constant adc_util.ora_name_type := '2020-05-31 10:30:00';
  C_INVALID_DATE_STRING constant adc_util.ora_name_type := '31.05.2020 10:30:45';
  
  C_JAVA_SCRIPT constant adc_util.max_char := 'apex.message.alert("Hello World!");';
  
  -- Aplication pages
  
  -- Rule groups
  C_APP_ALIAS constant adc_util.ora_name_type := 'SADC';
  C_PAGE_ALIAS constant adc_util.ora_name_type := 'UNITTEST';
  C_PAGE_TEST constant pls_integer := 99;
  
  -- Items
  C_PREFIX constant adc_util.ora_name_type := 'P' || C_PAGE_TEST || '_';
  C_STRING_ITEM constant adc_util.ora_name_type := C_PREFIX || 'LAST_NAME';
  C_NUMBER_ITEM constant adc_util.ora_name_type := C_PREFIX || 'SALARY';
  C_DATE_ITEM constant adc_util.ora_name_type := C_PREFIX || 'HIRE_DATE';
  C_OPTIONAL_ITEM constant adc_util.ora_name_type := C_PREFIX || 'FIRST_NAME';
  
  g_application_id pls_integer;
  g_crg_id pls_integer;
  g_page_prefix adc_util.ora_name_type;
  g_scenario adc_util.ora_name_type;
  

  procedure create_session
  as
  begin 
    apex_session.create_session(
       p_app_id => g_application_id,
       p_page_id => C_PAGE_TEST,
       p_username => C_APEX_USER);
       
    g_page_prefix := utl_apex.get_page_prefix;
  end create_session;


  procedure delete_session
  as
  begin
    rollback;
    apex_session.delete_session;
  end delete_session;
  
  
  procedure before_all
  as
    pragma autonomous_transaction;
  begin
    --pit.initialize;
    pit.set_context('DEBUG');
    null;
  end before_all;
  
  
  procedure after_all
  as
  begin
    --pit.reset_context;
    null;
  end after_all;
  
  
  procedure before_each
  as
  begin
    null;
  end before_each;
  
  
  procedure after_each
  as
  begin
    --adc_internal.initialize;
    delete_session;
  end after_each;
  
  
  procedure initialize
  as
  begin
    select application_id
      into g_application_id
      from apex_applications
     where alias = C_APP_ALIAS;
     
    select crg_id
      into g_crg_id
      from adc_rule_groups
     where crg_app_id = g_application_id
       and crg_page_id = C_PAGE_TEST;
  end initialize;
  
  
  procedure initialize_adc(
    p_scenario in adc_util.ora_name_type)
  as
    l_result adc_util.max_char;
  begin
    create_session;
    
    apex_application.g_date_format := C_DATE_FORMAT;
    g_scenario := p_scenario;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    l_result := adc_internal.process_request;
  end initialize_adc;
  
  
  function call_scenario_plsql_code(
    p_scenario in adc_util.ora_name_type)
    return varchar2
  as
  begin
    initialize_adc(p_scenario);
      
    adc_internal.read_settings(
      p_firing_item => C_OPTIONAL_ITEM,
      p_event => 'change',
      p_event_data => null);
      
    return adc_internal.process_request;
  end;
    
  
  
  procedure execute_ut_scenario
  as
  begin
    pit.enter_optional(
      p_params => msg_params(msg_param('Scenario', g_scenario)));
      
    case g_scenario
      when 'execute_action' then
        adc_internal.execute_action(
          p_cat_id => 'SET_ITEM',
          p_cpi_id => C_STRING_ITEM,
          p_param_1 => dbms_assert.enquote_literal(C_STRING),
          p_param_2 => null,
          p_param_3 => null,
          p_allow_recursion => adc_util.C_TRUE);
      when 'execute_non_existing_action' then
        adc_internal.execute_action(
          p_cat_id => 'FOO',
          p_cpi_id => C_STRING_ITEM,
          p_param_1 => dbms_assert.enquote_literal(C_STRING),
          p_param_2 => null,
          p_param_3 => null,
          p_allow_recursion => adc_util.C_FALSE);
      when 'execute_action_with_css_selector' then
        adc_internal.execute_action(
          p_cat_id => 'SET_ITEM',
          p_cpi_id => adc_util.C_NO_FIRING_ITEM,
          p_param_1 => null,
          p_param_2 => '.sadc-mandatory',
          p_param_3 => null,
          p_allow_recursion => adc_util.C_FALSE);
      when 'register_error' then
        adc_internal.register_error(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_error_msg => 'FOO',
          p_internal_error => 'FOO_INTERNAL');
      when 'register_error_message' then
        adc_internal.register_error(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_message_name => msg.PIT_PASS_MESSAGE,
          p_msg_args => msg_args(C_STRING));
      when 'register_mandatory' then
        adc_internal.register_mandatory(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_cpi_mandatory_message => 'FOO',
          p_is_mandatory => adc_util.C_TRUE,
          p_jquery_selector => null);
      when 'register_mandatory_validate' then
        adc_internal.register_mandatory(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_cpi_mandatory_message => 'FOO',
          p_is_mandatory => adc_util.C_TRUE,
          p_jquery_selector => null);
        adc_internal.set_session_state(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_value => null,
          p_allow_recursion => adc_util.C_TRUE);
      when 'reset_mandatory' then
        adc_internal.register_mandatory(
          p_cpi_id => C_STRING_ITEM,
          p_cpi_mandatory_message => null,
          p_is_mandatory => adc_util.C_FALSE,
          p_jquery_selector => null);
      when 'reset_mandatory_validate' then
        adc_internal.register_mandatory(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_cpi_mandatory_message => 'FOO',
          p_is_mandatory => adc_util.C_TRUE,
          p_jquery_selector => null);
        adc_internal.register_mandatory(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_cpi_mandatory_message => 'FOO',
          p_is_mandatory => adc_util.C_FALSE,
          p_jquery_selector => null);
        adc_internal.set_session_state(
          p_cpi_id => C_OPTIONAL_ITEM,
          p_value => null,
          p_allow_recursion => adc_util.C_TRUE);
      else
        null;
    end case;
    
    pit.leave_optional;
  end execute_ut_scenario;
  
  --
  -- test case 1: Get the actually selected CRG_ID
  --
  procedure get_crg_id
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    ut.expect(adc_internal.get_crg_id()).to_equal(g_crg_id);
  end get_crg_id;
  
  
  --
  -- test case 2: Get the actually selected CRG_ID even without calling read_settings before
  --
  procedure get_crg_id_without_preparation
  as
  begin
    create_session;
      
    ut.expect(adc_internal.get_crg_id()).to_equal(g_crg_id);
  end get_crg_id_without_preparation;
  
  
  --
  -- test case 3: Get the actually raised event
  --
  procedure get_event
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    ut.expect(adc_internal.get_event()).to_equal('initialize');
  end get_event;
  
  
  --
  -- test case 4: Get NULL if no event data is present
  --
  procedure get_empty_event_data
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    ut.expect(adc_internal.get_event_data(null)).to_be_null;
  end get_empty_event_data;
  
  
  --
  -- test case 5: Get the whole string if no event data is a plain string
  --
  procedure get_string_event_data
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_STRING);
      
    ut.expect(adc_internal.get_event_data(null)).to_equal(C_STRING);
  end get_string_event_data;
  
  
  --
  -- test case 6: Get the key string if no event data is a JSON string
  --
  procedure get_json_event_data
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_JSON_STRING);
      
    ut.expect(adc_internal.get_event_data('name')).to_equal(C_STRING);
  end get_json_event_data;
  
  
  --
  -- test case 7: Get the key string if no event data is a JSON string
  --
  procedure get_empty_json_event_data
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_JSON_STRING);
      
    ut.expect(adc_internal.get_event_data('foo')).to_be_null();
  end get_empty_json_event_data;
  
  
  --
  -- test case 8: Return null and register an error when JSON is invalid
  --
  procedure get_invalid_json_event_data
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_INVALID_JSON_STRING);
      
    ut.expect(adc_internal.get_event_data('foo')).to_be_null();
    ut.expect(adc_internal.get_error_flag).to_be_true();
  end get_invalid_json_event_data;
  
  
  --
  -- test case 9: Return FALSE if no error is registered
  --
  procedure get_error_flag_no_error
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_JSON_STRING);
      
    ut.expect(adc_internal.get_error_flag()).to_be_false;
  end get_error_flag_no_error;
  
  
  --
  -- test case 10: Return TRUE if an error is registered
  --
  procedure get_error_flag_with_error
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => C_JSON_STRING);
      
    adc_internal.register_error(
      p_cpi_id => C_STRING_ITEM,
      p_error_msg => ' Foo',
      p_internal_error => null);
      
    ut.expect(adc_internal.get_error_flag()).to_be_true;
  end get_error_flag_with_error;
  
  
  --
  -- test case 11: Return adc_util.C_NO_FIRING_ITEM when initializing
  --
  procedure get_initial_firing_item
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    ut.expect(adc_internal.get_firing_item()).to_equal(adc_util.C_NO_FIRING_ITEM);
  end get_initial_firing_item;
  
  
  --
  -- test case 12: Return the name for the firing item later
  --
  procedure get_firing_item
  as
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => C_STRING_ITEM,
      p_event => 'change',
      p_event_data => C_JSON_STRING);
      
    ut.expect(adc_internal.get_firing_item()).to_equal(C_STRING_ITEM);
  end get_firing_item;
  
  
  --
  -- test case 13: Return a JSON string with all bind items
  --
  procedure get_bind_items_as_json
  as
    l_target_item json_object_t;
    l_actual json_array_t;
    l_bind_item adc_util.ora_name_type := C_OPTIONAL_ITEM;
  begin
    create_session;
    
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    -- Find l_bind_item in the list of bind items
    l_actual := json_array_t.parse(replace(adc_internal.get_bind_items_as_json(), '~', '"'));
    dbms_output.put_line(l_actual.stringify());
    for i in 0 .. l_actual.get_size - 1 loop
      l_target_item := treat(l_actual.get(i) as json_object_t);
      if l_target_item.get_string('id') = l_bind_item then
        exit;
      end if;
    end loop;
    
    ut.expect(l_target_item.get_string('id')).to_equal(l_bind_item);
  end get_bind_items_as_json;
  
  
  --
  -- test case 13: Check that a mandatory item is in the bind item JSON
  --
  procedure find_mandatory_item_in_bind_items
  as
    l_target_item json_object_t;
    l_actual json_array_t;
    l_bind_item adc_util.ora_name_type := 'P99_LAST_NAME';
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'find_mandatory_item_in_bind_items');
      
    -- Find l_bind_item in the list of bind items
    l_actual := json_array_t.parse(adc_internal.get_bind_items_as_json());
    for i in 0 .. l_actual.get_size - 1 loop
      l_target_item := treat(l_actual.get(i) as json_object_t);
      if l_target_item.get_string('id') = l_bind_item then
        exit;
      end if;
    end loop;
    
    ut.expect(l_target_item.get_string('id')).to_equal(l_bind_item);
  end find_mandatory_item_in_bind_items;
  
  
  --
  -- test case 14: Check that a number item is in the bind item JSON
  --
  procedure find_number_item_in_bind_items
  as
    l_target_item json_object_t;
    l_actual json_array_t;
    l_bind_item adc_util.ora_name_type := 'P99_SALARY';
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'find_number_item_in_bind_items');
      
    -- Find l_bind_item in the list of bind items
    l_actual := json_array_t.parse(adc_internal.get_bind_items_as_json());
    for i in 0 .. l_actual.get_size - 1 loop
      l_target_item := treat(l_actual.get(i) as json_object_t);
      if l_target_item.get_string('id') = l_bind_item then
        exit;
      end if;
    end loop;
    
    ut.expect(l_target_item.get_string('id')).to_equal(l_bind_item);
  end find_number_item_in_bind_items;
  
  
  --
  -- test case 15: Check that a date item is in the bind item JSON
  --
  procedure find_date_item_in_bind_items
  as
    l_target_item json_object_t;
    l_actual json_array_t;
    l_bind_item adc_util.ora_name_type := 'P99_HIRE_DATE';
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'find_date_item_in_bind_items');
      
    -- Find l_bind_item in the list of bind items
    l_actual := json_array_t.parse(adc_internal.get_bind_items_as_json());
    for i in 0 .. l_actual.get_size - 1 loop
      l_target_item := treat(l_actual.get(i) as json_object_t);
      if l_target_item.get_string('id') = l_bind_item then
        exit;
      end if;
    end loop;
    
    ut.expect(l_target_item.get_string('id')).to_equal(l_bind_item);
  end find_date_item_in_bind_items;
  
  
  --
  -- test case 15: Check that a date item is in the bind item JSON
  --
  procedure get_page_items
  as
    l_bind_item adc_util.ora_name_type := C_OPTIONAL_ITEM;
    l_result adc_util.max_char;
  begin
    create_session;
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_STRING);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(instr(l_result, '"firingItems":["P99_FIRST_NAME"]')).to_be_greater_than(0);
  end get_page_items;
  
  
  --
  -- test case 15: Check that a date item is in the bind item JSON
  --
  procedure process_request_initialize
  as
    l_bind_item adc_util.ora_name_type := C_OPTIONAL_ITEM;
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_initialize');
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_initialize;
  
  
  --
  -- test case 15: Processes mandatory item with value without errors
  --
  procedure process_request_mandatory
  as
    l_bind_item adc_util.ora_name_type := 'P99_JOB_ID';
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_mandatory');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_STRING);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_mandatory;
  
  
  --
  -- test case 15: Processes number item with number without errors
  --
  procedure process_request_number
  as
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_number');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_number;
  
  
  --
  -- test case 15: Processes date item with date without errors
  --
  procedure process_request_date
  as
    l_bind_item adc_util.ora_name_type := C_DATE_ITEM;
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_date');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_VALID_DATE_STRING);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_date;
  
  
  --
  -- test case 15: Processes mandatory item withou value with error
  --
  procedure process_request_mandatory_null
  as
    l_bind_item adc_util.ora_name_type := 'P99_JOB_ID';
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_mandatory_null');
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_mandatory_null;
  
  
  --
  -- test case 15: Processes number item with invalid number with errors
  --
  procedure process_request_invalid_number
  as
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_invalid_number');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_STRING);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_invalid_number;
  
  
  --
  -- test case 15: Processes date item with invalid date with errors
  --
  procedure process_request_invalid_date
  as
    l_bind_item adc_util.ora_name_type := C_DATE_ITEM;
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'process_request_invalid_date');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_STRING);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_invalid_date;
  
  
  --
  -- test case 15: Add JavaScript to the reponse
  --
  procedure add_javascript
  as
    l_result adc_util.max_char;
  begin
    create_session;
      
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
    
    adc_internal.add_javascript(C_JAVA_SCRIPT);
    
    l_result := adc_internal.process_request;
    
    ut.expect(l_result).to_be_like('%' || C_JAVA_SCRIPT || '%');
  end add_javascript;
  
  
  --
  -- test case 15: Add JavaScript twice and check it is commented out
  --
  procedure ignore_double_javascript
  as
    l_result adc_util.max_char;
  begin
    create_session;
      
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
    
    adc_internal.add_javascript(C_JAVA_SCRIPT);
    
    adc_internal.add_javascript(C_JAVA_SCRIPT);
    
    l_result := adc_internal.process_request;
    
    ut.expect(l_result).not_to_be_like('%' || C_JAVA_SCRIPT || '%' || C_JAVA_SCRIPT || '%');
  end ignore_double_javascript;
  
  
  --
  -- test case 15: Add JavaScript twice and check it is commented out
  --
  procedure ignore_empty_javascript
  as
    l_result adc_util.max_char;
  begin
    create_session;
      
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
    
    adc_internal.add_javascript(null);
    
    l_result := adc_internal.process_request;
    
    ut.expect(l_result).not_to_be_like('%' || C_JAVA_SCRIPT || '%');
  end ignore_empty_javascript;
  
  
  --
  -- test case 15: ignores a mandatory item if it is not null
  --
  procedure check_mandatory
  as
    l_result adc_util.max_char;
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
  begin
    initialize_adc(
     p_scenario => 'check_mandatory');
    
    utl_apex.set_value(
      p_page_item => C_STRING_ITEM,
      p_value => C_STRING);
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
      
    adc_internal.check_mandatory(C_STRING_ITEM);
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end check_mandatory;
  
  
  --
  -- test case 15: registers an error if a mandatory item is null
  --
  procedure check_mandatory_null
  as
    l_result adc_util.max_char;
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
  begin
    initialize_adc(
     p_scenario => 'check_mandatory_null');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
      
    adc_internal.check_mandatory(C_STRING_ITEM);
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end check_mandatory_null;
  
  
  --
  -- test case 15: registers an error if a mandatory item is null and stops the rule
  --
  procedure check_mandatory_null_stop
  as
    l_result adc_util.max_char;
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
  begin
    initialize_adc(
     p_scenario => 'check_mandatory_null_stop');
    
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    adc_internal.read_settings(
      p_firing_item => l_bind_item,
      p_event => 'change',
      p_event_data => null);
      
    adc_internal.check_mandatory(C_STRING_ITEM, adc_util.C_TRUE);
    
    l_result := adc_internal.process_request;
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(instr(l_result, '//')).to_equal(0);
  end check_mandatory_null_stop;
  
  
  --
  -- test case 15: ignore missing mandatory values when initializing
  --
  procedure check_mandatory_on_initialize
  as
    l_result adc_util.max_char;
  begin
    initialize_adc(
     p_scenario => 'check_mandatory_on_initialize');
      
    adc_internal.read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
      
    adc_internal.check_mandatory(C_STRING_ITEM, adc_util.C_FALSE);
    
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end check_mandatory_on_initialize;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure execute_action
  as
    l_result adc_util.max_char;
  begin
      
    l_result := call_scenario_plsql_code('execute_action');
    -- See execute_ut_scenario
    
    ut.expect(adc_api.get_string(C_STRING_ITEM)).to_equal(C_STRING);
    ut.expect(instr(l_result, 'de.condes.plugin.adc.setDisplayState')).to_be_greater_than(0);
  end execute_action;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure execute_non_existing_action
  as
    l_result adc_util.max_char;
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
  begin
  
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    l_result := call_scenario_plsql_code('execute_non_existing_action');
    -- See execute_ut_scenario
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end execute_non_existing_action;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure execute_action_with_css_selector
  as
    l_result adc_util.max_char;
    l_bind_item adc_util.ora_name_type := C_NUMBER_ITEM;
  begin      
    utl_apex.set_value(
      p_page_item => l_bind_item,
      p_value => C_NUMBER);
      
    l_result := call_scenario_plsql_code('execute_action_with_css_selector');
    -- See execute_ut_scenario
    
    ut.expect(adc_api.get_number(l_bind_item)).to_be_null;
  end execute_action_with_css_selector;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure register_error
  as
    l_result adc_util.max_char;
  begin      
    
    l_result := call_scenario_plsql_code('register_error');
    -- See execute_ut_scenario
    
    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(instr(l_result, 'FOO')).to_be_greater_than(0);
    ut.expect(instr(l_result, 'FOO_INTERNAL')).to_be_greater_than(0);
  end register_error;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure register_error_message
  as
    l_result adc_util.max_char;
  begin      
    
    l_result := call_scenario_plsql_code('register_error_message');
     
    -- See execute_ut_scenario
        
    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(instr(l_result, C_STRING)).to_be_greater_than(0);
  end register_error_message;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure register_item
  as
    l_result adc_util.max_char;
  begin      
    
    l_result := call_scenario_plsql_code('register_item');     
    -- See execute_ut_scenario
    
    ut.expect(adc_internal.get_items_to_observe).to_equal(C_PREFIX || 'COMMISSION_PCT');
  end register_item;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure register_mandatory
  as
    l_result adc_util.max_char;
    l_is_mandatory pls_integer;
  begin      
    
    l_result := call_scenario_plsql_code('register_mandatory');     
    -- See execute_ut_scenario
    
    select count(*)
      into l_is_mandatory
      from apex_collections
     where collection_name = C_COLLECTION_NAME || g_crg_id
       and c001 = C_OPTIONAL_ITEM;
       
    ut.expect(l_is_mandatory).to_equal(1);
  end register_mandatory;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure register_mandatory_validate
  as
    l_result adc_util.max_char;
    l_is_mandatory pls_integer;
  begin      
    
    l_result := call_scenario_plsql_code('register_mandatory_validate');     
    -- See execute_ut_scenario
    
    select count(*)
      into l_is_mandatory
      from apex_collections
     where collection_name = C_COLLECTION_NAME || g_crg_id
       and c001 = C_OPTIONAL_ITEM;
       
    ut.expect(l_is_mandatory).to_equal(1);
    ut.expect(adc_internal.get_error_flag).to_be_true;
  end register_mandatory_validate;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure reset_mandatory
  as
    l_result adc_util.max_char;
    l_is_mandatory pls_integer;
  begin      
    
    l_result := call_scenario_plsql_code('reset_mandatory');     
    -- See execute_ut_scenario
    
    select count(*)
      into l_is_mandatory
      from apex_collections
     where collection_name = C_COLLECTION_NAME || g_crg_id
       and c001 = C_OPTIONAL_ITEM;
       
    ut.expect(l_is_mandatory).to_equal(0);
  end reset_mandatory;
  
  
  --
  -- test case 15: execute PL/SQL and register JavaScript when executing an action type
  --
  procedure reset_mandatory_validate
  as
    l_result adc_util.max_char;
    l_is_mandatory pls_integer;
  begin      
    
    l_result := call_scenario_plsql_code('reset_mandatory_validate');     
    -- See execute_ut_scenario
    
    select count(*)
      into l_is_mandatory
      from apex_collections
     where collection_name = C_COLLECTION_NAME || g_crg_id
       and c001 = C_OPTIONAL_ITEM;
       
    ut.expect(l_is_mandatory).to_equal(0);
    ut.expect(adc_internal.get_error_flag).to_be_false;
  end reset_mandatory_validate;
  
begin
  initialize;
end ut_adc_internal;
/
