create or replace package ut_adc
  authid definer
as

  --%suite(ADC Tests)
  --%suitepath(ut_adc)
  --%rollback(manual)

  --%beforeall
  procedure before_all;
  
  --%beforeeach
  procedure before_each;
  
  --%afterall
  procedure after_all;
  
  --%aftereach
  procedure after_each;
  
  
  --%aftereach
  procedure persist_outcome;
  
  --%context(Plugin ADC)
  
  --%test (identifies 3 well known items as relevant when rendering page ADMIN_CRG of the ADC application)
  procedure render_plugin;
  
  --%test (executes 1 rule with 1 action if setting item P1_CRG_ID to the ID of ADC_ADMIN_CRG rule group)
  procedure refresh_plugin;
  
  --%endcontext
  
  --%context(ADC core functionality)

  --%test(gets the event that was passed in using GET_EVENT)
  procedure get_event;

  --%test(gets the firing item that was passed in using GET_FIRING_ITEM)
  procedure get_firing_item;

  --%test(gets the session state of a page item using GET_CHAR)
  procedure get_char;

  --%test(gets the default of a page item if its session state is NULL using GET_CHAR)
  procedure get_char_default;
  
  --%context(when converting session state)

  --%test(correctly converts a page item to DATE based on format mask using GET_DATE)
  procedure get_date;

  --%test(succesfully checks whether a page item contains a DATE)
  procedure check_date;

  --%test(throws an excpetion if a page item doesn't contain a DATE)
  --%throws(-1830)
  procedure check_no_date;

  --%test(correctly converts a page item to NUMBER based on format mask using GET_NUMBER)
  procedure get_number;

  --%test(succesfully checks whether a page item contains a NUMBER)
  procedure check_number;

  --%test(throws an excpetion if a page item doesn't contain a NUMBER)
  procedure check_no_number;
  
  --%endcontext
  
  --%context(when controlling behaviour of the target page)

  --%test(adds a custom javascript block to the response using ADD_JAVASCRIPT)
  procedure add_javascript;
  
  --%test
  procedure check_mandatory;

  --%test
  procedure exclusive_or;

  --%test
  procedure execute_javascript;

  --%test
  procedure execute_plsql;

  --%test
  procedure has_errors;

  --%test
  procedure has_no_errors;

  --%test
  procedure not_null;

  --%test
  procedure notify;
  
  --%endcontext

  --%test
  procedure register_error;

  --%test
  procedure register_mandatory;

  --%test
  procedure register_notification;

  --%test
  procedure set_list_from_stmt;

  --%test
  procedure set_session_state;

  --%test
  procedure set_session_state_or_error;

  --%test
  procedure set_value_from_stmt;

  --%test
  procedure stop_rule;

  --%test
  procedure validate_page;

  --%test
  procedure toggle_item_mandatory;

  --%test
  procedure toggle_item_status;

  --%test
  procedure toggle_item_visibility;

  --%test
  procedure refresh_item;

  --%test
  procedure set_item;

  --%test
  procedure set_focus;

  --%test
  procedure execute_apex_action;

  --%test
  procedure execute_java_script;

  --%test
  procedure write_to_console;
  
  --%endcontext

  --%afterall (Test Suite herunterfahren)
  procedure tear_down;

end ut_adc;
/
