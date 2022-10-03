create or replace editionable view adc_ui_edit_cit
as 
with cit_references as (
       select cpi_cit_id, count(*) ref_amount
         from adc_page_items
        group by cpi_cit_id)
select cit_id, cit_name, cit_cig_id, cit_has_value, cit_include_in_view, cit_cet_id, cit_col_template, cit_init_template,
       coalesce(ref_amount, 0) ref_amount,
       case coalesce(ref_amount, 0)
         when 0 then 'UD'
         else 'U'
       end allowed_operations
  from adc_page_item_types_v
  left join cit_references
    on cit_id = cpi_cit_id;

comment on table adc_ui_edit_cit is 'View for APEX page EDIT_CIT';