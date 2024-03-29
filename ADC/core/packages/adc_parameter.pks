create or replace package adc_parameter 
  authid definer
  accessible by (package adc_internal, package adc_admin, package adca_ui_designer)
as

  /** 
    Package: ADC_PARAMETER
      Package to handle parameter values. There are two main tasks to perform:
      
        - Validate any parameter upon creation or change of the rule action
        - Evaluate the parameter value upon execution
               
    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  /**
    Group: Public methods
   */
  /**
    Procedure: validate_param_lov
      Method checks that a LOV view exists.

      For an action parameter of type SELECT_LIST, a LOV view is required to calculate
      the actual display and return values. It must also provide a column with the
      CRG_ID the values relate to to allow for filtering.
      This method checks that a LOV view with the correct column structure
      that is able to deliver LOV data exists.

      This view must adhere to the naming convention ADC_PARAM_LOV_<PARAMETER_TYPE>

    Example:
      For a parameter called PAGE_ITEM with parameter type SELECT_LIST, a view called
      ADC_PARAM_LOV_PAGE_ITEM must exist with a D, R and CRG_ID column.

    Parameters:
      p_capt_id - Parameter Type
      p_capt_capvt_id - Item type

    Errors:
      msg.ADC_PARAM_LOV_MISSING - if LOV view is required but missing
      msg.ADC_PARAM_LOV_INCORRECT - if required LOV view exists but with the wrong structure
   */
  procedure validate_param_lov(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_capt_capvt_id in adc_action_param_types.capt_capvt_id%type);
    

  /**
    Procedure: validate_parameter
      Method to check an entered parameter value against meta data and
      format it in order to directly use it in rule actions.

    Parameters:
      p_value - Parameter value to check and format
      p_capt_id - Parameter Type
      p_cpi_id - UI element to attach the error to
   */
  procedure validate_parameter(
    p_value in out nocopy adc_rule_actions.cra_param_1%type,
    p_capt_id in adc_action_param_types.capt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type);    
  
  
  /**
    Function: get_param_lov_query
      Method to caculate a query for a parameter in case its type mandates for a LOV.
      
      Is called when creating a new parameter type from within the ADC app as well as
      when exporting. The statement must be present in the export file to circumvent
      the necessity of having a direct CREATE VIEW grant for any user working with ADC.
      
    Parameters:
      p_row - Instance of <ADC_ACTION_PARAM_TYPES_V>
      
    Returns:
      A create view statement, if the parameter type includes a LOV and NULL otherwise
   */
  function get_param_lov_query(
    p_row in out nocopy adc_action_param_types_v%rowtype)
    return varchar2;
  
  
  /**
    Function: get_param_lov_comment
      Method to caculate a query for a parameter in case its type mandates for a LOV.
      
      Is called when creating a new parameter type from within the ADC app as well as
      when exporting. The statement must be present in the export file to circumvent
      the necessity of having a direct CREATE VIEW grant for any user working with ADC.
      
    Parameters:
      p_row - Instance of <ADC_ACTION_PARAM_TYPES_V>
      
    Returns:
      A create view comment statement, if the parameter type includes a LOV and NULL otherwise
   */
  function get_param_lov_comment(
    p_row in out nocopy adc_action_param_types_v%rowtype)
    return varchar2;
    
    
   /** 
    Function: analyze_selector_parameter
      Helper to analyze a rule action parameter.
      
      The following syntactical possibilities exist:
      
      - jQuery CSS selector
      - jQuery ID selector
      - static string, encapsulated in single quotes
      - PL/SQL-Block without single quotes, with or without terminating semicolon
      
    Parameters:
      p_cpi_id - Name of the referenced item or <ADC_UTIL.C_NO_FIRING_ITEM>
      p_param - Attribute value to analyze
      
    Returns:
      Result of the analysis, either static or dynamic.
   */
  function analyze_selector_parameter(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_param in adc_rule_actions.cra_param_2%type)
    return varchar2;
   
  /**
    Function: evaluate_parameter
      Method to evaluate a parameter value based on its type and value. This method
      is called when the rule is executed to replace parameter values with calculated
      values such as the result of function calls or PIT messages.
      
    Parameters:
      p_capt_id - Type of the parameter
      p_param_value - Actual parameter value
      
    Returns:
      Evaluated parameter value.
   */
  function evaluate_parameter(
    p_capt_id adc_action_param_types.capt_id%type,
    p_param_value adc_rule_actions.cra_param_1%type,
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
    return varchar2;
  
  
end adc_parameter;
/