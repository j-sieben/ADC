create or replace type adc_test_result 
  authid definer
as object(
  rule_list adc_test_list,
  constructor function adc_test_result(
    self in out nocopy adc_test_result)
    return self as result,
  constructor function adc_test_result(
    self in out nocopy adc_test_result,
    p_rule_list in adc_test_list)
    return self as result
);
/
