create or replace package body adc_apex_action
as
  /**
    Package: ADC_APEX_ACTIONS Body
      Implementation of the helper package to maintain APEX Actions

    Author::
      Juergen Sieben, ConDeS GmbH
   */


  /**
    Group: Type definitions
   */
  
  /**
    Type: action_rec
      Record to store controlling properties to put toghether a working JavaScript
      
    Properties:
      action_name - Name of the APEX Action
      needs_update - Flag to indicate whether a call to apex.actions.update is required
      execute_immediate - Flag to indicate wheter a call to apex.actions.invoke is required
      javascript_stack - Stack of JavaScrip snippets to form the resulting JavaScript code
      additional_javascript - JavaScript function to integrate into the JavaScript answer.
   */      
  type action_rec is record(
    action_name adc_apex_actions_v.caa_name%type,
    needs_update boolean,
    execute_immediate boolean,
    javascript_stack utl_apex.max_char,
    additional_javascript utl_apex.max_char
  );
  g_action action_rec;

  subtype template_t is utl_apex.max_sql_char;


  /**
    Group: Private Constants
   */
  /**
    Constants:
      C_INIT_TEMPLATE - Template to lookup the APEX Action
      C_UPDATE_TEMPLATE - Template to update an APEX Action
      C_EXECUTE_IMMEDIATE - Template to invoke an APEX Action
      C_HREF_TEMPLATE - Template to set the href attribute of an APEX Action
      C_ACTION_TEMPLATE - Template to set the action attribute of an APEX Action
      C_LABEL_TEMPLATE - Template to set the label of an APEX Action
      C_LABEL_KEY_TEMPLATE - Template to set the shortcut of an APEX Action
      C_TITLE_TEMPLATE - Template to set the title attribute of an APEX Action
      C_TITLE_KEY_TEMPLATE - Template to set the title key attribute of an APEX Action
      C_DISABLE_TEMPLATE - Template to dsiable an APEX Action
      C_ENABLE_TEMPLATE - Template to enable an APEX Action
      C_SHOW_TEMPLATE - Template to show an APEX Action
      C_HIDE_TEMPLATE - Template to hide an APEX Action
      C_JAVA_SCRIPT_TAG - javascript prefix
   */
  C_INIT_TEMPLATE constant template_t := q'^action = apex.actions.lookup('#NAME#');^';

  C_UPDATE_TEMPLATE constant template_t := q'^    apex.actions.update('#NAME#');^';
  C_EXECUTE_IMMEDIATE constant template_t := q'^    apex.actions.invoke('#NAME#');^';

  C_HREF_TEMPLATE constant template_t := q'^    action.href="#JS##HREF#"; action.action='';^';
  C_ACTION_TEMPLATE constant template_t := q'^    action.action = function(){#ACTION#}; action.href='';^';
  C_LABEL_TEMPLATE constant template_t := q'^    action.label = #LABEL#;^';
  C_LABEL_KEY_TEMPLATE constant template_t := q'^    action.labelKey = #LABEL_KEY#;^';
  C_TITLE_TEMPLATE constant template_t := q'^    action.title = #TITLE#;^';
  C_TITLE_KEY_TEMPLATE constant template_t := q'^    action.titleKey = #TITLE_KEY#;^';
  C_DISABLE_TEMPLATE constant template_t := q'^    action.disabled = true;^';
  C_ENABLE_TEMPLATE constant template_t := q'^    action.disabled = false;^';
  C_SHOW_TEMPLATE constant template_t := q'^    action.hide = false;^';
  C_HIDE_TEMPLATE constant template_t := q'^    action.hide = true;^';

  C_JAVA_SCRIPT_TAG constant adc_util.ora_name_type := 'javascript:';
  -- The following constants are used to prevent ADC_RESPONSE from escaping these namespace objects
  -- with local IIFE parameters which would make them unusable.
  C_JS_NAMESPACE constant adc_util.ora_name_type := 'de.condes.plugin.adc.actions';
  C_JS_PLACEHOLDER constant adc_util.ora_name_type := 'ADC_PLUGIN';
  C_APEX_ACTION_NAMESPACE constant adc_util.ora_name_type := 'apex.actions';
  C_APEX_ACTION_PLACEHOLDER constant adc_util.ora_name_type := 'APEX_ACTION';

  /**
    Group: Private Methods
   */
  /**
    Procedure: append
      Helper method to append a chunk to the JavaScript stack. Replaces #ACTION# with action name.
      
      Is used to collect a JacaScript instance performing the requested operations client side.
      Normal usage is to collect JavaScript to the G_ACTION.JAVASCRIPT_STACK. If you need additional
      JavaScript code, add it to G_ACTION.ADDITIONAL_JAVASCRIPT to make sure this code gets executed
      after G_ACTION.JAVASCRIPT_STACK.
      
    Parameters:
      p_text - Text to append to the JavaScript stack
      p_for_action - Optional flag to indicate where to append P_TEXT to
                     - TRUE (Default): P_TEXT is appended to G_ACTION.JAVASCRIPT_STACK
                     - FALSE: P_TEXT is appended to G_ACTION.ADDITIONAL_JAVASCRIPT
   */
  procedure append(
    p_text in varchar2,
    p_for_action in boolean default TRUE)
  as
  begin
    pit.enter_detailed('append');
    if p_text is not null then
      if p_for_action then
        g_action.javascript_stack := g_action.javascript_stack || adc_util.C_CR
                                    || replace(p_text, '#NAME#', g_action.action_name);
      else
        g_action.additional_javascript := g_action.additional_javascript || adc_util.C_CR || p_text;
      end if;
    end if;
    pit.leave_detailed;
  end append;


  /**
    Group: Public Methods
   */
  /**
    Procedure: action_init
      See <ADC_APEX_ACTIONS.action_init>
   */
  procedure action_init(
    p_action_name in adc_apex_actions_v.caa_name%type)
  is
    l_action_exists binary_integer;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_action_name', p_action_name)));

    select 1
      into l_action_exists
      from adc_apex_actions
     where caa_name = p_action_name
       and rownum = 1;

    g_action := null;
    g_action.action_name := p_action_name;
    g_action.needs_update := FALSE;
    g_action.execute_immediate := FALSE;
    append(C_INIT_TEMPLATE);

    pit.leave_optional;
  exception
    when no_data_found then
      adc_api.register_error(
        p_cpi_id => null,
        p_error_msg => 'APEX action ' || p_action_name || ' does not exist',
        p_internal_error => null);
  end action_init;


  /**
    Procedure: get_action_script
      See <ADC_APEX_ACTIONS.get_action_script>
   */
  function get_action_script
    return varchar2
  is
    l_script utl_apex.max_char;
  begin
    pit.enter_optional;

    -- Request update of the UI elements of the action, if necessary.
    if g_action.needs_update then
      append(C_UPDATE_TEMPLATE);
    end if;

    -- If execute is requested and not INLINE, then add command to execute here
    if g_action.execute_immediate then
      append(C_EXECUTE_IMMEDIATE);
    end if;

    -- Add possible additional scripts
    append(g_action.additional_javascript);

    l_script := g_action.javascript_stack;
    g_action := null;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Script', l_script)));
    return l_script;
  end get_action_script;
  

  /**
    Procedure: register_action_script
      See <ADC_APEX_ACTIONS.register_action_script>
   */
  procedure register_action_script
  is
  begin
    adc_api.add_javascript(get_action_script);
  end register_action_script;
  
  
  /**  
    Procedure: append_apex_actions
      See <ADC_APEX_ACTIONS.get_crg_apex_actions>
   */
  function get_crg_apex_actions(
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    l_actions_js adc_util.max_char;
    l_default_action adc_util.max_char;
    l_confirm_action adc_util.max_char;
    l_cur sys_refcursor;
  begin
    pit.enter_optional('get_crg_apex_actions');
    
    -- check whether APEX actions exist
    open l_cur for
      select null
        from adc_apex_actions
       where caa_crg_id = p_crg_id;
    pit.assert_exists(l_cur);
                
    l_default_action := utl_text.get_text_template(adc_util.C_PARAM_GROUP, 'DEFAULT_APEX_ACTION', 'FRAME');
    l_confirm_action := utl_text.get_text_template(adc_util.C_PARAM_GROUP, 'CONFIRM_APEX_ACTION', 'FRAME');
    utl_text.set_secondary_anchor_char(null);
    
    -- Generate initalization JavaScript for APEX actions based on UTL_TEXT templates of name APEX_ACTION
    with templates as (
           select uttm_name, uttm_mode, uttm_text, p_crg_id crg_id
             from utl_text_templates_v
            where uttm_type = adc_util.C_PARAM_GROUP
              and uttm_name = 'APEX_ACTION')
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    adc_util.C_CR cr,
                    pit.get_message_text(msg.ADC_APEX_ACTION_ORIGIN) apex_action_origin,
                    utl_text.generate_text(cursor(
                      select uttm_text template,
                             cpi_id, caa_name
                        from adc_apex_action_items
                        join adc_apex_actions
                          on caai_caa_id = caa_id
                        join adc_page_items
                          on caai_cpi_crg_id = cpi_crg_id
                         and caai_cpi_id = cpi_id
                        join adc_page_item_types
                          on cpi_cpit_id = cpit_id
                        join templates
                          on cpit_id = uttm_mode
                         and caai_cpi_crg_id = crg_id),
                      p_delimiter => adc_util.C_CR
                    ) bind_action_items,
                    utl_text.generate_text(cursor(
                      select uttm_text template, adc_util.C_CR || '    ' cr,
                             caa_crg_id, caa_caat_id, caa_name, caa_icon, caa_icon_type, caa_shortcut, caa_href,
                             apex_escape.json(caa_label) caa_label,
                             apex_escape.json(caa_label) caa_label_key, 
                             apex_escape.json(caa_context_label) caa_context_label, 
                             apex_escape.json(coalesce(caa_title, caa_label)) caa_title,
                             apex_escape.json(coalesce(caa_title, caa_label)) caa_title_key,
                             case caa_initially_disabled when adc_util.c_true then 'true' else 'false' end caa_initially_disabled,
                             case caa_initially_hidden when adc_util.c_true then 'true' else 'false' end caa_initially_hidden,
                             case when caa_confirm_message_name is not null 
                                  then apex_escape.json(pit.get_message_text(replace(caa_confirm_message_name, 'msg.'))) 
                             end confirm_message,
                             -- Default is to inform ADC about invoking an APEX action on the page
                             case 
                               when caa_action is not null then caa_action
                               when caa_confirm_message_name is not null then l_confirm_action
                               else l_default_action
                             end caa_action
                        from adc_apex_actions_v saa
                        join adc_rule_groups cgr
                          on saa.caa_crg_id = cgr.crg_id
                        join templates t
                          on t.crg_id = cgr.crg_id
                         and uttm_mode = caa_caat_id),
                      p_delimiter => adc_util.C_DELIMITER || adc_util.C_CR || '   ',
                      p_enable_second_level => adc_util.C_TRUE
                    ) action_list
               from templates
              where uttm_mode = 'FRAME')
           ) resultat
      into l_actions_js
      from dual;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('APEX_ACTIONS', l_actions_js)));
    return l_actions_js;
  exception
    when msg.PIT_ASSERT_EXISTS_ERR then
      pit.leave_optional;
      return null;
  end get_crg_apex_actions;


  /**
    Procedure: set_href
      See <ADC_APEX_ACTIONS.set_href>
   */
  procedure set_href(
    p_href in adc_apex_actions_v.caa_href%type)
  is
    l_js_flag varchar2(30);
    l_href adc_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_href', p_href)));

    if not regexp_like(p_href, '^http|^f?p') then
      l_js_flag := 'Javascript:';
    end if;
    append(adc_util.bulk_replace(C_HREF_TEMPLATE, adc_util.string_table(
             '#HREF#', p_href, 
             '#JS#', l_js_flag,
             C_JS_NAMESPACE, C_JS_PLACEHOLDER,
             C_APEX_ACTION_NAMESPACE, C_APEX_ACTION_PLACEHOLDER)));

    pit.leave_optional;
  end set_href;


  /**
    Procedure: set_action
      See <ADC_APEX_ACTIONS.set_action>
   */
  procedure set_action(
    p_action in adc_apex_actions_v.caa_action%type)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_action', p_action)));

    append(adc_util.bulk_replace(C_ACTION_TEMPLATE, adc_util.string_table(
             '#ACTION#', p_action, 
             C_JAVA_SCRIPT_TAG, null,
             C_JS_NAMESPACE, C_JS_PLACEHOLDER,
             C_APEX_ACTION_NAMESPACE, C_APEX_ACTION_PLACEHOLDER)));

    pit.leave_optional;
  end set_action;


  /**
    Procedure: execute_immediate
      See <ADC_APEX_ACTIONS.execute_immediate>
   */
  procedure execute_immediate(
    p_inline in boolean default FALSE)
  is
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_inline', utl_apex.get_bool(p_inline))));

    if p_inline then
      append(C_EXECUTE_IMMEDIATE);
    else
      g_action.execute_immediate := TRUE;
    end if;

    pit.leave_optional;
  end execute_immediate;


  /**
    Procedure: set_label
      See <ADC_APEX_ACTIONS.set_label>
   */
  procedure set_label(
    p_label in adc_apex_actions_v.caa_label%type,
    p_is_key in boolean default false)
  is
    l_template utl_apex.ora_name_type;
    l_anchor utl_apex.ora_name_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_label', p_label),
                    msg_param('p_is_key', utl_apex.get_bool(p_is_key))));
                    
    if p_is_key then
      l_template := C_LABEL_KEY_TEMPLATE;
      l_anchor := '#LABEL_KEY#';
    else
      l_template := C_LABEL_TEMPLATE;
      l_anchor := '#LABEL#';
    end if;

    append(replace(l_template, l_anchor, apex_escape.js_literal(p_label)));
    g_action.needs_update := TRUE;

    pit.leave_optional;
  end set_label;


  /**
    Procedure: set_title
      See <ADC_APEX_ACTIONS.set_title>
   */
  procedure set_title(
    p_title in adc_apex_actions_v.caa_title%type,
    p_is_key in boolean default false)
  is
    l_template utl_apex.ora_name_type;
    l_anchor utl_apex.ora_name_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_title', p_title),
                    msg_param('p_is_key', utl_apex.get_bool(p_is_key))));

    if p_is_key then
      l_template := C_TITLE_KEY_TEMPLATE;
      l_anchor := '#TITLE_KEY#';
    else
      l_template := C_TITLE_TEMPLATE;
      l_anchor := '#TITLE#';
    end if;

    append(replace(l_template, l_anchor, apex_escape.js_literal(p_title)));
    g_action.needs_update := TRUE;

    pit.leave_optional;
  end set_title;


  /**
    Procedure: set_disabled
      See <ADC_APEX_ACTIONS.set_disabled>
   */
  procedure set_disabled(
    p_disabled in boolean)
  is
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_disabled', utl_apex.get_bool(p_disabled))));

    if p_disabled then
      append(C_DISABLE_TEMPLATE);
    else
      append(C_ENABLE_TEMPLATE);
    end if;
    g_action.needs_update := TRUE;

    pit.leave_optional;
  end set_disabled;


  /**
    Procedure: set_visible
      See <ADC_APEX_ACTIONS.set_visible>
   */
  procedure set_visible(
    p_visible in boolean)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_visible', utl_apex.get_bool(p_visible))));

    if p_visible then
      append(C_SHOW_TEMPLATE);
    else
      append(C_HIDE_TEMPLATE);
    end if;
    g_action.needs_update := TRUE;

    pit.leave_optional;
  end set_visible;


  /**
    Procedure: add_script
      See <ADC_APEX_ACTIONS.add_script>
   */
  procedure add_script(
    p_script in varchar2)
  is
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_script', p_script)));

    append(p_script, FALSE);

    pit.leave_optional;
  end add_script;
  
end adc_apex_action;
/