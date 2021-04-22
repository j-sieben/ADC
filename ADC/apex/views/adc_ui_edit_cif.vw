create or replace editionable view adc_ui_edit_cif
as 
select cif_id, cif_name, cif_description, cif_actual_page_only, cif_item_types, cif_active,
       case
         (select count(*)
            from dual
           where exists (
                 select null
                   from adc_action_types
                  where cat_cif_id = cif_id))
         when 1 then 'U'
         else 'UD'
       end allowed_operations
  from adc_action_item_focus_v;

comment on table adc_ui_edit_cif is 'View for APEX page EDIT_SIF';