create or replace editionable view adc_ui_edit_cif
as 
with cif_references as (
       select cat_cif_id, count(*) ref_amount
         from adc_action_types
        group by cat_cif_id)
select cif_id, cif_name, cif_description, cif_actual_page_only, cif_item_types, cif_active,
       coalesce(ref_amount, 0) ref_amount,
       case coalesce(ref_amount, 0)
         when 0 then 'UD'
         else 'U'
       end allowed_operations
  from adc_action_item_focus_v
  left join cif_references
    on cif_id = cat_cif_id;

comment on table adc_ui_edit_cif is 'View for APEX page EDIT_CIF';