create or replace package body adca_ui_designer
as

  /**
    Package: ADCA_UI_DESIGNER  Body
      Implementation of the GUI logic of the ADC APEX applications ADC Designer

    Author::
      Juergen Sieben, ConDeS GmbH
  */


  /**
    Group: Private package constants
   */
  C_PTI_PMG constant adc_util.ora_name_type := 'ADCA';
  
  /**
    Constants: Item and Region constants
      C_ITEM_CRG_APP_ID - Item that contains the Application ID
      C_ITEM_CRG_ID - Item that contains the Rule Group ID
      C_ITEM_CRU_ID - Item that contains the Rule ID
      C_ITEM_CRA_ID - Item that contains the Rule Action ID
      C_ITEM_CAA_ID - Item that contains the APEX Action ID
      C_ITEM_CRA_CAT_ID - Item that contains the Action Type
      C_REGION_RULES - Static ID of the Rule report region
      C_REGION_HIERARCHY - Static ID of the Hierarchy Tree region
      C_REGION_HELP - Static ID of the Help region
      C_REGION_CRG_FORM - Static ID of the Rule Group form region
      C_REGION_CRU_FORM - Static ID of the Rule form region
      C_REGION_CRA_FORM - Static ID of the Rule Action form region
      C_REGION_CAA_FORM - Static ID of the APEX Action form region
  */
  C_PAGE_PREFIX constant adc_util.ora_name_type := utl_apex.get_page_prefix;
  C_REGION_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'R');
  C_BUTTON_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'B');
  C_EXPORT_PAGE constant adc_util.ora_name_type := 'EXPORT_CRG';
  C_EXPORT_PAGE_PREFIX adc_util.ora_name_type; -- not constant as this is calculated upon initialization
  
  C_ITEM_CRG_APP_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRG_APP_ID';  
  C_ITEM_CRG_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRG_ID';
  C_ITEM_CRU_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRU_ID';
  C_ITEM_CRA_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_ID';
  C_ITEM_CAA_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_ID';
  C_ITEM_DIAGRAM_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'DIAGRAM_ID';
  C_ITEM_CRA_CRU_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CRU_ID';
  C_ITEM_CRA_CAT_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CAT_ID';
  C_ITEM_CRA_CPI_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CPI_ID';
  C_ITEM_CRU_CRG_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRU_CRG_ID';
  C_ITEM_CRA_CRG_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRA_CRG_ID';
  C_ITEM_CAA_CRG_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_CRG_ID';
  C_ITEM_CRU_CONDITION constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CRU_CONDITION';
  C_ITEM_CAA_CAAT_ID constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_CAAT_ID';
  C_ITEM_CAA_CAAI_LIST constant adc_util.ora_name_type := C_PAGE_PREFIX || 'CAA_CAAI_LIST';
  C_ITEM_SELECTED_NODE constant adc_util.ora_name_type := C_PAGE_PREFIX || 'SELECTED_NODE';
  
  C_REGION_RULES constant adc_util.ora_name_type := C_REGION_PREFIX || 'RULES';
  C_REGION_HIERARCHY constant adc_util.ora_name_type := C_REGION_PREFIX || 'HIERARCHY';
  C_REGION_FINDINGS constant adc_util.ora_name_type := C_REGION_PREFIX || 'FINDINGS';
  C_REGION_HELP constant adc_util.ora_name_type := C_REGION_PREFIX || 'HELP';
  
  C_REGION_CRG_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CRG_FORM';
  C_REGION_CRU_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CRU_FORM';
  C_REGION_CRA_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CRA_FORM';
  C_REGION_CAA_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'CAA_FORM';
  C_REGION_FLS_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'FLS_FORM';
  C_REGION_FLOW_MODELER constant adc_util.ora_name_type := C_REGION_PREFIX || 'FLOW_MODELER';
  C_CENTRAL_TAB_REGION constant adc_util.ora_name_type := C_REGION_PREFIX || 'CENTRAL';
  C_TAB_RULES constant adc_util.ora_name_type := 'SR_' || C_REGION_PREFIX || 'RULES';
  C_TAB_WORKFLOWS constant adc_util.ora_name_type := 'SR_' || C_REGION_PREFIX || '_WORKFLOWS';
  
  
  /**
    Constants: Mode and Action constants
      C_MODE_CRG - Hierarchical level Rule Group
      C_MODE_CRU - Hierarchical level Rule
      C_MODE_CRA - Hierarchical level Rule Action
      C_MODE_CAG - Hierarchical level APEX Action Group (used as a hierarchy level only to group APEX Actions)
      C_MODE_CAA - Hierarchical level APEX Action
      C_MODE_FLG - Hierarchical level Workflow Group (used as a hierarchy level only to group Flows, if flows if installed)
      C_MODE_FLS - Hierarchical level Workflows (if flows is installed only)
      C_ACTION_CANCEL - APEX Action to cancel an operation
      C_ACTION_CREATE - APEX Action to create a record
      C_ACTION_DELETE - APEX Action to delete a record
      C_ACTION_UPDATE - APEX Action to update a record
      C_EXPORT_CRG - APEX Action to export a rule group
  */
  C_MODE_CRG constant adc_util.ora_name_type := 'CRG';
  C_MODE_CRU constant adc_util.ora_name_type := 'CRU';
  C_MODE_CRA constant adc_util.ora_name_type := 'CRA';
  C_MODE_CAG constant adc_util.ora_name_type := 'CAG';
  C_MODE_CAA constant adc_util.ora_name_type := 'CAA';
  C_MODE_FLG constant adc_util.ora_name_type := 'FLG';
  C_MODE_FLS constant adc_util.ora_name_type := 'FLS';
  C_COMMAND constant adc_util.ora_name_type := 'COMMAND';
  C_ACTION_SHOW constant adc_util.ora_name_type := 'show';
  C_ACTION_CANCEL constant adc_util.ora_name_type := 'cancel-action';
  C_ACTION_CREATE constant adc_util.ora_name_type := 'create-action';
  C_ACTION_DELETE constant adc_util.ora_name_type := 'delete-action';
  C_ACTION_UPDATE constant adc_util.ora_name_type := 'update-action';
  C_EXPORT_CRG constant adc_util.ora_name_type := 'export-rule-group';
  
  C_DESIGNER_ACTIONS constant char_table := char_table(C_ACTION_CANCEL, C_ACTION_CREATE, C_ACTION_DELETE, C_ACTION_UPDATE, C_EXPORT_CRG);
  
  
  /**
    Group: Type definitions
   */
  /**
    Type: environment_rec
      Record to hold information about the actual state of the ADC designer

    Properties:
      selected_node - ID value of the selected node from the hierarchy. Combination of target_mode and node_id
      target_mode - Type of the node (CRG, CRU, CRA or CAA and others) that controls what form is displayed if the
                    APEX Action is invoked
      action_mode - Type of the node (CRG, CRU, CRA or CAA and others) that controls on what form the actual
                    APEX Action is to be performed. If fi <C_ACTION_DELETE> is invoked, the delete must be processed
                    for mode identified by this attribute. If this is done, target_mode controls which form to display next.
      node_id - ID of the selected node as used in the data model. Normally, the ID is taken based from the mode.
                It is possible though that not all modes have a correlated ID, fi the APEX Action group (CAG) which will
                reference the Rule Group (CRG) ID instead.
      form_id - Static ID of the actually selected form
      crg_id - ID of the rule group the selecte node belongs to
      cru_id - ID of the rule the selecte node belongs to
      action - Name of the APEX action that triggered the event
      firing_item - ID of the item that fired the event,
      app_changed - Flag to indicate whether a different application was selected
      crg_changed - Flag to indicate whether a different dynamic page was selected
      cru_changed - Flag to indicate whether a different use case was selected
   */ 
  type environment_rec is record(
    selected_node adc_util.ora_name_type,
    target_mode adc_util.ora_name_type,
    action_mode adc_util.ora_name_type,
    node_id adc_rule_groups.crg_id%type,
    form_id adc_util.ora_name_type,
    crg_id adc_rule_groups.crg_id%type,
    cru_id adc_rules.cru_id%type,
    action adc_util.ora_name_type,
    firing_item adc_util.ora_name_type,
    app_changed boolean := false,
    crg_changed boolean := false,
    cru_changed boolean := false);
    
    
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
      g_form_item_list - PL/SQL table to hold a list of page items per supported form type (CRA, CRU, CAA etc.)
   */

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
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caai_list out nocopy char_table)
  as
  begin
    pit.enter_detailed('copy_apex_action');
    
    p_row.caa_id := utl_apex.get_number('caa_id');
    p_row.caa_crg_id := utl_apex.get_number('caa_crg_id');
    p_row.caa_caat_id := utl_apex.get_string('caa_caat_id');
    p_row.caa_name := utl_apex.get_string('caa_name');
    p_row.caa_confirm_message_name := utl_apex.get_string('caa_confirm_message_name');
    p_row.caa_label := utl_apex.get_string('caa_label');
    p_row.caa_context_label := utl_apex.get_string('caa_context_label');
    p_row.caa_icon := utl_apex.get_string('caa_icon');
    p_row.caa_icon_type := utl_apex.get_string('caa_icon_type');
    p_row.caa_title := utl_apex.get_string('caa_title');
    p_row.caa_shortcut := utl_apex.get_string('caa_shortcut');
    p_row.caa_initially_disabled := utl_apex.get_string('caa_initially_disabled');
    p_row.caa_initially_hidden := utl_apex.get_string('caa_initially_hidden');
    p_row.caa_href := utl_apex.get_string('caa_href');
    p_row.caa_action := utl_apex.get_string('caa_action');
    p_row.caa_on_label := utl_apex.get_string('caa_on_label');
    p_row.caa_off_label := utl_apex.get_string('caa_off_label');
    p_row.caa_get := utl_apex.get_string('caa_get');
    p_row.caa_set := utl_apex.get_string('caa_set');
    p_row.caa_choices := utl_apex.get_string('caa_choices');
    p_row.caa_label_classes := utl_apex.get_string('caa_label_classes');
    p_row.caa_label_start_classes := utl_apex.get_string('caa_label_start_classes');
    p_row.caa_label_end_classes := utl_apex.get_string('caa_label_end_classes');
    p_row.caa_item_wrap_class := utl_apex.get_string('caa_item_wrap_class');

    utl_text.string_to_table(utl_apex.get_string('caa_caai_list'), p_caai_list);

    pit.leave_detailed;
  end copy_apex_action;
  
  
  procedure copy_rule(
    p_row in out nocopy adc_rules%rowtype,
    p_crg_id adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('copy_rule');

    p_row.cru_id := utl_apex.get_number('cru_id');
    p_row.cru_crg_id := coalesce(utl_apex.get_number('cru_crg_id'), p_crg_id);
    p_row.cru_sort_seq := utl_apex.get_number('cru_sort_seq');
    p_row.cru_name := utl_apex.get_string('cru_name');
    p_row.cru_condition := utl_apex.get_string('cru_condition');
    p_row.cru_fire_on_page_load := utl_apex.get_string('cru_fire_on_page_load');
    p_row.cru_active := utl_apex.get_string('cru_active');

    pit.leave_detailed;
  end copy_rule;


  procedure copy_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype,
    p_cra_crg_id adc_rule_actions.cra_crg_id%type)
  as
    l_param_name_1 adc_util.ora_name_type;
    l_param_name_2 adc_util.ora_name_type;
    l_param_name_3 adc_util.ora_name_type;
  begin
    pit.enter_detailed('copy_rule_action');

    p_row.cra_id := utl_apex.get_number('cra_id');
    p_row.cra_crg_id := coalesce(utl_apex.get_number('cra_crg_id'), p_cra_crg_id);
    p_row.cra_cru_id := utl_apex.get_number('cra_cru_id');
    p_row.cra_sort_seq := utl_apex.get_number('cra_sort_seq');
    p_row.cra_cpi_id := utl_apex.get_string('cra_cpi_id');
    p_row.cra_cat_id := utl_apex.get_string('cra_cat_id');
    p_row.cra_active := utl_apex.get_string('cra_active');
    p_row.cra_on_error := utl_apex.get_string('cra_on_error');
    p_row.cra_raise_recursive := utl_apex.get_string('cra_raise_recursive');
    p_row.cra_raise_on_validation := utl_apex.get_string('cra_raise_on_validation');
    p_row.cra_comment := utl_apex.get_string('cra_comment');

    -- Get the required parameter field
    begin
      with data as (
           select cap_cat_id, cap_sort_seq, 
                  'CRA_PARAM_' || capvt_param_item_extension || cap_sort_seq item_name
             from adc_action_parameters
             join adc_action_param_types
               on cap_capt_id = capt_id
             join adc_action_param_visual_types
               on capt_capvt_id = capvt_id)
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

    p_row.cra_param_1 := case when l_param_name_1 is not null then utl_apex.get_string(l_param_name_1) end;
    p_row.cra_param_2 := case when l_param_name_2 is not null then utl_apex.get_string(l_param_name_2) end;
    p_row.cra_param_3 := case when l_param_name_3 is not null then utl_apex.get_string(l_param_name_3) end;    

    pit.leave_detailed;
  end copy_rule_action;
  
  
  $IF adc_util.C_WITH_FLOWS $THEN
  procedure copy_flow(
    p_row in out nocopy fls_diagrams_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_rule');

    p_row.diagram_id := utl_apex.get_number('diagram_id');
    p_row.diagram_name := utl_apex.get_string('diagram_name');
    p_row.diagram_version := utl_apex.get_string('diagram_version');
    p_row.diagram_status_id := utl_apex.get_string('diagram_status_id');
    p_row.diagram_category := utl_apex.get_string('diagram_category');

    pit.leave_detailed;
  end copy_flow;
  $END
  

  /**
    Group: Private Methods
   */  
  /**
    Function: get_form_items
      Method to retrieve a list of items for a given form
      
    Parameter:
      p_form_id - ID of the form for which to get the item list for.
  
    Returns:
      List of items for the requested form, empty array string if the form does not exist
   */
  function get_form_items(
    p_form_id in adca_bl_designer_actions.amda_form_id%type)
    return varchar2
  as
    l_item_list adc_util.sql_char;
  begin
    pit.enter_detailed('get_form_items',
      p_params => msg_params(msg_param('p_form_id', p_form_id)));
      
    if g_form_item_list.exists(p_form_id) then 
      l_item_list := g_form_item_list(p_form_id);
    else
        l_item_list := '[]';
    end if;
    
    pit.leave_detailed;
    return l_item_list;
  end get_form_items;
  
  
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
    p_row in adca_bl_designer_actions%rowtype)
  return varchar2
  as
    /**
      Constant: assemble_action.C_ACTION_TEMPLATE
        Method private code template for the action attribute.
        
        The template holds relevant information that is accessible by the package
        upon action execution via the <adc.get_event_data> method. It's structure is as follows:
        
        --- JavaScript
        de.condes.plugin.adc.actions.executeCommand({
          "command":"Name of the APEX action",
          "targetMode":"Mode to which the code traverses if the action is executed",
          "actionMode":"Mode to which APEX action refers to",
          "id":"ID of the target mode entry",
          "additionalPageItems": [Array of page items which are required during processing],
          "monitorChanges":Flag to indicate whether it is required to check for changes prior to invoking the action});
        ---
     */
    C_DATA_TEMPLATE constant adc_util.max_char := 
      '{"command":"#COMMAND#","targetMode":"#TARGET_MODE#","actionMode":"#ACTION_MODE#","id":"#NODE_ID#","additionalPageItems":#PAGE_ITEM_LIST#,"monitorChanges":#MONITOR_CHANGES#}';
    C_ACTION_TEMPLATE constant adc_util.max_char := 'de.condes.plugin.adc.actions.executeCommand(#DATA#);';
    C_CONFIRM_TEMPLATE constant adc_util.max_char := 'de.condes.plugin.adc.actions.confirmCommand("#CONFIRM_MESSAGE#", #DATA#);';
    l_action adc_util.max_char;
    l_target_mode adc_util.ora_name_type;
    l_action_mode adc_util.ora_name_type;
    l_node_id adc_util.ora_name_type;
    l_page_items adc_util.max_char := '[]';
    l_monitor_changes adc_util.ora_name_type;
    l_template adc_util.max_char;
  begin
    pit.enter_detailed('assemble_action',
      p_params => msg_params(
                    msg_param('p_action', p_action)));

    -- Initialize
    l_template := C_ACTION_TEMPLATE;
    l_monitor_changes := 'false';

    -- calculate page_item values, modes and id based on action type
    case p_action
      when C_ACTION_CREATE then
        l_monitor_changes := 'true';
        l_page_items := get_form_items(p_row.amda_form_id);
        l_target_mode := p_row.amda_create_target_mode;
        l_node_id := null;
      when C_ACTION_UPDATE then
        l_page_items := get_form_items(p_row.amda_form_id);
        l_target_mode := p_row.amda_update_target_mode;
        l_node_id := p_row.amda_update_value;
      when C_ACTION_DELETE then
        l_template := C_CONFIRM_TEMPLATE;
        l_target_mode := p_row.amda_delete_target_mode;
        l_action_mode := p_row.amda_delete_mode;
        l_node_id := p_row.amda_delete_value;
      when C_ACTION_CANCEL then
        l_monitor_changes := 'true';
        l_target_mode := p_row.amda_cancel_target_mode;
        l_node_id := p_row.amda_cancel_value;
      else
        l_target_mode := p_row.amda_actual_mode;
        l_node_id := p_row.amda_id_value;
    end case;

    -- assemble
    l_template:= replace(l_template,
                  'CONFIRM_MESSAGE', p_row.amda_delete_confirm_message);
    l_action := utl_text.bulk_replace(C_DATA_TEMPLATE, char_table(
                  'COMMAND', p_action,
                  'PAGE_ITEM_LIST', l_page_items,
                  'TARGET_MODE', l_target_mode,
                  'ACTION_MODE', l_action_mode,
                  'NODE_ID', l_node_id,
                  'MONITOR_CHANGES', l_monitor_changes));
    l_action := replace(replace(l_template, 
                  '#DATA#', l_action),
                  '#CONFIRM_MESSAGE#', p_row.amda_delete_confirm_message);

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
    p_crg_id in adc_rule_groups.crg_id%type)
    return number
  as
    l_cru_sort_seq adc_rules.cru_sort_seq%type;
  begin
    pit.enter_optional('get_cru_sort_seq',
      p_params => msg_params(
                    msg_param('p_crg_id', p_crg_id)));

    select coalesce(max(trunc(cru_sort_seq, -1)) + 10, 10)
      into l_cru_sort_seq
      from adc_rules
     where cru_crg_id = p_crg_id;

    pit.leave_optional(
      p_params => msg_params(msg_param('SortSequence', l_cru_sort_seq)));
    return l_cru_sort_seq;
  end get_cru_sort_seq;


  /**
    Function: get_first_crg_for_app
      Method retrieves the CRG_ID for the first page that is maintained by ADC
      
    Returns: CRG_ID of the first ADC maintained page, ordered by page number.
             If no page exists or no application selected, NULL is returned.
   */
  function get_first_crg_for_app
    return adc_rule_groups.crg_id%type
  as
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_crg_id adc_rule_groups.crg_id%type;
  begin
    pit.enter_optional('get_first_crg_for_app');
    
    l_crg_app_id := adc.get_number(C_ITEM_CRG_APP_ID);
    
    select crg_id
      into l_crg_id
      from adc_rule_groups
     where crg_app_id = l_crg_app_id
     order by crg_page_id
     fetch first 1 row only;
     
    pit.leave_optional(p_params => msg_params(msg_param('CRG', l_crg_id)));
    return l_crg_id;
  exception
    when NO_DATA_FOUND then
      pit.leave_optional;
      return null;
  end get_first_crg_for_app;
  
  
  /**
    Function: get_parameter_type
      Retrieves the type for a given parameter
      
    Parameters:
      p_cat_id - Action type
      p_param_index - Index of the parameter within the action type
      
    Returns:
      Type of the parameter.
   */
  function get_parameter_type(
    p_cap_cat_id IN adc_action_parameters_v.cap_cat_id%type, 
    p_cap_sort_seq IN adc_action_parameters_v.cap_sort_seq%type)
    return adc_action_param_types_v.capt_id%type
  as
    l_capt_id adc_action_parameters_v.cap_capt_id%type;
  begin
    pit.enter_detailed('get_parameter_type',
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id),
                    msg_param('p_cap_sort_seq', p_cap_sort_seq)));
      
    select cap_capt_id
      into l_capt_id
      from adc_action_parameters_v
     where cap_cat_id = p_cap_cat_id
       and cap_sort_seq = p_cap_sort_seq;
       
    pit.leave_detailed(
      p_params => msg_params(msg_param('capt_id', l_capt_id)));
    return l_capt_id;
  end get_parameter_type;
  
  
  /**
    Procedure: set_crg_and_cru_id
      Method to retrieve the selected CRG_ID and CRU_ID from the page state and add it to the environment
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure set_crg_and_cru_id(
    p_environment in out nocopy environment_rec)
  as
    l_crg_id adc_rule_groups.crg_id%type;
    l_cru_id adc_rules.cru_id%type;
  begin
    pit.enter_optional('set_crg_and_cru_id');
    
    p_environment.crg_id := p_environment.node_id;
    
    if p_environment.crg_id is not null then
      case p_environment.target_mode
        when C_MODE_CAA then
          -- APEX actions are not bound to a CRU
          select caa_crg_id
            into p_environment.crg_id
            from adc_apex_actions
           where caa_id = p_environment.node_id;
        when C_MODE_CRU then
          select cru_crg_id, cru_id
            into p_environment.crg_id, p_environment.cru_id
            from adc_rules
           where cru_id = p_environment.node_id;
          -- Persist CRU in CRA to prepare creation of new CRA
          adc.set_item(
            p_cpi_id => C_ITEM_CRA_CRU_ID,
            p_item_value => p_environment.cru_id);
        when C_MODE_CRA then
          select cra_crg_id, cra_cru_id
            into p_environment.crg_id, p_environment.cru_id
            from adc_rule_actions
           where cra_id = p_environment.node_id;
          adc.set_item(
            p_cpi_id => C_ITEM_CRU_ID,
            p_item_value => p_environment.cru_id);
        else
          null;
      end case;
      
      -- Detect changes
      l_crg_id := coalesce(adc.get_number(C_ITEM_CRG_ID), 0);
      l_cru_id := coalesce(adc.get_number(C_ITEM_CRU_ID), 0);
      p_environment.crg_changed := l_crg_id != coalesce(p_environment.crg_id, 0);
      p_environment.cru_changed := l_cru_id != coalesce(p_environment.cru_id, 0);
      
      if p_environment.crg_changed then
        -- Make sure that the rule group is based on actual application data
        adc_admin.propagate_rule_change(p_environment.crg_id);
      end if;
    else
      adc.set_item(
        p_cpi_id => C_ITEM_CRG_ID,
        p_item_value => null);
      adc.set_item(
        p_cpi_id => C_ITEM_SELECTED_NODE,
        p_item_value => null);
    end if;
    
    pit.leave_optional;
  end set_crg_and_cru_id;
  
  
  /**
    Procedure: set_id_values
      Maintains the session state of CRG_ID and others based on the environment.
      
      IDs can change as a consequence of two use cases only:
      
      - A row in the hierarchy or the rule report is selected
      - A new tupel is generated.
      
      This method deals with the first use case. In this use case, the ID of the
      selected node is passed in in the form <mode>_<id>, fi CRA_1234 for a Rule Action.
      This method performs these tasks with this information:
      
      - It sets the ID of page item CRA_ID to the value 1234
      - It retrieves the related CRG_ID and compares it to the actually set CRG_ID.
        Should they differ, the new CRG_ID is set and a refresh of the Rule Report
        is requested.
      - It retrieves the related CRU_ID and compares it to the actually set CRU_ID.
        Should they differ, the new CRU_ID is set and selected at the respective report,
        fi on the RULES report if the firing item is HIERARCHY and vice versa
        
      If a new tupel is created, the ID is set there after succesful creation.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure set_id_values(
    p_environment in out nocopy environment_rec)
  as
  begin
    pit.enter_optional('set_id_values');
    
    set_crg_and_cru_id(p_environment);
    
    -- Compare CRG_ID with session state. If changed, refresh rule report
    if p_environment.crg_changed then
      if p_environment.target_mode in (C_MODE_FLG, C_MODE_FLS) then
        -- Workflow modes
        adc.set_item(
          p_cpi_id => C_ITEM_DIAGRAM_ID,
          p_item_value => p_environment.node_id);
        adc.refresh_item(
          p_cpi_id => C_REGION_FINDINGS);
      else
        -- control page
        adc.set_item(
          p_cpi_id => C_ITEM_CRG_ID,
          p_item_value => p_environment.crg_id);
        adc.set_item(
          p_cpi_id => C_ITEM_CRU_CRG_ID,
          p_item_value => p_environment.crg_id);
        adc.set_item(
          p_cpi_id => C_ITEM_CRA_CRG_ID,
          p_item_value => p_environment.crg_id);
        adc.set_item(
          p_cpi_id => C_ITEM_CAA_CRG_ID,
          p_item_value => p_environment.crg_id);
      end if;
    end if;
    
    -- Set ID of the selected mode if not CRG and set SELECTD_NODE to enable the tree to remember its state
    case 
      when p_environment.target_mode = C_MODE_FLS then
        adc.set_item(
          p_cpi_id => C_ITEM_DIAGRAM_ID,
          p_item_value => p_environment.node_id);
      when p_environment.target_mode != C_MODE_CRG then
        adc.set_item(
          p_cpi_id => C_PAGE_PREFIX || p_environment.target_mode || '_ID',
          p_item_value => p_environment.node_id);
      else
        null;
    end case;

    adc.set_item(
      p_cpi_id => C_ITEM_SELECTED_NODE,
      p_item_value => p_environment.selected_node);
      
    pit.leave_optional;
  end set_id_values;


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

    select help_text help_text
      into l_help_text
      from adca_bl_cat_help
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

    -- Cursor collects the parameters, parameter settings
    -- their actual values (if the Rule Action is not newly created)
    -- or their default values
    cursor action_type_cur(
             p_cra_id in adc_rule_actions.cra_id%type,
             p_cat_id in adc_action_types.cat_id%type) is
      select cap_page_item, cap_sort_seq, cap_mandatory, cap_value,
             capt_id, capt_name, capt_capvt_id
        from adca_bl_cat_parameter_items
       where coalesce(cra_id, 0) = coalesce(p_cra_id, 0)
         and cat_id = p_cat_id
       order by cap_sort_seq;

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
      adc.set_item_label(
        p_cpi_id => param.cap_page_item, 
        p_item_label => param.capt_name);    

      -- First set items mandatory to avoid endless loops if a select list refreshes
      if param.cap_mandatory = adc_util.C_TRUE then
        adc.set_mandatory(
           p_cpi_id => param.cap_page_item,
           p_msg_text => replace(l_mandatory_message, '#LABEL#', param.capt_name));
      else
        adc.set_optional(
          p_cpi_id => param.cap_page_item);
        adc.set_visual_state(
          p_cpi_id => param.cap_page_item,
          p_visual_state => adc.C_SHOW_ENABLE);   
      end if;

     -- set values, if required after refresh
     if instr(param.capt_capvt_id, 'LIST') > 0 then
       -- any list type (LOV or CB) is based on a lov query, so set the name for that query
       adc.set_item(
         p_cpi_id => C_PAGE_PREFIX || 'CRA_LOV_PARAM_' || param.cap_sort_seq,
         p_item_value => param.capt_id);
       adc.refresh_item(
         p_cpi_id => param.cap_page_item, 
         p_item_value => param.cap_value);
     else
       adc.set_item(
         p_cpi_id => param.cap_page_item,
         p_item_value => param.cap_value,
         p_allow_recursion => adc_util.C_FALSE);
     end if;

    end loop;

    pit.leave_optional;
  end set_cra_param_settings;


  /**
    Procedure: read_environment
      Method to retrieve the actual state of the ADC designer.
      
      This procedure analyses the data attribute of the APEX Action invoked by the user.
      Based on this information, respective values are copied into <l_environment>.
      
      A second use case is that this method is called based on a selection of a row
      in the hierarchy tree or rule report. In this case, the data attribute only contains
      the ID of the selected row, which is composed of the mode and the id of the
      respective tupel. A selected Rule will therefore pass in something like CRU_123.
      
      Based on this information, the required attributes are filled:
      
      - action and target mode,
      - id of the active entry
      - static ID of the form to show
      - CRG_ID of the rule group containing the selected entry.
      
      If the CRG_ID has changed, this method also emits JavaScript code to refresh
      the rule report region.
   */
  function read_environment
    return environment_rec
  as
    l_environment environment_rec;
    l_cra_id adc_rule_actions.cra_id%type;
  begin
    pit.enter_optional('read_environment');
    
    l_environment.firing_item := adc.get_firing_item;
    case l_environment.firing_item 
      when C_ITEM_CRG_APP_ID then
        -- Application selection changed, return to initial state
        l_environment.crg_id := get_first_crg_for_app;
        l_environment.selected_node := case when l_environment.crg_id is not null then C_MODE_CRG || '_' || l_environment.crg_id end;
        l_environment.target_mode := C_MODE_CRG;
        l_environment.node_id := l_environment.crg_id;
        l_environment.form_id := C_REGION_PREFIX || C_MODE_CRG || '_FORM';
        l_environment.action := C_ACTION_SHOW;
        l_environment.app_changed := true;
        -- Harmonize with page state
        set_id_values(l_environment);
      when C_ITEM_CRA_CAT_ID then
        l_cra_id := adc.get_number(C_ITEM_CRA_ID);
        l_environment.crg_id := adc.get_number(C_ITEM_CRG_ID);
        l_environment.action := null;
      when C_ITEM_CRU_CONDITION then
        l_environment.crg_id := adc.get_number(C_ITEM_CRG_ID);
      when C_COMMAND then
        -- APEX Action has called the method. Event data is JSON, so extract attributes
        l_environment.crg_id := adc.get_number(C_ITEM_CRG_ID);
        l_environment.target_mode := adc.get_event_data('targetMode');
        l_environment.action_mode := coalesce(adc.get_event_data('actionMode'), adc.get_event_data('targetMode'));
        l_environment.node_id := to_number(adc.get_event_data('id'));
        l_environment.selected_node := l_environment.target_mode || '_' || l_environment.node_id;
        l_environment.form_id := C_REGION_PREFIX || l_environment.target_mode || '_FORM';
        l_environment.action := adc.get_event_data('command');
      else
        -- Method was called due to a changed selection in hierarchy or rule report. ID is passed in directly
        l_environment.selected_node := adc.get_event_data;
        l_environment.target_mode := substr(l_environment.selected_node, 1, 3);
        l_environment.node_id := to_number(substr(l_environment.selected_node, 5), 'fm99999990');
        l_environment.form_id := C_REGION_PREFIX || l_environment.target_mode || '_FORM';
        l_environment.action := C_ACTION_SHOW;
        -- Harmonize with page state
        set_id_values(l_environment);
    end case;

    pit.log_state(msg_params(
      msg_param('selected_node', l_environment.selected_node),
      msg_param('target_mode', l_environment.target_mode),
      msg_param('action_mode', l_environment.action_mode),
      msg_param('node_id', l_environment.node_id),
      msg_param('form_id', l_environment.form_id),
      msg_param('crg_id', l_environment.crg_id),
      msg_param('cru_id', l_environment.cru_id),
      msg_param('action', l_environment.action),
      msg_param('firing_item', l_environment.firing_item)));

    pit.leave_optional;
    return l_environment;
  end read_environment;
  
  
  /**
    Procedure: maintain_action
      Method to update aspects of an action and include the required Javascript to the response
      
    Parameters:
      p_name - Name of the action
      p_label - Label of the action
      p_active - Flag to indicate whether the action is active or nor
      p_action - If the action is active, this action is executed
   */
  procedure maintain_action(
    p_name in adc_apex_actions_v.caa_name%type,
    p_label in adc_apex_actions_v.caa_label%type default null,
    p_active in adc_util.flag_type,
    p_action in adc_util.sql_char)
  as
    l_disabled boolean;
  begin
    pit.enter_detailed('maintain_action',
      p_params => msg_params(
                    msg_param('p_name', p_name),
                    msg_param('p_label', p_label),
                    msg_param('p_active', p_active),
                    msg_param('p_action', p_action)));
                    
    l_disabled := p_active = adc_util.C_FALSE;
    adc_apex_action.action_init(p_name);
    if p_label is not null then
      adc_apex_action.set_label(p_label);
      adc_apex_action.set_title(p_label);
    end if;
    adc_apex_action.set_disabled(l_disabled);
    adc_apex_action.set_action(p_action);
    adc.add_javascript(adc_apex_action.get_action_script);
    
    pit.leave_detailed;
  end maintain_action;
  
  
  /**
    Procedure: disable_actions
      Method to disable all page commands. Is called if no application is selected.
   */
  procedure disable_actions
  as
  begin
    pit.enter_detailed('disable_action');
    
    for i in 1 .. C_DESIGNER_ACTIONS.count loop
      adc_apex_action.action_init(C_DESIGNER_ACTIONS(i));
      if C_DESIGNER_ACTIONS(i) in (C_ACTION_CREATE, C_ACTION_DELETE) then
        adc_apex_action.set_label(null);
      end if;
      adc_apex_action.set_disabled(true);
      adc.add_javascript(adc_apex_action.get_action_script);
    end loop;
    
    pit.leave_detailed;
  end disable_actions;
  
  
  /**
    Procedure: maintain_export_action
      Method to set the export action afteer the application has changed.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure maintain_export_action(
    p_environment environment_rec)
  as
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_javascript adc_util.max_char;
  begin
    pit.enter_detailed('maintain_export_action');
    
    if p_environment.app_changed then
      select crg_app_id
        into l_crg_app_id
        from adc_rule_groups
       where crg_id = p_environment.crg_id;
      
      if p_environment.target_mode in ('FLG', 'FLS') then
        -- TODO: Decide whether to add code to export workflows
        null;
      else
        l_javascript := utl_apex.get_page_url(
                          p_page => C_EXPORT_PAGE,
                          p_param_items => C_EXPORT_PAGE_PREFIX || 'CRG_APP_ID',
                          p_value_list => l_crg_app_id,
                          p_triggering_element => C_BUTTON_PREFIX || C_EXPORT_PAGE);
        maintain_action(
          p_name => C_EXPORT_CRG,
          p_active => adc_util.C_TRUE,
          p_action => l_javascript);
      end if;
      adc.add_javascript(adc_apex_action.get_action_script);
    end if;
    
    pit.leave_detailed;
  exception
    when NO_DATA_FOUND then
      adc_apex_action.action_init(C_EXPORT_CRG);
      adc_apex_action.set_disabled(true);
      adc.add_javascript(adc_apex_action.get_action_script);
  end maintain_export_action;


  /**
    Procedure: maintain_dml_actions
      Method to calculate the visible status and action parameter of the APEX Actions.
      
      Based on the type and mode of the APEX Action called, this methods calculates
      the correct visible status, the label and the action properties of the APEX Actions.
      
      The decision is based on the outcome of the decision table query in <handle_activity>.
      The attributes of the selected row control the outcome of this method.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure maintain_dml_actions(
    p_row in adca_bl_designer_actions%rowtype)
  as
    l_disabled boolean;
    l_javascript adc_util.max_char;
    l_crg_app_id adc_rule_groups.crg_app_id%type;
  begin
    pit.enter_optional('maintain_dml_actions',
      p_params => msg_params(msg_param('Action', p_row.amda_comment)));
    
    -- Adjust action based on outcome of the decision table
    -- CANCEL-Button
    maintain_action(
      p_name => C_ACTION_CANCEL,
      p_label => pit.get_trans_item_name(C_PTI_PMG, 'CANCEL_BUTTON'),
      p_active => p_row.amda_cancel_button_active,
      p_action => assemble_action(C_ACTION_CANCEL, p_row));

    -- CREATE button
    maintain_action(
      p_name => C_ACTION_CREATE,
      p_label => p_row.amda_create_button_label,
      p_active => p_row.amda_create_button_visible,
      p_action => assemble_action(C_ACTION_CREATE, p_row));

    -- UPDATE button
    maintain_action(
      p_name => C_ACTION_UPDATE,
      p_label => p_row.amda_update_button_label,
      p_active => p_row.amda_update_button_visible,
      p_action => assemble_action(C_ACTION_UPDATE, p_row));

    -- DELETE button
    maintain_action(
      p_name => C_ACTION_DELETE,
      p_label => p_row.amda_delete_button_label,
      p_active => p_row.amda_delete_button_visible,
      p_action => assemble_action(C_ACTION_DELETE, p_row));

    pit.leave_optional;
  end maintain_dml_actions;


  /** 
    Procedure: show_form_caa
      Method to show and populate a ADC Apex Action form of the designer and populate it with the values selected.
      
      Two modes:
      
      - APEX Action already exists. Initialize form based on stored values
      - APEX Action is created. Initialize form with default values
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure show_form_caa(
    p_environment in environment_rec)
  as
    l_statement adc_util.max_char := q'^
select null #PRE#caa_id, '#CRG_ID#' #PRE#caa_crg_id, 'ACTION' #PRE#caa_caat_id, null #PRE#caa_name,
       null #PRE#caa_label, null #PRE#caa_context_label, null #PRE#caa_icon, 'fa' #PRE#caa_icon_type,
       null #PRE#caa_shortcut, adc_util.C_FALSE #PRE#caa_initially_disabled, adc_util.C_FALSE #PRE#caa_initially_hidden,
       null #PRE#caa_href, null #PRE#caa_action, null #PRE#caa_on_label, null #PRE#caa_off_label,
       null #PRE#caa_get, null #PRE#caa_set, null #PRE#caa_choices, 
       null #PRE#caa_label_classes, null #PRE#caa_label_start_classes,
       null #PRE#caa_label_end_classes, null #PRE#caa_item_wrap_class, null #PRE#caa_caai_list
  from dual^';
  begin
    pit.enter_mandatory('show_form_caa');

    if p_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CAA, initialize default values
      l_statement := replace(
                       replace(l_statement, '#CRG_ID#', p_environment.crg_id), 
                       '#PRE#', C_PAGE_PREFIX);
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
    adc.show_hide_item('.adc-caa-' || lower(adc.get_string(C_ITEM_CAA_CAAT_ID)), '.adc-caa-hide');
    adc.refresh_item(
      p_cpi_id => C_ITEM_CAA_CAAI_LIST, 
      p_item_value => utl_apex.get_string(C_ITEM_CAA_CAAI_LIST));
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CAA_HELP'));

    adc.select_tab(C_CENTRAL_TAB_REGION, C_TAB_RULES);
    
    pit.leave_mandatory;
  end show_form_caa;


  /** 
    Procedure: show_form_crg
      Method to show and populate an ADC Rule Group form of the designer and populate it with the values selected.
   */
  procedure show_form_crg
  as
  begin
    pit.enter_mandatory('show_form_crg');

    adc.refresh_item(C_REGION_CRG_FORM);
    adc.show_hide_item('.adc-rule-group', '.adc-hide');
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CRG_HELP'));

    pit.leave_mandatory;
  end show_form_crg;
  
  
  /** 
    Procedure: show_form_cra
      Method to show and populate a ADC Rule Action form of the designer and populate it with the values selected.
      
      The method distinguishes between different scenarios:
      
      - Show an already existing Rule Action
      - Create a new Rule Action
      - Update an already visible Rule Action after changing its action type
      
      Based on this decision, the form is populated with the existing data or with a set
      of default data required for this method.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure show_form_cra(
    p_environment in environment_rec)
  as
    l_cra_id adc_rule_actions.cra_id%type;
    l_cru_id adc_rules.cru_id%type;
    l_cat_id adc_action_types.cat_id%type;
    l_caif_default adc_action_item_focus.caif_default%type;
    l_statement adc_util.max_char := q'^
select null #PRE#CRA_ID, '#CRG_ID#' #PRE#CRA_CRG_ID, '#CRU_ID#' #PRE#CRA_CRU_ID,
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
    case when p_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CRA, initialize default values
      l_cru_id := adc.get_number(C_ITEM_CRU_ID);
      utl_text.bulk_replace(l_statement, char_table(
        'PRE', C_PAGE_PREFIX,
        'CRG_ID', p_environment.crg_id,
        'CRU_ID', l_cru_id,
        'NO_FIRING_ITEM', adc_util.c_no_firing_item,
        'SORT_SEQ', get_cra_sort_seq(l_cru_id)));
      adc.set_items_from_statement(
        p_cpi_id => adc_util.c_no_firing_item, 
        p_statement => l_statement);    
    when p_environment.action = C_ACTION_SHOW then
      -- Was called from the hierarchy tree
      adc.initialize_form_region(C_REGION_CRA_FORM);
    else
      -- was called by changing the action type. Only control display state
      null;
    end case;

    -- Control visibility
    adc.show_hide_item('.adc-rule-action', '.adc-hide');
      
    -- Read ID values to adjust display settings
    l_cra_id := adc.get_number(C_ITEM_CRA_ID);
    l_cat_id := adc.get_string(C_ITEM_CRA_CAT_ID); 

    -- Filter CAT list
    adc.refresh_item(
      p_cpi_id => C_ITEM_CRA_CAT_ID,
      p_item_value => l_cat_id);

    -- Adjust form for CAT if present
    if l_cat_id is not null then
      select coalesce(cra_cpi_id, caif_default)
        into l_caif_default
        from adc_action_types
        join adc_action_item_focus
          on cat_caif_id = caif_id
        left join (
             select *
               from adc_rule_actions
             where cra_id = l_cra_id)
          on cat_id = cra_cat_id
       where cat_id = l_cat_id;

      adc.refresh_item(
        p_cpi_id => C_ITEM_CRA_CPI_ID,
        p_item_value => l_caif_default);
    end if;

    set_cra_param_settings(
      -- removing the CRA_ID when changing CAT avoids search for existing parameter values
      p_cra_id => case when p_environment.action is not null then l_cra_id end,
      p_cat_id => l_cat_id);

    set_cat_help_text(
      p_cat_id => l_cat_id);

    adc.select_tab(C_CENTRAL_TAB_REGION, C_TAB_RULES);

    pit.leave_mandatory;
  end show_form_cra;
  
  
  /** 
    Procedure: show_form_cru
      Method to show and populate a ADC Rule form of the designer and populate it with the values selected.
      
      Two modes:
      
      - Rule already exists. Initialize form based on stored values
      - Rule is created. Initialize form with default values
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure show_form_cru(
    p_environment in environment_rec)
  as
    l_statement adc_util.max_char := q'^
select null #PRE#CRU_ID, '#CRG_ID#' #PRE#CRU_CRG_ID, '#SORT_SEQ#' #PRE#CRU_SORT_SEQ,
       null #PRE#CRU_NAME, null #PRE#CRU_CONDITION,
       adc_util.C_TRUE #PRE#CRU_ACTIVE, adc_util.C_FALSE #PRE#CRU_FIRE_ON_PAGE_LOAD
  from dual
    ^';
  begin
    pit.enter_mandatory('show_form_cru');

    case when p_environment.action = C_ACTION_CREATE then
      -- Was called to create a new CRU, initialize default values
      utl_text.bulk_replace(l_statement, char_table(
        'PRE', C_PAGE_PREFIX,
        'CRG_ID', p_environment.crg_id,
        'SORT_SEQ', get_cru_sort_seq(p_environment.crg_id)));
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

    adc.select_tab(C_CENTRAL_TAB_REGION, C_TAB_RULES);

    pit.leave_mandatory;
  end show_form_cru;
  
  
  /** 
    Procedure: show_form_fls
      Method to show and populate a workflow form of the designer and populate it with the values selected.
      
      This form is rendered only if FLOWS is installed and flag <ADC_UTIL.C_WITH_FLOWS> is set to TRUE.
   */
  procedure show_form_fls
  as
    l_statement adc_util.max_char := q'^
