create or replace package body adc_config
as

  C_ADC constant adc_util.ora_name_type := 'ADC';
  C_FRAME constant adc_util.ora_name_type := 'FRAME';
  C_DEFAULT constant adc_util.ora_name_type := 'DEFAULT';

  C_REGEX_ITEM constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
  C_REGEX_CSS constant varchar2(50 byte) := q'~'.+'~';
  C_PIPE constant adc_util.tiny_char := '|';
  C_REGISTER_ADDITIONAL_ITEMS constant adc_util.ora_name_type := 'REGISTER_ADDITIONAL_ITEM';

  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;
  g_crg_id adc_rule_groups.crg_id%type;

  /**
    Group: Private Methods
      Internal helper methods for harmonization, export integration and
      maintenance of ADC configuration data.
   */
  /**
    Procedure: get_key
      Assigns a new technical ID from <ADC_SEQ> if the given key is null.

    Parameter:
      p_key - Technical ID to initialize on demand
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
    Procedure: create_decision_table
      Regenerates the stored decision table view definition for a rule group.

    Parameter:
      p_crg_id - Rule group whose generated SQL view is refreshed
   */
  procedure create_decision_table(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'RULE_VIEW';
    l_stmt clob;
  begin
    pit.enter_optional('create_decision_table',
      p_params => msg_params(msg_param('p_crg_id', p_crg_id)));

    with params as(
           select /*+ no_merge */
                  uttm_text template, uttm_log_text log_template,
                  uttm_name, uttm_mode, p_crg_id g_crg_id,
                  adc_util.C_TRUE c_true,
                  adc_util.C_CR cr
             from utl_text_templates_v
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select template, log_template, g_crg_id crg_id,
                    utl_text.generate_text(cursor(
                      select template, cet_id, lower(cet_column_name) cet_column_name
                        from adc_event_types_v
                        join params
                          on uttm_mode = case cet_is_custom_event when c_true then 'EVENT' else upper(cet_id) end
                       where (cet_is_custom_event = c_true
                          or cet_id in ('initialize', 'command', 'notification'))
                       order by case cet_is_custom_event when c_true then 1 else 0 end, cet_id), ',' || CR, 14) event_list,
                    utl_text.generate_text(cursor(
                      select cpit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cpit_cet_id
                        from adc_page_item_types_v sit
                        left join (
                               select cpi_id, cpi_cpit_id, cpi_conversion, cpi_is_required
                                 from adc_page_items
                                where cpi_crg_id = g_crg_id) cpi
                          on sit.cpit_id = cpi.cpi_cpit_id
                        join params p
                          on C_TRUE in (cpi_is_required, cpit_include_in_view)
                       where cpit_col_template is not null
                         and uttm_mode = 'WHERE_CLAUSE'
                       order by cpit_include_in_view desc, cpi_id), ',' || CR, 14) column_list,
                    coalesce(
                      utl_text.generate_text(cursor(
                        select template, cru_id, cru_name, cru_condition, cru_firing_items,
                               row_number() over (order by cru_id) sort_seq
                          from adc_rules
                          join params p
                            on cru_crg_id in (0, g_crg_id)
                           and cru_active = c_true
                         where uttm_mode = 'WHERE_CLAUSE'
                         order by cru_id), CR || '           or '),
                      to_clob('null is null')) where_clause,
                    utl_text.generate_text(cursor(
                      select template, 'EVENT' cpi_id from params where uttm_mode = 'ACTUAL_STATUS' union all
                      select template, 'EVENT_DATA' cpi_id from params where uttm_mode = 'ACTUAL_STATUS' union all
                      select template, 'FIRING_ITEM' cpi_id from params where uttm_mode = 'ACTUAL_STATUS' union all
                      select template, cpi_id
                        from adc_page_items
                        join params p
                          on cpi_crg_id = g_crg_id
                         and cpi_may_have_value = c_true
                         and cpi_is_required = c_true
                       where uttm_mode = 'ACTUAL_STATUS'
                       order by cpi_id), ',' || CR, 16) actual_status
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = C_FRAME;

    update adc_rule_groups
       set crg_decision_table = l_stmt
     where crg_id = p_crg_id;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_decision_table;

  /**
    Procedure: reset_page_item_status
      Resets derived status information for all page items of a rule group.

    Parameter:
      p_crg_id - Rule group whose page item state is reset
   */
  procedure reset_page_item_status(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_optional('reset_page_item_status');
    update adc_page_items
       set cpi_is_required = adc_util.C_FALSE,
           cpi_has_error = adc_util.C_TRUE,
           cpi_validation_method = null
     where cpi_crg_id = p_crg_id;
    pit.leave_optional;
  end reset_page_item_status;

  /**
    Procedure: mark_required_fields
      Synchronizes the page item base set from the view layer into
      <ADC_PAGE_ITEMS> for a rule group.

    Parameter:
      p_crg_id - Rule group whose page items are synchronized
   */
  procedure mark_required_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    l_cpi_id adc_page_items.cpi_id%type;
  begin
    pit.enter_detailed('mark_required_fields');
    g_crg_id := p_crg_id;

    merge into adc_page_items t
    using (select cpi_crg_id,
                  cpi_cpit_id,
                  cpi_caat_id,
                  cpi_id,
                  cpi_label,
                  cpi_conversion,
                  cpi_item_default,
                  cpi_css,
                  adc_util.C_FALSE cpi_has_error,
                  cpi_is_required,
                  cpi_is_mandatory,
                  cpi_may_have_value,
                  cpi_form_region_id
             from adc_bl_page_targets
            where cpi_id is not null) s
       on (t.cpi_id = s.cpi_id and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_cpit_id = s.cpi_cpit_id,
          t.cpi_caat_id = s.cpi_caat_id,
          t.cpi_label = s.cpi_label,
          t.cpi_conversion = s.cpi_conversion,
          t.cpi_item_default = s.cpi_item_default,
          t.cpi_css = s.cpi_css,
          t.cpi_has_error = s.cpi_has_error,
          t.cpi_is_required = s.cpi_is_required,
          t.cpi_is_mandatory = s.cpi_is_mandatory,
          t.cpi_may_have_value = s.cpi_may_have_value,
          t.cpi_form_region_id = s.cpi_form_region_id
     when not matched then insert(
            cpi_id, cpi_cpit_id, cpi_caat_id, cpi_label, cpi_crg_id,
            cpi_conversion, cpi_item_default, cpi_css, cpi_is_required,
            cpi_is_mandatory, cpi_may_have_value, cpi_form_region_id)
          values(
            s.cpi_id, s.cpi_cpit_id, s.cpi_caat_id, s.cpi_label, s.cpi_crg_id,
            s.cpi_conversion, s.cpi_item_default, s.cpi_css, s.cpi_is_required,
            s.cpi_is_mandatory, s.cpi_may_have_value, s.cpi_form_region_id);

    g_crg_id := null;
    pit.leave_detailed;
  exception
    when msg.ORA_INSTABLE_ROW_GROUP_ERR then
      select cpi_id
        into l_cpi_id
        from adc_bl_page_targets
       where cpi_crg_id = p_crg_id
       group by cpi_id
      having count(*) > 1;
      g_crg_id := null;
      pit.raise_error(msg.ADC_NON_UNIQUE_STATIC_ID, msg_args(to_char(p_crg_id), l_cpi_id));
  end mark_required_fields;

  /**
    Procedure: mark_rule_condition_items
      Marks all page items referenced by firing items or by a new rule
      condition as required.

    Parameters:
      p_crg_id - Rule group whose condition dependencies are analyzed
      p_new_condition - Optional new condition to include before persistence
   */
  procedure mark_rule_condition_items(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_new_condition in adc_rules.cru_condition%type default null)
  as
  begin
    pit.enter_detailed('mark_rule_condition_items');

    merge into adc_page_items t
     using (select distinct cpi_crg_id, cpi_id
             from (select crg_id cpi_crg_id, i.column_value cpi_id
                     from adc_rules
                     join adc_rule_groups
                       on cru_crg_id = crg_id
                    cross join table(utl_text.string_to_table(cru_firing_items, ',')) i
                    where crg_id = p_crg_id
                    union all
                   select cpi_crg_id, cpi_id
                     from adc_page_items cpi
                    where (regexp_instr(upper(p_new_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
                       or instr(cpi.cpi_css, replace(regexp_substr(p_new_condition, C_REGEX_CSS), adc_util.C_APOS, C_PIPE)) > 0)
                      and cpi_crg_id = p_crg_id)) s
       on (t.cpi_id = s.cpi_id and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_is_required = adc_util.C_TRUE
          where cpi_has_error = adc_util.C_FALSE;

    pit.leave_detailed;
  end mark_rule_condition_items;

  /**
    Procedure: mark_auto_validate_fields
      Stores generated validation method calls for fields affected by
      VALIDATE_ITEMS actions.

    Parameter:
      p_crg_id - Rule group whose validation metadata is maintained
   */
  procedure mark_auto_validate_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('mark_auto_validate_fields');

    merge into adc_page_items t
    using (with data as(
                  select cra_param_1, cra_param_2
                    from adc_rule_actions
                   where cra_crg_id = p_crg_id
                     and cra_cat_id = 'VALIDATE_ITEMS')
           select p_crg_id cpi_crg_id,
                  column_value cpi_id,
                  case
                    when instr(cra_param_2, '#ITEM#') > 0 then
                      replace(replace(cra_param_2, '#ITEM#', column_value), ';')
                    else
                      replace(cra_param_2, ';') || '(''' || column_value || ''')'
                    end cpi_validation_method,
                  adc_util.c_true cpi_is_required
             from data
            cross join table(
                  select utl_text.string_to_table(cra_param_1)
                    from data)) s
       on (t.cpi_id = s.cpi_id and t.cpi_crg_id = s.cpi_crg_id)
     when matched then update set
          t.cpi_validation_method = s.cpi_validation_method,
          t.cpi_is_required = s.cpi_is_required
          where t.cpi_has_error = (select adc_util.C_FALSE from dual);

    pit.leave_detailed;
  end mark_auto_validate_fields;

  /**
    Procedure: maintain_additional_items
      Normalizes the REGISTER_ADDITIONAL_ITEM action to only keep still
      relevant page items.

    Parameter:
      p_crg_id - Rule group whose additional-item registration is maintained
   */
  procedure maintain_additional_items(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    l_additional_items char_table;
  begin
    pit.enter_detailed('maintain_additional_items');

    select utl_text.string_to_table(cra_param_1)
      into l_additional_items
      from adc_rule_actions
     where cra_crg_id = p_crg_id
       and cra_cat_id = C_REGISTER_ADDITIONAL_ITEMS;

    select cast(multiset(
             select cpi_id
               from adc_page_items
               join table (l_additional_items)
                 on cpi_id = column_value
              where cpi_crg_id = p_crg_id
                and cpi_is_required = (select adc_util.C_FALSE from dual)
                and cpi_has_error = (select adc_util.C_FALSE from dual)) as char_table)
      into l_additional_items
      from dual;

    if l_additional_items.count > 0 then
      update adc_rule_actions
         set cra_param_1 = utl_text.table_to_string(l_additional_items, ':')
       where cra_crg_id = p_crg_id
         and cra_cat_id = C_REGISTER_ADDITIONAL_ITEMS;
    else
      delete from adc_rule_actions
       where cra_crg_id = p_crg_id
         and cra_cat_id = C_REGISTER_ADDITIONAL_ITEMS;
    end if;

    pit.leave_detailed;
  exception
    when no_data_found then
      pit.leave_detailed;
  end maintain_additional_items;

  /**
    Procedure: remove_irrelevant_fields
      Removes derived page item rows that are no longer required and are not
      referenced by any rule action.

    Parameter:
      p_crg_id - Rule group whose obsolete page item rows are cleaned up
   */
  procedure remove_irrelevant_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('remove_irrelevant_fields');

    delete from adc_page_items
     where cpi_crg_id = p_crg_id
       and cpi_is_required = adc_util.C_FALSE
       and cpi_has_error = adc_util.C_TRUE
       and cpi_id not in (
           select cra_cpi_id
             from adc_rule_actions
            where cra_crg_id = p_crg_id);

    pit.leave_detailed;
  end remove_irrelevant_fields;

  /**
    Procedure: mark_error_fields
      Propagates page item errors to dependent rules and rule actions.

    Parameter:
      p_crg_id - Rule group whose error flags are recalculated
   */
  procedure mark_error_fields(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('mark_error_fields');

    update adc_rules
       set cru_has_error = adc_util.C_FALSE
     where cru_crg_id = p_crg_id;

    merge into adc_rules t
    using (select distinct cru.cru_id
             from adc_page_items cpi
             join adc_rules cru
               on utl_text.contains(cru_firing_items, cpi_id) = adc_util.C_TRUE
            where cpi_crg_id = p_crg_id
              and cpi_has_error = adc_util.C_TRUE) s
       on (t.cru_id = s.cru_id)
     when matched then update set
          t.cru_has_error = adc_util.C_TRUE;

    update adc_rule_actions
       set cra_has_error = adc_util.C_FALSE
     where cra_crg_id = p_crg_id;

    merge into adc_rule_actions t
    using (select cpi_crg_id cra_crg_id, cpi_id cra_cpi_id
             from adc_page_items
            where cpi_crg_id = p_crg_id
              and cpi_has_error = adc_util.C_TRUE) s
       on (t.cra_crg_id = s.cra_crg_id
       and t.cra_cpi_id = s.cra_cpi_id)
     when matched then update set
          t.cra_has_error = adc_util.C_TRUE;

    pit.leave_detailed;
  end mark_error_fields;

  /**
    Procedure: harmonize_adc_page_item
      Rebuilds the derived page item model for a rule group.

    Parameters:
      p_crg_id - Rule group to harmonize
      p_new_condition - Optional transient rule condition to include
   */
  procedure harmonize_adc_page_item(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_new_condition in adc_rules.cru_condition%type default null)
  as
  begin
    pit.enter_optional('harmonize_adc_page_item',
      p_params => msg_params(msg_param('p_crg_id', p_crg_id)));

    reset_page_item_status(p_crg_id);
    mark_required_fields(p_crg_id);
    mark_rule_condition_items(p_crg_id, p_new_condition);
    mark_auto_validate_fields(p_crg_id);
    maintain_additional_items(p_crg_id);
    remove_irrelevant_fields(p_crg_id);
    mark_error_fields(p_crg_id);

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.ADC_INITIALZE_CRG_FAILED, msg_args(to_char(p_crg_id), sqlerrm));
  end harmonize_adc_page_item;

  /**
    Procedure: harmonize_firing_items
      Recalculates the firing item list of all active rules in a rule group.

    Parameter:
      p_crg_id - Rule group whose firing item lists are refreshed
   */
  procedure harmonize_firing_items(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_detailed('harmonize_firing_items',
      p_params => msg_params(msg_param('p_crg_id', p_crg_id)));

    merge into adc_rules t
    using (select cru.cru_id,
                  listagg(cpi.cpi_id, ',') within group (order by cpi.cpi_id) cru_firing_items
             from adc_page_items cpi
             join adc_rules cru
               on cpi.cpi_crg_id = cru.cru_crg_id
              and (regexp_instr(upper(cru.cru_condition), replace(C_REGEX_ITEM, '#ITEM#', cpi.cpi_id)) > 0
               or instr(cpi.cpi_css, replace(regexp_substr(cru.cru_condition, C_REGEX_CSS), adc_util.C_APOS, C_PIPE)) > 0)
            where cpi.cpi_crg_id = p_crg_id
              and cru.cru_active = adc_util.C_TRUE
            group by cru.cru_id) s
       on (t.cru_id = s.cru_id)
     when matched then update set
          t.cru_firing_items = s.cru_firing_items;

    pit.leave_detailed;
  end harmonize_firing_items;

  /**
    Function: export_apex_application
      Exports an APEX application as installation script text.

    Parameter:
      p_app_id - APEX application ID to export

    Returns:
      Export script as CLOB
   */
  function export_apex_application(
    p_app_id in binary_integer)
    return clob
  as
    l_export_file apex_t_export_files;
  begin
    pit.enter_optional('export_apex_application',
      p_params => msg_params(msg_param('p_app_id', p_app_id)));

    l_export_file := apex_export.get_application(
                       p_application_id => p_app_id,
                       p_with_ir_public_reports => true,
                       p_with_supporting_objects => 'N');

    pit.leave_optional;
    return l_export_file(1).contents;
  end export_apex_application;

  /**
    Function: integrate_rule_groups_into_app
      Injects a rule group export into an APEX application export script.

    Parameters:
      p_crg_app_id - APEX application ID
      p_rule_group - Generated rule group script
      p_install_id - Installation script ID used in the generated prefix

    Returns:
      Combined application export including rule group installation
   */
  function integrate_rule_groups_into_app(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_rule_group in clob,
    p_install_id in number)
    return clob
  as
    C_MAX_LENGTH constant pls_integer := 30000;
    C_END_COMMENT constant utl_apex.small_char := q'^prompt --application/end_environment^';
    l_offset pls_integer := 1;
    l_add_amount pls_integer;
    l_amount pls_integer := C_MAX_LENGTH;
    l_length pls_integer;
    l_buffer utl_apex.max_char;
    l_script clob;
    l_prefix adc_util.max_char;
    l_no_end_comment_found boolean := true;
  begin
    pit.enter_optional('integrate_rule_groups_into_app',
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_install_id', p_install_id)));

    l_script := export_apex_application(p_crg_app_id);
    l_length := length(l_script);

    while l_offset < l_length and l_no_end_comment_found loop
      l_add_amount := length(C_END_COMMENT);
      l_amount := l_amount + l_add_amount;

      dbms_lob.read(l_script, l_amount, l_offset, l_buffer);
      if instr(l_buffer, C_END_COMMENT) > 0 then
        l_amount := l_amount + 1000;
        dbms_lob.read(l_script, l_amount, l_offset, l_buffer);
        dbms_lob.append(l_script, substr(l_buffer, 1, instr(l_buffer, C_END_COMMENT) - 1));

        select replace(uttm_text, '#CRG_INSTALL_ID#', p_install_id)
          into l_prefix
          from utl_text_templates_v
         where uttm_type = C_ADC
           and uttm_name = 'EXPORT_RULE_GROUP'
           and uttm_mode = 'DEFAULT_APP_PREFIX';

        dbms_lob.append(l_script, l_prefix);
        dbms_lob.append(l_script, p_rule_group);
        dbms_lob.append(l_script, substr(l_buffer, instr(l_buffer, C_END_COMMENT)));
        l_no_end_comment_found := false;
      else
        l_amount := l_amount - l_add_amount;
        dbms_lob.append(l_script, substr(l_buffer, 1, length(l_buffer) - l_add_amount));
      end if;

      l_offset := l_offset + l_amount;
    end loop;

    pit.leave_optional;
    return l_script;
  end integrate_rule_groups_into_app;

  /**
    Procedure: validate_export_rule_groups
      Validates preconditions for grouped rule export operations.

    Parameter:
      p_crg_app_id - APEX application ID to validate
   */
  procedure validate_export_rule_groups(
    p_crg_app_id in out nocopy adc_rule_groups.crg_app_id%type)
  as
  begin
    pit.enter_optional('validate_export_rule_groups',
      p_params => msg_params(msg_param('p_crg_app_id', p_crg_app_id)));
    pit.assert_not_null(p_crg_app_id, msg.ADC_PARAM_MISSING, p_error_code => 'APP_ID_MISSING');
    pit.leave_optional;
  exception
    when others then
      pit.stop;
  end validate_export_rule_groups;


  function map_id(
    p_id in number default null)
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


  function get_crg_id
    return adc_rule_groups.crg_id%type
  as
  begin
    return g_crg_id;
  end get_crg_id;


  procedure merge_rule_group(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type,
    p_crg_id in adc_rule_groups.crg_id%type default null,
    p_crg_with_recursion in adc_rule_groups.crg_with_recursion%type default adc_util.C_TRUE,
    p_crg_active in adc_rule_groups.crg_active%type default adc_util.C_TRUE)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id),
                    msg_param('p_crg_id', p_crg_id),
                    msg_param('p_crg_with_recursion', p_crg_with_recursion),
                    msg_param('p_crg_active', p_crg_active)));

    l_row.crg_app_id := p_crg_app_id;
    l_row.crg_page_id := p_crg_page_id;
    l_row.crg_id := p_crg_id;
    l_row.crg_with_recursion := adc_util.get_boolean(p_crg_with_recursion);
    l_row.crg_active := adc_util.get_boolean(p_crg_active);

    merge_rule_group(l_row);

    pit.leave_mandatory;
  end merge_rule_group;


  procedure merge_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;

    validate_rule_group(p_row);
    get_key(p_row.crg_id);

    merge into adc_rule_groups t
    using (select p_row.crg_id crg_id,
                  p_row.crg_app_id crg_app_id,
                  p_row.crg_page_id crg_page_id,
                  coalesce(p_row.crg_with_recursion, adc_util.C_TRUE) crg_with_recursion,
                  coalesce(p_row.crg_active, adc_util.C_TRUE) crg_active
             from dual) s
       on (t.crg_id = s.crg_id and t.crg_app_id = s.crg_app_id)
     when matched then update set
          t.crg_page_id = s.crg_page_id,
          t.crg_with_recursion = s.crg_with_recursion,
          t.crg_active = s.crg_active
     when not matched then insert(crg_id, crg_app_id, crg_page_id, crg_with_recursion, crg_active)
          values(s.crg_id, s.crg_app_id, s.crg_page_id, s.crg_with_recursion, s.crg_active);

    harmonize_adc_page_item(p_row.crg_id);

    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE_GROUP, msg_args(to_char(p_row.crg_id)));
  end merge_rule_group;


  procedure delete_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
    l_row adc_rule_groups%rowtype;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_crg_id', p_crg_id)));
    l_row.crg_id := p_crg_id;
    delete_rule_group(l_row);
    pit.leave_mandatory;
  end delete_rule_group;


  procedure delete_rule_group(
    p_row in out nocopy adc_rule_groups%rowtype)
  as
  begin
    pit.enter_mandatory;
    delete from adc_rule_groups where crg_id = p_row.crg_id;
    pit.leave_mandatory;
  end delete_rule_group;


  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_mandatory;
    pit.assert_not_null(p_row.crg_app_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_APP_ID_MISSING');
    pit.assert_not_null(p_row.crg_page_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_PAGE_ID_MISSING');

    if p_row.crg_id is null then
      open l_cur for
        select null
          from adc_rule_groups
         where crg_app_id = p_row.crg_app_id
           and crg_page_id = p_row.crg_page_id;
      pit.assert_not_exists(
        p_cursor => l_cur,
        p_message_name => msg.ADC_CRG_MUST_BE_UNIQUE,
        p_msg_args => null,
        p_affected_id => 'CRG_PAGE_ID');
    end if;

    pit.leave_mandatory;
  end validate_rule_group;


  procedure toggle_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_crg_id', p_crg_id)));
    update adc_rule_groups
       set crg_active = case crg_active when adc_util.c_true then adc_util.c_false else adc_util.c_true end
     where crg_id = p_crg_id;
    pit.leave_mandatory;
  end toggle_rule_group;


  function validate_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'VALIDATE_RULE_GROUP_EXPORT';
    l_error_list clob;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_crg_id', p_crg_id)));

    harmonize_adc_page_item(p_crg_id);

    with params as (
           select uttm_mode, uttm_text template,
                  crg_id, crg_app_id
             from adc_rule_groups
            cross join utl_text_templates_v
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and crg_id = p_crg_id
              and exists(
                  select null
                    from adc_page_items
                   where cpi_crg_id = crg_id
                     and cpi_has_error = adc_util.C_TRUE))
    select utl_text.generate_text(cursor(
             select template,
                    utl_text.generate_text(cursor(
                      select p.template, p.crg_app_id, cpi.cpi_id
                        from adc_page_items cpi
                        join adc_page_item_types_v sit
                          on cpi.cpi_cpit_id = sit.cpit_id
                        join params p
                          on cpi.cpi_crg_id = p.crg_id
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


  procedure propagate_rule_change(
    p_crg_id in adc_rule_groups.crg_id%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_crg_id', p_crg_id)));
    harmonize_firing_items(p_crg_id);
    harmonize_adc_page_item(p_crg_id);
    create_decision_table(p_crg_id);
    resequence_rule(p_crg_id);
    pit.leave_mandatory;
  end propagate_rule_change;


  function export_rule_group(
    p_crg_id in adc_rule_groups.crg_id%type,
    p_mode in varchar2 default C_APP_GROUPS,
    p_install_id in number default null)
    return clob
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'EXPORT_RULE_GROUP';
    l_stmt_frame clob;
    l_stmt clob;
  begin
    utl_text.set_secondary_anchor_char('§');

    with params as (
           select uttm_mode, uttm_text template,
                  case p_mode when C_APEX_APP then 'DEFAULT_APP' else C_DEFAULT end g_mode,
                  crg_id, crg_app_id, crg_page_id,
                  adc_util.to_bool(crg_active) crg_active,
                  adc_util.to_bool(crg_with_recursion) crg_with_recursion,
                  p_install_id crg_install_id
             from utl_text_templates_v
            cross join adc_rule_groups
            where uttm_type = C_ADC
              and uttm_name = C_UTTM_NAME
              and crg_id = p_crg_id)
    select utl_text.generate_text(cursor(
             select template, crg_id, crg_app_id, crg_page_id, crg_active, crg_with_recursion,
                    utl_text.generate_text(cursor(
                      select p.template, caa_id, caa_crg_id, caa_caat_id, caa_name, caa_label, caa_context_label,
                             caa_icon, caa_icon_type, caa_title, caa_shortcut, caa_confirm_message_name,
                             adc_util.to_bool(caa_initially_disabled) caa_initially_disabled,
                             adc_util.to_bool(caa_initially_hidden) caa_initially_hidden,
                             caa_href, caa_action, caa_on_label, caa_off_label, caa_get, caa_set, caa_choices,
                             caa_label_classes, caa_label_start_classes, caa_label_end_classes, caa_item_wrap_class,
                             utl_text.generate_text(cursor(
                               select p.template, caai_caa_id, caai_cpi_crg_id, caai_cpi_id,
                                      adc_util.to_bool(caai_active) caai_active
                                 from adc_apex_action_items sai
                                 join params p
                                   on p.uttm_mode = 'APEX_ACTION_ITEM'
                                where caai_caa_id = saa.caa_id
                             )) apex_action_items
                        from adc_apex_actions_v saa
                        join params p
                          on p.uttm_mode = 'APEX_ACTION_' || saa.caa_caat_id
                       where caa_crg_id = crg_id
                    )) apex_actions,
                    utl_text.generate_text(cursor(
                      select p.template, cru_id, cru_crg_id, cru_name, cru_condition, cru_sort_seq,
                             cru_firing_items, adc_util.to_bool(cru_active) cru_active,
                             adc_util.to_bool(cru_fire_on_page_load) cru_fire_on_page_load,
                             utl_text.generate_text(cursor(
                               select p.template, cra_id, cra_crg_id, cra_cru_id, cra_cpi_id, cra_cat_id,
                                      adc_util.to_bool(cra_on_error) cra_on_error,
                                      cra_param_1, cra_param_2, cra_param_3, cra_comment, cra_sort_seq,
                                      adc_util.to_bool(cra_raise_recursive) cra_raise_recursive,
                                      adc_util.to_bool(cra_raise_on_validation) cra_raise_on_validation,
                                      adc_util.to_bool(cra_active) cra_active
                                 from adc_rule_actions a
                                cross join params p
                                where uttm_mode = 'RULE_ACTION'
                                  and cra_cru_id = r.cru_id
                             )) rule_actions
                        from adc_rules r
                        join params p
                          on r.cru_crg_id = p.crg_id
                       where p.uttm_mode = 'RULE'
                    )) rules
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = g_mode;

    if p_mode = C_APEX_APP then
      l_stmt := replace(replace(utl_text.wrap_string(l_stmt), ' ||', ','), '\CR\');
      select utl_text.generate_text(cursor(
               select uttm_text template, crg_id * crg_id crg_id_square, lower(page_alias) crg_page_alias,
                      crg_sort_seq, p_install_id crg_install_id
                 from (select crg.*, rank() over (partition by crg_app_id order by crg_page_id) * 10 crg_sort_seq
                         from adc_rule_groups crg)
                 join apex_application_pages
                   on crg_app_id = application_id
                  and crg_page_id = page_id
                where crg_id = p_crg_id)) frame
        into l_stmt_frame
        from utl_text_templates_v
       where uttm_type = C_ADC
         and uttm_name = C_UTTM_NAME
         and uttm_mode = 'DEFAULT_APP_FRAME';
      l_stmt := utl_text.clob_replace(l_stmt_frame, '#CRG_SCRIPT#', l_stmt);
    end if;
    return l_stmt;
  end export_rule_group;


  function export_rule_groups(
    p_crg_app_id in adc_rule_groups.crg_app_id%type default null,
    p_mode in varchar2 default C_APP_GROUPS)
    return blob
  as
    cursor rule_group_cur(
      p_crg_app_id in adc_rule_groups.crg_app_id%type)
    is
      select crg_id, a.alias app_alias, p.page_alias, lower(a.alias || '_' || p.page_alias) crg_file_name
        from adc_rule_groups
        join apex_applications a
          on crg_app_id = a.application_id
        join apex_application_pages p
          on crg_app_id = p.application_id
         and crg_page_id = p.page_id
       where crg_app_id = p_crg_app_id
       order by p.page_id;

    l_zip_file blob;
    l_clob clob;
    l_blob blob;
    l_file_name varchar2(100);
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_app_alias adc_util.ora_name_type;
    l_install_id number;
    l_embed_rule_groups boolean;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_mode', p_mode)));

    dbms_lob.createtemporary(l_clob, false, dbms_lob.call);
    l_crg_app_id := p_crg_app_id;

    validate_export_rule_groups(p_crg_app_id => l_crg_app_id);

    if p_mode = C_APEX_APP then
      l_install_id := trunc(dbms_random.value * 100000000);
      l_embed_rule_groups := param.get_boolean('ADC_EMBED_RULE_GROUPS', 'ADC');

      if l_embed_rule_groups then
        for crg in rule_group_cur(l_crg_app_id) loop
          dbms_lob.append(
            l_clob,
            export_rule_group(
              p_crg_id => crg.crg_id,
              p_mode => p_mode,
              p_install_id => l_install_id));
        end loop;

        l_clob := integrate_rule_groups_into_app(
                    p_crg_app_id => p_crg_app_id,
                    p_rule_group => l_clob,
                    p_install_id => l_install_id);
        l_blob := utl_text.clob_to_blob(l_clob);

        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => 'application.sql',
          p_content => l_blob);
      else
        for crg in rule_group_cur(l_crg_app_id) loop
          l_app_alias := crg.app_alias;
          l_blob := utl_text.clob_to_blob(
                      export_rule_group(
                        p_crg_id => crg.crg_id,
                        p_mode => p_mode,
                        p_install_id => l_install_id));
          l_file_name := replace(param.get_string('RULE_GROUP_FILENAME', C_ADC), '#CRG_FILE_NAME#', crg.crg_file_name);
          apex_zip.add_file(
            p_zipped_blob => l_zip_file,
            p_file_name => l_file_name,
            p_content => l_blob);
        end loop;

        l_blob := utl_text.clob_to_blob(export_apex_application(p_crg_app_id));
        l_file_name := utl_text.bulk_replace(param.get_string('APPLICATION_FILENAME', C_ADC), char_table(
                         '#ALIAS#', upper(l_app_alias),
                         '#alias#', lower(l_app_alias),
                         '#APP_ID#', p_crg_app_id));
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
      end if;
    else
      for crg in rule_group_cur(l_crg_app_id) loop
        l_blob := utl_text.clob_to_blob(
                    export_rule_group(
                      p_crg_id => crg.crg_id,
                      p_mode => p_mode));
        l_file_name := replace(param.get_string('RULE_GROUP_FILENAME', C_ADC), '#CRG_FILE_NAME#', crg.crg_file_name);
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
      end loop;
    end if;

    apex_zip.finish(l_zip_file);

    pit.leave_mandatory(
      p_params => msg_params(msg_param('ZIP file size', dbms_lob.getlength(l_zip_file))));
    return l_zip_file;
  end export_rule_groups;

  /**
    Procedure: prepare_rule_group_import
      See <ADC_CONFIG.prepare_rule_group_import>
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2)
  as
    l_ws_id apex_applications.workspace_id%type;
    l_app_id apex_applications.application_id%type;
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
    apex_application_install.set_application_id(l_app_id);

    pit.leave_mandatory;
  exception
    when no_data_found then
      pit.raise_warn(msg.ADC_NO_RULE_GROUP_FOUND, msg_args(p_workspace, p_app_alias));
      pit.leave_mandatory;
  end prepare_rule_group_import;

  /**
    Procedure: prepare_rule_group_import
      See <ADC_CONFIG.prepare_rule_group_import>
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in adc_rule_groups.crg_app_id%type)
  as
    l_ws_id apex_applications.workspace_id%type;
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
    apex_application_install.set_application_id(p_app_id);

    pit.leave_mandatory;
  end prepare_rule_group_import;

  /**
    Procedure: prepare_rule_group_import
      See <ADC_CONFIG.prepare_rule_group_import>
   */
  procedure prepare_rule_group_import(
    p_crg_app_id in adc_rule_groups.crg_app_id%type,
    p_crg_page_id in adc_rule_groups.crg_page_id%type)
  as
  begin
    pit.enter_mandatory('prepare_rule_group_import',
      p_params => msg_params(
                    msg_param('p_crg_app_id', p_crg_app_id),
                    msg_param('p_crg_page_id', p_crg_page_id)));

    delete from adc_rule_groups
     where crg_app_id = p_crg_app_id
       and crg_page_id = p_crg_page_id;

    pit.leave_mandatory;
  end prepare_rule_group_import;

  /**
    Procedure: merge_rule
      See <ADC_CONFIG.merge_rule>
   */
  procedure merge_rule(
    p_cru_id in adc_rules.cru_id%type default null,
    p_cru_crg_id in adc_rules.cru_crg_id%type,
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
                    msg_param('p_cru_crg_id', p_cru_crg_id),
                    msg_param('p_cru_name', p_cru_name),
                    msg_param('p_cru_condition', p_cru_condition),
                    msg_param('p_cru_fire_on_page_load', p_cru_fire_on_page_load),
                    msg_param('p_cru_sort_seq', p_cru_sort_seq),
                    msg_param('p_cru_active', p_cru_active)));

    l_row.cru_id := p_cru_id;
    l_row.cru_crg_id := p_cru_crg_id;
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
      See <ADC_CONFIG.merge_rule>
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
                  p_row.cru_crg_id cru_crg_id,
                  p_row.cru_name cru_name,
                  p_row.cru_condition cru_condition,
                  coalesce(p_row.cru_fire_on_page_load, adc_util.C_FALSE) cru_fire_on_page_load,
                  coalesce(p_row.cru_sort_seq, 10) cru_sort_seq,
                  coalesce(p_row.cru_active, adc_util.C_TRUE) cru_active
             from dual) s
       on (t.cru_id = s.cru_id and t.cru_crg_id = s.cru_crg_id)
     when matched then update set
          t.cru_name = s.cru_name,
          t.cru_condition = s.cru_condition,
          t.cru_fire_on_page_load = s.cru_fire_on_page_load,
          t.cru_sort_seq = s.cru_sort_seq,
          t.cru_active = s.cru_active
     when not matched then insert(cru_id, cru_crg_id, cru_name, cru_condition, cru_fire_on_page_load, cru_sort_seq, cru_active)
          values (s.cru_id, s.cru_crg_id, s.cru_name, s.cru_condition, s.cru_fire_on_page_load, s.cru_sort_seq, s.cru_active);

    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.ADC_MERGE_RULE, msg_args(p_row.cru_name));
  end merge_rule;

  /**
    Procedure: delete_rule
      See <ADC_CONFIG.delete_rule>
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
      See <ADC_CONFIG.delete_rule>
   */
  procedure delete_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    delete from adc_rules where cru_id = p_row.cru_id;
    pit.leave_mandatory;
  end delete_rule;

  /**
    Procedure: validate_rule_condition
      See <ADC_CONFIG.validate_rule_condition>
   */
  procedure validate_rule_condition(
    p_row in adc_rules%rowtype)
  as
    C_UTTM_NAME constant adc_util.ora_name_type := 'RULE_VALIDATION';
    l_stmt utl_apex.max_char;
    l_ctx pls_integer;
  begin
    pit.enter_mandatory('validate_rule_condition');

    pit.assert_not_null(p_row.cru_condition, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CONDITION_MISSING');
    harmonize_adc_page_item(p_row.cru_crg_id, p_row.cru_condition);

    with params as(
           select /*+ no_merge */ uttm_text template, uttm_mode,
                  p_row.cru_crg_id crg_id,
                  p_row.cru_condition condition,
                  adc_util.c_true c_true,
                  adc_util.C_CR cr
             from utl_text_templates_v
            where uttm_type = C_ADC
              and uttm_name in (C_UTTM_NAME, 'RULE_VIEW'))
    select utl_text.generate_text(cursor(
             select p.template, p.condition, crg_id,
                    utl_text.generate_text(cursor(
                      select template, cet_id, lower(cet_column_name) cet_column_name
                        from adc_event_types_v
                        join params
                          on uttm_mode = case cet_is_custom_event when c_true then 'EVENT' else upper(cet_id) end
                       where (cet_is_custom_event = c_true
                          or cet_id in ('initialize', 'command'))
                       order by case cet_is_custom_event when c_true then 1 else 0 end, cet_id), ',' || CR, 14) event_list,
                    utl_text.generate_text(cursor(
                      select cpit_col_template template,
                             replace(cpi_conversion, 'G') conversion,
                             cpi_id item,
                             cpit_cet_id
                        from adc_page_item_types_v sit
                        left join (
                               select cpi_id, cpi_cpit_id, cpi_conversion, cpi_is_required
                                 from adc_page_items
                                where cpi_crg_id = crg_id) cpi
                          on sit.cpit_id = cpi.cpi_cpit_id
                       where adc_util.C_TRUE in (cpi_is_required, cpit_include_in_view)
                         and cpit_col_template is not null
                      order by cpit_include_in_view desc, cpi_id), ',' || CR, 14) column_list
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = C_DEFAULT;

    begin
      l_ctx := dbms_sql.open_cursor;
      dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
      adc_util.close_cursor(l_ctx);
    exception
      when others then
        adc_util.close_cursor(l_ctx);
        pit.raise_error(msg.ADC_INVALID_SQL, msg_args(substr(sqlerrm, 12)));
    end;

    pit.leave_mandatory;
  end validate_rule_condition;

  /**
    Procedure: validate_rule
      See <ADC_CONFIG.validate_rule>
   */
  procedure validate_rule(
    p_row in adc_rules%rowtype)
  as
  begin
    pit.enter_mandatory;
    pit.assert_not_null(p_row.cru_crg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_CRG_ID_MISSING');
    pit.assert_not_null(p_row.cru_name, msg.ADC_PARAM_MISSING, p_error_code => 'CRU_NAME_MISSING');
    validate_rule_condition(p_row);
    pit.leave_mandatory;
  end validate_rule;

  /**
    Procedure: resequence_rule
      See <ADC_CONFIG.resequence_rule>
   */
  procedure resequence_rule(
    p_cru_id in adc_rules.cru_id%type)
  as
    l_crg_id adc_rule_groups.crg_id%type;
  begin
    pit.enter_optional('resequence_rule',
      p_params => msg_params(msg_param('p_cru_id', p_cru_id)));

    begin
      select cru_crg_id
        into l_crg_id
        from adc_rules
       where cru_id = p_cru_id;
    exception
      when no_data_found then
        l_crg_id := p_cru_id;
    end;

    merge into adc_rules t
    using (select cru_id, cru_crg_id,
                  row_number() over (partition by cru_crg_id order by cru_sort_seq) * 10 cru_sort_seq
             from adc_rules
            where cru_crg_id = l_crg_id
              and cru_crg_id > 0) s
       on (t.cru_id = s.cru_id and t.cru_crg_id = s.cru_crg_id)
     when matched then update set
          t.cru_sort_seq = s.cru_sort_seq;

    merge into adc_rule_actions t
    using (select cra_id,
                  row_number() over (partition by cra_cru_id order by cra_on_error, cra_sort_seq) * 10 cra_sort_seq
             from adc_rule_actions
            where cra_crg_id = l_crg_id) s
       on (t.cra_id = s.cra_id)
     when matched then update set
          t.cra_sort_seq = s.cra_sort_seq;

    commit;
    pit.leave_optional;
  end resequence_rule;

  /**
    Procedure: merge_rule_action
      See <ADC_CONFIG.merge_rule_action>
   */
  procedure merge_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type default null,
    p_cra_cru_id in adc_rule_actions.cra_cru_id%type,
    p_cra_crg_id in adc_rule_actions.cra_crg_id%type,
    p_cra_cpi_id in adc_rule_actions.cra_cpi_id%type,
    p_cra_cat_id in adc_rule_actions.cra_cat_id%type,
    p_cra_sort_seq in adc_rule_actions.cra_sort_seq%type default 10,
    p_cra_param_1 in adc_rule_actions.cra_param_1%type default null,
    p_cra_param_2 in adc_rule_actions.cra_param_2%type default null,
    p_cra_param_3 in adc_rule_actions.cra_param_3%type default null,
    p_cra_on_error in adc_rule_actions.cra_on_error%type default adc_util.C_FALSE,
    p_cra_raise_recursive in adc_rule_actions.cra_raise_recursive%type default adc_util.C_TRUE,
    p_cra_raise_on_validation in adc_rule_actions.cra_raise_on_validation%type default adc_util.C_FALSE,
    p_cra_active in adc_rule_actions.cra_active%type default adc_util.C_TRUE,
    p_cra_comment in adc_rule_actions.cra_comment%type default null)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_cra_id', p_cra_id),
                    msg_param('p_cra_cru_id', p_cra_cru_id),
                    msg_param('p_cra_crg_id', p_cra_crg_id),
                    msg_param('p_cra_cpi_id', p_cra_cpi_id),
                    msg_param('p_cra_cat_id', p_cra_cat_id),
                    msg_param('p_cra_sort_seq', p_cra_sort_seq),
                    msg_param('p_cra_param_1', p_cra_param_1),
                    msg_param('p_cra_param_2', p_cra_param_2),
                    msg_param('p_cra_param_3', p_cra_param_3),
                    msg_param('p_cra_on_error', p_cra_on_error),
                    msg_param('p_cra_raise_recursive', p_cra_raise_recursive),
                    msg_param('p_cra_raise_on_validation', p_cra_raise_on_validation),
                    msg_param('p_cra_active', p_cra_active),
                    msg_param('p_cra_comment', p_cra_comment)));

    l_row.cra_id := p_cra_id;
    l_row.cra_cru_id := p_cra_cru_id;
    l_row.cra_crg_id := p_cra_crg_id;
    l_row.cra_cpi_id := p_cra_cpi_id;
    l_row.cra_cat_id := p_cra_cat_id;
    l_row.cra_sort_seq := p_cra_sort_seq;
    l_row.cra_param_1 := p_cra_param_1;
    l_row.cra_param_2 := p_cra_param_2;
    l_row.cra_param_3 := p_cra_param_3;
    l_row.cra_on_error := adc_util.get_boolean(p_cra_on_error);
    l_row.cra_raise_recursive := adc_util.get_boolean(p_cra_raise_recursive);
    l_row.cra_raise_on_validation := adc_util.get_boolean(p_cra_raise_on_validation);
    l_row.cra_active := adc_util.get_boolean(p_cra_active);
    l_row.cra_comment := p_cra_comment;

    merge_rule_action(l_row);
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.ADC_MERGE_RULE_ACTION, msg_args(to_char(p_cra_cru_id), to_char(p_cra_cpi_id)));
  end merge_rule_action;

  /**
    Procedure: merge_rule_action
      See <ADC_CONFIG.merge_rule_action>
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
                  p_row.cra_crg_id cra_crg_id,
                  p_row.cra_cpi_id cra_cpi_id,
                  p_row.cra_cat_id cra_cat_id,
                  coalesce(p_row.cra_sort_seq, 10) cra_sort_seq,
                  p_row.cra_param_1 cra_param_1,
                  p_row.cra_param_2 cra_param_2,
                  p_row.cra_param_3 cra_param_3,
                  coalesce(p_row.cra_on_error, adc_util.C_FALSE) cra_on_error,
                  coalesce(p_row.cra_raise_recursive, adc_util.C_TRUE) cra_raise_recursive,
                  coalesce(p_row.cra_raise_on_validation, adc_util.C_FALSE) cra_raise_on_validation,
                  coalesce(p_row.cra_active, adc_util.C_TRUE) cra_active,
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
          t.cra_raise_on_validation = s.cra_raise_on_validation,
          t.cra_active = s.cra_active,
          t.cra_comment = s.cra_comment
     when not matched then insert(
            cra_id, cra_cru_id, cra_crg_id, cra_cpi_id, cra_cat_id, cra_sort_seq, cra_param_1, cra_param_2, cra_param_3,
            cra_on_error, cra_raise_recursive, cra_raise_on_validation, cra_active, cra_comment)
          values(
            s.cra_id, s.cra_cru_id, s.cra_crg_id, s.cra_cpi_id, s.cra_cat_id, s.cra_sort_seq, s.cra_param_1, s.cra_param_2, s.cra_param_3,
            s.cra_on_error, s.cra_raise_recursive, s.cra_raise_on_validation, s.cra_active, s.cra_comment);

    pit.leave_mandatory;
  end merge_rule_action;

  /**
    Procedure: delete_rule_action
      See <ADC_CONFIG.delete_rule_action>
   */
  procedure delete_rule_action(
    p_cra_id in adc_rule_actions.cra_id%type)
  as
    l_row adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_cra_id', p_cra_id)));
    l_row.cra_id := p_cra_id;
    delete_rule_action(l_row);
    pit.leave_mandatory;
  end delete_rule_action;

  /**
    Procedure: delete_rule_action
      See <ADC_CONFIG.delete_rule_action>
   */
  procedure delete_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
  begin
    pit.enter_optional;
    delete from adc_rule_actions where cra_id = p_row.cra_id;
    pit.leave_optional;
  end delete_rule_action;

  /**
    Procedure: validate_rule_action
      See <ADC_CONFIG.validate_rule_action>
   */
  procedure validate_rule_action(
    p_row in adc_rule_actions%rowtype)
  as
    l_cur sys_refcursor;
    C_DOCUMENT constant adc_util.ora_name_type := 'DOCUMENT';
  begin
    pit.enter_optional;

    pit.assert_not_null(p_row.cra_cru_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CRU_ID_MISSING');
    pit.assert_not_null(p_row.cra_crg_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CRG_ID_MISSING');
    pit.assert_not_null(p_row.cra_cpi_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CPI_ID_MISSING');
    pit.assert_not_null(p_row.cra_cat_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRA_CAT_ID_MISSING');

    if p_row.cra_id is null then
      open l_cur for
        select null
          from adc_rule_actions
         where cra_crg_id = p_row.cra_crg_id
           and cra_cru_id = p_row.cra_cru_id
           and case
                 when cra_cpi_id = C_DOCUMENT and cra_param_2 is not null then cra_param_2
                 else cra_cpi_id end =
               case
                 when p_row.cra_cpi_id = C_DOCUMENT and p_row.cra_param_2 is not null then p_row.cra_param_2
                 else p_row.cra_cpi_id end
           and cra_cat_id = p_row.cra_cat_id
           and cra_on_error = p_row.cra_on_error;
      pit.assert_not_exists(l_cur, msg.ADC_RULE_ACTION_EXISTS);
    end if;

    pit.leave_optional;
  end validate_rule_action;

  /**
    Procedure: merge_apex_action
      See <ADC_CONFIG.merge_apex_action>
   */
  procedure merge_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type default null,
    p_caa_crg_id in adc_apex_actions_v.caa_crg_id%type,
    p_caa_caat_id in adc_apex_actions_v.caa_caat_id%type,
    p_caa_name in adc_apex_actions_v.caa_name%type,
    p_caa_confirm_message_name in adc_apex_actions_v.caa_confirm_message_name%type,
    p_caa_label in adc_apex_actions_v.caa_label%type,
    p_caa_context_label in adc_apex_actions_v.caa_context_label%type default null,
    p_caa_icon in adc_apex_actions_v.caa_icon%type default null,
    p_caa_icon_type in adc_apex_actions_v.caa_icon_type%type default 'fa',
    p_caa_title in adc_apex_actions_v.caa_title%type default null,
    p_caa_shortcut in adc_apex_actions_v.caa_shortcut%type default null,
    p_caa_initially_disabled in adc_apex_actions_v.caa_initially_disabled%type default adc_util.C_FALSE,
    p_caa_initially_hidden in adc_apex_actions_v.caa_initially_hidden%type default adc_util.C_FALSE,
    p_caa_href in adc_apex_actions_v.caa_href%type default null,
    p_caa_action in adc_apex_actions_v.caa_action%type default null,
    p_caa_on_label in adc_apex_actions_v.caa_on_label%type default null,
    p_caa_off_label in adc_apex_actions_v.caa_off_label%type default null,
    p_caa_get in adc_apex_actions_v.caa_get%type default null,
    p_caa_set in adc_apex_actions_v.caa_set%type default null,
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
                    msg_param('p_caa_crg_id', p_caa_crg_id),
                    msg_param('p_caa_caat_id', p_caa_caat_id),
                    msg_param('p_caa_name', p_caa_name),
                    msg_param('p_caa_confirm_message_name', p_caa_confirm_message_name),
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
    l_row.caa_crg_id := p_caa_crg_id;
    l_row.caa_caat_id := p_caa_caat_id;
    l_row.caa_name := p_caa_name;
    l_row.caa_confirm_message_name := p_caa_confirm_message_name;
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
      See <ADC_CONFIG.merge_apex_action>
   */
  procedure merge_apex_action(
    p_row in out nocopy adc_apex_actions_v%rowtype,
    p_caa_caai_list in char_table default null)
  as
    l_pti_id pit_translatable_item_v.pti_id%type;
  begin
    pit.enter_mandatory;
    validate_apex_action(p_row);
    get_key(p_row.caa_id);

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
                  p_row.caa_crg_id caa_crg_id,
                  p_row.caa_name caa_name,
                  l_pti_id caa_pti_id,
                  C_ADC caa_pmg_name,
                  p_row.caa_caat_id caa_caat_id,
                  p_row.caa_confirm_message_name caa_confirm_message_name,
                  p_row.caa_icon caa_icon,
                  coalesce(p_row.caa_icon_type, 'fa') caa_icon_type,
                  p_row.caa_title caa_title,
                  p_row.caa_shortcut caa_shortcut,
                  coalesce(p_row.caa_initially_disabled, adc_util.C_FALSE) caa_initially_disabled,
                  coalesce(p_row.caa_initially_hidden, adc_util.C_FALSE) caa_initially_hidden,
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
            t.caa_caat_id = s.caa_caat_id,
            t.caa_pti_id = s.caa_pti_id,
            t.caa_pmg_name = s.caa_pmg_name,
            t.caa_confirm_message_name = s.caa_confirm_message_name,
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
            t.caa_id, t.caa_crg_id, t.caa_name, t.caa_caat_id, t.caa_pti_id, t.caa_pmg_name, t.caa_confirm_message_name,
            t.caa_icon, t.caa_icon_type, t.caa_shortcut, t.caa_initially_disabled, t.caa_initially_hidden,
            t.caa_href, t.caa_action, t.caa_get, t.caa_set, t.caa_on_label, t.caa_off_label, t.caa_choices, t.caa_label_classes,
            t.caa_label_start_classes, t.caa_label_end_classes, t.caa_item_wrap_class)
          values(
            s.caa_id, s.caa_crg_id, s.caa_name, s.caa_caat_id, s.caa_pti_id, s.caa_pmg_name, s.caa_confirm_message_name,
            s.caa_icon, s.caa_icon_type, s.caa_shortcut, s.caa_initially_disabled, s.caa_initially_hidden,
            s.caa_href, s.caa_action, s.caa_get, s.caa_set, s.caa_on_label, s.caa_off_label, s.caa_choices, s.caa_label_classes,
            s.caa_label_start_classes, s.caa_label_end_classes, s.caa_item_wrap_class);

    delete from adc_apex_action_items
     where caai_caa_id = p_row.caa_id
       and caai_cpi_crg_id = p_row.caa_crg_id;

    if p_caa_caai_list is not null then
      for i in 1 .. p_caa_caai_list.count loop
        merge_apex_action_item(
          p_caai_caa_id => p_row.caa_id,
          p_caai_cpi_crg_id => p_row.caa_crg_id,
          p_caai_cpi_id => p_caa_caai_list(i),
          p_caai_active => adc_util.C_TRUE);
      end loop;
    end if;

    pit.leave_mandatory;
  end merge_apex_action;

  /**
    Procedure: delete_apex_action
      See <ADC_CONFIG.delete_apex_action>
   */
  procedure delete_apex_action(
    p_caa_id in adc_apex_actions_v.caa_id%type)
  as
    l_row adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_caa_id', p_caa_id)));
    l_row.caa_id := p_caa_id;
    delete_apex_action(l_row);
    pit.leave_mandatory;
  end delete_apex_action;

  /**
    Procedure: delete_apex_action
      See <ADC_CONFIG.delete_apex_action>
   */
  procedure delete_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    delete from adc_apex_actions where caa_id = p_row.caa_id;
    pit.leave_mandatory;
  end delete_apex_action;

  /**
    Procedure: validate_apex_action
      See <ADC_CONFIG.validate_apex_action>
   */
  procedure validate_apex_action(
    p_row in adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_mandatory;
    pit.leave_mandatory;
  end validate_apex_action;

  /**
    Procedure: merge_apex_action_item
      See <ADC_CONFIG.merge_apex_action_item>
   */
  procedure merge_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type,
    p_caai_cpi_crg_id in adc_apex_action_items.caai_cpi_crg_id%type,
    p_caai_cpi_id in adc_apex_action_items.caai_cpi_id%type,
    p_caai_active in adc_apex_action_items.caai_active%type default adc_util.C_TRUE)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_caai_caa_id', p_caai_caa_id),
                    msg_param('p_caai_cpi_crg_id', p_caai_cpi_crg_id),
                    msg_param('p_caai_cpi_id', p_caai_cpi_id),
                    msg_param('p_caai_active', p_caai_active)));

    l_row.caai_caa_id := p_caai_caa_id;
    l_row.caai_cpi_crg_id := p_caai_cpi_crg_id;
    l_row.caai_cpi_id := p_caai_cpi_id;
    l_row.caai_active := adc_util.get_boolean(p_caai_active);

    merge_apex_action_item(l_row);
    pit.leave_mandatory;
  end merge_apex_action_item;

  /**
    Procedure: merge_apex_action_item
      See <ADC_CONFIG.merge_apex_action_item>
   */
  procedure merge_apex_action_item(
    p_row in out nocopy adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
    validate_apex_action_item(p_row);

    merge into adc_apex_action_items t
    using (select p_row.caai_caa_id caai_caa_id,
                  p_row.caai_cpi_crg_id caai_cpi_crg_id,
                  p_row.caai_cpi_id caai_cpi_id,
                  coalesce(p_row.caai_active, adc_util.C_TRUE) caai_active
             from dual) s
       on (t.caai_caa_id = s.caai_caa_id
       and t.caai_cpi_crg_id = s.caai_cpi_crg_id
       and t.caai_cpi_id = s.caai_cpi_id)
     when matched then update set
            t.caai_active = s.caai_active
     when not matched then insert(t.caai_caa_id, t.caai_cpi_crg_id, t.caai_cpi_id, t.caai_active)
          values(s.caai_caa_id, s.caai_cpi_crg_id, s.caai_cpi_id, s.caai_active);

    pit.leave_mandatory;
  end merge_apex_action_item;

  /**
    Procedure: delete_apex_action_item
      See <ADC_CONFIG.delete_apex_action_item>
   */
  procedure delete_apex_action_item(
    p_caai_caa_id in adc_apex_action_items.caai_caa_id%type)
  as
    l_row adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_caai_caa_id', p_caai_caa_id)));
    l_row.caai_caa_id := p_caai_caa_id;
    delete_apex_action_item(l_row);
    pit.leave_mandatory;
  end delete_apex_action_item;

  /**
    Procedure: delete_apex_action_item
      See <ADC_CONFIG.delete_apex_action_item>
   */
  procedure delete_apex_action_item(
    p_row in adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory;
    delete from adc_apex_action_items where caai_caa_id = p_row.caai_caa_id;
    pit.leave_mandatory;
  end delete_apex_action_item;

  /**
    Procedure: validate_apex_action_item
      See <ADC_CONFIG.validate_apex_action_item>
   */
  procedure validate_apex_action_item(
    p_row in adc_apex_action_items%rowtype)
  as
  begin
    pit.enter_mandatory('validate_apex_action_item');
    pit.leave_mandatory;
  end validate_apex_action_item;
end adc_config;
/
