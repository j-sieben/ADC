create or replace package body adc_ui_designer
as

  /**
    Package: ADC_UI_DESIGNER  Body
      Implementation of the GUI logic of the ADC APEX applications ADC Designer

    Author::
      Juergen Sieben, ConDeS GmbH
  */


  /**
    Group: Private package constants
   */
  C_PTI_PMG constant adc_util.ora_name_type := 'ADC_UI';
  
  /**
    Constants: Mode and Action constants
      C_MODE_CGR - Hierarchical level Rule Group
      C_MODE_CRU - Hierarchical level Rule
      C_MODE_CRA - Hierarchical level Rule Action
      C_MODE_CAG - Hierarchical level APEX Action Group (used as a hierarchy level only to group APEX Actions)
      C_MODE_CAA - Hierarchical level APEX Action
      C_ACTION_CANCEL - APEX Action to cancel an operation
      C_ACTION_CREATE - APEX Action to create a record
      C_ACTION_DELETE - APEX Action to delete a record
      C_ACTION_UPDATE - APEX Action to update a record
      C_EXPORT_CGR - APEX Action to export a rule group
  */
  C_MODE_CGR constant adc_util.ora_name_type := 'CGR';
  C_MODE_CRU constant adc_util.ora_name_type := 'CRU';
  C_MODE_CRA constant adc_util.ora_name_type := 'CRA';
  C_MODE_CAG constant adc_util.ora_name_type := 'CAG';
  C_MODE_CAA constant adc_util.ora_name_type := 'CAA';
  C_ACTION_SHOW constant adc_util.ora_name_type := 'show';
  C_ACTION_CANCEL constant adc_util.ora_name_type := 'cancel-action';
  C_ACTION_CREATE constant adc_util.ora_name_type := 'create-action';
  C_ACTION_DELETE constant adc_util.ora_name_type := 'delete-action';
  C_ACTION_UPDATE constant adc_util.ora_name_type := 'update-action';
  C_EXPORT_CGR constant adc_util.ora_name_type := 'export-rule-group';
  
  /**
    Constants: Item and Region constants
      C_ITEM_CGR_APP_ID - Item that contains the Application ID
      C_ITEM_CGR_ID - Item that contains the Rule Group ID
      C_ITEM_CRU_ID - Item that contains the Rule ID
      C_ITEM_CRA_ID - Item that contains the Rule Action ID
      C_ITEM_CAA_ID - Item that contains the APEX Action ID
      C_ITEM_CRA_CAT_ID - Item that contains the Action Type
      C_REGION_RULES - Static ID of the Rule report region
      C_REGION_HIERARCHY - Static ID of the Hierarchy Tree region
      C_REGION_HELP - Static ID of the Help region
      C_REGION_CGR_FORM - Static ID of the Rule Group form region
      C_REGION_CRU_FORM - Static ID of the Rule form region
      C_REGION_CRA_FORM - Static ID of the Rule Action form region
      C_REGION_CAA_FORM - Static ID of the APEX Action form region
  */
  C_PAGE_PREFIX constant adc_util.ora_name_type := utl_apex.get_page_prefix;
  C_REGION_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'R');
  C_BUTTON_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'B');
  C_EXPORT_PAGE constant adc_util.ora_name_type := 'EXPORT_CGR';
  C_EXPORT_PAGE_PREFIX adc_util.ora_name_type; -- not constant as this is calculated upon initialization
  
  C_ITEM_CGR_APP_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CGR_APP_ID';  
  C_ITEM_CGR_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CGR_ID';
  C_ITEM_CRU_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRU_ID';
  C_ITEM_CRA_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_ID';
  C_ITEM_CAA_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_ID';
  C_ITEM_CRA_CAT_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CAT_ID';
  C_ITEM_CRU_CGR_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRU_CGR_ID';
  C_ITEM_CRA_CGR_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CGR_ID';
  C_ITEM_CAA_CGR_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_CGR_ID';
  C_ITEM_SELECTED_NODE constant adc_util.ora_name_type := C_PAGE_PREFIX || 'SELECTED_NODE';
  
  C_REGION_RULES constant adc_util.ora_name_type := C_REGION_PREFIX || 'RULES';
  C_REGION_HIERARCHY constant adc_util.ora_name_type := C_REGION_PREFIX || 'HIERARCHY';
  C_REGION_FINDINGS constant adc_util.ora_name_type := C_REGION_PREFIX || 'FINDINGS';
  C_REGION_HELP constant adc_util.ora_name_type := C_REGION_PREFIX || 'HELP';
  
  C_REGION_CGR_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CGR_FORM';
  C_REGION_CRU_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CRU_FORM';
  C_REGION_CRA_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CRA_FORM';
  C_REGION_CAA_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CAA_FORM';
  
  
  /**
    Group: Type definitions
   */
  /**
    Type: environment_rec
      Record to hold information about the actual state of the ADC designer

    Properties:
      selected_node - ID value of the selected node from the hierarchy. Combination of target_mode and node_id
      target_mode - Type of the node (CGR, CRU, CRA or CAA and others) that controls what form is displayed if the
                    APEX Action is invoked
      action_mode - Type of the node (CGR, CRU, CRA or CAA and others) that controls on what form the actual
                    APEX Action is to be performed. If fi <C_ACTION_DELETE> is invoked, the delete must be processed
                    for mode identified by this attribute. If this is done, target_mode controls which form to display next.
      node_id - ID of the selected node as used in the data model. Normally, the ID is taken based on the mode.
                It is possible though that not all modes have a correlated ID, fi the APEX Action group (CAG) which will
                reference the Rule Group (CGR) ID instead.
      form_id - Static ID of the actually selected form
      cgr_id - ID of the rule group the selecte node belongs to
      action - Name of the APEX action that triggered the event
   */ 
  type environment_rec is record(
    selected_node adc_util.ora_name_type,
    target_mode adc_util.ora_name_type,
    action_mode adc_util.ora_name_type,
    node_id adc_rule_groups.cgr_id%type,
    form_id adc_util.ora_name_type,
    cgr_id adc_rule_groups.cgr_id%type,
    action adc_util.ora_name_type);
    
  /**
    Type: form_item_list_tab
      List of page items required by a given mode.
      
      The list of page items required for a given form is collected upon package initialization based on the
      APEX meta data and the form region's static ID.
      
      These item lists are required for the ADC designer to 
      
      - control which items to pass back to the database if a DML process is requested
      - control which items to monitor for changes. If on of these items changes and a respective APEX Action
        is invoked, a warn message is displayed to prevent this data from being overwritten.
   */
  type form_item_list_tab is table of adc_util.sql_char index by adc_util.ora_name_type;

  /**
    Group: Private package variables
   */
  /**
    Variables: State variables
      g_environment - Variable of type <environment_rec> to hold all relevant attributes of the actual designer state.
      g_page_values - PL/SQL table to hold key value pairs for page items (key) and their values
   */
  g_environment environment_rec;
  
  g_page_values utl_apex.page_value_t;

  g_cai_list char_table;
  g_form_item_list form_item_list_tab;


  /**
    Group: Copy Session State methods
   */
  /** 
    Procedure: copy_...
      Helper to copy APEX session state values into type safe record structures

      Is called to copy the actual session state values entered into a type safe record structure.
      Type casting is auto detected if APEX has knowledge of the type, fi by using a form region or
      editable interactive grid. If this is not present, it tries to detect the type basyed on a 
      format mask assigned to the item.
      
    Attention::
      Please note that the use of a form region or an editable interactive grid requires the 
      mandatory identification with a static ID so that the method can uniquely identify the region.
   */
  procedure copy_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_apex_action');
    
    g_page_values := utl_apex.get_page_values(C_REGION_CAA_FORM);
    p_row.caa_id := to_number(utl_apex.get(g_page_values, 'CAA_ID'), 'fm9999999999990');
    p_row.caa_cgr_id := to_number(utl_apex.get(g_page_values, 'CAA_CGR_ID'), 'fm9999999999990');
    p_row.caa_cty_id := utl_apex.get(g_page_values, 'CAA_CTY_ID');
    p_row.caa_name := utl_apex.get(g_page_values, 'CAA_NAME');
    p_row.caa_label := utl_apex.get(g_page_values, 'CAA_LABEL');
    p_row.caa_context_label := utl_apex.get(g_page_values, 'CAA_CONTEXT_LABEL');
    p_row.caa_icon := utl_apex.get(g_page_values, 'CAA_ICON');
    p_row.caa_icon_type := utl_apex.get(g_page_values, 'CAA_ICON_TYPE');
    p_row.caa_title := utl_apex.get(g_page_values, 'CAA_TITLE');
    p_row.caa_shortcut := utl_apex.get(g_page_values, 'CAA_SHORTCUT');
    p_row.caa_initially_disabled := utl_apex.get(g_page_values, 'CAA_INITIALLY_DISABLED');
    p_row.caa_initially_hidden := utl_apex.get(g_page_values, 'CAA_INITIALLY_HIDDEN');
    p_row.caa_href := utl_apex.get(g_page_values, 'CAA_HREF');
    p_row.caa_action := utl_apex.get(g_page_values, 'CAA_ACTION');
    p_row.caa_on_label := utl_apex.get(g_page_values, 'CAA_ON_LABEL');
    p_row.caa_off_label := utl_apex.get(g_page_values, 'CAA_OFF_LABEL');
    p_row.caa_get := utl_apex.get(g_page_values, 'CAA_GET');
    p_row.caa_set := utl_apex.get(g_page_values, 'CAA_SET');
    p_row.caa_choices := utl_apex.get(g_page_values, 'CAA_CHOICES');
    p_row.caa_label_classes := utl_apex.get(g_page_values, 'CAA_LABEL_CLASSES');
    p_row.caa_label_start_classes := utl_apex.get(g_page_values, 'CAA_LABEL_START_CLASSES');
    p_row.caa_label_end_classes := utl_apex.get(g_page_values, 'CAA_LABEL_END_CLASSES');
    p_row.caa_item_wrap_class := utl_apex.get(g_page_values, 'CAA_ITEM_WRAP_CLASS');

    utl_text.string_to_table(utl_apex.get(g_page_values, 'CAA_CAI_LIST'), g_cai_list);

    pit.leave_detailed;
  end copy_apex_action;
  
  
  procedure copy_rule(
    p_row in out nocopy adc_rules%rowtype)
  as
  begin
    pit.enter_detailed('copy_rule');

    g_page_values := utl_apex.get_page_values(C_REGION_CRU_FORM);
    p_row.cru_id := to_number(utl_apex.get(g_page_values, 'CRU_ID'), '999990');
    p_row.cru_cgr_id := coalesce(to_number(utl_apex.get(g_page_values, 'CRU_CGR_ID'), '999990'), g_environment.cgr_id);
    p_row.cru_sort_seq := to_number(utl_apex.get(g_page_values, 'CRU_SORT_SEQ'), '999990');
    p_row.cru_name := utl_apex.get(g_page_values, 'CRU_NAME');
    p_row.cru_condition := utl_apex.get(g_page_values, 'CRU_CONDITION');
    p_row.cru_fire_on_page_load := utl_apex.get(g_page_values, 'CRU_FIRE_ON_PAGE_LOAD');
    p_row.cru_active := utl_apex.get(g_page_values, 'CRU_ACTIVE');

    pit.leave_detailed;
  end copy_rule;


  procedure copy_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype)
  as
    l_param_name_1 adc_util.ora_name_type;
    l_param_name_2 adc_util.ora_name_type;
    l_param_name_3 adc_util.ora_name_type;
  begin
    pit.enter_detailed('copy_rule_action');

    g_page_values := utl_apex.get_page_values(C_REGION_CRA_FORM);
    p_row.cra_id := to_number(utl_apex.get(g_page_values, 'CRA_ID'), '999990');
    p_row.cra_cgr_id := coalesce(to_number(utl_apex.get(g_page_values, 'CRA_CGR_ID'), '999990'), g_environment.cgr_id);
    p_row.cra_cru_id := to_number(utl_apex.get(g_page_values, 'CRA_CRU_ID'), '999990');
    p_row.cra_sort_seq := to_number(utl_apex.get(g_page_values, 'CRA_SORT_SEQ'), '999990');
    p_row.cra_cpi_id := utl_apex.get(g_page_values, 'CRA_CPI_ID');
    p_row.cra_cat_id := utl_apex.get(g_page_values, 'CRA_CAT_ID');
    p_row.cra_active := utl_apex.get(g_page_values, 'CRA_ACTIVE');
    p_row.cra_on_error := utl_apex.get(g_page_values, 'CRA_ON_ERROR');
    p_row.cra_raise_recursive := utl_apex.get(g_page_values, 'CRA_RAISE_RECURSIVE');
    p_row.cra_comment := utl_apex.get(g_page_values, 'CRA_COMMENT');

    -- Get the required parameter field
    begin
      with data as (
           select cap_cat_id, cap_sort_seq, 
                  'CRA_PARAM_' ||
                  case cpt_cpv_id
                    when 'TEXT' then null
                    when 'SELECT_LIST' then 'LOV_'
                    when 'STATIC_LIST' then 'LOV_'
                    when 'TEXT_AREA' then 'AREA_'
                    when 'SWITCH' then 'SWITCH_'
                  end || cap_sort_seq item_name
             from adc_action_parameters
             join adc_action_param_types
               on cap_cpt_id = cpt_id)
      select max(decode(cap_sort_seq, 1, item_name)) item_name_1,
             max(decode(cap_sort_seq, 2, item_name)) item_name_2,
             max(decode(cap_sort_seq, 3, item_name)) item_name_3
        into l_param_name_1, l_param_name_2, l_param_name_3
        from data
       where cap_cat_id = p_row.cra_cat_id
       group by cap_cat_id;
    exception
      when no_data_found then
        null; -- No parameter for action type, ignore
    end;

    p_row.cra_param_1 := case when l_param_name_1 is not null then utl_apex.get(g_page_values, l_param_name_1) end;
    p_row.cra_param_2 := case when l_param_name_2 is not null then utl_apex.get(g_page_values, l_param_name_2) end;
    p_row.cra_param_3 := case when l_param_name_3 is not null then utl_apex.get(g_page_values, l_param_name_3) end;    

    pit.leave_detailed;
  end copy_rule_action;


  /**
    Group: Private Methods
   */
  /**
    Function: assemble_action
      Method to calculate the action attribute of an APEX Action based on the action name, the node type and its ID.

      APEX Actions <C_ACTION_CREATE>, <C_ACTION_UPDATE> processing user input 
      forms require a list of page items to work with.
      This list is evaluated on package initialization at method <initialize>
      and integrated into the action's event data attribute as required.

    Parameters:
      p_action - ID of the APEX Action to set the action for
      p_row - the selected row of the decision table with all relevant information for the APEX Action
   */
  function assemble_action(
    p_action in adc_util.ora_name_type,
    p_row in adc_bl_designer_action_v%rowtype)
  return varchar2
  as
    /**
      Constant: assemble_action.C_ACTION_TEMPLATE
        Method private code template for the action attribute.
        
        The template holds relevant information that is accessible by the package
        upon action execution via the <ADC_API.get_event_data> method. It's structure is as follows:
        
        --- JavaScript
        de.condes.plugin.adc.executeCommand({
          "command":"Name of the APEX action",
          "targetMode":"Mode to which the code traverses if the action is executed",
          "actionMode":"Mode to which APEX action refers to",
          "id":"ID of the target mode entry",
          "additionalPageItems": [Array of page items which are required during processing],
          "monitorChanges":Flag to indicate whether it is required to check for changes prior to invoking the action});
        ---
     */
    C_ACTION_TEMPLATE adc_util.max_char := 
      'de.condes.plugin.adc.executeCommand({"command":"#COMMAND#","targetMode":"#TARGET_MODE#","actionMode":"#ACTION_MODE#","id":"#NODE_ID#","additionalPageItems":#PAGE_ITEM_LIST#,"monitorChanges":#MONITOR_CHANGES#});';
    l_action adc_util.max_char;
    l_target_mode adc_util.ora_name_type;
    l_action_mode adc_util.ora_name_type;
    l_node_id adc_util.ora_name_type;
    l_page_items adc_util.max_char;
    l_monitor_changes adc_util.ora_name_type;
  begin
    pit.enter_detailed('assemble_action',
      p_params => msg_params(
                    msg_param('p_action', p_action)));

    -- Calculate values for replacement
    -- Decide whether a list of page items for a given form are required
    if p_action in (C_ACTION_CREATE, C_ACTION_UPDATE) and g_form_item_list.exists(p_row.mda_form_id)
    then
      l_page_items := g_form_item_list(p_row.mda_form_id);
    else
      l_page_items := '[]';
    end if;

    -- calculate modes and id based on action type
    case p_action
      when C_ACTION_CREATE then
        l_target_mode := p_row.mda_create_target_mode;
        l_node_id := null;
      when C_ACTION_UPDATE then
        l_target_mode := p_row.mda_update_target_mode;
        l_node_id := p_row.mda_update_value;
      when C_ACTION_DELETE then
        l_target_mode := p_row.mda_delete_target_mode;
        l_action_mode := p_row.mda_delete_mode;
        l_node_id := p_row.mda_delete_value;
      when C_ACTION_CANCEL then
        l_target_mode := p_row.mda_cancel_target_mode;
        l_node_id := p_row.mda_cancel_value;
      else
        l_target_mode := p_row.mda_actual_mode;
        l_node_id := p_row.mda_id_value;
    end case;

    -- decide whether monitoring changes on the page is required
    if p_action in (C_ACTION_CANCEL, C_ACTION_CREATE) then
      l_monitor_changes := 'true';
    else
      l_monitor_changes := 'false';
    end if;

    -- assemble
    l_action := utl_text.bulk_replace(C_ACTION_TEMPLATE, char_table(
                  '#COMMAND#', p_action,
                  '#PAGE_ITEM_LIST#', l_page_items,
                  '#TARGET_MODE#', l_target_mode,
                  '#ACTION_MODE#', l_action_mode,
                  '#NODE_ID#', l_node_id,
                  '#MONITOR_CHANGES#', l_monitor_changes));

    pit.leave_optional;
    return l_action;
  end assemble_action;


  /** 
    Function: get_cra_sort_seq
      Calculates the next Rule Action sort sequence for a given Rule ID.
   */
  function get_cra_sort_seq(
    p_cru_id in adc_rules.cru_id%type)
    return number
  as
    l_cra_sort_seq adc_rule_actions.cra_sort_seq%type;
  begin
    pit.enter_optional('get_cra_sort_seq',
      p_params => msg_params(
                    msg_param('p_cru_id', p_cru_id)));

    select coalesce(max(trunc(cra_sort_seq, -1)) + 10, 10)
      into l_cra_sort_seq
      from adc_rule_actions
     where cra_cru_id = p_cru_id;

    pit.leave_optional(
      p_params => msg_params(msg_param('SortSequence', l_cra_sort_seq)));
    return l_cra_sort_seq;
  end get_cra_sort_seq;


  /** 
    Function: get_cru_sort_seq
      Calculates the next Rule sort sequence for a given Rule Group ID.
   */
  function get_cru_sort_seq(
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return number
  as
    l_cru_sort_seq adc_rules.cru_sort_seq%type;
  begin
    pit.enter_optional('get_cru_sort_seq',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

    select coalesce(max(trunc(cru_sort_seq, -1)) + 10, 10)
      into l_cru_sort_seq
      from adc_rules
     where cru_cgr_id = p_cgr_id;

    pit.leave_optional(
      p_params => msg_params(msg_param('SortSequence', l_cru_sort_seq)));
    return l_cru_sort_seq;
  end get_cru_sort_seq;


  /**
    Function: get_first_cgr_for_app
      Method retrieves the CGR_ID for the first page that is maintained by ADC
      
    Returns: CGR_ID of the first ADC maintained page, ordered by page number.
             If no page exists or no application selected, NULL is returned.
   */
  function get_first_cgr_for_app
    return adc_rule_groups.cgr_id%type
  as
  begin
    pit.enter_optional('get_first_cgr_for_app');
    
    select cgr_id
      into g_environment.cgr_id
      from adc_rule_groups
     where cgr_app_id = (select utl_apex.get_number('CGR_APP_ID') from dual)
     order by cgr_page_id
     fetch first 1 row only;
     
    pit.leave_optional(p_params => msg_params(msg_param('CGR_ID', g_environment.cgr_id)));
    return g_environment.cgr_id;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional;
      return null;
  end get_first_cgr_for_app;


  /**
    Procedure: maintain_actions
      Method to calculate the visible status and action parameter of the APEX Actions.
      
      Based on the type and mode of the APEX Action called, this methods calculates
      the correct visible status, the label and the action properties of the APEX Actions.
      
      The decision is based on the outcome of the decision table query in <handle_activity>.
      The attributes of the selected row control the outcome of this method.
   */
  procedure maintain_actions(
    p_row in adc_bl_designer_action_v%rowtype)
  as
    l_cancel_pti pit_translatable_item_v.pti_name%type;
    l_disabled boolean;
    l_javascript adc_util.max_char;
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
  begin
    pit.enter_optional('maintain_actions',
      p_params => msg_params(msg_param('Action', p_row.mda_comment)));

    -- Initialize
    l_cancel_pti := pit.get_trans_item_name(C_PTI_PMG, 'CANCEL_BUTTON');

    -- CANCEL-Button
    l_disabled := p_row.mda_cancel_button_active = adc_util.C_FALSE;
    adc_apex_action.action_init(C_ACTION_CANCEL);
    adc_apex_action.set_disabled(l_disabled);
    if not l_disabled then
      adc_apex_action.set_action(assemble_action(C_ACTION_CANCEL, p_row));
      adc_apex_action.set_title(l_cancel_pti);
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);

    -- CREATE button
    l_disabled := p_row.mda_create_button_visible = adc_util.C_FALSE;
    adc_apex_action.action_init(C_ACTION_CREATE);
    adc_apex_action.set_disabled(l_disabled);
    if not l_disabled then
      adc_apex_action.set_action(assemble_action(C_ACTION_CREATE, p_row));
      adc_apex_action.set_label(p_row.mda_create_button_label);
      adc_apex_action.set_title(p_row.mda_create_button_label);
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);

    -- DELETE button
    l_disabled := p_row.mda_delete_button_visible = adc_util.C_FALSE;
    adc_apex_action.action_init(C_ACTION_DELETE);
    adc_apex_action.set_disabled(l_disabled);
    if not l_disabled then
    adc_apex_action.set_action(assemble_action(C_ACTION_DELETE, p_row));
    adc_apex_action.set_label(p_row.mda_delete_button_label);
    adc_apex_action.set_title(p_row.mda_delete_button_label);
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);

    -- SAVE button
    l_disabled := p_row.mda_update_button_visible = adc_util.C_FALSE;
    adc_apex_action.action_init(C_ACTION_UPDATE);
    adc_apex_action.set_disabled(l_disabled);
    adc_apex_action.set_disabled(false);
    adc_apex_action.set_action(assemble_action(C_ACTION_UPDATE, p_row));
    adc_apex_action.set_title(p_row.mda_update_button_label);
    adc.add_javascript(adc_apex_action.get_action_script);
    
    -- EXPORT rule group
    -- get target application id
    select cgr_app_id
      into l_cgr_app_id
      from adc_rule_groups
     where cgr_id = g_environment.cgr_id;
    if l_cgr_app_id is not null then
      adc_apex_action.action_init(C_EXPORT_CGR);
      l_javascript := utl_apex.get_page_url(
                        p_page => C_EXPORT_PAGE,
                        p_param_items => C_EXPORT_PAGE_PREFIX || 'CGR_APP_ID',
                        p_value_list => l_cgr_app_id,
                        p_triggering_element => C_BUTTON_PREFIX || C_EXPORT_PAGE);
      adc_apex_action.set_action(l_javascript);
      adc_apex_action.set_disabled(false);
    else
      adc_apex_action.set_disabled(true);
    end if;
    adc.add_javascript(adc_apex_action.get_action_script);

    pit.leave_optional;
  end maintain_actions;


  /** 
    Function: process_page
      Method to process the user input and persist the data at the database.
      
      Based on the mode of the APEX Action (such as CGR, CRU etc.) the method calls
      the respective XAPI methods implemented in package <ADC_ADMIN>. It also decides
      upon the method to call based on the command passed in.
   */
  procedure process_page
  as
    l_cgr_id adc_rule_groups.cgr_id%type := utl_apex.get_number('P13_CGR_ID');
    l_apex_row adc_apex_actions_v%rowtype;
    l_rule_row adc_rules%rowtype;
    l_action_row adc_rule_actions%rowtype;
    l_selected_id adc_util.ora_name_type;
  begin
    pit.enter_mandatory;
    
    case g_environment.action_mode
      when C_MODE_CRU then
        copy_rule(l_rule_row);
      when C_MODE_CRA then
        copy_rule_action(l_action_row);
      when C_MODE_CAA then
        copy_apex_action(l_apex_row);
      else
        null;
    end case;

    case g_environment.action 
      when C_ACTION_UPDATE then
        pit.info(msg.ADC_UI_ACTION_REQUESTED, msg_args(C_ACTION_UPDATE, g_environment.target_mode));
        case g_environment.target_mode
          when C_MODE_CRU then
            adc_admin.merge_rule(l_rule_row);
            adc.set_item(
              p_cpi_id => C_ITEM_CRU_ID,
              p_item_value => l_rule_row.cru_id);
            l_selected_id := C_MODE_CRU || '_' || l_rule_row.cru_id;
          when C_MODE_CRA then
            adc_admin.merge_rule_action(l_action_row);
            adc.set_item(
              p_cpi_id => C_ITEM_CRA_ID,
              p_item_value => l_action_row.cra_id);
            l_selected_id := C_MODE_CRA || '_' || l_action_row.cra_id;
          when C_MODE_CAA then
            adc_admin.merge_apex_action(l_apex_row, g_cai_list);
            adc.set_item(
              p_cpi_id => C_ITEM_CAA_ID,
              p_item_value => l_apex_row.caa_id);
            l_selected_id := C_MODE_CAA || '_' || l_apex_row.caa_id;
          else
            null;
        end case;
        -- Transaction control, because the action is called via AJAX
        adc.show_notification(msg.ADC_UI_CHANGES_SAVED);
        adc.set_item(
          p_cpi_id => C_ITEM_SELECTED_NODE,
          p_item_value => l_selected_id);
        commit;
      when C_ACTION_DELETE then
        pit.info(msg.ADC_UI_ACTION_REQUESTED, msg_args(C_ACTION_DELETE, g_environment.action_mode));
        case g_environment.action_mode
          when C_MODE_CRU then
            adc_admin.delete_rule(l_rule_row);
          when C_MODE_CRA then
            adc_admin.delete_rule_action(l_action_row);
          when C_MODE_CAA then
            adc_admin.delete_apex_action(l_apex_row);
          else
            null;
        end case;
        -- Transaction control, because the action is called via AJAX
        adc.show_notification(msg.ADC_UI_DATA_DELETED);
        commit;
      else
        adc.register_error(
          p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
          p_message_name => msg.ADC_UI_UNKNOWN_ACTION,
          p_msg_args => msg_args(g_environment.action));
    end case;

    -- in any case, propagate rule change to reflect changes
    begin
      adc_admin.propagate_rule_change(l_cgr_id);
    exception
      when others then
        -- ignore any errors here as these can occur if the page has changed
        -- and has made a rule group invalid. Display the errors instead.
        null;
    end;

    adc.refresh_item(
      p_cpi_id => C_REGION_HIERARCHY,
      p_set_item => adc_util.C_FALSE);

    adc.refresh_item(
      p_cpi_id => C_REGION_RULES,
      p_set_item => adc_util.C_FALSE);

    adc.refresh_item(
      p_cpi_id => C_REGION_FINDINGS,
      p_set_item => adc_util.C_FALSE);

    pit.leave_mandatory;
  end process_page;
  
  
  /**
    Procedure: set_id_values
      Maintains the session state of CGR_ID and others based on the environment.
      
      IDs can change as a consequence of two use cases only:
      
      - A row in the hierarchy or the rule report is selected
      - A new tupel is generated.
      
      This method deals with the first use case. In this use case, the ID of the
      selected node is passed in in the form <mode>_<id>, fi CRA_1234 for a Rule Action.
      This method performs two tasks with this information:
      
      - It sets the ID of page item CRA_ID to the value 1234
      - It retrieves the related CGR_ID and compares it to the actually set CGR_ID.
        Should they differ, the new CGR_ID is set and a refresh of the Rule Report
        is requested.
        
      If a new tupel is created, the ID is set there after succesful creation.
   */
  procedure set_id_values
  as
    l_cgr_id adc_rule_groups.cgr_id%type;
    l_cru_id adc_rules.cru_id%type;
  begin
    pit.enter_optional('set_id_values');
    
    -- Retrieve CGR_ID 
    case g_environment.target_mode
      when C_MODE_CAA then
        select caa_cgr_id
          into g_environment.cgr_id
          from adc_apex_actions
         where caa_id = g_environment.node_id;
      when C_MODE_CRU then
        select cru_cgr_id
          into g_environment.cgr_id
          from adc_rules
         where cru_id = g_environment.node_id;
      when C_MODE_CRA then
        select cra_cgr_id, cra_cru_id
          into g_environment.cgr_id, l_cru_id
          from adc_rule_actions
         where cra_id = g_environment.node_id;
        if coalesce(adc_api.get_number(C_ITEM_CRU_ID), 0) != l_cru_id then   
          adc.set_item(
            p_cpi_id => C_ITEM_CRU_ID,
            p_item_value => l_cru_id);
        end if;
      else
        g_environment.cgr_id := g_environment.node_id;
    end case;
    
    -- Compare CGR_ID with session state. If changed, refresh rule report
    l_cgr_id := coalesce(adc_api.get_number(C_ITEM_CGR_ID), 0);
    if l_cgr_id != g_environment.cgr_id then
      -- Make sure that the rule group is based on actual application data
      adc_admin.propagate_rule_change(l_cgr_id);
      -- control page
      adc.set_item(
        p_cpi_id => C_ITEM_CGR_ID,
        p_item_value => g_environment.cgr_id);
      adc.set_item(
        p_cpi_id => C_ITEM_CRU_CGR_ID,
        p_item_value => g_environment.cgr_id);
      adc.set_item(
        p_cpi_id => C_ITEM_CRA_CGR_ID,
        p_item_value => g_environment.cgr_id);
      adc.set_item(
        p_cpi_id => C_ITEM_CAA_CGR_ID,
        p_item_value => g_environment.cgr_id);
      adc.refresh_item(
        p_cpi_id => C_REGION_RULES,
        p_set_item => adc_util.C_FALSE);
      adc.refresh_item(
        p_cpi_id => C_REGION_FINDINGS,
        p_set_item => adc_util.C_FALSE);
    end if;
    
    -- Set ID of the selected mode if not CGR and set SELECTD_NODE to enable the tree to remember its state
    if g_environment.target_mode != C_MODE_CGR then
      adc.set_item(
        p_cpi_id => C_PAGE_PREFIX || g_environment.target_mode || '_ID',
        p_item_value => g_environment.node_id);
    end if;

    adc.set_item(
      p_cpi_id => C_PAGE_PREFIX || 'SELECTED_NODE',
      p_item_value => g_environment.selected_node); 
      
    pit.leave_optional;
  end set_id_values;


  /**
    Procedure: read_environment
      Method to retrieve the actual state of the ADC designer.
      
      This procedure analyses the data attribute of the APEX Action invoked by the user.
      Based on this information, respective values are copied into <g_environment>.
      
      A second use case is that this method is called based on a selection of a row
      in the hierarchy tree or rule report. In this case, the data attribute only contains
      the ID of the selected row, which is composed of the mode and the id of the
      respective tupel. A selected Rule will therefore pass in something like CRU_123.
      
      Based on this information, the required attributes are filled:
      
      - action and target mode,
      - id of the active entry
      - static ID of the form to show
      - CGR_ID of the rule group containing the selected entry.
      
      If the CGR_ID has changed, this method also emits JavaScript code to refresh
      the rule report region.
   */
  procedure read_environment
  as
    l_cgr_id adc_rule_groups.cgr_id%type;
  begin
    pit.enter_optional('read_environment');
    
    case when adc_api.get_firing_item = C_ITEM_CGR_APP_ID then
      -- Application selection changed, return to initial state
      l_cgr_id := get_first_cgr_for_app;
      adc.set_item(
        p_cpi_id => C_ITEM_CGR_ID,
        p_item_value => l_cgr_id);
      adc.set_item(
        p_cpi_id => C_ITEM_SELECTED_NODE,
        p_item_value => case when l_cgr_ID is not null then 'CGR_' || l_cgr_id end);
      adc.refresh_item(
        p_cpi_id => C_REGION_RULES,
        p_set_item => adc_util.C_FALSE);
      adc.refresh_item(
        p_cpi_id => C_REGION_HIERARCHY,
        p_set_item => adc_util.C_FALSE);
      adc.refresh_item(
        p_cpi_id => C_REGION_FINDINGS,
        p_set_item => adc_util.C_FALSE);
    when substr(adc_api.get_event_data, 1, 1) = '{' then
      -- Event data is JSON. Indicates that an APEX Action has called the method. Extract node type and -id
      g_environment.target_mode := adc_api.get_event_data('targetMode');
      g_environment.action_mode := coalesce(adc_api.get_event_data('actionMode'), adc_api.get_event_data('targetMode'));
      g_environment.node_id := to_number(adc_api.get_event_data('id'));
      g_environment.form_id := C_REGION_PREFIX || g_environment.target_mode || '_FORM';
      g_environment.action := adc_api.get_event_data('command');
      g_environment.cgr_id := adc_api.get_number(C_ITEM_CGR_ID);
    else
      -- Method was called due to a changed selection in hierarchy or rule report. ID is passed in directly
      g_environment.selected_node := adc_api.get_event_data;
      g_environment.target_mode := substr(g_environment.selected_node, 1, 3);
      g_environment.node_id := to_number(substr(g_environment.selected_node, 5), 'fm99999990');
      g_environment.form_id := C_REGION_PREFIX || g_environment.target_mode || '_FORM';
      g_environment.action := C_ACTION_SHOW;
      -- Harmonize with page state
      set_id_values;
    end case;

    pit.log_state(msg_params(
      msg_param('selected_node', g_environment.selected_node),
      msg_param('target_mode', g_environment.target_mode),
      msg_param('action_mode', g_environment.action_mode),
      msg_param('node_id', g_environment.node_id),
      msg_param('form_id', g_environment.form_id),
      msg_param('action', g_environment.action)));

    pit.leave_optional;
  end read_environment;


  /**
    Procedure: set_cat_help_text
      Method to calculate the help text for the selected hierarchy entry

    Parameter:
      p_cat_id - ID of the ADC Action Type to set the help text for

   */
  procedure set_cat_help_text(
    p_cat_id in adc_action_types.cat_id%type)
  as
    l_help_text adc_util.max_char;
  begin
    pit.enter_optional('set_cat_help_text',
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id)));

    select help_text
      into l_help_text
      from adc_bl_cat_help
     where cat_id = p_cat_id;
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => l_help_text);

    pit.leave_optional;
  exception
    when NO_DATA_FOUND then
      -- no help found, generate generic help text
      adc.set_region_content(
        p_region_id => C_REGION_HELP, 
        p_html_code => adc_util.get_trans_item_name('CRA_NO_HELP'));

      pit.leave_mandatory;
  end set_cat_help_text;


  /**
    Procedure: set_cra_param_settings
      Method to adjust the visibility, type and content of the parameters depending on the action type.

    Parameters:
      p_cra_id - ID of the Rule Action
      p_cat_id - Type of the Rule Action
   */
  procedure set_cra_param_settings(
    p_cra_id in adc_rule_actions.cra_id%type,
    p_cat_id in adc_action_types.cat_id%type)
  as    
    C_PARAM_SELECTOR varchar2(100 byte) := '.adc-cra-hide';

    -- Cursor collects the parameters, parameter settings and Rule Action
    -- values (if the Rule Action is not newly created)
    cursor action_type_cur(
             p_cra_id in adc_rule_actions.cra_id%type,
             p_cat_id in adc_action_types.cat_id%type) is
      with params as(
             select adc_util.c_true c_active,
                    p_cra_id p_cra_id,
                    p_cat_id p_cat_id
               from dual)
      select /*+ no_merge (p) */
             sat.cat_id, cat_cif_id, 
             cpt_id, cpt_cpv_id,
             cap_sort_seq, cap_mandatory, 
             coalesce(
               case cap_sort_seq
                 when 1 then cra_param_1
                 when 2 then cra_param_2
                 when 3 then cra_param_3
               end, cap_default) cap_value,
             coalesce(cap_display_name, cpt_name) cpt_name,
             utl_apex.get_page_prefix || 'CRA_PARAM_' || 
             case cpt_cpv_id
               when 'SELECT_LIST' then 'LOV_'
               when 'STATIC_LIST' then 'LOV_'
               when 'TEXT_AREA' then 'AREA_'
               when 'SWITCH' then 'SWITCH_'
             end || cap_sort_seq cap_page_item
        from adc_action_types_v sat
        join params
          on cat_id = p_cat_id
         and cat_active = c_active
        left join adc_action_parameters_v
          on sat.cat_id = cap_cat_id
         and c_active = cap_active
        left join adc_action_param_types_v
          on cap_cpt_id = cpt_id
         and c_active = cpt_active
        left join (
             select *
               from adc_ui_designer_rule_action
               join params
                 on cra_id = p_cra_id)
          on cat_id = cra_cat_id
       where cap_sort_seq is not null
       order by cat_id, cap_sort_seq;

    l_mandatory_message adc_util.max_char;
  begin
    pit.enter_optional('set_cra_param_settings',
      p_params => msg_params(
                    msg_param('p_cra_id', p_cra_id),
                    msg_param('p_cat_id', p_cat_id)));

    -- Initialize
    l_mandatory_message := pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY);

    -- Hide all parameter regions
    adc.set_visual_state(
      p_jquery_selector => C_PARAM_SELECTOR,
      p_visual_state => adc.C_HIDE);

    -- Adjust Parameter settings to show only required parameters in the correct format
    for param in action_type_cur(p_cra_id, p_cat_id) loop
      -- Show parameter region
      adc.set_visual_state(
        p_cpi_id => C_REGION_PREFIX || 'PARAMETER_' || param.cap_sort_seq,
        p_visual_state => adc.C_SHOW_ENABLE);   
      adc.set_item_label(param.cap_page_item, param.cpt_name);    

      -- First set items mandatory to avoid endless loops if a select list refreshes
      if param.cap_mandatory = adc_util.C_TRUE then
        adc.set_mandatory(
           p_cpi_id => param.cap_page_item,
           p_msg_text => replace(l_mandatory_message, '#LABEL#', param.cpt_name));
      else
        adc.set_optional(p_cpi_id => param.cap_page_item);
        adc.set_visual_state(
          p_cpi_id => param.cap_page_item,
          p_visual_state => adc.C_SHOW_ENABLE);   
      end if;

     -- set values, if required after refresh
     if param.cpt_cpv_id in ('SELECT_LIST', 'STATIC_LIST') then
       adc.set_item(
         p_cpi_id => C_PAGE_PREFIX || 'CRA_LOV_PARAM_' || param.cap_sort_seq,
         p_item_value => param.cpt_id);
       adc.refresh_item(
         p_cpi_id => param.cap_page_item, 
         p_item_value => param.cap_value,
         p_set_item => adc_util.C_TRUE);
     else
       adc.set_item(
         p_cpi_id => param.cap_page_item,
         p_item_value => apex_escape.json(param.cap_value),
         p_allow_recursion => adc_util.C_FALSE);
     end if;

    end loop;

    pit.leave_optional;
  end set_cra_param_settings;


  /** 
    Procedure: show_form_caa
      Method to show and populate a ADC Apex Action form of the designer and populate it with the values selected.
      
      Two modes:
      
      - APEX Action already exists. Initialize form based on stored values
      - APEX Action is created. Initialize form with default values
   */
  procedure show_form_caa
  as
    l_statement adc_util.max_char := q'^
