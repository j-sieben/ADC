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
         when item_source_data_type in ('NUMBER', 'DATE', 'TIMESTAMP') or format_mask is not null or instr(upper(item_label_template), 'REQUIRED') > 0 then adc_util.C_TRUE 
         else adc_util.C_FALSE end  cpi_is_required
  from apex_application_page_items aai
  join adc_rule_groups sgr
    on application_id = sgr.crg_app_id
   and page_id = sgr.crg_page_id
 union all
-- APPLICATION ITEMS
select crg_id, item_name, 'APP_ITEM', 'ITEM', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_items
  join adc_rule_groups sgr
    on application_id = sgr.crg_app_id
 union all
-- BUTTONS
select crg_id, button_static_id, 'BUTTON', 'BUTTON', 'ACTION', label, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_page_buttons
  join adc_rule_groups sgr
    on application_id = sgr.crg_app_id
   and page_id = sgr.crg_page_id
 where button_static_id is not null
 union all
-- REGIONS
select crg_id, static_id, 
       case source_type_code
         when 'NATIVE_SQL_REPORT' then 'REPORT_REGION'
         when 'NATIVE_IR' then 'INTERACTIVE_REPORT_REGION'
         when 'NATIVE_IG' then 'INTERACTIVE_GRID_REGION'
         when 'NATIVE_FORM' then 'FORM_REGION' 
         when 'JSTREE' then 'TREE_REGION' 
         else 'REGION' end, 
       'REGION', null, region_name, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_page_regions
  join adc_rule_groups sgr
    on application_id = sgr.crg_app_id
   and page_id = sgr.crg_page_id
 where static_id is not null
 union all
-- EVENTS and COMMANDS
select crg_id, cet_column_name, 'EVENT', 'EVENT', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from adc_event_types_v
 cross join adc_rule_groups sgr
 union all
-- GENERICALLY REQUIRED ENTRIES
select crg_id, 'DOCUMENT', 'DOCUMENT' || case page_mode when 'Modal Dialog' then '_MODAL' end, 'FRAMEWORK', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from apex_application_pages
  join adc_rule_groups sgr
    on application_id = sgr.crg_app_id
   and page_id = sgr.crg_page_id
 union all
select crg_id, 'ALL', 'ALL', 'FRAMEWORK', null, null, null, null, null, adc_util.C_FALSE, adc_util.C_FALSE
  from adc_rule_groups;

comment on table adc_bl_page_targets is 'View to collect all page components that are accessible by ADC, along with an item type categorization for grouping in ITEM_FOCUS etc.';
comment on column adc_bl_page_targets.cpi_crg_id is 'ID to the rule group';
comment on column adc_bl_page_targets.cpi_id is 'Static ID to the page item';
comment on column adc_bl_page_targets.cpi_cpit_id is 'Item type of the page item, reference to ADC_PAGE_ITEM_TYPES';
comment on column adc_bl_page_targets.cpi_cpitg_id is 'Item group of the page item, reference to ADC_PAGE_ITEM_TYPE_GROUPS';
comment on column adc_bl_page_targets.cpi_caat_id is 'Optional APEX action type of the page item, if an APEX action, reference to ADC_APEX_ACTION_TYPES';
comment on column adc_bl_page_targets.cpi_label is 'Label of the page item';
comment on column adc_bl_page_targets.cpi_conversion is 'Optional format mask of the page item';
comment on column adc_bl_page_targets.cpi_item_default is 'Optional default item value for a mandatory item';
comment on column adc_bl_page_targets.cpi_css is 'Any CSS class attatched to the page item, separated by |-signs';
comment on column adc_bl_page_targets.cpi_is_mandatory is 'Flag to indicate whether this page item is initially mandatory. Taken from the APEX metadata';
comment on column adc_bl_page_targets.cpi_is_required is 'Flag to indicate whether this page item is necessary for ADC. A page item is necessary, if ADC has to react on item value changes';
