begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^ADC Plugin messages^');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^A conversion could not be executed^',
    p_pms_description => q'^^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^ADC action #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX application #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#// Dynamically generated JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ERROR_HANDLING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// Error at #1#: #2# (#3#), Firing Item: "#4#", proceed with error actions^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_EXPECTED_FORMAT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Expected format "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_GENERIC_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^"#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CGR_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialization of rule group #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRU_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialization of single rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INIT_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// Rule #1# (#2#), fired on page load^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INTERNAL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^An error has occurred on the page: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_FORMAT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid date. Expected format: "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1861);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid number. Expected format: "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER_REMOVED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid number removed: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page item "#1#" does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page item "#1#" is mandatory. Please provide a valid value.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when merging rule #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when merging rule action #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when merging rule group #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace "#1#" and alias "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// No JavaScript code for rule "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// No JavaScript action^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace #1# and application alias #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ONE_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exactly one of the fields #1# and #2# is mandatory.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_CLIPPED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'// Further JavaScript action suppressed, because too long^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_REDUCED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'// Output reduced to level #1# due to length'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX page #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page contains errors. Please solve open errors before submit.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARSE_JSON',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while parsing JSON: #SQLERRM#.^',
    p_pms_description => q'^Errors occurred while parsing a JSON instance. Correct the JSON instance and try again.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PROCESSING_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Creating action for rule #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LIMIT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page item "#1#" has exceeded recursion depth #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page item "#1#" has created a recursion loop at depth #2# and was ignored.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// Recursion #1#: #2# (#3#), Firing Item: "#4#", Duration: #TIME##NOTIFICATION#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VALIDATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when validating rule #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule view "#1#" created.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule view "#1#" deleted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_SESSION_STATE_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// Page item "#1#" set to "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CGR_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The name of the rule group must be unique for this application.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CGR_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The rule group already exists. Choose a unique name.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STANDARD_JS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^// Standard ADC JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group #1# is already installed at application #2#, page #3#. It can't be installed over itself.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unexpected item type "#1#" with format mask.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception while executing "#1#", cannot continue work.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_CPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unknown parameter type: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group view "#1#" created succesfully.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when creating rule group "#1#": #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_WHERE_CLAUSE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Exception when creating WHERE-clause: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Export type #1# is unknown.^',
    p_pms_description => q'^An unsupported export type was requested. Only use the constants C_%_GROUP(S).^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_REJECTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Action #1# was not executed because there was an error and this action is not an error handler.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_EXECUTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Executing action #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'ADC_INFINITE_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Loop #1# has exceeded the maximum allowed number of passes and has been aborted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/