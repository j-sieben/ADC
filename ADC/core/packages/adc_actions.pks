create or replace package adc_actions
  authid definer
  accessible by (package adc_api)
as

  /** 
    Package: ADC_ACTIONS
      Package to implement complexer logic for ADC_API. This package helps
      keeping package ADC_API focussed on the API functionality without moving
      action related logic into the core packages of ADC.
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Public methods
   */
  /**
    Procedure: exclusive_or
      See: <ADC_API.exclusive_or
   */
  procedure exclusive_or(
    p_cpi_id in varchar2,
    p_item_list in varchar2,
    p_message in varchar2 default null,
    p_error_on_null in boolean default true);
    
    
  /**
    Procedure: execute_javascript
      See: <ADC_API.execute_javascript
   */
  procedure execute_javascript(
    p_plsql in varchar2);
  
  
  /**
    Procedure: execute_plsql
      See: <ADC_API.execute_plsql
   */
  procedure execute_plsql(
    p_plsql in varchar2);
    
  /**
    Function: get_lov_sql
      See: <ADC_API.get_lov_sql
   */
  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2;
    
    
  /**
    Procedure: handle_bulk_errors
      See: <ADC_API:handle_bulk_errors
   */
  procedure handle_bulk_errors(
    p_mapping in char_table default null,
    p_filter_list in varchar2 default null);
  
  
  /**
    Function: has_class
      See <ADC_API.has_class>
   */
  function has_class(
    p_class in varchar2)
    return adc_util.flag_type;
  
  
  /**
    Procedure: initialize_form_region
      See <ADC_API.initialize_form_region>
   */
  procedure initialize_form_region(
    p_static_id in adc_util.ora_name_type);
  
  
  /**
    Function: not_null
      See <ADC_API.not_null>
   */
  function not_null(
    p_item_list in varchar2)
    return adc_util.flag_type;
  
  
  /**
    Procedure: remember_page_state
      See <ADC_API.remember_page_state>
   */
  procedure remember_page_state(
    p_cpi_id in varchar2 default null,
    p_page_items in varchar2 default null);
  
  
end adc_actions;
/
