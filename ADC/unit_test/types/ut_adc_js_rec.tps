create or replace type ut_adc_js_rec 
  authid definer
as object(
  script varchar2(4000 byte),
  hash raw(2000),
  debug_level number(5,0)
);
/
