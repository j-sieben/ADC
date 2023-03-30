set define off

begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'SADC',
    p_pmg_description => q'^Translatable Items for the ADC Sample Application^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'SADC_INVALID_NUMBER',
    p_pms_text => 'Die Zahl muss zwischen 100 und 1000 liegen und durch 3 teilbar sein.',
    p_pms_pse_id => pit.level_error,
    p_pms_description => null,
    p_pms_pmg_name => 'SADC',
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);
  

  pit_admin.merge_message(
    p_pms_name => 'SADC_INVALID_DATE',
    p_pms_text => 'Das Datum muss in der Zukunft liegen und ein Arbeitstag sein.',
    p_pms_pse_id => pit.level_error,
    p_pms_description => null,
    p_pms_pmg_name => 'SADC',
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);
    
  commit;
  
  pit_admin.create_message_package;
end;
/

set define on