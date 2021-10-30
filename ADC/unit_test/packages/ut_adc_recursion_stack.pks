create or replace package ut_adc_recursion_stack
  authid definer
as

  --%suite(ADC RECURSION STACK Tests)
  --%suitepath(ut_adc_page_state)
  --%rollback(manual)

  --%beforeall
  procedure before_all;
  
  --%afterall
  procedure after_all;
  
  --%beforeeach
  procedure before_each;
  
  --%aftereach
  procedure after_each;
  
  --%context(Method push_firing_item)
  
  --%test (... does not push adc_util.C_NO_FIRING_ITEM onto the recursive stack)
  procedure push_no_firing_item;
  
  --%test (... pushes a required item onto the recursive stack)
  procedure push_firing_item;
  
  --%test (... pushes a required item and retrieves it with get_next method)
  procedure push_and_get_firing_item;
  
  --%test (... ignores the second registration of a required item if it is already known)
  procedure push_firing_item_twice;
  
  --%test (... ignores a required item if it has been on the stack before)
  procedure push_pop_push_firing_item;
  
  --%test (... pushes a second firing item onto the stack at level 2)
  procedure push_two_firing_items;
  
  --%test (... pushes two firings and pops the first item, leaving the second item on level 2)
  procedure push_two_firing_items_and_pop_first;
  
  --%test (... pushes and pops an item and then pushes a new item. This is on level 1)
  procedure push_pop_push;
  
  --%test (... pushes two items and pops them. The stack is on level 0)
  procedure push_pop;
  
  --%endcontext
  
  --%context(Method pop_firing_item)
  
  --%test (... pushes an items and pops it. The stack is on level 0)
  procedure pop_item;
  
  --%test (... does not throw an exception, if it is called on an empty stack)
  procedure pop_empty_stack;
  
  --%test (... empties the stack completely if requested by parameter P_ALL)
  procedure pop_stack_completely;
  
  --%test (... ignores it if an item has to be popped that is not on the stack)
  procedure pop_item_not_on_stack;
  
  --%endcontext
  
  --%context(Method reset)
    
  --%test (... cleans the stack and initializes it, recursive stack is empty)
  procedure reset_initial;
    
  --%test (... cleans the stack and initializes it with a firing item passed in by P_CPI_ID)
  procedure reset_with_item;
    
  --%test (... throws an exception if P_CGR_ID is missing)
  --%throws (msg.ASSERT_IS_NOT_NULL_ERR)
  procedure reset_without_cgr_id;
  
  --%endcontext
  
  --%context(Method get_firing_items_as_json)
    
  --%test (... retrieves a JSON formatted string including all firing items)
  procedure get_firing_items;
    
  --%test (... retrieves an empty JSON formatted string if the stack is empty)
  procedure get_no_firing_items;
    
  --%endcontext

  --%afterall

end ut_adc_recursion_stack;
/
