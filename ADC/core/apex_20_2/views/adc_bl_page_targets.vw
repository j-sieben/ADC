create or replace editionable view adc_bl_page_targets
as 
select cgr_id cpi_cgr_id,
       item_name cpi_id,
       case 
       -- priorize data type detection
       when item_source_data_type = 'NUMBER' then 'NUMBER_ITEM'
       when item_source_data_type in ('DATE', 'TIMESTAMP') then 'DATE_ITEM'
       when regexp_like(format_mask, '(^|(FM))[09DGL\.\,]+$', 'i') then 'NUMBER_ITEM'
       when format_mask is not null then 'DATE_ITEM'
       else 'ITEM' end cpi_cit_id,
       case replace(display_as_code, 'NATIVE_')
         when 'SELECT_LIST' then 'RADIO_GROUP'
         when 'RADIO_GROUP' then 'RADIO_GROUP'
         when 'YES_NO' then 'TOGGLE'
         when 'CHECKBOX' then 'TOGGLE'
         else null end cpi_cty_id,
       label cpi_label,
       coalesce(
         format_mask, 
         case item_source_data_type
           when 'NUMBER' then 'fm999999999999999990'
           when 'DATE' then
             (select date_format
                from apex_applications app
               where app.application_id = aai.application_id)
           else null end
       ) cpi_conversion,
       item_default cpi_item_default,
       '|' || replace(trim(item_css_classes), ' ', '|') || '|' || replace(trim(html_form_element_css_classes), ' ', '|') || '|' cpi_css,
       -- default mandatory items
       case when instr(upper(item_label_template), 'REQUIRED') > 0 then adc_util.C_TRUE else adc_util.C_FALSE end cpi_is_mandatory,
       -- default required items
       case
         when item_source_data_type in ('NUMBER', 'DATE', 'TIMESTAMP') or format_mask is not null or instr(upper(item_label_template), 'REQUIRED') > 0 then adc_util.C_TRUE 
         else adc_util.C_FALSE end  cpi_is_required
  from apex_application_page_items aai
  join adc_rule_groups sgr
    on application_id = sgr.cgr_app_id
   and page_id = sgr.cgr_page_id
 union all
select cgr_id, item_name, 'APP_ITEM', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_items
  join adc_rule_groups sgr
    on application_id = sgr.cgr_app_id
 union all
select cgr_id, button_static_id, 'BUTTON', 'ACTION', label, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_page_buttons
  join adc_rule_groups sgr
    on application_id = sgr.cgr_app_id
   and page_id = sgr.cgr_page_id
 where button_static_id is not null
 union all
select cgr_id, static_id, 'REGION', null, region_name, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_page_regions
  join adc_rule_groups sgr
    on application_id = sgr.cgr_app_id
   and page_id = sgr.cgr_page_id
 where static_id is not null
 union all
select cgr_id, 'DOCUMENT', 'DOCUMENT', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from adc_rule_groups
 union all
select cgr_id, 'ALL', 'ALL', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from adc_rule_groups;
