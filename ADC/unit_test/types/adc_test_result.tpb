create or replace type body adc_test_result 
as

  constructor function adc_test_result(
    self in out nocopy adc_test_result)
    return self as result as
  begin
    self.rule_list := adc_test_list();
    return;
  end adc_test_result;

  constructor function adc_test_result(
    self in out nocopy adc_test_result,
    p_rule_list in adc_test_list)
    return self as result as
  begin
    self.rule_list := p_rule_list;
    return;
  end adc_test_result;

end;
/
