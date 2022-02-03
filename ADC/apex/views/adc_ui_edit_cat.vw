create or replace editionable view adc_ui_edit_cat
as 
select cat_id, cat_ctg_id, cat_cif_id, cat_name, cat_display_name, cat_description, cat_pl_sql, cat_js, cat_is_editable, cat_raise_recursive, cat_active,
       cap_cpt_id_1, cap_display_name_1, cap_description_1, cap_default_1, cap_mandatory_1, cap_active_1,
       cap_cpt_id_2, cap_display_name_2, cap_description_2, cap_default_2, cap_mandatory_2, cap_active_2,
       cap_cpt_id_3, cap_display_name_3, cap_description_3, cap_default_3, cap_mandatory_3, cap_active_3
  from adc_action_types_v
  left join (
        select cap_cat_id,
               max(decode(cap_sort_seq, 1, cap_cpt_id)) cap_cpt_id_1,
               max(decode(cap_sort_seq, 1, cap_display_name)) cap_display_name_1,
               max(decode(cap_sort_seq, 1, cap_description)) cap_description_1,
               max(decode(cap_sort_seq, 1, cap_default)) cap_default_1,
               max(decode(cap_sort_seq, 1, cap_mandatory)) cap_mandatory_1,
               max(decode(cap_sort_seq, 1, cap_active)) cap_active_1,
               max(decode(cap_sort_seq, 2, cap_cpt_id)) cap_cpt_id_2,
               max(decode(cap_sort_seq, 2, cap_display_name)) cap_display_name_2,
               max(decode(cap_sort_seq, 2, cap_description)) cap_description_2,
               max(decode(cap_sort_seq, 2, cap_default)) cap_default_2,
               max(decode(cap_sort_seq, 2, cap_mandatory)) cap_mandatory_2,
               max(decode(cap_sort_seq, 2, cap_active)) cap_active_2,
               max(decode(cap_sort_seq, 3, cap_cpt_id)) cap_cpt_id_3,
               max(decode(cap_sort_seq, 3, cap_display_name)) cap_display_name_3,
               max(decode(cap_sort_seq, 3, cap_description)) cap_description_3,
               max(decode(cap_sort_seq, 3, cap_default)) cap_default_3,
               max(decode(cap_sort_seq, 3, cap_mandatory)) cap_mandatory_3,
               max(decode(cap_sort_seq, 3, cap_active)) cap_active_3
          from adc_action_parameters_v
         group by cap_cat_id)
    on cat_id = cap_cat_id;

comment on table adc_ui_edit_cat is 'View for APEX page EDIT_CAF';