select null caa_id, '#CGR_ID#' caa_cgr_id, 'ACTION' caa_cty_id, null caa_name,
       null caa_label, null caa_context_label, null caa_icon, 'fa' caa_icon_type,
       null caa_shortcut, adc_util.C_FALSE caa_initially_disabled, adc_util.C_FALSE caa_initially_hidden,
       null caa_href, null caa_action, null caa_on_label, null caa_off_label,
       null caa_get, null caa_set, null caa_choices, 
       null caa_label_classes, null caa_label_start_classes,
       null caa_label_end_classes, null caa_item_wrap_class
  from dual;
    ^';
  begin
    pit.enter_mandatory('show_form_caa');

    if g_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CAA, initialize default values
      l_statement := replace(l_statement, '#CGR_ID#', g_environment.cgr_id);
      adc.set_items_from_statement(
        p_cpi_id => adc_util.c_no_firing_item, 
        p_statement => l_statement);
    else
      -- Was called from the hierarchy tree
      adc.initialize_form_region(C_REGION_CAA_FORM);
    end if;

    -- Show action atribute region
    adc.show_hide_item('.adc-apex-action', '.adc-hide');
    -- control items to show
    adc.show_hide_item('.adc-caa-' || lower(adc_api.get_string(C_PAGE_PREFIX || 'CAA_CTY_ID')), '.adc-caa-hide');
    adc.refresh_item(
      p_cpi_id => C_PAGE_PREFIX || 'CAA_CAI_LIST', 
      p_set_item => adc_util.C_TRUE);
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CAA_HELP'));

    pit.leave_mandatory;
  end show_form_caa;


  /** 
    Procedure: show_form_cgr
      Method to show and populate an ADC Rule Group form of the designer and populate it with the values selected.
   */
  procedure show_form_cgr
  as
  begin
    pit.enter_mandatory('show_form_cgr');

    adc.refresh_item(C_REGION_CGR_FORM);
    adc.show_hide_item('.adc-rule-group', '.adc-hide');
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CGR_HELP'));

    pit.leave_mandatory;
  end show_form_cgr;
  
  
  /** 
    Procedure: show_form_cra
      Method to show and populate a ADC Rule Action form of the designer and populate it with the values selected.
      
      The method distinguishes between different scenarios:
      
      - Show an already existing Rule Action
      - Create a new Rule Action
      - Update an already visible Rule Action after changing its action type
      
      Based on this decision, the form is populated with the existing data or with a set
      of default data required for this method.
   */
  procedure show_form_cra
  as
    l_cra_id adc_rule_actions.cra_id%type;
    l_cru_id adc_rules.cru_id%type;
    l_cat_id adc_action_types.cat_id%type;
    l_cif_default adc_action_item_focus.cif_default%type;
    l_statement adc_util.max_char := q'^
