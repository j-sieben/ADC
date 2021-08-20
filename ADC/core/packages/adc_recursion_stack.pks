create or replace package adc_recursion_stack
  authid definer
  accessible by (package adc_internal)
as

  /** Package to maintain the recursion stack for ADC
   * A recursion stack is used to control recursive rule execution in that the list of
   * firing items for which the rules have to be evaluated is collected.
   * It's a FIFO stack of unique items whith a recursive depth indicator.
   * Items are pushed onto the stack only 
   * - if the max recusrive depth is not yet reached,
   * - if the rule allows for recursion 
   * - if the action does not prohibit recursive execution and
   * - if the item to push is referenced in a technical rule condition of the actual rule group
   */
  
  
  /** Method reset the recursion stack 
   * %param  p_cgr_id  ID of the rule group. Is used to check whether recursion is allowed for this CGR
   * %param  p_cpi_id  ID of the page item to push. May also be C_NO_FIRING_ITEM
   * %usage  This method performs the following tasks:
   *         - reset the recursion stack
   *         - detects whether the selected rule group supports recursion or not
   *         - puts the initial firing item onto the recursion stack.
   */
  procedure reset(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type);
    
  
  /** Method to register a firing item onto the recursion stack
   * %param  p_cgr_id           ID of the rule group. 
   * %param  p_cpi_id           ID of the page item to push. May also be C_NO_FIRING_ITEM
   * %param  p_allow_recursion  Flag to indicate whether recursion is forbidden for that action type.
   *                            Value can be overwritten by g_param.allow_recursion
   * %usage  Is used to register recursion for a given page item.
   *         If the actually selected action type does not allow for recursion, it will
   *         not be pushed, resulting in no recursive rule evaluation
   */
  procedure push_firing_item(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);
  
  
  /** Method to pop one or all items from the recursive stack
   * %param  p_all  Flag to indicate whether all items should be popped (C_RUE) or not (C_FALSE)
   * %usage  Normal use case is to pop the actual firing item after it has been succesfully dealt with.
   *         If the rule execution signals a STOP_RULE, all recursive items are removed from the stack
   */
  procedure pop_firing_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_all in adc_util.flag_type default adc_util.C_FALSE);
  
  
  /** Method to retrieve the name of the first entry of the recursion stack.
   * %return Name of the first entry of the recursion stack
   * %usage  Is used to define the next firing item for a recursion.
   */
  function get_next
    return adc_page_items.cpi_id%type;
    
  
  /** Method to retrieve the actual recursion level
   * %usage  Is called to get the actual recursion level for notification purposes
   */
  function get_level
    return pls_integer;
    
    
  /** Method get all firing items back in  JSON [{"id":"#ID#","value":"#VALUE#"},..]
   * %return JSON string containing the JSON representation of the CHAR_TABLE
   * %usage  Is used to collect all firing items in JSON to send it back to the client
   */
  function get_firing_items_as_json
    return varchar2;
    
    
end adc_recursion_stack;
/