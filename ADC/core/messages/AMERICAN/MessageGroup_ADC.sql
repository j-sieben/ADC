begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^ADC Plugin messages^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^ADC action #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_EXECUTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Execute action #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_info,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_REJECTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Action #1# was not executed because there was an error and this action is not an error handler.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Integration of the page actions^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_UNKNOWN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX action #1# does not exist.^',
    p_pms_description => q'^When validating a parameter of type APEX_ACTION, a non-existent APEX action was referenced.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX application #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The rule group already exists. Choose a unique name.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The name of the rule group must be unique for this application.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DATE_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Datum element #1# set to value #2#, string value: #3#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_info,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#// Dynamically generated JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ERROR_HANDLING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^error occurred in recursion #1#, rule #2# (#3#), triggering element: "#4#", execute error handling^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_EXPECTED_FORMAT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Expected format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_FIRING_ITEM_PUSHED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# was written to the stack on recursion #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_GENERIC_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^"#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INFINITE_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Loop #1# has exceeded the maximum allowed number of passes and has been aborted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRG_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialization of rule group #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRU_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialization of the single rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INIT_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule #1# (#2#), additionally triggered on page load^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INTERNAL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^An error has occurred on the page: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_DATE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid date: #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_DEBUG_LEVEL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The debug level is not allowed, just use adc_util.C_JS_CODE, adc_util.C_JS_DEBUG, adc_util.C_JS_COMMENT or adc_util.C_JS_DETAIL.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_JQUERY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The selector "#1#" is not used on the page.^',
    p_pms_description => q'^When validating a jQuery selector, it must be present on the page.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid number. Expected format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER_REMOVED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid number removed: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_PAGE_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The page element "#1#" is not used on the page.^',
    p_pms_description => q'^When validating an element name, it must be present on the page.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SEQUENCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The sequence "#1#" does not exist.^',
    p_pms_description => q'^A non-existent sequence was referenced.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error in technical condition: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page element #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#LABEL# is a mandatory element. Please enter a value.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY_DEFAULT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #LABEL# is a mandatory element. Please enter a value.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when merging rule #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when merging rule action #1#, #2#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when merging rule group #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_METHOD_PARSE_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^A parse error was raised when validating a method. Correct the method.^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace "#1#" and alias "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No JavaScript code for rule "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No JavaScript action^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No use case found for the current page status^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace #1# and application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_info,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NUMBER_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Number element #1# set to value #2#, string value: #3#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_info,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ONE_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exactly one of the fields #1# and #2# is mandatory.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_CLIPPED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Another JavaScript action suppressed because too long^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_REDUCED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Output reduced to level #1# because of length^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX application page #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fix all page errors before sending.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_INCORRECT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The LOV view #1# does not have the specified columns D, R and CRG_ID.^',
    p_pms_description => q'^For a LOV view to be used, it must have exactly 3 columns with the identifiers D, R and CRG_ID.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The parameter type #1# requires a LOV view of the name #2#. This is missing.^',
    p_pms_description => q'^A parameter type that requires a LOV list requires a corresponding LOV view so that the required data can be determined.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Field #LABEL# is a mandatory field.^',
    p_pms_description => q'^The input field is a mandatory parameter and must therefore be filled.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_VALIDATION_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^When validating a parameter value, it is checked for plausibility, depending on its type. The incorrect parameter value must be corrected.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARSE_JSON',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error parsing JSON: #SQLERRM#.^',
    p_pms_description => q'^Errors occurred while parsing a JSON instance. Correct the JSON instance and try again.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_CODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL code: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error executing PL/SQL code #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PROCESSING_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Create action for rule #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LIMIT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# has exceeded recursion depth of #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# created a recursive loop at recursion depth #2# and was therefore ignored.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ACTION_EXISTS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^This combination of attributes of a rule action already exists.^',
    p_pms_description => q'^The attributes CRA_CRG_ID, CRA_CRU_ID, CRA_CPI_ID, CRA_CAT_ID and CRA_ON_ERROR must be unique.^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Recursion #1#, Run #2#: Rule #3# (If the user #4#), Triggering element: "#5#"#6| (Value: |)|#, Duration: #TIME#hsec^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VALIDATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error validating rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group view #1# was created.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group view #1# has been deleted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_SESSION_STATE_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element ~#1#~ was set to the value ~#2#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STANDARD_JS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Standard ADC JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^JavaScript code "#1#" was not considered because there was an error and the rule was stopped.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_PLSQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL code was not executed because there was an error and the rule was stopped.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_warn,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group #1# is already on application #2#, page #3# and cannot be copied over itself.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unexpected element type ~#1#~ with format mask.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error executing "#1#", cannot continue work.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_CPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unbekannter Parametertyp: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Export type #1# is unknown.^',
    p_pms_description => q'^An unsupported export type was requested. Only use the constants C_%_GROUP(S).^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group #1# successfully created^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error creating Decision Table #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_WHERE_CLAUSE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while generating the WHERE clause: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_error,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_all,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^A conversion could not be executed^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_fatal,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_1',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 1: Remove the REQUIRED flags and mark each element as incorrect, this will be corrected later.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_2',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 2: Merge APEX page items into ADC_PAGE_ITEMS^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_3',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 3: mark page items referenced in a technical condition as relevant^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_4',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 4: remove elements which are irreleveant, erroneus, not referenced^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_5',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 5: Mark errors in adc_rules and ADC_RULE_ACTION and reset all error flags for rule to FALSE^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_6',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 6: Mark rules that refer to elements with an error flag^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_7',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 7: Reset all error flags for rule actions to FALSE^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_8',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 8: Mark rule actions that refer to elements with an error flag^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_9',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 9: Re-create initialization code for fast page initialization and store it in table adc_rule_groups^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.level_debug,
    p_pms_pml_name => 'AMERICAN');
    
  commit;
  pit_admin.create_message_package;
end;
/