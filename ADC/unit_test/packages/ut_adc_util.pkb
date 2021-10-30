create or replace package body ut_adc_util
as
  
  procedure before_all
  as
    pragma autonomous_transaction;
  begin
    pit.initialize;
    pit.set_context('DEFAULT');
    null;
  end before_all;
  
  
  procedure after_all
  as
  begin
    pit.reset_context;
  end after_all;
  
  
  procedure before_each
  as
  begin
    null;
  end before_each;
  
  
  procedure after_each
  as
  begin
    null;
  end after_each;
  
  
  --
  -- test ADC_PAGE_STATE case 1: Read TRUE value as FLAG_TYPE
  --
  procedure get_true
  as
  begin
    ut.expect(adc_util.c_true).to_be_not_null;
  end get_true;
  
  
  --
  -- test ADC_PAGE_STATE case 2: Read FALSE value as FLAG_TYPE
  --
  procedure get_false
  as
  begin
    ut.expect(adc_util.c_false).to_be_not_null;
  end get_false;
  
  
  --
  -- test ADC_PAGE_STATE case 3: Read Replacement char for #
  --
  procedure get_hash
  as
  begin
    ut.expect(adc_util.c_hash).to_be_not_null;
  end get_hash;
  
  
  --
  -- test ADC_PAGE_STATE case 4: 1 is casted to C_TRUE
  --
  procedure get_boolean_for_1
  as
  begin
    ut.expect(adc_util.get_boolean(1)).to_equal(adc_util.C_TRUE);
  end get_boolean_for_1;
  
  
  --
  -- test ADC_PAGE_STATE case 5: Y is casted to C_TRUE
  --
  procedure get_boolean_for_Y
  as
  begin
    ut.expect(adc_util.get_boolean('Y')).to_equal(adc_util.C_TRUE);
  end get_boolean_for_Y;
  
  
  --
  -- test ADC_PAGE_STATE case 6: 0 is casted to C_FALSE
  --
  procedure get_boolean_for_0
  as
  begin
    ut.expect(adc_util.get_boolean(0)).to_equal(adc_util.C_FALSE);
  end get_boolean_for_0;
  
  
  --
  -- test ADC_PAGE_STATE case 7: N is casted to C_FALSE
  --
  procedure get_boolean_for_N
  as
  begin
    ut.expect(adc_util.get_boolean('N')).to_equal(adc_util.C_FALSE);
  end get_boolean_for_N;
  
  
  --
  -- test ADC_PAGE_STATE case 8: NULL is casted to C_FALSE
  --
  procedure get_boolean_for_NULL
  as
  begin
    ut.expect(adc_util.get_boolean(null)).to_equal(adc_util.C_FALSE);
  end get_boolean_for_NULL;
  
  
  --
  -- test ADC_PAGE_STATE case 9: true is casted to C_FALSE
  --
  procedure cast_true_to_c_true
  as
  begin
    ut.expect(adc_util.bool_to_flag(true)).to_equal(adc_util.C_TRUE);
  end cast_true_to_c_true;
  
  
  --
  -- test ADC_PAGE_STATE case 10: false is casted to C_TRUE
  --
  procedure cast_false_to_c_false
  as
  begin
    ut.expect(adc_util.bool_to_flag(false)).to_equal(adc_util.C_FALSE);
  end cast_false_to_c_false;
  
  
  --
  -- test ADC_PAGE_STATE case 11: false is casted to C_FALSE
  --
  procedure cast_null_to_c_false
  as
  begin
    ut.expect(adc_util.bool_to_flag(null)).to_equal(adc_util.C_FALSE);
  end cast_null_to_c_false;
  
  
  --
  -- test ADC_PAGE_STATE case 12: C_TRUE is casted to 'adc_util.C_TRUE'
  --
  procedure cast_c_true_to_true
  as
  begin
    ut.expect(adc_util.to_bool(adc_util.C_TRUE)).to_equal('adc_util.C_TRUE');
  end cast_c_true_to_true;
  
  
  --
  -- test ADC_PAGE_STATE case 13: C_FALSE is casted to 'adc_util.C_FALSE'
  --
  procedure cast_c_false_to_false
  as
  begin
    ut.expect(adc_util.to_bool(adc_util.C_FALSE)).to_equal('adc_util.C_FALSE');
  end cast_c_false_to_false;
  
  
  --
  -- test ADC_PAGE_STATE case 14: NULL is casted to 'adc_util.C_FALSE'
  --
  procedure cast_null_to_false
  as
  begin
    ut.expect(adc_util.to_bool(null)).to_equal('adc_util.C_FALSE');
  end cast_null_to_false;
  
  
  --
  -- test ADC_PAGE_STATE case 15: remove blanks from name
  --
  procedure sanitize_blanks_from_name
  as
  begin
    ut.expect(adc_util.clean_adc_name('NAME WITH BLANKS')).to_equal('NAME_WITH_BLANKS');
  end sanitize_blanks_from_name;
  
  
  --
  -- test ADC_PAGE_STATE case 16: remove quotations from name
  --
  procedure sanitize_quotations_from_name
  as
  begin
    ut.expect(adc_util.clean_adc_name('"NAME_WITH_QUOTATIONS"')).to_equal('NAME_WITH_QUOTATIONS');
  end sanitize_quotations_from_name;
  
  
  --
  -- test ADC_PAGE_STATE case 17: convert name to upper case
  --
  procedure sanitize_name_spelling
  as
  begin
    ut.expect(adc_util.clean_adc_name('Mixed_Case')).to_equal('MIXED_CASE');
  end sanitize_name_spelling;
  
  
  --
  -- test ADC_PAGE_STATE case 18: limit length to 50 chars
  --
  procedure sanitize_name_length
  as
  begin
    ut.expect(length(adc_util.clean_adc_name('A very long name that for sure exceeds the mark of 50 characters for a single name'))).to_equal(50);
  end sanitize_name_length;
  
  
  --
  -- test ADC_PAGE_STATE case 19: Wrapper around PIT.get_trans_item_name returns a value
  --
  procedure get_trans_item_name_normal_execution
  as
  begin
    ut.expect(adc_util.get_trans_item_name('CRA_NO_HELP')).to_be_not_null;
  end get_trans_item_name_normal_execution;
  
  
  --
  -- test ADC_PAGE_STATE case 20: Wrapper around PIT.get_trans_item_name throws an exception for a non existing entry
  --
  procedure get_trans_item_name_not_existing
  as
    l_result adc_util.max_char;
  begin
    l_result := adc_util.get_trans_item_name('FOO');
  end get_trans_item_name_not_existing;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Method closes a cursor
  --
  procedure close_cursor_closes_cursor
  as
    l_cursor sys_refcursor;
  begin
    open l_cursor for select sysdate from dual;
    
    adc_util.close_cursor(l_cursor);
    
    ut.expect(l_cursor%ISOPEN).to_be_false;
    
  end close_cursor_closes_cursor;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Method ignores closed cursor
  --
  procedure close_cursor_ignores_closed_cursors
  as
    l_cursor sys_refcursor;
  begin
    open l_cursor for select sysdate from dual;
    close l_cursor;
    adc_util.close_cursor(l_cursor);
    
    ut.expect(l_cursor%ISOPEN).to_be_false;
    
  end close_cursor_ignores_closed_cursors;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Monitor loop is ok up to 100 iterations
  --
  procedure monitor_loop_accepts_up_to_99
  as
  begin
    for i in 1 .. 99 loop
      adc_util.monitor_loop(i, 'FOO');
    end loop;
  end monitor_loop_accepts_up_to_99;
  
  
  --
  -- test ADC_PAGE_STATE case 21: Monitor loop is ok up to 100 iterations
  --
  procedure monitor_loop_breaks_when_100
  as
  begin
    for i in 1 .. 100 loop
      adc_util.monitor_loop(i, 'FOO');
    end loop;
  end monitor_loop_breaks_when_100;
  
end ut_adc_util;
/
