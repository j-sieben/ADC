create or replace editionable view adc_ui_edit_ctg
as 
select ctg_id, ctg_name, ctg_description, ctg_active,
       case
         (select count(*)
            from dual
           where exists (
                 select null
                   from adc_action_types
                  where cat_ctg_id = ctg_id))
         when 1 then 'U'
         else 'UD'
       end allowed_operations
  from adc_action_type_groups_v;

comment on table adc_ui_edit_ctg is 'View for APEX page EDIT_CTG';