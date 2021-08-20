create or replace package body sadc_ui
as

  /* Package constants */
  C_PMG_NAME constant adc_util.ora_name_type := 'SADC';
  
  /* Global Variables */
  g_page_values utl_apex.page_value_t;
  g_edpti_row pit_translatable_item%rowtype;
  
  
  /* Helper method to copy session state values from an APEX page 
   * %usage  Is called to copy the actual session state of an APEX page into a PL/SQL table
   */
  procedure copy_edpti
  as
  begin
    pit.enter_detailed('copy_edpti');
  
    g_page_values := utl_apex.get_page_values('EDPTI_FORM');
    g_edpti_row.pti_id := utl_apex.get(g_page_values, 'pti_id');
    g_edpti_row.pti_pmg_name := utl_apex.get(g_page_values, 'pti_pmg_name');
    g_edpti_row.pti_name := utl_apex.get(g_page_values, 'pti_name');
    g_edpti_row.pti_display_name := utl_apex.get(g_page_values, 'pti_display_name');
    g_edpti_row.pti_description := utl_apex.get(g_page_values, 'pti_description');
  
    pit.leave_detailed;
  end copy_edpti;

  /* INTERFACE */
  function c_true
    return adc_util.flag_type
  as
  begin
    return adc_util.C_TRUE;
  end c_true;
  
    
  function c_false
    return adc_util.flag_type
  as
  begin
    return adc_util.C_FALSE;
  end c_false;
  
  
  procedure calculate_prev_next
  as
    l_prev_title utl_apex.ora_name_type;
    l_prev_target utl_apex.ora_name_type;
    l_prev_id apex_application_pages.page_id%type;
    l_next_title utl_apex.ora_name_type;
    l_next_target utl_apex.ora_name_type;
    l_next_id apex_application_pages.page_id%type;
  begin
    pit.enter_mandatory;
    
    with params as (
           select utl_apex.get_application_id p_app_id,
                  utl_apex.get_page_id p_page_id
             from dual),
        data as(
           select /*+ no_merge(p) */ 
                  lag(page_name) over (order by display_sequence) prev_title, 
                  lag(page_alias) over (order by display_sequence) prev_target,
                  lag(page_id) over (order by display_sequence) prev_id,
                  lead(page_name) over (order by display_sequence) next_title, 
                  lead(page_alias) over (order by display_sequence) next_target,
                  lead(page_id) over (order by display_sequence) next_id,
                  page_id, p_page_id, display_sequence
             from apex_application_pages
             join params p
               on application_id = p_app_id
             join apex_ui_list_menu
                  -- Extrahiere Zielseite aus Navigationsmenue und joine ueber Seiten-ID oder -Alias
               on substr(target_value, instr(target_value, ':') + 1, instr(target_value, ':', 1, 2) - instr(target_value, ':') - 1) in (to_char(page_id), page_alias)
            where list_name = 'Desktop Navigation Menu'
              and level_value = 3
              and parent_page_alias = 'tutorial')
    select prev_id, prev_title, prev_target, next_id, next_title, next_target
      into l_prev_id, l_prev_title, l_prev_target, l_next_id, l_next_title, l_next_target
      from data
     where page_id = p_page_id
     order by display_sequence;
         
    utl_apex.set_value('SADC_PREV_TITLE', l_prev_title);
    utl_apex.set_value('SADC_PREV_TARGET', l_prev_target);
    utl_apex.set_value('SADC_PREV_ID', l_prev_id);
    utl_apex.set_value('SADC_NEXT_TITLE', l_next_title);
    utl_apex.set_value('SADC_NEXT_TARGET', l_next_target);
    utl_apex.set_value('SADC_NEXT_ID', l_next_id);
    
    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('SADC_PREV_TITLE', l_prev_title),
                    msg_param('SADC_PREV_TARGET', l_prev_target),
                    msg_param('SADC_PREV_ID', l_prev_id),
                    msg_param('SADC_NEXT_TITLE', l_next_title),
                    msg_param('SADC_NEXT_TARGET', l_next_target),
                    msg_param('SADC_NEXT_ID', l_next_id)));
  exception
    when no_data_found then
      pit.leave_mandatory;
  end calculate_prev_next;
  
  
  procedure validate_p6_date
  as
    l_date date;
  begin
    -- Initialization
    l_date := utl_apex.get_date('DATE');
    
    if l_date > sysdate and trim(to_char(l_date, 'DAY', 'NLS_DATE_LANGUAGE=AMERICAN')) not in ('SATURDAY', 'SUNDAY') then
      null;
    else
      adc.register_error(
        p_cpi_id => 'P6_DATE',
        p_error_msg => 'Das Datum muss in der Zukunft liegen und ein Arbeitstag sein.');
    end if;
  end validate_p6_date;
    
    
  procedure validate_p6_number
  as
    l_number number;
  begin
    -- Initialization
    l_number := utl_apex.get_number('NUMBER');
    
    if l_number between 100 and 1000 and mod(l_number, 3) = 0 then
      null;
    else
      adc.register_error(
        p_cpi_id => 'P6_NUMBER',
        p_error_msg => 'Das Zahl muss zwischen 100 und 1000 liegen und durch 3 teilbar sein.');
    end if;
  end validate_p6_number;
  
  

  function is_comm_eligible(
    p_job_id in jobs.job_id%type)
    return adc_util.flag_type 
  as
    l_comm_eligible pls_integer;
  begin
  
    select comm_eligible
      into l_comm_eligible
      from jobs
     where job_id = p_job_id;
     
    return case l_comm_eligible when 1 then adc_util.C_TRUE else adc_util.C_FALSE end;
    
  end is_comm_eligible;
  
  
  procedure print_text(
    p_text_id in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_text_id', p_text_id)));
    
    htp.prn(
      pit.get_trans_item_description(
        p_pti_pmg_name => C_PMG_NAME,
        p_pti_id => p_text_id));
    
    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      htp.prn(
        pit.get_trans_item_name(
          p_pti_pmg_name => C_PMG_NAME,
          p_pti_id => 'UI_TEXT_MISSING',
          p_msg_args => msg_args(p_text_id)));
  end print_text;
  
  
  function validate_edpti
    return boolean
  as
  begin
    pit.enter_mandatory;
  
    copy_edpti;
    
    pit.start_message_collection;
    pit_admin.validate_translatable_item(g_edpti_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table());
      return true;
  end validate_edpti;
  
  
  procedure process_edpti
  as
  begin
    pit.enter_mandatory;
    
    copy_edpti;
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_translatable_item(g_edpti_row);
    else
      pit_admin.delete_translatable_item(g_edpti_row.pti_id);
    end case;
    
    pit.leave_mandatory;
  end process_edpti;
  
  
  procedure adact_control_action
  as
    l_employee_id sadc_ui_adact.employee_id%type;
    l_is_manager pls_integer;
    l_label varchar2(100 byte);
  begin
    pit.enter_mandatory;
    
    -- Initialization
    l_employee_id := to_number(adc_api.get_event_data);
    adc_apex_action.action_init('edit-employee');
    
    select j.is_manager, substr(e.first_name, 1, 1) || '. ' || e.last_name || ' bearbeiten'
      into l_is_manager, l_label
      from jobs j
      join employees e
        on j.job_id = e.job_id
     where e.employee_id = l_employee_id;
     
    if l_is_manager = 1 then
      adc_apex_action.set_label('Nicht bearbeitbar');
      adc_apex_action.set_disabled(true);
    else
      adc_apex_action.set_label(l_label);
      adc_apex_action.set_disabled(false);
      adc_apex_action.set_href(
        utl_apex.get_page_url(
          p_page => 'edemp',
          p_param_items => 'P9_EMPLOYEE_ID',
          p_value_list => l_employee_id,
          p_triggering_element => 'B8_EDIT_EMP',
          p_clear_cache => 9));
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);
    
    pit.leave_mandatory;
  end adact_control_action;
  
  
  procedure print_help_text(
    p_cat_id in adc_action_types.cat_id%type)
  as
    l_help_text adc_util.max_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_cat_id', p_cat_id)));
      
    select help_text
      into l_help_text
      from adc_bl_cat_help
     where cat_id = p_cat_id;
  
    utl_apex.print(l_help_text);
   
    pit.leave_mandatory;
  end print_help_text;
  

end sadc_ui;
/