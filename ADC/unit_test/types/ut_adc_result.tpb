create or replace type body ut_adc_result 
as

  constructor function ut_adc_result(
    self in out nocopy ut_adc_result)
    return self as result as
  begin
    self.rule_list := ut_adc_list();
    return;
  end ut_adc_result;

  constructor function ut_adc_result(
    self in out nocopy ut_adc_result,
    p_rule_list in ut_adc_list)
    return self as result as
  begin
    self.rule_list := p_rule_list;
    return;
  end ut_adc_result;

end;
/
