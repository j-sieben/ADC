-- Fixit Job
create or replace type msg_args is
  /** Basic array of MESSAGE_TYPE parameters */
  varray(20) of clob;
/

create or replace type msg_param force as object(
  /** Type to be used as a key value pair to pass parameter or variable values along with their value */
  p_param varchar2(128 byte),
  p_value varchar2(4000 byte),
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in varchar2)
    return self as result,
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in date)
    return self as result,
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in number)
    return self as result,
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in timestamp)
    return self as result,
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in timestamp with time zone)
    return self as result
);
/

create or replace type body msg_param
as
 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in varchar2)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := substrb(p_value, 1, 4000 - length(C_EXTENSION));
   if self.p_value != p_value then
     self.p_value := self.p_value || C_EXTENSION;
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in date)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SS');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in number)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'fm999999999999999999990D9999999999999999');
   else
     self.p_value := to_char(p_value, 'fm999999999999999999999');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in timestamp)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SSXFF');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in timestamp with time zone)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SSXFF TZR');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

end;
/

create or replace type msg_params as
  /** List type for MSG_PARAM */
  table of msg_param;
/



create or replace package msg
as

  PIT_PASS_MESSAGE constant varchar2(2000 byte) := '#1#';
  ASSERTION_FAILED constant varchar2(2000 byte) := 'Assertion failed.';
  ASSERT_DATATYPE constant varchar2(2000 byte) := '#1# is not of data type #2#.';
  ASSERT_EXISTS constant varchar2(2000 byte) := 'A statement is supposed to return rows, but it does not.';
  ASSERT_NOT_EXISTS constant varchar2(2000 byte) := 'A statement is not supposed to return lines, but does so anyway.';
  ASSERT_TRUE constant varchar2(2000 byte) := 'A value was expected to be equal, but was not.';
  ASSERT_TRUE_ERR exception;
  pragma EXCEPTION_INIT(ASSERT_TRUE_ERR, -20000);
  ASSERT_IS_NULL constant varchar2(2000 byte) := 'A value was expected to be null, but was [#1#].';
  ASSERT_IS_NOT_NULL constant varchar2(2000 byte) := '#1# was expected, but was null.';
  UTL_PARAMETER_REQUIRED constant varchar2(2000 byte) := 'Parameter "#1#" must not be NULL.';
  SQL_ERROR constant varchar2(2000 byte) := 'SQL Error occurred: #SQLERRM#';
  CONVERSION_IMPOSSIBLE constant varchar2(2000 byte) := 'A conversion could not be performed';
  CONVERSION_IMPOSSIBLE_ERR exception;
  pragma exception_init(CONVERSION_IMPOSSIBLE_ERR, -20001);
  INVALID_DATE constant varchar2(2000 byte) := 'Invalid date: #1#';
  INVALID_DATE_ERR exception;
  pragma exception_init(INVALID_DATE_ERR, -20002);
  INVALID_DATE_FORMAT constant varchar2(2000 byte) := 'Invalid date format: #1#';
  INVALID_DATE_FORMAT_ERR exception;
  pragma exception_init(INVALID_DATE_FORMAT_ERR, -20003);
  INVALID_YEAR constant varchar2(2000 byte) := '#1#';
  INVALID_YEAR_ERR exception;
  pragma exception_init(INVALID_YEAR_ERR, -20004);
  INVALID_MONTH constant varchar2(2000 byte) := '#1#';
  INVALID_MONTH_ERR exception;
  pragma exception_init(INVALID_MONTH_ERR, -20005);
  INVALID_DAY constant varchar2(2000 byte) := '#1#';
  INVALID_DAY_ERR exception;
  pragma exception_init(INVALID_DAY_ERR, -20006);
  INVALID_NUMBER_FORMAT constant varchar2(2000 byte) := 'Invalid number format: #1#';
  INVALID_NUMBER_FORMAT_ERR exception;
  pragma exception_init(INVALID_NUMBER_FORMAT_ERR, -20007);
  
  PIT_MSG_NOT_EXISTING constant varchar2(2000 byte) := 'Message #1# does not exist. Call PIT using Package MSG to avoid this error.';
  PIT_MSG_NOT_EXISTING_ERR exception;
  pragma exception_init(PIT_MSG_NOT_EXISTING_ERR, -20007);
  
  adc_initialze_cgr_failed constant varchar2(2000 byte) := 'Error during initialization of control group #1#: #2#';
  ADC_RULE_VIEW_DELETED constant varchar2(2000 byte) := 'Rule group view #1# has been deleted.';
  ADC_VIEW_CREATION constant varchar2(2000 byte) := 'Error creating rule group view #1#: #2#.';
  ADC_MERGE_RULE_GROUP constant varchar2(2000 byte) := 'Error while merging rule group #1#: #SQLERRM#.';
  ADC_PARAM_MISSING constant varchar2(2000 byte) := 'Item #LABEL# is a mandatory field.';
  ADC_CGR_MUST_BE_UNIQUE constant varchar2(2000 byte) := 'The rule group already exists. Choose a unique name.';
  ADC_UNKNOWN_EXPORT_MODE constant varchar2(2000 byte) := 'The export type #1# is unknown.';
  ADC_NO_RULE_GROUP_FOUND constant varchar2(2000 byte) := 'No data found for workspace #1# and application #2#.';
  ADC_MERGE_RULE_ACTION constant varchar2(2000 byte) := 'Error when merging rule action #1#, #2#: #SQLERRM#.';
  ADC_OUTPUT_REDUCED constant varchar2(2000 byte) := '// Output reduced to level #1# because of length';
  ADC_OUTPUT_CLIPPED constant varchar2(2000 byte) := '// Another JavaScript action suppressed because too long';
  ADC_INIT_ORIGIN constant varchar2(2000 byte) := '// Rule #1# (#2#), triggered on page load';
  ADC_RULE_ORIGIN constant varchar2(2000 byte) := '// Recursion #1#: #2# (#3#), Triggering element: "#4#", Duration: #TIME##NOTIFICATION#';
  ADC_ERROR_HANDLING constant varchar2(2000 byte) := '// error occurred in recursion #1#, rule #2# (#3#), triggering element: "#4#", execute error handling';
  ADC_ITEM_IS_MANDATORY constant varchar2(2000 byte) := 'Element #LABEL# is a mandatory element. Please enter a value.';
  ADC_UNEXPECTED_CONV_TYPE constant varchar2(2000 byte) := 'Unexpected element type ~#1#~ with format mask.';
  ADC_UNHANDLED_EXCEPTION constant varchar2(2000 byte) := 'Error executing "#1#", cannot continue work.';
  ADC_DEBUG_RULE_STMT constant varchar2(2000 byte) := 'Rule SQL: "#1#"';
  ADC_PROCESSING_RULE constant varchar2(2000 byte) := 'Create action for rule #1# (#2#)';
  ADC_NO_JAVASCRIPT constant varchar2(2000 byte) := '#2#// No JavaScript code for rule "#1#"';
  ADC_INTERNAL_ERROR constant varchar2(2000 byte) := 'Invalid number. Expected format ~#1#~.';
  ADC_RECURSION_LOOP constant varchar2(2000 byte) := 'Element #1# created a recursive loop at recursion depth #2# and was therefore ignored.';
  ADC_RECURSION_LIMIT constant varchar2(2000 byte) := 'Element #1# has exceeded recursion depth of #2#.';
  ADC_INVALID_NUMBER_REMOVED constant varchar2(2000 byte) := 'Invalid number: "#1#"';
  ADC_RULE_DOES_NOT_EXIST constant varchar2(2000 byte) := 'Rule #1# does not exist.';
  ADC_ACTION_DOES_NOT_EXIST constant varchar2(2000 byte) := 'SCT action #1# does not exist.';
  ADC_SESSION_STATE_SET constant varchar2(2000 byte) := 'Element ~#1#~ was set to the value ~#2#~.';
  ADC_NO_DATA_FOR_ITEM constant varchar2(2000 byte) := 'No data found for #1#.';
  ADC_PARAM_LOV_MISSING constant varchar2(2000 byte) := 'The LOV view #1# does not have the specified columns D, R and CGR_ID.';
  ADC_PARAM_LOV_INCORRECT constant varchar2(2000 byte) := 'The parameter type #1# requires a LOV view of the name #2#. This is missing.';
  ADC_UNKNOWN_CPT constant varchar2(2000 byte) := 'Unknown parameter type: #1#';
  
