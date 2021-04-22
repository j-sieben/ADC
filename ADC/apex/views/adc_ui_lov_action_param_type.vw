create or replace force view ADC_UI_LOV_ACTION_PARAM_TYPE
as 
select CPT_NAME d, CPT_ID r, CPT_ACTIVE
  from ADC_ACTION_PARAM_TYPES_V;
