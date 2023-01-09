declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor obj_cur is
    select object_type type, object_name name
      from user_objects
     where (object_name like 'PD%'
        or object_name like 'PIT%')
       and object_type in ('TABLE', 'VIEW', 'TYPE', 'PACKAGE', 'SEQUENCE');       
begin
  for obj in obj_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
                        end;
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        null;
      when others then
        raise;
    end;
  end loop;
end;
/

prompt SEQUENCES
prompt -  PD_PIT_LOG_SEQ
create sequence pd_pit_log_seq;

prompt *  TABLES
prompt -  PD_PARAMETER_GROUP
create table pd_parameter_group(
   pgr_id varchar2(128 byte),
   pgr_description varchar2(255),
   pgr_is_modifiable char(1 byte) default 'Y',
   constraint pd_parameter_group_pk primary key (pgr_id),
   constraint pgr_is_modifiable_chk check (pgr_is_modifiable in ('Y', 'N'))
) organization index;

prompt -  PD_PARAMETER
create table pd_parameter(
   par_id varchar2(128 byte),
   par_pgr_id varchar2(128 byte),
   par_description varchar2(200 char),
   par_string_value clob,
   par_raw_value blob,
   par_xml_value xmltype,
   par_integer_value number(38,0),
   par_float_value number,
   par_date_value date,
   par_timestamp_value timestamp with time zone,
   par_boolean_value char(1 byte),
   par_is_modifiable char(1 byte),
   par_validation_string varchar2(4000 char),
   par_validation_message varchar2(4000 char),
   constraint par_pgr_id_pk primary key (par_id, par_pgr_id),
   constraint par_pgr_id_fk foreign key (par_pgr_id) references pd_parameter_group(pgr_id) on delete cascade,
   constraint par_boolean_value_chk check (par_boolean_value in ('Y', 'N')),
   constraint par_is_modifiable_chk check (par_is_modifiable in ('N'))
);


prompt -  PD_PIT_MESSAGE_GROUP
create table pd_pit_message_group(
  pmg_name varchar2(128 byte),
  pmg_description varchar2(200 char),
  pmg_error_prefix varchar2(6 byte) default '',
  pmg_error_postfix varchar2(6 byte) default 'ERR',
  constraint pk_pmg_id primary key(pmg_name)
) organization index;


prompt -  MSG_PARAM


prompt -  PD_PIT_MESSAGE
create table pd_pit_message(
   pms_name varchar2(128 byte), 
   pms_pmg_name varchar2(128 byte),
   pms_pml_name varchar2(128 byte),
   pms_text clob, 
   pms_description clob,
   pms_pse_id number(3,0),
   pms_custom_error number,
   pms_active_error number,
   pms_id varchar2(128 byte) generated always as (case pms_pml_name when 'AMERICAN' then pms_name else null end) virtual,
   constraint pd_pit_message_pk primary key (pms_name, pms_pml_name),
   constraint pms_id_u unique (pms_id),
   constraint pms_pmg_name_fk foreign key (pms_pmg_name)
      references pd_pit_message_group(pmg_name),
   constraint pms_text_nn check (pms_text is not null)
);


create index pit_pms_pml_name_fk_idx on pd_pit_message(pms_pml_name);
-- Unique conditional index to prevent server errors to be initialized more than once
create unique index pms_custom_error_u on pd_pit_message(
  case 
  when coalesce(pms_custom_error, -20000) != -20000 
   and pms_pml_name = 'AMERICAN'
  then pms_custom_error
  else null end);
  
  
prompt -  PD_PIT_TRANSLATABLE_ITEM
create table pd_pit_translatable_item(
   pti_id varchar2(128 byte), 
   pti_pml_name varchar2(128 byte),
   pti_pmg_name varchar2(128 byte),
   pti_name varchar2(200 char), 
   pti_display_name varchar2(200 char),
   pti_description clob,
   pti_uid varchar2(128 byte) generated always as (case pti_pml_name when 'AMERICAN' then pti_id else null end) virtual,
   pti_upmg varchar2(128 byte) generated always as (case pti_pml_name when 'AMERICAN' then pti_pmg_name else null end) virtual,
   constraint pd_pit_translatable_item_pk primary key (pti_id, pti_pmg_name, pti_pml_name),
   constraint pti_uid_u unique (pti_uid, pti_upmg),
   constraint pti_pmg_name_fk foreign key (pti_pmg_name)
      references pd_pit_message_group(pmg_name) on delete cascade,
   constraint chk_pti_pmg_name check(pti_pmg_name is not null)
);

create index idx_pti_pmg_name_fk on pd_pit_translatable_item(pti_pmg_name);

prompt -  UTL_TEXT_TEMPLATES
create table utl_text_templates(
  uttm_name varchar2(128 byte), 
	uttm_type varchar2(128 byte), 
	uttm_mode varchar2(128 byte) default 'DEFAULT', 
	uttm_text varchar2(4000 char), 
	uttm_log_text varchar2(1000 char), 
	uttm_log_severity number(2,0) default 70,
  constraint pk_utl_text_templates primary key (uttm_name, uttm_type, uttm_mode),
  constraint chk_uttm_text_nn check(uttm_text is not null),
  constraint chk_uttm_log_severity check(uttm_log_severity in (20,30,40,50,60,70))
);

prompt *  TYPES
prompt - CHAR_TABLE
create or replace type char_table as table of varchar2(4000 byte);
/

prompt - CLOB_TABLE
create or replace type clob_table as table of clob;
/

prompt -  MSG_ARGS
create or replace type msg_args force is varray(20) of clob;
/

prompt -  MESSAGE_TYPE
create or replace type message_type force 
  authid definer
is object(
  id number,
  message_name varchar2(128 byte),
  affected_id varchar2(4000 byte),     
  error_code varchar2(30 char),
  session_id varchar2(64 byte),
  schema_name varchar2(128 byte),
  module varchar2(128 byte),
  action varchar2(128 byte),
  user_name varchar2(128 byte),
  message_text clob,
  message_description clob,
  severity number(2,0),
  stack varchar2(2000 byte),
  backtrace varchar2(2000 byte),
  error_number number (5,0),
  message_args msg_args,
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,        
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result)
final instantiable;
/


create or replace type body message_type
as

  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result
  as
    C_FAILURE constant number := 1;
    l_locale varchar2(100 byte);
    l_language varchar2(100 byte);
    l_territory varchar2(100 byte);
    l_status number(1, 0);
    l_error_message varchar2(1000 byte);
    l_json_parameters varchar2(32767 byte);
    -- Cursor to detect replacement anchors and separate their inner structure
    cursor anchor_cur(p_message_text in varchar2) is
      with regex as(
             select '#' anchor_char,
                    '|' anchor_separator,
                    '\#[A-Z0-9].*?\#' anchor_regex,
                    '[^\|]+' anchor_name_regex,
                    '(.*?)(\||$)' anchor_part_regex,
                    q'^[0-9]+$^' valid_anchor_regex
               from dual),
           anchors as (
              select trim(anchor_char from regexp_substr(p_message_text, anchor_regex, 1, level)) replacement_string,
                     anchor_char, anchor_name_regex, anchor_part_regex, valid_anchor_regex
                from regex
             connect by level <= regexp_count(p_message_text, anchor_char) / 2),
           parts as(
             select anchor_char || replacement_string || anchor_char as replacement_string,
                    upper(regexp_substr(replacement_string, anchor_name_regex, 1, 1)) anchor,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 2, null, 1) prefix,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 3, null, 1) postfix,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 4, null, 1) null_value,
                    valid_anchor_regex
               from anchors)
      select replacement_string, anchor, prefix, postfix, null_value,
             case when regexp_instr(anchor, valid_anchor_regex) > 0 then 1 else 0 end valid_anchor_name
        from parts
       where anchor is not null;
  begin
    select pms_text, pms_description, pms_pse_id, pms_active_error
      into self.message_text, self.message_description, self.severity, self.error_number
      from pd_pit_message
     where pms_name = p_message_name;
     
    self.id := pd_pit_log_seq.nextval;
    self.message_name := p_message_name;    
    self.affected_id := p_affected_id;
    self.error_code := p_error_code;
    self.session_id := p_session_id;
    self.schema_name := p_schema_name;
    self.user_name := p_user_name;
    self.message_args := p_msg_args;
    
    if sqlcode != 0 then
      self.message_text := replace(self.message_text, '#SQLERRM#', substr(sqlerrm, 12));
    end if;

    -- replace anchors with msg params
    if p_msg_args is not null then
      for a in anchor_cur(self.message_text) loop
        if a.valid_anchor_name = 1 then
          if p_msg_args.count >= a.anchor then
            if p_msg_args(a.anchor) is not null then
              self.message_text := replace(self.message_text, a.replacement_string, a.prefix || p_msg_args(a.anchor) || a.postfix);
            else
              self.message_text := replace(self.message_text, a.replacement_string, a.null_value);
            end if;
          end if;
        end if;
      end loop;
    end if;
    
    return;
  end;
end;
/


prompt -  PIT_MESSAGE_TABLE
create or replace type pit_message_table force as table of message_type;
/


prompt -  MSG_PARAM
create or replace type msg_param force 
   authid definer
as object(
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
    p_value in clob)
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
    return self as result,
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in xmltype)
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
   self.p_value := substrb(p_value, 1, 2000);
   if self.p_value != p_value then
     self.p_value := self.p_value || C_EXTENSION;
   end if;
   return;
 end;
 
 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in clob)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := dbms_lob.substr(p_value, 2000, 1);
   if dbms_lob.getlength(p_value) > 2000 then
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
   self.p_param := substrb(p_param, 1, 128);
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

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in xmltype)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value is not null then
     self.p_value := substr(p_value.getClobVal(), 1, 2000);
     if self.p_value != p_value.getClobVal() then
       self.p_value := self.p_value || C_EXTENSION;
     end if;
   end if;
   return;
 end;

end;
/


prompt -  MSG_PARAMS
create or replace type msg_params force as 
  table of msg_param;
/


prompt -  PIT_CALL_STACK_TYPE
create or replace type pit_call_stack_type force
  authid definer
is object (
  id integer,
  user_name varchar2(128 byte),
  module_name varchar2(128 byte),
  method_name varchar2(128 byte),
  app_module varchar2(128 byte),
  app_action varchar2(128 byte),
  client_info varchar2(64 byte),
  session_id varchar2(64 byte),
  long_op_idx integer,
  long_op_sno integer,
  params msg_params,
  wall_clock timestamp,
  elapsed integer,
  elapsed_cpu integer,
  total interval day to second,
  total_cpu integer,
  total_cpu_point integer,
  call_level integer,
  last_resume_point integer,
  last_cpu_resume_point integer,
  trace_level integer,
  trace_timing char(1 byte),
  member procedure pause(
    self in out nocopy pit_call_stack_type),
  member procedure resume(
    self in out nocopy pit_call_stack_type),
  member procedure leave(
    self in out nocopy pit_call_stack_type),
  constructor function pit_call_stack_type(
    self in out nocopy pit_call_stack_type,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_module_name in varchar2,
    p_method_name in varchar2,
    p_app_module in varchar2,
    p_app_action in varchar2,
    p_client_info in varchar2,
    p_params in msg_params,
    p_call_level in integer,
    p_trace_level in integer,
    p_trace_timing in char)
    return self as result
)
final instantiable;
/

create or replace type body pit_call_stack_type
as
  /** Implements the call stack type functionality */

  /** Method to pause the measurement of timing information */
  member procedure pause(
    self in out nocopy pit_call_stack_type)
  as
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = 'Y' then
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := self.elapsed + (now_time - self.last_resume_point);
      self.elapsed_cpu := self.elapsed_cpu + (now_cpu_time - self.last_cpu_resume_point);
    end if;
  end pause;

  /** Method to resume the measurement of timing information */
  member procedure resume(
    self in out nocopy pit_call_stack_type)
  as
  begin
    if self.trace_timing = 'Y' then
      self.last_resume_point := dbms_utility.get_time;
      self.last_cpu_resume_point := dbms_utility.get_cpu_time;
    end if;
  end resume;

  /** Method to collect timing information upon leaving a method */
  member procedure leave(
    self in out nocopy pit_call_stack_type)
  as
    now timestamp;
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = 'Y' then
      now := localtimestamp;
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := self.elapsed + (now_time - self.last_resume_point);
      self.elapsed_cpu := self.elapsed_cpu + (now_cpu_time - self.last_cpu_resume_point);
      self.total := now - self.wall_clock;
      self.total_cpu := now_cpu_time - self.total_cpu_point;
      self.wall_clock := now;
    end if;
  end leave;

  /** constructor function */
  constructor function pit_call_stack_type(
    self in out nocopy pit_call_stack_type,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_module_name in varchar2,
    p_method_name in varchar2,
    p_app_module in varchar2,
    p_app_action in varchar2,
    p_client_info in varchar2,
    p_params in msg_params,
    p_call_level in integer,
    p_trace_level in integer,
    p_trace_timing in char)
    return self as result
  as
    now_time integer;
    now_cpu_time integer;
  begin
    self.id := pd_pit_log_seq.nextval;
    self.session_id := p_session_id;
    self.module_name := p_module_name;
    self.method_name := p_method_name;
    self.app_module := p_app_module;
    self.app_action := p_app_action;
    self.client_info := p_client_info;
    self.params := p_params;
    self.user_name := p_user_name;
    self.call_level := p_call_level;
    self.trace_level := p_trace_level;
    self.trace_timing := p_trace_timing;
    if self.trace_timing = 'Y' then
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.wall_clock := localtimestamp;
      self.elapsed := 0;
      self.elapsed_cpu := 0;
      self.total := interval '0' second;
      self.total_cpu := 0;
      self.last_resume_point := now_time;
      self.total_cpu_point := now_cpu_time;
      self.last_cpu_resume_point := now_cpu_time;
    end if;
    return;
  end;
end;
/


prompt *  PACKAGES
prompt -  PARAM_ADMIN
create or replace package param_admin
  authid definer
as
  procedure edit_parameter_group(
    p_pgr_id in pd_parameter_group.pgr_id%type,
    p_pgr_description in pd_parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true);
  
  
  procedure edit_parameter_group(
    p_row in pd_parameter_group%rowtype);
    
    
  procedure edit_parameter(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter.par_pgr_id%type,
	  p_par_description in pd_parameter.par_description%type default null,
    p_par_string_value in pd_parameter.par_string_value%type default null,
    p_par_xml_value in pd_parameter.par_xml_value%type default null,
    p_par_integer_value in pd_parameter.par_integer_value%type default null,
    p_par_float_value in pd_parameter.par_float_value%type default null,
    p_par_date_value in pd_parameter.par_date_value%type default null,
    p_par_timestamp_value in pd_parameter.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null,
    p_par_is_modifiable in boolean default null,
    p_par_validation_string in pd_parameter.par_validation_string%type default null,
    p_par_validation_message in pd_parameter.par_validation_message%type default null);
    
    
  procedure edit_parameter(
    p_row in pd_parameter%rowtype);
    
end param_admin;
/

create or replace package body param_admin
as
  function convert_boolean(
    p_value in boolean)
    return varchar2
  as
    l_boolean pd_parameter.par_boolean_value%type;
  begin
    l_boolean := case when p_value then 'Y'
                      when not p_value then 'N'
                      else null end;
    return l_boolean;
  end convert_boolean;
  
  
  procedure edit_parameter_group(
    p_pgr_id in pd_parameter_group.pgr_id%type,
    p_pgr_description in pd_parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true)
  as
    l_row pd_parameter_group%rowtype;
  begin
    l_row.pgr_id := p_pgr_id;
    l_row.pgr_description := p_pgr_description;
    l_row.pgr_is_modifiable := convert_boolean(p_pgr_is_modifiable);
    
    edit_parameter_group(l_row);
    
  end edit_parameter_group;
  
  
  procedure edit_parameter_group(
    p_row in pd_parameter_group%rowtype)
  as
  begin
    
    merge into pd_parameter_group t
    using (select p_row.pgr_id pgr_id,
                  p_row.pgr_description pgr_description,
                  p_row.pgr_is_modifiable pgr_is_modifiable
             from dual) s
       on (t.pgr_id = s.pgr_id)
     when matched then update set
          pgr_description = s.pgr_description,
          pgr_is_modifiable = s.pgr_is_modifiable
     when not matched then insert
          (pgr_id, pgr_description, pgr_is_modifiable)
          values
          (s.pgr_id, s.pgr_description, s.pgr_is_modifiable);
          
  end edit_parameter_group;
    
    
  procedure edit_parameter(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter.par_pgr_id%type,
	  p_par_description in pd_parameter.par_description%type default null,
    p_par_string_value in pd_parameter.par_string_value%type default null,
    p_par_xml_value in pd_parameter.par_xml_value%type default null,
    p_par_integer_value in pd_parameter.par_integer_value%type default null,
    p_par_float_value in pd_parameter.par_float_value%type default null,
    p_par_date_value in pd_parameter.par_date_value%type default null,
    p_par_timestamp_value in pd_parameter.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null,
    p_par_is_modifiable in boolean default null,
    p_par_validation_string in pd_parameter.par_validation_string%type default null,
    p_par_validation_message in pd_parameter.par_validation_message%type default null)
  as
    l_row pd_parameter%rowtype;
  begin
    -- copy parameters to record instance
    l_row.par_id := p_par_id;
    l_row.par_pgr_id := p_par_pgr_id;
    l_row.par_description := p_par_description;
    l_row.par_string_value := p_par_string_value;
    l_row.par_xml_value := p_par_xml_value;
    l_row.par_integer_value := p_par_integer_value;
    l_row.par_float_value := p_par_float_value;
    l_row.par_date_value := p_par_date_value;
    l_row.par_timestamp_value := p_par_timestamp_value;
    l_row.par_boolean_value := convert_boolean(p_par_boolean_value);
    l_row.par_is_modifiable := convert_boolean(p_par_is_modifiable);
    l_row.par_validation_string := p_par_validation_string;
    l_row.par_validation_message := p_par_validation_message;
    
    edit_parameter(l_row);
    
  end edit_parameter;
    
    
  procedure edit_parameter(
    p_row in pd_parameter%rowtype)
  as
  begin
    
    merge into pd_parameter t
    using (select p_row.par_id par_id,
                  p_row.par_pgr_id par_pgr_id,
                  p_row.par_description par_description,
                  p_row.par_string_value par_string_value,
                  p_row.par_xml_value par_xml_value,
                  p_row.par_integer_value par_integer_value,
                  p_row.par_float_value par_float_value,
                  p_row.par_date_value par_date_value,
                  p_row.par_timestamp_value par_timestamp_value,
                  p_row.par_boolean_value par_boolean_value,
                  p_row.par_is_modifiable par_is_modifiable,
                  p_row.par_validation_string par_validation_string,
                  p_row.par_validation_message par_validation_message
             from dual) s
       on (t.par_id = s.par_id
       and t.par_pgr_id = s.par_pgr_id)
     when matched then update set
          par_description = coalesce(s.par_description, t.par_description),
          par_string_value = s.par_string_value,
          par_xml_value = s.par_xml_value,
          par_integer_value = s.par_integer_value,
          par_float_value = s.par_float_value,
          par_date_value = s.par_date_value,
          par_timestamp_value = s.par_timestamp_value,
          par_boolean_value = s.par_boolean_value,
          par_is_modifiable = s.par_is_modifiable,
          par_validation_string = s.par_validation_string,
          par_validation_message = s.par_validation_message          
     when not matched then insert
          (par_id, par_pgr_id, par_description, par_string_value, 
           par_xml_value, par_integer_value, par_float_value, par_date_value, par_timestamp_value,
           par_boolean_value, par_is_modifiable, par_validation_string, par_validation_message)
          values
          (s.par_id, s.par_pgr_id, s.par_description, s.par_string_value, 
           s.par_xml_value, s.par_integer_value, s.par_float_value, s.par_date_value, s.par_timestamp_value,
           s.par_boolean_value, s.par_is_modifiable, s.par_validation_string, s.par_validation_message);

  end edit_parameter;
    
end param_admin;
/

prompt -  PARAM
create or replace package param
  authid definer
