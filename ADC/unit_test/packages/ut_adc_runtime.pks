create or replace package ut_adc_runtime
  authid definer
as

  --%suite(ADC Runtime Tests)
  --%suitepath(ut_adc_runtime)
  --%rollback(manual)
  --
  -- Integration tests for ADC runtime processing.
  -- Requires the sample application with alias SADC and ADC rule groups on pages 7, 16, 50 and 99.

  --%beforeall
  procedure before_all;

  --%afterall
  procedure after_all;

  --%beforeeach
  procedure before_each;

  --%aftereach
  procedure after_each;

  --%context(Method process_request)

  --%test (... processes initialize without raising an ADC error)
  procedure process_request_initialize;

  --%test (... processes a mandatory item with value without raising an ADC error)
  procedure process_request_mandatory;

  --%test (... processes a number item with a valid value without raising an ADC error)
  procedure process_request_number;

  --%test (... processes a date item with a valid value without raising an ADC error)
  procedure process_request_date;

  --%test (... registers an ADC error if a mandatory item is empty)
  procedure process_request_mandatory_null;

  --%test (... registers an ADC error for an invalid number)
  procedure process_request_invalid_number;

  --%test (... registers an ADC error for an invalid date)
  procedure process_request_invalid_date;

  --%test (... reports the firing item in the runtime response)
  procedure process_request_reports_firing_item;

  --%endcontext

  --%context(Rule selection and recursion)

  --%test (... marks commission as mandatory for a commission-eligible job)
  procedure process_request_marks_commission_mandatory;

  --%test (... keeps commission optional for a non commission-eligible job)
  procedure process_request_keeps_commission_optional;

  --%test (... reevaluates rules after a relevant recursive state change)
  procedure process_request_recurses_after_relevant_state_change;

  --%test (... does not recurse after an irrelevant state change)
  procedure process_request_ignores_irrelevant_state_change;

  --%endcontext

  --%context(Validation dependent actions)

  --%test (... does not generate a submit action if page validation fails)
  procedure process_request_blocks_submit_on_validation_error;

  --%test (... aborts normal actions after an error without an error handler)
  procedure process_request_stops_after_error_without_handler;

  --%test (... continues with an on-error action after an error)
  procedure process_request_executes_on_error_handler;

  --%endcontext

  --%context(Extended initialization)

  --%test (... marks commission mandatory if the page opens in COMMISSION mode)
  procedure process_request_initializes_commission_mode;

  --%test (... keeps commission optional if the page opens in a non COMMISSION mode)
  procedure process_request_initializes_default_mode;

  --%endcontext

end ut_adc_runtime;
/
