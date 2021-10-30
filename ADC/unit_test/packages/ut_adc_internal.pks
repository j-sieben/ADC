create or replace package ut_adc_internal
  authid definer
as

  --%suite(ADC_INTERNAL Tests)
  --%suitepath(ut_adc_internal)
  --%rollback(manual)
  
  procedure execute_ut_scenario;

  --%beforeall
  procedure before_all;
  
  --%afterall
  procedure after_all;
  
  --%beforeeach
  procedure before_each;
  
  --%aftereach
  procedure after_each;
  
  --%context(Getter methods (indirectly tests read_settings))
  
  --%test (... get_cgr_id reads the actually selected CGR_ID)
  procedure get_cgr_id;
  
  --%test (... get_cgr_id reads the actually selected CGR_ID even if read_settings was not called before)
  procedure get_cgr_id_without_preparation;
  
  --%test (... get_event reads the actually raised event)
  procedure get_event;
  
  --%test (... get_event_data returns NULL if no event data is present)
  procedure get_empty_event_data;
  
  --%test (... get_event_data returns the whole string if it is a plain string)
  procedure get_string_event_data;
  
  --%test (... get_event_data returns the the key value if it is a JSON string)
  procedure get_json_event_data;
  
  --%test (... get_event_data returns NULL if it is a JSON string and the key does not exist)
  procedure get_empty_json_event_data;
  
  --%test (... get_event_data returns NULL but registers an error if invalid JSON was supplied)
  procedure get_invalid_json_event_data;
  
  --%test (... get_error_flag returns false if no error has been registered with ADC)
  procedure get_error_flag_no_error;
  
  --%test (... get_error_flag returns true if an error has been registered with ADC)
  procedure get_error_flag_with_error;
  
  --%test (... get_firing_item returns adc_util.C_NO_FIRING_ITEM upon initialization)
  procedure get_initial_firing_item;
  
  --%test (... get_firing_item returns the name of the firing item after initialization)
  procedure get_firing_item;
  
  --%endcontext
  
  --%context(Method get_bind_items_as_json)
  
  --%test (... returns a JSON formatted string with all page items to bind event handlers to)
  procedure get_bind_items_as_json;
  
  --%test (... makes sure that all initially mandatory items are part of the bind items JSON)
  procedure find_mandatory_item_in_bind_items;
  
  --%test (... makes sure that all number items are part of the bind items JSON)
  procedure find_number_item_in_bind_items;
  
  --%test (... makes sure that all date items are part of the bind items JSON)
  procedure find_date_item_in_bind_items;
  
  --%endcontext
  
  --%context(Method get_page_items)
  
  --%test (... returns the items which have beenn touched by rules)
  procedure get_page_items;
  
  --%endcontext
  
  --%context(When checking the firing item)
  
  --%test (... proceeds normally if the firing item is C_NO_FIRING_ITEM)
  procedure process_request_initialize;
  
  --%test (... proceeds normally if the firing item is a mandatory item with a value)
  procedure process_request_mandatory;
  
  --%test (... proceeds normally if the firing item is a number item with a value)
  procedure process_request_number;
  
  --%test (... proceeds normally if the firing item is a date item with a value)
  procedure process_request_date;
  
  --%test (... registers an exception if the firing item is a mandatory item but is NULL)
  procedure process_request_mandatory_null;
  
  --%test (... registers an exception if the firing item is a number item with an invalid number)
  procedure process_request_invalid_number;
  
  --%test (... registers an exception if the firing item is a date item with an invalid date)
  procedure process_request_invalid_date;
  
  --%endcontext
  
  --%context(Public methods - ADC functionality support)
  
  --%context(Method add_javascript)
  
  --%test (... adds a javascript snippet to the response)
  procedure add_javascript;
  
  --%test (... ignores a javascript snippet that has been added before)
  procedure ignore_double_javascript;
  
  --%test (... ignores an empty javascript snippet)
  procedure ignore_empty_javascript;
  
  --%endcontext
  
  --%context(Method check_mandatory)
  
  --%test (... does not register an error if the item has a value)
  procedure check_mandatory;
  
  --%test (... registers an error and continues if the item is empty)
  procedure check_mandatory_null;
  
  --%test (... registers an error and stops rule if the item is empty and p_stop is set to true)
  procedure check_mandatory_null_stop;
  
  --%test (... ignores empty mandatory items when initializing to prevent error message upon page rendering)
  procedure check_mandatory_on_initialize;
  
  --%endcontext
  
  --%context(Method execute_action)
  
  --%test (... executes PL/SQL code and registers JavaScript snippet)
  procedure execute_action;
  
  --%test (... registers an error if an unknown action type is passed in)
  procedure execute_non_existing_action;
  
  --%test (... replaces SELECTOR parameter with css-selector)
  procedure execute_action_with_css_selector;
  
  --%endcontext
  
  /* Method raise_item_event is a wrapper around adc_recursion_stack.push_firing_item which is tested there.*/
  
  --%context(Method register_error)
  
  --%test (... registers an exception with ADC)
  procedure register_error;
  
  --%test (... registers an exception based on a PIT message with ADC)
  procedure register_error_message;
  
  --%endcontext
  
  --%context(Method register_mandatory)
  
  --%test (... makes a page item mandatory that was optional before)
  procedure register_mandatory;
  
  --%test (... throws an exception if a dynamically set mandatory item is set to null)
  procedure register_mandatory_validate;
  
  --%test (... resets a initially mandatory item to be optional)
  procedure reset_mandatory;
  
  --%test (... does not throw an error if an optional page item that has been mandatory is set to null)
  procedure reset_mandatory_validate;
  
  --%endcontext
  
  --%endcontext

end ut_adc_internal;
/
