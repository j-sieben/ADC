create or replace package body adc_recursion_stack 
as

  /** 
    Package: ADC_RECURSION_STACK Body
      Implements the ADC_RECURSION_STACK logic.
      
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /**
    Group: Private types
   */
  type recursive_entry_t is record(
    cpi_id adc_page_items.cpi_id%type,
    recursive_level binary_integer,
    event adc_page_item_types.cpit_cet_id%type,
    event_data adc_util.max_char);
  
  /**
    Type: recursive_stack_t
      Table of recursion levels indexed by page item IDs.
      
      This stack persists all page items for which rules have to be evaluated along
      with their recursive depth.
   */
  type recursive_stack_t is table of recursive_entry_t index by adc_util.ora_name_type;
  
  
  /**
    Type: recursion_rec
      Record to hold all necessary informations about recursive items
      
    Properties:
      item_stack recursive_stack_t - List of items which were marked to recursively check rules for
      firing_items char_table - List of all "touched" page items. Used to monitor double recursion and 
                                to provide a list of all items for which existing error messages have to be removed
      is_recursive adc_util.flag_type - Flag to indicate whether we're in a recursive rule run
      allow_recursion adc_util.flag_type - Flag to indicate whether recursive calls are allowed for the active rule,
      recursion_limit binary_integer - Parameter to control max recursion depth
      loop_is_error boolean - Parameter to control whether a loop in recursion has to be treated as an error
   */
  type recursion_rec is record(
    item_stack recursive_stack_t, 
    firing_items char_table,
    is_recursive adc_util.flag_type,
    allow_recursion adc_util.flag_type,
    recursion_limit binary_integer,
    loop_is_error boolean
  );
  
  g_recursion recursion_rec;
  g_recursion_level binary_integer;
  
  
  /**
    Group: Private constants
   */
  /**
    Constants:
      C_PARAM_GROUP - Name of the parameter group
   */
  C_PARAM_GROUP constant parameter_v.par_pgr_id%type := 'ADC';
  C_COMMAND constant adc_util.ora_name_type := 'COMMAND';
  
  /**
    Group: Private methods
   */
  /**
    Function: stack_is_not_empty
      Method checks whether recursion stack contains entries.
   */
  function stack_is_not_empty
    return boolean
  as
  begin
    return g_recursion.item_stack.count > 0;
  end stack_is_not_empty;
  
  
  /** 
    Function: get_first_item
      Method retrieves the first item on the stack.
   */
  function get_first_item
    return recursive_entry_t
  as
  begin
    return g_recursion.item_stack(g_recursion.item_stack.first);
  end get_first_item;
  
  
  /**
    Procedure: initialize
      Package initialization method
   */
  procedure initialize
  as
  begin
    g_recursion.loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion.recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
    g_recursion.firing_items := char_table();
  end initialize;

  
  /**
    Group: Public methods
   */
  /**
    Procedure: reset
      See <ADC_RECURSION_STACK.reset>
   */
  procedure reset(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_event in adc_event_types.cet_id%type default 'initialize')
  as
  begin
    pit.enter_optional('reset',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_event', p_event)));
    
    pit.assert_not_null(p_crg_id);
    pit.assert_not_null(p_cpi_id);
    
    pop_firing_item(null, adc_util.C_TRUE);
    g_recursion.firing_items.delete;
    g_recursion_level := 0;
        
    -- set recursion flag
    select coalesce(crg_with_recursion, adc_util.C_TRUE)
      into g_recursion.allow_recursion
      from adc_rule_groups
     where crg_id = p_crg_id;
     
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Allow recursion', g_recursion.allow_recursion)));
  end reset;
  
  
  /**
    Procedure: push_firing_item
      See <ADC_RECURSION_STACK.push_firing_item>
   */
  procedure push_firing_item(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_event in adc_page_item_types.cpit_cet_id%type,
    p_event_data in adc_util.max_char default null,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE,
    p_force in adc_util.flag_type default adc_util.C_FALSE,
    p_recursive_depth in binary_integer default null)
  as
    l_must_be_processed binary_integer := 0;
    l_stack_entry recursive_entry_t;
  begin
    pit.enter_optional('push_firing_item',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_event', p_event),
                    msg_param('p_event_data', p_event_data),
                    msg_param('p_allow_recursion', p_allow_recursion)));
    
    pit.assert_not_null(p_crg_id, p_msg_args => msg_args('P_CRG_ID'));
    pit.assert_not_null(p_cpi_id, p_msg_args => msg_args('P_CPI_ID'));
    
    -- check recursion level does not exceeded max level
    pit.assert(coalesce(p_recursive_depth, 0) <= g_recursion.recursion_limit + 20, msg.ADC_RECURSION_LIMIT, msg_args(p_cpi_id, to_char(g_recursion.recursion_limit)));
    
    if g_recursion.allow_recursion = adc_util.C_TRUE and p_allow_recursion = adc_util.C_TRUE then
    
      -- Item has not been pushed already
      if not p_cpi_id member of g_recursion.firing_items then
        case 
          when p_cpi_id = C_COMMAND then
            l_must_be_processed := 1;
          when p_cpi_id != adc_util.C_NO_FIRING_ITEM then
          -- If page item to be registered is referenced in rules, register recursive call for this page item
          select count(*)
            into l_must_be_processed
            from dual
           where exists(
                 select null
                   from adc_rules
                   join adc_page_items
                     on instr(',' || cru_firing_items || ',', ',' || cpi_id || ',') > 0
                  where cpi_id = p_cpi_id
                    and (instr(cpi_cpit_id, 'ITEM') > 0)
                    and cru_crg_id = p_crg_id);
        else
          l_must_be_processed := 0;
        end case;
        
        if (l_must_be_processed > 0 or p_force = adc_util.C_TRUE) and p_cpi_id != adc_util.C_NO_FIRING_ITEM then
          -- First, push item uniquely on g_recursion.firing_items to retrieve all firing items later
          register_touched_item(p_cpi_id);
          -- then add item to the recursive stack. After succesful completion the firing item will be popped from that stack
          l_stack_entry.cpi_id := p_cpi_id;
          l_stack_entry.recursive_level := p_recursive_depth;
          l_stack_entry.event := p_event;
          l_stack_entry.event_data := p_event_data;
          g_recursion.item_stack(p_cpi_id) := l_stack_entry;
          pit.debug(msg.ADC_FIRING_ITEM_PUSHED, msg_args(p_cpi_id, to_char(p_recursive_depth))); 
        end if;
      end if;
    end if;
    
    pit.leave_optional;
  end push_firing_item;
  
  
  /**
    Procedure : register_touched_item
      See <ADC_RECURSION_STACK.register_touched_item>
   */
  procedure register_touched_item(
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_optional('register_touched_item',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id)));
                    
    if p_cpi_id not member of g_recursion.firing_items then
      g_recursion.firing_items.extend;
      g_recursion.firing_items(g_recursion.firing_items.last) := p_cpi_id;
    end if;
    
    pit.leave_optional;
  end register_touched_item;
  
    
  /**
    Procedure: pop_firing_item
      See <ADC_RECURSION_STACK.pop_firing_item>
   */
  procedure pop_firing_item(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_all in adc_util.flag_type default adc_util.C_FALSE)
  as
  begin
    pit.enter_optional('pop_firing_item',
      p_params => msg_params(
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_all', p_all)));
    
    if p_all = adc_util.C_TRUE then
      g_recursion.item_stack.delete;
    else
      pit.debug(msg.ADC_FIRING_ITEM_POPPED, msg_args(p_cpi_id));
      g_recursion.item_stack.delete(p_cpi_id);
      --g_recursion.item_stack.delete(g_recursion.item_stack.first);
    end if;
    
    pit.leave_optional;
  end pop_firing_item;
  
  
  /**
    Function: check_recursion
      See <adc_recursion_stack.check_recursion>
   */
  function check_recursion(
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type)
    return adc_util.flag_type
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_detailed('check_recursion',
      p_params => msg_params(
                    msg_param('p_cra_cpi_id', p_cra_cpi_id),
                    msg_param('p_cru_fire_on_page_load', p_cru_fire_on_page_load)));
    
    case when p_cra_cpi_id = adc_util.C_NO_FIRING_ITEM and p_cru_fire_on_page_load = adc_util.C_TRUE
      then l_result := adc_util.C_FALSE;
      when p_cra_raise_recursive = adc_util.C_FALSE then
        l_result := p_cra_raise_recursive;
      else l_result := adc_util.C_TRUE;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Result', l_result)));
    return l_result;
  end check_recursion;
  
  
  /**
    Function: get_next
      See <ADC_RECURSION_STACK.get_next>
   */
  procedure get_next(
    p_cpi_id out nocopy adc_page_items.cpi_id%type,
    p_event out nocopy adc_page_item_types.cpit_cet_id%type,
    p_event_data out nocopy varchar2)
  as
    l_stack_entry recursive_entry_t;
  begin
    pit.enter_optional('get_next');
    
    if stack_is_not_empty then
      l_stack_entry := get_first_item;
      p_cpi_id := l_stack_entry.cpi_id;
      p_event := l_stack_entry.event;
      p_event_data := l_stack_entry.event_data;
    end if;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Firing Item', l_stack_entry.cpi_id),
                    msg_param('Firing Event', l_stack_entry.event),
                    msg_param('Event Data', l_stack_entry.event_data)));
  end get_next;
    
  
  /**
    Function: get_level
      See <ADC_RECURSION_STACK.get_level>
   */
  function get_level
    return binary_integer
  as
    l_stack_entry recursive_entry_t;
  begin
    pit.enter_optional('get_level');
    
    l_stack_entry := get_first_item;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Level', l_stack_entry.recursive_level)));
    return l_stack_entry.recursive_level;
  exception
    when others then
      pit.leave_optional(
        p_params => msg_params(
                      msg_param('Level', 0)));
      return 0;
  end get_level;
  
  
  /**
    Function: get_firing_items_as_json
      See <ADC_RECURSION_STACK.get_firing_items_as_json>
   */
  function get_firing_items_as_json
    return varchar2
  as
    l_firing_items adc_util.max_char;
  begin
    pit.enter_optional;
  
    if g_recursion.firing_items.count > 0 then
      l_firing_items := '["' || utl_text.table_to_string(g_recursion.firing_items, '","') || '"]';
    else
      l_firing_items := '[]';
    end if;
    
    pit.leave_optional(msg_params(msg_param('JSON', l_firing_items)));
    return l_firing_items;
  end get_firing_items_as_json;
    
    
  /**
    Procedure: raise_recursion_level
      See <ADC_RECURSION_STACK.raise_recursion_level>
   */
  procedure raise_recursion_level
  as
  begin
    pit.enter_optional;
    
    g_recursion_level := g_recursion_level + 1;
    
    pit.leave_optional(
      p_params => msg_params(msg_param('Level', g_recursion_level)));
  end raise_recursion_level;

begin
  initialize;
end adc_recursion_stack;
/