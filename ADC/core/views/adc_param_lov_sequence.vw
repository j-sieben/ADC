create or replace view adc_param_lov_sequence
as 
select sequence_name d, sequence_name r, null cgr_id
  from user_sequences;
