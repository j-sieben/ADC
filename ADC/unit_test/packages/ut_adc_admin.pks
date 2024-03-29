create or replace package ut_adc_admin 
  authid definer
as

   --%suite(ADC ADMIN Tests)
   --%suitepath(ut_adc_admin)

   --%test
   procedure map_id;

   --%test
   procedure merge_rule_group;

   --%test
   procedure delete_rule_group;

   --%test
   procedure validate_rule_group;

   --%test
   procedure propagate_rule_change;

   --%test
   procedure export_rule_group;

   --%test
   procedure export_rule_groups;

   --%test
   procedure prepare_rule_group_import;

   --%test
   procedure merge_apex_action_type;

   --%test
   procedure delete_apex_action_type;

   --%test
   procedure validate_apex_action_type;

   --%test
   procedure merge_apex_action;

   --%test
   procedure delete_apex_action;

   --%test
   procedure validate_apex_action;

   --%test
   procedure merge_apex_action_item;

   --%test
   procedure delete_apex_action_item;

   --%test
   procedure validate_apex_action_item;

   --%test
   procedure merge_rule;

   --%test
   procedure delete_rule;

   --%test
   procedure validate_rule;

   --%test
   procedure resequence_rule;

   --%test
   procedure merge_action_type_group;

   --%test
   procedure delete_action_type_group;

   --%test
   procedure validate_action_type_group;

   --%test
   procedure merge_action_param_type;

   --%test
   procedure delete_action_param_type;

   --%test
   procedure validate_action_param_type;

   --%test
   procedure merge_action_item_focus;

   --%test
   procedure delete_action_item_focus;

   --%test
   procedure validate_action_item_focus;

   --%test
   procedure merge_action_type;

   --%test
   procedure delete_action_type;

   --%test
   procedure validate_action_type;

   --%test
   procedure export_action_types;

   --%test
   procedure merge_action_parameter;

   --%test
   procedure delete_action_parameter;

   --%test
   procedure validate_action_parameter;

   --%test
   procedure merge_rule_action;

   --%test
   procedure delete_rule_action;

   --%test
   procedure validate_rule_action;

   --%test
   procedure add_translation;

end ut_adc_admin;
/
