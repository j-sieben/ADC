create or replace package body ut_adc_page_state
as

  C_APEX_USER constant adc_util.ora_name_type := $$PLSQL_UNIT_OWNER;
  
  C_STRING constant adc_util.ora_name_type := 'WILLI';
  
  C_NUMBER constant number := 123456.78;
  C_NUMBER_FORMAT constant adc_util.ora_name_type := 'fm999G999D00';
  C_VALID_NUMBER_STRING constant adc_util.ora_name_type := to_char(C_NUMBER, C_NUMBER_FORMAT);
  C_INVALID_NUMBER_STRING constant adc_util.ora_name_type := '123 456:78';
  
  C_DATE constant date := timestamp '2020-05-31 10:30:00';
  C_DATE_FORMAT constant adc_util.ora_name_type := 'yyyy-mm-dd hh24:mi:ss';
  C_VALID_DATE_STRING constant adc_util.ora_name_type := '2020-05-31 10:30:00';
  C_INVALID_DATE_STRING constant adc_util.ora_name_type := '31.05.2020 10:30:45';
  
  -- Aplication pages
  C_PAGE_UNITTEST constant number := 99;
  
  -- Rule groups
  C_APP_ALIAS constant adc_util.ora_name_type := 'SADC';
  
  -- Items
  C_STRING_ITEM constant adc_util.ora_name_type := 'LAST_NAME';
  C_NUMBER_ITEM constant adc_util.ora_name_type := 'SALARY';
  C_DATE_ITEM constant adc_util.ora_name_type := 'HIRE_DATE';
  
  g_cgr_id adc_rule_groups.cgr_id%type;
  g_application_id number;
  g_page_prefix adc_util.ora_name_type;
  

  procedure create_session(
    p_page_id in number)
  as
  begin    
    apex_session.create_session(
       p_app_id => g_application_id,
       p_page_id => p_page_id,
       p_username => C_APEX_USER);
