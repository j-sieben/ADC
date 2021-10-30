create or replace package ut_adc_page_state
  authid definer
as

  --%suite(ADC Tests)
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
  
  --%context(Method set_value)
  
  --%test (... sets a given item value as String)
  procedure set_item_value_as_string;
        
  --%test (... sets a given item value and makes its value available in the page state cache)
  procedure set_and_read_item_value;
        
  --%test (... sets a number item value if passed in as number)
  procedure set_item_value_as_number;
        
  --%test (... sets a number item value if passed in as String, appliyng a conversion)
  procedure set_number_item_value_as_string;
        
  --%test (... raises an exception if a number item value is set using an invalid number string)
  --%throws (msg.ADC_INVALID_NUMBER_ERR)
  procedure set_number_item_value_as_invalid_string;
        
  --%test (... sets a number item valueif passed in as String with explicit format mask)
  procedure set_number_item_value_explicit_format;
  
  --%test (... throws an exception if an invalid format mask is passed in)
  --%throws (msg.ADC_INVALID_NUMBER_ERR)
  procedure set_number_item_value_invalid_format_mask;  
  
  --%test (... throws an exception if a string value to convert to number is longer than the format mask)
  --%throws (msg.ADC_INVALID_NUMBER_ERR)
  procedure set_number_item_value_string_too_long;  
        
  --%test (... sets a date item value if passed in as date)
  procedure set_item_value_as_date;
        
  --%test (... sets a date item value as String, appliyng a conversion)
  procedure set_date_item_value_as_string;
        
  --%test (... sets a date item value as String with explicit format mask)
  procedure set_date_item_value_explicit_format;
        
  --%test (... raises an exception if a date item value is set using an invalid date string)
  --%throws (msg.ADC_INVALID_DATE_ERR)
  procedure set_date_item_value_as_invalid_string;
  
  --%test (... throws an exception if an invalid format mask is passed in)
  --%throws (msg.ADC_INVALID_DATE_ERR)
  procedure set_date_item_value_invalid_format_mask;  
  
  --%test (... throws an exception if an invalid date (invalid day for month, invalid month, invalid year etc.) is passed in)
  --%throws (msg.ADC_INVALID_DATE_ERR)
  procedure set_date_item_value_invalid_date;  
        
  --%test (... resets a string item value to NULL)
  procedure reset_string_item_value_to_null;
        
  --%test (... resets a number item value to NULL)
  procedure reset_number_item_value_to_null;
        
  --%test (... resets a date item value to NULL)
  procedure reset_date_item_value_to_null;
        
  --%test (... harmonizes a string item value with the session state)
  procedure read_string_item_value_from_session_state;
        
  --%test (... harmonizes a number item value with the session state)
  procedure read_number_item_value_from_session_state;
        
  --%test (... harmonizes a date item value with the session state)
  procedure read_date_item_value_from_session_state;
        
  --%test (... ignores it if an item is set that is no value item such as DOCUMENT or a region)
  procedure set_non_value_item;
  
  --%endcontext
        
  --%context(Method reset)
  
  --%test (... clears the page state)
  procedure reset_state;
  
  --%endcontext
        
  --%context(Method get_item_values_as_char_table)
  
  --%test (... sets and retrieves page items as char table instance)
  procedure get_items_as_char_table;
  
  --%endcontext
        
  --%context(Method get_changed_items_as_json)
  
  --%test (... collects all changed items in a JSON formatted string)
  procedure get_changed_items_as_json;
  
  --%endcontext
        
  --%context(Method get_number)
  
  --%test (... retrieves a page item as number from page state cache)
  procedure get_number;
  
  --%test (... reads a page item as number from session state if it does not exist in page state cache)
  procedure get_number_from_session_state;  
  
  --%endcontext
        
  --%context(Method get_date)
  
  --%test (... retrieves a page item as date from page state cache)
  procedure get_date;
  
  --%test (... reads a page item as date from session state if it does not exist in page state cache)
  procedure get_date_from_session_state;  
  
  --%endcontext

  --%afterall

end ut_adc_page_state;
/
