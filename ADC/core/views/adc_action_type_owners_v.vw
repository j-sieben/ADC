create or replace force view adc_action_type_owners_v as
select cato_id, cato_description, cato_active
  from adc_action_type_owners;