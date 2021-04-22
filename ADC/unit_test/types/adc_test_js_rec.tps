create or replace type adc_test_js_rec as object(
  script varchar2(4000 byte),
  hash raw(2000),
  debug_level number(5,0)
);
/
