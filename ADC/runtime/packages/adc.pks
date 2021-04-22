create or replace package adc
  authid definer
as

  /** Package ADC to implement wrapper around ADC_API.EXECUTE_ACTION for system defined action types
   * %author Juergen Sieben, ConDeS GmbH
   * %usage  Used to implement the API for direct access of ADC actions from PL/SQL code
   * %headcom
   */
  
  /** Method to register JavaScript code
   * %param  p_javascript  JavaScript to execute on page
   * %usage  Is used to register JavaScript for execution. Is used if PL/SQL code that is part of the application logic needs
   *         to register JavaScript for execution. In that case, EXECUTE_JAVASCRIPT may not be as elegant to use.
   */
  procedure add_javascript(
    p_javascript in varchar2);


  /** Method to assure that exactly one or at most one page item of a selection of page items contains a value
   * %param  p_cpi_id         Page item ID that is selected to show the error message
   * %param  p_value_list     List of page item IDs to check
   * %param [p_message]       Optional PIT message name to show if the method throws an error
   * %param [p_error_on_null] Flag to indicate whether an error has to be thrown if all page items are NULL
   * %raises MSG.ASSERTION_FAILED_ERR or <P_MESSAGE>_ERR if
   *         - more than one page item is NOT NULL
   *         - all page items are NULL and P_ERROR_ON_NULL is set to true
   * %usage  Is used to assert that at least one page item of a list of items contains a value. If an error is raised, this
   *         can be used to proceed with an exception handler within the ADC rule.
   */
  procedure exclusive_or(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in adc_util.flag_type default adc_util.C_FALSE);


  /** Function overload
   * %param  p_value_list  colon-separated list of page item IDs to check
   * %return - adc_util.C_TRUE if rule is satisfied
   *         - adc_util.C_F if rule is not satisfied
   *         - NULL if all page item values are null
   * %usage  Is used to be able to utilize EXCLUSIVE_OR within an ADC rule condition (used in SQL)
   */
  function exclusive_or(
    p_value_list in varchar2)
    return adc_util.flag_type;

  
  /** Method to encapsulate PIT collection mode error treatment
   * %param [p_mapping] CHAR_TABLE instance with error code - page item names couples, according to DECODE function
   * %usage  Is used to retrieve the collection of messages collected during validation of a use case in PIT collect mode.
   *         The method retrieves the messages and maps the error codes to page items passed in via P_MAPPING.
   *         If found, it shows the exception inline with field and notification to those items, otherwise it shows the
   *         message without item reference in the notification area only.
   *         Supports #LABEL# replacement, page item name may be passed in with or without page prefix.
   *         Similar to UTL_APEX.HANDLE_BULK_ERRORS, but uses SCT to show the messages dynamically as opposed to UTL_APEX
   *         that encapsulates the messages in the validation life cycle step of APEX.
   */
  procedure handle_bulk_errors(
    p_mapping in char_table default null);


  /** Hides the referenced page element
   * %param [p_cpi_id]     Element to be hidden (default DOCUMENT, if P_JQUERY_SEL filled)
   * %param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * %param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_cpi_id filled)
   */
  procedure hide_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_whole_row in adc_util.flag_type default null,
    p_jquery_sel in varchar2 default null);


  /** Method to assure that at least on page item of a list of page items contains a value
   * %param  p_cpi_id      Page item ID that is selected to show the error message
   * %param  p_value_list  List of page item IDs to check
   * %param [p_message]    Optional PIT message name to show if the method throws an error
   * %usage  Is used to make sure that at least one page item of a list of page items contains a value.
   * %raises MSG.ASSERTION_FAILED_ERR or <P_MESSAGE>_ERR if all page item values are NULL
   */
  procedure not_null(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED);


  /** Overload as function
   * %param  p_value_list  List of page item IDs to check
   * %return - adc_util.C_TRUE if rule is satisfied
   *         - adc_util.C_FALSE if rule is not satisfied
   *         - NULL if all page item values are null
   * %usage  Is used to be able to utilize NOT_NULL within an ADC rule condition (used in SQL)
   */
  function not_null(
    p_value_list in varchar2)
    return adc_util.flag_type;


  /** Updates an element and sets the session state
   * %param  p_cpi_id      Page item to be updated
   * %param [p_item_value] Value of the element in the following format:
   *                       - constant in quotation marks or 
   *                       - JavaScript expression, which is calculated at runtime or 
   *                       - NULL In this case the value of the session state is used
   *                         (this can be calculated in advance)
   * %param [p_set_item]   Flag to indicate whether the value of the item must be set after refresh
   *                       (adc_util.C_TRUE) or not (adc_util.C_FALSE). Defaults to adc_util.C_TRUE
   * %usage  Is used to refresh a page item. In addition to the refresh methods, this method allows
   *         to set a page item to a defined value according to P_ITEM_VAL after refresh.
   *         Is usable for page items and refreshable regions
   */
  procedure refresh_item(
    p_cpi_id in varchar2,
    p_item_value in varchar2 default null,
    p_set_item in adc_util.flag_type default adc_util.C_TRUE);


  /** Method to register an error
   * %param  p_cpi_id          ID of the page item that is referenced by the error (or DOCUMENT)
   * %param  p_error_msg       Error message to register
   * %param [p_internal_error] Optional additional information, visible for developers
   * %usage  Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the
   *         consequence of an internal error.
   */
  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null);


  /** Overload to allow for PIT messages to be used.
   * %param  p_cpi_id        ID of the page item that is referenced by the error (or DOCUMENT)
   * %param  p_message_name  PIT message name to register
   * %param [p_msg_args]     Optional message arguments as defined by PIT
   * %usage  Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the
   *         consequence of an internal error.
   */
  procedure register_error(
    p_cpi_id in adc_page_items.cpi_id%type,
    p_message_name in varchar2,
    p_msg_args in msg_args default null);


  /** Sets the focus to the element defined in p_spi_id
   * %param  p_cpi_id   element to focus on
   */
  procedure set_focus(
    p_cpi_id in adc_page_items.cpi_id%type);


  /** Sets the referenced page element to the value passed as parameter
   * %param [p_cpi_id]      Element to be set (default DOCUMENT, if P_JQUERY_SEL filled)
   * %param  p_item_value   Value of the element in quotation marks or function that returns value.
   * %param [p_jquery_sel]  jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   * %param [p_raise_event] Flag indicating whether a Change Event should be triggered. (Default TRUE, event is triggered)
   */
  procedure set_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_value in varchar2,
    p_jquery_sel in varchar2 default null,
    p_raise_event in boolean default true);


  /** Sets a field label to the transferred value
   * %param [p_cpi_id]      Element to be set (default DOCUMENT, if P_JQUERY_SEL filled)
   * %param  p_item_label   Label of the element in quotation marks or function that returns value.
   * %param [p_jquery_sel]  jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure set_item_label(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_item_label in varchar2,
    p_jquery_sel in varchar2 default null);


  /** Procedure to set the session state, based on an SQL statement.
   * %param  p_cpi_id ID of the page item
   * %param  p_stmt   SELECT statement to retrieve the new page item value or values
   * %usage  Is used to set one or more item values based on a SQL query.
   *         Two operation modes:
   *         - P_CPI_ID is set to a page item ID
   *           In this case the SQL query must return a scalar value
   *         - P_CPI_ID ist DOCUMENT oder NULL
   *           In this mode the query is allowed to return more than one column but one row only.
   *           The column names must match page item column source names. 
   *           If a match is found, the respective element is set to the column value
   */
  procedure set_items_from_stmt(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_stmt in varchar2);


  /** Makes a page element a mandatory element and activates mandatory field validation.
   * %param [p_cpi_id]     Mandatory element (Default DOCUMENT, if p_jquery_sel filled)
   * %param [p_msg_text]   Message text in quotation marks or function that returns a value (default NULL, then standard text)
   * %param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_cpi_id filled)
   */
  procedure set_mandatory(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_msg_text in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Makes a page element an optional element and suspends mandatory field validation.
   * %param [p_cpi_id]     optional element (default DOCUMENT, if P_JQUERY_SEL filled)
   * %param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_cpi_id filled)
   */
  procedure set_optional(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_jquery_sel in varchar2 default null);


  /** Hides the element from P_JQUERY_SEL_SHOW on the page and the elements from P_JQUERY_SEL_HIDE
   * %param  p_jquery_sel_show  jQuery expression to display multiple elements
   * %param  p_jquery_sel_hide  jQuery expression to hide multiple elements
   */
  procedure show_hide_item(
    p_jquery_sel_show in varchar2,
    p_jquery_sel_hide in varchar2);


  /** Displays the referenced page element
   * %param [p_spi_id]     Element to be displayed (default DOCUMENT, if P_JQUERY_SEL filled)
   * %param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * %param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure show_item(
    p_cpi_id in adc_page_items.cpi_id%type default adc_util.C_NO_FIRING_ITEM,
    p_whole_row in adc_util.flag_type default adc_util.C_TRUE,
    p_jquery_sel in varchar2 default null);
    
    
  /** Method to submit the actual page
   * %param [p_execute_validations] Flag to indicat whether all validations should be performed
   * %usage  Allows ADC to determine on whether the actual page has to be processed or not
   */
  procedure submit_page(
    p_execute_validations in adc_util.flag_type default adc_util.C_TRUE);


  /** Method to stop further execution of the active rule
   * %usage  Is used to stop the execution of an ADC rule if an error occured.
   */
  procedure stop_rule;


  /** Prozedur zur Vorbereitung des Speicherns der Seite
   * %usage Diese Prozedur sollte nur verwendet werden, wenn ADC eine Seite
   *        vollstaendig verwaltet. Die Prozedur prueft alle Seitenelemente,
   *        die durch ADC auf MANDATORY gesetzt wurden, gegen den Session-State.
   *        Ist ein Pflichtfeld NULL wird ein Fehler registriert und das Absenden
   *        der Seite dadurch verhindert.
   */
  procedure validate_page;
  
end adc;
/