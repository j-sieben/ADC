create or replace package adc_validation
  authid definer
  --accessible by (package adc_plugin, package adc_ui, package adc_internal, package adc_admin)
as 

  /* Method checks that a lov view exists for an action parameter type with an item type of SELECT_LIST
   * %param  p_cpt_id         Parameter Type
   * @param  p_cpt_item_type  Item type
   * %usage  Method is used to assert that a LOV for a parameter type of item type SELECT_LIST exists 
   *         with the correct column structure that is able to deliver LOV data
   * @throws msg.ADC_PARAM_LOV_MISSING if LOV view is required but missing
   *         msg.ADC_PARAM_LOV_INCORRECT if required LOV view exists but with the wrong structure
   */
  procedure validate_param_lov(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpt_item_type in adc_action_param_types.cpt_item_type%type);

  /* Method to calculate the SQL statement for a parameter type
   * %param  p_cpt_id       Parameter Type
   * %param  p_environment  Record with environmental data such as CGR_ID
   * %usage  Method is used to generate a SQL statement for the parameter LOV
   */
  function get_lov_sql(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2;
  
  /* Method to check an action type parameter
   * %param  p_value        Parameter value to check and format
   * %param  p_cpt_id       Parameter Type
   * %param  p_cpi_id       UI element to attach the error to
   * %param  p_environment  Record with environmental data such as CGR_ID
   * %usage  Method is used to check an entered parameter value against meta data and format it in order to directly
   *         use it in rule actions
   */
  procedure validate_parameter(
    p_value in out nocopy adc_rule_actions.cra_param_1%type,
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_environment in adc_util.environment_rec);
    
end adc_validation;
/
