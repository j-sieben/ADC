create or replace editionable view adc_ui_lov_yes_no 
as 
select 'Ja' d, adc_util.c_true r from dual union all
select 'Nein', adc_util.c_false r from dual;
