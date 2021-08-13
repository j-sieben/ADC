create or replace package body adc_recursion_stack 
as

  type recursive_stack_t is table of pls_integer index by adc_util.ora_name_type;
  
  type recursion_rec is record(
    item_stack recursive_stack_t,          -- List of items which were marked to recursively check rules for
    is_recursive adc_util.flag_type,       -- Flag to indicate whether we're in a recursive rule run
    allow_recursion boolean,               -- Flag to indicate whether recursive calls are allowed for the active rule,
    limit pls_integer,                     -- Parameter to control max recursion depth
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
    g_recursion.limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
  end initialize;

  
  /* INTERFACE */
  procedure reset(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type)
  as
    l_allow_recursion adc_rule_groups.cgr_with_recursion%type;
  begin
    pit.enter_optional('reset',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id)));
    
    pop(adc_util.C_TRUE);
        
    -- set recursion flag
    select coalesce(cgr_with_recursion, adc_util.C_TRUE)
      into l_allow_recursion
      from adc_rule_groups
     where cgr_id = p_cgr_id;
    g_recursion.allow_recursion := l_allow_recursion = adc_util.C_TRUE;
    
    -- Register firing item on recursion level 1 to start evaluation
    push(p_cgr_id, p_cpi_id);
    
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Allow recursion', l_allow_recursion)));
  end reset;
  
  
  procedure push(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_cpi_id in adc_page_items.cpi_id%type,
    p_allow_recursion in adc_util.flag_type default adc_util.C_TRUE)
  as
    l_cpi_has_rule pls_integer;
    l_cpi_id adc_page_items.cpi_id%type;
  begin
    pit.enter_optional('push',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cpi_id', p_cpi_id),
                    msg_param('p_allow_recursion', p_allow_recursion)));
    
    -- check recursion level does not exceeded max level
    if stack_is_not_empty then
      pit.assert(get_level <= g_recursion.limit, msg.ADC_RECURSION_LIMIT, msg_args(p_cpi_id, to_char(g_recursion.limit)));
    end if;
    
    if g_recursion.allow_recursion and p_allow_recursion = adc_util.C_TRUE then
      case
        when p_cpi_id = adc_util.C_NO_FIRING_ITEM then
          -- Initialization, register C_NO_FIRING_ITEM on level 1
          g_recursion.item_stack(p_cpi_id) := 1;
          pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || p_cpi_id  || ' pushed onto the recursion stack'));
        when not g_recursion.item_stack.exists(p_cpi_id) then
          -- If page item to be registered is referenced in rules, register recursive call for this page item
          l_cpi_id := coalesce(get_first_item, adc_util.C_NO_FIRING_ITEM);
          select count(*)
            into l_cpi_has_rule
            from dual
           where exists(
                 select null
                   from adc_page_items
                  where cpi_id = p_cpi_id
                    and cpi_cgr_id = p_cgr_id
                    and cpi_is_required = adc_util.C_TRUE
                        -- don't register if the firing item changes itself
                    and p_cpi_id != l_cpi_id);
          if l_cpi_has_rule > 0 then
            g_recursion.item_stack(p_cpi_id) := g_recursion.item_stack(l_cpi_id) + 1;
            pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Item ' || p_cpi_id  || ' pushed onto the recursion stack'));
          end if;
        else
          null;
      end case;
    end if;
    
    pit.leave_optional;
  end push;
  
  
  procedure pop(
    p_all in adc_util.flag_type default adc_util.C_FALSE)
  as
  begin
    pit.enter_optional('pop',
      p_params => msg_params(
                    msg_param('p_all', p_all)));
    
    if p_all = adc_util.C_TRUE then
      g_recursion.item_stack.delete;
    else
      g_recursion.item_stack.delete(get_first_item);
    end if;
    
    pit.leave_optional;
  end pop;
  
  
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
    l_level pls_integer;
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

begin
  initialize;
end adc_recursion_stack;
/