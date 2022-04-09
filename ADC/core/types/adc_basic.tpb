create or replace type body adc_basic 
as

  /**
    Package: ADC_BASIC body
      Implements the public interface of ADC and a wrapper around ADC_API.EXECUTE_ACTION for system defined action types.
      Is called by ADC dynamic pages declaratively and directly from PL/SQL.

    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
   
  static function C_HIDE
  return varchar2
  as
  begin
    return 'HIDE';
  end;
  
  static function C_SHOW_ENABLE
  return varchar2
  as
  begin
    return 'SHOW_ENABLE';
  end;
  
  static function C_SHOW_DISABLE
  return varchar2
  as
  begin
    return 'SHOW_DISABLE';
  end;
  
  static procedure add_javascript(
    p_javascript in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_javascript', p_javascript)));

    adc_api.add_javascript(p_javascript);

    pit.leave_optional;
  end add_javascript;
  
  
  static procedure clear_page_state
  as
  begin
    adc_api.clear_page_state;
  end clear_page_state;


  static procedure exclusive_or(
    p_cpi_id in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default 'ASSERTION_FAILED',
    p_error_on_null in varchar2 default 'Y')
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


  static function exclusive_or(
    p_value_list in varchar2)
    return varchar2
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
  

  static procedure handle_bulk_errors(
    p_mapping in char_table default null)
  as
  begin
    pit.enter_optional;
    
    adc_api.handle_bulk_errors(p_mapping);
    
    pit.leave_optional;
  end handle_bulk_errors;
  
  
  static procedure initialize_form_region(
    p_static_id in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_static_id', p_static_id)));

    adc_api.initialize_form_region(p_static_id);
    
    pit.leave_optional;
  end initialize_form_region;
  

  static procedure not_null(
    p_cpi_id in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default 'ASSERTION_FAILED')
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


  static function not_null(
    p_value_list in varchar2)
    return varchar2
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
  
  
  static procedure remember_page_status(
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
  
  
  static procedure refresh_item(
    p_cpi_id in varchar2,
    p_item_value in varchar2 default null,
    p_set_item in varchar2 default 'Y')
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
        p_param_1 => p_item_value);
    else
      adc_api.execute_action(
        p_cat_id => 'REFRESH_ITEM',
        p_cpi_id => p_cpi_id);
    end if;
    
    pit.leave_optional;
  end refresh_item;
  
  
  static procedure register_error(
    p_cpi_id in varchar2,
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


  static procedure register_error(
    p_cpi_id in varchar2,
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
  
  
  static procedure select_region_entry(
    p_region_id in varchar2,
    p_entry_id in varchar2,
    p_notify in varchar2 default 'Y')
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
  
  
  static procedure select_tab(
    p_region_id in varchar2,
    p_tab_id in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id),
                    msg_param('p_tab_id', p_tab_id)));
                    
    adc_api.execute_action(
      p_cat_id => 'SELECT_TAB',
      p_cpi_id => p_tab_id,
      p_param_1 => p_region_id);

    pit.leave_optional;
  end select_tab;

  
  static procedure set_focus(
    p_cpi_id in varchar2)
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
  
  
  static procedure set_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in varchar2 default null,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 'Y')
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
      p_value => p_item_value,
      p_jquery_selector => p_jquery_selector,
      p_allow_recursion => p_allow_recursion);
        
    pit.leave_optional;
  end set_item;
  
  
  static procedure set_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in number,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 'Y')
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
  
  
  static procedure set_item(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_item_value in date,
    p_jquery_selector in varchar2 default null,
    p_allow_recursion in varchar2 default 'Y')
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
  
  
  static procedure set_item_label(
    p_cpi_id in varchar2 default 'DOCUMENT',
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
      p_param_1 => trim(chr(39) from apex_escape.js_literal(p_item_label)),
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end set_item_label;


  static procedure set_items_from_statement(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_statement in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_statement', p_statement)));

    adc_api.set_value_from_statement(
      p_cpi_id => p_cpi_id,
      p_statement => p_statement);

    pit.leave_optional;
  end set_items_from_statement;


  static procedure set_items_from_cursor(
    p_cursor in out nocopy sys_refcursor)
  as
  begin
    pit.enter_optional;

    adc_api.set_value_from_cursor(
      p_cursor => p_cursor);

    pit.leave_optional;
  end set_items_from_cursor;
  
  
  static procedure set_mandatory(
    p_cpi_id in varchar2 default 'DOCUMENT',
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
  
  
  static procedure set_optional(
    p_cpi_id in varchar2 default 'DOCUMENT',
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
  
  
  static procedure set_region_content(
    p_region_id in varchar2,
    p_html_code in varchar2)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_region_id', p_region_id),
                    msg_param('p_html_code', p_html_code)));
    
    adc_api.execute_action(
      p_cat_id => 'SET_REGION_CONTENT',
      p_cpi_id => p_region_id,
      p_param_1 => trim(chr(39) from apex_escape.js_literal(p_html_code)));
      
    pit.leave_optional;
  end set_region_content;
  
  
  static procedure set_visual_state(
    p_cpi_id in varchar2 default 'DOCUMENT',
    p_visual_state in varchar2,
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
      p_param_1 => p_visual_state,
      p_param_2 => p_jquery_selector);
      
    pit.leave_optional;
  end set_visual_state;
  
  
  static procedure show_hide_item(
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
  
  
  static procedure show_notification(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_message_name', p_message_name)));
    
    adc_api.execute_action(
      p_cat_id => 'NOTIFY',
      p_cpi_id => adc_util.C_NO_FIRING_ITEM,
      p_param_1 => pit.get_message_text(p_message_name, p_msg_args));
      
    pit.leave_optional;
  end show_notification;


  static procedure submit_page(
    p_execute_validations in varchar2 default 'Y')
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
  

  static procedure stop_rule
  as
  begin
    pit.enter_optional;

    adc_api.stop_rule;

    pit.leave_optional;
  end stop_rule;
  
  
  static procedure validate_page
  as
  begin
    pit.enter_optional;

    adc_api.validate_page;

    pit.leave_optional;
  end validate_page;  
  
end;
/
