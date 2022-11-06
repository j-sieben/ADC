create or replace force view sadc_ui_menu_cat as
select null status, label_value, target_value, is_current, image_value, image_attr_value, image_alt_value, attribute_01, attribute_02
  from apex_ui_list_menu
 where list_name = 'Desktop Navigation Menu'
   and level_value = 4
   and parent_page_alias = 'MENU_CAT'
 order by display_sequence;
 