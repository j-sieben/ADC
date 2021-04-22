set define off
set sqlprefix off

begin
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ACTION',
    p_uttm_text => q'{{"name":"#CAA_NAME#"#CAA_LABEL|,^CR^"label":"|"|##CAA_LABEL_KEY|,^CR^"labelKey":"|"|##CAA_CONTEXT_LABEL|,^CR^"contextLabel":"|"|##CAA_ICON|,^CR^"icon":"|"|##CAA_ICON_TYPE|,^CR^"iconType":"|"|##CAA_INITIALLY_DISABLED|,^CR^"disabled":||##CAA_INITIALLY_HIDDEN|,^CR^"hide":||##CAA_TITLE|,^CR^"title":"|"|##CAA_SHORTCUT|,^CR^"shortcut":"|"|##CAA_HREF|,^CR^"href":"|"|##CAA_ACTION|,^CR^"action":"|"|#}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'TOGGLE',
    p_uttm_text => q'{{"action":\CR\}' || 
q'{  {"name":"#CAA_NAME#",\CR\}' || 
q'{   "#LABEL_KEY#":"#CAA_LABEL#",\CR\}' || 
q'{   "#ON_LABEL_KEY#":"#CAA_ON_LABEL#",\CR\}' || 
q'{   "#OFF_LABEL_KEY#":"#CAA_OFF_LABEL#",\CR\}' || 
q'{   "contextLabel":"#CAA_CONTEXT_LABEL#",\CR\}' || 
q'{   "icon":"#CAA_ICON#",\CR\}' || 
q'{   "iconType":"#CAA_ICON_TYPE#",\CR\}' || 
q'{   "disabled":"#CAA_INITIALLY_DISABLED#",\CR\}' || 
q'{   "hide":"#CAA_INITIALLY_HIDDEN#",\CR\}' || 
q'{   "title":"#CAA_TITLE#",\CR\}' || 
q'{   "shortcut":"#CAA_SHORTCUT#",\CR\}' || 
q'{   "get":"#CAA_GET#",\CR\}' || 
q'{   "set":"#CAA_SET#",\CR\}' || 
q'{  }\CR\}' || 
q'{}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'RADIO_GROUP',
    p_uttm_text => q'{{"action":\CR\}' || 
q'{  {"name":"#CAA_NAME#",\CR\}' || 
q'{   "#LABEL_KEY#":"#CAA_LABEL#",\CR\}' || 
q'{   "contextLabel":"#CAA_CONTEXT_LABEL#",\CR\}' || 
q'{   "icon":"#CAA_ICON#",\CR\}' || 
q'{   "iconType":"#CAA_ICON_TYPE#",\CR\}' || 
q'{   "disabled":"#CAA_INITIALLY_DISABLED#",\CR\}' || 
q'{   "hide":"#CAA_INITIALLY_HIDDEN#",\CR\}' || 
q'{   "title":"#CAA_TITLE#",\CR\}' || 
q'{   "shortcut":"#CAA_SHORTCUT#",\CR\}' || 
q'{   "get":"#CAA_GET#",\CR\}' || 
q'{   "set":"#CAA_SET#",\CR\}' || 
q'{   "choices":[#CAA_CHOICES#],\CR\}' || 
q'{   "labelClasses":"#CAA_LABEL_CLASSES#",\CR\}' || 
q'{   "labelStartClasses":"#CAA_LABEL_START_CLASSES#",\CR\}' || 
q'{   "labelEndClasses":"#CAA_LABEL_END_CLASSES#",\CR\}' || 
q'{   "itemWrapClasses":"#CAA_ITEM_WRAP_CLASS#",\CR\}' || 
q'{  }\CR\}' || 
q'{}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'RADIO_GROUP_CHOICE',
    p_uttm_text => q'{{#RG_LABEL_KEY#:"#RG_LABEL#",\CR\}' || 
