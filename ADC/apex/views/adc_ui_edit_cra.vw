create or replace editionable view adc_ui_edit_cra
as 
select seq_id,
       n001 cra_id,
       n002 cra_cgr_id,
       n003 cra_cru_id,
       c001 cra_cpi_id,
       c002 cra_cat_id,
       c003 cra_param_1,
       c003 cra_param_lov_1,
       c003 cra_param_area_1,
       c004 cra_param_2,
       c004 cra_param_lov_2,
       c004 cra_param_area_2,
       c005 cra_param_3,
       c005 cra_param_lov_3,
       c005 cra_param_area_3,
       c006 cra_comment,
       c007 cra_on_error,
       c008 cra_raise_recursive,
       n004 cra_sort_seq,
       c009 cra_active,
       c010 cra_has_error
  from apex_collections
 where collection_name = 'ADC_UI_EDIT_CRA';
 
comment on table adc_ui_edit_cra is 'Collection View auf ADC_RULE_ACTION, nicht refaktorisieren, um zeitgleiche Erstellung von Regel und Aktionen zu ermoeglichen.';