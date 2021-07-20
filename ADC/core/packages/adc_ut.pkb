create or replace package body adc_ut
as

  /*============ UNIT TEST ============*/ 
  g_test_mode boolean := false;
  g_test_result ut_adc_result;
  
  
  procedure set_test_mode(
    p_mode in boolean default false)
  as
  begin
    g_test_mode := p_mode;
  end set_test_mode;
  
  function get_test_mode
    return boolean
  as
  begin
    return g_test_mode;
  end get_test_mode;
  
  
  function get_test_result
    return ut_adc_result
  as
  begin
    return g_test_result;
  end get_test_result;
  
  
  function to_char_table(
    p_list item_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list recursive_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list error_stack_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := p_list(i);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list level_length_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := to_char(p_list(i));
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_ut_adc_js_list(
    p_js_list js_list)
    return ut_adc_js_list
  as
    l_test_js_list ut_adc_js_list := ut_adc_js_list();
    l_js_rec js_rec;
    l_test_js_rec ut_adc_js_rec;
  begin
    for i in 1 .. p_js_list.count loop
      l_js_rec := p_js_list(i);
      l_test_js_rec := ut_adc_js_rec(substr(l_js_rec.script, 1, 4000), l_js_rec.javascript_hash, l_js_rec.debug_level);
      l_test_js_list.extend;
      l_test_js_list(l_test_js_list.count) := l_test_js_rec;
    end loop;
    return l_test_js_list;
  end to_ut_adc_js_list;
  
  
  function to_ut_adc_row(
    p_action_rec_rec rule_action_rec)
    return ut_adc_row
  as
    l_test_row ut_adc_row;
  begin
    l_test_row := ut_adc_row(
                    -- Rule
                    p_action_rec_rec.cru_id, p_action_rec_rec.cru_sort_seq, p_action_rec_rec.cru_name, p_action_rec_rec.cru_firing_items,
                    p_action_rec_rec.cru_fire_on_page_load, p_action_rec_rec.item, p_action_rec_rec.pl_sql, p_action_rec_rec.js, 
                    p_action_rec_rec.cra_sort_seq, p_action_rec_rec.cra_param_1, p_action_rec_rec.cra_param_2, p_action_rec_rec.cra_param_3, 
                    p_action_rec_rec.cra_on_error, p_action_rec_rec.cru_on_error, p_action_rec_rec.is_first_row,
                    -- Parameters
                    g_param.id, g_param.cgr_id, g_param.firing_item, g_param.firing_event, null,
                    to_char_table(g_param.bind_items), to_char_table(g_param.page_items), to_char_table(g_param.firing_items),
                    to_char_table(g_param.error_stack),  to_char_table(g_param.recursive_stack), g_param.is_recursive, 
                    to_ut_adc_js_list(g_param.js_action_stack), to_char_table(g_param.level_length),
                    g_param.recursive_level, adc_util.bool_to_flag(g_param.allow_recursion), g_param.notification_stack, 
                    adc_util.bool_to_flag(g_param.stop_flag), g_param.now);
    return l_test_row;
  end to_ut_adc_row;
  
  
  procedure initialize_test
  as
  begin
    null;
    if g_test_mode then
      g_test_result := ut_adc_result();
    end if;
  end initialize_test;
  
  
  procedure append_test_result(
    p_action_rec in rule_action_rec default null)
  as
    l_test_row ut_adc_row;
  begin
    null;
    if g_test_mode then      
      if p_action_rec.cru_id is not null then
        l_test_row := to_ut_adc_row(p_action_rec);
        g_test_result.rule_list.extend;
        g_test_result.rule_list(g_test_result.rule_list.count) := l_test_row;
      end if;
    end if;
  end append_test_result;

end adc_ut;
/