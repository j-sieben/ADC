create or replace force view sadc_ui_menu_catitems as
select null status, 
       cat_name label_value,
       replace(q'^javascript:de.condes.plugin.adc.executeCommand({'command':'get-cat-item','data':'#CAT_ID#'});^', '#CAT_ID#', cat_id) target_value, 
       'YES' is_current, 
       'fa fa-arrow-right' image_value, 
       null image_attr_value, 
       null image_alt_value, 
       null attribute_01, 
       null attribute_02, 
       cat_catg_id
  from adc_action_types_v
 order by cat_name;
 