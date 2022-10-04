create or replace package body sadc_ui
as

  /* Package constants */
  C_PMG_NAME constant adc_util.ora_name_type := 'SADC';
  
  /* Global Variables */
  g_page_values utl_apex.page_value_t;
  
  
  /* Helper method to copy session state values from an APEX page 
   * %usage  Is called to copy the actual session state of an APEX page into a PL/SQL table
   */
  procedure copy_edpti(
    p_row in out nocopy pit_translatable_item%rowtype)
  as
  begin
    pit.enter_detailed('copy_edpti');
  
    g_page_values := utl_apex.get_page_values('EDPTI_FORM');
    p_row.pti_id := utl_apex.get(g_page_values, 'pti_id');
    p_row.pti_pmg_name := utl_apex.get(g_page_values, 'pti_pmg_name');
    p_row.pti_name := utl_apex.get(g_page_values, 'pti_name');
    p_row.pti_display_name := utl_apex.get(g_page_values, 'pti_display_name');
    p_row.pti_description := utl_apex.get(g_page_values, 'pti_description');
  
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
               on lower(substr(target_value, instr(target_value, ':') + 1, instr(target_value, ':', 1, 2) - instr(target_value, ':') - 1)) in (to_char(page_id), lower(page_alias))
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
  
  
  function get_adc_admin_url
  return varchar2
  as
    l_url adc_util.sql_char;
    l_cgr_id adc_rule_groups.cgr_id%type;
    C_URL_TEMPLATE constant adc_util.sql_char := q'^javascript:apex.navigation.openInNewWindow('#URL#', 'ADC');^';
  begin
    with params as (
           select /*+ no_merge */utl_apex.get_application_id(adc_util.C_FALSE) p_app_id,
                  utl_apex.get_page_id p_page_id
             from dual)
    select cgr_id
      into l_cgr_id
      from adc_rule_groups
      join params p
        on cgr_app_id = p_app_id
       and cgr_page_id = p_page_id;
       
    l_url := apex_page.get_url(
               p_application => 'ADC',
               p_page => 'DESIGNER',
               p_items => 'P13_CGR_ID,P13_CGR_APP_ID,P13_SELECTED_NODE',
               p_values => l_cgr_id || ',' || utl_apex.get_application_id(adc_util.C_FALSE) || ', CGR_' || l_cgr_id);
    return replace(C_URL_TEMPLATE, '#URL#', l_url);
  exception
    when NO_DATA_FOUND then
      return null;
  end get_adc_admin_url;
  
  
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
    p_job_id in hr_jobs.job_id%type)
  return adc_util.flag_type 
  as
    l_is_commission_eligible adc_util.flag_type;
  begin
  
    select job_is_commission_eligible
      into l_is_commission_eligible
      from hr_jobs
     where job_id = p_job_id;
     
    return l_is_commission_eligible;
    
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
    l_row pit_translatable_item%rowtype;
  begin
    pit.enter_mandatory;
  
    copy_edpti(l_row);
    
    pit.start_message_collection;
    pit_admin.validate_translatable_item(l_row);
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
    l_row pit_translatable_item%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edpti(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_translatable_item(l_row);
    else
      pit_admin.delete_translatable_item(
        l_row.pti_id,
        l_row.pti_pmg_name);
    end case;
    
    pit.leave_mandatory;
  end process_edpti;
  
  
  procedure adact_control_action
  as
    l_emp_id sadc_ui_adact.emp_id%type;
    l_is_manager adc_util.flag_type;
    l_label adc_util.ora_name_type;
  begin
    pit.enter_mandatory;
    
    -- Initialization
    l_emp_id := adc_api.get_event_data;
    adc_apex_action.action_init('edit-employee');
    
    select emp_is_manager, substr(emp_first_name, 1, 1) || '. ' || emp_last_name || ' bearbeiten'
      into l_is_manager, l_label
      from hr_jobs
      join hr_employees
        on job_id = emp_job_id
     where emp_id = l_emp_id;
     
    if l_is_manager = adc_util.C_TRUE then
      adc_apex_action.set_label('Nicht bearbeitbar');
      adc_apex_action.set_disabled(true);
    else
      adc_apex_action.set_label(l_label);
      adc_apex_action.set_disabled(false);
      adc_apex_action.set_href(
        utl_apex.get_page_url(
          p_page => 'edemp',
          p_param_items => 'P9_EMP_ID',
          p_value_list => l_emp_id,
          p_triggering_element => 'B8_EDIT_EMP',
          p_clear_cache => 9));
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(adc_api.get_event_data));
  end adact_control_action;
  
  
  procedure print_help_text(
    p_cat_id in adc_action_types.cat_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_cat_id', p_cat_id)));
      
    utl_apex.print(get_help_text(p_cat_id));
   
    pit.leave_mandatory;
  end print_help_text;
  
  
  function get_help_text(
    p_cat_id in adc_action_types.cat_id%type)
  return varchar2
  as
    l_help_text adc_util.max_char;
  begin
    pit.enter_mandatory('get_help_text',
      p_params => msg_params(msg_param('p_cat_id', p_cat_id)));
      
    select help_text
      into l_help_text
      from adc_bl_cat_help
     where cat_id = p_cat_id;
  
    pit.leave_mandatory;
    return(l_help_text);   
  end get_help_text;
  

end sadc_ui;
/