as
  function get_string(
   p_par_id in pd_parameter.par_id%type,
   p_par_pgr_id in pd_parameter_group.pgr_id%type)
   return varchar2;

  function get_clob(
   p_par_id in pd_parameter.par_id%type,
   p_par_pgr_id in pd_parameter_group.pgr_id%type)
   return pd_parameter.par_string_value%type;
   
  function get_xml(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_xml_value%type;

  function get_float(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_float_value%type;

  function get_integer(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_integer_value%type;

  function get_date(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_date_value%type;

  function get_timestamp(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_timestamp_value%type;

  function get_boolean(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return boolean;

end param;
/

create or replace package body param
as

  C_TRUE constant pd_parameter_group.pgr_is_modifiable%type := 'Y';
  C_FALSE constant pd_parameter_group.pgr_is_modifiable%type := 'N';
  C_MAX_CHAR_LENGTH constant number := 32767;
  
  g_parameter_rec pd_parameter%rowtype;

  function get_bool(
    p_boolean_value in boolean)
    return varchar2
  as
    l_boolean pd_parameter.par_boolean_value%type;
  begin
    case
      when p_boolean_value is null then
        l_boolean := null;
      when p_boolean_value then
        l_boolean := C_TRUE;
      else
        l_boolean := C_FALSE;
    end case;
    
    return l_boolean;
    
  end get_bool;


  procedure get_parameter(
    p_par_id in varchar2,
    p_par_pgr_id in varchar2)
  as
  begin
    select *
      into g_parameter_rec
      from pd_parameter
     where par_id = p_par_id
       and par_pgr_id = p_par_pgr_id;
  exception
    when no_data_found then
      dbms_output.put_line('Parameter ' || p_par_id || ' not found in ' || p_par_pgr_id);
  end get_parameter;
  
  /* GETTER */
  function get_string(
   p_par_id in pd_parameter.par_id%type,
   p_par_pgr_id in pd_parameter_group.pgr_id%type)
   return varchar2
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return dbms_lob.substr(g_parameter_rec.par_string_value, C_MAX_CHAR_LENGTH, 1);
  end get_string;
  
  function get_clob(
   p_par_id in pd_parameter.par_id%type,
   p_par_pgr_id in pd_parameter_group.pgr_id%type)
   return pd_parameter.par_string_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_string_value;
  end get_clob;

  function get_xml(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_xml_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_xml_value;
  end get_xml;

  function get_float(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_float_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_float_value;
  end get_float;

  function get_integer(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_integer_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_integer_value;
  end get_integer;

  function get_date(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_date_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_date_value;
  end get_date;

  function get_timestamp(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return pd_parameter.par_timestamp_value%type
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_timestamp_value;
  end get_timestamp;

  function get_boolean(
    p_par_id in pd_parameter.par_id%type,
    p_par_pgr_id in pd_parameter_group.pgr_id%type)
    return boolean
  as
  begin
    get_parameter(p_par_id, p_par_pgr_id);
    return g_parameter_rec.par_boolean_value = C_TRUE;
  end get_boolean;
end param;
/


prompt -  PIT_ADMIN
create or replace package pit_admin
authid definer
as 
   
  procedure merge_message_group(
    p_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pmg_description in pd_pit_message_group.pmg_description%type default null,
    p_pmg_error_prefix in pd_pit_message_group.pmg_error_prefix%type default null,
    p_pmg_error_postfix in pd_pit_message_group.pmg_error_postfix%type default null);
    
    
  procedure merge_message_group(
    p_row in out nocopy pd_pit_message_group%rowtype);
    
    
  procedure merge_message(
    p_pms_name in pd_pit_message.pms_name%type,
    p_pms_text in pd_pit_message.pms_text%type,
    p_pms_pse_id in pd_pit_message.pms_pse_id%type,
    p_pms_description in pd_pit_message.pms_description%type default null,
    p_pms_pmg_name in pd_pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pd_pit_message.pms_pml_name%type default null,
    p_error_number in pd_pit_message.pms_custom_error%type default null);
    
    
  procedure merge_message(
    p_row in out nocopy pd_pit_message%rowtype);    
  
  
  procedure merge_translatable_item(
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_pti_pml_name in pd_pit_translatable_item.pti_pml_name%type,
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_name in pd_pit_translatable_item.pti_name%type,
    p_pti_display_name in pd_pit_translatable_item.pti_display_name%type default null,
    p_pti_description in pd_pit_translatable_item.pti_description%type default null);
    
    
  procedure merge_translatable_item(
    p_row in out nocopy pd_pit_translatable_item%rowtype);
    
end pit_admin;
/

create or replace package body pit_admin
as 
   
  procedure merge_message_group(
    p_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pmg_description in pd_pit_message_group.pmg_description%type default null,
    p_pmg_error_prefix in pd_pit_message_group.pmg_error_prefix%type default null,
    p_pmg_error_postfix in pd_pit_message_group.pmg_error_postfix%type default null)
  as
    l_row pd_pit_message_group%rowtype;
  begin
    l_row.pmg_name := p_pmg_name;
    l_row.pmg_description := p_pmg_description;
    l_row.pmg_error_prefix := coalesce(p_pmg_error_prefix, null);
    l_row.pmg_error_postfix := coalesce(p_pmg_error_postfix, 'ERR');
    
    merge_message_group(l_row);    
  end merge_message_group;
  
    
  procedure merge_message_group(
    p_row in out nocopy pd_pit_message_group%rowtype)
  as
  begin
    -- Initialization
    merge into pd_pit_message_group t
    using (select p_row.pmg_name pmg_name,
                  p_row.pmg_description pmg_description,
                  p_row.pmg_error_prefix pmg_error_prefix,
                  p_row.pmg_error_postfix pmg_error_postfix
             from dual) s
       on (t.pmg_name = s.pmg_name)
     when matched then update set
          t.pmg_description = s.pmg_description,
          t.pmg_error_prefix = s.pmg_error_prefix,
          t.pmg_error_postfix = s.pmg_error_postfix
     when not matched then insert(pmg_name, pmg_description, pmg_error_prefix, pmg_error_postfix)
          values(s.pmg_name, s.pmg_description, s.pmg_error_prefix, s.pmg_error_postfix);          
  end merge_message_group;
    
    
  procedure merge_message(
    p_pms_name in pd_pit_message.pms_name%type,
    p_pms_text in pd_pit_message.pms_text%type,
    p_pms_pse_id in pd_pit_message.pms_pse_id%type,
    p_pms_description in pd_pit_message.pms_description%type default null,
    p_pms_pmg_name in pd_pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pd_pit_message.pms_pml_name%type default null,
    p_error_number in pd_pit_message.pms_custom_error%type default null)
  as
    l_row pd_pit_message%rowtype;
  begin
    l_row.pms_name := p_pms_name;
    l_row.pms_text := p_pms_text;
    l_row.pms_pse_id := p_pms_pse_id;
    l_row.pms_description := p_pms_description;
    l_row.pms_pmg_name := p_pms_pmg_name;
    l_row.pms_pml_name := p_pms_pml_name;
    l_row.pms_custom_error := p_error_number;
    
    merge_message(l_row);
  end merge_message;
    
    
  procedure merge_message(
    p_row in out nocopy pd_pit_message%rowtype)
  as
  begin
    merge into pd_pit_message t
    using (select p_row.pms_name pms_name,
                  upper(coalesce(p_row.pms_pml_name, 'AMERICAN')) pms_pml_name,
                  upper(p_row.pms_pmg_name) pms_pmg_name,
                  p_row.pms_text pms_text,
                  p_row.pms_description pms_description,
                  p_row.pms_pse_id pms_pse_id,
                  p_row.pms_custom_error pms_custom_error
             from dual) s
       on (t.pms_name = s.pms_name and t.pms_pml_name = s.pms_pml_name)
     when matched then update set
          t.pms_pmg_name = s.pms_pmg_name,
          t.pms_text = s.pms_text,
          t.pms_description = s.pms_description,
          t.pms_pse_id = s.pms_pse_id,
          t.pms_custom_error = s.pms_custom_error
     when not matched then insert
            (pms_name, pms_pmg_name, pms_pml_name, pms_text, pms_description, pms_pse_id, pms_custom_error)
          values
            (s.pms_name, s.pms_pmg_name, s.pms_pml_name, s.pms_text, s.pms_description, s.pms_pse_id, s.pms_custom_error);
    commit;
  end merge_message; 
  
  
  procedure merge_translatable_item(
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_pti_pml_name in pd_pit_translatable_item.pti_pml_name%type,
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_name in pd_pit_translatable_item.pti_name%type,
    p_pti_display_name in pd_pit_translatable_item.pti_display_name%type default null,
    p_pti_description in pd_pit_translatable_item.pti_description%type default null)
  as
    l_row pd_pit_translatable_item%rowtype;
  begin
    l_row.pti_id := p_pti_id;
    l_row.pti_pml_name := p_pti_pml_name;
    l_row.pti_pmg_name := p_pti_pmg_name;
    l_row.pti_name := p_pti_name;
    l_row.pti_display_name := p_pti_display_name;
    l_row.pti_description := p_pti_description;
    
    merge_translatable_item(l_row);
  end merge_translatable_item;
    
    
  procedure merge_translatable_item(
    p_row in out nocopy pd_pit_translatable_item%rowtype)
  as
  begin
    merge into pd_pit_translatable_item t
    using (select p_row.pti_id pti_id,
                  coalesce(p_row.pti_pml_name, 'AMERICAN') pti_pml_name,
                  p_row.pti_pmg_name pti_pmg_name,
                  p_row.pti_name pti_name,
                  p_row.pti_display_name pti_display_name,
                  p_row.pti_description pti_description
             from dual) s
       on (t.pti_id = s.pti_id
       and t.pti_pml_name = s.pti_pml_name)
      when matched then update set
           t.pti_pmg_name = s.pti_pmg_name,
           t.pti_name = s.pti_name,
           t.pti_display_name = s.pti_display_name,
           t.pti_description = s.pti_description
      when not matched then insert(pti_id, pti_pmg_name, pti_pml_name, pti_name, pti_display_name, pti_description)
           values(s.pti_id, s.pti_pmg_name, s.pti_pml_name, s.pti_name, s.pti_display_name, s.pti_description);
  end merge_translatable_item;
    
end pit_admin;
/


prompt - MSG
create or replace package msg as
  /** Generated package to provide message constants and exceptions*/

  -- CONSTANTS:
  ADC_ACTION_DOES_NOT_EXIST constant varchar2(128 byte) := 'ADC_ACTION_DOES_NOT_EXIST';
  ADC_ACTION_EXECUTED constant varchar2(128 byte) := 'ADC_ACTION_EXECUTED';
  ADC_ACTION_REJECTED constant varchar2(128 byte) := 'ADC_ACTION_REJECTED';
  ADC_APEX_ACTION_ORIGIN constant varchar2(128 byte) := 'ADC_APEX_ACTION_ORIGIN';
  ADC_APEX_ACTION_UNKNOWN constant varchar2(128 byte) := 'ADC_APEX_ACTION_UNKNOWN';
  ADC_APP_DOES_NOT_EXIST constant varchar2(128 byte) := 'ADC_APP_DOES_NOT_EXIST';
  ADCA_UI_ACTION_REQUESTED constant varchar2(128 byte) := 'ADCA_UI_ACTION_REQUESTED';
  ADCA_UI_CHANGES_SAVED constant varchar2(128 byte) := 'ADCA_UI_CHANGES_SAVED';
  ADCA_UI_CHK_DEPRECATED constant varchar2(128 byte) := 'ADCA_UI_CHK_DEPRECATED';
  ADCA_UI_CHK_MISSING constant varchar2(128 byte) := 'ADCA_UI_CHK_MISSING';
  ADCA_UI_CHK_REGISTER_OBSERVER constant varchar2(128 byte) := 'ADCA_UI_CHK_REGISTER_OBSERVER';
  ADCA_UI_CONFIRM_DELETE constant varchar2(128 byte) := 'ADCA_UI_CONFIRM_DELETE';
  ADCA_UI_DATA_DELETED constant varchar2(128 byte) := 'ADCA_UI_DATA_DELETED';
  ADCA_UI_UNKNOWN_ACTION constant varchar2(128 byte) := 'ADCA_UI_UNKNOWN_ACTION';
  ADCA_UI_UNSAVED_DATA constant varchar2(128 byte) := 'ADCA_UI_UNSAVED_DATA';
  ADC_CLOB_JS_SCRIPT constant varchar2(128 byte) := 'ADC_CLOB_JS_SCRIPT';
  ADC_CRG_MUS_BE_UNIQUE constant varchar2(128 byte) := 'ADC_CRG_MUS_BE_UNIQUE';
  ADC_CRG_MUST_BE_UNIQUE constant varchar2(128 byte) := 'ADC_CRG_MUST_BE_UNIQUE';
  ADC_DATE_ITEM_SET constant varchar2(128 byte) := 'ADC_DATE_ITEM_SET';
  ADC_DEBUG_RULE_STMT constant varchar2(128 byte) := 'ADC_DEBUG_RULE_STMT';
  ADC_DYNAMIC_JAVASCRIPT constant varchar2(128 byte) := 'ADC_DYNAMIC_JAVASCRIPT';
  ADC_ERROR_HANDLING constant varchar2(128 byte) := 'ADC_ERROR_HANDLING';
  ADC_EXPECTED_FORMAT constant varchar2(128 byte) := 'ADC_EXPECTED_FORMAT';
  ADC_FIRING_ITEM_PUSHED constant varchar2(128 byte) := 'ADC_FIRING_ITEM_PUSHED';
  ADC_GENERIC_ERROR constant varchar2(128 byte) := 'ADC_GENERIC_ERROR';
  ADC_HARMONIZE_CPI_STEP_1 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_1';
  ADC_HARMONIZE_CPI_STEP_2 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_2';
  ADC_HARMONIZE_CPI_STEP_3 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_3';
  ADC_HARMONIZE_CPI_STEP_4 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_4';
  ADC_HARMONIZE_CPI_STEP_5 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_5';
  ADC_HARMONIZE_CPI_STEP_6 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_6';
  ADC_HARMONIZE_CPI_STEP_7 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_7';
  ADC_HARMONIZE_CPI_STEP_8 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_8';
  ADC_HARMONIZE_CPI_STEP_9 constant varchar2(128 byte) := 'ADC_HARMONIZE_CPI_STEP_9';
  ADC_INFINITE_LOOP constant varchar2(128 byte) := 'ADC_INFINITE_LOOP';
  ADC_INITIALZE_CRG_FAILED constant varchar2(128 byte) := 'ADC_INITIALZE_CRG_FAILED';
  ADC_INITIALZE_CRU_FAILED constant varchar2(128 byte) := 'ADC_INITIALZE_CRU_FAILED';
  ADC_INIT_ORIGIN constant varchar2(128 byte) := 'ADC_INIT_ORIGIN';
  ADC_INTERNAL_ERROR constant varchar2(128 byte) := 'ADC_INTERNAL_ERROR';
  ADC_INVALID_DATE constant varchar2(128 byte) := 'ADC_INVALID_DATE';
  ADC_INVALID_DEBUG_LEVEL constant varchar2(128 byte) := 'ADC_INVALID_DEBUG_LEVEL';
  ADC_INVALID_JQUERY constant varchar2(128 byte) := 'ADC_INVALID_JQUERY';
  ADC_INVALID_NUMBER constant varchar2(128 byte) := 'ADC_INVALID_NUMBER';
  ADC_INVALID_PAGE_ITEM constant varchar2(128 byte) := 'ADC_INVALID_PAGE_ITEM';
  ADC_INVALID_SEQUENCE constant varchar2(128 byte) := 'ADC_INVALID_SEQUENCE';
  ADC_INVALID_SQL constant varchar2(128 byte) := 'ADC_INVALID_SQL';
  ADC_ITEM_DOES_NOT_EXIST constant varchar2(128 byte) := 'ADC_ITEM_DOES_NOT_EXIST';
  ADC_ITEM_IS_MANDATORY constant varchar2(128 byte) := 'ADC_ITEM_IS_MANDATORY';
  ADC_ITEM_IS_MANDATORY_DEFAULT constant varchar2(128 byte) := 'ADC_ITEM_IS_MANDATORY_DEFAULT';
  ADC_MERGE_RULE constant varchar2(128 byte) := 'ADC_MERGE_RULE';
  ADC_MERGE_RULE_ACTION constant varchar2(128 byte) := 'ADC_MERGE_RULE_ACTION';
  ADC_MERGE_RULE_GROUP constant varchar2(128 byte) := 'ADC_MERGE_RULE_GROUP';
  ADC_METHOD_PARSE_EXCEPTION constant varchar2(128 byte) := 'ADC_METHOD_PARSE_EXCEPTION';
  ADC_NO_DATA_FOR_ITEM constant varchar2(128 byte) := 'ADC_NO_DATA_FOR_ITEM';
  ADC_NO_EXPORT_DATA_FOUND constant varchar2(128 byte) := 'ADC_NO_EXPORT_DATA_FOUND';
  ADC_NO_JAVASCRIPT constant varchar2(128 byte) := 'ADC_NO_JAVASCRIPT';
  ADC_NO_JAVASCRIPT_ACTION constant varchar2(128 byte) := 'ADC_NO_JAVASCRIPT_ACTION';
  ADC_NO_RULE_FOUND constant varchar2(128 byte) := 'ADC_NO_RULE_FOUND';
  ADC_NO_RULE_GROUP_FOUND constant varchar2(128 byte) := 'ADC_NO_RULE_GROUP_FOUND';
  ADC_NUMBER_ITEM_SET constant varchar2(128 byte) := 'ADC_NUMBER_ITEM_SET';
  ADC_ONE_ITEM_IS_MANDATORY constant varchar2(128 byte) := 'ADC_ONE_ITEM_IS_MANDATORY';
  ADC_OUTPUT_CLIPPED constant varchar2(128 byte) := 'ADC_OUTPUT_CLIPPED';
  ADC_OUTPUT_REDUCED constant varchar2(128 byte) := 'ADC_OUTPUT_REDUCED';
  ADC_PAGE_DOES_NOT_EXIST constant varchar2(128 byte) := 'ADC_PAGE_DOES_NOT_EXIST';
  ADC_PAGE_HAS_ERRORS constant varchar2(128 byte) := 'ADC_PAGE_HAS_ERRORS';
  ADC_PARAM_LOV_INCORRECT constant varchar2(128 byte) := 'ADC_PARAM_LOV_INCORRECT';
  ADC_PARAM_LOV_MISSING constant varchar2(128 byte) := 'ADC_PARAM_LOV_MISSING';
  ADC_PARAM_MISSING constant varchar2(128 byte) := 'ADC_PARAM_MISSING';
  ADC_PARAM_VALIDATION_FAILED constant varchar2(128 byte) := 'ADC_PARAM_VALIDATION_FAILED';
  ADC_PARSE_JSON constant varchar2(128 byte) := 'ADC_PARSE_JSON';
  ADC_PLSQL_CODE constant varchar2(128 byte) := 'ADC_PLSQL_CODE';
  ADC_PLSQL_ERROR constant varchar2(128 byte) := 'ADC_PLSQL_ERROR';
  ADC_PROCESSING_RULE constant varchar2(128 byte) := 'ADC_PROCESSING_RULE';
  ADC_RECURSION_LIMIT constant varchar2(128 byte) := 'ADC_RECURSION_LIMIT';
  ADC_RECURSION_LOOP constant varchar2(128 byte) := 'ADC_RECURSION_LOOP';
  ADC_RULE_ACTION_EXISTS constant varchar2(128 byte) := 'ADC_RULE_ACTION_EXISTS';
  ADC_RULE_DOES_NOT_EXIST constant varchar2(128 byte) := 'ADC_RULE_DOES_NOT_EXIST';
  ADC_RULE_ORIGIN constant varchar2(128 byte) := 'ADC_RULE_ORIGIN';
  ADC_RULE_VALIDATION constant varchar2(128 byte) := 'ADC_RULE_VALIDATION';
  ADC_RULE_VIEW_CREATED constant varchar2(128 byte) := 'ADC_RULE_VIEW_CREATED';
  ADC_RULE_VIEW_DELETED constant varchar2(128 byte) := 'ADC_RULE_VIEW_DELETED';
  ADC_SESSION_STATE_SET constant varchar2(128 byte) := 'ADC_SESSION_STATE_SET';
  ADC_STANDARD_JS constant varchar2(128 byte) := 'ADC_STANDARD_JS';
  ADC_STOP_NO_JAVASCRIPT constant varchar2(128 byte) := 'ADC_STOP_NO_JAVASCRIPT';
  ADC_STOP_NO_PLSQL constant varchar2(128 byte) := 'ADC_STOP_NO_PLSQL';
  ADC_TARGET_EQUALS_SOURCE constant varchar2(128 byte) := 'ADC_TARGET_EQUALS_SOURCE';
  ADC_UNEXPECTED_CONV_TYPE constant varchar2(128 byte) := 'ADC_UNEXPECTED_CONV_TYPE';
  ADC_UNHANDLED_EXCEPTION constant varchar2(128 byte) := 'ADC_UNHANDLED_EXCEPTION';
  ADC_UNKNOWN_CPT constant varchar2(128 byte) := 'ADC_UNKNOWN_CPT';
  ADC_UNKNOWN_EXPORT_MODE constant varchar2(128 byte) := 'ADC_UNKNOWN_EXPORT_MODE';
  ADC_VIEW_CREATED constant varchar2(128 byte) := 'ADC_VIEW_CREATED';
  ADC_VIEW_CREATION constant varchar2(128 byte) := 'ADC_VIEW_CREATION';
  ADC_WHERE_CLAUSE constant varchar2(128 byte) := 'ADC_WHERE_CLAUSE';
  CHILD_RECORD_FOUND constant varchar2(128 byte) := 'CHILD_RECORD_FOUND';
  CONVERSION_IMPOSSIBLE constant varchar2(128 byte) := 'CONVERSION_IMPOSSIBLE';
  INVALID_ANCHOR_NAMES constant varchar2(128 byte) := 'INVALID_ANCHOR_NAMES';
  INVALID_DATE constant varchar2(128 byte) := 'INVALID_DATE';
  INVALID_DATE_FORMAT constant varchar2(128 byte) := 'INVALID_DATE_FORMAT';
  INVALID_DATE_LENGTH constant varchar2(128 byte) := 'INVALID_DATE_LENGTH';
  INVALID_DAY constant varchar2(128 byte) := 'INVALID_DAY';
  INVALID_DAY_FOR_MONTH constant varchar2(128 byte) := 'INVALID_DAY_FOR_MONTH';
  INVALID_MONTH constant varchar2(128 byte) := 'INVALID_MONTH';
  INVALID_NUMBER_FORMAT constant varchar2(128 byte) := 'INVALID_NUMBER_FORMAT';
  INVALID_PARAMETER_COMBI constant varchar2(128 byte) := 'INVALID_PARAMETER_COMBI';
  INVALID_YEAR constant varchar2(128 byte) := 'INVALID_YEAR';
  LOG_CONVERSION constant varchar2(128 byte) := 'LOG_CONVERSION';
  MISSING_ANCHORS constant varchar2(128 byte) := 'MISSING_ANCHORS';
  NO_TEMPLATE constant varchar2(128 byte) := 'NO_TEMPLATE';
  PARAM_ADMIN_MODE_REQUIRED constant varchar2(128 byte) := 'PARAM_ADMIN_MODE_REQUIRED';
  PARAM_IS_NULL constant varchar2(128 byte) := 'PARAM_IS_NULL';
  PARAM_NOT_EXTENDABLE constant varchar2(128 byte) := 'PARAM_NOT_EXTENDABLE';
  PARAM_NOT_FOUND constant varchar2(128 byte) := 'PARAM_NOT_FOUND';
  PARAM_NOT_MODIFIABLE constant varchar2(128 byte) := 'PARAM_NOT_MODIFIABLE';
  PIT_ASSERT_DATATYPE constant varchar2(128 byte) := 'PIT_ASSERT_DATATYPE';
  PIT_ASSERT_EXISTS constant varchar2(128 byte) := 'PIT_ASSERT_EXISTS';
  PIT_ASSERTION_FAILED constant varchar2(128 byte) := 'PIT_ASSERTION_FAILED';
  PIT_ASSERT_IS_NOT_NULL constant varchar2(128 byte) := 'PIT_ASSERT_IS_NOT_NULL';
  PIT_ASSERT_IS_NULL constant varchar2(128 byte) := 'PIT_ASSERT_IS_NULL';
  PIT_ASSERT_NOT_EXISTS constant varchar2(128 byte) := 'PIT_ASSERT_NOT_EXISTS';
  PIT_ASSERT_TRUE constant varchar2(128 byte) := 'PIT_ASSERT_TRUE';
  PITA_UI_INVALID_INTEGER constant varchar2(128 byte) := 'PITA_UI_INVALID_INTEGER';
  PITA_UI_INVALID_REQUEST constant varchar2(128 byte) := 'PITA_UI_INVALID_REQUEST';
  PITA_UI_PARAMETER_REQUIRED constant varchar2(128 byte) := 'PITA_UI_PARAMETER_REQUIRED';
  PITA_UI_PAR_PGR_EXPORTED constant varchar2(128 byte) := 'PITA_UI_PAR_PGR_EXPORTED';
  PITA_UI_XLIFF_IMPORTED constant varchar2(128 byte) := 'PITA_UI_XLIFF_IMPORTED';
  PIT_BULK_ERROR constant varchar2(128 byte) := 'PIT_BULK_ERROR';
  PIT_BULK_FATAL constant varchar2(128 byte) := 'PIT_BULK_FATAL';
  PIT_CODE_ENTER constant varchar2(128 byte) := 'PIT_CODE_ENTER';
  PIT_CODE_ENTER_W_PARAM constant varchar2(128 byte) := 'PIT_CODE_ENTER_W_PARAM';
  PIT_CODE_LEAVE constant varchar2(128 byte) := 'PIT_CODE_LEAVE';
  PIT_CONTEXT_MISSING constant varchar2(128 byte) := 'PIT_CONTEXT_MISSING';
  PIT_CTX_CHANGED constant varchar2(128 byte) := 'PIT_CTX_CHANGED';
  PIT_CTX_CREATED constant varchar2(128 byte) := 'PIT_CTX_CREATED';
  PIT_CTX_CREATION_ERROR constant varchar2(128 byte) := 'PIT_CTX_CREATION_ERROR';
  PIT_CTX_DEFAULT_CREATION_ERROR constant varchar2(128 byte) := 'PIT_CTX_DEFAULT_CREATION_ERROR';
  PIT_CTX_INVALID_CONTEXT constant varchar2(128 byte) := 'PIT_CTX_INVALID_CONTEXT';
  PIT_CTX_MISSING constant varchar2(128 byte) := 'PIT_CTX_MISSING';
  PIT_CTX_NO_CONTEXT constant varchar2(128 byte) := 'PIT_CTX_NO_CONTEXT';
  PIT_DUPLICATE_MESSAGE constant varchar2(128 byte) := 'PIT_DUPLICATE_MESSAGE';
  PIT_FAIL_MESSAGE_CREATION constant varchar2(128 byte) := 'PIT_FAIL_MESSAGE_CREATION';
  PIT_FAIL_MESSAGE_PURGE constant varchar2(128 byte) := 'PIT_FAIL_MESSAGE_PURGE';
  PIT_FAIL_MODULE_INIT constant varchar2(128 byte) := 'PIT_FAIL_MODULE_INIT';
  PIT_FAIL_READ_MODULE_LIST constant varchar2(128 byte) := 'PIT_FAIL_READ_MODULE_LIST';
  PIT_IMPOSSIBLE_CONVERSION constant varchar2(128 byte) := 'PIT_IMPOSSIBLE_CONVERSION';
  PIT_INITIALIZED constant varchar2(128 byte) := 'PIT_INITIALIZED';
  PIT_INVALID_SQL_NAME constant varchar2(128 byte) := 'PIT_INVALID_SQL_NAME';
  PIT_LONG_OP_WO_TRACE constant varchar2(128 byte) := 'PIT_LONG_OP_WO_TRACE';
  PIT_MODULE_INSTANTIATED constant varchar2(128 byte) := 'PIT_MODULE_INSTANTIATED';
  PIT_MODULE_LIST_LOADED constant varchar2(128 byte) := 'PIT_MODULE_LIST_LOADED';
  PIT_MODULE_PARAM_MISSING constant varchar2(128 byte) := 'PIT_MODULE_PARAM_MISSING';
  PIT_MODULE_TERMINATED constant varchar2(128 byte) := 'PIT_MODULE_TERMINATED';
  PIT_MODULE_UNAVAILABLE constant varchar2(128 byte) := 'PIT_MODULE_UNAVAILABLE';
  PIT_MSG_NOT_EXISTING constant varchar2(128 byte) := 'PIT_MSG_NOT_EXISTING';
  PIT_NAME_TOO_LONG constant varchar2(128 byte) := 'PIT_NAME_TOO_LONG';
  PIT_NO_CONTEXT_SETTINGS constant varchar2(128 byte) := 'PIT_NO_CONTEXT_SETTINGS';
  PIT_PARAM_ADMIN_MODE_REQUIRED constant varchar2(128 byte) := 'PIT_PARAM_ADMIN_MODE_REQUIRED';
  PIT_PARAM_IS_NULL constant varchar2(128 byte) := 'PIT_PARAM_IS_NULL';
  PIT_PARAM_MISSING constant varchar2(128 byte) := 'PIT_PARAM_MISSING';
  PIT_PARAM_NOT_EXTENDABLE constant varchar2(128 byte) := 'PIT_PARAM_NOT_EXTENDABLE';
  PIT_PARAM_NOT_FOUND constant varchar2(128 byte) := 'PIT_PARAM_NOT_FOUND';
  PIT_PARAM_NOT_MODIFIABLE constant varchar2(128 byte) := 'PIT_PARAM_NOT_MODIFIABLE';
  PIT_PARAM_OUT_OF_RANGE constant varchar2(128 byte) := 'PIT_PARAM_OUT_OF_RANGE';
  PIT_PASS_MESSAGE constant varchar2(128 byte) := 'PIT_PASS_MESSAGE';
  PIT_PMG_ERROR_MARKER_INVALID constant varchar2(128 byte) := 'PIT_PMG_ERROR_MARKER_INVALID';
  PIT_PMG_ERROR_MARKER_MISSING constant varchar2(128 byte) := 'PIT_PMG_ERROR_MARKER_MISSING';
  PIT_PMS_PREDEFINED_ERROR constant varchar2(128 byte) := 'PIT_PMS_PREDEFINED_ERROR';
  PIT_PMS_TOO_LONG constant varchar2(128 byte) := 'PIT_PMS_TOO_LONG';
  PIT_READ_MODULE_LIST constant varchar2(128 byte) := 'PIT_READ_MODULE_LIST';
  PIT_SQL_ERROR constant varchar2(128 byte) := 'PIT_SQL_ERROR';
  PIT_TWEET constant varchar2(128 byte) := 'PIT_TWEET';
  PIT_UNKNOWN_NAMED_CONTEXT constant varchar2(128 byte) := 'PIT_UNKNOWN_NAMED_CONTEXT';
  PIT_WEBSOCKET_MESSAGE constant varchar2(128 byte) := 'PIT_WEBSOCKET_MESSAGE';
  SQL_ACCESS_DENIED constant varchar2(128 byte) := 'SQL_ACCESS_DENIED';
  UTL_APEX_FETCH_ROW_REQUIRED constant varchar2(128 byte) := 'UTL_APEX_FETCH_ROW_REQUIRED';
  UTL_APEX_INVALID_ITEM_PREFIX constant varchar2(128 byte) := 'UTL_APEX_INVALID_ITEM_PREFIX';
  UTL_APEX_INVALID_REQUEST constant varchar2(128 byte) := 'UTL_APEX_INVALID_REQUEST';
  UTL_APEX_ITEM_IS_REQUIRED constant varchar2(128 byte) := 'UTL_APEX_ITEM_IS_REQUIRED';
  UTL_APEX_ITEM_VALUE_REQUIRED constant varchar2(128 byte) := 'UTL_APEX_ITEM_VALUE_REQUIRED';
  UTL_APEX_MISSING_ITEM constant varchar2(128 byte) := 'UTL_APEX_MISSING_ITEM';
  UTL_APEX_NAME_CONTAINS_UMLAUT constant varchar2(128 byte) := 'UTL_APEX_NAME_CONTAINS_UMLAUT';
  UTL_APEX_NAME_INVALID constant varchar2(128 byte) := 'UTL_APEX_NAME_INVALID';
  UTL_APEX_NAME_TOO_LONG constant varchar2(128 byte) := 'UTL_APEX_NAME_TOO_LONG';
  UTL_APEX_OBJECT_DOES_NOT_EXIST constant varchar2(128 byte) := 'UTL_APEX_OBJECT_DOES_NOT_EXIST';
  UTL_APEX_PAGE_ALIAS_REQUIRED constant varchar2(128 byte) := 'UTL_APEX_PAGE_ALIAS_REQUIRED';
  UTL_APEX_PARAMETER_REQUIRED constant varchar2(128 byte) := 'UTL_APEX_PARAMETER_REQUIRED';
  WEBSOCKET_MESSAGE constant varchar2(128 byte) := 'WEBSOCKET_MESSAGE';

  -- EXCEPTIONS:
  ADC_ACTION_DOES_NOT_EXIST_ERR exception;
  ADC_APEX_ACTION_ORIGIN_ERR exception;
  ADC_APP_DOES_NOT_EXIST_ERR exception;
  ADCA_UI_UNKNOWN_ACTION_ERR exception;
  ADC_CRG_MUS_BE_UNIQUE_ERR exception;
  ADC_CRG_MUST_BE_UNIQUE_ERR exception;
  ADC_GENERIC_ERROR_ERR exception;
  ADC_INFINITE_LOOP_ERR exception;
  ADC_INITIALZE_CRG_FAILED_ERR exception;
  ADC_INITIALZE_CRU_FAILED_ERR exception;
  ADC_INIT_ORIGIN_ERR exception;
  ADC_INTERNAL_ERROR_ERR exception;
  ADC_INVALID_DATE_ERR exception;
  ADC_INVALID_DEBUG_LEVEL_ERR exception;
  ADC_INVALID_NUMBER_ERR exception;
  ADC_INVALID_SQL_ERR exception;
  ADC_ITEM_DOES_NOT_EXIST_ERR exception;
  ADC_ITEM_IS_MANDATORY_ERR exception;
  ADC_MERGE_RULE_ERR exception;
  ADC_MERGE_RULE_ACTION_ERR exception;
  ADC_MERGE_RULE_GROUP_ERR exception;
  ADC_NO_DATA_FOR_ITEM_ERR exception;
  ADC_NO_EXPORT_DATA_FOUND_ERR exception;
  ADC_ONE_ITEM_IS_MANDATORY_ERR exception;
  ADC_PAGE_DOES_NOT_EXIST_ERR exception;
  ADC_PARAM_LOV_INCORRECT_ERR exception;
  ADC_PARAM_LOV_MISSING_ERR exception;
  ADC_PARAM_MISSING_ERR exception;
  ADC_PARAM_VALIDATION_FAILED_ERR exception;
  ADC_PARSE_JSON_ERR exception;
  ADC_PLSQL_ERROR_ERR exception;
  ADC_RECURSION_LIMIT_ERR exception;
  ADC_RECURSION_LOOP_ERR exception;
  ADC_RULE_ACTION_EXISTS_ERR exception;
  ADC_RULE_DOES_NOT_EXIST_ERR exception;
  ADC_RULE_ORIGIN_ERR exception;
  ADC_RULE_VALIDATION_ERR exception;
  ADC_TARGET_EQUALS_SOURCE_ERR exception;
  ADC_UNEXPECTED_CONV_TYPE_ERR exception;
  ADC_UNHANDLED_EXCEPTION_ERR exception;
  ADC_UNKNOWN_CPT_ERR exception;
  ADC_UNKNOWN_EXPORT_MODE_ERR exception;
  ADC_VIEW_CREATION_ERR exception;
  ADC_WHERE_CLAUSE_ERR exception;
  CHILD_RECORD_FOUND_ERR exception;
  CONVERSION_IMPOSSIBLE_ERR exception;
  INVALID_ANCHOR_NAMES_ERR exception;
  INVALID_DATE_ERR exception;
  INVALID_DATE_FORMAT_ERR exception;
  INVALID_DATE_LENGTH_ERR exception;
  INVALID_DAY_ERR exception;
  INVALID_DAY_FOR_MONTH_ERR exception;
  INVALID_MONTH_ERR exception;
  INVALID_NUMBER_FORMAT_ERR exception;
  INVALID_PARAMETER_COMBI_ERR exception;
  INVALID_YEAR_ERR exception;
  MISSING_ANCHORS_ERR exception;
  NO_TEMPLATE_ERR exception;
  PARAM_ADMIN_MODE_REQUIRED_ERR exception;
  PARAM_NOT_EXTENDABLE_ERR exception;
  PARAM_NOT_FOUND_ERR exception;
  PARAM_NOT_MODIFIABLE_ERR exception;
  PIT_ASSERT_DATATYPE_ERR exception;
  PIT_ASSERT_EXISTS_ERR exception;
  PIT_ASSERTION_FAILED_ERR exception;
  PIT_ASSERT_IS_NOT_NULL_ERR exception;
  PIT_ASSERT_IS_NULL_ERR exception;
  PIT_ASSERT_NOT_EXISTS_ERR exception;
  PIT_ASSERT_TRUE_ERR exception;
  PITA_UI_INVALID_REQUEST_ERR exception;
  PITA_UI_PARAMETER_REQUIRED_ERR exception;
  PIT_BULK_ERROR_ERR exception;
  PIT_BULK_FATAL_ERR exception;
  PIT_CONTEXT_MISSING_ERR exception;
  PIT_CTX_CREATION_ERROR_ERR exception;
  PIT_CTX_DEFAULT_CREATION_ERROR_ERR exception;
  PIT_CTX_INVALID_CONTEXT_ERR exception;
  PIT_CTX_NO_CONTEXT_ERR exception;
  PIT_DUPLICATE_MESSAGE_ERR exception;
  PIT_FAIL_MESSAGE_CREATION_ERR exception;
  PIT_FAIL_MESSAGE_PURGE_ERR exception;
  PIT_FAIL_READ_MODULE_LIST_ERR exception;
  PIT_IMPOSSIBLE_CONVERSION_ERR exception;
  PIT_LONG_OP_WO_TRACE_ERR exception;
  PIT_MODULE_PARAM_MISSING_ERR exception;
  PIT_MODULE_TERMINATED_ERR exception;
  PIT_MSG_NOT_EXISTING_ERR exception;
  PIT_NAME_TOO_LONG_ERR exception;
  PIT_NO_CONTEXT_SETTINGS_ERR exception;
  PIT_PARAM_ADMIN_MODE_REQUIRED_ERR exception;
  PIT_PARAM_MISSING_ERR exception;
  PIT_PARAM_NOT_EXTENDABLE_ERR exception;
  PIT_PARAM_NOT_FOUND_ERR exception;
  PIT_PARAM_NOT_MODIFIABLE_ERR exception;
  PIT_PARAM_OUT_OF_RANGE_ERR exception;
  PIT_PMG_ERROR_MARKER_INVALID_ERR exception;
  PIT_PMG_ERROR_MARKER_MISSING_ERR exception;
  PIT_PMS_PREDEFINED_ERROR_ERR exception;
  PIT_PMS_TOO_LONG_ERR exception;
  PIT_SQL_ERROR_ERR exception;
  PIT_UNKNOWN_NAMED_CONTEXT_ERR exception;
  SQL_ACCESS_DENIED_ERR exception;
  UTL_APEX_FETCH_ROW_REQUIRED_ERR exception;
  UTL_APEX_INVALID_ITEM_PREFIX_ERR exception;
  UTL_APEX_INVALID_REQUEST_ERR exception;
  UTL_APEX_ITEM_IS_REQUIRED_ERR exception;
  UTL_APEX_ITEM_VALUE_REQUIRED_ERR exception;
  UTL_APEX_MISSING_ITEM_ERR exception;
  UTL_APEX_NAME_CONTAINS_UMLAUT_ERR exception;
  UTL_APEX_NAME_INVALID_ERR exception;
  UTL_APEX_NAME_TOO_LONG_ERR exception;
  UTL_APEX_OBJECT_DOES_NOT_EXIST_ERR exception;
  UTL_APEX_PAGE_ALIAS_REQUIRED_ERR exception;
  UTL_APEX_PARAMETER_REQUIRED_ERR exception;

  -- EXCEPTION INIT:
  pragma exception_init(ADC_ACTION_DOES_NOT_EXIST_ERR, -20999);
  pragma exception_init(ADC_APEX_ACTION_ORIGIN_ERR, -20998);
  pragma exception_init(ADC_APP_DOES_NOT_EXIST_ERR, -20997);
  pragma exception_init(ADCA_UI_UNKNOWN_ACTION_ERR, -20996);
  pragma exception_init(ADC_CRG_MUS_BE_UNIQUE_ERR, -20995);
  pragma exception_init(ADC_CRG_MUST_BE_UNIQUE_ERR, -20994);
  pragma exception_init(ADC_GENERIC_ERROR_ERR, -20993);
  pragma exception_init(ADC_INFINITE_LOOP_ERR, -20992);
  pragma exception_init(ADC_INITIALZE_CRG_FAILED_ERR, -20991);
  pragma exception_init(ADC_INITIALZE_CRU_FAILED_ERR, -20990);
  pragma exception_init(ADC_INIT_ORIGIN_ERR, -20989);
  pragma exception_init(ADC_INTERNAL_ERROR_ERR, -20988);
  pragma exception_init(ADC_INVALID_DATE_ERR, -20987);
  pragma exception_init(ADC_INVALID_DEBUG_LEVEL_ERR, -20986);
  pragma exception_init(ADC_INVALID_NUMBER_ERR, -20985);
  pragma exception_init(ADC_INVALID_SQL_ERR, -20984);
  pragma exception_init(ADC_ITEM_DOES_NOT_EXIST_ERR, -20983);
  pragma exception_init(ADC_ITEM_IS_MANDATORY_ERR, -20982);
  pragma exception_init(ADC_MERGE_RULE_ERR, -20981);
  pragma exception_init(ADC_MERGE_RULE_ACTION_ERR, -20980);
  pragma exception_init(ADC_MERGE_RULE_GROUP_ERR, -20979);
  pragma exception_init(ADC_NO_DATA_FOR_ITEM_ERR, -20978);
  pragma exception_init(ADC_NO_EXPORT_DATA_FOUND_ERR, -20977);
  pragma exception_init(ADC_ONE_ITEM_IS_MANDATORY_ERR, -20976);
  pragma exception_init(ADC_PAGE_DOES_NOT_EXIST_ERR, -20975);
  pragma exception_init(ADC_PARAM_LOV_INCORRECT_ERR, -20974);
  pragma exception_init(ADC_PARAM_LOV_MISSING_ERR, -20973);
  pragma exception_init(ADC_PARAM_MISSING_ERR, -20972);
  pragma exception_init(ADC_PARAM_VALIDATION_FAILED_ERR, -20971);
  pragma exception_init(ADC_PARSE_JSON_ERR, -20970);
  pragma exception_init(ADC_PLSQL_ERROR_ERR, -20969);
  pragma exception_init(ADC_RECURSION_LIMIT_ERR, -20968);
  pragma exception_init(ADC_RECURSION_LOOP_ERR, -20967);
  pragma exception_init(ADC_RULE_ACTION_EXISTS_ERR, -20966);
  pragma exception_init(ADC_RULE_DOES_NOT_EXIST_ERR, -20965);
  pragma exception_init(ADC_RULE_ORIGIN_ERR, -20964);
  pragma exception_init(ADC_RULE_VALIDATION_ERR, -20963);
  pragma exception_init(ADC_TARGET_EQUALS_SOURCE_ERR, -20962);
  pragma exception_init(ADC_UNEXPECTED_CONV_TYPE_ERR, -20961);
  pragma exception_init(ADC_UNHANDLED_EXCEPTION_ERR, -20960);
  pragma exception_init(ADC_UNKNOWN_CPT_ERR, -20959);
  pragma exception_init(ADC_UNKNOWN_EXPORT_MODE_ERR, -20958);
  pragma exception_init(ADC_VIEW_CREATION_ERR, -20957);
  pragma exception_init(ADC_WHERE_CLAUSE_ERR, -20956);
  pragma exception_init(CHILD_RECORD_FOUND_ERR, -2292);
  pragma exception_init(CONVERSION_IMPOSSIBLE_ERR, -20947);
  pragma exception_init(INVALID_ANCHOR_NAMES_ERR, -20941);
  pragma exception_init(INVALID_DATE_ERR, -1858);
  pragma exception_init(INVALID_DATE_FORMAT_ERR, -1821);
  pragma exception_init(INVALID_DATE_LENGTH_ERR, -1840);
  pragma exception_init(INVALID_DAY_ERR, -1847);
  pragma exception_init(INVALID_DAY_FOR_MONTH_ERR, -1839);
  pragma exception_init(INVALID_MONTH_ERR, -1843);
  pragma exception_init(INVALID_NUMBER_FORMAT_ERR, -1481);
  pragma exception_init(INVALID_PARAMETER_COMBI_ERR, -20940);
  pragma exception_init(INVALID_YEAR_ERR, -1841);
  pragma exception_init(MISSING_ANCHORS_ERR, -20938);
  pragma exception_init(NO_TEMPLATE_ERR, -20937);
  pragma exception_init(PARAM_ADMIN_MODE_REQUIRED_ERR, -20936);
  pragma exception_init(PARAM_NOT_EXTENDABLE_ERR, -20935);
  pragma exception_init(PARAM_NOT_FOUND_ERR, -20934);
  pragma exception_init(PARAM_NOT_MODIFIABLE_ERR, -20933);
  pragma exception_init(PIT_ASSERT_DATATYPE_ERR, -20932);
  pragma exception_init(PIT_ASSERT_EXISTS_ERR, -20931);
  pragma exception_init(PIT_ASSERTION_FAILED_ERR, -20930);
  pragma exception_init(PIT_ASSERT_IS_NOT_NULL_ERR, -20929);
  pragma exception_init(PIT_ASSERT_IS_NULL_ERR, -20928);
  pragma exception_init(PIT_ASSERT_NOT_EXISTS_ERR, -20927);
  pragma exception_init(PIT_ASSERT_TRUE_ERR, -20926);
  pragma exception_init(PITA_UI_INVALID_REQUEST_ERR, -20925);
  pragma exception_init(PITA_UI_PARAMETER_REQUIRED_ERR, -20924);
  pragma exception_init(PIT_BULK_ERROR_ERR, -20923);
  pragma exception_init(PIT_BULK_FATAL_ERR, -20922);
  pragma exception_init(PIT_CONTEXT_MISSING_ERR, -20921);
  pragma exception_init(PIT_CTX_CREATION_ERROR_ERR, -20920);
  pragma exception_init(PIT_CTX_DEFAULT_CREATION_ERROR_ERR, -20919);
  pragma exception_init(PIT_CTX_INVALID_CONTEXT_ERR, -20918);
  pragma exception_init(PIT_CTX_NO_CONTEXT_ERR, -20917);
  pragma exception_init(PIT_DUPLICATE_MESSAGE_ERR, -20916);
  pragma exception_init(PIT_FAIL_MESSAGE_CREATION_ERR, -20915);
  pragma exception_init(PIT_FAIL_MESSAGE_PURGE_ERR, -20914);
  pragma exception_init(PIT_FAIL_READ_MODULE_LIST_ERR, -20913);
  pragma exception_init(PIT_IMPOSSIBLE_CONVERSION_ERR, -20912);
  pragma exception_init(PIT_LONG_OP_WO_TRACE_ERR, -20911);
  pragma exception_init(PIT_MODULE_PARAM_MISSING_ERR, -20910);
  pragma exception_init(PIT_MODULE_TERMINATED_ERR, -20909);
  pragma exception_init(PIT_MSG_NOT_EXISTING_ERR, -20908);
  pragma exception_init(PIT_NAME_TOO_LONG_ERR, -20907);
  pragma exception_init(PIT_NO_CONTEXT_SETTINGS_ERR, -20906);
  pragma exception_init(PIT_PARAM_ADMIN_MODE_REQUIRED_ERR, -20905);
  pragma exception_init(PIT_PARAM_MISSING_ERR, -20904);
  pragma exception_init(PIT_PARAM_NOT_EXTENDABLE_ERR, -20903);
  pragma exception_init(PIT_PARAM_NOT_FOUND_ERR, -20902);
  pragma exception_init(PIT_PARAM_NOT_MODIFIABLE_ERR, -20901);
  pragma exception_init(PIT_PARAM_OUT_OF_RANGE_ERR, -20900);
  pragma exception_init(PIT_PMG_ERROR_MARKER_INVALID_ERR, -20899);
  pragma exception_init(PIT_PMG_ERROR_MARKER_MISSING_ERR, -20898);
  pragma exception_init(PIT_PMS_PREDEFINED_ERROR_ERR, -20897);
  pragma exception_init(PIT_PMS_TOO_LONG_ERR, -20896);
  pragma exception_init(PIT_SQL_ERROR_ERR, -20895);
  pragma exception_init(PIT_UNKNOWN_NAMED_CONTEXT_ERR, -20894);
  pragma exception_init(SQL_ACCESS_DENIED_ERR, -29471);
  pragma exception_init(UTL_APEX_FETCH_ROW_REQUIRED_ERR, -20892);
  pragma exception_init(UTL_APEX_INVALID_ITEM_PREFIX_ERR, -20891);
  pragma exception_init(UTL_APEX_INVALID_REQUEST_ERR, -20890);
  pragma exception_init(UTL_APEX_ITEM_IS_REQUIRED_ERR, -20889);
  pragma exception_init(UTL_APEX_ITEM_VALUE_REQUIRED_ERR, -20888);
  pragma exception_init(UTL_APEX_MISSING_ITEM_ERR, -20887);
  pragma exception_init(UTL_APEX_NAME_CONTAINS_UMLAUT_ERR, -20886);
  pragma exception_init(UTL_APEX_NAME_INVALID_ERR, -20885);
  pragma exception_init(UTL_APEX_NAME_TOO_LONG_ERR, -20884);
  pragma exception_init(UTL_APEX_OBJECT_DOES_NOT_EXIST_ERR, -20883);
  pragma exception_init(UTL_APEX_PAGE_ALIAS_REQUIRED_ERR, -20882);
  pragma exception_init(UTL_APEX_PARAMETER_REQUIRED_ERR, -20881);
end msg;
/

prompt -  PIT
create or replace package pit
  authid definer 
as
  function level_off return binary_integer deterministic;
  function level_fatal return binary_integer deterministic;
  function level_error return binary_integer deterministic;
  function level_warn return binary_integer deterministic;
  function level_info return binary_integer deterministic;
  function level_debug return binary_integer deterministic;
  function level_all return binary_integer deterministic;
  
  function trace_off return binary_integer deterministic;
  function trace_mandatory return binary_integer deterministic;
  function trace_optional return binary_integer deterministic;
  function trace_detailed return binary_integer deterministic;
  function trace_all return binary_integer deterministic;

  function type_integer return varchar2 deterministic;
  function type_number return varchar2 deterministic;
  function type_date return varchar2 deterministic;
  function type_timestamp return varchar2 deterministic;
  function type_xml return varchar2 deterministic;    

  function get_log_level
    return binary_integer;
    

  function check_log_level_greater_equal(
    p_log_level in binary_integer)
    return boolean;
    

  function get_trace_level
    return binary_integer;
    

  function check_trace_level_greater_equal(
    p_trace_level in binary_integer)
    return boolean;
    

  procedure tweet(
    p_message in varchar2);
    

  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);
    

  procedure debug(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);
    

  procedure info(
    p_message_name in varchar2,
    p_msg_args msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);
    

  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);
    

  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);
    

  procedure fatal(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);
    

  procedure log_state(
    p_params msg_params,
    p_severity in binary_integer default null);
    

  procedure handle_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  

  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    

  procedure enter_optional(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    

  procedure enter_detailed(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    

  procedure enter(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null);
  

  procedure leave_mandatory(
    p_params in msg_params default null);
  

  procedure leave_optional(
    p_params in msg_params default null);
  

  procedure leave_detailed(
    p_params in msg_params default null);
  

  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null);
  

  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
    return clob;
    

  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
    return message_type;
    

  function get_active_message
    return message_type;
    

  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.PIT_ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
  

  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    

  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    

  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
  
  
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    
    
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    
    
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    
    
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    
    
  procedure assert_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    

  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,   
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    
    
  procedure assert_not_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);
    

   procedure assert_datatype(
     p_value in varchar2,
     p_type in varchar2,
     p_format_mask in varchar2 default null,
     p_message_name in varchar2 default msg.PIT_ASSERT_DATATYPE,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_affected_ids in msg_params default null,
     p_error_code in varchar2 default null,
     p_accept_null in boolean default true,
     p_severity in binary_integer default null);
  

  function get_default_language
    return varchar2;
    
    
  function get_trans_item_name(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return varchar2;  
    
  function get_trans_item_display_name(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return varchar2;  

  function get_trans_item_description(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return CLOB;
  
  procedure start_message_collection;
  
  procedure stop_message_collection;
  
  function get_message_collection
    return pit_message_table;
end pit;
/

prompt -  APEX output module
create or replace package pit_apex_pkg
  authid definer
as

  function get_apex_triggered_context
    return varchar2;
  
  
  procedure tweet(
    p_message in message_type);
  
  
  procedure log(
    p_message in message_type);
  
  
  procedure print(
    p_message in message_type);
  

  procedure enter(
    p_call_stack in pit_call_stack_type);


  procedure leave(
    p_call_stack in pit_call_stack_type);
    
end pit_apex_pkg;
/

create or replace package body pit_apex_pkg
as
  C_PARAM_GROUP constant varchar2(20 char) := 'PIT';
  C_APEX_CONTEXT constant varchar2(128 byte) := 'CONTEXT_APEX';
  C_DEFAULT_CONTEXT constant varchar2(128 byte) := 'CONTEXT_DEFAULT';
  C_FIRE_THRESHOLD constant varchar2(128 byte) := 'PIT_APEX_FIRE_THRESHOLD';
  C_TRG_FIRE_THRESHOLD constant varchar2(128 byte) := 'PIT_APEX_TRG_FIRE_THRESHOLD';
  C_TRG_TRACE_THRESHOLD constant varchar2(128 byte) := 'PIT_APEX_TRG_TRACE_THRESHOLD';
  C_TRG_TRACE_TIMING constant varchar2(128 byte) := 'PIT_APEX_TRG_TRACE_TIMING';
  C_TRG_LOG_MODULES constant varchar2(128 byte) := 'PIT_APEX_TRG_LOG_MODULES';
  C_YES constant varchar2(3 byte) := 'YES';
  C_CHUNK_SIZE constant integer := 8192;
  
  type pit_context_type is record(
    context_name varchar2(128 byte),
    log_level integer,
    trace_level integer,
    trace_timing char(1 byte),
    log_modules char_table,
    trace_settings varchar2(4000 byte),
    allow_toggle char(1 byte),
    broadcast_context_switch char(1 byte));

  g_apex_triggered_context pit_context_type;
  g_fire_threshold number;

  procedure initialize
  as
  begin
    g_fire_threshold := 70;
    g_apex_triggered_context.log_level := 70;
    g_apex_triggered_context.trace_level := 50;
    g_apex_triggered_context.trace_timing := 'Y';
    g_apex_triggered_context.log_modules := char_table('PIT_APEX');
  end initialize;


  function valid_environment
    return boolean
  as
  begin
    return apex_application.get_session_id is not null;
  end valid_environment;


  function get_msg_param(
    p_call_stack in pit_call_stack_type,
    p_position in binary_integer)
    return varchar2
  as
    l_position binary_integer;
  begin
    l_position := round((p_position)/2);
    if p_call_stack.params.exists(l_position) then
      if mod(p_position, 2) = 1 then
        return p_call_stack.params(l_position).p_param;
      else
        return p_call_stack.params(l_position).p_value;
      end if;
    else
      return null;
    end if;
  end get_msg_param;


  procedure debug_message(
    p_message in message_type)
  as
    l_severity binary_integer range 1..7;
    l_message varchar2(32767);
  begin
    l_severity := round(p_message.severity/10);
    if p_message.stack is not null then
      l_message := dbms_lob.substr(p_message.message_text, 30000, 1)
                || chr(10)
                || substr(p_message.stack, 1, 200)
                || chr(10)
                || substr(p_message.backtrace, 1, 2550);
    else
      l_message := dbms_lob.substr(p_message.message_text, 32760, 1);
    end if;

    apex_debug.log_long_message(
      p_message => l_message,
      p_level => l_severity);
  end debug_message;


  procedure log_error(
    p_message in message_type)
  as
    C_ITEM_LABEL varchar2(128 byte) := '#ITEMLABEL#';
    l_label varchar2(100);
    l_message varchar2(1000);
  begin
    if instr(p_message.message_text, C_ITEM_LABEL) > 0 and p_message.affected_id is not null and regexp_like(p_message.affected_id, '^P[0-9]+_') then
      -- Get item label to include it into the message
      begin
           with params as(
                select to_number(v('APP_ID')) application_id,
                       to_number(v('APP_PAGE_ID')) page_id,
                       p_message.affected_id item_name
                  from dual)
         select /*+ no_merge (p) */ label
           into l_label
           from apex_application_page_items
        natural join params p;
        l_message := replace(p_message.message_text, C_ITEM_LABEL, l_label);
      exception
        when NO_DATA_FOUND then
          l_message := replace(p_message.message_text, C_ITEM_LABEL, p_message.affected_id);
      end;

      apex_error.add_error(
        p_message => l_message,
        p_additional_info => p_message.message_description,
        p_page_item_name => p_message.affected_id,
        p_display_location => apex_error.c_inline_with_field_and_notif);
    else
      apex_error.add_error(
        p_message => p_message.message_text,
        p_additional_info => p_message.message_description,
        p_display_location => apex_error.c_inline_with_field_and_notif);
    end if;
  end log_error;


  procedure print_clob(
    p_text in clob)
  as
    l_offset binary_integer := 1;
    l_amount binary_integer := C_CHUNK_SIZE;
    l_chunk varchar2(32767);
    l_length binary_integer := dbms_lob.getlength(p_text);
  begin
    while l_length > 0 and p_text is not null loop
      dbms_lob.read(
        lob_loc => p_text,
        amount => l_amount,
        offset => l_offset,
        buffer => l_chunk);
      l_offset := l_offset + l_amount;
      l_length := l_length - l_amount;
      sys.htp.p(l_chunk);
    end loop;
  end print_clob;


  function get_apex_triggered_context
    return varchar2
  as
    l_context varchar2(128 byte);
  begin
    if valid_environment then
      if apex_application.g_debug then
        l_context := C_APEX_CONTEXT;
      else
        l_context := C_DEFAULT_CONTEXT;
      end if;
    end if;
    return l_context;
  end get_apex_triggered_context;


  procedure tweet(
    p_message in message_type)
  as
  begin
    if valid_environment then
      apex_debug.info(p_message.message_text);
    end if;
  end tweet;


  procedure log(
    p_message in message_type)
  as
  begin
    if valid_environment then
      -- Decision tree for the output of the individual severity levels
      case p_message.severity
      when pit.level_all then
        apex_debug.trace(p_message.message_text);
      when pit.level_debug then
        apex_debug.info(p_message.message_text);
      when pit.level_info then
        apex_debug.info(p_message.message_text);
      when pit.level_warn then
        apex_debug.warn(p_message.message_text);
      when pit.level_error then
        log_error(p_message);
      when pit.level_fatal then
        apex_debug.warn(p_message.message_text);
        log_error(p_message);
        apex_application.stop_apex_engine;
      else
        -- Level off
        null;
      end case;
    end if;
  end log;


  procedure print(
    p_message in message_type)
  as
  begin
    print_clob(p_message.message_text);
  end print;


  procedure enter(
    p_call_stack in pit_call_stack_type)
  is
    l_message message_type;
    l_message_language varchar2(64);
    l_param_list varchar2(32767);
    l_next_param varchar2(32767);
  begin
    if valid_environment then
      apex_debug.enter(
        p_routine_name => p_call_stack.module_name || '.' || p_call_stack.method_name,
        p_name01 => get_msg_param(p_call_stack, 1),
        p_value01 => get_msg_param(p_call_stack, 2),
        p_name02 => get_msg_param(p_call_stack, 3),
        p_value02 => get_msg_param(p_call_stack, 4),
        p_name03 => get_msg_param(p_call_stack, 5),
        p_value03 => get_msg_param(p_call_stack, 6),
        p_name04 => get_msg_param(p_call_stack, 7),
        p_value04 => get_msg_param(p_call_stack, 8),
        p_name05 => get_msg_param(p_call_stack, 9),
        p_value05 => get_msg_param(p_call_stack, 10),
        p_name06 => get_msg_param(p_call_stack, 11),
        p_value06 => get_msg_param(p_call_stack, 12),
        p_name07 => get_msg_param(p_call_stack, 13),
        p_value07 => get_msg_param(p_call_stack, 14),
        p_name08 => get_msg_param(p_call_stack, 15),
        p_value08 => get_msg_param(p_call_stack, 16),
        p_name09 => get_msg_param(p_call_stack, 17),
        p_value09 => get_msg_param(p_call_stack, 18),
        p_name10 => get_msg_param(p_call_stack, 19),
        p_value10 => get_msg_param(p_call_stack, 20));
      debug_message(l_message);
    end if;
  end enter;


  procedure leave(
    p_call_stack in pit_call_stack_type)
  as
    l_message message_type;
  begin
    if valid_environment then
      apex_debug.enter(
        p_routine_name => '< ' || p_call_stack.module_name || '.' || p_call_stack.method_name,
        p_name01 => get_msg_param(p_call_stack, 1),
        p_value01 => get_msg_param(p_call_stack, 2),
        p_name02 => get_msg_param(p_call_stack, 3),
        p_value02 => get_msg_param(p_call_stack, 4),
        p_name03 => get_msg_param(p_call_stack, 5),
        p_value03 => get_msg_param(p_call_stack, 6),
        p_name04 => get_msg_param(p_call_stack, 7),
        p_value04 => get_msg_param(p_call_stack, 8),
        p_name05 => get_msg_param(p_call_stack, 9),
        p_value05 => get_msg_param(p_call_stack, 10),
        p_name06 => get_msg_param(p_call_stack, 11),
        p_value06 => get_msg_param(p_call_stack, 12),
        p_name07 => get_msg_param(p_call_stack, 13),
        p_value07 => get_msg_param(p_call_stack, 14),
        p_name08 => get_msg_param(p_call_stack, 15),
        p_value08 => get_msg_param(p_call_stack, 16),
        p_name09 => get_msg_param(p_call_stack, 17),
        p_value09 => get_msg_param(p_call_stack, 18),
        p_name10 => get_msg_param(p_call_stack, 19),
        p_value10 => get_msg_param(p_call_stack, 20));
      debug_message(l_message);
    end if;
  end leave;

begin
   initialize;
end pit_apex_pkg;
/


prompt -  PIT
create or replace package body pit
as
  g_active_message message_type;
  g_user_name varchar2(128 byte);
  g_schema_name varchar2(128 byte);
  g_client_id varchar2(128 byte);
  
  g_collect_mode boolean := false;
  g_message_stack pit_message_table := pit_message_table();
  g_collect_least_severity binary_integer := 70;
  g_stop_bulk_on_fatal boolean := false;
  
  -- HELPER
  procedure get_session_details(
    p_user_name out varchar2,
    p_session_id out varchar2,
    p_required_context out nocopy varchar2)
  as
  begin
    p_user_name := apex_application.g_user;
    p_session_id := apex_application.g_instance; 
    -- If APEX is set to logging, adjust context to predefined log settings defined in PIT_APEX params
    p_required_context := pit_apex_pkg.get_apex_triggered_context;
    dbms_output.put_line('PIT_APEX_ADAPTER called');
  end get_session_details;
    
    
  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args,
    p_affected_id in varchar2,
    p_error_code in varchar2)
   return message_type
  as
    -- use a local message here to prevent to overwrite g_active_message with messages that are never raised
    l_message message_type;
  begin
    get_session_details(g_user_name, g_schema_name, g_client_id);
    l_message := message_type(
                   p_message_name => p_message_name,
                   p_message_language => 'AMERICAN',
                   p_affected_id => p_affected_id,
                   p_error_code => p_error_code,
                   p_session_id => g_client_id,
                   p_schema_name => g_schema_name,
                   p_user_name => g_user_name,
                   p_msg_args => p_msg_args);
    return l_message;
  exception
    when NO_DATA_FOUND then
      --handle_error(20, C_MSG_NOT_EXISTING, msg_args(p_message_name));
      return null;
  end get_message;
  
  
  function get_message_severity(
    p_message_name in varchar2)
    return binary_integer
  as
    l_pse_id pd_pit_message.pms_pse_id%type;
  begin
    select pms_pse_id
      into l_pse_id
      from pd_pit_message
     where pms_id = p_message_name;
    return l_pse_id;
  exception
    when NO_DATA_FOUND then
      return null;
  end get_message_severity;
  
  
  procedure push_message(
    p_message in out nocopy message_type)
  as
  begin
    g_collect_least_severity := least(g_collect_least_severity, p_message.severity);
    p_message.error_code := coalesce(p_message.error_code, p_message.message_name);
    g_message_stack.extend;
    g_message_stack(g_message_stack.last) := p_message;
  end push_message;
  
  
  procedure raise_error(
    p_severity in pls_integer,
    p_message_name varchar2,
    p_msg_args in msg_args,
    p_affected_id in varchar2,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2)
  as
  begin
    -- P_MESSAGE_NAME could be NULL, we use G_ACTIVE_MESSAGE then
    if p_message_name is not null then
      g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
      g_active_message.severity := p_severity;
      g_active_message.error_number := coalesce(g_active_message.error_number, -20000);
    end if;
    
    if g_collect_mode and not (p_severity = 20 and g_stop_bulk_on_fatal) then
      push_message(g_active_message);      
    else
      raise_application_error(
        g_active_message.error_number,
        dbms_lob.substr(g_active_message.message_text, 2048, 1));    
    end if;
  end raise_error;
  
    
  procedure log_event(
    p_severity in pls_integer,
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
  as
  begin
    if check_log_level_greater_equal(p_severity) then
      case when p_message_name is not null then
        -- instantiate message
        g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
        -- Persist severity of calling environment with message
        g_active_message.severity := least(p_severity, g_active_message.severity);
      when g_active_message is not null then
        -- message has been raised as an error before, use g_active_message
        -- call stack is filled only after an error has been raised, so get it again
        null;
      when p_severity <= 20 then
        -- fallback, is used if a SQL exception was raised outside of PIT
        g_active_message := get_message('PIT_SQL_ERROR', p_msg_args, p_affected_id, p_affected_ids, p_error_code);
      else 
        -- if used with SQL_EXCEPTION, code may re raise the exception explicitly
        null;
      end case;

      if g_collect_mode then
        push_message(g_active_message);
      else
        pit_apex_pkg.log(g_active_message);
      end if;
    end if;
  end log_event; 
  
    
  function check_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2,
    p_accept_null in boolean)
    return boolean
  as
    C_INTEGER_REGEXP constant varchar2(128 byte) := '^[0-9]+$';
    l_result boolean := true;
    l_format_mask varchar2(128 byte);
    l_number number;
    l_date date;
    l_timestamp timestamp with time zone;
    l_xml xmltype;
    l_perform_check boolean;
  begin
    l_format_mask := p_format_mask;
    
    l_perform_check := p_value is not null or not p_accept_null;
    
    if l_perform_check then
      case p_type
      when type_integer then
        l_result := regexp_like(p_value, C_INTEGER_REGEXP);
      when type_number then
        begin
          l_format_mask := coalesce(l_format_mask, '999999999999999999D999999999');
          l_number := to_number(p_value, l_format_mask);
        exception
          when others then
            l_result := false;
        end;
      when type_date then
        begin
          l_format_mask := coalesce(l_format_mask, sys_context('USERENV', 'NLS_DATE_FORMAT'));
          l_date := to_date(p_value, p_format_mask);
        exception
          when others then
            l_result := false;
        end;
      when type_timestamp then
        begin
          if l_format_mask is null then
            select value
              into l_format_mask
              from v$nls_parameters
             where parameter = 'NLS_TIMESTAMP_FORMAT';
          end if;
          l_timestamp := to_timestamp(p_value, l_format_mask);
        exception
          when others then
            l_result := false;
        end;
      when type_xml then
        begin
          l_xml := xmltype(p_value);
        exception
          when others then
            l_result := false;
        end;
      else
        null;
      end case;
    end if;
    
    return l_result;
  end check_datatype;
  
  -- INTERFACE
  function level_off return binary_integer
  as
  begin
    return 10;
  end;
  
  function level_fatal return binary_integer
  as
  begin
    return 20;
  end;
  
  function level_error return binary_integer
  as
  begin
    return 30;
  end;
  
  function level_warn return binary_integer
  as
  begin
    return 40;
  end;
  
  function level_info return binary_integer
  as
  begin
    return 50;
  end;
  
  function level_debug return binary_integer
  as
  begin
    return 60;
  end;
  
  function level_all return binary_integer
  as
  begin
    return 70;
  end;
  
  
  function trace_off return binary_integer
  as
  begin
    return 10;
  end;
  
  function trace_mandatory return binary_integer
  as
  begin
    return 20;
  end;
  
  function trace_optional return binary_integer
  as
  begin
    return 30;
  end;
  
  function trace_detailed return binary_integer
  as
  begin
    return 40;
  end;
  
  function trace_all return binary_integer
  as
  begin
    return 50;
  end;
    
  function type_integer
    return varchar2
  as
  begin
    return 'INTEGER';
  end type_integer;  
  
  function type_number
    return varchar2
  as
  begin
    return 'NUMBER';
  end type_number;  
    
  function type_date
    return varchar2
  as
  begin
    return 'DATE';
  end type_date;  
    
  function type_timestamp
    return varchar2
  as
  begin
    return 'TIMESTAMP';
  end type_timestamp;  
  
  function type_xml
    return varchar2
  as
  begin
    return 'XML';
  end type_xml;  

  function get_log_level
    return binary_integer
  as
  begin
    return 30;
  end;


  function check_log_level_greater_equal(
    p_log_level in binary_integer)
    return boolean
  as
  begin
    return p_log_level < 30;
  end;
      

  function get_trace_level
    return binary_integer
  as
  begin
    return 10;
  end;
    

  function check_trace_level_greater_equal(
    p_trace_level in binary_integer)
    return boolean
  as
  begin
    return p_trace_level < 10;
  end;
  

  procedure tweet(
    p_message in varchar2)
  as
  begin
    dbms_output.put_line(p_message);
  end;
    

  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null)
  as
  begin
    null;
  end;
  
    

  procedure debug(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null)
  as
  begin
    null;
  end;
    

  procedure info(
    p_message_name in varchar2,
    p_msg_args msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null)
  as
  begin
    null;
  end;
    

  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null)
  as
  begin
    null;
  end;
    

  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
  as
  begin
    null;
  end;
    

  procedure fatal(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
  as
  begin
    null;
  end;
    

  procedure log_state(
    p_params msg_params,
    p_severity in binary_integer default null)
  as
  begin
    null;
  end;
    

  procedure handle_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    null;
  end;
    

  procedure enter_optional(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    null;
  end;
    

  procedure enter_detailed(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    null;
  end;
    

  procedure enter(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null)
  as
  begin
    null;
  end;
  

  procedure leave_mandatory(
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  procedure leave_optional(
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  procedure leave_detailed(
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null)
  as
  begin
    null;
  end;
  

  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
    return clob
  as
  begin
    return null;
  end;
    

  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
    return message_type
  as
  begin
    return null;
  end;
    

  function get_active_message
    return message_type
  as
  begin
    return null;
  end;
    
  
  procedure raise_assertion_finding(
    p_message_name in varchar2,
    p_msg_args msg_args,
    p_affected_id in varchar2,
    p_affected_ids in msg_params,
    p_error_code in varchar2,
    p_severity in binary_integer)
  as
    l_severity binary_integer;
  begin
    -- Calculate resulting severity
    l_severity := coalesce(
                    p_severity, 
                    least(
                      pit.level_error, 
                      get_message_severity(p_message_name)));
    
    -- Raise
    if l_severity >= pit.level_warn then
      log_event(l_severity, p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    else
      raise_error(l_severity, p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    end if;
  end raise_assertion_finding;
  
  
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.PIT_ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if not p_condition or p_condition is null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert;
  
  
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is not null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is not null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is not null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_is_null;
  
  
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
  begin
    if p_condition is null then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_not_null;
  
 
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
    l_stmt varchar2(32767) := 'select count(*) from (#STMT#) where rownum = 1';
    l_count number;
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_count;
    if l_count = 0 then
       raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_exists;
  
  
  procedure assert_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
    l_id number;
    l_count number;
  begin
    l_id := dbms_sql.to_cursor_number(p_cursor);
    l_count := dbms_sql.fetch_rows(l_id);
    dbms_sql.close_cursor(l_id);
 
    if l_count = 0 then
       raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  exception
    when others then
      if dbms_sql.is_open(l_id) then
        dbms_sql.close_cursor(l_id);
      end if;
      raise;
  end assert_exists;
  
  
  procedure assert_not_exists(
    p_stmt  in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
    l_stmt varchar2(32767) := 'select count(*) from (#STMT#) where rownum = 1';
    l_count number;
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_count;
    if l_count = 1 then
       raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  end assert_not_exists;
  
  
  procedure assert_not_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null)
  as
    l_id number;
    l_count number;
  begin
    l_id := dbms_sql.to_cursor_number(p_cursor);
    l_count := dbms_sql.fetch_rows(l_id);
    dbms_sql.close_cursor(l_id);
    
    if l_count > 0 then
      raise_assertion_finding(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, p_severity);
    end if;
  exception
    when others then
      if dbms_sql.is_open(l_id) then
        dbms_sql.close_cursor(l_id);
      end if;
      raise;
  end assert_not_exists;
  
  
  procedure assert_datatype(
    p_value in varchar2,
    p_type  in varchar2,
    p_format_mask in varchar2 default null,
    p_message_name in varchar2 default msg.PIT_ASSERT_DATATYPE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_accept_null in boolean default true,
    p_severity in binary_integer default null)
  as
    l_msg_args msg_args;
  begin
    if p_message_name = msg.PIT_ASSERT_DATATYPE then 
      l_msg_args := msg_args(p_value, p_type);
    else 
      l_msg_args := p_msg_args;
    end if;
    
    assert(
      p_condition => check_datatype(p_value, p_type, p_format_mask, p_accept_null),
      p_message_name => p_message_name,
      p_msg_args => l_msg_args,
      p_affected_id => p_affected_id,
      p_affected_ids => p_affected_ids,
      p_error_code => p_error_code,
      p_severity => p_severity);
  end assert_datatype;
  

  function get_default_language
    return varchar2
  as
  begin
    return 'AMERICAN';
  end;
    
    
  function get_trans_item_name(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return varchar2
  as
  begin
    return null;
  end; 
    
  function get_trans_item_display_name(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return varchar2
  as
  begin
    return null;
  end; 

  function get_trans_item_description(
    p_pti_pmg_name in pd_pit_message_group.pmg_name%type,
    p_pti_id in pd_pit_translatable_item.pti_id%type,
    p_pti_pml_name in varchar2 := 'AMERICAN')
    return CLOB
  as
  begin
    return null;
  end;
  
  procedure start_message_collection
  as
  begin
    null;
  end;
  
  procedure stop_message_collection
  as
  begin
    null;
  end;
  
  function get_message_collection
    return pit_message_table
  as
  begin
    return null;
  end;
end pit;
/


prompt - UTL_TEXT_ADMIN
create or replace package utl_text_admin
  authid definer
as


  /** 
    Package: UTL_TEXT_ADMIN
      Package to maintain UTL_TEXT_TEMPLATES

    Author::
      Juergen Sieben, ConDeS GmbH
   */ 
  
  type utl_text_template_table is table of utl_text_templates%rowtype;
  type utl_text_template_type_table is table of utl_text_templates.uttm_type%type;
    
  /**
    Procedure: merge_template
      Method for merging a template into <UTL_TEXT_TEMPLATES>
      
    Parameters:
      p_uttm_type - Type of the template
      p_uttm_name - Name of the template
      p_uttm_mode - Execution mode of the template
      p_uttm_text - Template with replacement anchors
      p_uttm_log_text - Optional template with replacement anchors for logging tasks
      p_uttm_log_severity - Optional severity of the log message to control the log amount
   */
  procedure merge_template(
    p_uttm_type in varchar2,
    p_uttm_name in varchar2,
    p_uttm_mode in varchar2,
    p_uttm_text in varchar2,
    p_uttm_log_text in varchar2 default null,
    p_uttm_log_severity in number default null);
    
  
  /**
    Function: get_templates
      Method to retrieve all text templates for the given parameter selection
    
    Parameters:
      p_type - Type of the templates to return
      p_name - Optional Name of the templates
      
    Returns:
      Row instance of table UTL_TEXT_TEMPLATES
   */
  function get_templates(
    p_type in utl_text_templates.uttm_type%type,
    p_name in utl_text_templates.uttm_name%type default null,
    p_mode in utl_text_templates.uttm_mode%type default null)
    return utl_text_template_table
    pipelined;
    
  
  /**
    Function: get_template_types
      Method to retrieve all text templates for the given parameter selection
    
    Parameters:
      p_type - Type of the templates to return
      p_name - Optional Name of the templates
      
    Returns:
      Row instance of table UTL_TEXT_TEMPLATES
   */
  function get_template_types
    return utl_text_template_type_table
    pipelined;
    
end utl_text_admin;
/

create or replace package body utl_text_admin
as

  C_CR_CHAR constant varchar2(10) := '\CR\';
  g_newline_char varchar2(2 byte);
  

  procedure initialize
  as
  begin
     -- Derive delimiter from OS
    case when regexp_like(dbms_utility.port_string, '(WIN|Windows)') then
      g_newline_char := chr(13) || chr(10);
    when regexp_like(dbms_utility.port_string, '(AIX)') then
      g_newline_char := chr(21);
    else
      g_newline_char := chr(10);
    end case;
  end initialize;
  
  
  procedure merge_template(
    p_uttm_type in varchar2,
    p_uttm_name in varchar2,
    p_uttm_mode in varchar2,
    p_uttm_text in varchar2,
    p_uttm_log_text in varchar2 default null,
    p_uttm_log_severity in number default null)
  as
  begin
    merge into utl_text_templates t
    using (select p_uttm_name uttm_name,
                  p_uttm_type uttm_type,
                  p_uttm_mode uttm_mode,
                  replace(p_uttm_text, C_CR_CHAR, g_newline_char) uttm_text,
                  p_uttm_log_text uttm_log_text,
                  p_uttm_log_severity uttm_log_severity
             from dual) s
       on (t.uttm_name = s.uttm_name
       and t.uttm_type = s.uttm_type
       and t.uttm_mode = s.uttm_mode)
     when matched then update set
            t.uttm_text = s.uttm_text,
            t.uttm_log_text = s.uttm_log_text,
            t.uttm_log_severity = s.uttm_log_severity
     when not matched then insert(
            t.uttm_name, t.uttm_type, t.uttm_mode, t.uttm_text, t.uttm_log_text, t.uttm_log_severity)
          values(
            s.uttm_name, s.uttm_type, s.uttm_mode, s.uttm_text, s.uttm_log_text, s.uttm_log_severity);
  end merge_template;
    
  
  function get_templates(
    p_type in utl_text_templates.uttm_type%type,
    p_name in utl_text_templates.uttm_name%type default null,
    p_mode in utl_text_templates.uttm_mode%type default null)
    return utl_text_template_table
    pipelined
  as
    cursor template_cur(
      p_type in utl_text_templates.uttm_type%type,
      p_name in utl_text_templates.uttm_name%type)
    is
    select *
      from utl_text_templates
     where uttm_type = p_type
       and (uttm_name = p_name or p_name is null)
       and (uttm_mode = p_mode or p_mode is null);
  begin
    for tpl in template_cur(p_type, p_name) loop
      pipe row(tpl);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_templates;
    
  
  function get_template_types
    return utl_text_template_type_table
    pipelined
  as
    cursor uttm_cur is
      select distinct uttm_type
        from utl_text_templates
       where uttm_type != 'INTERNAL';
  begin
    for t in uttm_cur loop
      pipe row(t.uttm_type);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_template_types;

begin
  initialize;
end utl_text_admin;
/


prompt - UTL_TEXT
create or replace package utl_text
  authid current_user
as
  subtype ora_name_type is varchar2(128 byte);
  subtype flag_type is char(1 byte);
  subtype char_type is char(1 char);
  subtype max_char is varchar2(32767 byte);
  type clob_tab is table of clob index by ora_name_type;
  

  C_NO_DELIMITER constant varchar2(4) := 'NONE';
  C_WITH_PIT constant boolean := true;
  C_TRUE constant flag_type := 'Y';
  C_FALSE constant flag_type := 'N';
  C_DEL constant varchar2(10) := ':';


  procedure set_ignore_missing_anchors(
    p_flag in boolean);

  function get_ignore_missing_anchors 
    return boolean;
  

  procedure set_default_date_format(
    p_format in varchar2);

  function get_default_date_format
    return varchar2;
  

  procedure set_newline_char(
    p_char in varchar2);

  function get_newline_char
    return varchar2;
  

  procedure set_default_delimiter_char(
    p_delimiter in varchar2);

  function get_default_delimiter_char
    return varchar2;
  

  procedure set_main_anchor_char(
    p_char in char_type);
  
  function get_main_anchor_char 
    return char_type;
    

  procedure set_secondary_anchor_char(
    p_char in char_type);
  
  function get_secondary_anchor_char 
    return char_type;
  

  procedure set_main_separator_char(
    p_char in char_type);
  
  function get_main_separator_char 
    return char_type;
  

  procedure set_secondary_separator_char(
    p_char in char_type);
  
  function get_secondary_separator_char 
    return char_type;
                               

  function wrap_string(
    p_text in clob,
    p_prefix in varchar2 default null,
    p_postfix in varchar2 default null)
    return clob;
    

  function unwrap_string(
    p_text in clob)
    return clob;
    

  function blob_to_clob(
    p_data in blob)
    return clob;
    

  function clob_replace(
    p_text in clob,
    p_what in varchar2,
    p_with in clob default null)
    return clob;
    

  function not_empty(
    p_text in varchar2)
    return boolean;


  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default C_FALSE)
    return varchar2;

  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in boolean default false);


  function append_clob(
    p_clob in clob,
    p_chunk in clob)
    return clob;


  procedure append_clob(
    p_clob in out nocopy clob,
    p_chunk in clob);


  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_ignore_nulls varchar2 default C_FALSE)
    return varchar2;


  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_ignore_nulls in boolean default true);
    

  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default C_DEL,
    p_omit_empty in flag_type default C_FALSE)
    return char_table
    pipelined;
    
    
  procedure string_to_table(
    p_string in varchar2,
    p_table out nocopy char_table,
    p_delimiter in varchar2 default C_DEL,
    p_omit_empty in flag_type default C_FALSE);
    

  function table_to_string(
    p_table in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_max_length in number default 32767)
    return varchar2;
    
    
  procedure table_to_string(
    p_table in char_table,
    p_string out nocopy varchar2,
    p_delimiter in varchar2 default C_DEL,
    p_max_length in number default 32767);

  
  function clob_to_blob(
    p_clob in clob) 
    return blob;
    

  function contains(
    p_text in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL)
    return varchar2;

  function merge_string(
    p_text in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL)
    return varchar2;
    
    
  procedure merge_string(
    p_text in out nocopy varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL);
    
    
  procedure bulk_replace(
    p_template in clob,
    p_clob_tab in clob_tab,
    p_result out nocopy clob);
    
    
  function bulk_replace(
    p_template in clob,
    p_chunks in char_table
  ) return clob;   
    
    
  procedure bulk_replace(
    p_template in out nocopy clob,
    p_chunks in char_table
  );
                         

  function generate_text(
    p_cursor in sys_refcursor,
    p_delimiter in varchar2 default null,
    p_indent in number default 0
  ) return clob;
  
    
  procedure generate_text(
    p_cursor in out nocopy sys_refcursor,
    p_result out nocopy clob,
    p_delimiter in varchar2 default null,
    p_indent in number default 0);
                         
            
  function generate_text_table(
    p_cursor in sys_refcursor
  ) return clob_table
    pipelined;
  
    
  procedure generate_text_table(
    p_cursor in out nocopy sys_refcursor,
    p_result out nocopy clob_table
  );
    
  procedure initialize;

end utl_text;
/

create or replace package body utl_text
as

  C_ROW_TEMPLATE constant ora_name_type := 'TEMPLATE';
  C_LOG_TEMPLATE constant ora_name_type := 'LOG_TEMPLATE';
  C_DATE_TYPE constant binary_integer := 12;
  C_PARAM_GROUP constant ora_name_type := 'UTL_TEXT';
  C_CR_CHAR constant varchar2(10) := '\CR\';

  g_ignore_missing_anchors boolean;
  g_default_date_format varchar2(200);
  g_default_delimiter_char varchar2(100);
  g_main_anchor_char char_type;
  g_secondary_anchor_char char_type;
  g_main_separator_char char_type;
  g_secondary_separator_char char_type;
  g_newline_char varchar2(2 byte);

  type row_tab is table of clob_tab index by binary_integer;

  type ref_rec_type is record(
    r_string max_char,
    r_date date,
    r_clob clob);
  g_ref_rec ref_rec_type;


  /**
    Group: Helper methods
   */
  /** 
    Procedure: open_cursor
      Method to open a cursor
      
    Parameters:
      p_cur - Cursor ID
      p_cursor - SYS_REFCURSOR
   */
  procedure open_cursor(
    p_cur out nocopy binary_integer,
    p_cursor in out nocopy sys_refcursor)
  as
  begin
    p_cur := dbms_sql.to_cursor_number(p_cursor);
  end open_cursor;


  /** 
    Procedure: describe_columns
      Method to analyze a cursor. The following functionality is implemented:
   
      - analyze cursor
      - initialize PL/SQL with column_name as key an NULL as payload
      - register out variables for each column with cursor
      
    Parameters:
      p_cur - Cursor ID
      p_cur_desc - DBMS_SQL.DESC_TAB2 with details to the actual cursor
      p_clob_tab - PL/SQL table with column_name (KEY) and initial NULL value for each column
      p_template - Optional template. If present, no template is expected to be part of the cursor
   */
  procedure describe_columns(
    p_cur in binary_integer,
    p_cur_desc in out nocopy dbms_sql.desc_tab2,
    p_clob_tab in out nocopy clob_tab,
    p_template in varchar2 default null)
  as
    l_column_name ora_name_type;
    l_column_count binary_integer := 1;
    l_column_type binary_integer;
    l_cnt binary_integer := 0;
    l_cur_contains_template boolean := true;
  begin
    dbms_sql.describe_columns2(
      c => p_cur,
      col_cnt => l_column_count,
      desc_t => p_cur_desc);

    if p_template is not null then
      p_clob_tab(c_row_template) := p_template;
      l_cur_contains_template := false;
    end if;

    for i in 1 .. l_column_count loop
      if i = 1 and l_cur_contains_template then
        l_column_name := C_ROW_TEMPLATE;
      else
        l_column_name := p_cur_desc(i).col_name;
      end if;

      l_column_type := p_cur_desc(i).col_type;

      -- Add column to PL/SQL table to enable referencing as out variable
      l_cnt := l_cnt + 1;
      p_clob_tab(l_column_name) := null;

      -- register out variable for this column
      if l_column_type = C_DATE_TYPE then
        dbms_sql.define_column(
          c => p_cur,
          position => l_cnt,
          column => g_ref_rec.r_date);
      else
        dbms_sql.define_column(
          c => p_cur,
          position => l_cnt,
          column => g_ref_rec.r_clob);
      end if;
    end loop;
  end describe_columns;


  /** 
    Procedure: copy_row_values
      Method to copy row values in prepared PL/SQL table
      
    Parameters:
      p_cur - Cursor ID
      p_cur_desc - DBMS_SQL.DESC_TAB2 with details to the actual cursor
      p_clob_tab - PL/SQL table with column_name (KEY) and initial NULL value for each column
   */
  procedure copy_row_values(
    p_cur in binary_integer,
    p_cur_desc in dbms_sql.desc_tab2,
    p_clob_tab in out nocopy clob_tab)
  as
    l_column_name ora_name_type;
  begin
    for i in 1 .. p_cur_desc.count loop
      l_column_name := p_cur_desc(i).col_name;

      -- get actual column value
      if p_cur_desc(i).col_type = C_DATE_TYPE then
        dbms_sql.column_value(p_cur, i, g_ref_rec.r_date);
        p_clob_tab(l_column_name) := to_char(g_ref_rec.r_date, g_default_date_format);
      else
        dbms_sql.column_value(p_cur, i, p_clob_tab(l_column_name));
      end if;
    end loop;
  end copy_row_values;


  /** 
    Procedure copy_table_values
      Method to copy multiple row values into a nested PL/SQL table 
      (one entry per row in the outer table, on entry per column in the inner table).
      
      Copies all rows of a cursor including their column values into a nested PL/SQL table.
      Parameter P_CLOB_TAB is necessary as it has been prepared upfront and must be passed all the way through the layers
      
    Paramteres:
      p_cur - Cursor ID
      p_cur_desc - DBMS_SQL.DESC_TAB2 with details to the actual cursor
      p_clob_tab - PL/SQL table with one entry per column
      p_row_tab - PL/SQL with one entry of type P_CLOB_TAB per row
   */
  procedure copy_table_values(
    p_cur in binary_integer,
    p_cur_desc in dbms_sql.desc_tab2,
    p_clob_tab in out nocopy clob_tab,
    p_row_tab in out nocopy row_tab)
  as
  begin
    while dbms_sql.fetch_rows(p_cur) > 0 loop
      copy_row_values(
        p_cur => p_cur,
        p_cur_desc => p_cur_desc,
        p_clob_tab => p_clob_tab);

      p_row_tab(dbms_sql.last_row_count) := p_clob_tab;
    end loop;
  end copy_table_values;


  /** 
    Procedure: copy_table_to_row_tab
      Method to copy a table into a nested PL/SQL table. Helper method as it is called three times
      
    Parameters:
      p_cur - Cursor ID of a cursor that is allowed to contain multiple rows
      p_row_tab - PL/SQL table with the rows and column values
      p_template - Optional template. If present, no template is expected to be part of the cursor
   */
  procedure copy_table_to_row_tab(
    p_cur in out nocopy binary_integer,
    p_row_tab in out nocopy row_tab,
    p_template in varchar2 default null)
  as
    l_cur_desc dbms_sql.desc_tab2;
    l_clob_tab clob_tab;
  begin
    describe_columns(
      p_cur => p_cur,
      p_cur_desc => l_cur_desc,
      p_clob_tab => l_clob_tab,
      p_template => p_template);

    copy_table_values(
      p_cur => p_cur,
      p_cur_desc => l_cur_desc,
      p_clob_tab => l_clob_tab,
      p_row_tab => p_row_tab);

    dbms_sql.close_cursor(p_cur);
  end copy_table_to_row_tab;


  /** 
    Function: get_delimiter
      Method to calculate the actual delimiter sign. Allows to switch delimiter off by passing in <C_NO_DELIMITER>
      
    Parameter:
      p_delimiter - Delimiter char. If NULL, <G_DEFAULT_DELIMITER> is used
      
    Returns:
      Delimiter character
   */
  function get_delimiter(
    p_delimiter in varchar2)
    return varchar2
  as
    l_delimiter g_default_delimiter_char%type;
  begin
    case
    when p_delimiter = c_no_delimiter then
      l_delimiter := null;
    when p_delimiter is null then
      l_delimiter := g_default_delimiter_char;
    else
      l_delimiter := p_delimiter;
    end case;

    return l_delimiter;
  end get_delimiter;


  /** 
    Procedure: bulk_replace
      Method to replace all anchors with respective values from P_ROW_TAB
      
    Parameters:
      p_row_tab - Nested PL/SQL table, created by <COPY_TABLE_TO_ROW_TAB>
      p_delimiter - Delimiter char to separate optional compponents within an anchor
      p_indent - Optional amount of blanks to indent each resulting row
      p_result - CLOB instance with the converted result
   */
  procedure bulk_replace(
    p_row_tab in row_tab,
    p_delimiter in varchar2,
    p_indent in number,
    p_result out nocopy clob)
  as
    l_result clob;
    l_template clob;
    l_log_message clob;
    l_clob_tab clob_tab;
    l_delimiter g_default_delimiter_char%type;
    l_indent varchar2(1000);
  begin
    l_delimiter := get_delimiter(p_delimiter);

    if p_row_tab.count > 0 then
      dbms_lob.createtemporary(p_result, false, dbms_lob.call);

      for i in 1 .. p_row_tab.count loop
        l_clob_tab := p_row_tab(i);
        if l_clob_tab.exists(C_ROW_TEMPLATE) then
          l_template := l_clob_tab(C_ROW_TEMPLATE);
        else
          l_template := l_clob_tab(l_clob_tab.first);
        end if;

        bulk_replace(
          p_template => l_template,
          p_clob_tab => l_clob_tab,
          p_result => l_result);

        if i < p_row_tab.last then
          l_result := l_result || l_delimiter;
        end if;

        dbms_lob.append(p_result, l_result);
      end loop;
    end if;

    -- indent complete result by P_INDENT
    if p_indent > 0 then
      l_indent := l_delimiter || rpad(' ', p_indent, ' ');
      p_result := replace(p_result, l_delimiter, l_indent);
    end if;

  end bulk_replace;


  /** 
    Procedure: bulk_replace
      Method to replace all anchors with respective values from P_ROW_TAB
    
    Paramters:
      p_row_tab - Nested PL/SQL table, created by <COPY_TABLE_TO_ROW_TAB>
      p_delimiter - Delimiter char to separate optional compponents within an anchor
      p_result - <CLOB_TABLE> instance with the converted result (one CLOB instance per row)
   */
  procedure bulk_replace(
    p_row_tab in row_tab,
    p_delimiter in varchar2,
    p_result out nocopy clob_table)
  as
    l_result clob;
    l_template clob;
    l_log_message clob;
    l_clob_tab clob_tab;
    l_delimiter g_default_delimiter_char%type;
  begin
    -- Initialize
    p_result := clob_table();
    l_delimiter := get_delimiter(p_delimiter);

    for i in 1 .. p_row_tab.count loop
      l_clob_tab := p_row_tab(i);

      l_template := l_clob_tab(C_ROW_TEMPLATE);

      bulk_replace(
        p_template => l_template,
        p_clob_tab => l_clob_tab,
        p_result => l_result);

      if i < p_row_tab.last then
        l_result := l_result || l_delimiter;
      end if;

      p_result.extend;
      p_result(p_result.count) := l_result;
    end loop;
  end bulk_replace;


  /** 
    Procedure: initialize
      Initializes the package and reads parameter values
   */
  procedure initialize
  as
  begin
    $IF utl_text.C_WITH_PIT $THEN
    g_ignore_missing_anchors := param.get_boolean(
                                  p_par_id => 'IGNORE_MISSING_ANCHORS',
                                  p_par_pgr_id => C_PARAM_GROUP);
    g_default_delimiter_char := param.get_string(
                                  p_par_id => 'DEFAULT_DELIMITER_CHAR',
                                  p_par_pgr_id => C_PARAM_GROUP);
    g_default_date_format := param.get_string(
                               p_par_id => 'DEFAULT_DATE_FORMAT',
                               p_par_pgr_id => C_PARAM_GROUP);
    g_main_anchor_char := param.get_string(
                            p_par_id => 'MAIN_ANCHOR_CHAR',
                            p_par_pgr_id => C_PARAM_GROUP);
    g_secondary_anchor_char := param.get_string(
                                 p_par_id => 'SECONDARY_ANCHOR_CHAR',
                                 p_par_pgr_id => C_PARAM_GROUP);
    g_main_separator_char := param.get_string(
                               p_par_id => 'MAIN_SEPARATOR_CHAR',
                               p_par_pgr_id => C_PARAM_GROUP);
    g_secondary_separator_char := param.get_string(
                                    p_par_id => 'SECONDARY_SEPARATOR_CHAR',
                                    p_par_pgr_id => C_PARAM_GROUP);
    $ELSE
    g_ignore_missing_anchors := true;
    g_default_delimiter_char := chr(10);
    g_default_date_format := 'yyyy-mm-dd hh24:mi:ss';
    g_main_anchor_char := '#';
    g_secondary_anchor_char := '^';
    g_main_separator_char := '|';
    g_secondary_separator_char := '~';
    $END

    -- Derive delimiter from OS
    case when regexp_like(dbms_utility.port_string, '(WIN|Windows)') then
      g_newline_char := chr(13) || chr(10);
    when regexp_like(dbms_utility.port_string, '(AIX)') then
      g_newline_char := chr(21);
    else
      g_newline_char := chr(10);
    end case;
  end initialize;


  /** 
    Group: INTERFACE
   */
  /** 
    Procedure: set_default_delimiter_char
      see: <UTL_TEXT.set_default_delimiter_char>
   */
  procedure set_ignore_missing_anchors(
    p_flag in boolean)
  as
  begin
    g_ignore_missing_anchors := p_flag;
  end set_ignore_missing_anchors;
    
  
  /** 
    Function: get_ignore_missing_anchors
      see: <UTL_TEXT.get_ignore_missing_anchors>
   */
  function get_ignore_missing_anchors
    return boolean
  as
  begin
    return g_ignore_missing_anchors;
  end get_ignore_missing_anchors;
    
  
  /** 
    Procedure: set_default_delimiter_char
      see: <UTL_TEXT.set_default_delimiter_char>
   */
  procedure set_default_delimiter_char(
    p_delimiter in varchar2)
  as
  begin
    g_default_delimiter_char := p_delimiter;
  end set_default_delimiter_char;
    
  
  /** 
    Function: get_default_delimiter_char
      see: <UTL_TEXT.get_default_delimiter_char>
   */
  function get_default_delimiter_char
    return varchar2
  as
  begin
    return g_default_delimiter_char;
  end get_default_delimiter_char;
    
  
  /** 
    Procedure: set_main_anchor_char
      see: <UTL_TEXT.set_main_anchor_char>
   */
  procedure set_main_anchor_char(p_char in char_type) as
  begin
    g_main_anchor_char := p_char;
  end set_main_anchor_char;
    
  
  /** 
    Function: get_main_anchor_char
      see: <UTL_TEXT.get_main_anchor_char>
   */
  function get_main_anchor_char return char_type as
  begin
    return g_main_anchor_char;
  end get_main_anchor_char;
    
  
  /** 
    Procedure: set_secondary_anchor_char
      see: <UTL_TEXT.set_secondary_anchor_char>
   */
  procedure set_secondary_anchor_char(p_char in char_type) as
  begin
    g_secondary_anchor_char := p_char;
  end set_secondary_anchor_char;
    
  
  /** 
    Function: get_secondary_anchor_char
      see: <UTL_TEXT.get_secondary_anchor_char>
   */
  function get_secondary_anchor_char return char_type as
  begin
    return g_secondary_anchor_char;
  end get_secondary_anchor_char;
    
  
  /** 
    Procedure: set_main_separator_char
      see: <UTL_TEXT.set_main_separator_char>
   */
  procedure set_main_separator_char(
    p_char in char_type)
  as
  begin
    g_main_separator_char := p_char;
  end set_main_separator_char;
    
  
  /** 
    Function: get_main_separator_char
      see: <UTL_TEXT.get_main_separator_char>
   */
  function get_main_separator_char
    return char_type
  as
  begin
    return g_main_separator_char;
  end get_main_separator_char;
    
  
  /** 
    Procedure: set_secondary_separator_char
      see: <UTL_TEXT.set_secondary_separator_char>
   */
  procedure set_secondary_separator_char(
    p_char in char_type)
  as
  begin
    g_secondary_separator_char := p_char;
  end set_secondary_separator_char;
    
  
  /** 
    Function: get_secondary_separator_char
      see: <UTL_TEXT.get_secondary_separator_char>
   */
  function get_secondary_separator_char
    return char_type
  as
  begin
    return g_secondary_separator_char;
  end get_secondary_separator_char;
    
  
  /** 
    Procedure: set_default_date_format
      see: <UTL_TEXT.set_default_date_format>
   */
  procedure set_default_date_format(p_format in varchar2) as
  begin
    g_default_date_format := p_format;
  end set_default_date_format;
    
  
  /** 
    Function: get_default_date_format
      see: <UTL_TEXT.get_default_date_format>
   */
  function get_default_date_format return varchar2 as
  begin
    return g_default_date_format;
  end get_default_date_format;
    
  
  /** 
    Procedure: set_newline_char
      see: <UTL_TEXT.set_newline_char>
   */
  procedure set_newline_char(
    p_char in varchar2)
  as
  begin
    g_newline_char := p_char;
  end set_newline_char;
    
  
  /** 
    Function: get_newline_char
      see: <UTL_TEXT.get_newline_char>
   */
  function get_newline_char
    return varchar2
  as
  begin
    return g_newline_char;
  end get_newline_char;
    
  
  /** 
    Function: not_empty
      see: <UTL_TEXT.not_empty>
   */
  function not_empty(
    p_text in varchar2)
    return boolean
  as
  begin
    return length(trim(p_text)) > 0;
  end not_empty;
    
  
  /** 
    Function: append
      see: <UTL_TEXT.append>
   */
  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default C_FALSE)
    return varchar2
  as
    l_result max_char;
  begin
    if not_empty(p_chunk) then
      if upper(p_before) != c_false then
        l_result := p_text || case when p_text is not null then p_delimiter end || p_chunk;
      else
        l_result := p_text || p_chunk || p_delimiter;
      end if;
    end if;
    return l_result;
  end append;
    
  
  /** 
    Procedure: append
      see: <UTL_TEXT.append>
   */
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in boolean default false)
  as
    l_before flag_type := C_FALSE;
  begin
    if p_before then
      l_before := C_TRUE;
    end if;
    p_text := append(p_text, p_chunk, p_delimiter, l_before);
  end append;
    
  
  /** 
    Function: append_clob
      see: <UTL_TEXT.append_clob>
   */
  function append_clob(
    p_clob in clob,
    p_chunk in clob)
    return clob
  as
    l_length number;
    l_clob clob;
  begin
    l_length := dbms_lob.getlength(p_chunk);
    if l_length > 0 then
      l_clob := p_clob;
      if l_clob is null then
        dbms_lob.createtemporary(l_clob, false, dbms_lob.call);
      end if;
      dbms_lob.writeappend(l_clob, l_length, p_chunk);
    end if;
    return l_clob;
  end append_clob;
    
  
  /** 
    Procedure: append_clob
      see: <UTL_TEXT.append_clob>
   */
  procedure append_clob(
    p_clob in out nocopy clob,
    p_chunk in clob)
  as
  begin
     p_clob := append_clob(p_clob, p_chunk);
  end append_clob;
    
  
  /** 
    Function: blob_to_clob
      see: <UTL_TEXT.blob_to_clob>
   */
  function blob_to_clob(
    p_data in blob)
    return clob
  as
    l_clob clob;
    l_dest_offset  PLS_INTEGER := 1;
    l_src_offset   PLS_INTEGER := 1;
    l_lang_context PLS_INTEGER := DBMS_LOB.default_lang_ctx;
    l_warning      PLS_INTEGER;
  begin
    dbms_lob.createtemporary(
      lob_loc => l_clob,
      cache   => FALSE,
      dur     => dbms_lob.call);

    dbms_lob.converttoclob(
     dest_lob      => l_clob,
     src_blob      => p_data,
     amount        => dbms_lob.lobmaxsize,
     dest_offset   => l_dest_offset,
     src_offset    => l_src_offset, 
     blob_csid     => dbms_lob.default_csid,
     lang_context  => l_lang_context,
     warning       => l_warning);
    dbms_lob.append(l_clob, sqlerrm);
    return l_clob;
  end blob_to_clob;
    
  
  /** 
    Function: concatenate
      see: <UTL_TEXT.concatenate>
   */
  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_ignore_nulls varchar2 default C_FALSE)
    return varchar2
  as
    l_result max_char;
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if (not_empty(p_chunks(i)) and p_ignore_nulls = C_TRUE) or (p_ignore_nulls = C_FALSE) then
        append(
          p_text => l_result,
          p_chunk => p_chunks(i),
          p_delimiter => p_delimiter
        );
      end if;
    end loop;
    return trim(p_delimiter from l_result);
  end concatenate;
    
  
  /** 
    Procedure: concatenate
      see: <UTL_TEXT.concatenate>
   */
  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_ignore_nulls in boolean default true)
  as
    l_ignore_nulls char(1 byte);
  begin
    if p_ignore_nulls then
      l_ignore_nulls := c_true;
    else
      l_ignore_nulls := c_false;
    end if;
    p_text := concatenate(p_chunks, p_delimiter, l_ignore_nulls);
  end concatenate;
    
  
  /** 
    Function: string_to_table
      see: <UTL_TEXT.string_to_table>
   */
  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default C_DEL,
    p_omit_empty in flag_type default C_FALSE)
    return char_table
    pipelined
  as
    l_char_table char_table;
  begin
    string_to_table(p_string, l_char_table, p_delimiter, p_omit_empty);
    for i in 1 .. l_char_table.count loop
      pipe row (l_char_table(i));
    end loop;
    return;
  end string_to_table;
    
  
  /** 
    Procedure: string_to_table
      see: <UTL_TEXT.string_to_table>
   */
  procedure string_to_table(
    p_string in varchar2,
    p_table out nocopy char_table,
    p_delimiter in varchar2 default C_DEL,
    p_omit_empty in flag_type default C_FALSE)
  as
    l_chunk max_char;
  begin
    if p_table is null then
      p_table := char_table();
    end if;
    if p_string is not null then
      for i in 1 .. regexp_count(p_string, '\' || p_delimiter) + 1 loop
        l_chunk := regexp_substr(p_string, '[^\' || p_delimiter || ']+', 1, i);
        if p_omit_empty = C_FALSE or l_chunk is not null then
          p_table.extend;
          p_table(p_table.last) := l_chunk;
        end if;
      end loop;
    end if;
  end string_to_table;
    
  
  /** 
    Function: table_to_string
      see: <UTL_TEXT.table_to_string>
   */
  function table_to_string(
    p_table in char_table,
    p_delimiter in varchar2 default C_DEL,
    p_max_length in number default 32767)
    return varchar2
  as
    l_result max_char;
  begin
    table_to_string(p_table, l_result, p_delimiter, p_max_length);
    
    return l_result;
  end table_to_string;
    
  
  /** 
    Procedure: table_to_string
      see: <UTL_TEXT.table_to_string>
   */
  procedure table_to_string(
    p_table in char_table,
    p_string out nocopy varchar2,
    p_delimiter in varchar2 default C_DEL,
    p_max_length in number default 32767)
  as
  begin
    for i in 1 .. p_table.count loop
      if length(p_string) + length(p_table(i)) > least(p_max_length, 32767) then
        exit;
      end if;
      if i > 1 then
        p_string := p_string || p_delimiter;
      end if;
      p_string := p_string || p_table(i);
    end loop;
  end table_to_string;
    
  
  /** 
    Function: clob_to_blob
      see: <UTL_TEXT.clob_to_blob>
   */
  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context  integer := dbms_lob.DEFAULT_LANG_CTX;
    l_warning       integer := dbms_lob.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin
    $IF utl_text.C_WITH_PIT $THEN   
    pit.assert(dbms_lob.getlength(p_clob) > 0);
    $ELSE
    return null;
    $END
    
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
    dbms_lob.converttoblob (
      dest_lob => l_blob,
      src_clob => p_clob,
      amount => dbms_lob.LOBMAXSIZE,
      dest_offset => l_dest_offset,
      src_offset => l_source_offset,
      blob_csid => dbms_lob.DEFAULT_CSID,
      lang_context => l_lang_context,
      warning => l_warning
    );

    return l_blob;
  $IF utl_text.C_WITH_PIT $THEN   
  exception
    when msg.PIT_ASSERT_IS_NOT_NULL_ERR then
      return null;
  $END
  end clob_to_blob;
    
  
  /** 
    Function: contains
      see: <UTL_TEXT.contains>
   */
  function contains(
    p_text in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL)
    return varchar2
  as
    l_result char(1 byte) := c_false;
  begin
    if instr(p_delimiter || p_text || p_delimiter, p_delimiter || p_pattern || p_delimiter) > 0 then
      l_result := c_true;
    end if;
    return l_result;
  end contains;
    
  
  /** 
    Function: merge_string
      see: <UTL_TEXT.merge_string>
   */
  function merge_string(
    p_text in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL)
    return varchar2
  as
    l_result max_char;
    l_strings char_table;
    l_patterns char_table;
    l_exists boolean := false;
  begin
    l_strings := string_to_table(p_text, p_delimiter);
    l_patterns := string_to_table(p_pattern, p_delimiter);
    for i in 1 .. l_patterns.count loop
      for k in 1 .. l_strings.count loop
        if l_strings(k) = l_patterns(i) then
          l_exists := true;
        end if;
      end loop;
      if l_exists then
        -- already in list, ignore
        null;
      else
        l_strings.extend;
        l_strings(l_strings.last) := l_patterns(i);
      end if;
      l_exists := false;
    end loop;
    l_result := concatenate(l_strings, p_delimiter);
    return l_result;
  end merge_string;
    
  
  /** 
    Procedure: merge_string
      see: <UTL_TEXT.merge_string>
   */
  procedure merge_string(
    p_text in out nocopy varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default C_DEL)
  as
  begin
    p_text := merge_string(p_text, p_pattern, p_delimiter);
  end merge_string;
    
  
  /** 
    Function: wrap_string
      see: <UTL_TEXT.wrap_string>
   */
  function wrap_string(
    p_text in clob,
    p_prefix in varchar2 default null,
    p_postfix in varchar2 default null)
    return clob
  as
    l_text clob;
    l_prefix varchar2(20) := coalesce(p_prefix, q'[q'°]');
    l_postfix varchar2(20) := coalesce(p_postfix, q'[°']');
    C_REGEX_NEWLINE constant varchar2(30) := '(' || chr(13) || chr(10) || '|' || chr(10) || '|' || chr(13) || ' |' || chr(21) || ')';
    C_REPLACEMENT constant varchar2(100) := C_CR_CHAR || l_postfix || ' || ' || g_newline_char || l_prefix;
  begin
    if p_text is not null and dbms_lob.getlength(p_text) < 32767 then
      -- l_text := l_prefix || regexp_replace(p_text, C_REGEX_NEWLINE, C_REPLACEMENT) || l_postfix; -- Buggy
      if instr(p_text, chr(13) || chr(10)) > 0 then
        l_text := replace(p_text, chr(13) || chr(10), C_REPLACEMENT);
      end if;
      if instr(p_text, chr(10)) > 0 then
        l_text := replace(p_text, chr(10), C_REPLACEMENT);
      end if;
      if instr(p_text, chr(13)) > 0 then
        l_text := replace(p_text, chr(13), C_REPLACEMENT);
      end if;
      l_text := l_prefix || coalesce(l_text, p_text) || l_postfix;
    else
      -- TODO: Klären, was mit CLOB > 32K passieren soll
      null;
    end if;
    l_text := coalesce(l_text, l_prefix || l_postfix);    
    return l_text;
  end wrap_string;
    
  
  /** 
    Function: unwrap_string
      see: <UTL_TEXT.unwrap_string>
   */
  function unwrap_string(
    p_text in clob)
    return clob
  as
    l_text clob;
  begin
    if p_text is not null and dbms_lob.getlength(p_text) <= 32767 then
      l_text := replace(p_text, C_CR_CHAR, g_newline_char);
    else
      -- TODO: Klären, was mit CLOB > 32K passieren soll
      null;
    end if;
    return l_text;
  end unwrap_string;


  function clob_replace(
    p_text in clob,
    p_what in varchar2,
    p_with in clob default null)
    return clob
  as
    l_result clob;
    l_before clob;
    l_after clob;
    l_idx binary_integer;
  begin
    l_idx := instr(p_text, p_what);
    if l_idx > 0 then
      l_before := substr(p_text, 1, l_idx - 1);
      l_after := substr(p_text, l_idx + length(p_what));
      l_result :=  l_before || p_with || l_after;
      return l_result;
    else
      return p_text;
    end if;
  end clob_replace;
    
  
  /** 
    Procedure: bulk_replace
      see: <UTL_TEXT.bulk_replace>
   */
  procedure bulk_replace(
    p_template in clob,
    p_clob_tab in clob_tab,
    p_result out nocopy clob)
  as
    C_REGEX varchar2(20) := replace('\#A#[A-Z0-9].*?\#A#', '#A#', g_main_anchor_char);
    C_REGEX_ANCHOR varchar2(20) := '[^\' || g_main_anchor_char || ']+';
    C_REGEX_SEPARATOR varchar2(20) := '(.*?)(\' || g_main_separator_char || '|$)';
    C_REGEX_ANCHOR_NAME constant varchar2(50) := q'^(^[0-9]+$|^[A-Z][A-Z0-9_\$#]*$)^';

    /** Cursor detects all replacement anchors within a template and extracts any substructure */
    cursor replacement_cur(p_template in clob) is
        with anchors as (
                select trim(g_main_anchor_char from regexp_substr(p_template, C_REGEX, 1, level)) replacement_string
                  from dual
               connect by level <= regexp_count(p_template, '\' || g_main_anchor_char) / 2),
             parts as(
             select g_main_anchor_char || replacement_string || g_main_anchor_char as replacement_string,
                    upper(regexp_substr(replacement_string, C_REGEX_SEPARATOR, 1, 1, null, 1)) anchor,
                    regexp_substr(replacement_string, C_REGEX_SEPARATOR, 1, 2, null, 1) prefix,
                    regexp_substr(replacement_string, C_REGEX_SEPARATOR, 1, 3, null, 1) postfix,
                    regexp_substr(replacement_string, C_REGEX_SEPARATOR, 1, 4, null, 1) null_value
               from anchors)
      select replacement_string, anchor, prefix, postfix, null_value,
             case when regexp_instr(anchor, C_REGEX_ANCHOR_NAME) > 0 then 1 else 0 end valid_anchor_name
        from parts
       where anchor is not null;

    l_anchor_value clob;
    l_missing_anchors max_char;
    l_invalid_anchors max_char;
    l_template clob;
  begin
    $IF utl_text.C_WITH_PIT $THEN
    pit.assert(
      p_condition => dbms_lob.getlength(p_template) > 0,
      p_message_name => msg.NO_TEMPLATE);
    $ELSE
    if p_template is null then
      raise_application_error(-20000, 'Template must not be null');
    end if;
    $END

    -- Copy template to result to allow for easy recursion
    p_result := p_template;

    -- Replace replacement anchors. Replacements may contain replacement anchors
    for rep in replacement_cur(p_template) loop
      case
      when rep.valid_anchor_name = 0 then
        l_invalid_anchors := l_invalid_anchors || g_main_anchor_char || rep.anchor;
      when p_clob_tab.exists(rep.anchor) then
        l_anchor_value := p_clob_tab(rep.anchor);
        if l_anchor_value is not null then
          p_result := clob_replace(p_result, rep.replacement_string, rep.prefix || l_anchor_value || rep.postfix);
        else
          p_result := clob_replace(p_result, rep.replacement_string, rep.null_value);
        end if;
      else
        -- replacement anchor is missing
        l_missing_anchors := l_missing_anchors || g_main_anchor_char || rep.anchor;
        null;
      end case;
    end loop;

    /*if l_invalid_anchors is not null and not g_ignore_missing_anchors then
      $IF utl_text.C_WITH_PIT $THEN
      pit.error(
        msg.INVALID_ANCHOR_NAMES,
        msg_args(l_invalid_anchors));
      $ELSE
      raise_application_error(-20001, 'The following anchors are not conforming to the naming rules: ' || l_invalid_anchors);
      $END
    end if;*/

    if l_missing_anchors is not null and not g_ignore_missing_anchors then
      l_missing_anchors := ltrim(l_missing_anchors, g_main_anchor_char);
      $IF utl_text.C_WITH_PIT $THEN
      pit.error(
        msg.MISSING_ANCHORS,
        msg_args(l_missing_anchors));
      $ELSE
      raise_application_error(-20002, 'The following anchors are missing: ' || l_missing_anchors);
      $END
    end if;

    -- Call recursively to replace newly entered replacement anchors.
    -- To make this possible, replace secondary anchor chars with their primary pendants before recursion
    if p_template != p_result then
      l_template := replace(replace(p_result,
                        g_secondary_anchor_char, g_main_anchor_char),
                        g_secondary_separator_char, g_main_separator_char);
      if dbms_lob.getlength(l_template) > 0 then
        bulk_replace(
          p_template => l_template,
          p_clob_tab => p_clob_tab,
          p_result => p_result);
      end if;
    end if;
  end bulk_replace;
    
  
  /** 
    Procedure: bulk_replace
      see: <UTL_TEXT.bulk_replace>
   */
  procedure bulk_replace(
    p_template in out nocopy clob,
    p_chunks in char_table
  )
  as
    l_clob_tab clob_tab;
    l_result clob;
  begin
    for i in 1 .. p_chunks.count loop
      if mod(i, 2) = 1 then
        l_clob_tab(replace(p_chunks(i), g_main_anchor_char)) := p_chunks(i + 1);
      end if;
    end loop;

    bulk_replace(
      p_template => p_template,
      p_clob_tab => l_clob_tab,
      p_result => l_result);
    p_template := l_result;
  end bulk_replace;


  function bulk_replace(
    p_template in clob,
    p_chunks in char_table
  ) return clob
  as
    l_result clob;
  begin
    l_result := p_template;
    bulk_replace(
      p_template => l_result,
      p_chunks => p_chunks);
    return l_result;
  end bulk_replace;
    
  
  /** 
    Procedure: generate_text
      see: <UTL_TEXT.generate_text>
   */
  procedure generate_text(
    p_cursor in out nocopy sys_refcursor,
    p_result out nocopy clob,
    p_delimiter in varchar2 default null,
    p_indent in number default 0)
  as
    l_row_tab row_tab;
    l_cur binary_integer;
  begin
    $IF utl_text.C_WITH_PIT $THEN
    pit.assert(
      p_condition => (coalesce(p_delimiter, c_no_delimiter) = c_no_delimiter and p_indent = 0) or (p_delimiter != c_no_delimiter),
      p_message_name => msg.INVALID_PARAMETER_COMBI);
    $ELSE
    if not((p_delimiter = c_no_delimiter and p_indent = 0) or (p_delimiter != c_no_delimiter)) then
      raise_application_error(-20003, 'Indenting is allowed only if a delimiter is present.');
    end if;
    $END

    open_cursor(
      p_cur => l_cur,
      p_cursor => p_cursor);

    copy_table_to_row_tab(
      p_cur => l_cur,
      p_row_tab => l_row_tab);

    bulk_replace(
      p_row_tab => l_row_tab,
      p_delimiter => p_delimiter,
      p_result => p_result,
      p_indent => p_indent);
  end generate_text;
    
  
  /** 
    Function: generate_text
      see: <UTL_TEXT.generate_text>
   */
  function generate_text(
    p_cursor in sys_refcursor,
    p_delimiter in varchar2 default null,
    p_indent in number default 0)
    return clob
  as
    l_clob clob;
    l_cur sys_refcursor := p_cursor;
  begin
    generate_text(
      p_cursor => l_cur,
      p_result => l_clob,
      p_delimiter => p_delimiter,
      p_indent => p_indent);
    return l_clob;
  end generate_text;
    
  
  /** 
    Procedure: generate_text_table
      see: <UTL_TEXT.generate_text_table>
   */
  procedure generate_text_table(
    p_cursor in out nocopy sys_refcursor,
    p_result out nocopy clob_table)
  as
    l_cur binary_integer;
    l_row_tab row_tab;
  begin
    open_cursor(
      p_cur => l_cur,
      p_cursor => p_cursor);

    copy_table_to_row_tab(
      p_cur => l_cur,
      p_row_tab => l_row_tab);

    bulk_replace(
      p_row_tab => l_row_tab,
      p_delimiter => null,
      p_result => p_result);
  end generate_text_table;
    
  
  /** 
    Function: generate_text_table
      see: <UTL_TEXT.generate_text_table>
   */
  function generate_text_table(
    p_cursor in sys_refcursor)
    return clob_table
    pipelined
  as
    l_clob_table clob_table;
    l_cur sys_refcursor := p_cursor;
  begin
    generate_text_table(
        p_cursor    => l_cur,
        p_result    => l_clob_table);

    for i in 1 .. l_clob_table.count loop
      if dbms_lob.getlength(l_clob_table(i)) > 0 then
        pipe row (l_clob_table(i));
      end if;
    end loop;
    return;
  end generate_text_table;
    
  
  function get_anchors(
    p_uttm_type in varchar2,
    p_uttm_name in varchar2,
    p_uttm_mode in varchar2,
    p_with_replacements in flag_type default C_FALSE
  ) return char_table
    pipelined
  as
    C_REGEX_ANCHOR_complete constant varchar2(100) :=
      '\' || g_main_anchor_char || '[A-Z0-9_\$\' || g_main_separator_char || '].*?\' || g_main_anchor_char || '';
    C_REGEX_ANCHOR_only constant varchar2(100) :=
      '\' || g_main_anchor_char || '[A-Z0-9_\$].*?(\' || g_main_separator_char || '|\' || g_main_anchor_char || ')';

    l_regex varchar2(200);
    l_retval char_table;
    l_template utl_text_templates.uttm_text%type;
    l_str varchar2(50 char);
    l_cnt pls_integer := 1;
  begin
    select uttm_text
      into l_template
      from utl_text_templates
     where uttm_name = upper(p_uttm_name)
       and uttm_type = upper(p_uttm_type)
       and uttm_mode = upper(p_uttm_mode);

    -- Template found, initialize
    case when p_with_replacements = C_TRUE then
      l_regex := C_REGEX_ANCHOR_COMPLETE;
    else
      l_regex := C_REGEX_ANCHOR_ONLY;
    end case;

    -- Find replacement anchors and prepare them for replacement
    loop
      l_str := regexp_substr(l_template, l_regex, 1, l_cnt);
      if l_str is not null then
        if p_with_replacements = 0 then
          l_str := replace(replace(l_str, g_main_anchor_char), g_main_separator_char);
        end if;
        l_cnt := l_cnt + 1;

        pipe row (l_str);
      else
        exit;
      end if;
    end loop;

    return;
  end get_anchors;
    
  
begin
  initialize;
end utl_text;
/


prompt -  UTL_APEX
create or replace package utl_apex
  authid definer
as
  subtype ora_name_type is varchar2(128 byte);
  subtype small_char is varchar2(255 byte);
  subtype max_char is varchar2(32767 byte);
  subtype max_sql_char is varchar2(4000 byte);
  subtype flag_type is char(1 byte);

  type item_rec is record(
    item_name ora_name_type,
    item_alias ora_name_type,
    item_label ora_name_type,
    format_mask ora_name_type,
    item_value max_char,
    is_column flag_type,
    region_id number);

  type item_tab is table of item_rec;

  NUMBER_FORMAT_MASK constant small_char := '9999999999999999999D99999999999999';

  /* Package constants */
  /* APEX Version constants according to DBMS_DB_VERSION */
  VER_LE_18 constant boolean := false;
  VER_LE_1801 constant boolean := false;
  VER_LE_1802 constant boolean := false;
  VER_LE_19 constant boolean := false;
  VER_LE_1901 constant boolean := false;
  VER_LE_1902 constant boolean := false;
  VER_LE_20 constant boolean := false;
  VER_LE_2001 constant boolean := false;
  VER_LE_2002 constant boolean := false;
  VER_LE_21 constant boolean := false;
  VER_LE_2101 constant boolean := false;
  VER_LE_2102 constant boolean := false;
  VER_LE_22 constant boolean := true;
  VER_LE_2201 constant boolean := false;
  VER_LE_2202 constant boolean := true;

  APEX_VERSION constant number := 22.2;
  UTL_APEX_VERSION constant char(8 byte) := '01.00.00';

  PIT_INSTALLED constant boolean := true;
  
  function c_true
    return flag_type;

  function c_false
    return flag_type;

  function c_yes
    return ora_name_type;

  function c_no
    return ora_name_type;


  function get_bool(
    p_bool in boolean)
    return flag_type;


  function get_bool(
    p_bool in flag_type)
    return boolean;


  function to_bool(
    p_value in varchar2)
    return flag_type;


  function get_apex_version
    return number;

  function get_user
    return varchar2;

  function get_workspace_id(
    p_application_id in number)
    return number;


  function get_application_id(
    p_ignore_translation in flag_type default C_TRUE)
    return number;

  function get_application_alias
    return varchar2;

  function get_page_id(
    p_ignore_translation in flag_type default C_TRUE)
    return number;

  function get_page_alias
    return varchar2;


  procedure get_page_element(
    p_page_item in ora_name_type,
    p_item out nocopy item_rec);

  function get_page_element(
    p_page_item in ora_name_type)
    return item_rec;


  function get_page_prefix
   return varchar2;

  function get_session_id
    return number;

  function get_request
    return varchar2;

  function get_debug
    return boolean;

  function get_default_date_format(
    p_application_id in number default null)
    return varchar2;

  function get_default_timestamp_format(
    p_application_id in number default null)
    return varchar2;


  function get_number(
    p_page_item in varchar2)
    return number;


  function get_date(
    p_page_item in varchar2)
    return date;


  function get_string(
    p_page_item in varchar2)
    return varchar2;


  function get_boolean(
    p_page_item in varchar2)
    return flag_type;
    
    
  function get_timestamp(
    p_page_item in varchar2)
    return timestamp;
    
    
  function get_value(
    p_page_item in varchar2)
    return varchar2;

  procedure set_value(
    p_page_item in varchar2,
    p_value in varchar2);


  function get_app_value(
    p_app_item in varchar2)
    return varchar2;

  procedure set_app_value(
    p_app_item in varchar2,
    p_value in varchar2);


  procedure set_success_message(
    p_message in ora_name_type,
    p_msg_args in msg_args default null);


  function user_is_authorized(
    p_authorization_scheme in varchar2)
    return flag_type;


  function current_user_in_group(
    p_group_name in varchar2)
    return utl_apex.flag_type;


  function get_last_login
    return date;


  function validate_simple_sql_name(
    p_name in ora_name_type)
    return ora_name_type;


  procedure set_error(
    p_page_item in ora_name_type,
    p_message in ora_name_type default null,
    p_msg_args in msg_args default null,
    p_region_id in ora_name_type default null);


  procedure set_error(
    p_test in boolean,
    p_page_item in ora_name_type,
    p_message in ora_name_type default null,
    p_msg_args in msg_args default null,
    p_region_id in ora_name_type default null);

  function inserting
    return boolean;

  function updating
    return boolean;

  function deleting
    return boolean;

  function request_is(
    p_request in varchar2)
    return boolean;

  procedure unhandled_request;


  function get_page_url(
    p_application in varchar2 default null,
    p_page in varchar2 default null,
    p_param_items in varchar2 default null,
    p_value_items in varchar2 default null,
    p_value_list in varchar2 default null,
    p_triggering_element in varchar2 default null,
    p_clear_cache in binary_integer default null)
    return varchar2;


  /** Methods to download a LOB over the browser
   * @param  p_blob       BLOB instance to download
   * @param  p_file_name  Name of the file to download
   * @param  p_mime_type  Optional mime type of the download
   * @usage  Is called to offer a file as a download over APEX
   */
  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2,
    p_mime_type in varchar2 default 'application/octet-stream');


  /** Overload for CLOB instances */
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2,
    p_mime_type in varchar2 default 'application/octet-stream');


  /* ASSERTIONS-Wrapper */
  procedure assert(
    p_condition in boolean,
    p_message_name in ora_name_type default msg.PIT_ASSERT_TRUE,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_is_null(
    p_condition in number,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_is_null(
    p_condition in date,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_not_null(
    p_condition in number,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_not_null(
    p_condition in date,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_EXISTS,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_NOT_EXISTS,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null);


  procedure assert_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2 default null,
    p_message_name in ora_name_type default msg.PIT_ASSERT_DATATYPE,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null,
    p_accept_null in boolean default true);
    

  procedure handle_bulk_errors(
    p_mapping in char_table default null);

end utl_apex;
/

create or replace package body utl_apex
as

  -- Private type declarations
  -- Private constant declarations
  C_ROW_DML_ACTION constant ora_name_type := 'APEX$ROW_STATUS';
  C_INSERT constant char(1 byte) := 'C';
  C_UPDATE constant char(1 byte) := 'U';
  C_DELETE constant char(1 byte) := 'D';

  -- Constants for supported APEX form types
  C_PAGE_FORM constant ora_name_type := 'FORM';
  C_FORM_REGION constant ora_name_type := 'NATIVE_FORM';
  C_IG_REGION constant ora_name_type := 'NATIVE_IG';

  -- Templates used for GET_PAGES etc.
  C_TEMPLATE_TYPE constant ora_name_type := 'APEX_FORM';
  C_TEMPLATE_NAME_FRAME constant ora_name_type := 'FORM_FRAME';
  C_TEMPLATE_NAME_COLUMNS constant ora_name_type := 'FORM_COLUMN';

  C_TEMPLATE_MODE_DYNAMIC constant ora_name_type := 'DYNAMIC';

  C_PARAM_GROUP constant ora_name_type := 'UTL_APEX';
  C_ITEM_PREFIX_CONVENTION constant ora_name_type := 'ITEM_PREFIX_CONVENTION';

  C_DATE constant ora_name_type := 'DATE';
  C_DEFAULT constant ora_name_type := 'DEFAULT';

  g_item_value_convention boolean;
  g_item_prefix_convention binary_integer;
  g_show_item_error apex_error.c_on_error_page%type;

  -- HELPER
  function get_url(
    p_application in varchar2 default null,
    p_page in varchar2 default null,
    p_clear_cache in varchar2 default null,
    p_param_list in varchar2 default null,
    p_value_list in varchar2 default null,
    p_triggering_element in varchar2 default null)
    return varchar2
  as
    l_url utl_apex.max_sql_char;
  begin
    l_url := apex_page.get_url(
               p_application => p_application,
               p_page => p_page,
               p_clear_cache => p_clear_cache,
               p_items => p_param_list,
               p_values => p_value_list,
               p_triggering_element => dbms_assert.enquote_literal(p_triggering_element));
    return l_url;
  end get_url;


  /** Default initialization method */
  procedure initialize
  as
  begin
    g_item_prefix_convention := 1;
    g_item_value_convention := false;
    g_show_item_error := apex_error.c_inline_with_field_and_notif;
  end initialize;


  -- INTERFACE
  function get_apex_version
    return number
  as
  begin
    return UTL_APEX_VERSION;
  end get_apex_version;


  function get_user
    return varchar2
  as
  begin
    return apex_application.g_user;
  end get_user;


  function get_workspace_id(
    p_application_id in number)
    return number
  as
    l_workspace_id apex_applications.workspace_id%type;
  begin
    select workspace_id
      into l_workspace_id
      from apex_applications
     where application_id = p_application_id;
    return l_workspace_id;
  end get_workspace_id;


  function get_application_id(
    p_ignore_translation in flag_type default C_TRUE)
    return number
  as
    l_application_id apex_applications.application_id%type;
  begin
    if p_ignore_translation = C_TRUE then
      l_application_id := apex_application.g_flow_id;
    else
      l_application_id := coalesce(apex_application.g_translated_flow_id, apex_application.g_flow_id);
    end if;
    return l_application_id;
  end get_application_id;


  function get_application_alias
    return varchar2
  as
  begin
    return apex_application.g_flow_alias;
  end get_application_alias;


  function get_page_id(
    p_ignore_translation in flag_type default C_TRUE)
    return number
  as
    l_page_id apex_application_pages.page_id%type;
  begin
    if p_ignore_translation = C_TRUE then
      l_page_id := apex_application.g_flow_step_id;
    else
      l_page_id := coalesce(apex_application.g_translated_page_id, apex_application.g_flow_step_id);
    end if;
    return l_page_id;
  end get_page_id;


  function get_page_alias
    return varchar2
  as
  begin
    return apex_application.g_page_alias;
  end get_page_alias;


  procedure get_page_element(
    p_page_item in ora_name_type,
    p_item out nocopy item_rec)
  as
    l_application_id number;
    l_page_id number;
    l_page_item ora_name_type;
    l_default_date_format ora_name_type;
    l_default_timestamp_format ora_name_type;
    C_ITEM_NAME_BLACKLIST constant char_table := char_table('APEX$ROW_STATUS');
  begin
    pit.enter_detailed('get_page_element',
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item)));

    l_page_item := upper(p_page_item);
    if l_page_item not like get_page_prefix || '%' then
      l_page_item := get_page_prefix || l_page_item;
    end if;

    if l_page_item member of C_ITEM_NAME_BLACKLIST then
      -- Blacklist items are items which cannot be seen in the APEX data dictionary
      -- Just pass their name and value back
      p_item.item_name := p_page_item;
      p_item.item_value := apex_util.get_session_state(p_page_item);
    else
      l_application_id := get_application_id;
      l_page_id := get_page_id;
      l_default_date_format := get_default_date_format;
      l_default_timestamp_format := get_default_timestamp_format;

      pit.debug(msg.PIT_PASS_MESSAGE, msg_args('App: ' || l_application_id || ', Page: ' || l_page_id || ', Item: ' || p_page_item));

      with data as(
            -- page items
            select item_name, label, format_mask, apex_util.get_session_state(item_name) item_value, C_FALSE item_is_column, region_id, null column_id
              from apex_application_page_items
             where application_id = l_application_id
               and page_id = l_page_id
               and item_name = l_page_item
            union all
            -- IG columns
            select name, heading,
                   coalesce(
                    format_mask,
                    case
                      when instr(data_type, 'DATE') > 0 then l_default_date_format
                      when instr(data_type, 'TIMESTAMP') > 0 then l_default_timestamp_format
                    end) format_mask,
                   apex_util.get_session_state(name), C_TRUE, region_id, column_id
              from apex_appl_page_ig_columns
             where application_id = l_application_id
               and page_id = l_page_id
               and name = upper(p_page_item))
      select item_name, label, format_mask, item_value, item_is_column, region_id, column_id
        into p_item.item_name, p_item.item_label, p_item.format_mask, p_item.item_value, p_item.is_column, p_item.region_id, p_item.item_alias -- IG columns without page prefix
        from data
       where rownum = 1;

    end if;

    pit.leave_detailed(
      p_params => msg_params(
                    msg_param('item_name', p_item.item_name),
                    msg_param('item_label', p_item.item_label),
                    msg_param('format_mask', p_item.format_mask),
                    msg_param('item_value', substr(p_item.item_value, 1, 200))));
  exception
    when NO_DATA_FOUND then
      pit.leave_detailed(
        p_params => msg_params(
                      msg_param('Result', 'No item found')));
  end get_page_element;


  function get_page_element(
    p_page_item in ora_name_type)
    return item_rec
  as
    l_item_rec item_rec;
  begin
    get_page_element(p_page_item, l_item_rec);
    return l_item_rec;
  end get_page_element;


  function get_page_prefix
   return varchar2
  is
    C_PAGE_TEMPLATE constant ora_name_type := 'P#PAGE#';
    C_DELIMITER char(1 byte) := '_';
    l_prefix ora_name_type;
  begin
    l_prefix := replace(C_PAGE_TEMPLATE, '#PAGE#', to_char(get_page_id));

    return l_prefix || C_DELIMITER;
  end get_page_prefix;


  function get_session_id
    return number
  as
  begin
    return apex_application.g_instance;
  end get_session_id;


  function get_request
    return varchar2
  as
  begin
    return apex_application.g_request;
  end get_request;


  function get_debug
    return boolean
  as
  begin
    return apex_application.g_debug;
  end get_debug;


  function get_default_date_format(
    p_application_id in number default null)
    return varchar2
  as
    l_date_format apex_applications.date_format%type;
  begin
    return apex_application.g_date_format;
  end get_default_date_format;


  function get_default_timestamp_format(
    p_application_id in number default null)
    return varchar2
  as
    l_timestamp_format apex_applications.timestamp_format%type;
  begin
    return apex_application.g_timestamp_format;
  end get_default_timestamp_format;


  function c_true
    return flag_type
  as
  begin
    return 'Y';
  end c_true;


  function c_false
    return flag_type
  as
  begin
    return 'N';
  end c_false;


  function c_yes
    return ora_name_type
  as
  begin
    return 'YES';
  end c_yes;


  function c_no
    return ora_name_type
  as
  begin
    return 'NO';
  end c_no;


  function get_true
    return flag_type
  as
  begin
    return c_true;
  end get_true;


  function get_false
    return flag_type
  as
  begin
    return c_false;
  end get_false;


  function get_bool(
    p_bool in boolean)
    return flag_type
  as
    l_result flag_type;
  begin
    if p_bool then
      l_result := C_TRUE;
    else
      l_result := C_FALSE;
    end if;
    return l_result;
  end get_bool;


  function get_bool(
    p_bool in flag_type)
    return boolean
  as
  begin
    return p_bool = C_TRUE;
  end get_bool;


  function to_bool(
    p_value in varchar2)
    return flag_type
  as
    l_value varchar(10);
    l_result flag_type;
  begin
    l_value := upper(p_value);
    if l_value in ('J', 'Y', '1') then
      l_result := C_TRUE;
    else
      l_result := C_FALSE;
    end if;
    return l_result;
  end to_bool;


  function get_number(
      p_page_item in varchar2)
      return number
  is
    l_number number;
    l_item item_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item)));

    -- Initialization
    get_page_element(p_page_item, l_item);

    l_number := to_number(l_item.item_value, replace(coalesce(l_item.format_mask, utl_apex.NUMBER_FORMAT_MASK), apex_application.get_nls_group_separator, null));

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', l_number)));
    return l_number;
  exception
    when others then
      pit.handle_exception(msg.PIT_IMPOSSIBLE_CONVERSION, msg_args(l_item.item_value, l_item.format_mask, 'NUMBER'));
      return null;
  end get_number;


  function get_date(
    p_page_item in varchar2)
    return date
  is
    l_date date;
    l_item item_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item)));

    -- Initialization
    get_page_element(p_page_item, l_item);

    -- Conversion
    begin
      l_date := to_date(l_item.item_value, coalesce(l_item.format_mask, utl_apex.get_default_date_format));
    exception when others then
      l_date := to_timestamp_tz(l_item.item_value, apex_application.g_nls_date_format);
    end;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', to_char(l_date, utl_apex.get_default_date_format))));
    return l_date;
  exception
    when others then
      pit.handle_exception(msg.PIT_IMPOSSIBLE_CONVERSION, msg_args(l_item.item_value, l_item.format_mask, 'DATE'));
      return null;
  end get_date;


  function get_string(
    p_page_item in varchar2)
    return varchar2
  is
  begin
    return get_value(p_page_item);
  end get_string;


  function get_boolean(
    p_page_item in varchar2)
    return flag_type
  is
    l_value varchar2(10 byte);
    l_result flag_type;
  begin
    l_value := upper(get_value(p_page_item));
    if l_value in ('1', 'Y', 'J', 'YES', 'JA', 'TRUE', to_char('''' || replace(C_TRUE, '''') || '''')) then
      l_result := C_TRUE;
    else
      l_result := C_FALSE;
    end if;
    return l_result;
  end get_boolean;


  function get_timestamp(
    p_page_item in varchar2)
    return timestamp
  as
    l_timestamp timestamp;
    l_timestamp_tz timestamp with time zone;
    l_item item_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item)));

    -- Initialization
    get_page_element(p_page_item, l_item);


    -- CONVERSION
    begin
      l_timestamp := to_timestamp(l_item.item_value, l_item.format_mask);
    exception when others then
      begin
        l_timestamp := to_timestamp_tz(l_item.item_value, l_item.format_mask);
      exception when others then
        l_timestamp_tz := to_timestamp_tz(l_item.item_value, apex_application.g_nls_timestamp_tz_format);
      end;
    end;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', to_char(coalesce(l_timestamp, l_timestamp_tz), utl_apex.get_default_timestamp_format))));
    return coalesce(l_timestamp, l_timestamp_tz);
  exception
    when others then
      pit.handle_exception(msg.PIT_IMPOSSIBLE_CONVERSION, msg_args(l_item.item_value, l_item.format_mask, 'TIMESTAMP'));
      return null;
  end get_timestamp;


  function get_value(
    p_page_item in varchar2)
    return varchar2
  as
    l_item item_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item)));

    get_page_element(p_page_item, l_item);

    if l_item.item_value is null and g_item_value_convention then
      pit.assert_not_null(l_item.item_name, msg.UTL_APEX_MISSING_ITEM, msg_args(p_page_item, to_char(get_page_id)));
    end if;

    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Value', substr(l_item.item_value, 1, 200))));
    return l_item.item_value;
  exception
    when msg.UTL_APEX_MISSING_ITEM_ERR then
      pit.handle_exception(msg.PIT_SQL_ERROR);
      raise;
  end get_value;


  procedure set_value(
    p_page_item in varchar2,
    p_value in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_page_item', p_page_item),
                    msg_param('p_value', substr(p_value, 1, 200))));

    apex_util.set_session_state(p_page_item, p_value);

    pit.leave_mandatory;
  exception
    when others then
      pit.leave_mandatory;
      pit.error(msg.UTL_APEX_MISSING_ITEM, msg_args(p_page_item, to_char(get_page_id)));
  end set_value;


  function get_app_value(
    p_app_item in varchar2)
    return varchar2
  as
    l_value max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_app_item', p_app_item)));

    l_value := apex_util.get_session_state(p_app_item);

    pit.leave_mandatory;
    return l_value;
  end get_app_value;

  procedure set_app_value(
    p_app_item in varchar2,
    p_value in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_app_item', p_app_item),
                    msg_param('p_value', substr(p_value, 1, 200))));

    apex_util.set_session_state(p_app_item, p_value);

    pit.leave_mandatory;
  end set_app_value;


  procedure set_success_message(
    p_message in ora_name_type,
    p_msg_args in msg_args default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_message', p_message)));

    apex_application.g_print_success_message := pit.get_message_text(p_message, p_msg_args);

    pit.leave_mandatory;
  end set_success_message;


  function user_is_authorized(
    p_authorization_scheme in varchar2)
    return flag_type
  as
    l_result flag_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_authorization_scheme', p_authorization_scheme)));

    l_result := get_bool(apex_authorization.is_authorized(p_authorization_scheme));

    pit.leave_optional(msg_params(msg_param('is authorized', l_result)));
    return l_result;
  exception
    when others then
      pit.leave_optional(msg_params(msg_param('Error', substr(sqlerrm, 12))));
      return C_FALSE;
  end user_is_authorized;


  function current_user_in_group(
    p_group_name in varchar2)
    return utl_apex.flag_type
  is
  begin
    return get_bool(apex_util.current_user_in_group(p_group_name));
  end current_user_in_group;


  function get_last_login
    return date
  as
    l_last_login_date date;
  begin
    pit.enter_detailed;

    select min(access_date) access_date
      into l_last_login_date
      from (select access_date, rank() over (order by access_date desc) rang
              from wwv_flow_user_access_log
             where authentication_result = 0
               and login_name = (select v('APP_USER') from dual));

     pit.leave_detailed(
        p_params => msg_params(
                      msg_param('LastLogin', to_char(l_last_login_date, 'dd.mm.yyyy hh24:mi:ss'))));
     return l_last_login_date;
  exception
    when no_data_found then
      pit.leave_detailed;
      return null;
  end get_last_login;


  function validate_simple_sql_name(
    p_name in ora_name_type)
    return ora_name_type
  as
    C_UMLAUT_REGEX constant ora_name_type := '[^QWERTZUIOPASDFGHJKLYXCVBNM1234567890$_]';
    -- TODO: Take this length from PIT
    C_MAX_LENGTH constant number := 26;
    l_name ora_name_type;
    l_error_message max_sql_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_name', p_name)));

    -- exclude names with double quotes
    l_name := upper(replace(p_name, '"'));

    -- exclude names with umlauts
    pit.assert(
       p_condition => regexp_instr(l_name, C_UMLAUT_REGEX) = 0,
       p_message_name => msg.UTL_APEX_NAME_CONTAINS_UMLAUT,
       p_msg_args => msg_args(l_name));

    -- limit length according to naming conventions
    pit.assert(
       p_condition => length(l_name) <= C_MAX_LENGTH,
       p_message_name => msg.UTL_APEX_NAME_TOO_LONG,
       p_msg_args => msg_args(l_name, to_char(C_MAX_LENGTH)));

    -- name against Oracle naming conventions. Throws errors, so catch them rather than use ASSERT
    begin
       l_name := dbms_assert.simple_sql_name(l_name);
    exception
       when others then
          pit.error(msg.UTL_APEX_NAME_INVALID, msg_args(l_name));
    end;

    pit.leave_optional(msg_params(msg_param('Result', 'OK')));
    return null;
  exception
    when others then
      l_error_message := substr(sqlerrm, 12);
      pit.leave_optional(msg_params(msg_param('Result', l_error_message)));
      return l_error_message;
  end validate_simple_sql_name;


  procedure set_error(
    p_page_item in ora_name_type,
    p_message in ora_name_type default null,
    p_msg_args in msg_args default null,
    p_region_id in ora_name_type default null)
  as
    l_message message_type;
    l_rownum number;
    l_application_id number;
    l_page_id number;
    l_primary_key max_char;
    l_region_Id number;
    l_source_type ora_name_type;
    l_item item_rec;
  begin
    pit.enter_optional(p_params => msg_params(
      msg_param('p_page_item', p_page_item),
      msg_param('p_message', p_message)));

    if p_page_item is not null then
      get_page_element(p_page_item, l_item);
    end if;
    if p_message is null then
      l_message := pit.get_active_message;
    else
      l_message := pit.get_message(p_message, p_msg_args);
    end if;
    l_message.message_text := replace(l_message.message_text, '#LABEL#', l_item.item_label);

    case
      when p_region_id is not null then
        -- Detect type of region to adjust the error message
        l_application_id := get_application_id;
        l_page_id := get_page_id;

        select r.region_id, r.source_type_code, apex_util.get_session_state(i.primary_key_item)
          into l_region_Id, l_source_type, l_primary_key
          from apex_application_page_regions r
          left join (
               select region_id, source_expression primary_key_item
                 from apex_appl_page_ig_columns
                where application_id = l_application_id
                  and page_id = l_page_id
                  and is_primary_key = 'Yes') i
            on r.region_id = i.region_id
         where application_id = l_application_id
           and page_id = l_page_id
           and static_id = p_region_id;

        case l_source_type
          when C_IG_REGION then
            pit.warn(msg.PIT_PASS_MESSAGE, msg_args('Handling IG errors in UTL_APEX is not yet supported due to a missing API for it'));
        else
          -- Fallback, works as if P_REGION_ID is NULL
          if p_page_item is not null then
            apex_error.add_error(
              p_message => replace(l_message.message_text, '#LABEL#', l_item.item_label),
              p_additional_info => l_message.message_description,
              p_display_location => apex_error.c_inline_with_field_and_notif,
              p_page_item_name => l_item.item_name);
          else
            apex_error.add_error(
              p_message => l_message.message_text,
              p_additional_info => l_message.message_description,
              p_display_location => apex_error.c_inline_in_notification);
          end if;
        end case;
      when p_page_item is not null then
        apex_error.add_error(
          p_message => replace(l_message.message_text, '#LABEL#', l_item.item_label),
          p_additional_info => l_message.message_description,
          p_display_location => apex_error.c_inline_with_field_and_notif,
          p_page_item_name => l_item.item_name);
      else
        apex_error.add_error(
          p_message => l_message.message_text,
          p_additional_info => l_message.message_description,
          p_display_location => apex_error.c_inline_in_notification);
    end case;

    pit.leave_optional;
  exception
    when msg.PIT_ASSERT_IS_NOT_NULL_ERR then
      -- Assertion is violated if no error was passed in. Accept this as a sign that no error has occurred
      pit.leave_optional;
  end set_error;


  procedure set_error(
    p_test in boolean,
    p_page_item in ora_name_type,
    p_message in ora_name_type default null,
    p_msg_args in msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_test', get_bool(p_test)),
                    msg_param('p_page_item', p_page_item),
                    msg_param('p_message', p_message)));

    if not p_test then
      set_error(p_page_item, p_message, p_msg_args, p_region_id);
    end if;

    pit.leave_optional;
  end set_error;


  function inserting
   return boolean
  is
    C_INSERT_WHITELIST constant char_table := char_table('CREATE', 'CREATE_AGAIN', 'INSERT', 'CREATEAGAIN');
    C_INSERT_FLAG constant char(1 byte) := 'C';
    l_result boolean := false;
    l_item_value_convention boolean := g_item_value_convention;
  begin
    pit.enter_optional;

    -- Switch item_value_convention off to avoid exceptions when checking C_ROW_DML_ACTION and no IG is present
    g_item_value_convention := false;
    -- Starting with version 5.1, insert might be detected by using C_ROW_DML_ACTION in interactive Grid or Form regions (>= 19.1)
    -- CAVE: Don't refactor to GET_VALUE instead of APEX_UTIL.GET_SESSION_STATE as C_ROW_DML_ACTION is no page item
    if get_request member of C_INSERT_WHITELIST or apex_util.get_session_state(C_ROW_DML_ACTION) = C_INSERT_FLAG then
      l_result := true;
    end if;

    -- reset item value convention
    g_item_value_convention := l_item_value_convention;

    pit.leave_optional(msg_params(msg_param('Result', get_bool(l_result))));
    return l_result;
  end inserting;


  function updating
   return boolean
  is
    C_UPDATE_WHITELIST constant char_table := char_table('SAVE', 'APPLY CHANGES', 'UPDATE', 'UPDATE ROW', 'CHANGE', 'APPLY');
    C_UPDATE_FLAG constant char(1 byte) := 'U';
    l_result boolean := false;
    l_item_value_convention boolean := g_item_value_convention;
  begin
    pit.enter_optional;

    -- Switch item_value_convention off to avoid exceptions when checking C_ROW_DML_ACTION and no IG is present
    g_item_value_convention := false;

    -- Starting with version 5.1, insert might be detected by using C_ROW_DML_ACTION in interactive Grid or Form regions (>= 19.1)
    -- CAVE: Don't refactor to GET_VALUE instead of APEX_UTIL.GET_SESSION_STATE as C_ROW_DML_ACTION is no page item
    if get_request member of C_UPDATE_WHITELIST or apex_util.get_session_state(C_ROW_DML_ACTION) = C_UPDATE_FLAG then
      l_result := true;
    end if;

    -- rest item value convntion
    g_item_value_convention := l_item_value_convention;

    pit.leave_optional(msg_params(msg_param('Result', get_bool(l_result))));
    return l_result;
  end updating;


  function deleting
   return boolean
  is
    C_DELETE_WHITELIST constant char_table := char_table('DELETE', 'REMOVE', 'DELETE ROW', 'DROP');
    C_DELETE_FLAG constant char(1 byte) := 'D';
    l_result boolean := false;
    l_item_value_convention boolean := g_item_value_convention;
  begin
    pit.enter_optional;

    -- Switch item_value_convention off to avoid exceptions when checking C_ROW_DML_ACTION and no IG is present
    g_item_value_convention := false;

    -- Starting with version 5.1, insert might be detected by using C_ROW_DML_ACTION in interactive Grid or Form regions (>= 19.1)
    -- CAVE: Don't refactor to GET_VALUE instead of APEX_UTIL.GET_SESSION_STATE as C_ROW_DML_ACTION is no page item
    if get_request member of C_DELETE_WHITELIST or apex_util.get_session_state(C_ROW_DML_ACTION) = C_DELETE_FLAG then
      l_result := true;
    end if;

    -- rest item value convntion
    g_item_value_convention := l_item_value_convention;

    pit.leave_optional(msg_params(msg_param('Result', get_bool(l_result))));
    return l_result;
  end deleting;


  function request_is(
    p_request in varchar2)
    return boolean
  as
    l_result boolean;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_request', p_request)));

    l_result := upper(get_request) = upper(p_request);

    pit.leave_optional(msg_params(msg_param('Result', get_bool(l_result))));
    return l_result;
  end request_is;


  procedure unhandled_request
  as
  begin
    pit.error(msg.UTL_APEX_INVALID_REQUEST, msg_args(get_request));
  end unhandled_request;


  function get_page_url(
    p_application in varchar2 default null,
    p_page in varchar2 default null,
    p_param_items in varchar2 default null,
    p_value_items in varchar2 default null,
    p_value_list in varchar2 default null,
    p_triggering_element in varchar2 default null,
    p_clear_cache in binary_integer default null)
    return varchar2
  as
    l_url max_sql_char;
    l_param_values char_table;
    l_param_list max_sql_char;
    l_value_list max_sql_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_param_items', p_param_items),
                    msg_param('p_value_items', p_value_items),
                    msg_param('p_application', p_application),
                    msg_param('p_page', p_page),
                    msg_param('p_triggering_element', p_triggering_element)));

    l_param_list := replace(p_param_items, ':', ',');
    if p_value_items is not null then
      utl_text.string_to_table(p_value_items, l_param_values);
      for i in 1 .. l_param_values.count loop
        l_value_list := l_value_list || case when i > 1 then ',' end || get_value(l_param_values(i));
      end loop;
    else
      l_value_list := p_value_list;
    end if;

    l_url := get_url(
               p_application => p_application,
               p_page => p_page,
               p_clear_cache => p_clear_cache,
               p_param_list => l_param_list,
               p_value_list => l_value_list,
               p_triggering_element => p_triggering_element);

    pit.leave_optional(p_params => msg_params(msg_param('URL', l_url)));
    return l_url;
  end get_page_url;


  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2,
    p_mime_type in varchar2 default 'application/octet-stream')
  as
    l_blob blob := p_blob;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_blob.length', to_char(dbms_lob.getlength(p_blob))),
                    msg_param('p_file_name', p_file_name),
                    msg_param('p_mime_type', p_mime_type)));

    -- Write http header
    htp.init;
    owa_util.mime_header(p_mime_type, false, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(p_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;

    wpg_docload.download_file(l_blob);

    apex_application.stop_apex_engine;
    pit.leave_mandatory;
  exception
    when apex_application.e_stop_apex_engine then
      null;
    when others then
      htp.p('error: ' || sqlerrm);
      apex_application.stop_apex_engine;
  end download_blob;


  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2,
    p_mime_type in varchar2 default 'application/octet-stream')
  as
    l_blob blob;
  begin
    pit.enter_optional;
    l_blob := utl_text.clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name, p_mime_type);
    pit.leave_optional;
  end download_clob;


  procedure assert(
    p_condition in boolean,
    p_message_name in ora_name_type default msg.PIT_ASSERT_TRUE,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  is
  begin
    pit.enter_optional;
    pit.assert(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert;


  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_is_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_is_null;


  procedure assert_is_null(
    p_condition in number,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_is_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_is_null;


  procedure assert_is_null(
    p_condition in date,
    p_message_name in ora_name_type default msg.PIT_ASSERT_IS_NULL,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_is_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_is_null;


  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_not_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_not_null;


  procedure assert_not_null(
    p_condition in number,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_not_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_not_null;


  procedure assert_not_null(
    p_condition in date,
    p_message_name in ora_name_type default msg.UTL_APEX_PARAMETER_REQUIRED,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  as
  begin
    pit.enter_optional;
    pit.assert_not_null(
      p_condition => p_condition,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_not_null;


  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_EXISTS,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  is
  begin
    pit.enter_optional;
    pit.assert_exists(
      p_stmt => p_stmt,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_exists;


  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in ora_name_type default msg.PIT_ASSERT_NOT_EXISTS,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null)
  is
  begin
    pit.enter_optional;
    pit.assert_not_exists(
      p_stmt => p_stmt,
      p_message_name => p_message_name,
      p_msg_args => p_msg_args);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_not_exists;


  procedure assert_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2 default null,
    p_message_name in ora_name_type default msg.PIT_ASSERT_DATATYPE,
    p_page_item in ora_name_type default null,
    p_msg_args msg_args default null,
    p_region_id in ora_name_type default null,
    p_accept_null in boolean default true)
  as
  begin
    pit.enter_optional;
    pit.assert_datatype(
      p_value => p_value,
      p_type => p_type,
      p_format_mask => p_format_mask,
      p_message_name => p_message_name,
      p_msg_args => coalesce(p_msg_args, msg_args(p_value, p_type)),
      p_accept_null => p_accept_null);
    pit.leave_optional;
  exception
    when others then
      set_error(
        p_page_item => p_page_item,
        p_message => p_message_name,
        p_region_id => p_region_id);
      pit.leave_optional;
  end assert_datatype;


  procedure handle_bulk_errors(
    p_mapping in char_table default null)
  as
    type error_code_map_t is table of ora_name_type index by ora_name_type;
    l_error_code_map error_code_map_t;
    l_error_code ora_name_type;
    l_message_list pit_message_table;
    l_message message_type;
    l_item item_rec;
  begin
    pit.enter_optional;
    l_message_list := pit.get_message_collection;

    if l_message_list.count > 0 then
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then
            l_error_code_map(upper(p_mapping(i))) := upper(p_mapping(i+1));
          end if;
        end loop;
      end if;

      for i in 1 .. l_message_list.count loop
        l_message := l_message_list(i);
        if l_message.severity in (pit.level_fatal, pit.level_error) then
          pit.verbose(msg.PIT_PASS_MESSAGE, msg_args('Error occured'));
          l_error_code := upper(l_message.error_code);
          if l_error_code_map.exists(l_error_code) then
            get_page_element(l_error_code_map(l_error_code), l_item);
            if get_bool(l_item.is_column) then
              apex_error.add_error(
                p_message => replace(l_message.message_text, '#LABEL#', l_item.item_label),
                p_additional_info => l_message.message_description,
                p_display_location => apex_error.c_inline_with_field_and_notif,
                p_region_id => l_item.region_id,
                p_column_alias => l_item.item_alias,
                p_row_num => 2);
            else
              if l_item.item_label is not null then
                apex_error.add_error(
                  p_message => replace(l_message.message_text, '#LABEL#', l_item.item_label),
                  p_additional_info => l_message.message_description,
                  p_display_location => g_show_item_error,
                  p_page_item_name => l_item.item_name);
              else
                apex_error.add_error(
                  p_message => l_message.message_text,
                  p_additional_info => l_message.message_description,
                  p_display_location => apex_error.c_inline_in_notification,
                  p_page_item_name => l_item.item_name);
              end if;
            end if;
          else
            pit.warn(msg.PIT_PASS_MESSAGE, msg_args('No mapping found for error code ' || l_error_code));
            apex_error.add_error(
              p_message => l_message.message_text,
              p_additional_info => l_message.message_description,
              p_display_location => apex_error.c_inline_in_notification);
          end if;
        end if;
      end loop;
    end if;

    pit.leave_optional;
  end handle_bulk_errors;

begin
  initialize;
end utl_apex;
/


prompt * VIEWS
prompt -  PIT_MESSAGE_LANGUAGE_V
create or replace view pit_message_language_v as
select 'AMERICAN' pml_name, 'AMERICAN' pml_display_name, 10 pml_default_order, 1 pml_rank
  from dual;
  
prompt -  PIT_TRANSLATABLE_ITEM_V
create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from (select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description,
               rank() over (partition by pti_id, pti_pmg_name order by pml_default_order desc) ranking
          from pd_pit_translatable_item
          join pit_message_language_v
            on pti_pml_name = pml_name
         where -- try to find available translation or fallback to default language
               pml_name = substr(sys_context('USERENV', 'LANGUAGE'), 1, instr(sys_context('USERENV', 'LANGUAGE'), '_') -1)
            or pml_default_order = 10)
 where ranking = 1;
  
prompt -  PIT_MESSAGE_SEVERITY
create or replace view pit_message_severity_v as
select pse_id, pse_pti_id pse_name, pti_display_name pse_display_name, pti_description pse_description
  from (select 10	pse_id, 'LEVEL_OFF' pse_pti_id from dual union all
        select 20, 'LEVEL_FATAL' from dual union all
        select 30, 'LEVEL_ERROR' from dual union all
        select 40, 'LEVEL_WARN' from dual union all
        select 50, 'LEVEL_INFO' from dual union all
        select 60, 'LEVEL_DEBUG' from dual union all
        select 70, 'LEVEL_ALL	LEVEL_ALL' from dual)
  join pit_translatable_item_v
    on pse_pti_id = pti_id;
    

prompt -  PIT_MESSAGE_V
create or replace view pit_message_v as
with deflt as (
       select pms_name, pms_pml_name, pms_pmg_name, pms_text, pms_description, pms_pse_id, 
              pms_active_error
         from pd_pit_message
        where pms_id is not null),
     trans as (
       select pms_name, pms_pml_name, pms_text, pms_description
         from pd_pit_message
         join pit_message_language_v
           on pms_pml_name = pml_name
        where pml_rank = 1)
select d.pms_name,
       d.pms_pmg_name,
       coalesce(t.pms_pml_name, d.pms_pml_name) pms_pml_name, 
       coalesce(t.pms_text, d.pms_text) pms_text, 
       coalesce(t.pms_description, d.pms_description) pms_description, 
       d.pms_pse_id,
       d.pms_active_error
  from deflt d
  left join trans t
    on d.pms_name = t.pms_name;
    
prompt -  PIT_TRACE_LEVEL_V
create or replace view pit_trace_level_v as
select ptl_id, ptl_pti_id ptl_name, pti_display_name ptl_display_name, pti_description ptl_description
  from (select 50 ptl_id, 'TRACE_ALL' ptl_pti_id from dual union all
        select 40, 'TRACE_DETAILED' from dual union all
        select 20, 'TRACE_MANDATORY' from dual union all
        select 10, 'TRACE_OFF' from dual union all
        select 30, 'TRACE_OPTIONAL' from dual)
  join pit_translatable_item_v
    on ptl_pti_id = pti_id;

prompt * MESSAGES
prompt - Oracle Messages
begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ORACLE',
    p_pmg_description => q'^Messages for Oracle errors^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'CHILD_RECORD_FOUND',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^The record could not be deleted, dependent records exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -2292);

  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^A conversion could not be carried out^',
    p_pms_description => q'^^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Invalid date: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1858);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE_FORMAT',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Invalid date format: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1861);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE_LENGTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Invalid length of the date: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1840);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DAY',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1847);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DAY_FOR_MONTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1839);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_MONTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1843);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_NUMBER_FORMAT',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Invalid payment format: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1481);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_YEAR',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1841);

  commit;
end;
/

prompt -  PIT Messages
begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_DATATYPE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# is not of data type #2#.^',
    p_pms_description => q'^An unsuccessful attempt was made to convert a value to the specified data type. Check the value.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion failed.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return rows, but did not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# was expected, but was null.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be null, but was [#1#].^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return no rows, but did.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be equal, but was not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CASE_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# not found when executing CASE statement^',
    p_pms_description => q'^An option was passed for which no handler was present in a CASE statement and which does not contain an ELSE branch.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context set to ##1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context ##1# created and added to the available contexts list.^',
    p_pms_description => q'^A context collects log settings under one name.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error initializing a new context.^',
    p_pms_description => q'^As a rule, a context cannot be initialized if invalid settings were passed for the individual parameters.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Default Context could not be created.^',
    p_pms_description => q'^The default context is created by initialization parameters. Make sure that no invalid entries are contained there.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context #1# does not exist. Please provide a valid context name that is controlled by #2#.^',
    p_pms_description => q'^Create a context using UTL_CONTEXT.CREATE_CONTEXT before you use it^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tried to call context ##1# but it is not existing.^',
    p_pms_description => q'^Create a context using PIT_ADMIN.CREATE_NAMED_CONTEXT before you use it^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context cannot be null. Please provide a valid context name.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_IMPOSSIBLE_CONVERSION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid conversion of element value "#1#" and format mask "#2#" to type #3#.^',
    p_pms_description => q'^The element value could not be converted correctly when automatically determining a date or numeric value.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_LONG_OP_WO_TRACE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Use of PIT.LONG_OP requires PIT.ENTER/LEAVE usage.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Requested change requires admin mode.^',
    p_pms_description => q'^To make changes, you must be logged in as administrator.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The requested parameter #1# doesn't exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter-Group does not allow for new parameters.^',
    p_pms_description => q'^Parameter groups can prohibit changes by the end user. This is the case here, the parameters cannot be changed.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# does not exist.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# is not allowed to be changed.^',
    p_pms_description => q'^A parameter can be defined as not changeable, in contrast to the settings of the parameter group. This is the case here.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^An error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_ERROR is raised, this error is thrown.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_FATAL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A fatal error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_FATAL is raised, this error is thrown.^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#^',
    p_pms_description => q'^This message is output when a procedure or function is called.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#, Params: #2#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Leaving: #1#^',
    p_pms_description => q'^This message is issued when a procedure or function is left.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CONTEXT_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The context #1# does not exist. Please create it in advance.^',
    p_pms_description => q'^A toggle must reference an existing context, otherwise the output will not work.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^he message #1# you entered already exists.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log message "#1#" could not be created.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error purging the message stack.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# received an error during installation: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error reading the list of modules.^',
    p_pms_description => q'^The list of modules includes all installed, initialized or active output modules. This list was empty here.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Finished initialization at #1#. Loaded modules: [#2#]^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been succesfully instantiated.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list has been successfully loaded.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^At least one output module must be specified.^',
    p_pms_description => q'^If no output module has been defined in the current context that can be initialized, PIT cannot output any messages. Make sure that at least one module can be reached.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# was terminated due to an error.^',
    p_pms_description => q'^If an error occurs during the initialization of a module, the module is deactivated. Other modules continue to operate normally.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been requested, but is not available.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Message #1# does not exist. Call PIT using Package MSG to avoid this error.^',
    p_pms_description => q'^A message must be created by procedure PIT_ADMIN.MERGE_MESSAGE. Then method PIT_ADMIN.CREATE_MESSAGE_PACKAGE must be called to update package MSG.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NAME_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The identifier exceeds the maximum length of #1# characters.^',
    p_pms_description => q'^A maximum length is specified for an identifier. This length is currently exceeded.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# was expected to be in (#2#) but was #3#.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list read succesfully.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Named context #1# does not exist.^',
    p_pms_description => q'^A context should be used that does not exist. Use PIT_ADMIN.CREATE_NAMED_CONTEXT to create a context^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NO_CONTEXT_SETTINGS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^No settings for logging could be found.^',
    p_pms_description => q'^An attempt was made to read values for logging from the gloable context. But this failed. Check whether PIT is correctly initialized.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^SQL Error occurred: #SQLERRM#^',
    p_pms_description => q'^General error message. For more information, see the message parameter.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'WEBSOCKET_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Neither prefix nor postfix for error messages were specified.^',
    p_pms_description => q'^A message group needs a flag for errors. These are taken from the default, but must not be NULL. At least one value must be assigned.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_INVALID',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The length of prefix and postfix together must not exceed 12 characters and at least prefix or postfix must be defined.^',
    p_pms_description => q'^The prefix and/or postfix for error names must remain below a maximum length to avoid problems with the naming convention.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The message "#1#" must not be longer than #2# characters, but has the length #3#.^',
    p_pms_description => q'^The length restriction applies because of the length of exception prefixes and postfixes to be added.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_PREDEFINED_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The error number #1# is a predefined Oracle error named #2# in #3#.#4#. Please do not overwrite Oracle predefined errors.^',
    p_pms_description => q'^By overwriting a predefined error, it will no longer be trapped under its name.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The #LABEL# element is a mandatory element.^',
    p_pms_description => q'^Obviously.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_SQL_NAME',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid SQL name. #1#. Please specify a name that conforms to Oracle naming conventions.^',
    p_pms_description => q'^Since some identifiers are also used as Oracle names (for example, as constants), they must conform to Oracle naming conventions.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  commit;
end;
/
