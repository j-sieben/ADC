create or replace package body adc
as

  C_BUTTON constant adc_page_item_types.cit_id%type := 'BUTTON';
  C_APOS constant adc_util.ora_name_type := chr(39);
  C_EMPTY_STRING constant adc_util.ora_name_type := C_APOS || C_APOS;
  
  
  /* ADDITIONAL ADC FUNCTIONALITY */
  procedure add_javascript(
    p_javascript in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_javascript', substr(p_javascript, 1, 4000))));

    adc_api.add_javascript(p_javascript);

    pit.leave_optional;
  end add_javascript;


  procedure exclusive_or(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in adc_util.flag_type default adc_util.C_FALSE)
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value_list', p_value_list),
                    msg_param('p_message', p_message),
                    msg_param('p_error_on_null', p_error_on_null)));

    l_result := exclusive_or(p_value_list);
    if (l_result = adc_util.C_FALSE 
       or (l_result is null and p_error_on_null = adc_util.C_TRUE)) then
      adc_api.register_error(p_cpi_id, p_message, msg_args(''));
    end if;
    
    pit.leave_optional;
  exception
    when others then
      adc_api.register_error(
        p_cpi_id => p_cpi_id, 
        p_message_name => msg.SQL_ERROR);
      pit.leave_optional;
  end exclusive_or;


  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_optional('exlusive_or',
      p_params => msg_params(
                    msg_param('p_value_list', p_value_list)));

    l_result := adc_api.exclusive_or(p_value_list);

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', l_result)));
    return l_result;
  end exclusive_or;
  

  procedure handle_bulk_errors(
    p_mapping in char_table default null) 
  as
    type error_code_map_t is table of utl_apex.ora_name_type index by utl_apex.ora_name_type;
    l_error_code_map error_code_map_t;
    l_message_list pit_message_table;
    l_message message_type;
    l_item utl_apex.item_rec;
    l_processed_messages char_table := char_table();
  begin
    pit.enter_optional;
    
    l_message_list := pit.get_message_collection;
    
    if l_message_list.count > 0 then
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then
            l_error_code_map(p_mapping(i)) := p_mapping(i + 1);
          end if;
        end loop;
      end if;
      
      for i in 1 .. l_message_list.count loop
        l_message := l_message_list(i);
        if l_message.severity in (pit.level_fatal, pit.level_error) then
        
          if l_error_code_map.exists(l_message.error_code) then
            utl_apex.get_page_element(l_error_code_map(l_message.error_code), l_item);
          end if;
          
          if l_message.error_code not member of l_processed_messages then
            -- Push on local message list to remove doulbe errors
            l_processed_messages.extend;
            l_processed_messages(l_processed_messages.count) := l_message.error_code;
            
            adc_api.register_error(
              p_cpi_id => coalesce(l_item.item_name, adc_util.C_NO_FIRING_ITEM),
              p_error_msg => replace(l_message.message_text, '#LABEL#', l_item.item_label),
              p_internal_error => l_message.message_description);
          end if;
          
        end if;
      end loop;
    end if;
    
    pit.leave_optional;
  end handle_bulk_errors;
  
  
  procedure hide_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_jquery_selector in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_jquery_selector', p_jquery_selector)));
    
    adc_api.execute_action(
      p_cat_id => 'SET_VISUAL_STATE',
      p_cpi_id => p_cpi_id,
      p_param_1 => 'HIDE',
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end hide_item;
  
  
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_static_id', p_static_id)));

    adc_api.initialize_form_region(p_static_id);
    
    pit.leave_optional;
  end initialize_form_region;
  

  procedure not_null(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED)
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_value_list', p_value_list),
                    msg_param('p_message', p_message)));
                    
    l_result := not_null(p_value_list);
    
    if l_result = adc_util.C_FALSE then
      adc_api.register_error(p_cpi_id, p_message, msg_args(''));
    end if;

    pit.leave_optional;
  exception
    when others then
      pit.leave_optional;
      register_error(
        p_cpi_id => p_cpi_id,
        p_error_msg => substr(sqlerrm, 12));
  end not_null;


  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type
  as
    l_result binary_integer;
  begin
    pit.enter_optional('not_null',
      p_params => msg_params(
                    msg_param('p_value_list', p_value_list)));

    l_result := adc_api.not_null(p_value_list);

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Result', l_result)));
    return l_result;
  end not_null;
  
  
  procedure refresh_item(
    p_cpi_id in varchar2,
    p_item_value in varchar2 default null,
    p_set_item in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_item_value', p_item_value),
                    msg_param('p_set_item', p_set_item)));
    
    if p_set_item = adc_util.C_TRUE or p_item_value is not null then
      adc_api.execute_action(
        p_cat_id => 'REFRESH_AND_SET_VALUE',
        p_cpi_id => p_cpi_id,
        p_param_1 => coalesce(p_item_value, C_EMPTY_STRING));
    else
      adc_api.execute_action(
        p_cat_id => 'REFRESH_ITEM',
        p_cpi_id => p_cpi_id);
    end if;
    
    pit.leave_optional;
  end refresh_item;
  
  
  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_error_msg', p_error_msg),
                    msg_param('p_internal_error', p_internal_error)));

    adc_api.register_error(
      p_cpi_id => p_cpi_id,
      p_error_msg => p_error_msg,
      p_internal_error => p_internal_error);
      
    pit.leave_optional;
  end register_error;


  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_message_name', p_message_name)));

    adc_api.register_error(
      p_cpi_id => p_cpi_id, 
      p_message_name => p_message_name, 
      p_msg_args => p_msg_args);

    pit.leave_optional;
  end register_error;
  
  
  procedure remember_page_status(
    p_page_items in varchar2,
    p_message in varchar2,
    p_title in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_page_items', p_page_items),
                    msg_param('p_message', p_message),
                    msg_param('p_title', p_title)));
                    
    adc_api.execute_action(
      p_cat_id => 'REMEMBER_PAGE_STATE',
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_param_1 => p_page_items,
      p_param_2 => p_message,
      p_param_3 => coalesce(p_title, pit.get_trans_item_name('ADC_UI', 'ADC_UNSAVED_ITEM_TITLE')));

    pit.leave_optional;
  end remember_page_status;
  
  
  procedure select_region_entry(
    p_region_id in adc_util.ora_name_type,
    p_entry_id in adc_util.ora_name_type,
    p_notify in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id),
                    msg_param('p_entry_id', p_entry_id),
                    msg_param('p_notify', p_notify)));
                    
    adc_api.execute_action(
      p_cat_id => 'SELECT_REGION_ENTRY',
      p_cpi_id => p_region_id,
      p_param_1 => p_entry_id,
      p_param_2 => p_notify);

    pit.leave_optional;
  end select_region_entry;

  
  procedure set_focus(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    adc_api.execute_action(
      p_cat_id => 'SET_FOCUS',
      p_cpi_id => p_cpi_id);
      
    pit.leave_optional;
  end set_focus;
  
  
  procedure set_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_value in varchar2,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    l_item_value utl_apex.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_item_value', p_item_value),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_allow_recursion', p_allow_recursion)));
    
    l_item_value := coalesce(p_item_value, C_EMPTY_STRING);
    
    adc_api.set_session_state(
      p_cpi_id => p_cpi_id, 
      p_value => l_item_value,
      p_jquery_selector => p_jquery_selector,
      p_allow_recursion => p_allow_recursion);
        
    pit.leave_optional;
  end set_item;
  
  
  procedure set_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_value in number,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_item_value', p_item_value),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_allow_recursion', p_allow_recursion)));
        
    adc_api.set_session_state(
      p_cpi_id => p_cpi_id, 
      p_number_value => p_item_value,
      p_jquery_selector => p_jquery_selector,
      p_allow_recursion => p_allow_recursion);
        
    pit.leave_optional;
  end set_item;
  
  
  procedure set_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_value in date,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_item_value', p_item_value),
                    msg_param('p_jquery_selector', p_jquery_selector),
                    msg_param('p_allow_recursion', p_allow_recursion)));
    
    adc_api.set_session_state(
      p_cpi_id => p_cpi_id, 
      p_date_value => p_item_value,
      p_jquery_selector => p_jquery_selector,
      p_allow_recursion => p_allow_recursion);
        
    pit.leave_optional;
  end set_item;
  
  
  procedure set_item_label(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_label in varchar2,
    p_jquery_selector in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_item_label', p_item_label),
                    msg_param('p_jquery_selector', p_jquery_selector)));
    
    adc_api.execute_action(
      p_cat_id => 'SET_ITEM_LABEL',
      p_cpi_id => p_cpi_id,
      p_param_1 => trim(C_APOS from apex_escape.js_literal(p_item_label)),
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end set_item_label;


  procedure set_items_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_stmt in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_stmt', substr(p_stmt, 1, 4000))));

    adc_api.set_value_from_stmt(
      p_cpi_id => p_cpi_id,
      p_stmt => p_stmt);

    pit.leave_optional;
  end set_items_from_stmt;
  
  
  procedure set_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_msg_text in varchar2 default null,
    p_jquery_selector in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_msg_text', p_msg_text),
                    msg_param('p_jquery_selector', p_jquery_selector)));
    
    adc_api.execute_action(
      p_cat_id => 'IS_MANDATORY',
      p_cpi_id => p_cpi_id,
      p_param_1 => p_msg_text,
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end set_mandatory;
  
  
  procedure set_optional(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_jquery_selector in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_jquery_selector', p_jquery_selector)));
    
    adc_api.execute_action(
      p_cat_id => 'IS_OPTIONAL',
      p_cpi_id => p_cpi_id,
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end set_optional;
  
  
  procedure set_region_content(
    p_region_id in adc_page_items.cpi_id%type,
    p_html_code in adc_util.max_char)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id),
                    msg_param('p_html_code', p_html_code)));
    
    adc_api.execute_action(
      p_cat_id => 'SET_REGION_CONTENT',
      p_cpi_id => p_region_id,
      p_param_1 => trim(C_APOS from apex_escape.js_literal(p_html_code)));
      
    pit.leave_optional;
  end set_region_content;
  
  
  procedure show_hide_item(
    p_jquery_sel_show in varchar2,
    p_jquery_sel_hide in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_jquery_sel_show', p_jquery_sel_show),
                    msg_param('p_jquery_sel_hide', p_jquery_sel_hide)));
    
    adc_api.execute_action(
      p_cat_id => 'SHOW_HIDE_ITEMS',
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_param_1 => p_jquery_sel_show,
      p_param_2 => p_jquery_sel_hide);
      
    pit.leave_optional;
  end show_hide_item;
  
  
  procedure show_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_jquery_selector in varchar2 default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_jquery_selector', p_jquery_selector)));
    
    adc_api.execute_action(
      p_cat_id => 'SET_VISUAL_STATE',
      p_cpi_id => p_cpi_id,
      p_param_1 => 'SHOW_ENABLE',
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end show_item;


  procedure stop_rule
  as
  begin
    pit.enter_optional;

    adc_api.stop_rule;

    pit.leave_optional;
  end stop_rule;
  
  
  procedure submit_page(
    p_execute_validations in adc_util.flag_type default adc_util.C_TRUE)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_execute_validations', p_execute_validations)));
    
    if p_execute_validations = adc_util.C_TRUE then
      adc_api.validate_page;
    end if;

    pit.leave_optional;
  end submit_page;


  procedure validate_page
  as
  begin
    pit.enter_optional;

    adc_api.validate_page;

    pit.leave_optional;
  end validate_page;
  
end adc;
/