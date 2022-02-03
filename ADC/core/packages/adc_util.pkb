create or replace package body adc_util
as
  

  /**
    Package: ADC_UTIL Body
      Provides data types, constants and generic helper functions for ADC.

    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Public Methods
   */
  g_loop_counter binary_integer;

  
  /**
    Function C_TRUE
      See <ADC_UTIL.C_TRUE>
   */
  function c_true
    return flag_type
  as
  begin
    return &C_TRUE.;
  end c_true;

  
  /**
    Function C_FALSE
      See <ADC_UTIL.C_FALSEE>
   */
  function c_false
    return flag_type
  as
  begin
    return &C_FALSE.;
  end c_false;

  
  /**
    Function C_HASH
      See <ADC_UTIL.C_HASH>
   */
  function c_hash
    return varchar2
  as
  begin
    return '\u0023';
  end c_hash;

  
  /**
    Function get_boolean
      See <ADC_UTIL.get_boolean>
   */
  function get_boolean(
    p_bool in varchar2)
    return adc_util.flag_type
  as
  begin
    if p_bool in ('J', 'Y', '1') then
      return adc_util.C_TRUE;
    else
      return adc_util.C_FALSE;
    end if;
  end get_boolean;

  
  /**
    Function to_bool
      See <ADC_UTIL.to_bool>
   */
  function to_bool(
    p_bool in flag_type)
    return varchar2
  as
  begin
    return case p_bool when C_TRUE then 'adc_util.C_TRUE' else 'adc_util.C_FALSE' end;
  end to_bool;

  
  /**
    Function bool_to_flag
      See <ADC_UTIL.bool_to_flag>
   */
  function bool_to_flag(
    p_bool in boolean)
    return adc_util.flag_type
  as
  begin
    if p_bool then
      return C_TRUE;
    else
      return C_FALSE;
    end if;
  end bool_to_flag;

  
  /**
    Function clean_adc_name
      See <ADC_UTIL.clean_adc_name>
   */
  function clean_adc_name(
    p_name in varchar2)
    return varchar2
  as
    l_name ora_name_type;
  begin
    l_name := replace(replace(p_name, '"'), ' ', '_');
    l_name := upper(substr(l_name, 1, 50));
    return l_name;
  end clean_adc_name;

  
  /**
    Function get_trans_item_name
      See <ADC_UTIL.get_trans_item_name>
   */
  function get_trans_item_name(
    p_item in varchar2,
    p_msg_args in msg_args default null)
    return varchar2
  as
  begin
    return pit.get_trans_item_name(C_ADC, p_item, p_msg_args);
  end get_trans_item_name;

  
  /**
    Function close_cursor
      See <ADC_UTIL.close_cursor>
   */
  procedure close_cursor(
    p_cur in sys_refcursor)
  as
  begin
    pit.enter_detailed('close_cursor');
    
    if p_cur%ISOPEN then
      close p_cur;
    end if;
    
    pit.leave_detailed;
  end close_cursor;

  
  /**
    Function monitor_loop
      See <ADC_UTIL.monitor_loop>
   */
  procedure monitor_loop(
    p_counter in number default null,
    p_loop_name in varchar2 default null)
  as
  begin
    g_loop_counter := coalesce(p_counter, 0) + 1;
    
    if g_loop_counter > 100 then
      pit.error(msg.ADC_INFINITE_LOOP, msg_args(p_loop_name));
    end if;
  end monitor_loop;

end adc_util;
/