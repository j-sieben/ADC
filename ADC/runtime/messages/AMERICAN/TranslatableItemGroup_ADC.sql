begin

  pit_admin.merge_message_group(
    p_pmg_name => 'ADC',
    p_pmg_description => q'^ADC Plugin messages^');

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_PAGE_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page element^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_ALL_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All rule groups^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All control groups of an application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All rule groups of an application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_CGR_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^One rule group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPAC3D4D849D3D3917E8CC2606FF68F6E2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional JavaScript action.<br>This parameter must be the name of a JavaScript function or an anonymous function definition that is called as a callback.<br/>If no parameter is defined, ADC is called and the corresponding rules are executed, otherwise the function stored here is executed directly.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPBDA9160DDE5F6AEDB488FF32665A62D4',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Element value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPBF769C85CC8DAB50F56D660ECB6B2FBA',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to display^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements to be displayed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB0528533092E9D3F52D838938EB5930D',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB2D10702F0B0188397C2CA89A4BD944A',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Element value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB62D45604A2D55BF5BCA1410CE0EF93B',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Name of the page element where the IG selection should be saved.</p>
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPB978A4138A030641A7462A678187CB20',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Request^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>REQUEST value, can optionally be transferred, otherwise SUBMIT is used.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPC31B355C8A1EAEC903C714EB5D5B2296',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPDB647256162400B9E63FD2EFB18BFD90',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message text</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPDEB7F9B363DE45ED97D97891DF640704',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Comma-separated list of element names or CSS classes that identify the fields that will be grouped together. Within this group, exactly one field must have a NOT NULL value when checking the values.<br>If all elements are NULL or if more than one element is NOT NULL, an error is thrown</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPD13D372C92172FF7A6D6DA4A430780CB',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional JavaScript action.<br>This parameter must be the name of a JavaScript function or an anonymous function definition that is called as a callback.<br/>If no parameter is defined, ADC is called and the corresponding rules are executed, otherwise the function stored here is executed directly.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPD2C15D4CFEC29ED0C5807C32D62C4000',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message text</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPE181E6A716D6AD6D14BDFDB946CCA2F4',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPE61E3FD9A9FC0068E4CC62095FB0762E',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPFB17277D49BAFA7638B98C05D27A2838',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be output if the page validation check fails.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAPFD6AB926E62740D9CFBD2752874BD1FF',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0BD14564CB6FE907C6BC2DDE59CB5056',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0BFEE6E89A13BFD9D315FB56A4D4E651',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0EE72386778AC8E5A6C436E9D58BD4C2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>JavaScript statement to be executed. (without semicolon)</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP0689C597B72E1C3C1A68C4947E8E2406',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Item value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP08B88A6421BF53E742982EC858694A66',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP117C7441334261A7FCBF4984E2AD73B4',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Ordinal number of the value column^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>1- based ordinal number of the column to be stored in the deposited element. The order will be based on the order on the APEX application page.</p>.
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP15E7057159CD40FF351530D05667BE60',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be output if the check fails. Must be a PIT message name, in the form MSG.[messagename].</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP177598894625ECABC760864A5E1C0A02',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optional JavaScript action.<br>This parameter must be the name of a JavaScript function or an anonymous function definition that is called as a callback.<br/>If no parameter is defined, ADC is called and the corresponding rules are executed, otherwise the function stored here is executed directly.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP179D749A8A00A8832B7573AFA9E193F0',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^List of page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Comma-separated list of element names or CSS classes that identify the fields that will be grouped together. Within this group, when checking values, either exactly one field must have a NOT NULL value, or all values must be empty</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP20B544876D535AB8292D6753CB3D9DFE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>The page command to be executed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP4F1E987BB2D9371305C1DC18A9AB0B82',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP4F360095CD75214AB35BF40E55ACA18C',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP50C16A7CCFAD2685DFE78533EA53813F',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sequence name</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP531282FC2099B7CCD49D7CECADF2E905',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP611E99D4B894D68489A1060D4DE07C47',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>SQL statement returning one or more values</br>The column labels must match element names, the query results are set in the corresponding page elements</dd>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP7C042712CDD7810589867BD3A08A6DD4',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP70D8A0B9EF3ADEB0DD9A2BD0E499A2A7',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP72850F551A3B5F37A7670B5EC081EA2B',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Error message can optionally be passed, otherwise a standard message is used.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP729A6A7AABC066E08247DFCB3339D464',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message displayed in the confirmation message</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP75A4BB1CB653A11D97D845ABBB5CBDD3',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP76ECA0290404F66846502EB78BBD4F76',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP7724DC6D811532DA8D522D3CEB2BAE8F',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL code to be executed.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP77504FC6F879315C6B0FBAB530A40C90',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be output if the check fails.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP8B8771CE2BA0C22DCE51D389A2F21D25',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP80DBD593D7303BF0C1EFC308A40DB79E',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP82EEAF01903EBC85283DF7416D9ACADE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog title^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Title of Dialog window</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP86AC296FB638C95E539E775E307861E5',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements to be hidden^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery selector that identifies the page elements to be hidden.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP88B0FC095F08F31DB49ABD31C39221E2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Value to be set.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9BB1FC3515BD86A3FB1C8FD44C3FB34B',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Element value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9ECFCB015230C774FD6FFD4DC15A63A2',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>PL/SQL function that outputs a JavaScript statement.<br>Without using "javascript:", only output the JavaScript code</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP928CE4EFBA5F2EE3B4D691AEBFBA681E',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird ADC aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9459F044E685427FCFBB0536194ADF08',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => '_SAP9848E46D537D360B197740E74F10E043',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Message name to be output if the check fails. Must be a PIT message name, in the form MSG.[messagename]</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_AFTER_REFRESH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Monitor "After Refresh" event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registers an APEXAfterRefresh event handler. If the event is triggered, this is reported to ADC and can be caught with a rule AFTER_REFRESH = 1.<br>triggering element is the element that is registered as FIRING_ITEM in this action.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CHECK_MANDATORY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Check mandatory fields^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Checks whether all mandatory items contain a value</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_CONFIRM_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Bind button to confirmation dialog^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Ensures that a confirmation message is displayed when a button is clicked.<br>Only when this request is confirmed is the event reported to ADC.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DIALOG_CLOSED',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Monitor "Dialog Close" event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If the event is triggered, this is reported to ADC and can be caught with a rule DIALOG_CLOSED = 1. The element that registers as FIRING_ITEM in this action is the element that is sent.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DISABLE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Disable button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Deactivates a button. <br>To disable a page element, please use <span style="font-family:courier new,courier,monospace">Deactivate field</span>.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DISABLE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Deactivate target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Deactivates the referenced page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DOUBLE_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Monitor "double-click" event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If the event is triggered, this is reported to ADC and can be caught with a rule DOUBLE_CLICK = 1. <br>The triggering element is the element that is registered as FIRING_ITEM in this action.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_DYNAMIC_JAVASCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute dynamic JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Executes the passed JavaScript on the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EMPTY_FIELD',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Empty page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the element value of a field to <span style="font-family:courier new,courier,monospace">NULL</span></p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENABLE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enable button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Activates a button. To activate a page element please use <span style="font-family:courier new,courier,monospace">Show field</span>.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENABLE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enable target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Disables the referenced page item.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ENTER_KEY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Monitor "Enter key" event^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Registers an Enter key event handler.<br>If the event is triggered, this is reported to ADC and can be caught with a ruleENTER_KEY = 1.<br>Trigging element is the element that is registered as FIRING_ITEM in this action.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_APEX_ACTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Executes a command that must have been created as page command in advance.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXECUTE_COMMAND',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Executes a page command.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_ALLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All Action types^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Action types created by the user and all supplied action types^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_SYSTEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Supplied Action types^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Action types created and supplied by ADC^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_EXPORT_USER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^User-created action types^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^User created Action types^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_GET_SEQ_VAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Get sequence value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced element to a new sequence value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_IR_IG_FILTER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hide filter from IR/IG^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Hides the filter bank of Interactive Report/Grid.</p>
^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_HIDE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Hide target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Hides the referenced page element</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IG_ALIGN_VERTICAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Format table cells vertically top^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Changes the formatting of an interactive grid/report so that the table cells are vertically aligned at the top.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_DATE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item contains date^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<P>Checks whether an input field contains a date.<br>Conversion will be based on format mask having been stored in APEX for that field.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_MANDATORY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item is mandatory^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Make a page item a mandatory field including validation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_NUMERIC',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item contains number^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<P>Checks whether an input field contains a number.<br>Conversion will be based on format mask having been stored in APEX for that field.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_IS_OPTIONAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item is optional^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Makes a page element an optional element and suspends mandatory field validation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_ITEM_NULL_SHOW',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Empty page item and enable^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page element to NULL and displays it on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_JAVA_SCRIPT_CODE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute JavaScript code^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executes the JavaScript code passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_EDITABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^(not editable)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOTIFY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show message^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Shows a message on the application page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_NOT_NULL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select at least one value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Make sure that at least one of the elements from attribute 1 contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_PLSQL_CODE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Execute PL/SQL code^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executes the PL/SQL code passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_AND_SET_VALUE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Refresh page item and set value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Updates a page element and sets the field to session state</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REFRESH_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Refresh target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>initiates APEX-refresh on the referenced page item.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Trigger change Event on page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Triggers a CHANGE event on the specified field and ensures the processing of the associated rules</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_REGISTER_OBSERVER',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Observe page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Action observes a field or class and registers the elements so that the corresponding element values are copied to the session state at each event on the page.<br>Required only if no ADC rule contains this item or class.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_CONSOLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Outputting a message to the console^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>A message is written to the console of the developer tools.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ELEMENT_FROM_STMT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set element value with SQL statement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets an element value based on an SQL statement that returns a single value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_FOCUS',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set focus in page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>set focus in input field of the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_IG_SELECTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Save selection in field^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Drops the currently selected line IDs in the specified field.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set page item to value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page item to the value passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_ITEM_LABEL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set field identifier to value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the identifier of the referenced page element to the value passed as parameter.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_NULL_DISABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Empty page item and disable^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page element to <span style="font-family:courier new,courier,monospace">NULL </span>and disables it on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_NULL_HIDE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Empty page item and hide^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page element to <span style="font-family:courier new,courier,monospace">NULL </span>and hides it on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SET_VALUE_ONLY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Set field to value, do not trigger recursion^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Sets the referenced page element to the transferred value without triggering further recursions</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ERROR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show error^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Shows the error message passed as parameter on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show target^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Shows the referenced page item on the page.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SHOW_TIP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show note^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Display a note in the message region</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_STOP_RULE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Stop rule^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Terminates the currently running rule and does not allow recursive execution of further rules.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SUBMIT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Submit page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Checks all mandatory fields and validations and submits the page if there are no errors.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_SUBMIT_WO_VALIDATION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Submit page, no validation^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Submits the page without prior validation.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_TOGGLE_ITEMS',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show and hide page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Controls the display of multiple page elements by showing the page elements identified by the first parameter and hiding the page elements identified by the second parameter</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_VALIDATE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Validate page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Validates mandatory items and validations but does not submit the page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_WAIT_FOR_REFRESH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Show waiting spinner until APEX refresh has completed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Make sure a wait spinner will be shown on the page until an APEX refresh action has been completed successfully.<br>The region/element to be updated must be indicated as page element.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Choose exactly one value^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Makes sure that exactly one of the elements from attribute 1 contains a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CAT_XOR_NN',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select exactly one value, NOT_NULL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Makes sure that exactly one of the elements from attribute 1 contains a value. NULL is not allowed</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Select rule group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Export all rule groups^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Export rule groups of application "#1#"^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Export rule groups of application  page "#1#"^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_EXPORT_LABEL_CGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Export rule Group #1#^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CGR_REGION_HEADING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Rule overview »#1#« (#2#)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items of the application^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_DATE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (date)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items that contain a date^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^The action is not assigned to a specific page element^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ENABLE_DISABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page items that can be activated and deactivated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items that can be activated and deactivated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items or jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_NONE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^No page items^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_NUMBER_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (number)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items containing a number^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page items of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items of the application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All buttons of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All buttons of the actual application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>All application and page elements of the current application page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM_OR_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All input fields or no specific entry^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_ITEM_OR_JQUERY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item or jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page items or jQuery selector^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_PAGE_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Regions of the application page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All regions of the actual application page^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIF_REFRESHABLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page elements that can be updated^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^All page elements that can be updated^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_AFTER_REFRESH',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^After refresh^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_APP_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Application item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DATE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (date)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DIALOG_CLOSED',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Dialog closed^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DOCUMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Document^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_DOUBLE_CLICK',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Double click^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ELEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ENTER_KEY',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Enter key^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_FIRING_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Firing Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_INITIALIZING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Initialize Flag^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_NUMBER_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item (number)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CIT_REGION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Region^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_APEX_ACTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page command^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>existing page commands of the rule group.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL function or package function<br>No need to specify a terminating semicolon.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JAVA_SCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Java Script expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executable JavaScript expression, no function definition</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JAVA_SCRIPT_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>name of a JavaScript function or anonymous function definition/IIFE</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_JQUERY_SELECTOR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^jQuery selector^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>jQuery expression to handle multiple elements. If this parameter is used, <code>DOCUMENT</code> must be entered as the outgoing element.</p>.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page item^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>page item or region of the current page</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PIT_MESSAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p> Identifier of a PIT message in the form msg.NAME or 'NAME', must be an existing message.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_PROCEDURE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL procedure^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>An existing PL/SQL procedure or package procedure<br>No need to specify a terminating semicolon.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_SEQUENCE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Sequence^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>name of an existing sequence</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_SQL_STATEMENT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^SQL statement^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>executable SELECT-statement, no semicolon required.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>Simple character string.<br>The character string is surrounded by quotation marks, so it is not necessary to enter these characters.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_FUNCTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or PL/SQL function^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If the value is passed with single quotation marks, it is output as constant text.<br>If the parameter is passed without quotation marks, it is interpreted as a PL/SQL function that returns a value.</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_JAVASCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or JavaScript-expression^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Can contain the following values:</p><ul><li>A constant. It must be enclosed in quotation marks or be a number</li><li>A JavaScript expression that is calculated at runtime</li><li>Empty string. In this case the value of the session state is used (this can be calculated in advance)</li></ul>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CPT_STRING_OR_PIT_MESSAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^String or message name^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^<p>If not enclosed with quotation marks, a PIT message name of the form msg.NAME</p>^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CRA_NO_HELP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^No help available, please select an action type.^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_BUTTON',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_IG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Interactive Grid^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for the Interactive Grid^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Page items^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for input fields^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_JAVA_SCRIPT',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^JavaScript^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript methods and events^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_PAGE_ITEM',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^All page elements^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Actions for all page element^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_PL_SQL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^PL/SQL^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^PL/SQL methods^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTG_ADC',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Framework^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Generic actions^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_ACTION',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Command/Link^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^JavaScript or PL/SQL command, alternatively reference^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_RADIO_GROUP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Option group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Select list, radio buttons^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'CTY_TOGGLE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^ADC^',
    p_pti_name => q'^Button^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^Toggle (YES/NO)^'
  );

  commit;
end;
/