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
  C_INIT_TEMPLATE constant template_t := q'^var action = apex.actions.lookup('#NAME#');^';

  C_UPDATE_TEMPLATE constant template_t := q'^apex.actions.update('#NAME#');^';
  C_EXECUTE_IMMEDIATE constant template_t := q'^apex.actions.invoke('#NAME#');^';

  C_HREF_TEMPLATE constant template_t := q'^action.href="#JS##HREF#"; action.action='';^';
  C_ACTION_TEMPLATE constant template_t := q'^action.action = function(){#ACTION#}; action.href='';^';
  C_LABEL_TEMPLATE constant template_t := q'^action.label = #LABEL#;^';
  C_LABEL_KEY_TEMPLATE constant template_t := q'^action.labelKey = #LABEL_KEY#;^';
  C_TITLE_TEMPLATE constant template_t := q'^action.title = #TITLE#;^';
  C_TITLE_KEY_TEMPLATE constant template_t := q'^action.titleKey = #TITLE_KEY#;^';
  C_DISABLE_TEMPLATE constant template_t := q'^action.disabled = true;^';
  C_ENABLE_TEMPLATE constant template_t := q'^action.disabled = false;^';
  C_SHOW_TEMPLATE constant template_t := q'^action.hide = false;^';
  C_HIDE_TEMPLATE constant template_t := q'^action.hide = true;^';

  C_JAVA_SCRIPT_TAG constant adc_util.ora_name_type := 'javascript:';

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
    C_CR constant varchar2(10) := chr(10);
  begin
    pit.enter_detailed('append');
    if p_text is not null then
      if p_for_action then
        g_action.javascript_stack := g_action.javascript_stack || C_CR
                                    || replace(p_text, '#NAME#', g_action.action_name);
      else
        g_action.additional_javascript := g_action.additional_javascript || C_CR || p_text;
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
      adc.register_error(
        p_cpi_id => null,
        p_error_msg => 'APEX action ' || p_action_name || ' does not exist');
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

    -- Aktualisieurng der UI-Elemente der Aktion anfordern, falls erforderlich
    if g_action.needs_update then
      append(C_UPDATE_TEMPLATE);
    end if;

    -- Falls Ausfuehren angefordert und nicht INLINE, dann hier Befehl zum Ausfuehren ergaenzen
    if g_action.execute_immediate then
      append(C_EXECUTE_IMMEDIATE);
    end if;

    -- Eventuelle zusaetzliche Skripte anschliessen
    append(g_action.additional_javascript);

    l_script := g_action.javascript_stack;
    g_action := null;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Script', l_script)));
    return l_script;
  end get_action_script;


  /**
    Procedure: set_href
      See <ADC_APEX_ACTIONS.set_href>
   */
  procedure set_href(
    p_href in adc_apex_actions_v.caa_href%type)
  is
    l_js_flag varchar2(30);
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_href', p_href)));

    if not regexp_like(p_href, '^http|^f?p') then
      l_js_flag := 'Javascript:';
    end if;
    append(replace(replace(C_HREF_TEMPLATE, '#HREF#', p_href), '#JS#', l_js_flag));

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

      append(replace(replace(C_ACTION_TEMPLATE, '#ACTION#', p_action), C_JAVA_SCRIPT_TAG));

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