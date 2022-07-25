create or replace package body ut_adc_recursion_stack
as

  C_APEX_USER constant adc_util.ora_name_type := $$PLSQL_UNIT_OWNER;
  
  -- Aplication pages
  C_APP_ALIAS constant adc_util.ora_name_type := 'ADC';
  C_PAGE_DESIGNER constant number := 13;
  
  -- Items
  g_cgr_id adc_rule_groups.cgr_id%type;
  g_application_id number;
  g_page_prefix adc_util.ora_name_type := 'P' || C_PAGE_DESIGNER || '_';
  
  C_CGR_APP_ID_ITEM constant adc_util.ora_name_type := g_page_prefix || 'CGR_APP_ID';
  C_CRA_CAT_ID_ITEM constant adc_util.ora_name_type := g_page_prefix || 'CRA_CAT_ID';
  C_CRU_CONDITION_ITEM constant adc_util.ora_name_type := g_page_prefix || 'CRU_CONDITION';  
  C_COMMAND constant adc_util.ora_name_type := 'COMMAND';
  C_HIERARCHY_REGION constant adc_util.ora_name_type := 'R' || C_PAGE_DESIGNER || '_HIERARCHY';
  C_RULES_REGION constant adc_util.ora_name_type := 'R' || C_PAGE_DESIGNER || '_RULES';
  

  procedure create_session
  as
  begin    
    apex_session.create_session(
       p_app_id => g_application_id,
       p_page_id => C_PAGE_DESIGNER,
       p_username => C_APEX_USER);
    
    -- get CGR for the rule group of the selected page
    select cgr_id
      into g_cgr_id
      from adc_rule_groups
     where cgr_app_id = g_application_id
       and cgr_page_id = C_PAGE_DESIGNER;
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
    pit.set_context('DEFAULT');
    null;
  end before_all;
  
  
  procedure after_all
  as
  begin
    pit.reset_context;
    delete_session;
  end after_all;
  
  
  procedure before_each
  as
  begin
    null;
  end before_each;
  
  
  procedure after_each
  as
  begin
    adc_recursion_stack.reset(
      p_cgr_id => g_cgr_id,
      p_cpi_id => adc_util.C_NO_FIRING_ITEM);
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
  -- test ADC_RECURSION_STACK case 1: Ignores C_NO_FIRING_ITEM for the recursive stack
  --
  procedure push_no_firing_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => adc_util.C_NO_FIRING_ITEM);
    
    ut.expect(adc_recursion_stack.get_next).to_be_null;
  end push_no_firing_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 2: Pushes a required item onto the recursive stack
  --
  procedure push_firing_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(1);
  end push_firing_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 3: Pushes a required item which is available using get_next
  --
  procedure push_and_get_firing_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_next).to_equal(C_CRA_CAT_ID_ITEM);
  end push_and_get_firing_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 4: Pushes a required item twice but the second call is ignored
  --
  procedure push_firing_item_twice
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(1);
  end push_firing_item_twice;
  
  
  --
  -- test ADC_RECURSION_STACK case 5: Pushes, pops and pushes again a required itembut the second call is ignored
  --
  procedure push_pop_push_firing_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(0);
  end push_pop_push_firing_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 6: Pushes tow different items onto the stack, the second is on level 2
  --
  procedure push_two_firing_items
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(2);
  end push_two_firing_items;
  
  
  --
  -- test ADC_RECURSION_STACK case 7: Pushes tow items and pop the first, the stays on level 2
  --
  procedure push_two_firing_items_and_pop_first
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(2);
  end push_two_firing_items_and_pop_first;
  
  
  --
  -- test ADC_RECURSION_STACK case 7: Pushes two items and pop the first, the second stays on level 2
  --
  procedure push_pop_push
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(1);
  end push_pop_push;
  
  
  --
  -- test ADC_RECURSION_STACK case 9: Pushes two items and pop both, the stack is empty
  --
  procedure push_pop
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CGR_APP_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(0);
  end push_pop;
  
  
  --
  -- test ADC_RECURSION_STACK case 10: Pushes an items and pops it, the stack is empty
  --
  procedure pop_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(0);
  end pop_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 11: Pops an items from an empty stack, no error is thrown
  --
  procedure pop_empty_stack
  as
  begin
    create_session;
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CRA_CAT_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(0);
  end pop_empty_stack;
  
  
  --
  -- test ADC_RECURSION_STACK case 12: Clears the stack if requested
  --
  procedure pop_stack_completely
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => null,
      p_all => adc_util.C_TRUE);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(0);
  end pop_stack_completely;
  
  
  --
  -- test ADC_RECURSION_STACK case 13: Ignores it if a non existing item is popped
  --
  procedure pop_item_not_on_stack
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.pop_firing_item(
      p_cpi_id => C_CGR_APP_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_level).to_equal(1);
  end pop_item_not_on_stack;
  
  
  --
  -- test ADC_RECURSION_STACK case 14: Cleans and initializes the stack
  --
  procedure reset_initial
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.reset(
      p_cgr_id => g_cgr_id,
      p_cpi_id => adc_util.C_NO_FIRING_ITEM);
    
    ut.expect(adc_recursion_stack.get_next).to_be_null;
  end reset_initial;
  
  
  --
  -- test ADC_RECURSION_STACK case 15: Cleans and initializes the stack
  --
  procedure reset_with_item
  as
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.reset(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM);
    
    ut.expect(adc_recursion_stack.get_next).to_equal(C_CGR_APP_ID_ITEM);
  end reset_with_item;
  
  
  --
  -- test ADC_RECURSION_STACK case 16: throws an exception if P_CGR_ID is missing
  --
  procedure reset_without_cgr_id
  as
  begin
    create_session;
    
    adc_recursion_stack.reset(
      p_cgr_id => null,
      p_cpi_id => adc_util.C_NO_FIRING_ITEM);
    
  end reset_without_cgr_id;
  
  
  --
  -- test ADC_RECURSION_STACK case 17: retrieves a JSON with all firing items
  --
  procedure get_firing_items
  as
    l_actual json_element_t;
    l_expected json_element_t;
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CRA_CAT_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_CGR_APP_ID_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    l_expected := json_element_t.parse('["' || C_CRA_CAT_ID_ITEM || '","' || C_CGR_APP_ID_ITEM || '"]');
    l_actual := json_element_t.parse(adc_recursion_stack.get_firing_items_as_json);
    
    ut.expect(l_expected).to_equal(l_actual);    
  end get_firing_items;
  
  
  --
  -- test ADC_RECURSION_STACK case 18: retrieves an empty JSON array if no firing items are on stack
  --
  procedure get_no_firing_items
  as
    l_actual json_element_t;
    l_expected json_element_t;
  begin
    create_session;
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_allow_recursion => adc_util.C_TRUE);
    
    adc_recursion_stack.push_firing_item(
      p_cgr_id => g_cgr_id,
      p_cpi_id => C_COMMAND,
      p_allow_recursion => adc_util.C_TRUE);
    
    l_expected := json_element_t.parse('[]');
    l_actual := json_element_t.parse(adc_recursion_stack.get_firing_items_as_json);
    
    ut.expect(l_actual).to_equal(l_expected);    
  end get_no_firing_items;
  
begin
  initialize;
end ut_adc_recursion_stack;
/
