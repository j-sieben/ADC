create or replace package adc_ut
  authid definer
as
  
  procedure set_test_mode(
    p_mode in boolean default false);
  
  function get_test_mode
    return boolean;
  
  
  function get_test_result
    return ut_adc_result;
  
  
  function to_char_table(
    p_list item_stack_t)
    return char_table;
  
  
  function to_char_table(
    p_list recursive_stack_t)
    return char_table;
  
  
  function to_char_table(
    p_list error_stack_t)
    return char_table;
  
  
  function to_ut_adc_js_list(
    p_js_list js_list)
    return ut_adc_js_list;
  
  
  function to_ut_adc_row(
    p_action_rec_rec rule_action_rec)
    return ut_adc_row;
  
  
  procedure initialize_test;
  
  
  procedure append_test_result(
    p_action_rec in rule_action_rec default null);
    
end adc_ut;
/