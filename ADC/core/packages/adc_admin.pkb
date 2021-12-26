create or replace package body adc_admin
as

  /**
    Package: ADC_ADMIN Body
      Implementation of methods to administer ADC rules and related metadata.

    Author::
      Juergen Sieben, ConDeS GmbH

   */

  
  /**
    Group: Private constants
   */
   
  /**
    Constants: 
      C_ADC - UTL_TEXT template group for ADC
   */
  C_ADC constant utl_text_templates.uttm_type%type := 'ADC';
  C_FRAME constant adc_util.ora_name_type := 'FRAME';
  C_DEFAULT constant adc_util.ora_name_type := 'DEFAULT';

  C_REGEX_ITEM constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
  C_REGEX_CSS constant varchar2(50 byte) := q'~'.+'~';
  
  C_CR constant char(1 byte) := chr(10);
  C_APOS constant char(1 byte) := chr(39);
  C_PIPE constant char(1 byte) := '|';
  

  /* Globale Variablen */
  g_offset binary_integer;

  
  /**
    Group: Type definitions
   */
   
  /**
    Type: id_map_t
      PL/SQL table for mapping old IDs to new ones. Used when importing rule groups.
   */
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;
  
  /**
    Group: Private Methods
   */
  /** 
    Procedure: create_decision_table
      Method to generate the decision table logic for a ADC Rule Group.
      Result is persisted in column <ADC_RULE_GROUP.CGR_DECISION_TABLE>.
      
    Parameter:
      p_cgr_id - Rule group ID
   */
  procedure create_decision_table(
    p_cgr_id in adc_rule_groups.cgr_id%type)
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'RULE_VIEW';
    l_stmt clob;
  begin
    pit.enter_optional('create_decision_table', 
      p_params => msg_params(msg_param('p_cgr_id', p_cgr_id)));

    -- generate view SQL
    with params as(
           select uttm_text template, uttm_log_text log_template,
                  uttm_name, uttm_mode, p_cgr_id g_cgr_id,
                  adc_util.C_TRUE c_true,
                  adc_util.C_CR c_cr
             from utl_text_templates
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select template, log_template, g_cgr_id cgr_id,
                    -- Spaltenliste im SessionState
                    utl_text.generate_text(cursor(
                      select /*+ no_merge (p) */
                             cit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cit_event
                        from adc_page_item_types sit
                        left join (
                               select *
                                 from adc_page_items
                                where cpi_cgr_id = g_cgr_id) cpi
                          on sit.cit_id = cpi.cpi_cit_id
                        join params p
                          on C_TRUE in (cpi_is_required, cit_include_in_view)
                       where cit_col_template is not null
                         and uttm_mode = 'WHERE_CLAUSE'
                       order by cit_include_in_view desc, cpi_id), ',' || C_CR, 14) column_list,
                    coalesce(
                      utl_text.generate_text(cursor(
                        select /*+ no_merge (p) */
                               template, cru_id, cru_name, cru_condition, cru_firing_items,
                               row_number() over (order by cru_id) sort_seq
                          from adc_rules
                          join params p
                            on cru_cgr_id in (0, g_cgr_id)
                           and cru_active = c_true
                         where uttm_mode = 'WHERE_CLAUSE'
                         order by cru_id), C_CR || '           or '),
                      to_clob('null is null')) where_clause
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = 'FRAME';

    -- persist outcome with rule group
    update adc_rule_groups
       set cgr_decision_table = l_stmt
     where cgr_id = p_cgr_id;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_decision_table;


  /** 
    Function: create_initialization_code
      Method to generate initialization code that copies initial page item values to the session state.
      
      Is used to copy initial values into the session state during page rendering. This is required to assure that
      any rule that is based on certain session state values is processed at initialization time.
      
    Parameter:
      p_cgr_id - Rule group ID
      
    Returns:
      Anonymous PL/SQL block that copies the actual session state values into the session state
   */
  function create_initialization_code(
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2
  as
    l_initialization_code utl_apex.max_char;
  begin
    pit.enter_optional('create_initialization_code',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

      with params as (
           -- Get common values, depending on whether the page contains a DML_FETCH_ROW process
           select cgr.cgr_id, adc_util.C_CR cr,
                  uttm.uttm_name, uttm.uttm_mode, uttm.uttm_text template,
                  app.attribute_02, app.attribute_03, app.attribute_04, app.application_id, app.page_id
             from apex_application_page_proc app
             join adc_rule_groups cgr
               on app.application_id = cgr.cgr_app_id
              and app.page_id = cgr.cgr_page_id
            cross join utl_text_templates uttm
            where app.process_type_code = 'DML_FETCH_ROW'
              and uttm_type = C_ADC
              and uttm_name like 'INITIALIZE%'
              and cgr.cgr_id = p_cgr_id)
    select utl_text.generate_text(cursor(
             select template,
                    cr,
                    -- select statement to select the actual page values from the table referenced by the DML_FETCH_ROW process
                    utl_text.generate_text(cursor(
                      select p.template, p.attribute_02, p.attribute_03, p.attribute_04
                        from params p
                       where p.uttm_mode = case p.attribute_04 when 'ROWID' then p.attribute_04 else 'DEFAULT' end
                         and p.uttm_name = 'INITIALIZE_COLUMN'), ',' || adc_util.C_CR) sql_stmt,
                    -- generate adc_util.set_session_state calls for any page element
                    utl_text.generate_text(cursor(
                      select p.template, sit.cit_init_template, cpi.cpi_conversion,
                             api.item_name, api.item_source
                        from params p
                        join apex_application_page_items api
                          on p.application_id = api.application_id
                         and p.page_id = api.page_id
                        join adc_page_items cpi
                          on p.cgr_id = cpi.cpi_cgr_id
                         and api.item_name = cpi.cpi_id
                        join adc_page_item_types sit
                          on cpi.cpi_cit_id = sit.cit_id
                       where api.item_source_type = 'Database Column'
                         and cpi.cpi_is_required = adc_util.C_TRUE
                         and p.uttm_name = 'INITIALIZE_COL_VAL'), adc_util.C_CR) item_stmt
               from dual)) resultat
      into l_initialization_code
      from params
     where uttm_name = 'INITIALIZE';

    pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', l_initialization_code)));
    return l_initialization_code;
  exception
    when no_data_found then
      pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', 'NULL')));
      return null;
  end create_initialization_code;
  
  
  /**
    Procedure: get_key
      Method to retrive a new primary key if not present. If P_KEY is NULL, a new sequence key is provided.
      
    Parameter:  
      p_key - Key to set
   */
  procedure get_key(
    p_key in out nocopy binary_integer)
  as
  begin
    if p_key is null then
      p_key := adc_seq.nextval;
    end if;
  end get_key;


  /** 
    Procedure: harmonize_adc_page_item
      Method to harmonize table adc_page_items against APEX Data Dictionary.
      
      If a rule group changes, all rules and page elements are checked against each other.
      The resulting values are used as the basis for a single rule.
      Additionally, this method is called if a new rule is created to check whether the condition
      is syntactically plausible. Therefore, the new condition (which is not stored in the tables yet)
      must be added to identify any new page items referenced within this rule.
      
    Attention:: 
      Method removes non existing page items from the table and deletes any rule actions attached to these page items!
      
    Parameters:
      p_cgr_id - Rule group ID
      p_new_condition - Optional. If a new rule is created, the new rule condition must be obeyed as well
      
   */
  procedure harmonize_adc_page_item(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_new_condition in adc_rules.cru_condition%type default null)
  as
    l_initialization_code adc_rule_groups.cgr_initialization_code%type;
    l_is_true utl_text.flag_type := utl_apex.C_TRUE;
  begin
    pit.enter_optional('harmonize_adc_page_item',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Step 1: Remove REQUIRED flags and mark any element as erroneus, will be cleared later on'));
      update adc_page_items
         set cpi_is_required = adc_util.C_FALSE,
             cpi_has_error = adc_util.C_TRUE
       where cpi_cgr_id = p_cgr_id;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Step 2: Merge APEX page items into ADC_PAGE_ITEMS'));
      --         Mark any item with a conversion or mandatory as required to enable ADC to dynamically validate the format
      --         Mark any item with a required label as mandatory to dynamically check for NOT NULL
      merge into adc_page_items t
      using (select cpi_cgr_id,
                    cpi_cit_id,
                    cpi_cty_id,
                    cpi_id,
                    cpi_label,
                    cpi_conversion,
                    cpi_item_default,
                    cpi_css,
                    adc_util.C_FALSE cpi_has_error,
                    cpi_is_required,
                    cpi_is_mandatory
               from adc_bl_page_targets
              where cpi_cgr_id = p_cgr_id
                and cpi_id is not null) s
         on (t.cpi_id = s.cpi_id and t.cpi_cgr_id = s.cpi_cgr_id)
       when matched then update set
            t.cpi_cit_id = s.cpi_cit_id,
            t.cpi_cty_id = s.cpi_cty_id,
            t.cpi_label = s.cpi_label,
            t.cpi_conversion = s.cpi_conversion,
            t.cpi_item_default = s.cpi_item_default,
            t.cpi_css = s.cpi_css,
            t.cpi_has_error = s.cpi_has_error,
            t.cpi_is_required = s.cpi_is_required,
            t.cpi_is_mandatory = s.cpi_is_mandatory
       when not matched then insert(cpi_id, cpi_cit_id, cpi_cty_id, cpi_label, cpi_cgr_id, cpi_conversion, cpi_item_default, cpi_css, cpi_is_required, cpi_is_mandatory)
            values(s.cpi_id, s.cpi_cit_id, s.cpi_cty_id, s.cpi_label, s.cpi_cgr_id, s.cpi_conversion, s.cpi_item_default, s.cpi_css, s.cpi_is_required, s.cpi_is_mandatory);

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Step 3: mark page items referenced in a technical condition as relevant'));
      merge into adc_page_items t
      using (select distinct cpi_cgr_id, cpi_id
               from (select cgr.cgr_id cpi_cgr_id, i.column_value cpi_id
                       from adc_rules cru
                       join adc_rule_groups cgr
                         on cru.cru_cgr_id = cgr.cgr_id
                      cross join table(utl_text.string_to_table(cru.cru_firing_items, ',')) i
                      where cgr_id = p_cgr_id
                      union all
                     -- Match newly created condition against adc_page_items to find new firing items
                     select cpi_cgr_id, cpi_id
                       from adc_page_items cpi
                      where (regexp_instr(upper(p_new_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
                         or instr(cpi.cpi_css, replace(regexp_substr(p_new_condition, C_REGEX_CSS), C_APOS, C_PIPE)) > 0)
                        and cpi_cgr_id = p_cgr_id)) s
         on (t.cpi_id = s.cpi_id
         and t.cpi_cgr_id = s.cpi_cgr_id)
       when matched then update set
            t.cpi_is_required = adc_util.C_TRUE;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Step 4: remove elements which are irreleveant, erroneus, not referenced'));
      -- - irrelevant and
      -- - erroneus (fi not existing anymore) and
      -- - not referenced by rule actions
      delete from adc_page_items
       where cpi_cgr_id = p_cgr_id
         and cpi_is_required = adc_util.C_FALSE
         and cpi_has_error = adc_util.C_TRUE
         and cpi_id not in (
             select cra_cpi_id
               from adc_rule_actions
              where cra_cgr_id = p_cgr_id);

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Mark errors in adc_rules and ADC_RULE_ACTION and reset all error flags for rule to FALSE'));
      update adc_rules
         set cru_has_error = adc_util.C_FALSE
       where cru_cgr_id = p_cgr_id;
      
      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Mark rules that reference items with error flag'));
      merge into adc_rules t
      using (select distinct cru.cru_id
               from adc_page_items cpi
               join adc_rules cru
                 on utl_text.contains(cru_firing_items, cpi_id) = l_is_true
              where cpi_cgr_id = p_cgr_id
                and cpi_has_error = adc_util.C_TRUE) s
         on (t.cru_id = s.cru_id)
       when matched then update set
            t.cru_has_error = adc_util.C_TRUE;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Reset all error flags for rule actions to FALSE'));
      update adc_rule_actions
         set cra_has_error = adc_util.C_FALSE
       where cra_cgr_id = p_cgr_id;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('Mark rule actions that reference items with error flag'));
      merge into adc_rule_actions t
      using (select cpi_cgr_id cra_cgr_id, cpi_id cra_cpi_id
               from adc_page_items
              where cpi_cgr_id = p_cgr_id
                and cpi_has_error = adc_util.C_TRUE) s
         on (t.cra_cgr_id = s.cra_cgr_id
         and t.cra_cpi_id = s.cra_cpi_id)
       when matched then update set
            t.cra_has_error = adc_util.C_TRUE;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('create initialization code and persist at adc_rule_groups for fast page initialization'));
      l_initialization_code := create_initialization_code(p_cgr_id);

      update adc_rule_groups
         set cgr_initialization_code = l_initialization_code
       where cgr_id = p_cgr_id;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_INITIALZE_CGR_FAILED, msg_args(to_char(p_cgr_id),sqlerrm));
  end harmonize_adc_page_item;


  /** 
    Procedure: harmonize_firing_items
      Helper to harmonize page items which are referenced by a rule at table ADC_RULE.
      
      Method extracts page item names from a rule condition using regex C_REGEX_ITEM.
      Used to validate a rule condition and further application logic.
      
    Parameter:
      p_cgr_id - Rule group ID
   */
  procedure harmonize_firing_items(
    p_cgr_id in adc_rule_groups.cgr_id%type)
  as
  begin
    pit.enter_detailed('harmonize_firing_items',
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

    merge into adc_rules t
    using (select cru.cru_id,
                  listagg(cpi.cpi_id, ',') within group (order by cpi.cpi_id) cru_firing_items
             from adc_page_items cpi
             join adc_rules cru
               on cpi.cpi_cgr_id = cru.cru_cgr_id
              and (regexp_instr(upper(cru.cru_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
               or instr(cpi.cpi_css, replace(regexp_substr(cru.cru_condition, C_REGEX_CSS), C_APOS, C_PIPE)) > 0)
            where cpi.cpi_cgr_id = p_cgr_id
              and cru.cru_active = adc_util.C_TRUE
            group by cru.cru_id) s
       on (t.cru_id = s.cru_id)
     when matched then update set
          t.cru_firing_items = s.cru_firing_items;

    pit.leave_detailed;
  end harmonize_firing_items;
  
  
  /** 
    Function: integrate_rule_groups_into_app
      Helper method to include rule group export script into the application export.
      
    Parameters:
      p_cgr_app_id - ID of the APEX application to integrate the rule group script into
      p_script - Rule group script
      
    Returns:
      Script with the APEX export and rule group script integrated
   */
  function integrate_rule_groups_into_app(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_rule_group in clob)
    return clob
  as
    C_MAX_LENGTH constant pls_integer := 30000;
    C_END_COMMENT constant utl_apex.small_char := q'^prompt --application/end_environment^';
    l_export_file apex_t_export_files;
    l_offset pls_integer := 1;
    l_add_amount pls_integer;
    l_amount pls_integer := C_MAX_LENGTH;
    l_length pls_integer;
    l_buffer utl_apex.max_char;
    l_script clob;
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    
    -- Get APEX application
    l_export_file := apex_export.get_application (
                       p_application_id => p_cgr_app_id,
                       p_with_ir_public_reports => true);
                
    -- Find position to integrate rule script into the export file
    l_length := dbms_lob.getlength(l_export_file(1).contents);

    while l_offset < l_length loop
      -- Add some text to securly detect C_END_COMMENT
      l_add_amount := length(C_END_COMMENT);
      l_amount := l_amount + l_add_amount;
    
      dbms_lob.read(l_export_file(1).contents, l_amount, l_offset, l_buffer);
      -- Try to find C_END_COMMENT.
      if instr(l_buffer, C_END_COMMENT) > 0 then
        -- found, read the rest of the file and split it
        l_amount := l_amount + 1000;
        dbms_lob.read(l_export_file(1).contents, l_amount, l_offset, l_buffer);
        dbms_lob.append(l_script, substr(l_buffer, 1, instr(l_buffer, C_END_COMMENT) - 1));
        dbms_lob.append(l_script, 'set define ^' || chr(13));
        dbms_lob.append(l_script, p_rule_group);
        dbms_lob.append(l_script, 'set define on' || chr(13));
        dbms_lob.append(l_script, substr(l_buffer, instr(l_buffer, C_END_COMMENT)));
        exit;
      else
        -- Not found, add buffer to out script and read on
        l_amount := l_amount - l_add_amount;
        dbms_lob.append(l_script, substr(l_buffer, 1, length(l_buffer) - l_add_amount));
      end if;
    
      l_offset := l_offset + l_amount;
    end loop;
    
    return l_script;
  end integrate_rule_groups_into_app;
  

  /** 
    Procedure: resequence_rule_group
      Helper to resequence rules and rule actions.
      
      Is called automatically upon change of a rule group to resequence all entries in steps of 10.
      
    Parameter:
      p_cgr_id - Rule group ID
   */
  procedure resequence_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type)
  as
  begin
    pit.enter_optional('resequence_rule_group',
      p_params => msg_params(msg_param('p_cgr_id', p_cgr_id)));

    -- resequence rules
    merge into adc_rules t
    using (select cru_id, cru_cgr_id,
                  row_number() over (partition by cru_cgr_id order by cru_sort_seq) * 10 cru_sort_seq
             from adc_rules
            where cru_cgr_id = p_cgr_id
              and cru_cgr_id > 0) s
       on (t.cru_id = s.cru_id and t.cru_cgr_id = s.cru_cgr_id)
     when matched then update set
          t.cru_sort_seq = s.cru_sort_seq;

    -- resequence rule actions
    merge into adc_rule_actions t
    using (select rowid row_id,
                  row_number() over (partition by cra_cru_id order by cra_on_error, cra_sort_seq) * 10 cra_sort_seq
             from adc_rule_actions
            where cra_cgr_id = p_cgr_id) s
       on (t.rowid = s.row_id)
     when matched then update set
          t.cra_sort_seq = s.cra_sort_seq;

    -- Is called outside the request-response-cycle, so commit explicitly
    commit;

    pit.leave_optional;
  end resequence_rule_group;
  
  
  /** 
    Procedure: validate_export_rule_groups
      Helper method to validate an export rule group according to the P_MODE request.
      Based on the parameters passed in this method will export one or more rule groups.
      
    Parameters:
      p_cgr_app_id - APEX application ID of the application of which all rule groups are to be exported.
      p_cgr_page_id - If a rule group is copied, this parameter defines the target application page id
      p_mode - Export mode. Determines which parameters are mandatory
      
    Errors:
      APP_ID_MISSING - if <P_MODE> requires an application id
      PAGE_ID_MISSING - if <P_MODE> requires an application page id
   */
  procedure validate_export_rule_groups(
    p_cgr_app_id in out nocopy adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in out nocopy adc_rule_groups.cgr_page_id%type,
    p_mode in varchar2)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_cgr_app_id', p_cgr_app_id),
                    msg_param('p_cgr_page_id', p_cgr_page_id)));
    case p_mode
      when C_ALL_GROUPS then
        -- Reset unneeded restrictions
        p_cgr_app_id := null;
        p_cgr_page_id := null;
      when C_APEX_APP then
        pit.assert_not_null(p_cgr_app_id, p_error_code => 'APP_ID_MISSING');
        -- Reset unneeded restrictions
        p_cgr_page_id := null;
      when C_APP_GROUPS then
        pit.assert_not_null(p_cgr_app_id, p_error_code => 'APP_ID_MISSING');
        -- Reset unneeded restrictions
        p_cgr_page_id := null;
      when C_PAGE_GROUP then
        pit.assert_not_null(p_cgr_app_id, p_error_code => 'APP_ID_MISSING');
        pit.assert_not_null(p_cgr_page_id, p_error_code => 'PAGE_ID_MISSING');
        -- Reset unneeded restrictions
        p_cgr_page_id := null;
      else
        pit.error(msg.ADC_UNKNOWN_EXPORT_MODE, msg_args(p_mode));
      end case;
    pit.leave_optional;
  exception
    when others then
      pit.stop;
  end validate_export_rule_groups;


  /**
    Procedure: initialize
      Package initialization method.
   */
  procedure initialize
  as
  begin
    g_offset := 0;
  end;


  /**
    Group: Public Methods - Helper Functions
   */
  
  /**
    Function: map_id
      See <ADC_ADMIN.map_id>
   */
  function map_id(
    p_id in number)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_mandatory;

    if p_id is null then
      g_id_map.delete;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := adc_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_new_id)));
    return l_new_id;
  end map_id;


  /**
    Procedure: add_translation
      See <ADC_ADMIN.add_translation>
   */
  procedure add_translation(
    p_table_shortcut in adc_util.ora_name_type,
    p_item_id in adc_util.ora_name_type,
    p_pml_name pit_translatable_item.pti_pml_name%type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type)
  as
  begin
    pit_admin.merge_translatable_item(
      p_pti_id => p_table_shortcut || '_' || p_item_id,
      p_pti_pml_name => p_pml_name,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_name,
      p_pti_display_name => p_display_name,
      p_pti_description => p_description);
  end add_translation;


  /**
    Group: Public Methods - Rule Group Functions
   */    
  /**
    Procedure: merge_rule_group
      See <ADC_ADMIN.merge_rule_group>
   */ 
  procedure merge_rule_group(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type,
    p_cgr_id in adc_rule_groups.cgr_id%type default null,
    p_cgr_with_recursion in adc_rule_groups.cgr_with_recursion%type default adc_util.C_TRUE,
    p_cgr_active in adc_rule_groups.cgr_active%type default adc_util.C_TRUE)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cgr_app_id', p_cgr_app_id),
                    msg_param('p_cgr_page_id', p_cgr_page_id),
                    msg_param('p_cgr_id', p_cgr_id),
                    msg_param('p_cgr_with_recursion', p_cgr_with_recursion),
                    msg_param('p_cgr_active', p_cgr_active)));
                    
    l_row.cgr_app_id := p_cgr_app_id + g_offset;
    l_row.cgr_page_id := p_cgr_page_id;
    l_row.cgr_id := p_cgr_id;
    l_row.cgr_with_recursion := adc_util.get_boolean(p_cgr_with_recursion);
    l_row.cgr_active := adc_util.get_boolean(p_cgr_active);
    
    merge_rule_group(l_row);    

    pit.leave_mandatory;
  end merge_rule_group;


  /**
    Procedure: merge_rule_group
      See <ADC_ADMIN.merge_rule_group>
   */ 
  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    p_row.cgr_with_recursion := coalesce(p_row.cgr_with_recursion, adc_util.C_TRUE);
    p_row.cgr_active := coalesce(p_row.cgr_active, adc_util.C_TRUE);

    validate_rule_group(p_row);
      
    get_key(p_row.cgr_id);    

    merge into adc_rule_groups t
    using (select p_row.cgr_id cgr_id,
                  p_row.cgr_app_id cgr_app_id,
                  p_row.cgr_page_id cgr_page_id,
                  p_row.cgr_with_recursion cgr_with_recursion,
                  p_row.cgr_active cgr_active
             from dual) s
       on (t.cgr_id = s.cgr_id and t.cgr_app_id = s.cgr_app_id)
     when matched then update set
          t.cgr_page_id = s.cgr_page_id,
          t.cgr_with_recursion = s.cgr_with_recursion,
          t.cgr_active = s.cgr_active
     when not matched then insert(cgr_id, cgr_app_id, cgr_page_id, cgr_with_recursion, cgr_active)
          values(s.cgr_id, s.cgr_app_id, s.cgr_page_id, s.cgr_with_recursion, s.cgr_active);
     
    harmonize_adc_page_item(p_row.cgr_id);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE_GROUP, msg_args(to_char(p_row.cgr_id)));
  end merge_rule_group;


  /**
    Procedure: delete_rule_group
      See <ADC_ADMIN.delete_rule_group>
   */ 
  procedure delete_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));
                    
    l_row.cgr_id := p_cgr_id;
    
    delete_rule_group(l_row);
     
    pit.leave_mandatory;
  end delete_rule_group;


  /**
    Procedure: delete_rule_group
      See <ADC_ADMIN.delete_rule_group>
   */ 
  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from adc_rule_groups
     where cgr_id = p_row.cgr_id;
     
    pit.leave_mandatory;
  end delete_rule_group;
  
  
  /**
    Procedure: validate_rule_group
      See <ADC_ADMIN.validate_rule_group>
   */ 
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_mandatory;
      
    pit.assert_not_null(p_row.cgr_app_id, msg.ADC_PARAM_MISSING, p_error_code => 'CGR_APP_ID_MISSING');
    pit.assert_not_null(p_row.cgr_page_id, msg.ADC_PARAM_MISSING, p_error_code => 'CGR_PAGE_ID_MISSING');

    if p_row.cgr_id is null then
      -- only if inserting we need to check whether the name is unique
      open l_cur for 
        select null
          from adc_rule_groups
         where cgr_app_id = p_row.cgr_app_id
           and cgr_page_id = p_row.cgr_page_id;
      pit.assert_not_exists(
        p_cursor => l_cur,
        p_message_name => msg.ADC_CGR_MUST_BE_UNIQUE,
        p_msg_args => null,
        p_affected_id => 'CGR_PAGE_ID');
    end if;
    
    pit.leave_mandatory;
  end validate_rule_group;


  /**
    Function: validate_rule_group
      See <ADC_ADMIN.validate_rule_group>
   */ 
  function validate_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type)
    return varchar2
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'VALIDATE_RULE_GROUP_EXPORT';
    l_error_list clob;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

    harmonize_adc_page_item(p_cgr_id);

    with params as (
           select uttm_mode, uttm_text template,
                  cgr_id, cgr_app_id
             from adc_rule_groups
            cross join utl_text_templates
            where cgr_id = p_cgr_id
              and uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and exists(
                  select null
                    from adc_page_items
                   where cpi_cgr_id = cgr_id
                     and cpi_has_error = adc_util.C_TRUE))
    select utl_text.generate_text(cursor(
             select template, 
                    utl_text.generate_text(cursor(
                      select p.template, p.cgr_app_id, cpi.cpi_id
                        from adc_page_items cpi
                        join adc_page_item_types sit
                          on cpi.cpi_cit_id = sit.cit_id
                        join params p
                          on cpi.cpi_cgr_id = p.cgr_id
                       where cpi.cpi_has_error = adc_util.C_TRUE
                    )) error_list
               from dual
           )) resultat
      into l_error_list
      from params
     where uttm_mode = C_DEFAULT;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_error_list)));
    return l_error_list;
  end validate_rule_group;


  /**
    Procedure: propagate_rule_change
      See <ADC_ADMIN.propagate_rule_change>
   */ 
  procedure propagate_rule_change(
    p_cgr_id in adc_rule_groups.cgr_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cgr_id', p_cgr_id)));

    harmonize_firing_items(p_cgr_id);
    harmonize_adc_page_item(p_cgr_id);
    create_decision_table(p_cgr_id);
    resequence_rule_group(p_cgr_id);

    pit.leave_mandatory;
  end propagate_rule_change;
  
  
  /**
    Function: export_rule_group
      See <ADC_ADMIN.export_rule_group>
   */ 
  function export_rule_group(
    p_cgr_id in adc_rule_groups.cgr_id%type,
    p_mode in varchar2 default C_APP_GROUPS)
    return clob
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_RULE_GROUP';
    l_template utl_text_templates.uttm_mode%type;
    l_stmt clob;
  begin      
    -- Create export script based on UTL_TEXT export templates
    utl_text.set_secondary_anchor_char('&');
        
    with params as (
           select uttm_mode, uttm_text template,
                  case p_mode when C_APEX_APP then 'DEFAULT_APP' else C_DEFAULT end g_mode,
                  cgr_id, cgr_app_id, cgr_page_id, 
                  adc_util.to_bool(cgr_active) cgr_active,
                  adc_util.to_bool(cgr_with_recursion) cgr_with_recursion
             from utl_text_templates
            cross join adc_rule_groups
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and cgr_id = p_cgr_id)
    select utl_text.generate_text(cursor(
             select template, cgr_id, cgr_app_id, cgr_page_id, cgr_active, cgr_with_recursion,
                    -- apex_actions
                    utl_text.generate_text(cursor(
                      select p.template, caa_id, caa_cgr_id, caa_cty_id, caa_name, caa_label, caa_context_label,
                             caa_icon, caa_icon_type, caa_title, caa_shortcut,
                             adc_util.to_bool(caa_initially_disabled) caa_initially_disabled,
                             adc_util.to_bool(caa_initially_hidden) caa_initially_hidden,
                             caa_href, caa_action, caa_on_label, caa_off_label, caa_get, caa_set, caa_choices,
                             caa_label_classes, caa_label_start_classes, caa_label_end_classes, caa_item_wrap_class,
                             -- apex_action_items
                             utl_text.generate_text(cursor(
                               select p.template, cai_caa_id, cai_cpi_cgr_id, cai_cpi_id,
                                      adc_util.to_bool(cai_active) cai_active
                                 from adc_apex_action_items sai
                                 join params p
                                   on p.uttm_mode = 'APEX_ACTION_ITEM'
                                where cai_caa_id = saa.caa_id
                             )) apex_action_items
                        from adc_apex_actions_v saa
                        join params p
                          on p.uttm_mode = 'APEX_ACTION_' || saa.caa_cty_id
                       where caa_cgr_id = cgr_id
                    )) apex_actions,
                    -- rules
                    utl_text.generate_text(cursor(
                      select p.template, cru_id, cru_cgr_id, cru_name, cru_condition, cru_sort_seq,
                             cru_firing_items, adc_util.to_bool(cru_active) cru_active,
                             adc_util.to_bool(cru_fire_on_page_load) cru_fire_on_page_load,
                             -- rule actions
                             utl_text.generate_text(cursor(
                               select p.template, cra_id, cra_cgr_id, cra_cru_id, cra_cpi_id, cra_cat_id,
                                      adc_util.to_bool(cra_on_error) cra_on_error,
                                      cra_param_1, cra_param_2, cra_param_3, cra_comment, cra_sort_seq,
                                      adc_util.to_bool(cra_raise_recursive) cra_raise_recursive,
                                      adc_util.to_bool(cra_active) cra_active
                                 from adc_rule_actions a
                                cross join params p
                                where uttm_mode = 'RULE_ACTION'
                                  and cra_cru_id = r.cru_id
                             )) rule_actions
                        from adc_rules r
                        join params p
                          on r.cru_cgr_id = p.cgr_id
                       where p.uttm_mode = 'RULE'
                    )) rules
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = g_mode;
    return l_stmt;
  end export_rule_group;
  

  /**
    Function: export_rule_groups
      See <ADC_ADMIN.export_rule_groups>
   */ 
  function export_rule_groups(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type default null,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type default null,
    p_mode in varchar2 default C_APP_GROUPS)
    return blob
  as
    cursor rule_group_cur(
      p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
      p_cgr_page_id in adc_rule_groups.cgr_page_id%type) 
    is
      select cgr_id, lower(a.alias || '_' || p.page_alias) cgr_file_name
        from adc_rule_groups
        join apex_applications a
          on cgr_app_id = a.application_id
        join apex_application_pages p
          on cgr_app_id = p.application_id
         and cgr_page_id = p.page_id
       where (cgr_app_id = p_cgr_app_id or p_cgr_app_id is null)
         and (cgr_page_id = p_cgr_page_id or p_cgr_page_id is null)
       order by p.page_id;
    
    C_FILE_NAME_PATTERN constant varchar2(100 byte) := 'merge_rule_group_#CGR_FILE_NAME#.sql';
    C_ACTION_TYPE_FILE_NAME constant adc_util.ora_name_type := 'merge_action_types.sql';
    C_FILE_NAME_APPLICATION constant adc_util.ora_name_type := 'f#APP_ID#_dynamic.sql';
    l_zip_file blob;
    l_clob clob;
    l_blob blob;
    l_file_name varchar2(100);
    
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
    l_cgr_page_id adc_rule_groups.cgr_page_id%type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cgr_app_id', p_cgr_app_id),
                    msg_param('p_cgr_page_id', p_cgr_page_id),
                    msg_param('p_mode', p_mode)));
    
    -- Initialize
    dbms_lob.createtemporary(l_clob, false, dbms_lob.call);
    l_cgr_app_id := p_cgr_app_id;
    l_cgr_page_id := p_cgr_page_id;
                    
    validate_export_rule_groups(
      p_cgr_app_id => l_cgr_app_id,
      p_cgr_page_id => l_cgr_page_id,
      p_mode => p_mode);      
    
    if p_mode = C_APEX_APP then
      -- Get all rule groups
      for cgr in rule_group_cur(l_cgr_app_id, l_cgr_page_id) loop
        dbms_lob.append(
          l_clob, 
          export_rule_group(
            p_cgr_id => cgr.cgr_id,
            p_mode => p_mode));
      end loop;
      
      l_clob := integrate_rule_groups_into_app(p_cgr_app_id, l_clob);
      l_blob := utl_text.clob_to_blob(l_clob);
      
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => 'application.sql',
        p_content => l_blob);   
    else   
      for cgr in rule_group_cur(l_cgr_app_id, l_cgr_page_id) loop
      
        l_blob := utl_text.clob_to_blob(
                    export_rule_group(
                      p_cgr_id => cgr.cgr_id,
                      p_mode => p_mode));
                  
        l_file_name := replace(C_FILE_NAME_PATTERN, '#CGR_FILE_NAME#', cgr.cgr_file_name);
     
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
  
      end loop;
    end if;
    
    apex_zip.finish(l_zip_file);

    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('ZIP file size', dbms_lob.getlength(l_zip_file))));
    return l_zip_file;
  end export_rule_groups;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */ 
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2)
  as
    l_ws_id number;
    l_app_id number;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_workspace', p_workspace),
                    msg_param('p_app_alias', p_app_alias)));

    select workspace_id, application_id
      into l_ws_id, l_app_id
      from apex_applications
     where alias = p_app_alias
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(l_app_id + g_offset);

    pit.leave_mandatory;
  exception
    when no_data_found then
      pit.warn(msg.ADC_NO_RULE_GROUP_FOUND, msg_args(p_workspace, p_app_alias));
      pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */ 
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.cgr_app_id%type)
  as
    l_ws_id number;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_workspace', p_workspace),
                    msg_param('p_app_id', p_app_id)));

    select workspace_id
      into l_ws_id
      from apex_applications
     where application_id = p_app_id
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(p_app_id + g_offset);

    pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Procedure: prepare_rule_group_import
      See <ADC_ADMIN.prepare_rule_group_import>
   */
  procedure prepare_rule_group_import(
    p_cgr_app_id in adc_rule_groups.cgr_app_id%type,
    p_cgr_page_id in adc_rule_groups.cgr_page_id%type)
  as
  begin
    pit.enter_mandatory('prepare_rule_group_import', 
      p_params => msg_params(
                    msg_param('p_cgr_app_id', p_cgr_app_id),
                    msg_param('p_cgr_page_id', p_cgr_page_id)));

    -- Recursively delete any existing rulegroup with same APP_ID, PAGE_ID and NAME
    delete from adc_rule_groups
     where cgr_app_id = p_cgr_app_id
       and cgr_page_id = p_cgr_page_id;

    pit.leave_mandatory;
  end prepare_rule_group_import;


  /**
    Group: Public Methods - Rule Methods
   */
  /**
    Procedure: merge_rule
      See <ADC_ADMIN.merge_rule>
   */ 
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_cgr_id in adc_rules.cru_cgr_id%type,
    p_cru_name in adc_rules.cru_name%type,
    p_cru_condition in adc_rules.cru_condition%type,
    p_cru_fire_on_page_load in adc_rules.cru_fire_on_page_load%type,
    p_cru_sort_seq in adc_rules.cru_sort_seq%type,
    p_cru_active in adc_rules.cru_active%type default adc_util.C_TRUE)
  as
    l_row adc_rules%rowtype;
  begin
    pit.enter_mandatory('merge_rule',
      p_params => msg_params(
                    msg_param('p_cru_id', p_cru_id),
                    msg_param('p_cru_cgr_id', p_cru_cgr_id),
                    msg_param('p_cru_name', p_cru_name),
                    msg_param('p_cru_condition', p_cru_condition),
                    msg_param('p_cru_fire_on_page_load', p_cru_fire_on_page_load),
                    msg_param('p_cru_sort_seq', p_cru_sort_seq),
                    msg_param('p_cru_active', p_cru_active)));
                    
      l_row.cru_id := p_cru_id;
      l_row.cru_cgr_id := p_cru_cgr_id;
      l_row.cru_name := p_cru_name;
      l_row.cru_condition := p_cru_condition;
      l_row.cru_fire_on_page_load := p_cru_fire_on_page_load;
      l_row.cru_sort_seq := p_cru_sort_seq;
      l_row.cru_active := p_cru_active;
      
    merge_rule(l_row);
      
    pit.leave_mandatory;
  end merge_rule;


  /**
    Procedure: merge_rule
      See <ADC_ADMIN.merge_rule>
   */ 
  procedure merge_rule(
    p_row in out nocopy adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_rule(p_row);
    
    get_key(p_row.cru_id);
    
    merge into adc_rules t
    using (select p_row.cru_id cru_id,
                  p_row.cru_cgr_id cru_cgr_id,
                  p_row.cru_name cru_name,
                  p_row.cru_condition cru_condition,
                  p_row.cru_fire_on_page_load cru_fire_on_page_load,
                  p_row.cru_sort_seq cru_sort_seq,
                  p_row.cru_active cru_active
             from dual) s
       on (t.cru_id = s.cru_id
       and t.cru_cgr_id = s.cru_cgr_id)
     when matched then update set
          t.cru_name = s.cru_name,
          t.cru_condition = s.cru_condition,
          t.cru_fire_on_page_load = s.cru_fire_on_page_load,
          t.cru_sort_seq = s.cru_sort_seq,
          t.cru_active = s.cru_active
     when not matched then insert(cru_id, cru_cgr_id, cru_name, cru_condition, cru_fire_on_page_load, cru_sort_seq, cru_active)
          values (s.cru_id, s.cru_cgr_id, s.cru_name, s.cru_condition, s.cru_fire_on_page_load, s.cru_sort_seq, s.cru_active);

    pit.leave_mandatory;
/*  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE, msg_args(p_row.cru_name));*/
  end merge_rule;


  /**
    Procedure: delete_rule
      See <ADC_ADMIN.delete_rule>
   */ 
  procedure delete_rule(
    p_cru_id in adc_rules.cru_id%type)
  as
    l_row adc_rules%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row.cru_id := p_cru_id;
    
    delete_rule(l_row);

    pit.leave_mandatory;
  end delete_rule;


  /**
    Procedure: delete_rule
      See <ADC_ADMIN.delete_rule>
   */ 
  procedure delete_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_rules
     where cru_id = p_row.cru_id;

    pit.leave_mandatory;
  end delete_rule;
  
  
  /**
    Procedure: validate_rule_condition
      See <ADC_ADMIN.validate_rule_condition>
   */ 
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype)
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'RULE_VALIDATION';
    l_data_cols utl_apex.max_char;
    l_stmt utl_apex.max_char;
    l_ctx pls_integer;
  begin
    pit.enter_mandatory('validate_rule_condition');
    
    pit.assert_not_null(p_row.cru_condition, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CONDITION_MISSING');

    harmonize_adc_page_item(p_row.cru_cgr_id, p_row.cru_condition);

    -- create validation statement
    with params as(
           select uttm_text template,
                  p_row.cru_cgr_id cgr_id,
                  p_row.cru_condition condition
             from utl_text_templates
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and uttm_mode = C_DEFAULT)
    select utl_text.generate_text(cursor(
             select p.template, p.condition,
                    utl_text.generate_text(cursor(
                      select cit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cit_event
                        from adc_page_item_types sit
                        left join (
                               select *
                                 from adc_page_items
                                where cpi_cgr_id = cgr_id) cpi
                          on sit.cit_id = cpi.cpi_cit_id
                       where adc_util.C_TRUE in (cpi_is_required, cit_include_in_view)
                         and cit_col_template is not null
                      order by cit_include_in_view desc, cpi_id), ',' || adc_util.C_CR, 14) column_list
               from dual)) resultat
      into l_stmt
      from params p;

    -- perform validation
    begin
      l_ctx := dbms_sql.open_cursor;
      dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
      dbms_sql.close_cursor(l_ctx);
    exception
      when others then
        if dbms_sql.is_open(l_ctx) then
          dbms_sql.close_cursor(l_ctx);
        end if;
        pit.error(msg.ADC_INVALID_SQL, msg_args(substr(sqlerrm, 12)));
    end;
    
    pit.leave_mandatory;
  end validate_rule_condition;
  

  /**
    Procedure: validate_rule
      See <ADC_ADMIN.validate_rule>
   */ 
  procedure validate_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.cru_cgr_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CGR_ID_MISSING');
    pit.assert_not_null(p_row.cru_name, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_NAME_MISSING');

    validate_rule_condition(p_row);
    
    pit.leave_mandatory;
  end validate_rule;


  /**
    Procedure: resequence_rule
      See <ADC_ADMIN.resequence_rule>
   */ 
  procedure resequence_rule(
    p_cru_id in adc_rules.cru_id%type)
  as
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_cru_id', p_cru_id)));

    -- resequence rule actions
    merge into adc_rule_actions t
    using (select rowid row_id,
                  row_number() over (partition by cra_cru_id order by cra_on_error, cra_sort_seq) * 10 cra_sort_seq
             from adc_rule_actions
            where cra_cru_id = p_cru_id) s
       on (t.rowid = s.row_id)
     when matched then update set
          t.cra_sort_seq = s.cra_sort_seq;

    -- Is called outside the request-response-cycle, so commit explicitly
    commit;

    pit.leave_optional;
  end resequence_rule;


  /**
    Group: Public Methods - Rule Action Methods
   */
  /**
    Procedure: merge_rule_action
      See <ADC_ADMIN.merge_rule_action>
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type,
    p_cra_cru_id in adc_rule_actions.cra_cru_id%type,
    p_cra_cgr_id in adc_rule_actions.cra_cgr_id%type,
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cra_cat_id in adc_rule_actions.cra_cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cra_id', p_cra_id),
                    msg_param('p_cra_cru_id', p_cra_cru_id),
                    msg_param('p_cra_cgr_id', p_cra_cgr_id),
                    msg_param('p_cra_cpi_id', p_cra_cpi_id),
                    msg_param('p_cra_cat_id', p_cra_cat_id),
                    msg_param('p_cra_sort_seq', p_cra_sort_seq),
                    msg_param('p_cra_param_1', p_cra_param_1),
                    msg_param('p_cra_param_2', p_cra_param_2),
                    msg_param('p_cra_param_3', p_cra_param_3),
                    msg_param('p_cra_on_error', p_cra_on_error),
                    msg_param('p_cra_raise_recursive', p_cra_raise_recursive),
                    msg_param('p_cra_active', p_cra_active),
                    msg_param('p_cra_comment', p_cra_comment)));
    
    l_row.cra_id := p_cra_id;
    l_row.cra_cru_id := p_cra_cru_id;
    l_row.cra_cgr_id := p_cra_cgr_id;
    l_row.cra_cpi_id := p_cra_cpi_id;
    l_row.cra_cat_id := p_cra_cat_id;
    l_row.cra_sort_seq := p_cra_sort_seq;
    l_row.cra_param_1 := p_cra_param_1;
    l_row.cra_param_2 := p_cra_param_2;
    l_row.cra_param_3 := p_cra_param_3;
    l_row.cra_on_error := adc_util.get_boolean(p_cra_on_error);
    l_row.cra_raise_recursive := adc_util.get_boolean(p_cra_raise_recursive);
    l_row.cra_active := adc_util.get_boolean(p_cra_active);
    l_row.cra_comment := p_cra_comment;

    merge_rule_action(l_row);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.ADC_MERGE_RULE_ACTION, msg_args(to_char(p_cra_cru_id), to_char( p_cra_cpi_id)));
  end merge_rule_action;


  /**
    Procedure: merge_rule_action
      See <ADC_ADMIN.merge_rule_action>
   */
  procedure merge_rule_action(
    p_row in out nocopy adc_rule_actions%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_rule_action(p_row);
    
    get_key(p_row.cra_id);
    
    merge into adc_rule_actions t
    using (select p_row.cra_id cra_id,
                  p_row.cra_cru_id cra_cru_id,
                  p_row.cra_cgr_id cra_cgr_id,
                  p_row.cra_cpi_id cra_cpi_id,
                  p_row.cra_cat_id cra_cat_id,
                  p_row.cra_sort_seq cra_sort_seq,
                  p_row.cra_param_1 cra_param_1,
                  p_row.cra_param_2 cra_param_2,
                  p_row.cra_param_3 cra_param_3,
                  p_row.cra_on_error cra_on_error,
                  p_row.cra_raise_recursive cra_raise_recursive,
                  p_row.cra_active cra_active,
                  p_row.cra_comment cra_comment
             from dual) s
       on (t.cra_id = s.cra_id)
     when matched then update set
          t.cra_cpi_id = s.cra_cpi_id,
          t.cra_cat_id = s.cra_cat_id,
          t.cra_sort_seq = s.cra_sort_seq,
          t.cra_param_1 = s.cra_param_1,
          t.cra_param_2 = s.cra_param_2,
          t.cra_param_3 = s.cra_param_3,
          t.cra_on_error = s.cra_on_error,
          t.cra_raise_recursive = s.cra_raise_recursive,
          t.cra_active = s.cra_active,
          t.cra_comment = s.cra_comment
     when not matched then insert (
            cra_id, cra_cru_id, cra_cgr_id, cra_cpi_id, cra_cat_id, cra_sort_seq, cra_param_1, cra_param_2, cra_param_3,
            cra_on_error, cra_raise_recursive, cra_active, cra_comment)
          values(
            s.cra_id, s.cra_cru_id, s.cra_cgr_id, s.cra_cpi_id, s.cra_cat_id, s.cra_sort_seq, s.cra_param_1, s.cra_param_2, s.cra_param_3,
            s.cra_on_error, s.cra_raise_recursive, s.cra_active, s.cra_comment);

    pit.leave_mandatory;
  end merge_rule_action;


  /**
    Procedure: delete_rule_action
      See <ADC_ADMIN.delete_rule_action>
   */
  procedure delete_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cra_id', to_char(p_cra_id))));

    l_row.cra_id := p_cra_id;
    
    delete_rule_action(l_row);
    
    pit.leave_mandatory;
  end delete_rule_action;


  /**
    Procedure: delete_rule_action
      See <ADC_ADMIN.delete_rule_action>
   */
  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
  begin
    pit.enter_optional;

    delete from adc_rule_actions
     where cra_id = p_row.cra_id;
    
    pit.leave_optional;
  end delete_rule_action;
  
  
  /**
    Procedure: validate_rule_action
      See <ADC_ADMIN.validate_rule_action>
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_optional;
    
    pit.assert_not_null(p_row.cra_cru_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CRU_ID_MISSING');
    pit.assert_not_null(p_row.cra_cgr_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CGR_ID_MISSING');
    pit.assert_not_null(p_row.cra_cpi_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CPI_ID_MISSING');
    pit.assert_not_null(p_row.cra_cat_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CAT_ID_MISSING');
    
    if p_row.cra_id is null then
      open l_cur for
        select null
          from adc_rule_actions
         where cra_cgr_id = p_row.cra_cgr_id
           and cra_cru_id = p_row.cra_cru_id
           and cra_cpi_id = p_row.cra_cpi_id
           and cra_cat_id = p_row.cra_cat_id
           and cra_on_error = p_row.cra_on_error;
      pit.assert_not_exists(l_cur, msg.ADC_RULE_ACTION_EXISTS);
    end if;
    
    pit.leave_optional;
  end validate_rule_action;
  
  
  /**
    Group: Public Methods - Action Type Methods
   */
  /**
    Procedure: merge_action_type_group
      See <ADC_ADMIN.merge_action_type_group>
   */ 
  procedure merge_action_type_group(
    p_ctg_id in adc_action_type_groups_v.ctg_id%type,
    p_ctg_name in adc_action_type_groups_v.ctg_name%type,
    p_ctg_description in adc_action_type_groups_v.ctg_description%type,
    p_ctg_active in adc_action_type_groups_v.ctg_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_ctg_id', p_ctg_id),
                    msg_param('p_ctg_name', p_ctg_name),
                    msg_param('p_ctg_description', p_ctg_description),
                    msg_param('p_ctg_active', p_ctg_active)));
                    
    l_row.ctg_id := p_ctg_id;
    l_row.ctg_name := p_ctg_name;
    l_row.ctg_description := utl_text.unwrap_string(p_ctg_description);
    l_row.ctg_active := adc_util.get_boolean(p_ctg_active);
    
    merge_action_type_group(l_row);

    pit.leave_mandatory;
  end merge_action_type_group;


  /**
    Procedure: merge_action_type_group
      See <ADC_ADMIN.merge_action_type_group>
   */ 
  procedure merge_action_type_group(
    p_row in out nocopy adc_action_type_groups_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_type_group(p_row);

    -- maintain translatable item
    l_pti_id := 'CTG_' || p_row.ctg_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.ctg_name,
      p_pti_description => p_row.ctg_description);

    -- store local data
    merge into adc_action_type_groups t
    using (select p_row.ctg_id ctg_id,
                  l_pti_id ctg_pti_id,
                  C_ADC ctg_pmg_name,
                  p_row.ctg_active ctg_active
             from dual) s
       on (t.ctg_id = s.ctg_id)
     when matched then update set
          t.ctg_active = s.ctg_active
     when not matched then insert(ctg_id, ctg_pti_id, ctg_pmg_name, ctg_active)
          values(s.ctg_id, s.ctg_pti_id, s.ctg_pmg_name, s.ctg_active);
    
    pit.leave_mandatory;
  end merge_action_type_group;


  /**
    Procedure: delete_action_type_group
      See <ADC_ADMIN.delete_action_type_group>
   */ 
  procedure delete_action_type_group(
    p_ctg_id in adc_action_type_groups_v.ctg_id%type)
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_ctg_id', p_ctg_id)));
    
    l_row.ctg_id := p_ctg_id;
    
    delete_action_type_group(l_row);
    
    pit.leave_mandatory;
  end delete_action_type_group;


  /**
    Procedure: delete_action_type_group
      See <ADC_ADMIN.delete_action_type_group>
   */ 
  procedure delete_action_type_group(
    p_row in adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_type_groups
     where ctg_id = p_row.ctg_id;
    
    pit.leave_mandatory;
  end delete_action_type_group;


  /**
    Procedure: validate_action_type_group
      See <ADC_ADMIN.validate_action_type_group>
   */ 
  procedure validate_action_type_group(
    p_row in adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.ctg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CTG_ID_MISSING');
    pit.assert_not_null(p_row.ctg_name, msg.ADC_PARAM_MISSING, p_error_code => 'CTG_NAME_MISSING');
    
    pit.leave_mandatory;
  end validate_action_type_group;
  
  
  /**
    Procedure: merge_action_param_type
      See <ADC_ADMIN.merge_action_param_type>
   */ 
  procedure merge_action_param_type(
    p_cpt_id in adc_action_param_types_v.cpt_id%type,
    p_cpt_name in adc_action_param_types_v.cpt_name%type,
    p_cpt_display_name in adc_action_param_types_v.cpt_display_name%type default null,
    p_cpt_description in adc_action_param_types_v.cpt_description%type default null,
    p_cpt_item_type in adc_action_param_types_v.cpt_item_type%type,
    p_cpt_active in adc_action_param_types_v.cpt_active%type default ADC_UTIL.C_TRUE)
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpt_id', p_cpt_id),
                    msg_param('p_cpt_name', p_cpt_name),
                    msg_param('p_cpt_display_name', p_cpt_display_name),
                    msg_param('p_cpt_description', p_cpt_description),
                    msg_param('p_cpt_item_type', p_cpt_item_type),
                    msg_param('p_cpt_active', p_cpt_active)));
                    
    l_row.cpt_id := p_cpt_id;
    l_row.cpt_name := p_cpt_name;
    l_row.cpt_display_name := p_cpt_display_name;
    l_row.cpt_description := utl_text.unwrap_string(p_cpt_description);
    l_row.cpt_item_type := p_cpt_item_type;
    l_row.cpt_active := adc_util.get_boolean(p_cpt_active);
    
    merge_action_param_type(l_row);
          
    pit.leave_mandatory;
  end merge_action_param_type;


  /**
    Procedure: merge_action_param_type
      See <ADC_ADMIN.merge_action_param_type>
   */ 
  procedure merge_action_param_type(
    p_row in out nocopy adc_action_param_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_param_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CPT_' || p_row.cpt_id;
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cpt_name,
      p_pti_display_name => p_row.cpt_display_name,
      p_pti_description => p_row.cpt_description);

    -- store local data
    merge into adc_action_param_types t
    using (select p_row.cpt_id cpt_id,
                  l_pti_id cpt_pti_id,
                  C_ADC cpt_pmg_name,
                  p_row.cpt_item_type cpt_item_type,
                  p_row.cpt_active cpt_active
             from dual) s
       on (t.cpt_id = s.cpt_id)
     when matched then update set
          t.cpt_item_type = s.cpt_item_type,
          t.cpt_active = s.cpt_active
     when not matched then insert(cpt_id, cpt_pti_id, cpt_pmg_name, cpt_item_type, cpt_active)
          values(s.cpt_id, s.cpt_pti_id, s.cpt_pmg_name, s.cpt_item_type, s.cpt_active);
    
    pit.leave_mandatory;
  end merge_action_param_type;


  /**
    Procedure: delete_action_param_type
      See <ADC_ADMIN.delete_action_param_type>
   */ 
  procedure delete_action_param_type(
    p_cpt_id in adc_action_param_types_v.cpt_id%type)
  as  
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cpt_id', p_cpt_id)));
    
    l_row.cpt_id := p_cpt_id;
    
    delete_action_param_type(l_row);
    
    pit.leave_mandatory;
  end delete_action_param_type;


  /**
    Procedure: delete_action_param_type
      See <ADC_ADMIN.delete_action_param_type>
   */ 
  procedure delete_action_param_type(
    p_row in adc_action_param_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_param_types
     where cpt_id = p_row.cpt_id;
    
    pit.leave_mandatory;
  end delete_action_param_type;
  
  
  /**
    Procedure: validate_action_param_type
      See <ADC_ADMIN.validate_action_param_type>
   */ 
  procedure validate_action_param_type(
    p_row in adc_action_param_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_not_null(p_row.cpt_id, msg.ADC_PARAM_MISSING, p_error_code => 'CPT_ID_MISSING');
    pit.assert_not_null(p_row.cpt_name, msg.ADC_PARAM_MISSING, p_error_code => 'CPT_NAME_MISSING');
    pit.assert_not_null(p_row.cpt_item_type, msg.ADC_PARAM_MISSING, p_error_code => 'CPT_ITEM_TYPE_MISSING');
    
    adc_validation.validate_param_lov(
      p_cpt_id => p_row.cpt_id,
      p_cpt_item_type => p_row.cpt_item_type);
    
    pit.leave_mandatory;
  end validate_action_param_type;

  /**
    Procedure: merge_action_item_focus
      See <ADC_ADMIN.merge_action_item_focus>
   */ 
  procedure merge_action_item_focus(
    p_cif_id in adc_action_item_focus_v.cif_id%type,
    p_cif_name in adc_action_item_focus_v.cif_name%type,
    p_cif_description in adc_action_item_focus_v.cif_description%type,
    p_cif_actual_page_only in adc_action_item_focus_v.cif_actual_page_only%type default adc_util.C_TRUE,
    p_cif_item_types in adc_action_item_focus_v.cif_item_types%type,
    p_cif_default adc_action_item_focus_v.cif_default%type,
    p_cif_active in adc_action_item_focus_v.cif_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cif_id', p_cif_id),
                    msg_param('p_cif_name', p_cif_name),
                    msg_param('p_cif_description', p_cif_description),
                    msg_param('p_cif_actual_page_only', p_cif_actual_page_only),
                    msg_param('p_cif_item_types', p_cif_item_types),
                    msg_param('p_cif_default', p_cif_default),
                    msg_param('p_cif_active', p_cif_active)));
                    
    l_row.cif_id := p_cif_id;
    l_row.cif_name := p_cif_name;
    l_row.cif_description := utl_text.unwrap_string(p_cif_description);
    l_row.cif_actual_page_only := adc_util.get_boolean(p_cif_actual_page_only);
    l_row.cif_item_types := p_cif_item_types;
    l_row.cif_default := p_cif_default;
    l_row.cif_active := adc_util.get_boolean(p_cif_active);
    
    merge_action_item_focus(l_row);
    
    pit.leave_mandatory;
  end merge_action_item_focus;


  /**
    Procedure: merge_action_item_focus
      See <ADC_ADMIN.merge_action_item_focus>
   */ 
  procedure merge_action_item_focus(
    p_row in out nocopy adc_action_item_focus_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_item_focus(p_row);
                    
    -- maintain translatable item
    l_pti_id := 'CIF_' || p_row.cif_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cif_name,
      p_pti_description => p_row.cif_description);

    -- store local data
    merge into adc_action_item_focus t
    using (select p_row.cif_id cif_id,
                  l_pti_id cif_pti_id,
                  C_ADC cif_pmg_name,
                  p_row.cif_actual_page_only cif_actual_page_only,
                  p_row.cif_item_types cif_item_types,
                  p_row.cif_default cif_default,
                  p_row.cif_active cif_active
             from dual) s
       on (t.cif_id = s.cif_id)
     when matched then update set
          t.cif_actual_page_only = s.cif_actual_page_only,
          t.cif_item_types = s.cif_item_types,
          t.cif_default = s.cif_default,
          t.cif_active = s.cif_active
     when not matched then insert(cif_id, cif_pti_id, cif_pmg_name, cif_actual_page_only, cif_item_types, cif_default, cif_active)
          values(s.cif_id, s.cif_pti_id, s.cif_pmg_name, s.cif_actual_page_only, s.cif_item_types, s.cif_default, s.cif_active);
    
    pit.leave_mandatory;
  end merge_action_item_focus;


  /**
    Procedure: delete_action_item_focus
      See <ADC_ADMIN.delete_action_item_focus>
   */ 
  procedure delete_action_item_focus(
    p_cif_id in adc_action_item_focus_v.cif_id%type)
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cif_id', p_cif_id)));
    
    l_row.cif_id := p_cif_id;
    
    delete_action_item_focus(l_row);
    
    pit.leave_mandatory;
  end delete_action_item_focus;


  /**
    Procedure: delete_action_item_focus
      See <ADC_ADMIN.delete_action_item_focus>
   */ 
  procedure delete_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_item_focus
     where cif_id = p_row.cif_id;
    
    pit.leave_mandatory;
  end delete_action_item_focus;
  

  /**
    Procedure: validate_action_item_focus
      See <ADC_ADMIN.validate_action_item_focus>
   */ 
  procedure validate_action_item_focus(
    p_row in adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_action_item_focus;



  /**
    Procedure: merge_action_type
      See <ADC_ADMIN.merge_action_type>
   */ 
  procedure merge_action_type(
    p_cat_id in adc_action_types_v.cat_id%type,
    p_cat_ctg_id in adc_action_types_v.cat_ctg_id%type,
    p_cat_cif_id in adc_action_types_v.cat_cif_id%type,
    p_cat_name in adc_action_types_v.cat_name%type,
    p_cat_display_name in adc_action_types_v.cat_display_name%type,
    p_cat_description in adc_action_types_v.cat_description%type default null,
    p_cat_pl_sql in adc_action_types_v.cat_pl_sql%type,
    p_cat_js in adc_action_types_v.cat_js%type,
    p_cat_is_editable in adc_action_types_v.cat_is_editable%type default adc_util.C_TRUE,
    p_cat_raise_recursive in adc_action_types_v.cat_raise_recursive%type default adc_util.C_TRUE,
    p_cat_active in adc_action_types_v.cat_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id),
                    msg_param('p_cat_ctg_id', p_cat_ctg_id),
                    msg_param('p_cat_cif_id', p_cat_cif_id),
                    msg_param('p_cat_name', p_cat_name),
                    msg_param('p_cat_display_name', p_cat_display_name),
                    msg_param('p_cat_description', p_cat_description),
                    msg_param('p_cat_pl_sql', p_cat_pl_sql),
                    msg_param('p_cat_js', p_cat_js),
                    msg_param('p_cat_is_editable', p_cat_is_editable),
                    msg_param('p_cat_raise_recursive', p_cat_raise_recursive),
                    msg_param('p_cat_active', p_cat_active)));
    
    l_row.cat_id := p_cat_id;
    l_row.cat_ctg_id := p_cat_ctg_id;
    l_row.cat_cif_id := p_cat_cif_id;
    l_row.cat_name := p_cat_name;
    l_row.cat_display_name := p_cat_display_name;
    l_row.cat_description := utl_text.unwrap_string(p_cat_description);
    l_row.cat_pl_sql := utl_text.unwrap_string(p_cat_pl_sql);
    l_row.cat_js := utl_text.unwrap_string(p_cat_js);
    l_row.cat_is_editable := adc_util.get_boolean(p_cat_is_editable);
    l_row.cat_raise_recursive := adc_util.get_boolean(p_cat_raise_recursive);
    l_row.cat_active := adc_util.get_boolean(p_cat_active);
    
    merge_action_type(l_row);
    
    pit.leave_mandatory;
  end merge_action_type;


  /**
    Procedure: merge_action_type
      See <ADC_ADMIN.merge_action_type>
   */ 
  procedure merge_action_type(
    p_row in adc_action_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;

    validate_action_type(p_row);
      
    -- maintain translatable item
    l_pti_id := 'CAT_' || p_row.cat_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cat_name,
      p_pti_display_name => p_row.cat_display_name,
      p_pti_description => p_row.cat_description);

    -- store local data
    merge into adc_action_types t
    using (select p_row.cat_id cat_id,
                  p_row.cat_ctg_id cat_ctg_id,
                  p_row.cat_cif_id cat_cif_id,
                  l_pti_id cat_pti_id,
                  C_ADC cat_pmg_name,
                  p_row.cat_pl_sql cat_pl_sql,
                  p_row.cat_js cat_js,
                  p_row.cat_is_editable cat_is_editable,
                  p_row.cat_raise_recursive cat_raise_recursive,
                  p_row.cat_active cat_active
             from dual) s
       on (t.cat_id = s.cat_id)
     when matched then update set
          t.cat_ctg_id = s.cat_ctg_id,
          t.cat_cif_id = s.cat_cif_id,
          t.cat_pl_sql = s.cat_pl_sql,
          t.cat_js = s.cat_js,
          t.cat_is_editable = s.cat_is_editable,
          t.cat_raise_recursive = s.cat_raise_recursive,
          t.cat_active = s.cat_active
     when not matched then insert(
            cat_id, cat_ctg_id, cat_cif_id, cat_pti_id, cat_pmg_name, cat_pl_sql, cat_js,
            cat_is_editable, cat_raise_recursive, cat_active)
          values (
            s.cat_id, s.cat_ctg_id, s.cat_cif_id, s.cat_pti_id, s.cat_pmg_name, s.cat_pl_sql, s.cat_js,
            s.cat_is_editable, s.cat_raise_recursive, s.cat_active);
      
    pit.leave_mandatory;
  end merge_action_type;


  /**
    Procedure: delete_action_type
      See <ADC_ADMIN.delete_action_type>
   */ 
  procedure delete_action_type(
    p_cat_id in adc_action_types_v.cat_id%type)
  as
    l_row adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cat_id', p_cat_id)));
    
    l_row.cat_id := p_cat_id;
    
    delete_action_type(l_row);
    
    pit.leave_mandatory;
  end delete_action_type;


  /**
    Procedure: delete_action_type
      See <ADC_ADMIN.delete_action_type>
   */
  procedure delete_action_type(
    p_row in adc_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_action_types
     where cat_id = p_row.cat_id;
      
    pit.leave_mandatory;
  end delete_action_type;
  

  /**
    Procedure: validate_action_type
      See <ADC_ADMIN.validate_action_type>
   */
  procedure validate_action_type(
    p_row in adc_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
  
    pit.assert_not_null(p_row.cat_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_ID_MISSING');
    pit.assert_not_null(p_row.cat_ctg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_CTG_ID_MISSING');
    pit.assert_not_null(p_row.cat_cif_id, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_CIF_ID_MISSING');
    pit.assert_not_null(p_row.cat_name, msg.ADC_PARAM_MISSING, p_error_code => 'CAT_NAME_MISSING');
    
    pit.leave_mandatory;
  exception
    when others then
      pit.leave_mandatory;
      raise;
  end validate_action_type;


  /**
    Function: export_action_types
      See <ADC_ADMIN.export_action_types>
   */
  function export_action_types(
    p_cat_is_editable in adc_action_types.cat_is_editable%type default adc_util.C_TRUE)
    return blob
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_ACTION_TYPE';
    C_WRAP_START constant varchar2(5) := 'q''{';
    C_WRAP_END constant varchar2(5) := '}''';
    l_action_param_types clob;
    l_page_item_types clob;
    l_action_item_focus clob;
    l_action_type_groups clob;
    l_action_type_list clob_table;
    l_action_types clob;
    l_apex_action_types clob;
    l_cur sys_refcursor;
    l_stmt clob;
    l_zip_file blob;
    l_zip_file_name adc_util.ora_name_type;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_cat_is_editable', p_cat_is_editable)));
    
    case p_cat_is_editable
    when adc_util.C_TRUE then
      l_zip_file_name := 'action_types_user.sql';
    when adc_util.C_FALSE then
      l_zip_file_name := 'action_types_system.sql';
    else
      l_zip_file_name := 'action_types_all.sql';
    end case;

    select utl_text.generate_text(cursor(
            select p.uttm_text template,
                   spt.cpt_id, spt.cpt_name, adc_util.to_bool(spt.cpt_active) cpt_active,
                   utl_text.wrap_string(spt.cpt_description, C_WRAP_START, C_WRAP_END) cpt_description,
                   cpt_item_type, cpt_display_name
              from adc_action_param_types_v spt
           ), C_CR)
      into l_action_param_types
      from utl_text_templates p
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'PARAM_TYPE';

    select utl_text.generate_text(cursor(
            select p.uttm_text template,
                   cit_id, cit_name, 
                   adc_util.to_bool(cit_has_value) cit_has_value, 
                   adc_util.to_bool(cit_include_in_view) cit_include_in_view, 
                   cit_event, 
                   utl_text.wrap_string(cit_col_template, C_WRAP_START, C_WRAP_END) cit_col_template, 
                   utl_text.wrap_string(cit_init_template, C_WRAP_START, C_WRAP_END) cit_init_template, 
                   adc_util.to_bool(cit_is_custom_event) cit_is_custom_event
              from adc_page_item_types_v
          ))
      into l_page_item_types
      from utl_text_templates p
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'PAGE_ITEM_TYPE';

    select utl_text.generate_text(cursor(
            select p.uttm_text template,
                   cif_id, cif_name, adc_util.to_bool(cif_active) cif_active, cif_default,
                   utl_text.wrap_string(cif_description, C_WRAP_START, C_WRAP_END) cif_description,
                   adc_util.to_bool(cif_actual_page_only) cif_actual_page_only, cif_item_types
              from adc_action_item_focus_v
           ), C_CR)
      into l_action_item_focus
      from utl_text_templates p
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'ITEM_FOCUS';

    select utl_text.generate_text(cursor(
            select p.uttm_text template,
                   stg.ctg_id, stg.ctg_name, adc_util.to_bool(stg.ctg_active) ctg_active,
                   utl_text.wrap_string(stg.ctg_description, C_WRAP_START, C_WRAP_END) ctg_description
              from adc_action_type_groups_v stg
           ), C_CR)
      into l_action_type_groups
      from utl_text_templates p
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'ACTION_TYPE_GROUP';

    select utl_text.generate_text(cursor(
            select p.uttm_text template,
                   cty_id, cty_name, adc_util.to_bool(cty_active) cty_active,
                   utl_text.wrap_string(cty_description, C_WRAP_START, C_WRAP_END) cty_description
              from adc_apex_action_types_v 
           ), C_CR)
      into l_apex_action_types
      from utl_text_templates p
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'APEX_ACTION_TYPE';

    -- Collect action types. Different API for performance and size reasons
    dbms_lob.createtemporary(l_action_types, false, dbms_lob.call);
    open l_cur for         
       with params as (
              select uttm_mode, uttm_text template, null cat_is_editable
                from utl_text_templates
               where uttm_type = C_ADC
                 and uttm_name = C_UTTM_NAME)
       select p.template,
              cat.cat_id, cat.cat_ctg_id, cat.cat_cif_id, cat.cat_name,
              utl_text.wrap_string(cat.cat_display_name, C_WRAP_START, C_WRAP_END) cat_display_name,
              utl_text.wrap_string(cat.cat_description, C_WRAP_START, C_WRAP_END) cat_description,
              utl_text.wrap_string(cat.cat_pl_sql, C_WRAP_START, C_WRAP_END) cat_pl_sql,
              utl_text.wrap_string(cat.cat_js, C_WRAP_START, C_WRAP_END) cat_js,
              adc_util.to_bool(cat.cat_is_editable) cat_is_editable,
              adc_util.to_bool(cat.cat_raise_recursive) cat_raise_recursive,
              -- rule action_params
              utl_text.generate_text(cursor(
                select p.template, ap.cap_cat_id, ap.cap_cpt_id, ap.cap_sort_seq,
                       adc_util.to_bool(ap.cap_mandatory) cap_mandatory,
                       adc_util.to_bool(ap.cap_active) cap_active,
                       utl_text.wrap_string(ap.cap_default, C_WRAP_START, C_WRAP_END) cap_default,
                       utl_text.wrap_string(ap.cap_description, C_WRAP_START, C_WRAP_END) cap_description,
                       cap_display_name
                  from adc_action_parameters_v ap
                 cross join params p
                 where uttm_mode = 'ACTION_PARAMS'
                   and ap.cap_cat_id = cat.cat_id
              ), C_CR) rule_action_params
         from adc_action_types_v cat
        cross join params p
        where (cat.cat_is_editable = p.cat_is_editable
           or p.cat_is_editable is null)
          and p.uttm_mode = 'ACTION_TYPE';
    utl_text.generate_text_table(l_cur, l_action_type_list);

    for i in 1 .. l_action_type_list.count loop
      dbms_lob.append(l_action_types, l_action_type_list(i));
    end loop;

    -- create export statement
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    l_action_param_types action_param_types,
                    l_page_item_types page_item_types,
                    l_action_item_focus action_item_focus,
                    l_action_type_groups action_type_groups,
                    l_action_types action_types,
                    l_apex_action_types apex_action_types
               from dual
           ), C_CR) resultat
      into l_stmt
      from utl_text_templates
     where uttm_type = C_ADC
       and uttm_name = C_UTTM_NAME
       and uttm_mode = C_FRAME;
       
    
    apex_zip.add_file(
      p_zipped_blob => l_zip_file,
      p_file_name => l_zip_file_name,
      p_content => utl_text.clob_to_blob(l_stmt));

    apex_zip.finish(l_zip_file);

    pit.leave_mandatory(p_params => msg_params(msg_param('ZIP file size', dbms_lob.getlength(l_zip_file))));
    return l_zip_file;
  end export_action_types;


  /**
    Procedure: merge_action_parameter
      See <ADC_ADMIN.merge_action_parameter>
   */
  procedure merge_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters_v.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type,
    p_cap_default in adc_action_parameters_v.cap_default%type,
    p_cap_description in adc_action_parameters_v.cap_description%type,
    p_cap_display_name in adc_action_parameters_v.cap_display_name%type,
    p_cap_mandatory in adc_action_parameters_v.cap_mandatory%type,
    p_cap_active in adc_action_parameters_v.cap_active%type default adc_util.C_TRUE)
  as
    l_row adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id),
                    msg_param('p_cap_cpt_id', p_cap_cpt_id),
                    msg_param('p_cap_sort_seq', to_char(p_cap_sort_seq)),
                    msg_param('p_cap_default', p_cap_default),
                    msg_param('p_cap_description', p_cap_description),
                    msg_param('p_cap_display_name', p_cap_display_name),
                    msg_param('p_cap_mandatory', p_cap_mandatory),
                    msg_param('p_cap_active', p_cap_active)));
    
    l_row.cap_cat_id := p_cap_cat_id;
    l_row.cap_cpt_id := p_cap_cpt_id;
    l_row.cap_sort_seq := p_cap_sort_seq;
    l_row.cap_default := p_cap_default;
    l_row.cap_description := utl_text.unwrap_string(p_cap_description);
    l_row.cap_display_name := p_cap_display_name;
    l_row.cap_mandatory := p_cap_mandatory;
    l_row.cap_active := adc_util.get_boolean(p_cap_active);
    
    merge_action_parameter(l_row);
    
    pit.enter_mandatory;
  end merge_action_parameter;


  /**
    Procedure: merge_action_parameter
      See <ADC_ADMIN.merge_action_parameter>
   */
  procedure merge_action_parameter(
    p_row in out nocopy adc_action_parameters_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_action_parameter(p_row);
                    
    -- maintain translatable item
    select 'CAP_' || p_row.cap_cat_id || '_PARAM_' || p_row.cap_sort_seq
      into l_pti_id
      from dual;

    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cap_display_name,
      p_pti_description => p_row.cap_description);

    -- store local data
    merge into adc_action_parameters t
    using (select p_row.cap_cat_id cap_cat_id,
                  p_row.cap_cpt_id cap_cpt_id,
                  p_row.cap_sort_seq cap_sort_seq,
                  p_row.cap_default cap_default,
                  l_pti_id cap_pti_id,
                  C_ADC cap_pmg_name,
                  p_row.cap_mandatory cap_mandatory,
                  p_row.cap_active cap_active
             from dual) s
       on (t.cap_cat_id = s.cap_cat_id
      and t.cap_cpt_id = s.cap_cpt_id
      and t.cap_sort_seq = s.cap_sort_seq)
     when matched then update set
          t.cap_pti_id = s.cap_pti_id,
          t.cap_default = s.cap_default,
          t.cap_mandatory = s.cap_mandatory,
          t.cap_active = s.cap_active
     when not matched then insert(cap_cat_id, cap_cpt_id, cap_sort_seq, cap_default, cap_pti_id, cap_pmg_name, cap_mandatory, cap_active)
          values(s.cap_cat_id, s.cap_cpt_id, s.cap_sort_seq, s.cap_default, s.cap_pti_id, s.cap_pmg_name, s.cap_mandatory, s.cap_active);
    
    pit.leave_mandatory;
  end merge_action_parameter;
  
  
  /**
    Procedure: delete_action_parameter
      See <ADC_ADMIN.delete_action_parameter>
   */
  procedure delete_action_parameter(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type,
    p_cap_cpt_id in adc_action_parameters_v.cap_cpt_id%type,
    p_cap_sort_seq in adc_action_parameters_v.cap_sort_seq%type)
  as
    l_row adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id),
                    msg_param('p_cap_cpt_id', p_cap_cpt_id),
                    msg_param('p_cap_sort_seq', p_cap_sort_seq)));
                    
    l_row.cap_cat_id := p_cap_cat_id;
    l_row.cap_cpt_id := p_cap_cpt_id;
    l_row.cap_sort_seq := p_cap_sort_seq;
    
    delete_action_parameter(l_row);
    
    pit.leave_mandatory;
  end delete_action_parameter;      


  /**
    Procedure: delete_action_parameter
      See <ADC_ADMIN.delete_action_parameter>
   */
  procedure delete_action_parameter(
    p_row in adc_action_parameters_v%rowtype)
  as
  begin
                    
    delete from adc_action_parameters
     where cap_cat_id = p_row.cap_cat_id
       and cap_cpt_id = p_row.cap_cpt_id
       and cap_sort_seq = p_row.cap_sort_seq;
    
    pit.leave_mandatory;
  end delete_action_parameter;
  
  
  /**
    Procedure: delete_action_parameters
      See <ADC_ADMIN.delete_action_parameters>
   */
  procedure delete_action_parameters(
    p_cap_cat_id in adc_action_parameters_v.cap_cat_id%type)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cap_cat_id', p_cap_cat_id)));
                    
    delete from adc_action_parameters
     where cap_cat_id = p_cap_cat_id;
    
    pit.leave_mandatory;
  end delete_action_parameters;
    

  /**
    Procedure: validate_action_parameter
      See <ADC_ADMIN.validate_action_parameter>
   */
  procedure validate_action_parameter(
    p_row in adc_action_parameters_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_action_parameter;
  
  
  /**
    Procedure: merge_page_item_type
      See <ADC_ADMIN.merge_page_item_type>
   */
  procedure merge_page_item_type(
    p_cit_id              in adc_page_item_types_v.cit_id%type,
    p_cit_name            in adc_page_item_types_v.cit_name%type,
    p_cit_has_value       in adc_page_item_types_v.cit_has_value%type,
    p_cit_include_in_view in adc_page_item_types_v.cit_include_in_view%type,
    p_cit_event           in adc_page_item_types_v.cit_event%type,
    p_cit_col_template    in adc_page_item_types_v.cit_col_template%type,
    p_cit_init_template   in adc_page_item_types_v.cit_init_template%type,
    p_cit_is_custom_event in adc_page_item_types_v.cit_is_custom_event%type) 
  as
    l_row adc_page_item_types_v%rowtype;
  begin
    pit.enter_mandatory;

    l_row.cit_id := p_cit_id;
    l_row.cit_name := p_cit_name;
    l_row.cit_has_value := p_cit_has_value;
    l_row.cit_include_in_view := p_cit_include_in_view;
    l_row.cit_event := p_cit_event;
    l_row.cit_col_template := p_cit_col_template;
    l_row.cit_init_template := p_cit_init_template;
    l_row.cit_is_custom_event := p_cit_is_custom_event;
    
    merge_page_item_type(l_row);

    pit.leave_mandatory;
  end merge_page_item_type;
  
  
  /**
    Procedure: merge_page_item_type
      See <ADC_ADMIN.merge_page_item_type>
   */
  procedure merge_page_item_type(
    p_row in out nocopy adc_page_item_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_page_item_type(p_row);
    
    -- maintain translatable item
    l_pti_id := 'CIT_' || p_row.cit_id;
    
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cit_name);

    merge into adc_page_item_types t
    using (select p_row.cit_id cit_id,
                  l_pti_id cit_pti_id,
                  C_ADC cit_pmg_name,
                  p_row.cit_has_value cit_has_value,
                  p_row.cit_include_in_view cit_include_in_view,
                  p_row.cit_event cit_event,
                  p_row.cit_col_template cit_col_template,
                  p_row.cit_init_template cit_init_template,
                  p_row.cit_is_custom_event cit_is_custom_event
             from dual) s
       on (t.cit_id = s.cit_id)
     when matched then update set
            t.cit_has_value = s.cit_has_value,
            t.cit_include_in_view = s.cit_include_in_view,
            t.cit_event = s.cit_event,
            t.cit_col_template = s.cit_col_template,
            t.cit_init_template = s.cit_init_template,
            t.cit_is_custom_event = s.cit_is_custom_event
     when not matched then insert(
            t.cit_id, t.cit_pti_id, t.cit_pmg_name, t.cit_has_value, t.cit_include_in_view, t.cit_event, t.cit_col_template, t.cit_init_template, t.cit_is_custom_event)
          values(
            s.cit_id, s.cit_pti_id, s.cit_pmg_name, s.cit_has_value, s.cit_include_in_view, s.cit_event, s.cit_col_template, s.cit_init_template, s.cit_is_custom_event);

    pit.leave_mandatory;
  end merge_page_item_type;


  /**
    Procedure: delete_page_item_type
      See <ADC_ADMIN.delete_page_item_type>
   */
  procedure delete_page_item_type(
    p_row in adc_page_item_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_page_item_types
     where cit_id = p_row.cit_id;

    pit.leave_mandatory;
  end delete_page_item_type;
  
  
  /**
    Procedure: validate_page_item_type
      See <ADC_ADMIN.validate_page_item_type>
   */
  procedure validate_page_item_type(
    p_row in adc_page_item_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    -- TODO: Add tests here
    null;

    pit.leave_mandatory;
  end validate_page_item_type;
  
  
  /**
    Group: Public Methods - APEX Action Methods
   */
  /**
    Procedure: merge_apex_action_type
      See <ADC_ADMIN.merge_apex_action_type>
   */ 
  procedure merge_apex_action_type(
    p_cty_id in adc_apex_action_types_v.cty_id%type,
    p_cty_name in adc_apex_action_types_v.cty_name%type,
    p_cty_description in adc_apex_action_types_v.cty_description%type,
    p_cty_active in adc_apex_action_types_v.cty_active%type)
  as
    l_row adc_apex_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cty_id', p_cty_id),
                    msg_param('p_cty_name', p_cty_name),
                    msg_param('p_cty_description', p_cty_description),
                    msg_param('p_cty_active', p_cty_active)));
                    
    l_row.cty_id := p_cty_id;
    l_row.cty_name := p_cty_name;
    l_row.cty_description := utl_text.unwrap_string(p_cty_description);
    l_row.cty_active := adc_util.get_boolean(p_cty_active);
    
    merge_apex_action_type(l_row);
    
    pit.leave_mandatory;
  end merge_apex_action_type;
  
  
  /**
    Procedure: merge_apex_action_type
      See <ADC_ADMIN.merge_apex_action_type>
   */ 
  procedure merge_apex_action_type(
    p_row in out nocopy adc_apex_action_types_v%rowtype)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    validate_apex_action_type(p_row);

    -- maintain translatable item
    l_pti_id := 'CTY_' || p_row.cty_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.cty_name,
      p_pti_description => p_row.cty_description);

    -- store local data
    merge into adc_apex_action_types t
    using (select p_row.cty_id cty_id,
                  l_pti_id cty_pti_id,
                  C_ADC cty_pmg_name,
                  p_row.cty_active cty_active
             from dual) s
       on (t.cty_id = s.cty_id)
     when matched then update set
            t.cty_active = s.cty_active
     when not matched then insert(t.cty_id, t.cty_pti_id, t.cty_pmg_name, t.cty_active)
          values(s.cty_id, s.cty_pti_id, s.cty_pmg_name, s.cty_active);
      
    pit.leave_mandatory;
  end merge_apex_action_type;


  /**
    Procedure: delete_apex_action_type
      See <ADC_ADMIN.delete_apex_action_type>
   */ 
  procedure delete_apex_action_type(
    p_cty_id in adc_apex_action_types_v.cty_id%type)
  as
    l_row adc_apex_action_types_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cty_id', p_cty_id)));
     
    l_row.cty_id := p_cty_id;
    delete_apex_action_type(l_row);
    
    pit.leave_mandatory;
  end delete_apex_action_type;


  /**
    Procedure: delete_apex_action_type
      See <ADC_ADMIN.delete_apex_action_type>
   */ 
  procedure delete_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from adc_apex_action_types
     where cty_id = p_row.cty_id;
    
    pit.leave_mandatory;
  end delete_apex_action_type;
  
  
  /**
    Procedure: validate_apex_action_type
      See <ADC_ADMIN.validate_apex_action_type>
   */ 
  procedure validate_apex_action_type(
    p_row in adc_apex_action_types_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Enter validation */
    
    pit.leave_mandatory;
  end validate_apex_action_type;


  /**
    Procedure: merge_apex_action
      See <ADC_ADMIN.merge_apex_action>
   */ 
  procedure merge_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type,
    p_caa_cgr_id in adc_apex_actions_v.caa_cgr_id%type,
    p_caa_cty_id in adc_apex_actions_v.caa_cty_id%type,
    p_caa_name in adc_apex_actions_v.caa_name%type,
    p_caa_label in adc_apex_actions_v.caa_label%type,
    p_caa_context_label in adc_apex_actions_v.caa_context_label%type default null,
    p_caa_icon in adc_apex_actions_v.caa_icon%type default null,
    p_caa_icon_type in adc_apex_actions_v.caa_icon_type%type default 'fa',
    p_caa_title in adc_apex_actions_v.caa_title%type default null,
    p_caa_shortcut in adc_apex_actions_v.caa_shortcut%type default null,
    p_caa_initially_disabled in adc_apex_actions_v.caa_initially_disabled%type default 0,
    p_caa_initially_hidden in adc_apex_actions_v.caa_initially_hidden%type default 0,
    -- ACTION
    p_caa_href in adc_apex_actions_v.caa_href%type default null,
    p_caa_action in adc_apex_actions_v.caa_action%type default null,
    -- TOGGLE
    p_caa_on_label in adc_apex_actions_v.caa_on_label%type default null,
    p_caa_off_label in adc_apex_actions_v.caa_off_label%type default null,
    -- TOGGLE | RADIO_GROUP
    p_caa_get in adc_apex_actions_v.caa_get%type default null,
    p_caa_set in adc_apex_actions_v.caa_set%type default null,
    -- RADIO_GROUP
    p_caa_choices in adc_apex_actions_v.caa_choices%type default null,
    p_caa_label_classes in adc_apex_actions_v.caa_label_classes%type default null,
    p_caa_label_start_classes in adc_apex_actions_v.caa_label_start_classes%type default null,
    p_caa_label_end_classes in adc_apex_actions_v.caa_label_end_classes%type default null,
    p_caa_item_wrap_class in adc_apex_actions_v.caa_item_wrap_class%type default null)
  as
    l_row adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caa_id', p_caa_id),
                    msg_param('p_caa_cgr_id', p_caa_cgr_id),
                    msg_param('p_caa_cty_id', p_caa_cty_id),
                    msg_param('p_caa_name', p_caa_name),
                    msg_param('p_caa_label', p_caa_label),
                    msg_param('p_caa_context_label', p_caa_context_label),
                    msg_param('p_caa_icon', p_caa_icon),
                    msg_param('p_caa_icon_type', p_caa_icon_type),
                    msg_param('p_caa_title', p_caa_title),
                    msg_param('p_caa_shortcut', p_caa_shortcut),
                    msg_param('p_caa_initially_disabled', p_caa_initially_disabled),
                    msg_param('p_caa_initially_hidden', p_caa_initially_hidden),
                    msg_param('p_caa_href', p_caa_href),
                    msg_param('p_caa_action', p_caa_action),
                    msg_param('p_caa_on_label', p_caa_on_label),
                    msg_param('p_caa_off_label', p_caa_off_label),
                    msg_param('p_caa_get', p_caa_get),
                    msg_param('p_caa_set', p_caa_set),
                    msg_param('p_caa_choices', p_caa_choices),
                    msg_param('p_caa_label_classes', p_caa_label_classes),
                    msg_param('p_caa_label_start_classes', p_caa_label_start_classes),
                    msg_param('p_caa_label_end_classes', p_caa_label_end_classes),
                    msg_param('p_caa_item_wrap_class', p_caa_item_wrap_class)));
    
    l_row.caa_id := p_caa_id;
    l_row.caa_cgr_id := p_caa_cgr_id;
    l_row.caa_cty_id := p_caa_cty_id;
    l_row.caa_name := p_caa_name;
    l_row.caa_label := p_caa_label;
    l_row.caa_context_label := p_caa_context_label;
    l_row.caa_icon := p_caa_icon;
    l_row.caa_icon_type := p_caa_icon_type;
    l_row.caa_title := p_caa_title;
    l_row.caa_shortcut := p_caa_shortcut;
    l_row.caa_initially_disabled := adc_util.get_boolean(p_caa_initially_disabled);
    l_row.caa_initially_hidden := adc_util.get_boolean(p_caa_initially_hidden);
    l_row.caa_href := p_caa_href;
    l_row.caa_action := p_caa_action;
    l_row.caa_on_label := p_caa_on_label;
    l_row.caa_off_label := p_caa_off_label;
    l_row.caa_get := p_caa_get;
    l_row.caa_set := p_caa_set;
    l_row.caa_choices := p_caa_choices;
    l_row.caa_label_classes := p_caa_label_classes;
    l_row.caa_label_start_classes := p_caa_label_start_classes;
    l_row.caa_label_end_classes := p_caa_label_end_classes;
    l_row.caa_item_wrap_class := p_caa_item_wrap_class;
    
    merge_apex_action(l_row);

    pit.leave_mandatory;
  end merge_apex_action;


  /**
    Procedure: merge_apex_action
      See <ADC_ADMIN.merge_apex_action>
   */ 
  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_cai_list in char_table default null)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;

    validate_apex_action(p_row);
    
    get_key(p_row.caa_id);    

    -- maintain translatable item
    l_pti_id := 'CAA_' || p_row.caa_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_ADC,
      p_pti_name => p_row.caa_label,
      p_pti_display_name => p_row.caa_title,
      p_pti_description => p_row.caa_context_label);

    merge into adc_apex_actions t
    using (select p_row.caa_id caa_id,
                  p_row.caa_cgr_id caa_cgr_id,
                  p_row.caa_name caa_name,
                  l_pti_id caa_pti_id,
                  C_ADC caa_pmg_name,
                  p_row.caa_cty_id caa_cty_id,
                  p_row.caa_icon caa_icon,
                  p_row.caa_icon_type caa_icon_type,
                  p_row.caa_title caa_title,
                  p_row.caa_shortcut caa_shortcut,
                  p_row.caa_initially_disabled caa_initially_disabled,
                  p_row.caa_initially_hidden caa_initially_hidden,
                  p_row.caa_href caa_href,
                  p_row.caa_action caa_action,
                  p_row.caa_on_label caa_on_label,
                  p_row.caa_off_label caa_off_label,
                  p_row.caa_get caa_get,
                  p_row.caa_set caa_set,
                  p_row.caa_choices caa_choices,
                  p_row.caa_label_classes caa_label_classes,
                  p_row.caa_label_start_classes caa_label_start_classes,
                  p_row.caa_label_end_classes caa_label_end_classes,
                  p_row.caa_item_wrap_class caa_item_wrap_class
             from dual) s
       on (t.caa_id = s.caa_id)
     when matched then update set
            t.caa_name = s.caa_name,
            t.caa_cty_id = s.caa_cty_id,
            t.caa_pti_id = s.caa_pti_id,
            t.caa_pmg_name = s.caa_pmg_name,
            t.caa_icon = s.caa_icon,
            t.caa_icon_type = s.caa_icon_type,
            t.caa_shortcut = s.caa_shortcut,
            t.caa_initially_disabled = s.caa_initially_disabled,
            t.caa_initially_hidden = s.caa_initially_hidden,
            t.caa_href = s.caa_href,
            t.caa_action = s.caa_action,
            t.caa_get = s.caa_get,
            t.caa_set = s.caa_set,
            t.caa_on_label = s.caa_on_label,
            t.caa_off_label = s.caa_off_label,
            t.caa_choices = s.caa_choices,
            t.caa_label_classes = s.caa_label_classes,
            t.caa_label_start_classes = s.caa_label_start_classes,
            t.caa_label_end_classes = s.caa_label_end_classes,
            t.caa_item_wrap_class = s.caa_item_wrap_class
     when not matched then insert(
            t.caa_id, t.caa_cgr_id, t.caa_name, t.caa_cty_id, t.caa_pti_id, t.caa_pmg_name, t.caa_icon, t.caa_icon_type,
            t.caa_shortcut, t.caa_initially_disabled, t.caa_initially_hidden, t.caa_href, t.caa_action,
            t.caa_get, t.caa_set, t.caa_on_label, t.caa_off_label, t.caa_choices, t.caa_label_classes, t.caa_label_start_classes,
            t.caa_label_end_classes, t.caa_item_wrap_class)
          values(
            s.caa_id, s.caa_cgr_id, s.caa_name, s.caa_cty_id, s.caa_pti_id, s.caa_pmg_name, s.caa_icon, s.caa_icon_type,
            s.caa_shortcut, s.caa_initially_disabled, s.caa_initially_hidden, s.caa_href, s.caa_action,
            s.caa_get, s.caa_set, s.caa_on_label, s.caa_off_label, s.caa_choices, s.caa_label_classes, s.caa_label_start_classes,
            s.caa_label_end_classes, s.caa_item_wrap_class);
    
    -- Register connected items by deleting and re-assigning them
    delete from adc_apex_action_items
     where cai_caa_id = p_row.caa_id
       and cai_cpi_cgr_id = p_row.caa_cgr_id;
       
    if p_caa_cai_list is not null then
      for i in 1 .. p_caa_cai_list.count loop
        merge_apex_action_item(
          p_cai_caa_id => p_row.caa_id,
          p_cai_cpi_cgr_id => p_row.caa_cgr_id,
          p_cai_cpi_id => p_caa_cai_list(i),
          p_cai_active => adc_util.C_TRUE);
      end loop;
    end if;
    
    pit.leave_mandatory;
  end merge_apex_action;


  /**
    Procedure: delete_apex_action
      See <ADC_ADMIN.delete_apex_action>
   */ 
  procedure delete_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type)
  as
    l_row adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caa_id', p_caa_id)));
                    
    l_row.caa_id := p_caa_id;
    
    delete_apex_action(l_row);

    pit.leave_mandatory;
  end delete_apex_action;


  /**
    Procedure: delete_apex_action
      See <ADC_ADMIN.delete_apex_action>
   */ 
  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;

    delete from adc_apex_actions
     where caa_id = p_row.caa_id;

    pit.leave_mandatory;
  end delete_apex_action;


  /**
    Procedure: validate_apex_action
      See <ADC_ADMIN.validate_apex_action>
   */ 
  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    /** TODO: Add validation*/
    
    pit.leave_mandatory;
  end validate_apex_action;


  /**
    Procedure: merge_apex_action_item
      See <ADC_ADMIN.merge_apex_action_item>
   */ 
  procedure merge_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type,
    p_cai_cpi_cgr_id in adc_apex_action_items.cai_cpi_cgr_id%type,
    p_cai_cpi_id in adc_apex_action_items.cai_cpi_id%type,
    p_cai_active in adc_apex_action_items.cai_active%type)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cai_caa_id', p_cai_caa_id),
                    msg_param('p_cai_cpi_cgr_id', p_cai_cpi_cgr_id),
                    msg_param('p_cai_cpi_id', p_cai_cpi_id),
                    msg_param('p_cai_active', p_cai_active)));
                    
    l_row.cai_caa_id := p_cai_caa_id;
    l_row.cai_cpi_cgr_id := p_cai_cpi_cgr_id;
    l_row.cai_cpi_id := p_cai_cpi_id;
    l_row.cai_active := adc_util.get_boolean(p_cai_active);
    
    merge_apex_action_item(l_row);
            
    pit.leave_mandatory;
  end merge_apex_action_item;


  /**
    Procedure: merge_apex_action_item
      See <ADC_ADMIN.merge_apex_action_item>
   */ 
  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    validate_apex_action_item(p_row);
                    
    merge into adc_apex_action_items t
    using (select p_row.cai_caa_id cai_caa_id,
                  p_row.cai_cpi_cgr_id cai_cpi_cgr_id,
                  p_row.cai_cpi_id cai_cpi_id,
                  p_row.cai_active cai_active
             from dual) s
       on (t.cai_caa_id = s.cai_caa_id
       and t.cai_cpi_cgr_id = s.cai_cpi_cgr_id
       and t.cai_cpi_id = s.cai_cpi_id)
     when matched then update set
            t.cai_active = s.cai_active
     when not matched then insert(t.cai_caa_id, t.cai_cpi_cgr_id, t.cai_cpi_id, t.cai_active)
          values(s.cai_caa_id, s.cai_cpi_cgr_id, s.cai_cpi_id, s.cai_active);
      
    pit.leave_mandatory;
  end merge_apex_action_item;


  /**
    Procedure: delete_apex_action_item
      See <ADC_ADMIN.delete_apex_action_item>
   */ 
  procedure delete_apex_action_item(
    p_cai_caa_id in adc_apex_action_items.cai_caa_id%type)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cai_caa_id', p_cai_caa_id)));
                    
    l_row.cai_caa_id := p_cai_caa_id;
    
    delete_apex_action_item(l_row);
    
    pit.leave_mandatory;
  end delete_apex_action_item;


  /**
    Procedure: delete_apex_action_item
      See <ADC_ADMIN.delete_apex_action_item>
   */ 
  procedure delete_apex_action_item(
    p_row adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
                    
    delete from adc_apex_action_items
     where cai_caa_id = p_row.cai_caa_id;
    
    pit.leave_mandatory;
  end delete_apex_action_item;
  
  
  /**
    Procedure: validate_apex_action_item
      See <ADC_ADMIN.validate_apex_action_item>
   */ 
  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory('validate_apex_action_item');
    
    /** TODO: Add validation */
    
    pit.leave_mandatory;
  end validate_apex_action_item;

begin
  initialize;
end adc_admin;
/