@&tool_dir.check_has_column ADC_PAGE_ITEMS CPI_VALIDATION_METHOD "varchar2(200 byte)"

@&tool_dir.check_has_column ADC_PAGE_ITEMS CPI_MAY_HAVE_VALUE "&FLAG_TYPE. default on null '&C_FALSE.' constraint c_cpi_may_have_value_nn not null"

comment on column adc_page_items.cpi_form_region_id is 'Optional static ID of the form region a page item belongs to';


@&tool_dir.check_has_column ADC_PAGE_ITEMS CPI_FORM_REGION_ID "varchar2(50 char)"

comment on column adc_page_items.cpi_form_region_id is 'Optional static ID of the form region a page item belongs to';