end msg;
/


create or replace package pit
as

  procedure enter_detailed(
    p_action in varchar2 default null,
    p_params in msg_params default null);
    
  procedure leave_detailed(
    p_params in msg_params default null);

  procedure enter_optional(
    p_action in varchar2 default null,
    p_params in msg_params default null);
    
  procedure leave_optional(
    p_params in msg_params default null);

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_params in msg_params default null);
    
  procedure leave_mandatory(
    p_params in msg_params default null);
    
  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null);
    
  procedure handle_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null);
    
  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null);
    
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  procedure assert_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  procedure assert_exists(
    p_cursor in sys_refcursor,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  procedure assert_not_exists(
    p_cursor in sys_refcursor,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
    return clob;
    
  function get_trans_item_name(
    p_pti_pmg_name in varchar2,
    p_pti_id in varchar2,
    p_msg_args msg_args default null,
    p_pti_pml_name in varchar2 default null)
    return varchar2;  
    
end pit;
/

create or replace package pit_admin
as

  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%TYPE,
    p_pti_pml_name in varchar2,
    p_pti_pmg_name in varchar2,
    p_pti_name in varchar2,
    p_pti_display_name in varchar2 default null,
    p_pti_description in clob default null);

end pit_admin;
/

create or replace package param
as

  function get_boolean(
    p_par_id in varchar2,
    p_par_pgr_id in varchar2)
    return boolean;

  function get_integer(
    p_par_id in varchar2,
    p_par_pgr_id in varchar2)
    return pls_integer;

  function get_string(
    p_par_id in varchar2,
    p_par_pgr_id in varchar2)
    return varchar2;
end param;
/

create table pit_translatable_item(
  pti_id varchar2(128 byte), 
	pti_pml_name varchar2(128 byte) default on null 'AMERICAN', 
	pti_pmg_name varchar2(128 byte) default on null 'ADC' constraint chk_pti_pmg_name check (pti_pmg_name is not null) , 
	pti_name varchar2(200 char), 
	pti_display_name varchar2(200 char), 
	pti_description clob, 
	pti_uid varchar2(128 byte) generated always as (case pti_pml_name when 'GERMAN' then pti_id else null end) virtual , 
	pti_upmg varchar2(128 byte) generated always as (case pti_pml_name when 'GERMAN' then pti_pmg_name else null end) virtual,
  constraint pit_translatable_item_pk primary key (pti_id, pti_pmg_name, pti_pml_name),
  constraint pti_uid_u unique (pti_uid, pti_upmg)
);

create index idx_pti_pmg_name_fk on pit_translatable_item (pti_pmg_name);
  
comment on column pit_translatable_item.pti_id is 'ID of the translatable item, part of the PK in conjunction with PIT_PML_NAME';
comment on column pit_translatable_item.pti_pml_name is 'Part of the PK, reference to PIT_MESSAGE_LANGUAGE. Taken from Oracle v$nls_valid_values';
comment on column pit_translatable_item.pti_pmg_name is 'Part of the PK, reference to PIT_MESSAGE_GROUP, criteria to group messages and translatables items per group';
comment on column pit_translatable_item.pti_name is 'Name. Optionally contains replacement anchors';
comment on column pit_translatable_item.pti_display_name is 'Display name. Used for UI display purposes. Optionally contains replacement anchors';
comment on column pit_translatable_item.pti_description is 'Help text or further description. No replacement anchors allowed';
comment on column pit_translatable_item.pti_uid is 'Virtual column as a surrogate primary key for references';
comment on column pit_translatable_item.pti_upmg is 'Virtual column as a surrogate primary key for references';
comment on table pit_translatable_item  is 'Central translatable item repository in various languages.';

create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from pit_translatable_item;