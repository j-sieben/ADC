create or replace type ut_adc_param 
  authid definer
as object(
  id number,                               -- internal ID of the record
  cgr_id number,                           -- actual CGR_ID
  firing_item varchar2(128 byte),          -- actual firing item (or adc_util.C_NO_FIRING_ITEM)
  firing_event varchar2(128 byte),         -- actual firing event (normally change or click, but can be any event)
  error_dependent_items varchar2(2000),    -- List of items to deactivate if the page contains errors
  bind_items char_table,                   -- List of items for which ADC binds event handlers
  page_items char_table,                   -- List of items that changed their value in the session state
  firing_items char_table,                 -- List of items which are connected with firing item within their rules
  error_stack char_table,                  -- List errors that occurred
  recursive_stack char_table,              -- List of items which were marked to recursively check rules for
  is_recursive varchar2(128 byte),         -- Flag to indicate whether we're in a recursive rule run
  js_action_stack ut_adc_js_list,          -- JavaScript action stack, rule outcome of the rules executed so far
  level_length char_table,                 -- cumulated length of the strings on the respective severity levels
  recursive_level number,                  -- actual recursive level
  allow_recursion char(1 byte),            -- Flag to indicate whether recursive calls are allowed for the active rule
  notification_stack varchar2(4000 byte),  -- List of notifications to be shown in the browser console
  stop_flag char(1 byte),                  -- Flag to indicate that all rule execution has to be stopped
  now number                               -- Time in hsec
);
/