--    apex_application.g_flow_step_id := p_page_id;
    
    execute immediate 'alter session set nls_numeric_characters = ''' 
                   ||  apex_application.get_nls_decimal_separator
                   ||  apex_application.get_nls_group_separator || '''';
                   
    apex_application.g_date_format := C_DATE_FORMAT;
    
    -- get CGR for the rule group of the selected page
    select cgr_id
      into g_cgr_id
      from adc_rule_groups
     where cgr_app_id = g_application_id
       and cgr_page_id = p_page_id;
       
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
    pit.initialize;
    pit.set_context('DEFAULT');
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
    adc_page_state.reset;
  end before_each;
  
  
  procedure after_each
  as
  begin
    adc_page_state.reset;
    delete_session;
  end after_each;
  
  
  procedure initialize
  as
  begin
    select application_id
      into g_application_id
      from apex_applications
     where alias = C_APP_ALIAS;
  end initialize;
  
  
  --
  -- test ADC_PAGE_STATE case 1: Sets a given item value as String
  --
  procedure set_item_value_as_string
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(g_cgr_id, g_page_prefix || C_STRING_ITEM, C_STRING);
    
    ut.expect(utl_apex.get_string(C_STRING_ITEM)).to_equal(C_STRING);
  end set_item_value_as_string;
  
  
  --
  -- test ADC_PAGE_STATE case 2: Sets a given item value as String and read its value from the adc_page_state cache
  --
  procedure set_and_read_item_value
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(g_cgr_id, g_page_prefix || C_STRING_ITEM, C_STRING, p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_STRING_ITEM)).to_equal(C_STRING);
  end set_and_read_item_value;
  
  
  --
  -- test ADC_PAGE_STATE case 3: Sets a given item value as Number
  --
  procedure set_item_value_as_number
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_number_value => C_NUMBER, 
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(g_page_prefix || C_NUMBER_ITEM)).to_equal(C_NUMBER);
  end set_item_value_as_number;
  
  
  --
  -- test ADC_PAGE_STATE case 4: Sets a number item value as String, conversion expected
  --
  procedure set_number_item_value_as_string
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_VALID_NUMBER_STRING, 
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(g_page_prefix || C_NUMBER_ITEM)).to_equal(C_NUMBER);
  end set_number_item_value_as_string;
  
  
  --
  -- test ADC_PAGE_STATE case 5: Sets a number item value as String, conversion expected
  --
  procedure set_number_item_value_as_invalid_string
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_INVALID_NUMBER_STRING, 
      p_throw_error => adc_util.C_TRUE);
  end set_number_item_value_as_invalid_string;
  
  
  --
  -- test ADC_PAGE_STATE case 6: Sets a number item value as String, explicit format mask provided
  --
  procedure set_number_item_value_explicit_format
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_VALID_NUMBER_STRING,
      p_format_mask => C_NUMBER_FORMAT,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(g_page_prefix || C_NUMBER_ITEM)).to_equal(C_NUMBER);
  end set_number_item_value_explicit_format;
  
  
  --
  -- test ADC_PAGE_STATE case 7: Sets a number item value as String, explicit format mask provided
  --
  procedure set_number_item_value_invalid_format_mask
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_VALID_NUMBER_STRING,
      p_format_mask => 'ABC',
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(g_page_prefix || C_NUMBER_ITEM)).to_equal(C_NUMBER);
  end set_number_item_value_invalid_format_mask;
  
  
  --
  -- test ADC_PAGE_STATE case 8: Sets a number item value as String, explicit format mask provided
  --
  procedure set_number_item_value_string_too_long
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_VALID_NUMBER_STRING,
      p_format_mask => 'fm990',
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(g_page_prefix || C_NUMBER_ITEM)).to_equal(C_NUMBER);
  end set_number_item_value_string_too_long;
  
  
  --
  -- test ADC_PAGE_STATE case 9: Sets a given item value as date
  --
  procedure set_item_value_as_date
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_date_value => C_DATE, 
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_date(g_cgr_id, g_page_prefix || C_DATE_ITEM, null)).to_equal(C_DATE);
  end set_item_value_as_date;
  
  
  --
  -- test ADC_PAGE_STATE case 10: Sets a date item value as String, conversion expected
  --
  procedure set_date_item_value_as_string
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => C_VALID_DATE_STRING, 
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_date(g_cgr_id, g_page_prefix || C_DATE_ITEM, null)).to_equal(C_DATE);
  end set_date_item_value_as_string;
  
  
  --
  -- test ADC_PAGE_STATE case 11: Sets a date item value as String, explicit format mask provided
  --
  procedure set_date_item_value_explicit_format
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => C_VALID_DATE_STRING,
      p_format_mask => C_DATE_FORMAT,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_date(g_cgr_id, g_page_prefix || C_DATE_ITEM, C_DATE_FORMAT)).to_equal(C_DATE);
  end set_date_item_value_explicit_format;
  
  
  --
  -- test ADC_PAGE_STATE case 12: Sets a date item value as String, conversion expected
  --
  procedure set_date_item_value_as_invalid_string
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => C_INVALID_DATE_STRING, 
      p_throw_error => adc_util.C_TRUE);
  end set_date_item_value_as_invalid_string;
  
  
  --
  -- test ADC_PAGE_STATE case 13: Invliad format mask passed in
  --
  procedure set_date_item_value_invalid_format_mask
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => C_VALID_DATE_STRING,
      p_format_mask => 'ABC', 
      p_throw_error => adc_util.C_TRUE);
  end set_date_item_value_invalid_format_mask;
  
  
  --
  -- test ADC_PAGE_STATE case 14: Invalid date passed in
  --
  procedure set_date_item_value_invalid_date
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => replace(C_VALID_DATE_STRING, '05', '04'),
      p_format_mask => C_DATE_FORMAT, 
      p_throw_error => adc_util.C_TRUE);
  end set_date_item_value_invalid_date;
  
  
  --
  -- test ADC_PAGE_STATE case 15: Resets a string item value to NULL
  --
  procedure reset_string_item_value_to_null
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => C_STRING,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => null,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_STRING_ITEM)).to_be_null;
  end reset_string_item_value_to_null;
  
  
  --
  -- test ADC_PAGE_STATE case 16: Resets a number item value to NULL
  --
  procedure reset_number_item_value_to_null
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_number_value => C_NUMBER,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_number_value => null,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_NUMBER_ITEM)).to_be_null;
  end reset_number_item_value_to_null;
  
  
  --
  -- test ADC_PAGE_STATE case 17: Resets a date item value to NULL
  --
  procedure reset_date_item_value_to_null
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_date_value => C_DATE,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_date_value => null,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_DATE_ITEM)).to_be_null;
  end reset_date_item_value_to_null;
  
  
  --
  -- test ADC_PAGE_STATE case 18: Reads a string value from the session state
  --
  procedure read_string_item_value_from_session_state
  as
  begin
    create_session(C_PAGE_UNITTEST);
    utl_apex.set_value(
      p_page_item => g_page_prefix || C_STRING_ITEM, 
      p_value => C_STRING);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => adc_page_state.C_FROM_SESSION_STATE,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_STRING_ITEM)).to_equal(C_STRING);
  end read_string_item_value_from_session_state;
  
  
  --
  -- test ADC_PAGE_STATE case 19: Reads a string value from the session state
  --
  procedure read_number_item_value_from_session_state
  as
  begin
    create_session(C_PAGE_UNITTEST);
    utl_apex.set_value(
      p_page_item => g_page_prefix || C_NUMBER_ITEM, 
      p_value => C_VALID_NUMBER_STRING);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_value => adc_page_state.C_FROM_SESSION_STATE,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_number(g_cgr_id, g_page_prefix || C_NUMBER_ITEM, null)).to_equal(C_NUMBER);
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_NUMBER_ITEM)).to_equal(C_VALID_NUMBER_STRING);
  end read_number_item_value_from_session_state;
  
  
  --
  -- test ADC_PAGE_STATE case 20: Reads a string value from the session state
  --
  procedure read_date_item_value_from_session_state
  as
  begin
    create_session(C_PAGE_UNITTEST);
    utl_apex.set_value(
      p_page_item => g_page_prefix || C_DATE_ITEM, 
      p_value => C_VALID_DATE_STRING);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_value => adc_page_state.C_FROM_SESSION_STATE,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_date(g_cgr_id, g_page_prefix || C_DATE_ITEM, null)).to_equal(C_DATE);
    ut.expect(adc_page_state.get_string(g_cgr_id, g_page_prefix || C_DATE_ITEM)).to_equal(C_VALID_DATE_STRING);
  end read_date_item_value_from_session_state;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Ignores setting a page item that has no value such as DOCUMENT or a region
  --
  procedure set_non_value_item
  as
  begin
    create_session(C_PAGE_UNITTEST);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
      p_value => C_STRING,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_page_state.get_string(g_cgr_id, adc_util.C_NO_FIRING_ITEM)).to_be_null;
  end set_non_value_item;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Resets clers the page state
  --
  procedure reset_state
  as
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => C_STRING,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.reset;
    
    ut.expect(adc_page_state.get_changed_items_as_json).to_equal('[]');
  end reset_state;
  
  
  --
  -- test ADC_PAGE_STATE case 22: Set three page items and retrieve them as a char table instance
  --
  procedure get_items_as_char_table
  as
    l_value_list char_table;
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => C_STRING,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_number_value => C_NUMBER,
      p_format_mask => C_NUMBER_FORMAT,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_date_value => C_DATE,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.get_item_values_as_char_table(
      p_cgr_id => g_cgr_id,
      p_cpi_list => g_page_prefix || C_STRING_ITEM || ',' || g_page_prefix || C_NUMBER_ITEM || ',' || g_page_prefix || C_DATE_ITEM,
      p_value_list => l_value_list);
    
    ut.expect(l_value_list.COUNT).to_equal(3);
    ut.expect(l_value_list(1)).to_equal(C_STRING);
    ut.expect(l_value_list(2)).to_equal(C_VALID_NUMBER_STRING);
    ut.expect(l_value_list(3)).to_equal(C_VALID_DATE_STRING);
  end get_items_as_char_table;
  
  
  --
  -- test ADC_PAGE_STATE case 23: Collect all changed item names and values to JSON formatted string
  --
  procedure get_changed_items_as_json
  as
    l_actual json_element_t;
    l_expected json_element_t;
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_STRING_ITEM, 
      p_value => C_STRING,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_NUMBER_ITEM, 
      p_number_value => C_NUMBER,
      p_format_mask => C_NUMBER_FORMAT,
      p_throw_error => adc_util.C_TRUE);
      
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => g_page_prefix || C_DATE_ITEM, 
      p_date_value => C_DATE,
      p_throw_error => adc_util.C_TRUE);
      
    -- ordered by item name because of removeal of double entries in the package
    l_expected := json_element_t.parse(
      '[{"id":"' || g_page_prefix || C_DATE_ITEM || '","value":"' || C_VALID_DATE_STRING || '"},' ||
      '{"id":"' || g_page_prefix || C_STRING_ITEM || '","value":"' || C_STRING || '"},' ||
      '{"id":"' || g_page_prefix || C_NUMBER_ITEM || '","value":"' || C_VALID_NUMBER_STRING || '"}]');
    l_actual := json_element_t.parse(adc_page_state.get_changed_items_as_json);
    
    ut.expect(l_expected).to_equal(l_actual);
  end get_changed_items_as_json;
  
  
  --
  -- test ADC_PAGE_STATE case 24: Set a number item and retrieve it from get_number
  --
  procedure get_number
  as
    l_page_item adc_util.ora_name_type := g_page_prefix || C_NUMBER_ITEM;
  begin
    create_session(C_PAGE_UNITTEST);
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => l_page_item, 
      p_number_value => C_NUMBER,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_number(l_page_item)).to_equal(C_NUMBER);
  end get_number;
  
  
  --
  -- test ADC_PAGE_STATE case 25: Set a number item and retrieve it from session state
  --
  procedure get_number_from_session_state
  as
    l_page_item adc_util.ora_name_type;
  begin
    create_session(C_PAGE_UNITTEST);
    l_page_item := g_page_prefix || C_NUMBER_ITEM;
    utl_apex.set_value(
      p_page_item => l_page_item, 
      p_value => C_VALID_NUMBER_STRING);
    
    ut.expect(adc_api.get_number(l_page_item)).to_equal(C_NUMBER);
  end get_number_from_session_state;
  
  
  --
  -- test ADC_PAGE_STATE case 26: Set a date item and retrieve it from get_number
  --
  procedure get_date
  as
    l_page_item adc_util.ora_name_type;
  begin
    create_session(C_PAGE_UNITTEST);
    l_page_item := g_page_prefix || C_DATE_ITEM;
    adc_page_state.set_value(
      p_cgr_id => g_cgr_id, 
      p_cpi_id => l_page_item, 
      p_date_value => C_DATE,
      p_throw_error => adc_util.C_TRUE);
    
    ut.expect(adc_api.get_date(l_page_item)).to_equal(C_DATE);
  end get_date;
  
  
  --
  -- test ADC_PAGE_STATE case 27: Set a date item and retrieve it from session state
  --
  procedure get_date_from_session_state
  as
    l_page_item adc_util.ora_name_type := g_page_prefix || C_DATE_ITEM;
  begin
    create_session(C_PAGE_UNITTEST);
    utl_apex.set_value(
      p_page_item => l_page_item, 
      p_value => C_VALID_DATE_STRING);
    
    ut.expect(adc_api.get_date(l_page_item)).to_equal(C_DATE);
  end get_date_from_session_state;
  
begin
  initialize;
end ut_adc_page_state;
/
