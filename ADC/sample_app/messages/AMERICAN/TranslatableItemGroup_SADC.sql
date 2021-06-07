set define off

begin

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>The report gets a hidden field P8_EMPLOYEE_ID, which should contain the currently selected ID of the report.</li><li>The report gets a static ID (R8_EMPLOYEE), so ADC knows that actions are planned on this region and it gets a unique identifier for the region.</li><li>The button gets a static ID (B8_EDIT_EMP), so ADC knows that an action is planned on this button. The identifier of this button is arbitrary, it will be overwritten by the page command. The action chosen is "Defined by Dynamic Action".</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_S1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Page commands</h2><p>A page command is an activity that can be executed via buttons, menus, or other triggers. However, unlike submitting a page, the application page remains loaded. A page command is based on APEX actions (not Dynamic Actions!), which manage a label, keyboard shortcuts, and state under a technical identifier.&nbsp;</p><p>Page commands are used for different purposes in ADC. They allow simple dynamic control so that the behavior, as well as the status and label, can be customized as desired.</p><p>The application page demonstrates its use by showing a button that exhibits different behavior depending on the employee selected from the list. Managers cannot be edited, while other employees are shown in the button's label.</p><^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADACT_S2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Notes</h3><p>When rendering the page, an SCT action has been introduced that writes the currently selected value of an Interactive Grid to a page element. In the example, the Employee ID has been selected in column 1 of the view, and the target is the hidden element P8_EMPLOYEE_ID.</p><p>If this field changes, a PL/SQL code is triggered that edits the page command. This allows to control the label as well as the behavior. In the example, a modal window is opened to edit the employee if this is allowed, and a warning is shown if this is not allowed. Please note that this is almost impossible to implement in APEX without ADC, because a link to an application page cannot be changed dynamically.</p><p>The method for controlling the page command uses the ADC_APEX_ACTION auxiliary package. This selects the action and then controls the behavior. After the changes are complete, a script is passed to ADC, which exercises control on the page:</p><p><span style="font-family:'Courier New', Courier, monospace;">adc_apex_action. <strong>action_init('edit-employee')</strong>;</span><br><span style="font-family:'Courier New', Courier, monospace;">if l_is_manager = 1 then</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action. <strong>set_label</strong>('Not editable');</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action. <strong>set_disabled</strong>(true);</span><br><span style="font-family:'Courier New', Courier, monospace;">else</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action. set_label(l_label);</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action.set_disabled(false);</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; adc_apex_action. <strong>set_href</strong>(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; utl_apex. get_page_url(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; p_page =&gt; 'edemp',</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_param_items =&gt; 'P9_EMPLOYEE_ID',</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_value_list =&gt; l_employee_id,</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; &nbsp; p_triggering_element =&gt; 'B8_EDIT_EMP',</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; p_clear_cache =&gt; 9));</span><br><span style="font-family:'Courier New', Courier, monospace;">end if;</span><br><span style="font-family:'Courier New', Courier, monospace;">adc. Add_javascript(<strong>adc_apex_action.get_action_script</strong>);</span></p>^'
  ); 

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADADC_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>All page elements: Element is mandatory field attribute turned off</li><li>Date field and payment field equipped with format mask to enable auto-detection</li><li>Mandatory field equipped with label "REQUIRED" (no matter which variant) to enable auto-detection.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADANF_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>All page elements: Element is mandatory field attribute disabled</li><li>Date field and number field equipped with format mask to enable auto-detection</li><li>Mandatory field not distinguished, as this is achieved via a use case.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADC_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>The ADC Administration Application</h2><p>Dynamic pages are configured through a central application that can manage use cases for all APEX applications in the workspace. This application not only manages the use cases for the dynamic pages, but also exports all use cases as SQL files so that the use cases can be easily delivered and scripted to other environments (test, production)</p><p>The following button opens the edit page associated for this application page in the ADC Administration Application in a new tab.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADC_NO_RULES',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Dynamic page without use cases</h3><p>The application page you are currently on has no use cases defined. Yet, a predefined use case appears when the user opens the page. Notice the technical condition. It references an INITIALIZING column. If a dynamic page is initially rendered, this column has the value C_TRUE, otherwise C_FALSE. These two columns are also available for creating technical conditions. The data type of these columns is defined as FLAG_TYPE in the package ADC_UTIL. If you are developing methods that make Boolean decisions, it is also a good idea to have this data type returned, then your methods can also be checked this way.</p><h3>What can a dynamic application page without use cases do?</h3><p>A dynamic page without use cases already behaves differently than a static application page. Try out these differences in the dialog below. Mandatory fields are already dynamically checked, and date and number fields must also contain correct date or number information</p><p>This functionality is possible because</p><ul><li>mandatory fields on the application page have been given a REQUIRED label type</li><li>number and date fields have been made identifiable using format masks</li><li>form regions based on a view or table are also automatically checked if their column type could be identified as a number or date field. </li></ul><p>Please note that for input fields on dynamic application pages, the "Validation → Value Required" attribute should be turned off to avoid colliding with the dynamic page checks.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<ul><li>Form region triggers recognition of number and date fields, no format mask required</li><li>Page Required attribute turned off for all elements</li><li>Required markup via Advanced - CSS class "sadc-mandatory" and corresponding action on page load</li><li>Which page elements are known to be mandatory elements can additionally be viewed in Session State under the current page's Collections.</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_S1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Control of page status</h2><p>In addition to validation, the status of the application page can be controlled via ADC. In combination, this provides powerful control over the dynamic page.</p><p>In this example, the selection of the occupation controls whether or not a sales bonus may be paid. If one of the SALES professions is selected, the Sales Bonuses field is shown, made mandatory, and defaults to 0.3.</p><p>If another profession is selected, these settings are reversed. Note that, as usual, no Dynamic Actions are required on the application page. This time, the mandatory fields are indicated by a CSS class on the page and an action when the page is loaded. Alternatively, the path used so far would have been possible. However, the example shows the greater flexibility, because based on initialization logic, different page elements can be marked as mandatory fields.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADSTA_S2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Notes</h3><p>The use cases for controlling sales bonuses show an example of a decision function in the technical condition. Since all relevant session values are available via corresponding columns, they can also be passed to functions. The function returns ADC_UTIL.FLAG_TYPE, so that the result can be easily checked via the C_TRUE column.</p><p>In the first use case, it was stored as the second action that the use cases referring to the P7_JOB_ID input field should be executed. This ensures that both use cases are checked and, if the technical condition is met, are also executed directly. As a result, the input fields are set correctly when the page is initially displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ADVAL_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>No changes from previous pages</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ANF_S1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Simple use cases</h2><p>Consider the dialog shown below. This dialog has already been modified by simple use cases. These changes have been made when you open the application page. The button will take you to the appropriate ADC Administration application page in a new tab. Consider the actions of the "When the user opens the page" use case.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_ANF_S2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Notes on the form</h3><p>Once again, field "Mandatory" is a required field, but this time it has not been set up by the label template REQUIRED, but by an action during page loading. In addition, field "Date" has been disabled.</p><p>Look at the way these two properties have been set. Also note that the mandatory field gives a different error message when deleting a previously entered value. This is because an error message has been added as a parameter to the "Field is mandatory" action. This overwrites the default message. If this parameter is left empty, the standard message appears again.</p><p>It does not matter, by the way, in which way you define a mandatory field, in both cases this distinction is dynamically changeable. If you want, as an action of another use case, that this field is no longer a mandatory field, this is possible at any time. ADC stores the list of mandatory fields for each user in an APEX Collection. You can also view this in the Session Status.</p><h3>Activating and deactivating dynamic application pages</h3><p>You can either deactivate the entire dynamic application page by turning off the "Active" switch in the "Dynamic Page" area, or individual use cases by editing that use case and selecting the appropriate option. Likewise, you can turn individual actions on or off. This capability is very important when it comes to troubleshooting.</p><p>Test this capability by going to the ADC Administration application and disabling the dynamic page. Return to that page and reload it. You will see that neither the Mandatory field is a required field, nor that the Date field is disabled.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_OVERVIEW',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h3>Overview of APEX Dynamic Action (ADC) sample application</h3>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_TEXT_MISSING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^<p>Text "#1#" is not present.</p>^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_USE_ADC',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Include ADC in your application</h2><p>ADC is delivered as a Dynamic Action Plugin. You must first import this plugin into your application. To use ADC with your pages, you have several options:</p><h3>Use for a specific page</h3><p>If you only want to control a few pages with ADC, it is recommended to include the plugin on the corresponding application pages during page load (PageLoad). The plugin does not require any parameterization on the application page.</p><h3>Use ADC on all application pages</h3><p>Alternatively, the plugin can be included on page 0 and is thus available on all application pages. This way is also useful if you want to control most pages with ADC, but exclude some from this. In this case, add a server-side condition that prevents the plugin from running on those pages.</p><h3>Create a page template for ADC</h3><p>As a third option, you can also create a page template that automatically references ADC. In this case, add the following code in the JavaScript section of the page template:</p><p>&lt;TODO: Create code&gt;</p><p>This way is useful if you want to make it as easy as possible for your developers to include ADC and, on the other hand, keep the flexibility of wanting to use ADC only for some application pages. </p><p>This application uses the plugin on page 0, so it is available to all application pages.</p><h3>Making application page available in ADC management application</h3><p>Once you have inserted a new page and set up ADC for that page in one of the ways described, you need to run that page once to register it in the ADC management application. You can then enter use cases for that application page. Note that page elements must be present on the application page for meaningful use cases to be captured.</p><p>Also note that ADC cannot automatically detect whether you have modified a page in APEX. So, for example, if you add or delete page elements, you must then open and re-save a use case of that page in ADC. This will synchronize the Dynamic Page in ADC with the APEX application page. Usually, the APEX application page is created completely first, and only then do you start capturing the use cases.</p>^'
  ); 

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL_S1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Create simple validations</h2><p>Validations can be modeled as a use case. In the dialog below, only one date in the future may be entered. This validation was created by inserting the technical condition P5_DATE &lt; SYSDATE. As an action in this case an error message should be output. In addition, a number must be between 100 and 1000. This condition is formulated analogously as P5_NUMBER not between 100 and 1000.</p><p>You can see from the technical condition that the input fields have been converted and are available as date or number, if a format mask has been deposited or a form region has recognized the corresponding data type.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL_S2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Validations of this type are quite limited in their capabilities. The remainder of this application will show how more complex validations can be easily implemented.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL2_S1',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<h2>Set up more complex validations</h2><p>To set up more complex validations, PL/SQL methods are used. You can prefer to run these methods as procedures that report any errors to ADC. For this purpose, the ADC.REGISTER_ERROR method is available in the ADC package. It has the following declaration:</p><p><span style="font-family:'Courier New', Courier, monospace;">&nbsp; /** Method to register an error</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; * %param &nbsp;p_cpi_id &nbsp; &nbsp; &nbsp; &nbsp;ID of the page item that is referenced by the error (or DOCUMENT)</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; * %param &nbsp;p_error_msg &nbsp; &nbsp; &nbsp; Error message to register</span><br><span style="font-family: 'Courier New', Courier, monospace;">&nbsp; * %param [p_internal_error] Optional additional information, visible for developers</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * %usage &nbsp;Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; * &nbsp; &nbsp; &nbsp; consequence of an internal error. </span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; */</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp;procedure register_error(</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_cpi_id in adc_page_items. cpi_id%type,</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_error_msg in varchar2,</span><br><span style="font-family:'Courier New', Courier, monospace;">&nbsp; &nbsp;p_internal_error in varchar2 default null);</span></p><p>There is also an overload for PIT messages. Passing errors to ADC within the procedure is identical to a "show error" type action that we used in the simple validation examples.</p><p>Procedures, on the other hand, are infinitely more powerful because they can execute the full range of conditional logic as well as arbitrarily complex validation logic.</p><^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'UI_VAL2_S2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The use of procedures for validation should be the standard procedure in order to avoid making the technical conditions unnecessarily complex. Here, the technical condition is only responsible for determining when validation should be performed, while the procedure performs the actual validation.</p><p>As an alternative to this approach, it is of course also possible to call a function in the technical condition that decides whether validation is required or not. This strategy is used in particular for status control, which we will examine on the next application page.</p><p>^'
  );

  commit;
end;
/

set define on