q'{ "value":"#RG_VALUE#",\CR\}' || 
q'{ "icon":"#RG_ICON#",\CR\}' || 
q'{ "iconType":"#RG_ICON_TYPE#",\CR\}' || 
q'{ "disabled":"#RG_INITIALLY_DISABLED#",\CR\}' || 
q'{ "shortcut":"#RG_SHORTCUT#"#RG_GROUP|,\CR\}' || 
q'{"group":"|#"|#\CR\}' || 
q'{}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'JSON_ERRORS',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{{"count":#ERROR_COUNT#,"errorDependentItems":"#DEPENDENT_ITEMS#","firingItems":"#FIRING_ITEMS#","errors":[#JSON_ERRORS#]}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'JSON_ERRORS',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ERROR',
    p_uttm_text => q'{{"type":"error","pageItem":"#PAGE_ITEM#","message":#MESSAGE#,"location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_STMT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'{  with params as (\CR\}' || 
q'{       select adc_util.c_true c_true,\CR\}' || 
q'{                 adc_util.c_false c_false\CR\}' || 
q'{            from dual)\CR\}' || 
q'{select /*+ no_merge(p) */cru.cru_id, cru.cru_sort_seq, cru.cru_name, cru.cru_firing_items, cru_fire_on_page_load,\CR\}' || 
q'{       cra_cpi_id item, cat_pl_sql pl_sql, cat_js js, cra_sort_seq, cra_param_1 param_1, cra_param_2 param_2, cra_param_3 param_3, cra_on_error,\CR\}' || 
q'{       max(cra_on_error) over (partition by cru_sort_seq) cru_on_error,\CR\}' || 
q'{       case row_number() over (partition by cru_sort_seq, cra_on_error order by crg.cra_sort_seq) when 1 then c_true else c_false end is_first_row\CR\}' || 
q'{  from (#CGR_DECISION_TABLE#) crg\CR\}' || 
q'{  join adc_rule cru\CR\}' || 
q'{    on crg.cru_id = cru.cru_id\CR\}' || 
q'{  join adc_action_type cat\CR\}' || 
q'{    on crg.cra_cat_id = cat.cat_id\CR\}' || 
q'{ cross join params p\CR\}' || 
q'{ where cat.cat_raise_recursive in (c_true, '#IS_RECURSIVE#')\CR\}' || 
q'{   and crg.cra_raise_recursive in (c_true, '#IS_RECURSIVE#')\CR\}' || 
q'{ order by cru.cru_sort_seq desc, crg.cra_sort_seq}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE_HELP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{<h2>#CAT_NAME#</h2><div>#CAT_DESCRIPTION#</div>#PARAMETERS|<h3>Parameter:</h3><div><dl>|</dl></div>#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE_HELP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'PARAMETERS',
    p_uttm_text => q'{<dt>#CPT_NAME#</dt><dd>#CAP_DESCRIPTION##CPT_DESCRIPTION#</dd>}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APEX_ACTION_TYPE',
    p_uttm_text => q'{  adc_admin.merge_apex_action_type(\CR\}' || 
q'{    p_cty_id => '#CTY_ID#',\CR\}' || 
q'{    p_cty_name => '#CTY_NAME#',\CR\}' || 
q'{    p_cty_description => #CTY_DESCRIPTION#,\CR\}' || 
q'{    p_cty_active  => #CTY_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'PAGE_ITEM_TYPE',
    p_uttm_text => q'{  adc_admin.merge_page_item_type(\CR\}' || 
q'{    p_cit_id => '#CIT_ID#',\CR\}' || 
q'{    p_cit_name => '#CIT_NAME#',\CR\}' || 
q'{    p_cit_has_value => #CIT_HAS_VALUE#,\CR\}' || 
q'{    p_cit_include_in_view => #CIT_INCLUDE_IN_VIEW#,\CR\}' || 
q'{    p_cit_event => '#CIT_EVENT#',\CR\}' || 
q'{    p_cit_col_template => #CIT_COL_TEMPLATE#,\CR\}' || 
q'{    p_cit_init_template => #CIT_INIT_TEMPLATE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{create or replace force view #PREFIX##CGR_ID# as\CR\}' || 
q'{  with session_state as(\CR\}' || 
q'{       select #COLUMN_LIST#,\CR\}' || 
q'{              adc_util.c_true c_true,\CR\}' || 
q'{              adc_util.c_false c_false\CR\}' || 
q'{         from dual),\CR\}' || 
q'{       data as (\CR\}' || 
q'{       select /*+ NO_MERGE(s) */\CR\}' || 
q'{              r.cru_id, r.cru_name, r.cru_firing_items, r.cru_fire_on_page_load,\CR\}' || 
q'{              r.cra_cpi_id, r.cra_cat_id, r.cra_sort_seq, r.cra_param_1, r.cra_param_2, r.cra_param_3, r.cra_on_error, r.cra_raise_recursive,\CR\}' || 
q'{              rank() over (order by r.cru_sort_seq) rang, case s.initializing when 1 then s.c_true else s.c_false end initializing\CR\}' || 
q'{         from adc_bl_rules r\CR\}' || 
q'{         join session_state s\CR\}' || 
q'{           on instr(r.cru_firing_items, ',' || s.firing_item || ',') > 0\CR\}' || 
q'{           or cru_fire_on_page_load = s.c_true\CR\}' || 
q'{        where r.cgr_id = #CGR_ID#\CR\}' || 
q'{          and (#WHERE_CLAUSE#))\CR\}' || 
q'{select cru_id, cru_name, cra_cpi_id, cra_cat_id, cra_param_1, cra_param_2, cra_param_3, cra_on_error, cra_raise_recursive, cra_sort_seq\CR\}' || 
q'{  from data\CR\}' || 
q'{ where rang = 1\CR\}' || 
q'{    or cru_fire_on_page_load = initializing\CR\}' || 
q'{ order by cru_fire_on_page_load, rang}',
    p_uttm_log_text => q'{Rule View #PREFIX##CGR_ID# created.}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VALIDATION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'{  with session_state as(\CR\}' || 
q'{       select #COLUMN_LIST#\CR\}' || 
q'{         from dual)\CR\}' || 
q'{select *\CR\}' || 
q'{  from session_state\CR\}' || 
q'{ where #CONDITION#}',
    p_uttm_log_text => q'{Rule View #PREFIX##CGR_ID# validated.}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'WHERE_CLAUSE',
    p_uttm_text => q'{(r.cru_id = #CRU_ID# and (#CRU_CONDITION#))}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'{\CR\}' || 
q'{set define #\CR\}' || 
q'{\CR\}' || 
q'{declare\CR\}' || 
q'{  l_foo number;\CR\}' || 
q'{  l_app_id number;\CR\}' || 
q'{begin\CR\}' || 
q'{  l_foo := adc_admin.map_id;\CR\}' || 
q'{  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);\CR\}' || 
q'{\CR\}' || 
q'{  dbms_output.put_line('&s1.Rulegroup #CGR_NAME#');\CR\}' || 
q'{\CR\}' || 
q'{  adc_admin.prepare_rule_group_import(\CR\}' || 
q'{    p_cgr_app_id => l_app_id,\CR\}' || 
q'{    p_cgr_page_id => #CGR_PAGE_ID#,\CR\}' || 
q'{    p_cgr_name => '#CGR_NAME#');\CR\}' || 
q'{\CR\}' || 
q'{  adc_admin.merge_rule_group(\CR\}' || 
q'{    p_cgr_id => adc_admin.map_id(#CGR_ID#),\CR\}' || 
q'{    p_cgr_name => '#CGR_NAME#',\CR\}' || 
q'{    p_cgr_description => q'|#CGR_DESCRIPTION#|',\CR\}' || 
q'{    p_cgr_app_id => l_app_id,\CR\}' || 
q'{    p_cgr_page_id => #CGR_PAGE_ID#,\CR\}' || 
q'{    p_cgr_with_recursion => #CGR_WITH_RECURSION#,\CR\}' || 
q'{    p_cgr_active => #CGR_ACTIVE#);\CR\}' || 
q'{  #RULES#\CR\}' || 
q'{  #APEX_ACTIONS#\CR\}' || 
q'{  adc_admin.propagate_rule_change(adc_admin.map_id(#CGR_ID#));\CR\}' || 
q'{\CR\}' || 
q'{  commit;\CR\}' || 
q'{end;\CR\}' || 
q'{/\CR\}' || 
q'{\CR\}' || 
q'{set define on\CR\}' || 
q'{}',
    p_uttm_log_text => q'{Rule group #CGR_NAME# exported.}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'RULE',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_rule(\CR\}' || 
q'{    p_cru_id => adc_admin.map_id(#CRU_ID#),\CR\}' || 
q'{    p_cru_cgr_id => adc_admin.map_id(#CRU_CGR_ID#),\CR\}' || 
q'{    p_cru_name => '#CRU_NAME#',\CR\}' || 
q'{    p_cru_condition => q'|#CRU_CONDITION#|',\CR\}' || 
q'{    p_cru_sort_seq => #CRU_SORT_SEQ#,\CR\}' || 
q'{    p_cru_fire_on_page_load => #CRU_FIRE_ON_PAGE_LOAD#,\CR\}' || 
q'{    p_cru_active => #CRU_ACTIVE#);\CR\}' || 
q'{  #RULE_ACTIONS#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'RULE_ACTION',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_rule_action(\CR\}' || 
q'{    p_cra_id => adc_admin.map_id(#CRA_ID#),\CR\}' || 
q'{    p_cra_cru_id => adc_admin.map_id(#CRA_CRU_ID#),\CR\}' || 
q'{    p_cra_cgr_id => adc_admin.map_id(#CRA_CGR_ID#),\CR\}' || 
q'{    p_cra_cpi_id => '#CRA_CPI_ID#',\CR\}' || 
q'{    p_cra_cat_id => '#CRA_CAT_ID#',\CR\}' || 
q'{    p_cra_param_1 => q'|#CRA_PARAM_1#|',\CR\}' || 
q'{    p_cra_param_2 => q'|#CRA_PARAM_2#|',\CR\}' || 
q'{    p_cra_param_3 => q'|#CRA_PARAM_3#|',\CR\}' || 
q'{    p_cra_sort_seq => #CRA_SORT_SEQ#,\CR\}' || 
q'{    p_cra_on_error => #CRA_ON_ERROR#,\CR\}' || 
q'{    p_cra_raise_recursive => #CRA_RAISE_RECURSIVE#,\CR\}' || 
q'{    p_cra_active => #CRA_ACTIVE#);}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APEX_ACTION_ACTION',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_apex_action(    \CR\}' || 
q'{    p_caa_id => adc_admin.map_id(#CAA_ID#),\CR\}' || 
q'{    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),\CR\}' || 
q'{    p_caa_cty_id => '#CAA_CTY_ID#',\CR\}' || 
q'{    p_caa_name => '#CAA_NAME#',\CR\}' || 
q'{    p_caa_label => '#CAA_LABEL#',\CR\}' || 
q'{    p_caa_context_label => '#CAA_CONTEXT_LABEL#',\CR\}' || 
q'{    p_caa_icon => '#CAA_ICON#',\CR\}' || 
q'{    p_caa_icon_type => '#CAA_ICON_TYPE#',\CR\}' || 
q'{    p_caa_title => '#CAA_TITLE#',\CR\}' || 
q'{    p_caa_shortcut => '#CAA_SHORTCUT#',\CR\}' || 
q'{    p_caa_initially_disabled => #CAA_INITIALLY_DISABLED#,\CR\}' || 
q'{    p_caa_initially_hidden => #CAA_INITIALLY_HIDDEN#,\CR\}' || 
q'{    p_caa_href => '#CAA_HREF#',\CR\}' || 
q'{    p_caa_action => '#CAA_ACTION#');\CR\}' || 
q'{  #APEX_ACTION_ITEMS#\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APEX_ACTION_TOGGLE',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_apex_action(    \CR\}' || 
q'{    p_caa_id => adc_admin.map_id(#CAA_ID#),\CR\}' || 
q'{    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),\CR\}' || 
q'{    p_caa_name => '#CAA_NAME#',\CR\}' || 
q'{    p_caa_type => '#CAA_TYPE#',\CR\}' || 
q'{    p_caa_label => '#CAA_LABEL#',\CR\}' || 
q'{    p_caa_on_label => '#CAA_ON_LABEL#',\CR\}' || 
q'{    p_caa_off_label => '#CAA_OFF_LABEL#',\CR\}' || 
q'{    p_caa_context_label => '#CAA_CONTEXT_LABEL#',\CR\}' || 
q'{    p_caa_icon => '#CAA_ICON#',\CR\}' || 
q'{    p_caa_icon_type => '#CAA_ICON_TYPE#',\CR\}' || 
q'{    p_caa_title => '#CAA_TITLE#',\CR\}' || 
q'{    p_caa_shortcut => '#CAA_SHORTCUT#',\CR\}' || 
q'{    p_caa_initially_disabled => '#CAA_INITIALLY_DISABLED#',\CR\}' || 
q'{    p_caa_initially_hidden => '#CAA_INITIALLY_HIDDEN#',\CR\}' || 
q'{    p_caa_href => '#CAA_HREF#',\CR\}' || 
q'{    p_caa_action => '#CAA_ACTION#',\CR\}' || 
q'{    p_caa_get => '#CAA_GET#',\CR\}' || 
q'{    p_caa_set => '#CAA_SET#');\CR\}' || 
q'{  #APEX_ACTION_ITEMS#\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APEX_ACTION_RADIO_GROUP',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_apex_action(    \CR\}' || 
q'{    p_caa_id => adc_admin.map_id(#CAA_ID#),\CR\}' || 
q'{    p_caa_cgr_id => adc_admin.map_id(#CGR_ID#),\CR\}' || 
q'{    p_caa_cty_id => '#CAA_CTY_ID#',\CR\}' || 
q'{    p_caa_name => '#CAA_NAME#',\CR\}' || 
q'{    p_caa_label => '#CAA_LABEL#',\CR\}' || 
q'{    p_caa_context_label => '#CAA_CONTEXT_LABEL#',\CR\}' || 
q'{    p_caa_icon => '#CAA_ICON#',\CR\}' || 
q'{    p_caa_icon_type => '#CAA_ICON_TYPE#',\CR\}' || 
q'{    p_caa_title => '#CAA_TITLE#',\CR\}' || 
q'{    p_caa_href => '#CAA_HREF#',\CR\}' || 
q'{    p_caa_action => '#CAA_ACTION#',\CR\}' || 
q'{    p_caa_initially_disabled => '#CAA_INITIALLY_DISABLED#',\CR\}' || 
q'{    p_caa_initially_hidden => '#CAA_INITIALLY_HIDDEN#',\CR\}' || 
q'{    p_caa_get => '#CAA_GET#',\CR\}' || 
q'{    p_caa_set => '#CAA_SET#',\CR\}' || 
q'{    p_caa_choices => '#CAA_CHOICES#',\CR\}' || 
q'{    p_caa_label_classes => '#CAA_LABEL_CLASSES#',\CR\}' || 
q'{    p_caa_label_start_classes => '#CAA_LABEL_START_CLASSES#',\CR\}' || 
q'{    p_caa_label_end_classes => '#CAA_LABEL_END_CLASSES#',\CR\}' || 
q'{    p_caa_item_wrap_class => '#CAA_ITEM_WRAP_CLASSES#');\CR\}' || 
q'{  #APEX_ACTION_ITEMS#\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APEX_ACTION_ITEM',
    p_uttm_text => q'{\CR\}' || 
q'{  adc_admin.merge_apex_action_item(\CR\}' || 
q'{    p_cai_caa_id => adc_admin.map_id(#CAI_CAA_ID#),\CR\}' || 
q'{    p_cai_cpi_cgr_id => adc_admin.map_id(#CAI_CPI_CGR_ID#),\CR\}' || 
q'{    p_cai_cpi_id => '#CAI_CPI_ID#',\CR\}' || 
q'{    p_cai_active => #CAI_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'{v('#ITEM#') #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'{itm.#ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'{to_number(v('#ITEM#'), '#CONVERSION#') #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'{to_char(itm.#ITEM#, '#CONVERSION#')}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'{to_date(v('#ITEM#'), '#CONVERSION#') #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'{to_char(to_date(itm.#ITEM#), '#CONVERSION#')}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'{v('#ITEM#') #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'{itm.#ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'{case adc.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'{null}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'{null #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'{null}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'{null #ITEM#}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'{null}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{set define off\CR\}' || 
q'{set sqlblanklines on\CR\}' || 
q'{\CR\}' || 
q'{begin\CR\}' || 
q'{  -- ACTION_PARAM_TYPES\CR\}' || 
q'{#ACTION_PARAM_TYPES#\CR\}' || 
q'{\CR\}' || 
q'{  -- PAGE_ITEM_TYPES\CR\}' || 
q'{#PAGE_ITEM_TYPES#\CR\}' || 
q'{\CR\}' || 
q'{  -- ACTION_ITEM_FOCUS\CR\}' || 
q'{#ACTION_ITEM_FOCUS#\CR\}' || 
q'{\CR\}' || 
q'{  -- ACTION_TYPE_GROUPS\CR\}' || 
q'{#ACTION_TYPE_GROUPS#\CR\}' || 
q'{\CR\}' || 
q'{  -- ACTION TYPES\CR\}' || 
q'{#ACTION_TYPES#\CR\}' || 
q'{\CR\}' || 
q'{  -- APEX_ACTION TYPES\CR\}' || 
q'{#APEX_ACTION_TYPES#\CR\}' || 
q'{  commit;\CR\}' || 
q'{end;\CR\}' || 
q'{/\CR\}' || 
q'{\CR\}' || 
q'{set define on\CR\}' || 
q'{set sqlblanklines off\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'PARAM_TYPE',
    p_uttm_text => q'{  adc_admin.merge_action_param_type(\CR\}' || 
q'{    p_CPT_id => '#CPT_ID#',\CR\}' || 
q'{    p_CPT_name => '#CPT_NAME#',\CR\}' || 
q'{    p_CPT_display_name => '#CPT_DISPLAY_NAME#',\CR\}' || 
q'{    p_CPT_description => #CPT_DESCRIPTION#,\CR\}' || 
q'{    p_CPT_item_type => '#CPT_ITEM_TYPE#',\CR\}' || 
q'{    p_CPT_active => #CPT_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ITEM_FOCUS',
    p_uttm_text => q'{  adc_admin.merge_action_item_focus(\CR\}' || 
q'{    p_cif_id => '#CIF_ID#',\CR\}' || 
q'{    p_cif_name => '#CIF_NAME#',\CR\}' || 
q'{    p_cif_description => #CIF_DESCRIPTION#,\CR\}' || 
q'{    p_cif_actual_page_only => #CIF_ACTUAL_PAGE_ONLY#,\CR\}' || 
q'{    p_cif_item_types => '#CIF_ITEM_TYPES#',\CR\}' || 
q'{    p_cif_active => #CIF_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ACTION_PARAMS',
    p_uttm_text => q'{  adc_admin.merge_action_parameter(\CR\}' || 
q'{    p_cap_cat_id => '#CAP_CAT_ID#',\CR\}' || 
q'{    p_cap_CPT_id => '#CAP_CPT_ID#',\CR\}' || 
q'{    p_cap_sort_seq => #CAP_SORT_SEQ#,\CR\}' || 
q'{    p_cap_default => #CAP_DEFAULT#,\CR\}' || 
q'{    p_cap_description => #CAP_DESCRIPTION#,\CR\}' || 
q'{    p_cap_display_name => '#CAP_DISPLAY_NAME#',\CR\}' || 
q'{    p_cap_mandatory => #CAP_MANDATORY#,\CR\}' || 
q'{    p_cap_active => #CAP_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ACTION_TYPE_GROUP',
    p_uttm_text => q'{  adc_admin.merge_action_type_group(\CR\}' || 
q'{    p_ctg_id => '#CTG_ID#',\CR\}' || 
q'{    p_ctg_name => '#CTG_NAME#',\CR\}' || 
q'{    p_ctg_description => #CTG_DESCRIPTION#,\CR\}' || 
q'{    p_ctg_active => #CTG_ACTIVE#);\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{declare\CR\}' || 
q'{  cursor item_cur is\CR\}' || 
q'{    #SQL_STMT#;\CR\}' || 
q'{begin\CR\}' || 
q'{  for itm in item_cur loop\CR\}' || 
q'{    #ITEM_STMT#\CR\}' || 
q'{  end loop;\CR\}' || 
q'{end;}',
    p_uttm_log_text => q'{Initialization code for rule group #CGR_ID# created.}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ROWID',
    p_uttm_text => q'{select rowid, v.*\CR\}' || 
q'{  from #ATTRIBUTE_02# v\CR\}' || 
q'{ where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'{select *\CR\}' || 
q'{  from #ATTRIBUTE_02# v\CR\}' || 
q'{ where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'ACTION_TYPE',
    p_uttm_text => q'{  adc_admin.merge_action_type(\CR\}' || 
q'{    p_cat_id => '#CAT_ID#',\CR\}' || 
q'{    p_cat_ctg_id => '#CAT_CTG_ID#',\CR\}' || 
q'{    p_cat_cif_id => '#CAT_CIF_ID#',\CR\}' || 
q'{    p_cat_name => '#CAT_NAME#',\CR\}' || 
q'{    p_cat_description => #CAT_DESCRIPTION#,\CR\}' || 
q'{    p_cat_pl_sql => #CAT_PL_SQL#,\CR\}' || 
q'{    p_cat_js => #CAT_JS#,\CR\}' || 
q'{    p_cat_is_editable => #CAT_IS_EDITABLE#,\CR\}' || 
q'{    p_cat_raise_recursive => #CAT_RAISE_RECURSIVE#);\CR\}' || 
q'{\CR\}' || 
q'{#RULE_ACTION_PARAMS#\CR\}' || 
q'{}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'VALUE',
    p_uttm_text => q'{apex_util.set_session_state('#ITEM#', #ITEM_SOURCE#);}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{<p>Regelgruppe "#CGR_NAME#" kann nicht exportiert werden:</p><ul>#ERROR_LIST#</ul>}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'{<li>#CIT_NAME# "#CPI_ID#" existiert in Anwendung #CGR_APP_ID# nicht</li>}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'{// Integration von APEX-Actions\CR\}' || 
q'{#BIND_ACTION_ITEMS#\CR\}' || 
q'{\CR\}' || 
q'{apex.actions.add(\CR\}' || 
q'{  [#ACTION_LIST#\CR\}' || 
q'{  ]);}',
    p_uttm_log_text => q'{APEX actions created}',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'ADC',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'{$('##CPI_ID#').removeClass('js-actionButton').addClass('js-actionButton').attr('data-action', '#CAA_NAME#');}',
    p_uttm_log_text => q'{}',
    p_uttm_log_severity => 70
  );
  commit;
end;
/
set define on
set sqlprefix on