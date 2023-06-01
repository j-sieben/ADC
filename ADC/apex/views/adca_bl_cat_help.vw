create or replace force view adca_bl_cat_help
as 
  with params as(
       select uttm_mode, uttm_text template
         from utl_text_templates
        where uttm_type = 'ADC'
          and uttm_name = 'ACTION_TYPE_HELP')
select cat_id,
       utl_text.generate_text(cursor(
         select template,
                cat_name, cat_description,
                utl_text.generate_text(cursor(
                  select template,
                         cap_sort_seq, coalesce(cap_display_name, capt_name) capt_name, cap_description, capt_description
                    from adc_action_parameters_v p
                    join adc_action_param_types_v
                      on cap_capt_id = capt_id
                   cross join params
                   where p.cap_cat_id = s.cat_id
                     and uttm_mode = 'PARAMETERS'
                   order by cat_id, cap_sort_seq)) parameters
           from adc_action_types_v s
          cross join params
          where s.cat_id = sat.cat_id
            and uttm_mode = 'FRAME')) help_text
  from adc_action_types_v sat;

comment on table adca_bl_cat_help is 'Business logic view to put together a help text for the UI Designer';
comment on column adca_bl_cat_help.cat_id is 'ID of the action type, reference to <Tables.ADC_ACTION_TYPES>';
comment on column adca_bl_cat_help.help_text is 'Translated and combined help text from the action type, their parameters and other sources.';