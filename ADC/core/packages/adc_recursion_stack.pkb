create or replace package body adc_recursion_stack 
as

  type recursive_stack_t is table of pls_integer index by adc_util.ora_name_type;
  
  type recursion_rec is record(
    item_stack recursive_stack_t,          -- List of items which were marked to recursively check rules for
    firing_items char_table,               -- List of all "touched" page items. Used to monitor double recursion and
                                           -- to provide a list of all items for which existing error messages have to be removed
    is_recursive adc_util.flag_type,       -- Flag to indicate whether we're in a recursive rule run
    allow_recursion adc_util.flag_type,    -- Flag to indicate whether recursive calls are allowed for the active rule,
    recursion_limit pls_integer,           -- Parameter to control max recursion depth
    loop_is_error boolean                  -- Parameter to control whether a loop in recursion has to be treated as an error
  );
  
  C_PARAM_GROUP constant adc_util.ora_name_type := 'ADC';
  
  g_recursion recursion_rec;
  
  /** Method checks whether recursion stack contains entries
   */
  function stack_is_not_empty
    return boolean
  as
  begin
    return g_recursion.item_stack.count > 0;
  end stack_is_not_empty;
  
  
  /** Method retrieves the first item on the stack
   */
  function get_first_item
    return adc_page_items.cpi_id%type
  as
  begin
    return g_recursion.item_stack.first;
  end get_first_item;
  
  
  /** Initialization */
  procedure initialize
  as
  begin
    g_recursion.loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion.recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
    g_recursion.firing_items := char_table();
  end initialize;

  
  /* INTERFACE */
  procedure reset(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
  as
  begin
    pit.enter_optional('reset',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id)));
    
    pop_firing_item(null, adc_util.C_TRUE);
    g_recursion.firing_items.delete;
        
    -- set recursion flag
    select coalesce(cgr_with_recursion, adc_util.C_TRUE)
      into g_recursion.allow_recursion
      from adc_rule_groups
     where cgr_id = p_cgr_id;
    
    -- Register firing item on recursion level 1 to start evaluation
    push_firing_item(p_cgr_id, p_cpi_id);
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Allow recursion', g_recursion.allow_recursion)));
  end reset;
  
  
  procedure push_firing_item(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    l_cpi_has_rule pls_integer;
  begin
    pit.enter_optional('push_firing_item',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_allow_recursion', p_allow_recursion)));
    
    -- check recursion level does not exceeded max level
    if stack_is_not_empty then
      pit.assert(get_level <= g_recursion.recursion_limit, msg.ADC_RECURSION_LIMIT, msg_args(p_cpi_id, to_char(g_recursion.recursion_limit)));
    end if;
    
    if g_recursion.allow_recursion = adc_util.C_TRUE and p_allow_recursion = adc_util.C_TRUE then
    
      -- Item has not been pushed already
      if p_cpi_id is not null and not p_cpi_id member of g_recursion.firing_items then
  
        -- If page item to be registered is referenced in rules, register recursive call for this page item
        select count(*)
          into l_cpi_has_rule
          from dual
         where exists(
               select null
                 from adc_page_items
                where cpi_id = p_cpi_id
                  and cpi_cgr_id = p_cgr_id
                  and cpi_is_required = adc_util.C_TRUE);
                  
        if l_cpi_has_rule > 0 then
          -- First, push item uniquely on g_recursion.firing_items to retrieve all firing items later
          g_recursion.firing_items.extend;
          g_recursion.firing_items(g_recursion.firing_items.last) := p_cpi_id;
          -- then add item to the recursive stack. After succesful completion the firing item will be popped from that stack
          g_recursion.item_stack(p_cpi_id) := case g_recursion.item_stack.count when 0 then 1 else get_level + 1 end;
          pit.info(msg.ADC_FIRING_ITEM_PUSHED, msg_args(p_cpi_id, to_char(g_recursion.item_stack(p_cpi_id))));
        end if;
      end if;
    end if;
    
    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional;
  end push_firing_item;
  
  
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
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || p_cpi_id || ' popped from stack'));
      g_recursion.item_stack.delete(p_cpi_id);
    end if;
    
    pit.leave_optional;
  end pop_firing_item;
  
  
  function get_next
    return adc_page_items.cpi_id%type
  as
    l_cpi_id adc_page_items.cpi_id%type;
  begin
    pit.enter_optional('get_next');
    
    if stack_is_not_empty then
      l_cpi_id := get_first_item;
    end if;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Firing Item', l_cpi_id)));
    return l_cpi_id;
  end get_next;
    
  
  function get_level
    return pls_integer
  as
    l_level pls_integer := 0;
  begin
    pit.enter_optional('get_level');
    
    if stack_is_not_empty then
      l_level := g_recursion.item_stack(get_first_item);
    end if;
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Level', l_level)));
    return l_level;
  end get_level;
  
  
  function get_firing_items_as_json
    return varchar2
  as
    l_firing_items adc_util.max_char;
  begin
    pit.enter_optional;
  
    l_firing_items := '["' || utl_text.table_to_string(g_recursion.firing_items, '","') || '"]';
    
    pit.leave_optional;
    return l_firing_items;
  end get_firing_items_as_json;

begin
  initialize;
end adc_recursion_stack;
/