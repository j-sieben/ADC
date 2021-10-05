create or replace package adc_validation
  authid definer
  accessible by (package adc_plugin, package adc_ui, package adc_internal, package adc_admin)
as 

  /**
    Package: ADC_VALIDATION
               Implements validation functionality for the internal meta data adminsitration.
    
    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Procedure: validate_param_lov
                 Method checks that a LOV view exists.
                 
                 For a action parameter of type SELECT_LIST, a LOV view is required to calculate
                 the actual display and return values. It must also provide a column with the
                 CGR_ID the values relate to to allow for filtering.
                 This method checks that a LOV view with the correct column structure 
                 that is able to deliver LOV data exists.
                 
                 This view must adhere to the naming convention ADC_PARAM_LOV_<PARAMETER_TYPE>
                 
    Example:                 
      For a parameter called PAGE_ITEM with parameter type SELECT_LIST, a view called
      ADC_PARAM_LOV_PAGE_ITEM must exist with a D, R and CGR_ID column.
                 
    Parameters:
      p_cpt_id - Parameter Type
      p_cpt_item_type - Item type
      
    Errors:
      msg.ADC_PARAM_LOV_MISSING - if LOV view is required but missing
      msg.ADC_PARAM_LOV_INCORRECT - if required LOV view exists but with the wrong structure
   */
  procedure validate_param_lov(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpt_item_type in adc_action_param_types.cpt_item_type%type);


  /**
    Function: get_lov_sql
                Method to calculate the SQL statement for a parameter type.
                
                This method is called from ADC_UI to populate a LOV item for a parameter.
                
    Parameters:
      p_cpt_id - Parameter Type
      p_cgr_id - ID of the rule group to filter the LOV data if required.
   */
  function get_lov_sql(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2;
  
  /**
    Procedure: validate_parameter
                 Method to check an entered parameter value against meta data and 
                 format it in order to directly use it in rule actions.
                 
    Parameters:
      p_value - Parameter value to check and format
      p_cpt_id - Parameter Type
      p_cpi_id - UI element to attach the error to
      p_environment - Record with environmental data such as CGR_ID
   */
  procedure validate_parameter(
    p_value in out nocopy adc_rule_actions.cra_param_1%type,
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_environment in adc_util.environment_rec);
    
end adc_validation;
/
