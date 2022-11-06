create or replace force view adc_param_lov_sequence
as
select sequence_name d, sequence_name r, null crg_id
  from user_sequences
       -- exclude column identity sequences
 where sequence_name not like 'ISEQ$$%';
  
  
comment on table adc_param_lov_sequence is 'List of sequences owned by the user';