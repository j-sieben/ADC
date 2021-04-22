begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'ADC',
    p_pgr_description => 'ADC Parameters',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'RAISE_RECURSION_LOOP'
   ,p_par_pgr_id => 'ADC'
   ,p_par_description => 'Flag to indicate whether exceeding the max recursion depth raises an exception (TRUE) or not (FALSE)'
   ,p_par_boolean_value => true
  );

  param_admin.edit_parameter(
    p_par_id => 'RECURSION_LIMIT'
   ,p_par_pgr_id => 'ADC'
   ,p_par_description => 'Amount of recursive levels before ADC stops further recursion'
   ,p_par_integer_value => 10
  );

  commit;
end;
/
