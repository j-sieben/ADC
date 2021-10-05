create or replace package adc_recursion_stack
  authid definer
  accessible by (package adc_internal)
as

  /** Package: ADC_RECURSION_STACK
      This package separates the maintenance of the recursive stack from the core functionality
      
      A recursion stack is used to control recursive rule execution in that the list of
      firing items for which the rules have to be evaluated is collected.
      It's a FIFO stack of unique items whith a recursive depth indicator.
      If a page item on the stack has been processed, it is popped from the stack.
      
      Items are pushed onto the stack only if
      
      - the max recusrive depth is not yet reached (to prevent endless loops)
      - the rule and the actually executed action allows for recursion 
      - the item to push is referenced in a technical rule condition of the actual rule group 
        (If this condition is not met, it is clear that pusing this item onto the recursive
        stack will lead to a no rule result, wasting resources)
      - the item was not pushed onto the recursion stack during the actual call before
      
      The recursion stack also maintains a list of all "touched" items, meaning all items
      which have been on the recursive stack during the actual rule evaluation.
      This allows to monitor that no item is pushed onto the recursive stack twice. 
      It it also used to remove any error message from the APEX page for these items. 
      The error messages may be attached again based on the response, but by using this mechanism, 
      it is possible to remove only those errors for which rules have been processed.
   */
  
  
  /**
    Procedure: reset
                 Method to reset the recursion stack.
                 
                 This method performs the following tasks:
                 
                 - reset the recursion stack
                 - detect whether the selected rule group supports recursion or not
                 - put the initial firing item onto the recursion stack.
                 
    Parameters:
      p_cgr_id - ID of the rule group. Is used to check whether recursion is allowed for this rule group
      p_cpi_id - ID of the page item to push. May also be adc_util.C_NO_FIRING_ITEM 
   */
  procedure reset(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type);
    
  
  /** 
    Procedure: push_firing_item
                 Method to register a firing item onto the recursion stack.
                 
                 If the actually selected action type does not allow for recursion, it will
                 not be pushed, resulting in no recursive rule evaluation
                 
    Parameters:
      p_cgr_id - ID of the rule group. 
      p_cpi_id - ID of the page item to push. May also be C_NO_FIRING_ITEM
      p_allow_recursion - Flag to indicate whether recursion is forbidden for that action type. Value can be overwritten by g_param.allow_recursion
   */
  procedure push_firing_item(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE);
  
  
  /**
    Procedure: pop_firing_item
                 Method to pop one or all items from the recursive stack.
                 
                 Normal use case is to pop the actual firing item after it has been succesfully evaluated.
                 If the rule execution signals a STOP_RULE, all recursive items are removed from the stack
                 
    Parameter:
      p_all - Flag to indicate whether all items should be popped (adc_util.C_TRUE) or not (adc_util.C_FALSE)
   */
  procedure pop_firing_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_all in adc_util.flag_type default adc_util.C_FALSE);
  
  
  /**
    Function: get_next
                Method to retrieve the name of the first entry of the recursion stack.
                
    Returns:
      Name of the first entry of the recursion stack
   */
  function get_next
    return adc_page_items.cpi_id%type;
    
  
  /**
    Function: get_level
                Method to retrieve the actual recursion level for notification purposes.
   */
  function get_level
    return pls_integer;
    
    
  /** 
    Function: get_firing_items_as_json
                Method get all firing items back in  JSON
                
                --- Code
                [{"id":"#ID#","value":"#VALUE#"},..]
                ---
                
                Is used to collect all firing items in JSON to send it back to the client
                
    Returns:
      JSON string containing the JSON representation of the CHAR_TABLE
   */
  function get_firing_items_as_json
    return varchar2;
    
    
end adc_recursion_stack;
/