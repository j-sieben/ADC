create or replace package body adc_util
as
  

  /**
    Package: ADC_UTIL Body
      Provides data types, constants and generic helper functions for ADC.

    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  g_loop_counter binary_integer;
  g_test_mode boolean;

  /**
    Group: Public Methods
   */
  
  /**
    Function: C_CR
      See <ADC_UTIL.C_CR>
   */
  function c_cr
    return varchar2
  as
  begin
    return chr(10);
  end c_cr;
  
  
  /**
    Function: C_APOS
      See <ADC_UTIL.C_APOS>
   */
  function c_apos
    return varchar2
  as
  begin
    return chr(39);
  end c_apos;
  
  /**
    Function: C_TRUE
      See <ADC_UTIL.C_TRUE>
   */
  function c_true
    return flag_type
  as
  begin
    return &C_TRUE.;
  end c_true;

  
  /**
    Function: C_FALSE
      See <ADC_UTIL.C_FALSE>
   */
  function c_false
    return flag_type
  as
  begin
    return &C_FALSE.;
  end c_false;

  
  /**
    Function: C_HASH
      See <ADC_UTIL.C_HASH>
   */
  function c_hash
    return varchar2
  as
  begin
    return '\u0023';
  end c_hash;

  
  /**
    Function: get_boolean
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
    Function: to_bool
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
    Function: bool_to_flag
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
    Function: clean_adc_name
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
    Function: get_trans_item_name
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
    Function: close_cursor
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
    Procedure: monitor_loop
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
  
  
  /**
    Function: get_additional_nd_comments
      See <ADC_UTIL.get_additional_nd_comments>
   */
  function get_additional_nd_comments
    return clob
  as
    l_comments clob;
  begin
    with params as (
           select /*+ no_merge */
                  adc_util.C_CR C_CR
             from dual)
    select utl_text.generate_text(cursor(
             select '#OBJECT_TYPE#: #OBJECT_TYPE#s.#OBJECT_NAME##CR#  #COMMENTS##CR##CR#Fields:#CR#  #COLUMNS#' template, initcap(object_type) object_type, object_name, comments, C_CR cr,
                    utl_text.generate_text(cursor(
                      select '#COLUMN_NAME# - #COMMENTS#' template, lower(t.column_name) column_name, 
                             coalesce(c.comments, case t.column_name when 'D' then 'Display value' when 'R' then 'Return value' else 'no comment available' end) comments, C_CR cr
                        from user_tab_columns t
                        join user_col_comments c
                          on t.table_name = c.table_name
                         and t.column_name = c.column_name
                       where t.table_name = o.object_name
                       order by t.table_name, t.column_id
                    ), adc_util.C_CR, 2) columns
               from user_objects o
               join user_tab_comments
                 on object_name = table_name
              where object_type in ('TABLE', 'VIEW')
                and object_name like 'ADC%'
              order by 1, 2), C_CR || C_CR) resultat
      into l_comments
      from params;
      
    return l_comments;
  end get_additional_nd_comments;
  
  
  /**
    Function: get_test_mode
      See <ADC_UTIL.get_test_mode>
   */
  function get_test_mode
    return boolean
  as
  begin
    return g_test_mode;
  end get_test_mode;
  
  
  /**
    Proceude: set_test_mode
      See <ADC_UTIL.set_test_mode>
   */
  procedure set_test_mode(
    p_flag in boolean)
  as
  begin
    g_test_mode := p_flag;
  end set_test_mode;
    
    
  /**
    Function: get_environment
      See <ADC_UTIL.get_environment>
   */
  function get_environment
    return environment_rec
  as
    l_rec environment_rec;
  begin
    l_rec.app_id := utl_apex.get_application_id;
    l_rec.page_id := utl_apex.get_page_id;
    select crg_id
      into l_rec.crg_id
      from adc_rule_groups
     where crg_app_id = l_rec.app_id
       and crg_page_id = l_rec.page_id;
       
    return l_rec;
  exception
    when NO_DATA_FOUND then 
      return null;
  end get_environment;
  
end adc_util;
/
