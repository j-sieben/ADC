begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'ADC',
    p_pgr_description => 'ADC Parameters',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'RAISE_RECURSION_LOOP',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Flag to indicate whether exceeding the max recursion depth raises an exception (TRUE) or not (FALSE)',
    p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'RECURSION_LIMIT',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Amount of recursive levels before ADC stops further recursion',
    p_par_integer_value => 10
  );

  param_admin.edit_parameter(
    p_par_id => 'ACTION_TYPE_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Template to use for the export files of Action Types exports',
    p_par_string_value => 'merge_adc_action_types_system.sql'
  );

  param_admin.edit_parameter(
    p_par_id => 'USER_ACTION_TYPE_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Template to use for the export files of user defined Action Types exports',
    p_par_string_value => 'adc_action_types_#CATO#.sql'
  );

  param_admin.edit_parameter(
    p_par_id => 'RULE_GROUP_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Template to use for the export files of rule group exports',
    p_par_string_value => 'merge_rule_group_#CRG_FILE_NAME#.sql'
  );

  param_admin.edit_parameter(
    p_par_id => 'APPLICATION_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Template to use for the export files of the apex application. Anchors: #ALIAS#, #alias#, #APP_ID#',
    p_par_string_value => 'app_#alias#_#APP_ID#.sql'
  );

  param_admin.edit_parameter(
    p_par_id => 'APPLICATION_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Template to use for the export file of rule groups integrated into an apex export file',
    p_par_string_value => 'f#APP_ID#_dynamic.sql'
  );

  param_admin.edit_parameter(
    p_par_id => 'DYNAMIC_PAGES_FILENAME',
    p_par_pgr_id => 'ADC',
    p_par_description => 'Filename for the zip file containing rule group scripts of an application',
    p_par_string_value => 'rule_groups_#APP_ALIAS#.zip'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_SHOW_MESSAGE_INFO',
    p_par_pgr_id => 'ADC',
    p_par_description => 'apex.message.showDialog.options objekt adjusting settings for the dialog',
    p_par_string_value => '{title:#PARAM_2#,modern:true,returnFocusTo:#ITEM#,isPopup:true,style:information,dialogType:dialog}'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_SHOW_MESSAGE_WARN',
    p_par_pgr_id => 'ADC',
    p_par_description => 'apex.message.showDialog.options objekt adjusting settings for the dialog',
    p_par_string_value => '{title:#PARAM_2#,modern:true,returnFocusTo:#ITEM#,style:warning,dialogType:dialog}'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_SHOW_MESSAGE_SUCCESS',
    p_par_pgr_id => 'ADC',
    p_par_description => 'apex.message.showDialog.options objekt adjusting settings for the dialog',
    p_par_string_value => '{title:#PARAM_2#,modern:true,returnFocusTo:#ITEM#,style:success,dialogType:success}'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_SHOW_MESSAGE_ERROR',
    p_par_pgr_id => 'ADC',
    p_par_description => 'apex.message.showDialog.options objekt adjusting settings for the dialog',
    p_par_string_value => '{title:#PARAM_2#,modern:true,returnFocusTo:#ITEM#,style:error,dialogType:dialog}'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_SHOW_MESSAGE_CONFIRM',
    p_par_pgr_id => 'ADC',
    p_par_description => 'apex.message.showDialog.options objekt adjusting settings for the dialog',
    p_par_string_value => '{title:#PARAM_2#,modern:true,returnFocusTo:#ITEM#,confirm:true,type:dialog}'
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_EMBED_RULE_GROUPS',
    p_par_pgr_id => 'ADC',
    p_par_description => 'When exporting rule groups along with the application, it is possible to integrate the rule groups as supporting objects. If FALSE, application export and rule groups are exported seperately in a ZIP file',
    p_par_boolean_value => false
  );
  
  param_admin.edit_parameter(
    p_par_id => 'ADC_EXCLUDE_ACTION_TYPES',
    p_par_pgr_id => 'ADC',
    p_par_description => ':-separated list of predefined action types which ust not be used in the local environment',
    p_par_string_value => ''
  );

  -- Realms used

  -- Local parameters

  commit;
end;
/