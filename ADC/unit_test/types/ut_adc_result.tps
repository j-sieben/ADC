create or replace type ut_adc_result 
  authid definer
as object(
  rule_list ut_adc_list,
  constructor function ut_adc_result(
    self in out nocopy ut_adc_result)
    return self as result,
  constructor function ut_adc_result(
    self in out nocopy ut_adc_result,
    p_rule_list in ut_adc_list)
    return self as result
);
/
