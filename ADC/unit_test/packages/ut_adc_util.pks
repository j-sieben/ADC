create or replace package ut_adc_util
  authid definer
as

  --%suite(ADC_UTIL Tests)
  --%suitepath(ut_adc_util)
  --%rollback(manual)

  --%beforeall
  procedure before_all;
  
  --%afterall
  procedure after_all;
  
  --%beforeeach
  procedure before_each;
  
  --%aftereach
  procedure after_each;
  
  --%context(Getter methods)
  
  --%test (... retrieves a boolean true value as FLAG_TYPE)
  procedure get_true;
        
  --%test (... retrieves a boolean true value as FLAG_TYPE)
  procedure get_false;
        
  --%test (... retrieves a replacement value for the # sign to avoid problems with UTL_TEXT)
  procedure get_hash;
        
  --%test (... interpret 1 to be true)
  procedure get_boolean_for_1;
        
  --%test (... interpret Y to be true)
  procedure get_boolean_for_Y;
        
  --%test (... interpret 0 to be false)
  procedure get_boolean_for_0;
        
  --%test (... interpret N to be false)
  procedure get_boolean_for_N;
        
  --%test (... interpret NULL to be false)
  procedure get_boolean_for_NULL;
  
  --%endcontext
        
  --%context(Cast methods)
  
  --%test (... cast true to C_TRUE)
  procedure cast_true_to_c_true;
        
  --%test (... cast false to C_FALSE)
  procedure cast_false_to_c_false;
        
  --%test (... cast NULL to C_FALSE)
  procedure cast_null_to_c_false;
        
  --%test (... cast C_TRUE to 'adc_util.C_TRUE')
  procedure cast_c_true_to_true;
        
  --%test (... cast C_FALSE to 'adc_util.C_FALSE')
  procedure cast_c_false_to_false;
        
  --%test (... cast NULL to 'adc_util.C_FALSE')
  procedure cast_null_to_false;
  
  --%endcontext
        
  --%context(Method clean_adc_name)
  
  --%test (... removes blanks from name)
  procedure sanitize_blanks_from_name;
  
  --%test (... removes quotation marks from name)
  procedure sanitize_quotations_from_name;
  
  --%test (... converts name to upper case)
  procedure sanitize_name_spelling;
  
  --%test (... limits to 50 chars)
  procedure sanitize_name_length;
  
  --%endcontext
        
  --%context(Method get_trans_item_name)
  
  --%test (... returns a value for an existing translatable item)
  procedure get_trans_item_name_normal_execution;
  
  --%test (... throws an exception for a non existing item)
  --%throws (NO_DATA_FOUND)
  procedure get_trans_item_name_not_existing;
  
  --%endcontext
        
  --%context(Method close_cursor)
  
  --%test (... closes and open cursor)
  procedure close_cursor_closes_cursor;
  
  --%test (... does nothing if the cursor is already closed)
  procedure close_cursor_ignores_closed_cursors;
  
  --%endcontext
        
  --%context(Method monitor_loop)
  
  --%test (... monitor loop does nothing for up to 99 iterations)
  procedure monitor_loop_accepts_up_to_99;
  
  --%test (... monitor loop throws an excpetion over 99 iterations)
  --%throws (msg.ADC_INFINITE_LOOP_ERR)
  procedure monitor_loop_breaks_when_100;
  
  --%endcontext

end ut_adc_util;
/
