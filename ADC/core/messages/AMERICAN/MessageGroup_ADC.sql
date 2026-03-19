begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',p_pmg_description => q'^Messages for the ADC plugin^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^ADC action #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_EXECUTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Execute action #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_PARAM_TYPE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when executing the statement "#1#": #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

pit_admin.merge_message(
    p_pms_name => 'ADC_ACTION_REJECTED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Action #1# was not executed because there was an error and this action is not an error handler.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Integration of the page actions^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_APEX_ACTION_UNKNOWN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The APEX action #1# does not exist.^',
    p_pms_description => q'^When validating a parameter of type APEX_ACTION, a non-existent APEX action was referenced.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

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
    p_pms_name => 'ADC_COLUMNS_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^SQL statement executed, #1# columns found.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CONFIRM_HAS_CHANGES',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^There are changes on the page. Please confirm that you still want to cancel.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CONFIRM_NO_CHANGES',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^There are no changes on the page. Save is not executed.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The name of the rule group must be unique for this application.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CRG_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The rule group already exists. Select a unique name.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_CSM_WRONG_PREFIX',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The name of a standard message must begin with CSM_.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DATE_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Date element #1# set to value #2#, string value: #3#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin. merge_message(
    p_pms_name => 'ADC_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule-SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_DOUBLE_IDENTIFIER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The element #1# appears several times on the page. Please use unique static IDs.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

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
    p_pms_text => q'^Error in recursion #1#, rule #2# (#3#), triggering element: "#4#" occurred, execute error handling^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_EXPECTED_FORMAT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Expected format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_FIRING_ITEM_POPPED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# has been removed from the stack.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_FIRING_ITEM_PUSHED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# was written to the stack on recursion #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
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
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_1',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 1: Remove the REQUIRED flags and mark each element as incorrect, this will be corrected later.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_2',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 2: Merge APEX page elements into ADC_PAGE_ITEMS^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_3',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 3: Mark page elements referenced in a technical condition as relevant^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_4',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 4: Remove elements that are irrelevant, incorrect or not referenced^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_5',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 5: Mark errors in adc_rules and ADC_RULE_ACTION and set all error flags for the rule to FALSE^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_6',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 6: Mark rules that refer to elements with an error flag^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_7',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 7: Reset all error flags for rule actions to FALSE^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin. merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_8',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 8: Mark rule actions that refer to elements with an error flag^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_HARMONIZE_CPI_STEP_9',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Step 9: Create new initialisation code for fast page initialisation and store in table adc_rule_groups^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INFINITE_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Loop #1# has exceeded the maximum allowed number of runs and has been cancelled.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRG_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialisation of rule group #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALZE_CRU_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during initialisation of single rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INIT_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^recursion #1#, run #2#: rule #3# (#4#), general initialisation, duration: #TIME#hsec^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INIT_ORIGIN_ADDITIONAL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^recursion #1#, run #2#: rule #3# (#4#), additional initialisation, duration: #TIME#hsec^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INTERNAL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^An error has occurred on the page: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_DATE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid date format^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_DEBUG_LEVEL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The debug level is not allowed, use only adc_util.C_JS_CODE, adc_util.C_JS_DEBUG, adc_util.C_JS_COMMENT or adc_util.C_JS_DETAIL.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_JQUERY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The selector "#1#" is not used on the page.^',
    p_pms_description => q'^When validating a jQuery selector, it must be present on the page.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_NUMBER',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Invalid number.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_PAGE_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The page element "#1#" is not used on the page.^',
    p_pms_description => q'^When validating an element name, it must be present on the page.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SEQUENCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The sequence "#1#" does not exist.^',
    p_pms_description => q'^A non-existent sequence was referenced.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INVALID_SQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error in technical condition: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin. merge_message(
    p_pms_name => 'ADC_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Page element #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IGNORED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The element #1# cannot contain a value and was therefore ignored.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#LABEL# must not be empty.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_IS_MANDATORY_DEFAULT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#LABEL# must not be empty.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_SET_MANDATORY',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# registered as mandatory field and added to collection.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_SET_OPTIONAL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# registered as optional and removed from collection.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_ITEM_UNCHANGED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Status of element #1# not changed.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MAX_ONE_VALUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Only one unique search criterion may be entered.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when merging rule #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error merging rule action #1#, #2#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error merging rule group #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_METHOD_PARSE_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^A parse error was triggered when validating a method. Correct the method.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_MIN_ONE_VALUE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^At least one search criterion must be specified.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for #1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Action #1# was not executed because there was no error and this action is an error handler.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace "#1#" and alias "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin. merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No JavaScript code for rule "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No JavaScript action^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NON_UNIQUE_STATIC_ID',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^In rule group #1# the static ID #2# occurs several times.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No use case found for the current page status^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^No data found for workspace #1# and application #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_NUMBER_ITEM_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^number element #1# set to value #2#, string value: #3#.^',
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
    p_pms_text => q'^Further JavaScript action suppressed because too long^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_OUTPUT_REDUCED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^'Output reduced to level #1# due to length'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^APEX application page #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Fix all page errors before sending.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_INCORRECT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The LOV-View #1# does not have the specified columns D, R and CRG_ID.^',
    p_pms_description => q'^In order for a LOV view to be used, it must have exactly 3 columns with the identifiers D, R and CRG_ID.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_LOV_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The parameter type #1# requires a LOV view of the name #2#. This is missing ^',
    p_pms_description => q'^A parameter type that requires a LOV list requires a corresponding LOV view so that the required data can be determined.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_MISSING',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Field #LABEL# is a mandatory field.^',
    p_pms_description => q'^The input field is a mandatory parameter and must therefore be filled.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PARAM_VALIDATION_FAILED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^When a parameter value is validated, it is checked for plausibility depending on its type. The incorrect parameter value must be corrected ^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin. merge_message(
    p_pms_name => 'ADC_PARSE_JSON',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error parsing JSON: #SQLERRM#.^',
    p_pms_description => q'^Errors occurred when parsing a JSON instance. Correct the JSON instance and try again.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_CODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL-Code: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PLSQL_ERROR',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while executing PL/SQL code #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_PROCESSING_RULE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Create action for rule #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LIMIT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# has exceeded recursion depth of #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RECURSION_LOOP',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element #1# has created a recursive loop at recursion depth #2# and was therefore ignored.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ACTION_EXISTS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^This combination of attributes of a rule action already exists.^',
    p_pms_description => q'^The attributes CRA_CRG_ID, CRA_CRU_ID, CRA_CPI_ID, CRA_CAT_ID and CRA_ON_ERROR must be unique.^',
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
    p_pms_name => 'ADC_RULE_IGNORED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule #1# was requested by element #2# but ignored because it has already been requested.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_ORIGIN',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Recursion #1#, Run #2#: Rule #3# (If the user #4#), Triggering element: "#5#"#6| (value: |)|#, Duration: #TIME#hsec^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VALIDATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error during validation of rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group view #1# was created.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group view #1# was deleted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_SESSION_STATE_SET',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Element ~#1#~ was set to the value ~#2#~^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_SET_SESSION_STATE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error when setting element #1# to the value "#2#": #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STANDARD_JS',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Standard-ADC JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin. merge_message(
    p_pms_name => 'ADC_STOP_NO_JAVASCRIPT',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^JavaScript code "#1#" was output because there was an error and the rule was stopped.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_STOP_NO_PLSQL',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^PL/SQL code "#1#" was not executed because there was an error and the rule was stopped.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group #1# is already on application #2#, page #3# and cannot be copied over itself.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Unexpected element type ~#1#~ with format mask.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while executing "#1#", cannot continue work.^',
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
    p_pms_name => 'ADC_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The export type #1# is unknown.^',
    p_pms_description => q'^An unsupported export type was requested. Only use the constants C_%_GROUP(S).^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATED',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Rule group #1# successfully created^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'ADC_VIEW_CREATION',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while creating the Decision Table #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_WHERE_CLAUSE',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^Error while creating the WHERE clause: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ADC_INITIALIZE_SCRIPT_TOO_LONG',
    p_pms_pmg_name => 'ADC',
    p_pms_text => q'^The ADC could not be initialised because the initial JavaScript exceeded the maximum size.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/
