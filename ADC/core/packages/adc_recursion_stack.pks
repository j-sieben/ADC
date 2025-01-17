create or replace package adc_recursion_stack
  authid definer
  accessible by (package adc_internal, package adc_response, package adc_page_state, package ut_adc_recursion_stack)
as

  /**
    Package: ADC_RECURSION_STACK
      This package separates the maintenance of the recursive stack from the core functionality.
      It is accessible by <ADC_INTERNAL> only.

      A recursion stack is used to control recursive rule execution in that the list of
      firing items for which the rules have to be evaluated is collected.
      It's a FIFO stack of unique items whith a recursive depth indicator.
      If a page item on the stack has been processed, it is popped from the stack.

      Items are pushed onto the stack only if

      - the max recursive depth is not yet reached (to prevent endless loops)
      - the rule and the actually executed action allows for recursion
      - the item to push is referenced in a technical rule condition of the actual rule group
        (If this condition is not met, it is clear that pusing this item onto the recursive
        stack will lead to a no rule result, wasting resources)
      - the item was not pushed onto the recursion stack during the actual call before,
        prventing unnecessary double rule evaluation

      The recursion stack also maintains a list of all "touched" items, meaning all items
      which have been on the recursive stack during the actual rule evaluation.
      This allows to monitor that no item is pushed onto the recursive stack twice.
      It it also used to remove any error message from the APEX page for these items.
      The error messages may be attached again based on the response, but by using this mechanism,
      it is possible to remove only those errors for which rules have been processed.

    Author::
      Juergen Sieben, ConDeS GmbH
   */

  /**
    Group: Public methods
   */
  /**
    Procedure: reset
      Method to reset the recursion stack.

      This method performs the following tasks:

      - reset the recursion stack
      - detect whether the selected rule group supports recursion or not
      - put the initial firing item onto the recursion stack.

    Parameters:
      p_crg_id - ID of the rule group. Is used to check whether recursion is allowed for this rule group
      p_cpi_id - ID of the page item to push. May also be <adc_util.C_NO_FIRING_ITEM>
      p_event - Event that caused the plugin to react. Defaults to initialize
   */
  procedure reset(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_event in adc_event_types.cet_id%type default 'initialize');


  /**
    Procedure: push_firing_item
      Method to register a firing item onto the recursion stack.

      If the actually selected action type does not allow for recursion, it will
      not be pushed, resulting in no recursive rule evaluation

    Parameters:
      p_crg_id - ID of the rule group.
      p_cpi_id - ID of the page item to push. May also be C_NO_FIRING_ITEM
      p_event - Event that was raised
      p_event_data - Optional event data for a given item. Is required when executing a command,
                     as the name of the comman is passed in via this way.
      p_allow_recursion - Flag to indicate whether recursion is forbidden for that action type.
                          Value can be overwritten by g_param.allow_recursion, so if the rule is
                          set to not evaluate recursion, this will be respected.
      p_force - Flag to indicate whether this item should be pushed anyway to the recursive stack.
                Set to C_TRUE on page initialization to assure that all firing items are on the
                recursive stack.
      p_recursive_depth - External recursion counter
   */
  procedure push_firing_item(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_event in adc_page_item_types.cpit_cet_id%type,
    p_event_data in adc_util.max_char default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_force in adc_util.flag_type default adc_util.C_FALSE,
    p_recursive_depth in binary_integer default null);


  /**
    Procedure: register_touched_item
      Method to register that a validation or similar has "touched" a page item. This method
      is used to make sure that any errors which were shown on the page are removed from the
      error list, even if the page items were not processed as part of a rule evaluation.
      This could happen, if the page as a whole is validated.

    Parameter:
      p_cpi_id - ID of the page item to push. May also be C_NO_FIRING_ITEM
   */
  procedure register_touched_item(
    p_cpi_id in adc_page_items.cpi_id%type);


  /**
    Procedure: pop_firing_item
      Method to pop one or all items from the recursive stack.

      Normal use case is to pop the actual firing item after it has been succesfully evaluated.
      If the rule execution signals a STOP_RULE, all recursive items are removed from the stack

    Parameter:
      p_cpi_id - ID of the page item to pop. May also be C_NO_FIRING_ITEM
      p_all - Flag to indicate whether all items should be popped (adc_util.C_TRUE) or not (adc_util.C_FALSE)
   */
  procedure pop_firing_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_all in adc_util.flag_type default adc_util.C_FALSE);


  /**
    Function: check_recursion
      Method to determine whether rule execution has to be checked for recursive allowance.

      Normally, any rule is checked whether it is allowed to be executed recursively. A rule that is set to
      FIRE_ON_PAGE_LOAD is an exception in this regard if the page is in initialization process.
      Whether this is true for the actual rule is checked within this method.

    Parameters:
      p_cra_cpi_id - Item parameter of the rule action
      p_cru_fire_on_page_load - Flag to indicate whether this rule has to be executed on page load as well

    Returns:
      Flag to indicate whether a recursion has to be checked or not.
   */
  function check_recursion(
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type)
    return adc_util.flag_type;


  /**
    Function: get_next
      Method to retrieve the name of the first entry of the recursion stack.

    Parameters:
      p_cpi_id - Out parameter with the name of the first entry of the recursion stack
      p_event - Out parameter with the event initially raised
      p_event_data - Out parameter with the event data initially entered
   */
  procedure get_next(
    p_cpi_id out nocopy adc_page_items.cpi_id%type,
    p_event out nocopy adc_page_item_types.cpit_cet_id%type,
    p_event_data out nocopy varchar2);


  /**
    Function: get_level
      Method to retrieve the actual recursion level for notification purposes.
   */
  function get_level
    return binary_integer;


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