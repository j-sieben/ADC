create or replace editionable view adca_ui_edit_cato
as 
select cato_id, cato_description, cato_active,
       case cato_id
         when 'ADC' then null
         else
          (select case count(*) when 0 then 'UD' else 'U' end
            from dual
           where exists(
                 select null
                   from adc_action_types
                  where cat_cato_id = cato_id))
       end cato_authorization
  from adc_action_type_owners_v;

comment on table adca_ui_edit_cato is 'View for APEX page EDIT_CATO';