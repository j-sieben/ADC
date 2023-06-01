create or replace force view adca_ui_edit_catg
as 
select catg_id, catg_name, catg_description, catg_active,
       case
         (select count(*)
            from dual
           where exists (
                 select null
                   from adc_action_types
                  where cat_catg_id = catg_id))
         when 1 then 'U'
         else 'UD'
       end allowed_operations
  from adc_action_type_groups_v;

comment on table adca_ui_edit_catg is 'View for APEX page EDIT_CATG';