select null #PRE#DIAGRAM_ID, null #PRE#DIAGRAM_NAME, '0' #PRE#DIAGRAM_VERSION, 'draft' #PRE#DIAGRAM_STATUS_ID
  from dual^';
  begin
    pit.enter_mandatory('show_form_fls');

    $IF adc_util.C_WITH_FLOWS $THEN
    case when l_environment.action = C_ACTION_CREATE then
      -- Was called to create a new FLS, initialize default values
      l_statement := replace(l_statement, '#PRE#', C_PAGE_PREFIX);
      adc.set_items_from_statement(
        p_cpi_id => adc_util.c_no_firing_item, 
        p_statement => l_statement);
    else
      -- Was called from the rule report
      adc.initialize_form_region(C_REGION_FLS_FORM);
    end case;

    adc.show_hide_item('.adc-flows', '.adc-hide');
    adc.set_region_content(
      p_region_id => C_REGION_HELP,
      p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'FLS_HELP'));
    if l_environment.node_id is not null then
      adc.refresh_item(
        p_cpi_id => C_REGION_FLOW_MODELER);
    end if;

    adc.select_tab(C_CENTRAL_TAB_REGION, C_TAB_WORKFLOWS);
    $END

    pit.leave_mandatory;
  end show_form_fls;


  /** 
    Function: validate_page
      Method to validate the user input against the business rules for the different designer areas.
      
      Based on the mode of the APEX Action (see <C_MODE_CREATE> etc.) a decision is taken whether
      
      - a validation method is required
      - which validation method to call.
      
      Validation methods are implemented in package <ADC_ADMIN> and throw errors. If an error is thrown,
      this will prevent further execution of the page.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure validate_page(
    p_environment in environment_rec)
  as
    l_apex_row adc_apex_actions_v%rowtype;
    l_rule_row adc_rules%rowtype;
    l_action_row adc_rule_actions%rowtype;
    $IF adc_util.C_WITH_FLOWS $THEN
    l_flow_row fls_diagrams_v%rowtype;
    $END
    l_caai_list char_table;
  begin
    pit.enter_mandatory;

    case p_environment.action_mode
      when C_MODE_CRU then
        copy_rule(l_rule_row, p_environment.crg_id);
        pit.start_message_collection;
        adc_admin.validate_rule(l_rule_row);
        pit.stop_message_collection;
      when C_MODE_CRA then
        copy_rule_action(l_action_row, p_environment.crg_id);
        pit.start_message_collection;
        adc_admin.validate_rule_action(l_action_row);
        pit.stop_message_collection;
      when C_MODE_CAA then
        copy_apex_action(l_apex_row, l_caai_list);
        pit.start_message_collection;
        adc_admin.validate_apex_action(l_apex_row);
        pit.stop_message_collection;
      else
        null;
    end case;

    pit.leave_mandatory;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      adc.handle_bulk_errors(char_table(
        -- CRU
        'ADC_INVALID_SQL', 'CRU_CONDITION',
        'CRU_CONDITION_MISSING', 'CRU_CONDITION',
        'CRU_CRG_ID_MISSING', 'CRU_CRG_ID',
        'CRU_NAME_MISSING', 'CRU_NAME',
        -- CRA
        'CRA_CRU_ID_MISSING', 'CRA_CRU_ID',
        'CRA_CRG_ID_MISSING', 'CRA_CRG_ID',
        'CRA_CPI_ID_MISSING', 'CRA_CPI_ID',
        'CRA_CAT_ID_MISSING', 'CRA_CAT_ID'
        -- CAA TODO: CAA Mapping
        ));
  end validate_page;


  /** 
    Function: process_page
      Method to process the user input and persist the data at the database.
      
      Based on the mode of the APEX Action (such as CRG, CRU etc.) the method calls
      the respective XAPI methods implemented in package <ADC_ADMIN>. It also decides
      upon the method to call based on the command passed in.
   */
  procedure process_page(
    p_environment environment_rec)
  as
    l_crg_id adc_rule_groups.crg_id%type := adc.get_number(C_ITEM_CRG_ID);
    l_apex_row adc_apex_actions_v%rowtype;
    l_rule_group_row adc_rule_groups%rowtype;
    l_rule_row adc_rules%rowtype;
    $IF adc_util.C_WITH_FLOWS $THEN
    l_flow_row fls_diagrams_v%rowtype;
    $END
    l_action_row adc_rule_actions%rowtype;
    l_selected_id adc_util.ora_name_type;
    l_caai_list char_table;
  begin
    pit.enter_mandatory;
    
    case p_environment.action_mode
      when C_MODE_CRG then
        l_rule_group_row.crg_id := p_environment.crg_id;
      when C_MODE_CRU then
        copy_rule(l_rule_row, p_environment.crg_id);
      when C_MODE_CRA then
        copy_rule_action(l_action_row, p_environment.crg_id);
      when C_MODE_CAA then
        copy_apex_action(l_apex_row, l_caai_list);
      else
        null;
    end case;

    case p_environment.action 
      when C_ACTION_UPDATE then
        pit.info(msg.ADCA_ACTION_REQUESTED, msg_args(C_ACTION_UPDATE, p_environment.target_mode));
        case p_environment.target_mode
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
            adc_admin.merge_apex_action(l_apex_row, l_caai_list);
            adc.set_item(
              p_cpi_id => C_ITEM_CAA_ID,
              p_item_value => l_apex_row.caa_id);
            l_selected_id := C_MODE_CAA || '_' || l_apex_row.caa_id;
          $IF adc_util.C_WITH_FLOWS $THEN
          when C_MODE_FLS then
            fls_admin_api.merge_diagram(l_flow_row);
            adc.set_item(
              p_cpi_id => C_ITEM_DIAGRAM_ID,
              p_item_value => l_flow_row.diagram_id);
            adc.refresh_item(
              p_cpi_id => C_REGION_FLOW_MODELER);
          $END
          else
            null;
        end case;
        
        -- Transaction control, because the action is called via AJAX
        adc.show_success(msg.ADCA_CHANGES_SAVED);
        adc.set_item(
          p_cpi_id => C_ITEM_SELECTED_NODE,
          p_item_value => l_selected_id);
        commit;
      when C_ACTION_DELETE then
        pit.info(msg.ADCA_ACTION_REQUESTED, msg_args(C_ACTION_DELETE, p_environment.action_mode));
        case p_environment.action_mode
          when C_MODE_CRG then
            adc_admin.delete_rule_group(l_rule_group_row);
          when C_MODE_CRU then
            adc_admin.delete_rule(l_rule_row);
          when C_MODE_CRA then
            adc_admin.delete_rule_action(l_action_row);
          when C_MODE_CAA then
            adc_admin.delete_apex_action(l_apex_row);
          $IF adc_util.C_WITH_FLOWS $THEN
          when C_MODE_FLS then
            fls_admin_api.delete_diagram(
              p_diagram_id => l_flow_row.diagram_id,
              p_cascade => adc_util.C_TRUE);
          $END
          else
            null;
        end case;
        
        -- Transaction control, because the action is called via AJAX
        adc.set_item(
          p_cpi_id => C_ITEM_SELECTED_NODE,
          p_item_value => p_environment.selected_node);
        adc.show_success(msg.ADCA_DATA_DELETED);
        commit;
      else
        adc.register_error(
          p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
          p_message_name => msg.ADCA_UNKNOWN_ACTION,
          p_msg_args => msg_args(p_environment.action));
    end case;

    -- in any case, propagate rule change to reflect changes
    begin
      adc_admin.propagate_rule_change(l_crg_id);
    exception
      when others then
        -- ignore any errors here as these can occur if the page has changed
        -- and has made a rule group invalid. Display the errors instead.
        null;
    end;

    -- Refresh reports
    adc.refresh_item(
      p_cpi_id => C_REGION_HIERARCHY);

    adc.refresh_item(
      p_cpi_id => C_REGION_RULES);

    adc.refresh_item(
      p_cpi_id => C_REGION_FINDINGS);

    pit.leave_mandatory;
  end process_page;
  
  
  /**
    Procedure: handle_dml
      based on the requested action, this method controls any DML actions
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure handle_dml(
    p_environment in environment_rec)
  as
  begin
    pit.enter_optional('handle_dml');
    
    -- Execute DML if required
    case p_environment.action 
      when C_ACTION_UPDATE then
        validate_page(p_environment);
        process_page(p_environment);
      when C_ACTION_DELETE then
        process_page(p_environment);
      when C_ACTION_CANCEL then
        adc.remove_all_errors;
      else
        -- ignore
        null;
    end case;
    
    pit.leave_optional;
  end handle_dml;
  
  
  /**
    Procedure: maintain_visual_state
      Method to adjust actions and shows the required forms based on the decision table
      <ADC_BL_DESIGNER_ACTIONS>.
      
    Parameter:
      p_environment - Information about the status the designer is in
   */
  procedure maintain_visual_state(
    p_environment in environment_rec)
  as
    cursor page_state_cur(
      p_amda_actual_mode adca_map_designer_actions.amda_aldm_id%type,
      p_amda_actual_id adca_map_designer_actions.amda_alda_id%type) 
    is
      select *
        from adca_bl_designer_actions
       where amda_actual_mode = p_amda_actual_mode
         and amda_actual_id = p_amda_actual_id;

    l_target_region adc_util.ora_name_type;
  begin
    pit.enter_optional('maintain_visual_state');
      
    -- React on changes of the hierarchy
    case 
      when p_environment.app_changed then
        maintain_export_action(p_environment);
        adc.refresh_item(
          p_cpi_id => C_REGION_HIERARCHY,
          p_item_value => p_environment.selected_node);
        adc.refresh_item(
          p_cpi_id => C_REGION_RULES,
          p_item_value => p_environment.selected_node);
      when p_environment.crg_changed then
        adc.refresh_item(
          p_cpi_id => C_REGION_RULES, 
          p_item_value => p_environment.selected_node);
      when p_environment.cru_changed then      
        if p_environment.firing_item = C_REGION_RULES then
          l_target_region := C_REGION_HIERARCHY;
        else
          l_target_region := C_REGION_RULES;
        end if;
        adc.select_region_entry(
          p_region_id => l_target_region, 
          p_entry_id => p_environment.selected_node, 
          p_notify => adc_util.C_FALSE);
      else
        null;
    end case;
    
    -- Retrieve page state from decision table
    for page_state in page_state_cur(
                        p_amda_actual_mode => p_environment.target_mode, 
                        p_amda_actual_id => p_environment.action) 
    loop
      maintain_dml_actions(page_state);

      case page_state.amda_actual_mode
      when C_MODE_CRG then
        show_form_crg;
      when C_MODE_CAA then
        show_form_caa(p_environment);
      when C_MODE_CRU then
        show_form_cru(p_environment);
      when C_MODE_CRA then
        show_form_cra(p_environment);
      when C_MODE_FLS then
        show_form_fls;
      when C_MODE_CAG then
        adc.set_region_content(
          p_region_id => C_REGION_HELP,
          p_html_code => pit.get_trans_item_description(C_PTI_PMG, 'CAA_HELP'));
      else
        adc.show_hide_item('.adc-no-attributes', '.adc-hide');
        adc.set_region_content(C_REGION_HELP, null);
      end case;

      if page_state.amda_remember_page_state = adc_util.C_TRUE then
        adc_api.remember_page_state(
          p_cpi_id => adc_util.C_NO_FIRING_ITEM,
          p_page_items => get_form_items(page_state.amda_form_id));
      end if;
    end loop;
    
    pit.leave_optional;
  end maintain_visual_state;
  
  
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
             select /*+ no_merge */
                    utl_apex.get_application_id p_app_id,
                    utl_apex.get_page_id p_page_id
               from dual)
      select r.static_id form_id, '[' ||  listagg('"' || i.item_name || '"', ',') within group (order by item_name) || ']' item_list 
        from apex_application_page_items i
        join apex_application_page_regions r
          on i.data_source_region_id = r.region_id
        join params p
          on i.application_id = p_app_id
         and i.page_id = p_page_id
       group by r.static_id;
  begin
    -- Get the quasi constant page prefix for the export CRG page
    select 'P' || page_id || '_'
      into C_EXPORT_PAGE_PREFIX
      from apex_application_pages
     where application_id = (select utl_apex.get_application_id from dual)
       and page_alias = C_EXPORT_PAGE;
       
    -- Persist list of page items per form region to define which page items to load when processing a form dynamically
    for frm in form_item_cur loop
      g_form_item_list(frm.form_id) := frm.item_list;
    end loop;
  exception
    when NO_DATA_FOUND then
      null;
  end initialize;


  /* 
    Group: Public Methods
   */
  /** 
    Function: get_lov_sql
      See <ADCA_UI_DESIGNER.get_lov_sql>
   */
  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
  begin
    return adc_api.get_lov_sql(p_capt_id, p_crg_id);
  end get_lov_sql;
  

  /**
    Procedure: handle_activity
      See <ADCA_UI_DESIGNER.handle_activity>
   */
  procedure handle_activity
  as
    l_environment environment_rec;
  begin
    pit.enter_mandatory;

    l_environment := read_environment;

    if l_environment.crg_id is null then
      -- No application selected, reset visual state
      disable_actions;
      adc.show_hide_item('.adc-no-attributes', '.adc-hide');
      adc.set_region_content(C_REGION_HELP, null);
      adc.refresh_item(C_REGION_HIERARCHY);
      adc.refresh_item(C_REGION_RULES);
    else
      handle_dml(l_environment);
      maintain_visual_state(l_environment);
    end if;

    pit.leave_mandatory;
  end handle_activity;
  
  
  /** 
    Function: handle_cat_changed
      See <ADCA_UI_DESIGNER.handle_cat_changed>
   */
  procedure handle_cat_changed
  as
    l_environment environment_rec;
  begin
    pit.enter_mandatory;
    
    l_environment := read_environment;
    show_form_cra(l_environment);
    
    pit.leave_mandatory;
  end handle_cat_changed;


  /** 
    Function: toggle_crg_active
      See <ADCA_UI_DESIGNER.toggle_crg_active>
   */
  procedure toggle_crg_active
  as
    l_environment environment_rec;
  begin
    pit.enter_mandatory;
    
    l_environment := read_environment;

    adc_admin.toggle_rule_group(l_environment.crg_id);
    commit;

    pit.leave_mandatory;
  end toggle_crg_active;


  /** 
    Function: validate_rule_condition
      See <ADCA_UI_DESIGNER.validate_rule_condition>
   */
  procedure validate_rule_condition
  as
    l_rule_row adc_rules%rowtype;
    l_environment environment_rec;
  begin
    pit.enter_mandatory;
    
    l_environment := read_environment;
    copy_rule(l_rule_row, l_environment.crg_id);

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
  
  
  /**
    Procedure: check_parameter_value
      See <ADCA_UI_DESIGNER.check_parameter_value>
   */
  procedure check_parameter_value
  as
    l_cap_sort_seq adc_action_parameters.cap_sort_seq%type;
    l_cat_id adc_action_types.cat_id%type;
    l_capt_id adc_action_param_types.capt_id%type;
    l_firing_item adc_util.ora_name_type;
    l_value adc_util.max_char;
  begin
    pit.enter_mandatory;
    
    l_firing_item := adc.get_firing_item;
    l_value := adc.get_string(l_firing_item);
    l_cap_sort_seq := to_number(substr(l_firing_item, -1, 1));
    l_cat_id := adc.get_string('CRA_CAT_ID');
       
    adc_parameter.validate_parameter(
      p_value => l_value,
      p_capt_id => get_parameter_type(l_cat_id, l_cap_sort_seq),
      p_cpi_id => l_firing_item);
    
    pit.leave_mandatory;
  end check_parameter_value;


  /** 
    Function: support_flows
      See <ADCA_UI_DESIGNER.support_flows>
   */
  function support_flows
    return adc_util.flag_type
  as
    l_result adc_util.flag_type;
  begin
    pit.enter_mandatory;
    
    l_result := adc_util.bool_to_flag(adc_util.C_WITH_FLOWS);
    
    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('Result', l_result)));
    return l_result;
  end support_flows;
  
begin
  initialize;
end adca_ui_designer;
/