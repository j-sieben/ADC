create or replace editionable view adca_ui_edit_cpit
as 
with cpit_references as (
       select cpi_cpit_id, count(*) ref_amount
         from adc_page_items
        group by cpi_cpit_id)
select cpit_id, cpit_name, cpit_cpitg_id, cpit_has_value, cpit_include_in_view, cpit_cet_id, cpit_col_template, cpit_init_template,
       coalesce(ref_amount, 0) ref_amount,
       case coalesce(ref_amount, 0)
         when 0 then 'UD'
         else 'U'
       end allowed_operations
  from adc_page_item_types_v
  left join cpit_references
    on cpit_id = cpi_cpit_id;

comment on table adca_ui_edit_cpit is 'View for APEX page EDIT_CPIT';