select null #PRE#CRA_ID, '#CGR_ID#' #PRE#CRA_CGR_ID, '#CRU_ID#' #PRE#CRA_CRU_ID,
       '#NO_FIRING_ITEM#' #PRE#CRA_CPI_ID, null #PRE#CRA_CAT_ID, adc_util.C_FALSE #PRE#CRA_ON_ERROR,
       null #PRE#CRA_PARAM_1, null #PRE#CRA_PARAM_2, null #PRE#CRA_PARAM_3, null #PRE#CRA_COMMENT,
       adc_util.C_TRUE #PRE#CRA_RAISE_RECURSIVE, adc_util.C_FALSE #PRE#CRA_RAISE_ON_VALIDATION,
       #SORT_SEQ# #PRE#CRA_SORT_SEQ, adc_util.C_TRUE #PRE#CRA_ACTIVE
  from dual
    ^';
  begin
    pit.enter_mandatory('show_form_cra');
    
    -- Calculate form data for two possible use cases:
    -- - New CRA, get default values
    -- - Existing CRA, initialize form based on CRA_ID
    case when g_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CRA, initialize default values
      l_cru_id := adc_api.get_number(C_ITEM_CRU_ID);
      utl_text.bulk_replace(l_statement, char_table(
        '#PRE#', utl_apex.get_page_prefix,
        '#CGR_ID#', g_environment.cgr_id,
        '#CRU_ID#', l_cru_id,
        '#NO_FIRING_ITEM#', adc_util.c_no_firing_item,
        '#SORT_SEQ#', get_cra_sort_seq(l_cru_id)));
      adc.set_items_from_statement(
        p_cpi_id => adc_util.c_no_firing_item, 
        p_statement => l_statement);
    when g_environment.action = C_ACTION_SHOW then
      -- Was called from the hierarchy tree
      adc.initialize_form_region(C_REGION_CRA_FORM);
    else
      -- was called by changing the action type. Only control display state
      null;
    end case;

    -- Control visibility
    adc.show_hide_item('.adc-rule-action', '.adc-hide');

    -- Read ID values to adjust display settings
    l_cra_id := adc_api.get_number(C_ITEM_CRA_ID);
    l_cat_id := adc_api.get_string(C_ITEM_CRA_CAT_ID);  

    -- Adjust form for CAT if present
    if l_cat_id is not null then
      select coalesce(cra_cpi_id, cif_default)
        into l_cif_default
        from adc_action_types
        join adc_action_item_focus
          on cat_cif_id = cif_id
        left join (
             select *
               from adc_rule_actions
             where cra_id = l_cra_id)
          on cat_id = cra_cat_id
       where cat_id = l_cat_id;

      adc.refresh_item(
        p_cpi_id => C_PAGE_PREFIX || 'CRA_CPI_ID',
        p_item_value => l_cif_default,
        p_set_item => adc_util.c_true);
    end if;

    set_cra_param_settings(
      p_cra_id => l_cra_id,
      p_cat_id => l_cat_id);

    set_cat_help_text(
      p_cat_id => l_cat_id);

    pit.leave_mandatory;
  end show_form_cra;
  
  
  /** 
    Procedure: show_form_cru
      Method to show and populate a ADC Rule form of the designer and populate it with the values selected.
      
      Two modes:
      
      - Rule already exists. Initialize form based on stored values
      - Rule is created. Initialize form with default values
   */
  procedure show_form_cru
  as
    l_statement adc_util.max_char := q'^
