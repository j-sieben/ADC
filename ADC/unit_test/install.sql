@tools/set_folder unit_test

prompt
prompt &section.
prompt &h1.Install ADC unit tests

prompt
prompt &section.
prompt &h2.Types

prompt &s1.Type ADC_TEST_JS_REC
@&TYPE_DIR.adc_test_js_rec.tps

prompt &s1.Type ADC_TEST_JS_LIST
@&TYPE_DIR.adc_test_js_list.tps

prompt &s1.Type ADC_TEST_ROW
@&TYPE_DIR.adc_test_row.tps

prompt &s1.Type ADC_TEST_LIST
@&TYPE_DIR.adc_test_list.tps

prompt &s1.Type ADC_TEST_RESULT
@&TYPE_DIR.adc_test_result.tps

prompt &s1.Type Body ADC_TEST_RESULT
@&TYPE_DIR.adc_test_result.tpb

prompt
prompt &section.
prompt &h2.Tables
prompt &s1.Table ADC_TEST_OUTCOME
@&TABLE_DIR.adc_test_outcome.tbl

prompt
prompt &section.
prompt &h2.Packages
prompt &s1.Package ADC_TEST
@&PKG_DIR.adc_test.pks


prompt &s1.Package Body ADC_APEX
@&PKG_DIR.adc_test.pkb

--prompt
--prompt &section.
--prompt &h2.APEX application
--prompt &h3.Prepare APEX import
--@&UT_DIR.prepare_app_import.sql

--prompt &h3.Install application
--@&APEX_DIR.utl_apex.sql

-- After APEX installation, reset output settings
@&tool_dir.re_init_apex.sql

prompt
prompt &section.
prompt &h1.Installation of UTL_APEX unit tests complete