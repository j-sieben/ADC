create or replace package body ut_adc_runtime
as

  C_APEX_USER constant adc_util.ora_name_type := $$PLSQL_UNIT_OWNER;
  C_APP_ALIAS constant adc_util.ora_name_type := 'SADC';
  C_PAGE_ADSTA constant pls_integer := 7;
  C_PAGE_EINIT constant pls_integer := 16;
  C_PAGE_ELEMS constant pls_integer := 50;
  C_PAGE_TEST constant pls_integer := 99;
  C_COLLECTION_NAME constant adc_util.ora_name_type := 'ADC_CRG_STATUS_';
  C_SUBMIT_ACTION constant adc_util.sql_char := 'de.condes.plugin.adc.actions.submit(';

  C_STRING constant adc_util.ora_name_type := 'WILLI';
  C_NUMBER constant number := 123456.78;
  C_DATE_FORMAT constant adc_util.ora_name_type := 'yyyy-mm-dd hh24:mi:ss';
  C_VALID_DATE_STRING constant adc_util.ora_name_type := '2020-05-31 10:30:00';
  C_RELEVANT_VALUE constant adc_util.ora_name_type := 'RELEVANT';
  C_IRRELEVANT_VALUE constant adc_util.ora_name_type := 'IRRELEVANT';
  C_ERROR_VALUE constant adc_util.ora_name_type := 'ERROR';
  C_HANDLER_VALUE constant adc_util.ora_name_type := 'HANDLER';
  C_FOLLOW_UP_VALUE constant adc_util.ora_name_type := 'FOLLOW_UP';
  C_HANDLED_VALUE constant adc_util.ora_name_type := 'HANDLED';

  C_PREFIX constant adc_util.ora_name_type := 'P' || C_PAGE_TEST || '_';
  C_FIRST_NAME_ITEM constant adc_util.ora_name_type := C_PREFIX || 'FIRST_NAME';
  C_LAST_NAME_ITEM constant adc_util.ora_name_type := C_PREFIX || 'LAST_NAME';
  C_EMAIL_ITEM constant adc_util.ora_name_type := C_PREFIX || 'EMAIL';
  C_PHONE_ITEM constant adc_util.ora_name_type := C_PREFIX || 'PHONE_NUMBER';
  C_DATE_ITEM constant adc_util.ora_name_type := C_PREFIX || 'HIRE_DATE';
  C_MANDATORY_ITEM constant adc_util.ora_name_type := C_PREFIX || 'JOB_ID';
  C_NUMBER_ITEM constant adc_util.ora_name_type := C_PREFIX || 'SALARY';
  C_COMMISSION_ITEM constant adc_util.ora_name_type := C_PREFIX || 'COMMISSION_PCT';
  C_ADSTA_JOB_ITEM constant adc_util.ora_name_type := 'P7_EMP_JOB_ID';
  C_ADSTA_COMMISSION_ITEM constant adc_util.ora_name_type := 'P7_EMP_COMMISSION_PCT';
  C_EINIT_MODE_ITEM constant adc_util.ora_name_type := 'P16_PAGE_MODE';
  C_EINIT_COMMISSION_ITEM constant adc_util.ora_name_type := 'P16_EMP_COMMISSION_PCT';
  C_COMMISSION_MODE constant adc_util.ora_name_type := 'COMMISSION';
  C_ELEMS_SAVE_BUTTON constant adc_util.ora_name_type := 'B50_SPEICHERN';

  g_application_id pls_integer;

  C_MISSING_APP_ERROR constant pls_integer := -20981;
  C_MISSING_RULE_GROUP_ERROR constant pls_integer := -20982;

  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_event_data in varchar2)
  as
    l_crg_is_active boolean;
  begin
    l_crg_is_active :=
      adc_internal.read_settings(
        p_firing_item => p_firing_item,
        p_event => p_event,
        p_event_data => p_event_data);
  end read_settings;


  function get_crg_id(
    p_page_id in pls_integer)
    return pls_integer
  as
    l_crg_id pls_integer;
  begin
    select crg_id
      into l_crg_id
      from adc_rule_groups
     where crg_app_id = g_application_id
       and crg_page_id = p_page_id;

    return l_crg_id;
  end get_crg_id;


  procedure assert_rule_group_exists(
    p_page_id in pls_integer)
  as
    l_dummy pls_integer;
  begin
    begin
      l_dummy := get_crg_id(p_page_id);
    exception
      when no_data_found then
        raise_application_error(
          C_MISSING_RULE_GROUP_ERROR,
          'Test prerequisite missing: no ADC rule group exists for app alias '
          || C_APP_ALIAS
          || ' on page '
          || p_page_id
          || '.');
    end;
  end assert_rule_group_exists;


  function get_job_id(
    p_is_commission_eligible in adc_util.flag_type)
    return hr_jobs.job_id%type
  as
    l_job_id hr_jobs.job_id%type;
  begin
    select job_id
      into l_job_id
      from hr_jobs
     where job_is_commission_eligible = p_is_commission_eligible
       and rownum = 1;

    return l_job_id;
  end get_job_id;


  function is_item_mandatory(
    p_crg_id in pls_integer,
    p_cpi_id in adc_page_items.cpi_id%type)
    return boolean
  as
    l_count pls_integer;
  begin
    select count(*)
      into l_count
      from apex_collections
     where collection_name = C_COLLECTION_NAME || p_crg_id
       and c001 = p_cpi_id;

    return l_count > 0;
  end is_item_mandatory;


  procedure create_session(
    p_page_id in pls_integer)
  as
  begin
    apex_session.create_session(
      p_app_id => g_application_id,
      p_page_id => p_page_id,
      p_username => C_APEX_USER);
  end create_session;


  procedure delete_session
  as
  begin
    rollback;
    apex_session.delete_session;
  exception
    when others then
      null;
  end delete_session;


  procedure initialize_adc(
    p_page_id in pls_integer default C_PAGE_TEST)
  as
    l_result adc_util.max_char;
  begin
    create_session(p_page_id);
    apex_application.g_date_format := C_DATE_FORMAT;

    read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);

    l_result := adc_internal.process_request;
  end initialize_adc;


  procedure initialize_test_context
  as
  begin
    begin
      select application_id
        into g_application_id
        from apex_applications
       where alias = C_APP_ALIAS;
    exception
      when no_data_found then
        raise_application_error(
          C_MISSING_APP_ERROR,
          'Test prerequisite missing: sample app with alias '
          || C_APP_ALIAS
          || ' is not installed.');
    end;

    assert_rule_group_exists(C_PAGE_ADSTA);
    assert_rule_group_exists(C_PAGE_EINIT);
    assert_rule_group_exists(C_PAGE_ELEMS);
    assert_rule_group_exists(C_PAGE_TEST);
  end initialize_test_context;


  procedure before_all
  as
    pragma autonomous_transaction;
  begin
    pit.initialize;
    initialize_test_context;
  end before_all;


  procedure after_all
  as
  begin
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
    delete_session;
  end after_each;


  procedure process_request_initialize
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_initialize;


  procedure process_request_mandatory
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_MANDATORY_ITEM,
      p_value => C_STRING);

    read_settings(
      p_firing_item => C_MANDATORY_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_mandatory;


  procedure process_request_number
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_NUMBER_ITEM,
      p_value => C_NUMBER);

    read_settings(
      p_firing_item => C_NUMBER_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_number;


  procedure process_request_date
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_DATE_ITEM,
      p_value => C_VALID_DATE_STRING);

    read_settings(
      p_firing_item => C_DATE_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
  end process_request_date;


  procedure process_request_mandatory_null
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    read_settings(
      p_firing_item => C_MANDATORY_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_mandatory_null;


  procedure process_request_invalid_number
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_NUMBER_ITEM,
      p_value => C_STRING);

    read_settings(
      p_firing_item => C_NUMBER_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_invalid_number;


  procedure process_request_invalid_date
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_DATE_ITEM,
      p_value => C_STRING);

    read_settings(
      p_firing_item => C_DATE_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
  end process_request_invalid_date;


  procedure process_request_reports_firing_item
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_FIRST_NAME_ITEM,
      p_value => C_STRING);

    read_settings(
      p_firing_item => C_FIRST_NAME_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(instr(l_result, '"firingItems":["' || C_FIRST_NAME_ITEM || '"]')).to_be_greater_than(0);
  end process_request_reports_firing_item;


  procedure process_request_marks_commission_mandatory
  as
    l_result adc_util.max_char;
    l_crg_id pls_integer;
  begin
    initialize_adc(C_PAGE_ADSTA);
    l_crg_id := get_crg_id(C_PAGE_ADSTA);

    utl_apex.set_value(
      p_page_item => C_ADSTA_JOB_ITEM,
      p_value => get_job_id(adc_util.C_TRUE));

    read_settings(
      p_firing_item => C_ADSTA_JOB_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(instr(adc_internal.get_page_items, C_ADSTA_COMMISSION_ITEM)).to_be_greater_than(0);
    ut.expect(is_item_mandatory(l_crg_id, C_ADSTA_COMMISSION_ITEM)).to_be_true;
  end process_request_marks_commission_mandatory;


  procedure process_request_keeps_commission_optional
  as
    l_result adc_util.max_char;
    l_crg_id pls_integer;
  begin
    initialize_adc(C_PAGE_ADSTA);
    l_crg_id := get_crg_id(C_PAGE_ADSTA);

    utl_apex.set_value(
      p_page_item => C_ADSTA_JOB_ITEM,
      p_value => get_job_id(adc_util.C_FALSE));

    read_settings(
      p_firing_item => C_ADSTA_JOB_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(instr(adc_internal.get_page_items, C_ADSTA_COMMISSION_ITEM)).to_be_greater_than(0);
    ut.expect(is_item_mandatory(l_crg_id, C_ADSTA_COMMISSION_ITEM)).to_be_false;
  end process_request_keeps_commission_optional;


  procedure process_request_blocks_submit_on_validation_error
  as
    l_result adc_util.max_char;
  begin
    initialize_adc(C_PAGE_ELEMS);

    read_settings(
      p_firing_item => C_ELEMS_SAVE_BUTTON,
      p_event => 'click',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(instr(l_result, C_SUBMIT_ACTION)).to_equal(0);
  end process_request_blocks_submit_on_validation_error;


  procedure process_request_stops_after_error_without_handler
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_FIRST_NAME_ITEM,
      p_value => C_ERROR_VALUE);

    read_settings(
      p_firing_item => C_FIRST_NAME_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(utl_apex.get_string(C_LAST_NAME_ITEM)).to_be_null;
    ut.expect(utl_apex.get_string(C_EMAIL_ITEM)).to_be_null;
  end process_request_stops_after_error_without_handler;


  procedure process_request_executes_on_error_handler
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_FIRST_NAME_ITEM,
      p_value => C_HANDLER_VALUE);

    read_settings(
      p_firing_item => C_FIRST_NAME_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_true;
    ut.expect(utl_apex.get_string(C_LAST_NAME_ITEM)).to_be_null;
    ut.expect(utl_apex.get_string(C_EMAIL_ITEM)).to_equal(C_HANDLED_VALUE);
  end process_request_executes_on_error_handler;


  procedure process_request_recurses_after_relevant_state_change
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_FIRST_NAME_ITEM,
      p_value => C_RELEVANT_VALUE);

    read_settings(
      p_firing_item => C_FIRST_NAME_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(utl_apex.get_string(C_LAST_NAME_ITEM)).to_equal(C_RELEVANT_VALUE);
    ut.expect(utl_apex.get_string(C_EMAIL_ITEM)).to_equal(C_FOLLOW_UP_VALUE);
    ut.expect(instr(l_result, C_LAST_NAME_ITEM)).to_be_greater_than(0);
  end process_request_recurses_after_relevant_state_change;


  procedure process_request_ignores_irrelevant_state_change
  as
    l_result adc_util.max_char;
  begin
    initialize_adc;

    utl_apex.set_value(
      p_page_item => C_FIRST_NAME_ITEM,
      p_value => C_IRRELEVANT_VALUE);

    read_settings(
      p_firing_item => C_FIRST_NAME_ITEM,
      p_event => 'change',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(utl_apex.get_string(C_PHONE_ITEM)).to_equal(C_IRRELEVANT_VALUE);
    ut.expect(utl_apex.get_string(C_EMAIL_ITEM)).to_be_null;
    ut.expect(utl_apex.get_string(C_LAST_NAME_ITEM)).to_be_null;
  end process_request_ignores_irrelevant_state_change;


  procedure process_request_initializes_commission_mode
  as
    l_result adc_util.max_char;
    l_crg_id pls_integer;
  begin
    create_session(C_PAGE_EINIT);
    l_crg_id := get_crg_id(C_PAGE_EINIT);
    apex_application.g_date_format := C_DATE_FORMAT;

    utl_apex.set_value(
      p_page_item => C_EINIT_MODE_ITEM,
      p_value => C_COMMISSION_MODE);

    read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(instr(adc_internal.get_page_items, C_EINIT_COMMISSION_ITEM)).to_be_greater_than(0);
    ut.expect(is_item_mandatory(l_crg_id, C_EINIT_COMMISSION_ITEM)).to_be_true;
  end process_request_initializes_commission_mode;


  procedure process_request_initializes_default_mode
  as
    l_result adc_util.max_char;
    l_crg_id pls_integer;
  begin
    create_session(C_PAGE_EINIT);
    l_crg_id := get_crg_id(C_PAGE_EINIT);
    apex_application.g_date_format := C_DATE_FORMAT;

    read_settings(
      p_firing_item => adc_util.C_NO_FIRING_ITEM,
      p_event => 'initialize',
      p_event_data => null);
    l_result := adc_internal.process_request;

    ut.expect(adc_internal.get_error_flag).to_be_false;
    ut.expect(instr(adc_internal.get_page_items, C_EINIT_COMMISSION_ITEM)).to_be_greater_than(0);
    ut.expect(is_item_mandatory(l_crg_id, C_EINIT_COMMISSION_ITEM)).to_be_false;
  end process_request_initializes_default_mode;

end ut_adc_runtime;
/
