create or replace force view adc_bl_page_targets
as
select crg_id cpi_crg_id,
       item_name cpi_id,
       case 
       -- priorize data type detection
       when item_source_data_type = 'NUMBER' then 'NUMBER_ITEM'
       when item_source_data_type in ('DATE', 'TIMESTAMP') then 'DATE_ITEM'
       when item_source_data_type = 'ROWID' then 'ROWID_ITEM'
       when regexp_like(format_mask, '(^|(FM))[09DGL\.\,]+$', 'i') then 'NUMBER_ITEM'
       when format_mask is not null then 'DATE_ITEM'
       else 'ITEM' end cpi_cpit_id,
       'ITEM' cpi_cpitg_id,
       case replace(display_as_code, 'NATIVE_')
         when 'SELECT_LIST' then 'RADIO_GROUP'
         when 'RADIO_GROUP' then 'RADIO_GROUP'
         when 'YES_NO' then 'TOGGLE'
         when 'CHECKBOX' then 'TOGGLE'
         else null end cpi_caat_id,
       label cpi_label,
       format_mask cpi_conversion,
       item_default cpi_item_default,
       '|' || replace(trim(item_css_classes), ' ', '|') || '|' || replace(trim(html_form_element_css_classes), ' ', '|') || '|' cpi_css,
       -- Default mandatory items
       case when instr(upper(item_label_template), 'REQUIRED') > 0 then adc_util.C_TRUE else adc_util.C_FALSE end cpi_is_mandatory,
       -- default required items
       case
         when item_source_data_type in ('NUMBER', 'DATE', 'TIMESTAMP')
           or format_mask is not null 
           or instr(upper(item_label_template), 'REQUIRED') > 0 
         then adc_util.C_TRUE 
         else adc_util.C_FALSE end cpi_is_required,
       case when display_as_code in ('NATIVE_DISPLAY_ONLY') then adc_util.C_FALSE else adc_util.C_TRUE end cpi_may_have_value,
       aar.static_id cpi_form_region_id
  from apex_application_page_items aai
  join adc_rule_groups crg
    on aai.application_id = crg.crg_app_id
   and aai.page_id = crg.crg_page_id
  left join apex_application_page_regions aar
    on crg.crg_app_id = aar.application_id
   and crg.crg_page_id = aar.page_id
   and aai.data_source_region_id = aar.region_id
 union all
-- APPLICATION ITEMS
select crg_id, item_name, 'APP_ITEM', 'ITEM', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from apex_application_items
  join adc_rule_groups crg
    on application_id = crg.crg_app_id
 union all
-- BUTTONS
select crg_id, button_static_id, 'BUTTON', 'BUTTON', 'ACTION', label, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from apex_application_page_buttons
  join adc_rule_groups crg
    on application_id = crg.crg_app_id
   and page_id = crg.crg_page_id
 where button_static_id is not null
 union all
-- REGIONS
select crg_id, static_id, 
       case source_type_code
         when 'NATIVE_SQL_REPORT' then 'REPORT_REGION'
         when 'SQL_QUERY' then 'REPORT_REGION'
         when 'DYNAMIC_QUERY' then 'INTERACTIVE_REPORT_REGION'
         when 'NATIVE_IR' then 'INTERACTIVE_REPORT_REGION'
         when 'NATIVE_IG' then 'INTERACTIVE_GRID_REGION'
         when 'NATIVE_FORM' then 'FORM_REGION' 
         when 'JSTREE' then 'TREE_REGION' 
         else 'REGION' end, 
       'REGION', null, region_name, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from apex_application_page_regions
  join adc_rule_groups crg
    on application_id = crg.crg_app_id
   and page_id = crg.crg_page_id
 where static_id is not null
 union all
-- EVENTS and COMMANDS
select crg_id, cet_column_name, 'EVENT', 'EVENT', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from adc_event_types_v
 cross join adc_rule_groups crg
 union all
-- GENERICALLY REQUIRED ENTRIES
select crg_id, 'DOCUMENT', 'DOCUMENT' || case page_mode when 'Modal Dialog' then '_MODAL' end, 'FRAMEWORK', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from apex_application_pages
  join adc_rule_groups crg
    on application_id = crg.crg_app_id
   and page_id = crg.crg_page_id
 union all
select crg_id, 'ALL', 'ALL', 'FRAMEWORK', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE, adc_util.C_FALSE, null
  from adc_rule_groups;