
@&tool_dir.check_has_column ADC_ACTION_PARAM_TYPES CAPT_SELECT_LIST_QUERY "varchar2(1000 byte)"

@&tool_dir.check_has_column ADC_ACTION_PARAM_TYPES CAPT_SELECT_VIEW_COMMENT "varchar2(200 byte)"


comment on column adc_action_param_types.capt_select_list_query is 'Optional SQL query for static or dynamic parameter types';
comment on column adc_action_param_types.capt_select_view_comment is 'Optional comment to explain what the select list contains';
