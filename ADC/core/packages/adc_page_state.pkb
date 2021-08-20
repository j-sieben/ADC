create or replace package body adc_page_state
as

  C_ITEM constant adc_page_item_types.cit_id%type := 'ITEM';
  C_APP_ITEM constant adc_page_item_types.cit_id%type := 'APP_ITEM';
  C_NUMBER_ITEM constant adc_page_item_types.cit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant adc_page_item_types.cit_id%type := 'DATE_ITEM';
  C_DEFAULT_NUMBER_MASK constant adc_util.sql_char := 'fm999999999999999999D9999999';
  C_NUMBER_GROUP_MASK constant adc_util.sql_char := 'G';
  
  -- Cache session state values during rule processing to prevent unnecessary fetches
  type session_value_rec is record(
    string_value adc_util.max_char,
    date_value date,
    number_value number);

  type session_value_tab is table of session_value_rec index by adc_util.ora_name_type;
  
  g_session_values session_value_tab;    
  
  /** Method to retrieve a default value for a mandatory page item
   * @param  p_cpi_id  ID of the page item
   * @return Default value for that page item
   * @usage  Is used to retrieve the default value if a mandatory item is NULL and  a default value was defined.
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
  
  
  /* INTERFACE */
  procedure reset
  as
  begin
    pit.enter_optional;
    
    g_session_values.delete;
    
    pit.leave_optional;
  end reset;
  
  
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
    l_conversion_necessary boolean := true;
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
                    
    
    -- Check whether page item is allowed to have a value and get the format mask for the firing item
    select cpi_cit_id, cpi_conversion
      into l_cpi_cit_id, l_cpi_conversion
      from adc_page_items
     where cpi_cgr_id = p_cgr_id
       and cpi_id = p_cpi_id
       and cpi_cit_id in (C_ITEM, C_APP_ITEM, C_NUMBER_ITEM, C_DATE_ITEM);
       
    -- Explicitly set the value and harmonize with the session state (fi when changing a session values during rule execution)
    case
    when p_number_value is not null and l_cpi_cit_id = C_NUMBER_ITEM then
      g_session_values(p_cpi_id).string_value := to_char(p_number_value, l_cpi_conversion);
      g_session_values(p_cpi_id).number_value := p_number_value;
      l_conversion_necessary := false;
    when p_date_value is not null and l_cpi_cit_id = C_DATE_ITEM then
      g_session_values(p_cpi_id).string_value := to_char(p_date_value, l_cpi_conversion);
      g_session_values(p_cpi_id).date_value := p_date_value;
      l_conversion_necessary := false;
    when p_value = C_FROM_SESSION_STATE then
      g_session_values(p_cpi_id).string_value := coalesce(utl_apex.get_string(p_cpi_id), get_mandatory_default_value(p_cgr_id, p_cpi_id));
    else
      g_session_values(p_cpi_id).string_value := p_value;
    end case;
    
    -- In either case harmonize date or number value with the new value if passed in accordingly
    if l_conversion_necessary then
      case l_cpi_cit_id
        when C_NUMBER_ITEM then        
          if g_session_values(p_cpi_id).string_value is not null then
            l_format_mask := replace(coalesce(p_format_mask, l_cpi_conversion, C_DEFAULT_NUMBER_MASK), C_NUMBER_GROUP_MASK);
            g_session_values(p_cpi_id).number_value := to_number(g_session_values(p_cpi_id).string_value, l_format_mask); 
            -- conversion successful, set formatted string in session state
            apex_util.set_session_state(p_cpi_id, to_char(g_session_values(p_cpi_id).number_value, l_format_mask));
          else
            g_session_values(p_cpi_id).number_value := null;
          end if;
        when C_DATE_ITEM then
          -- convert to date
          if g_session_values(p_cpi_id).string_value is not null then
            l_format_mask := coalesce(p_format_mask, l_cpi_conversion, apex_application.g_date_format);
            g_session_values(p_cpi_id).date_value := to_date(g_session_values(p_cpi_id).string_value, l_format_mask);
            -- conversion successful, set formatted string in session state
            apex_util.set_session_state(p_cpi_id, to_char(g_session_values(p_cpi_id).date_value, l_format_mask));
          else
            g_session_values(p_cpi_id).date_value := null;
          end if;
        else
          apex_util.set_session_state(p_cpi_id, g_session_values(p_cpi_id).string_value);
      end case;
    end if;
    
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
  
    
  function get_number(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return number
  as
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
  end get_number;
  
  
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
  
end adc_page_state;
/