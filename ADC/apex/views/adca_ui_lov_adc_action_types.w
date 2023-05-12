create or replace force view adca_ui_lov_adc_action_types
as 
select cat_name d, cat_id r, case when column_value is null then 0 else 1 end cat_excluded
  from adc_action_types_v
  left join table(
       utl_text.string_to_table(param.get_string('ADC_EXCLUDE_ACTION_TYPES', 'ADC'), ':'))
    on cat_id = column_value
 where cat_cato_id = 'ADC';
 
comment on table adca_ui_lov_adc_action_types is 'View with all predefined ADC action types';
