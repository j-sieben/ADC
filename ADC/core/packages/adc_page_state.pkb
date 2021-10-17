create or replace package body adc_page_state
as
  /** 
    Package: ADC_PAGE_STATE Body
      Implementation of the ADC_PAGE_STATE logic
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Private constants
   *
  /**
    Constants:
      C_ITEM - Generic page item (String)
      C_APP_ITEM - Application item
      C_NUMBER_ITEM - Number page item
      C_DATE_ITEM - Date page item
   */
  C_ITEM constant adc_page_item_types.cit_id%type := 'ITEM';
  C_APP_ITEM constant adc_page_item_types.cit_id%type := 'APP_ITEM';
  C_NUMBER_ITEM constant adc_page_item_types.cit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant adc_page_item_types.cit_id%type := 'DATE_ITEM';
  C_DEFAULT_NUMBER_MASK constant adc_util.sql_char := 'fm9999999999999999990';
  C_NUMBER_GROUP_MASK constant adc_util.sql_char := 'G';
  C_DELIMITER constant adc_util.sql_char := ',';
  
  /**
    Group: Types
   */
  /**
    Type: session_value_rec
    
    Properties:
      string_value - Actual value of the item as VARCHAR2
      date_value - Actual value of the item as DATE, if possible
      number_value  - Actual value of the item as NUMBER, if possible
   */
  -- Cache session state values during rule processing to prevent unnecessary fetches
  type session_value_rec is record(
    string_value adc_util.max_char,
    date_value date,
    number_value number);

  type session_value_tab is table of session_value_rec index by adc_util.ora_name_type;
  
  g_session_values session_value_tab;
  
  /**
    Group: Private methods
   */
  /**
    Function: get_mandatory_default_value
      Method to retrieve a default value for a mandatory page item.
      
      Is used to retrieve the default value if a mandatory item is NULL and  a default value was defined.
      
    Parameters:
      p_cgr_id - ID of the rule group. Required to retrieve format mask and default value
      p_cpi_id - ID of the page item
      
    Returns:
      Default value for that page item.
   */
  function get_mandatory_default_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_default adc_page_items.cpi_item_default%type;
  begin
    pit.enter_optional('get_mandatory_default_value',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    select cpi_item_default
      into l_default
      from adc_page_items
     where cpi_is_mandatory = adc_util.c_true
       and cpi_id = p_cpi_id
       and cpi_cgr_id = p_cgr_id;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', l_default)));
    return l_default;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional;
      return null;
    when too_many_rows then 
      htp.p(substr(sqlerrm, 12));
      pit.leave_mandatory;
      return null;
  end get_mandatory_default_value;
  
  
  /**
    Group: Public methods
   */
  /**
    Procedure: reset
      See <ADC_PAGE_STATE.reset>
   */
  procedure reset
  as
  begin
    pit.enter_optional;
    
    g_session_values.delete;
    
    pit.leave_optional;
  end reset;
  
  
  /**
    Procedure: set_value
      See <ADC_PAGE_STATE.set_value>
   */
  procedure set_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default C_FROM_SESSION_STATE,
    p_number_value in number default null,
    p_date_value in date default null,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_cpi_cit_id adc_page_items.cpi_cit_id%type;
    l_cpi_conversion adc_page_items.cpi_conversion%type;
    l_format_mask adc_util.ora_name_type;
    l_string_value adc_util.max_char;
  begin
    pit.enter_optional('set_value',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_number_value', p_number_value),
                    msg_param('p_date_value', p_date_value),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', p_throw_error)));
                    
    -- Check whether page item is allowed to have a value and get the item type and format mask
    select cpi_cit_id, cpi_conversion
      into l_cpi_cit_id, l_cpi_conversion
      from adc_page_items
     where cpi_cgr_id = p_cgr_id
       and cpi_id = p_cpi_id
       and cpi_cit_id in (C_ITEM, C_APP_ITEM, C_NUMBER_ITEM, C_DATE_ITEM);
    
    -- If requested, get the value from the session state
    if p_value = C_FROM_SESSION_STATE then
      g_session_values(p_cpi_id).string_value := coalesce(utl_apex.get_string(p_cpi_id), get_mandatory_default_value(p_cgr_id, p_cpi_id));
    else
      g_session_values(p_cpi_id).string_value := p_value;
    end if;
    
    -- Explicitly set the value and harmonize with the session state (fi when changing a session values during rule execution)
    case
    when l_cpi_cit_id = C_NUMBER_ITEM then
      l_format_mask := replace(coalesce(p_format_mask, l_cpi_conversion, C_DEFAULT_NUMBER_MASK), C_NUMBER_GROUP_MASK);
      l_string_value := coalesce(g_session_values(p_cpi_id).string_value, to_char(p_number_value, l_format_mask));
      g_session_values(p_cpi_id).string_value := l_string_value;
      g_session_values(p_cpi_id).number_value := coalesce(p_number_value, to_number(l_string_value, l_format_mask));
      pit.info(msg.ADC_NUMBER_ITEM_SET, msg_args(p_cpi_id , to_char(g_session_values(p_cpi_id).number_value), g_session_values(p_cpi_id).string_value));
    when l_cpi_cit_id = C_DATE_ITEM then
      l_format_mask := coalesce(p_format_mask, l_cpi_conversion, apex_application.g_date_format);
      l_string_value := coalesce(g_session_values(p_cpi_id).string_value, to_char(p_date_value, l_format_mask));
      g_session_values(p_cpi_id).string_value := l_string_value;
      g_session_values(p_cpi_id).date_value := coalesce(p_date_value, to_date(l_string_value, l_format_mask));
      pit.info(msg.ADC_DATE_ITEM_SET, msg_args(p_cpi_id , to_char(g_session_values(p_cpi_id).date_value), g_session_values(p_cpi_id).string_value));
    else
      null; --g_session_values(p_cpi_id).string_value := p_value;
    end case;
    
    apex_util.set_session_state(p_cpi_id, g_session_values(p_cpi_id).string_value);
    
    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      -- no session state value, ignore.
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || p_cpi_id || ' does not have a value, ignored'));
      pit.leave_optional;
    -- NUMBER conversion
    when msg.INVALID_NUMBER_FORMAT_ERR then
      pit.leave_optional(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_NUMBER_FORMAT, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when INVALID_NUMBER or VALUE_ERROR then
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.ADC_INVALID_NUMBER, msg_args(g_session_values(p_cpi_id).string_value));
      end if;
    -- DATE conversion
    when msg.INVALID_DATE_ERR then
      pit.leave_optional(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_DATE, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when msg.INVALID_DATE_FORMAT_ERR then
      pit.leave_optional(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_DATE_FORMAT, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when msg.INVALID_YEAR_ERR or msg.INVALID_MONTH_ERR or msg.INVALID_DAY_ERR then
      pit.leave_optional(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_YEAR, msg_args(substr(sqlerrm, 12)));
      end if;
    when others then
      pit.leave_optional(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.SQL_ERROR, msg_args(substr(sqlerrm, 12)));
      end if;
  end set_value;
  
  
  /**
    Function: get_string
      See <ADC_PAGE_STATE.get_string>
   */
  function get_string(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_string_value adc_util.max_char;
  begin
    pit.enter_optional('get_string',
      p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
    
    if not g_session_values.exists(p_cpi_id) then
      set_value(
        p_cgr_id => p_cgr_id,
        p_cpi_id => p_cpi_id);
    end if;
    
    if g_session_values.exists(p_cpi_id) then
      l_string_value := g_session_values(p_cpi_id).string_value;
    end if;
    
    pit.leave_optional(p_params => msg_params(msg_param('Result', l_string_value)));
    return l_string_value;
  end get_string;
  
    
  /**
    Function: get_date
      See <ADC_PAGE_STATE.get_date>
   */
  function get_date(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return date
  as
  begin
    pit.enter_optional('get_date',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask)));
                    
    if not g_session_values.exists(p_cpi_id) then
      set_value(
        p_cgr_id => p_cgr_id,
        p_cpi_id => p_cpi_id, 
        p_format_mask => p_format_mask);
    end if;
      
    pit.leave_optional(p_params => msg_params(msg_param('Result', get_string(p_cgr_id, p_cpi_id))));
    return g_session_values(p_cpi_id).date_value;
  end get_date;
  
      
  /**
    Function: get_number
      See <ADC_PAGE_STATE.get_number>
   */
  function get_number(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return number
  as
    l_value number;
  begin
    pit.enter_optional('get_number',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask)));
    
    if not g_session_values.exists(p_cpi_id) then
      set_value(
        p_cgr_id => p_cgr_id,
        p_cpi_id => p_cpi_id, 
        p_format_mask => p_format_mask);
    end if;
    
    pit.leave_optional(p_params => msg_params(msg_param('Result', get_string(p_cgr_id, p_cpi_id))));
    return g_session_values(p_cpi_id).number_value;
  exception
    when NO_DATA_FOUND then
      return null;
  end get_number;
  
  
  /**
    Function: get_changed_items_as_json
      See <ADC_PAGE_STATE.get_changed_items_as_json>
   */
  function get_changed_items_as_json
    return varchar2
  as
    C_BIND_JSON_TEMPLATE constant adc_util.sql_char := '[#JSON#]';
    C_PAGE_JSON_ELEMENT constant adc_util.sql_char := '{"id":"#ID#","value":"#VALUE#"}'; 
    l_json adc_util.max_char;
    l_item adc_page_items.cpi_id%type;
    l_what adc_util.max_char;
  begin
    pit.enter_optional('get_changed_items_as_json');
    
    if g_session_values.count > 0 then
      l_item := g_session_values.first;
      while l_item is not null loop
        l_what := htf.escape_sc(g_session_values(l_item).string_value);
        utl_text.append(
          p_text => l_json, 
          p_chunk => replace(replace(C_PAGE_JSON_ELEMENT, 
                      '#ID#', l_item), 
                      '#VALUE#', l_what),
          p_delimiter => ',',
          p_before => true);
        l_item := g_session_values.next(l_item);
      end loop;
    end if;
    
    l_json := replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json);
    
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_changed_items_as_json;
  
  
  /**
    Procedure: get_item_values_as_char_table
      See <ADC_PAGE_STATE.get_item_values_as_char_table>
   */
  procedure get_item_values_as_char_table(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_list in varchar2,
    p_value_list out nocopy char_table)
  as
    l_filter adc_util.max_char;
    C_TMPLT constant varchar2(1000) := q'^begin :x := char_table('#FILTER#'); end;^';
    l_filter_list char_table;
  begin
    pit.enter_optional('get_item_values_as_char_table',
      p_params => msg_params(msg_param('p_cpi_list', p_cpi_list)));
    
    -- convert comma separated list to CHAR_TABLE instance
    l_filter := replace(replace(p_cpi_list, ' '), C_DELIMITER, ''',''');
    execute immediate replace(C_TMPLT, '#FILTER#', l_filter) using out l_filter_list;
    
    -- Get the session state values as CHAR_TABLE
    select cast(
             multiset(
               select apex_util.get_session_state(cpi_id)
                 from adc_page_items spi
                 join table(l_filter_list) t
                   on t.column_value = cpi_id
                   or instr(cpi_css, '|' || replace(t.column_value, '.') || '|') > 0
                where cpi_cgr_id = p_cgr_id
             ) as char_table
           ) cpi_value
      into p_value_list
      from dual;
      
    pit.leave_optional;
  end get_item_values_as_char_table;
  
end adc_page_state;
/