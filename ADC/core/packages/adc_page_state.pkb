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
  C_ITEM constant adc_page_item_types.cpit_id%type := 'ITEM';
  C_APP_ITEM constant adc_page_item_types.cpit_id%type := 'APP_ITEM';
  C_NUMBER_ITEM constant adc_page_item_types.cpit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant adc_page_item_types.cpit_id%type := 'DATE_ITEM';
  C_DEFAULT_NUMBER_MASK constant adc_util.sql_char := 'fm9999999999999999999';
  C_NUMBER_GROUP_MASK constant adc_util.sql_char := 'G';
  C_DELIMITER constant adc_util.sql_char := ',';
  C_COLLECTION_NAME constant adc_util.ora_name_type := adc_util.C_PARAM_GROUP || '_CRG_STATUS_';
  
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
    cpi_id adc_page_items.cpi_id%type,
    cpi_conversion adc_page_items.cpi_conversion%type,
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
      p_crg_id - ID of the rule group. Required to retrieve format mask and default value
      p_cpi_id - ID of the page item
      
    Returns:
      Default value for that page item.
   */
  function get_mandatory_default_value(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_default adc_page_items.cpi_item_default%type;
  begin
    pit.enter_optional('get_mandatory_default_value',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    select cpi_item_default
      into l_default
      from adc_page_items
     where cpi_is_mandatory = adc_util.c_true
       and cpi_id = p_cpi_id
       and cpi_crg_id = p_crg_id;
    
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
    Function: get_mandatory_message
      Returns a default mandatory message for a page item.
      
      If a mandatory item is NULL, a message has to be generated which may have been excplicitly given or not.
      This method creates this message and returns a standard message if no explicit message is available.
      
    Parameter:
      p_cpi_id - ID of the mandatory page item
      
    Returns:
      Error message for missing value
   */
  function get_mandatory_message(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_mandatory_message adc_rule_group_status.cgs_cpi_mandatory_message%type;
  begin
    pit.enter_optional('get_mandatory_message',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));       
       
    select coalesce(cgs_cpi_mandatory_message, to_char(pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY, msg_args(cgs_cpi_label))))
      into l_mandatory_message
      from adc_rule_group_status
     where cgs_crg_id = p_crg_id
       and cgs_cpi_id = p_cpi_id;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Msg', l_mandatory_message)));
    return l_mandatory_message;
  exception
    when NO_DATA_FOUND then
      -- Not an available item, ignore
      pit.leave_optional;
      return null;
  end get_mandatory_message;
  
  
  /**
    Procedure: convert_session_value
      Method to convert a session value based on its metadata
    
    Parameters:
      p_cpi_cpit_id - Type of the item, needed to decide on the conversion
      p_cpi_conversion - Conversion mask
   */
  procedure convert_session_value(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_value in out nocopy session_value_rec,
    p_throw_error in adc_util.flag_type)
  as
    l_format_mask adc_util.ora_name_type;
    l_to_number_mask adc_util.ora_name_type;
    l_cpi_cpit_id adc_page_items.cpi_cpit_id%type;
    l_cpi_conversion adc_page_items.cpi_conversion%type;
  begin    
    pit.enter_detailed('convert_session_value',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_value.cpi_id),
                    msg_param('p_throw_error', p_throw_error)));
                    
    select cpi_cpit_id, cpi_conversion
      into l_cpi_cpit_id, l_cpi_conversion
      from adc_page_items
     where cpi_crg_id = p_crg_id
       and cpi_id = p_value.cpi_id
       and cpi_cpit_id in (C_ITEM, C_APP_ITEM, C_NUMBER_ITEM, C_DATE_ITEM);
       
    case l_cpi_cpit_id 
      when C_NUMBER_ITEM then
        -- first, get string value from parameter values
        l_format_mask := 'FM' || replace(upper(coalesce(p_value.cpi_conversion, l_cpi_conversion, C_DEFAULT_NUMBER_MASK)), 'FM');
        l_to_number_mask := replace(replace(upper(l_format_mask), C_NUMBER_GROUP_MASK), 'FM');
        p_value.string_value := rtrim(coalesce(to_char(p_value.number_value, l_format_mask), g_session_values(p_value.cpi_id).string_value), ',.');
        g_session_values(p_value.cpi_id).string_value := p_value.string_value;
        -- then persist number value, either directly or by converting the string value
        g_session_values(p_value.cpi_id).number_value := coalesce(p_value.number_value, to_number(p_value.string_value, l_to_number_mask));
        g_session_values(p_value.cpi_id).string_value := to_char(g_session_values(p_value.cpi_id).number_value, l_format_mask);
        pit.info(
          p_message_name => msg.ADC_NUMBER_ITEM_SET,
          p_msg_args => msg_args(p_value.cpi_id, to_char(g_session_values(p_value.cpi_id).number_value), g_session_values(p_value.cpi_id).string_value));
      when C_DATE_ITEM then
        -- first, get string value from parameter values
        l_format_mask := coalesce(p_value.cpi_conversion, l_cpi_conversion, apex_application.g_date_format);
        p_value.string_value := coalesce(to_char(p_value.date_value, l_format_mask), g_session_values(p_value.cpi_id).string_value);
        g_session_values(p_value.cpi_id).string_value := p_value.string_value;
        -- then persist date value, either directly or by converting the string value
        g_session_values(p_value.cpi_id).date_value := coalesce(p_value.date_value, to_date(p_value.string_value, l_format_mask));
        g_session_values(p_value.cpi_id).string_value := to_char(g_session_values(p_value.cpi_id).date_value, l_format_mask);
        pit.info(
          p_message_name => msg.ADC_DATE_ITEM_SET, 
          p_msg_args => msg_args(p_value.cpi_id, to_char(g_session_values(p_value.cpi_id).date_value), g_session_values(p_value.cpi_id).string_value));
      else
        null;
    end case;
    
    pit.leave_detailed;
  exception
    when INVALID_NUMBER or VALUE_ERROR then
      pit.leave_optional(
        p_params => msg_params(
                      msg_param('Result', g_session_values(p_value.cpi_id).string_value)));
      if p_throw_error = adc_util.C_TRUE then
        if l_cpi_cpit_id = C_NUMBER_ITEM then
          pit.error(
            p_message_name => msg.ADC_INVALID_NUMBER, 
            p_msg_args => msg_args(
                            replace(lower(l_format_mask), 'fm')));
        else
          pit.error(
            p_message_name => msg.ADC_INVALID_DATE, 
            p_msg_args => msg_args(
                            replace(lower(l_format_mask), 'fm')));
        end if;
      end if;
    when others then
      if p_throw_error = adc_util.C_TRUE then
        pit.tweet(sqlerrm);
        case 
        when sqlcode in (-1858, -1862) 
          or sqlcode between -1866 and -1800 then
          if l_cpi_cpit_id = C_NUMBER_ITEM then
            pit.error(
              p_message_name => msg.ADC_INVALID_NUMBER, 
              p_msg_args => msg_args(
                              replace(lower(l_format_mask), 'fm')));
          else
            pit.error(
              p_message_name => msg.ADC_INVALID_DATE, 
              p_msg_args => msg_args(
                              replace(lower(l_format_mask), 'fm')));
          end if;
        else
          raise;
        end case;
      end if;
  end convert_session_value;
  
  
  /**
    Procedure: set_session_value
      Wrapper method around apex_util.set_session state with an autonomous transaction. This method assures
      that DML is possible even inside a select statement.
      
    Parameters:
      p_cpi_id - ID of the page item
      p_value - new value of the item
   */
  procedure set_session_value(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2)
  as
    --pragma autonomous_transaction;
  begin
    apex_util.set_session_state(p_cpi_id, p_value);
    --commit;
  end set_session_value;
  
  
  /**
    Function: item_may_have_value
      Method checks whether an item is allowed to have a page state value.
      
    Parameters:
      p_crg_id - ID of the rule group.
      p_cpi_id - ID of the page item
      
    Returns:
      Flag to indicate whether this item is allowed to have a value (TRUE) or not (FALSE).
   */
  function item_may_have_value(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
    return boolean
  as
    l_count pls_integer;
    l_is_value_item boolean;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id)));
    
    select count(*)
      into l_count
      from dual
     where exists(
           select null
             from adc_page_items
            where cpi_crg_id = p_crg_id
              and cpi_id = p_cpi_id
              and cpi_cpit_id in (C_ITEM, C_APP_ITEM, C_NUMBER_ITEM, C_DATE_ITEM));
       
    l_is_value_item := l_count = 1;
       
    if not l_is_value_item and g_session_values.exists(p_cpi_id) then
      g_session_values.delete(p_cpi_id);
    end if;
  
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', case  l_count when 1 then adc_util.C_TRUE else adc_util.C_FALSE end)));
                    
    return l_is_value_item;
  end item_may_have_value;
  
  
  /**
    Group: Public methods
   */
  /**
    Function: check_mandatory
      See <ADC_PAGE_STATE.check_mandatory>
   */
  procedure check_mandatory(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    l_is_mandatory pls_integer;
    l_message adc_util.max_char;
    l_cpi_id adc_util.ora_name_type;
  begin
    pit.enter_optional('check_mandatory',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    l_cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);
    select count(*), max(cgs_cpi_mandatory_message)
      into l_is_mandatory, l_message
      from adc_rule_group_status
     where cgs_crg_id = p_crg_id
       and cgs_cpi_id = l_cpi_id;
       
    if l_is_mandatory = 1 then
      pit.assert_not_null(get_string(p_crg_id, l_cpi_id), msg.ADC_ITEM_IS_MANDATORY, msg_args(l_message));
    end if;
       
    pit.leave_optional;
  end check_mandatory;
  
  
  /**
    Procedure: register_mandatory
      See <ADC_PAGE_STATE.register_mandatory>
   */
  procedure register_mandatory(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_cpi_mandatory_message in varchar2,
    p_is_mandatory in adc_util.flag_type)
  as
    l_collection_name adc_util.ora_name_type;
    l_cpi_id adc_util.ora_name_type;
    l_cgs_row adc_rule_group_status%rowtype;
    cursor mandatory_items_cur is
      select cpi_id, cpi_label, cpi_mandatory_message
        from adc_page_items
       where cpi_crg_id = p_crg_id
         and cpi_is_mandatory = adc_util.C_TRUE;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_cpi_mandatory_message', p_cpi_mandatory_message),
                    msg_param('p_is_mandatory', p_is_mandatory)));
    
    l_collection_name := C_COLLECTION_NAME || p_crg_id;
    l_cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);
    
    if l_cpi_id = adc_util.C_NO_FIRING_ITEM then
      -- This option is called during page initialization only
      -- Initialize internal APEX mandatory item collection
      begin
        apex_collection.create_or_truncate_collection(l_collection_name);
      exception
        when DUP_VAL_ON_INDEX then
          -- This error can occur with hectic, multiple clicks, ignore.
          null;
      end;
      
      -- register all statically mandatory items, identifified by CPI_IS_MANDATORY
      for item in mandatory_items_cur loop
        apex_collection.add_member(
          p_collection_name => l_collection_name,
          p_c001 => item.cpi_id,
          p_c002 => item.cpi_label,
          p_c003 => item.cpi_mandatory_message,
          p_generate_md5 => 'NO');
      end loop;
    else
      -- Item ist registered or de-registered as mandatory explicitly
      select cgs_crg_id, cgs_id, cpi_id, cpi_label, cgs_cpi_mandatory_message
        into l_cgs_row
        from adc_page_items
        left join adc_rule_group_status
          on cpi_crg_id = cgs_crg_id
         and cpi_id = cgs_cpi_id
       where cpi_crg_id = p_crg_id
         and cpi_id = l_cpi_id;
         
      case when p_is_mandatory = adc_util.C_TRUE and l_cgs_row.cgs_id is null then
        pit.info(msg.PIT_PASS_MESSAGE, msg_args('Page item has become a mandatory field, register in collection'));
        apex_collection.add_member(
          p_collection_name => l_collection_name,
          p_c001 => l_cgs_row.cgs_cpi_id,
          p_c002 => l_cgs_row.cgs_cpi_label,
          p_c003 => coalesce(p_cpi_mandatory_message, get_mandatory_message(p_crg_id, l_cgs_row.cgs_cpi_id), 'null'),
          p_generate_md5 => 'NO');
      when p_is_mandatory = adc_util.C_FALSE and l_cgs_row.cgs_id is not null then
        pit.info(msg.PIT_PASS_MESSAGE, msg_args('Page item must be removed from the list of mandatory elements'));
        apex_collection.delete_member(
          p_seq => l_cgs_row.cgs_id,
          p_collection_name => l_collection_name);
      else
        pit.info(msg.PIT_PASS_MESSAGE, msg_args('Status of the page item has not changed'));
      end case;
    end if;
    
    pit.leave_optional;
  end register_mandatory;
  
  
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
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value in varchar2 default null,
    p_number_value in number default null,
    p_date_value in date default null,
    p_format_mask in varchar2 default null,
    p_throw_error in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_value session_value_rec;
    l_cpi_id adc_util.ora_name_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value', p_value),
                    msg_param('p_number_value', p_number_value),
                    msg_param('p_date_value', p_date_value),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', p_throw_error)));
    
    -- Initialize
    l_value.cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);    
    l_value.number_value := p_number_value;
    l_value.date_value := p_date_value;
    l_value.cpi_conversion := p_format_mask;
    
    if item_may_have_value(p_crg_id, l_value.cpi_id) then    
      -- If requested, get the value from the session state
      if p_value = C_FROM_SESSION_STATE then
        l_value.string_value := coalesce(utl_apex.get_string(l_value.cpi_id), get_mandatory_default_value(p_crg_id, l_value.cpi_id));
      else
        l_value.string_value := p_value;
      end if;
      
      g_session_values(l_value.cpi_id) := l_value;
      if l_value.string_value is not null then
        -- Explicitly set the value and harmonize with the session state (fi when changing a session values during rule execution)
        convert_session_value(p_crg_id, l_value, p_throw_error);
                
      else
        if p_throw_error = adc_util.C_TRUE then
          check_mandatory(p_crg_id, l_value.cpi_id);
        end if;
        l_value.number_value := null;
        l_value.date_value := null;
        g_session_values(l_value.cpi_id) := l_value;
      end if;
          
      set_session_value(l_value.cpi_id, g_session_values(l_value.cpi_id).string_value);
    end if;
    
    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      -- no session state value, ignore.
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || l_value.cpi_id || ' does not have a value, ignored'));
      g_session_values(l_value.cpi_id) := null;
      pit.leave_optional;
    when INVALID_NUMBER or VALUE_ERROR or msg.ADC_ITEM_IS_MANDATORY_ERR then
      pit.leave_optional;
      raise;
    when others then
      pit.leave_optional;
      raise;
  end set_value;
  
  
  /**
    Function: get_string
      See <ADC_PAGE_STATE.get_string>
   */
  function get_string(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2
  as
    l_string_value adc_util.max_char;
    l_cpi_id adc_util.ora_name_type;
  begin
    pit.enter_optional('get_string',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id)));
    
    l_cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);
    case
      when g_session_values.exists(l_cpi_id) then
        l_string_value := g_session_values(l_cpi_id).string_value;
      when item_may_have_value(p_crg_id, l_cpi_id) then
        set_value(
          p_crg_id => p_crg_id,
          p_cpi_id => l_cpi_id,
          p_value => C_FROM_SESSION_STATE);
        l_string_value := g_session_values(l_cpi_id).string_value;
      else
        null;
    end case;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', l_string_value)));
    return l_string_value;
  end get_string;
  
    
  /**
    Function: get_date
      See <ADC_PAGE_STATE.get_date>
   */
  function get_date(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return date
  as
    l_date_value date;
    l_cpi_id adc_util.ora_name_type;
  begin
    pit.enter_optional('get_date',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask)));
                    
    l_cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);
    case
      when g_session_values.exists(l_cpi_id) then
        l_date_value := g_session_values(l_cpi_id).date_value;
      when item_may_have_value(p_crg_id, l_cpi_id) then
        set_value(
          p_crg_id => p_crg_id,
          p_cpi_id => l_cpi_id,
          p_value => C_FROM_SESSION_STATE, 
          p_format_mask => p_format_mask);
        l_date_value := g_session_values(l_cpi_id).date_value;
      else
        null;
    end case;
      
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', l_date_value)));
    return l_date_value;
  end get_date;
  
      
  /**
    Function: get_number
      See <ADC_PAGE_STATE.get_number>
   */
  function get_number(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_format_mask in varchar2)
    return number
  as
    l_number_value number;
    l_cpi_id adc_util.ora_name_type;
  begin
    pit.enter_optional('get_number',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_format_mask', p_format_mask)));
    
    l_cpi_id := adc_util.harmonize_page_item_name(p_cpi_id);
    case
      when g_session_values.exists(l_cpi_id) then
        l_number_value := g_session_values(l_cpi_id).number_value;
      when item_may_have_value(p_crg_id, l_cpi_id) then
        set_value(
          p_crg_id => p_crg_id,
          p_cpi_id => l_cpi_id,
          p_value => C_FROM_SESSION_STATE, 
          p_format_mask => p_format_mask);
        l_number_value := g_session_values(l_cpi_id).number_value;
      else
        null;
    end case;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', l_number_value)));
    return l_number_value;
  end get_number;
  
  
  /**
    Procedure: dynamically_validate_value
      See <ADC_PAGE_STATE.dynamically_validate_value>
   */
  procedure dynamically_validate_value(
    p_crg_id in adc_rule_groups.crg_id%type, 
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    C_VALIDATION_TEMPLATE constant adc_util.sql_char := 'begin #CODE#; end;';
    l_cpi_validation_method adc_page_items.cpi_validation_method%type;
    l_result boolean;
  begin
    pit.enter_detailed('dynamically_validate_value',
      p_params => msg_params(
                    msg_param ('p_crg_id', p_crg_id),
                    msg_param ('p_cpi_id', p_cpi_id)));
    
    -- Check whether page item is allowed to have a value and get the item type and format mask
    select cpi_validation_method
      into l_cpi_validation_method
      from adc_page_items
     where cpi_crg_id = p_crg_id
       and cpi_id = p_cpi_id;
       
    if l_cpi_validation_method is not null then
      l_cpi_validation_method := replace(C_VALIDATION_TEMPLATE, '#CODE#', replace(l_cpi_validation_method, ';'));
      execute immediate l_cpi_validation_method;
    end if;
    
    pit.leave_detailed;
  end dynamically_validate_value;
  
  
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
    pit.enter_optional;
    
    if g_session_values.count > 0 then
      l_item := g_session_values.first;
      while l_item is not null loop
        l_what := trim('''' from apex_escape.js_literal(g_session_values(l_item).string_value)); --htf.escape_sc(g_session_values(l_item).string_value);
        utl_text.append(
          p_text => l_json, 
          p_chunk => replace(replace(C_PAGE_JSON_ELEMENT, 
                      '#ID#', adc_util.harmonize_page_item_name(l_item)), 
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
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_list in varchar2,
    p_value_list out nocopy char_table)
  as
    l_filter adc_util.max_char;
    C_TMPLT constant varchar2(1000) := q'^begin :x := char_table('#FILTER#'); end;^';
    l_filter_list char_table;
  begin
    pit.enter_optional(
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
                where cpi_crg_id = p_crg_id
             ) as char_table
           ) cpi_value
      into p_value_list
      from dual;
      
    pit.leave_optional;
  end get_item_values_as_char_table;
  
end adc_page_state;
/