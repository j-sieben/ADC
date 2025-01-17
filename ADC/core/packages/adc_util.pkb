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
    return utl_text.get_newline_char;
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
    return pit_util.c_true;
  end c_true;

  
  /**
    Function: C_FALSE
      See <ADC_UTIL.C_FALSE>
   */
  function c_false
    return flag_type
  as
  begin
    return pit_util.c_false;
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
    Function: to_javascript_boolean
      See <ADC_UTIL.to_javascript_boolean>
   */
  function to_javascript_boolean(
    p_flag in adc_util.flag_type)
    return varchar2
  as
    l_result adc_util.tiny_char;
  begin
    pit.enter_detailed('to_javascript_boolean',
      p_params => msg_params(msg_param('p_flag', p_flag)));

    if p_flag = adc_util.C_TRUE then
      l_result := 'true';
    else
      l_result := 'false';
    end if;
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('Result', l_result)));
    return l_result;
  end to_javascript_boolean;

  
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
    Function: bulk_replace
      See <ADC_UTIL.bulk_replace>
   */
  function bulk_replace(
    p_text in varchar2,
    p_string_table in string_table)
    return varchar2
  as
    l_text max_char;
  begin
    l_text := p_text;
    if p_text is not null and p_string_table is not null then
      for i in 1 .. p_string_table.count loop
        if mod(i, 2) = 1 then
          l_text := replace(l_text, p_string_table(i), p_string_table(i + 1));
        end if;
      end loop;
    end if;
    return l_text;
  end bulk_replace;

  
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
    Function: harmonize_page_item_name
      See <ADC_UTIL.harmonize_page_item_name>
   */
  function harmonize_page_item_name(
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_item_name adc_util.ora_name_type;
    l_page_prefix adc_util.ora_name_type;
    l_button_prefix adc_util.ora_name_type;
    l_region_prefix adc_util.ora_name_type;
  begin
    pit.enter_detailed('harmonize_page_item_name',
      p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
      
    l_item_name := upper(p_cpi_id);
    
    if l_item_name != adc_util.C_NO_FIRING_ITEM and p_cpi_id is not null then
      l_page_prefix := utl_apex.get_page_prefix;
      l_button_prefix := replace(l_page_prefix, 'P', 'B');
      l_region_prefix := replace(l_page_prefix, 'P', 'R');
        
      if substr(l_item_name, 1, length(l_page_prefix)) not in (l_page_prefix, l_button_prefix, l_region_prefix) then
        l_item_name := l_page_prefix || l_item_name;
      end if;
    end if;
      
    pit.leave_detailed(
      p_params => msg_params(msg_param('item_name', l_item_name)));
    return l_item_name;
  end harmonize_page_item_name;

  
  /**
    Function: get_trans_item_name
      See <ADC_UTIL.get_trans_item_name>
   */
  function get_trans_item_name(
    p_item in varchar2,
    p_msg_args in msg_args default null,
    p_pmg_name in varchar2 default C_ADC)
    return varchar2
  as
  begin
    return pit.get_trans_item_name(p_pmg_name, p_item, p_msg_args);
  end get_trans_item_name;

  
  /**
    Function: get_standard_message
      See <ADC_UTIL.get_standard_message>
   */
  function get_standard_message(
    p_msg_name in varchar2)
    return varchar2
  as
    l_message adc_standard_messages_v.csm_message%type;
  begin
    select csm_message
      into l_message
      from adc_standard_messages_v
     where csm_id = p_msg_name;
    return l_message;
  exception
    when NO_DATA_FOUND then
      return null;
  end get_standard_message;

  
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
      pit.raise_error(msg.ADC_INFINITE_LOOP, msg_args(p_loop_name));
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