select null #PRE#CRU_ID, '#CGR_ID#' #PRE#CRU_CGR_ID, '#SORT_SEQ#' #PRE#CRU_SORT_SEQ,
       null #PRE#CRU_NAME, null #PRE#CRU_CONDITION,
       adc_util.C_TRUE #PRE#CRU_ACTIVE, adc_util.C_FALSE #PRE#CRU_FIRE_ON_PAGE_LOAD
  from dual
    ^';
  begin
    pit.enter_mandatory('show_form_cru');

    case when g_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CRA, initialize default values
      utl_text.bulk_replace(l_statement, char_table(
        '#PRE#', utl_apex.get_page_prefix,
        '#CGR_ID#', g_environment.cgr_id,
        '#SORT_SEQ#', get_cru_sort_seq(g_environment.cgr_id)));
      adc.set_items_from_statement(
        p_cpi_id => adc_util.c_no_firing_item, 
        p_statement => l_statement);
    else
      -- Was called from the rule report
      adc.initialize_form_region(C_REGION_CRU_FORM);
    end case;

    adc.show_hide_item('.adc-rule', '.adc-hide');
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CRU_HELP'));

    pit.leave_mandatory;
  end show_form_cru;


  /** 
    Function: validate_page
      Method to validate the user input against the business rules for the different designer areas.
      
      Based on the mode of the APEX Action (see <C_MODE_CREATE> etc.) a decision is taken whether
      
      - a validation method is required
      - which validation method to call.
      
      Validation methods are implemented in package <ADC_ADMIN> and throw errors. If an error is thrown,
      this will prevent further execution of the page.
   */
  procedure validate_page
  as
    l_apex_row adc_apex_actions_v%rowtype;
    l_rule_row adc_rules%rowtype;
    l_action_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory;

    case g_environment.action_mode
      when C_MODE_CRU then
        copy_rule(l_rule_row);
        pit.start_message_collection;
        adc_admin.validate_rule(l_rule_row);
        pit.stop_message_collection;
      when C_MODE_CRA then
        copy_rule_action(l_action_row);
        pit.start_message_collection;
        adc_admin.validate_rule_action(l_action_row);
        pit.stop_message_collection;
      when C_MODE_CAA then
        copy_apex_action(l_apex_row);
        pit.start_message_collection;
        adc_admin.validate_apex_action(l_apex_row);
        pit.stop_message_collection;
      else
        null;
    end case;

    pit.leave_mandatory;
  end validate_page;


  /**
    Procedure: initialize
      Method to initialize the ADC_UI package

      Initially collects the name of all ADC Desginer page items per
      form region and persists them in an internal data structure for
      convenient access when working with the page designer.
   */
  procedure initialize
  as
    cursor form_item_cur is
      with params as (
             select utl_apex.get_application_id p_app_id,
                    utl_apex.get_page_id p_page_id
               from dual)
      select /*+ no_merge (p) */
             r.static_id form_id, '[' ||  listagg('"' || i.item_name || '"', ',') within group (order by item_name) || ']' item_list 
        from apex_application_page_items i
        join apex_application_page_regions r
          on i.data_source_region_id = r.region_id
        join params p
          on i.application_id = p_app_id
         and i.page_id = p_page_id
       group by r.static_id;
  begin
    -- Get the quasi constant page prefix for the export CGR page
    select 'P' || page_id || '_'
      into C_EXPORT_PAGE_PREFIX
      from apex_application_pages
     where application_id = (select utl_apex.get_application_id from dual)
       and page_alias = C_EXPORT_PAGE;
       
    -- Persist list of page items per form region to define which page items to load when processing a form dynamically
    for frm in form_item_cur loop
      g_form_item_list(frm.form_id) := frm.item_list;
    end loop;
  end initialize;


  /* 
    Group: Public Methods
   */
  /** 
    Function: get_lov_sql
      See <ADC_UI_DESIGNER.get_lov_sql>
   */
  function get_lov_sql(
    p_cpt_id in adc_action_param_types.cpt_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2
  as
  begin
    return adc_api.get_lov_sql(p_cpt_id, p_cgr_id);
  end get_lov_sql;


  /**
    Procedure: handle_activity
      See <ADC_UI_DESIGNER.handle_activity>
   */
  procedure handle_activity
  as
    cursor page_state_cur(
      p_mda_actual_mode adc_ui_map_designer_actions.mda_alm_id%type,
      p_mda_actual_id adc_ui_map_designer_actions.mda_ald_id%type) 
    is
      select *
        from adc_bl_designer_action_v
       where mda_actual_mode = p_mda_actual_mode
         and mda_actual_id = p_mda_actual_id;
  begin
    pit.enter_mandatory;

    read_environment;

    -- Execute DML if required
    case g_environment.action 
      when C_ACTION_UPDATE then
        validate_page;
        process_page;
      when C_ACTION_DELETE then
        process_page;
      else
        null;
    end case;

    -- Retrieve page status from decision table
    for act in page_state_cur(
                 p_mda_actual_mode => g_environment.target_mode, 
                 p_mda_actual_id => g_environment.action) 
    loop
      maintain_actions(act);

      case act.mda_actual_mode
      when C_MODE_CGR then
        show_form_cgr;
      when C_MODE_CAA then
        show_form_caa;
      when C_MODE_CRU then
        show_form_cru;
      when C_MODE_CRA then
        show_form_cra;
      else
        adc.show_hide_item('.adc-no-attributes', '.adc-hide');
        adc.set_region_content(C_REGION_HELP, null);
      end case;

      if act.mda_remember_page_state = adc_util.C_TRUE then
        adc.remember_page_status(
          p_page_items => case when g_form_item_list.exists(act.mda_form_id) then g_form_item_list(act.mda_form_id) else '[]' end,
          p_message => pit.get_message_text(msg.ADC_UI_UNSAVED_DATA));
      end if;
    end loop;

    pit.leave_mandatory;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      adc.handle_bulk_errors(char_table(
        -- CRU
        'ADC_INVALID_SQL', 'CRU_CONDITION',
        'CRU_CONDITION_MISSING', 'CRU_CONDITION',
        'CRU_CGR_ID_MISSING', 'CRU_CGR_ID',
        'CRU_NAME_MISSING', 'CRU_NAME',
        -- CRA
        'CRA_CRU_ID_MISSING', 'CRA_CRU_ID',
        'CRA_CGR_ID_MISSING', 'CRA_CGR_ID',
        'CRA_CPI_ID_MISSING', 'CRA_CPI_ID',
        'CRA_CAT_ID_MISSING', 'CRA_CAT_ID'
        -- CAA TODO: CAA Mapping
        ));
  end handle_activity;
  
  
  /** 
    Function: hanlde_cat_changed
      See <ADC_UI_DESIGNER.handle_cat_changed>
   */
  procedure handle_cat_changed
  as
  begin
    pit.enter_mandatory;
    
    show_form_cra;
    
    pit.leave_mandatory;
  end handle_cat_changed;


  /** 
    Function: toggle_cgr_active
      See <ADC_UI_DESIGNER.toggle_cgr_active>
   */
  procedure toggle_cgr_active
  as
    l_cgr_id adc_rule_groups.cgr_id%type;
  begin
    pit.enter_mandatory;

    l_cgr_id := utl_apex.get_number('CGR_ID');

    update adc_rule_groups
       set cgr_active = case cgr_active when adc_util.c_true then adc_util.c_false else adc_util.c_true end
     where cgr_id = l_cgr_id;

    commit;

    pit.leave_mandatory;
  end toggle_cgr_active;


  /** 
    Function: validate_rule_condition
      See <ADC_UI_DESIGNER.validate_rule_condition>
   */
  procedure validate_rule_condition
  as
    l_rule_row adc_rules%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_rule(l_rule_row);

    pit.start_message_collection;
    adc_admin.validate_rule_condition(l_rule_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      adc.handle_bulk_errors(char_table(
        'SQL_ERROR', 'CRU_CONDITION',
        'ADC_INVALID_SQL', 'CRU_CONDITION',
        'CRU_CONDITION_MISSING', 'CRU_CONDITION'));
    pit.leave_mandatory;
  end validate_rule_condition;
  
  
begin
  initialize;
end adc_ui_designer;
/
