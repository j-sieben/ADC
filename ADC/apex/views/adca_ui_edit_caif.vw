create or replace editionable view adca_ui_edit_caif
as 
with caif_references as (
       select cat_caif_id, count(*) ref_amount
         from adc_action_types
        group by cat_caif_id)
select caif_id, caif_name, caif_description, caif_actual_page_only, caif_item_types, caif_active,
       coalesce(ref_amount, 0) ref_amount,
       case coalesce(ref_amount, 0)
         when 0 then 'UD'
         else 'U'
       end allowed_operations
  from adc_action_item_focus_v
  left join caif_references
    on caif_id = cat_caif_id;

comment on table adca_ui_edit_caif is 'View for APEX page EDIT_CIF';