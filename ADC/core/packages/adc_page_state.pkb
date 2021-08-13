create or replace package body adc_page_state
as

  C_NUMBER_ITEM constant adc_page_item_types.cit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant adc_page_item_types.cit_id%type := 'DATE_ITEM';
  
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
    g_session_values.delete;
  end reset;
  
  
  procedure set_value(
    p_cgr_id in adc_rule_groups.cgr_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default C_FROM_SESSION_STATE,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_cpi_cit_id adc_page_items.cpi_cit_id%type;
    l_cpi_conversion adc_page_items.cpi_conversion%type;
    l_format_mask adc_util.ora_name_type;
    l_value adc_util.max_char;
    l_mandatory_default adc_util.max_char;
  begin
    pit.enter_detailed('set_value');
    l_value := p_value;
    
    -- Check whether page item is allowed to have a value and get the format mask for the firing item
    select cpi_cit_id, cpi_conversion
      into l_cpi_cit_id, l_cpi_conversion
      from adc_page_items
     where cpi_cgr_id = p_cgr_id
       and cpi_id = p_cpi_id
       and cpi_cit_id in ('ITEM', 'APP_ITEM', 'NUMBER_ITEM', 'DATE_ITEM');
       
    -- Explicitly set the value and harmonize with the session state (fi when changing a session values during rule execution)
    if l_value = C_FROM_SESSION_STATE then
      l_value := coalesce(utl_apex.get_string(p_cpi_id), get_mandatory_default_value(p_cgr_id, p_cpi_id));
    end if;
    
    g_session_values(p_cpi_id).string_value := l_value;
    apex_util.set_session_state(p_cpi_id, g_session_values(p_cpi_id).string_value);
    
    -- In either case harmonize date or number value with the new value
    case l_cpi_cit_id
      when C_NUMBER_ITEM then        
        if g_session_values(p_cpi_id).string_value is not null then
          l_format_mask := replace(coalesce(p_format_mask, l_cpi_conversion, '99999999999999D9999999'), 'G');
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
        null;
    end case;
    
    pit.leave_detailed;
  exception
    when NO_DATA_FOUND then
      -- no session state value, ignore.
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || p_cpi_id || ' does not have a value, ignored'));
      pit.leave_detailed;
    -- NUMBER conversion
    when msg.INVALID_NUMBER_FORMAT_ERR then
      pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_NUMBER_FORMAT, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when INVALID_NUMBER or VALUE_ERROR then
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.ADC_INVALID_NUMBER_REMOVED, msg_args(g_session_values(p_cpi_id).string_value));
      end if;
    -- DATE conversion
    when msg.INVALID_DATE_ERR then
      pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_DATE, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when msg.INVALID_DATE_FORMAT_ERR then
      pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_DATE_FORMAT, msg_args(g_session_values(p_cpi_id).string_value, p_format_mask));
      end if;
    when msg.INVALID_YEAR_ERR or msg.INVALID_MONTH_ERR or msg.INVALID_DAY_ERR then
      pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        pit.error(msg.INVALID_YEAR, msg_args(substr(sqlerrm, 12)));
      end if;
    when others then
      pit.leave_detailed(p_params => msg_params(msg_param('Result', g_session_values(p_cpi_id).string_value)));
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
    pit.enter_detailed('get_string',
      p_params => msg_params(msg_param('p_cpi_id', p_cpi_id)));
    
    if p_cpi_id != adc_util.C_NO_FIRING_ITEM then
      if not g_session_values.exists(p_cpi_id) then
        set_value(p_cgr_id, p_cpi_id);
      end if;
      
      if g_session_values.exists(p_cpi_id) then
        l_string_value := g_session_values(p_cpi_id).string_value;
      end if;
    end if;
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', l_string_value)));
    return l_string_value;
  end get_string;
  
    
  function get_date(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return date
  as
  begin
    pit.enter_detailed('get_date',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', p_throw_error)));
                    
    if not g_session_values.exists(p_cpi_id) then
      set_value(
        p_cgr_id => p_cgr_id,
        p_cpi_id => p_cpi_id, 
        p_format_mask => p_format_mask,
        p_throw_error => p_throw_error);
    end if;
      
    pit.leave_detailed(p_params => msg_params(msg_param('Result', get_string(p_cgr_id, p_cpi_id))));
    return g_session_values(p_cpi_id).date_value;
  end get_date;
  
    
  function get_number(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
    return number
  as
  begin
    pit.enter_detailed('get_number',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', to_char(p_throw_error))));
    
    if not g_session_values.exists(p_cpi_id) then
      set_value(
        p_cgr_id => p_cgr_id,
        p_cpi_id => p_cpi_id, 
        p_format_mask => p_format_mask,
        p_throw_error => p_throw_error);
    end if;
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', get_string(p_cgr_id, p_cpi_id))));
    return g_session_values(p_cpi_id).number_value;
  end get_number;
  
end adc_page_state;
/