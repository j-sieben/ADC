﻿NDFramePage.OnPageTitleLoaded("File:apex/packages/adca_ui_designer.pkb","adca_ui_designer.pkb");NDSummary.OnSummaryLoaded("File:apex/packages/adca_ui_designer.pkb",[["SQL","SQL"]],[["Classes","Class"],["Constants","Constant"],["Functions","Function"],["Groups","Group"],["Types","Type"],["Variables","Variable"]],[[56,0,0,"ADCA_UI_DESIGNER&nbsp; Body","ADCA_UI_DESIGNER_Body"],[57,0,3,"Private package constants","ADCA_UI_DESIGNER_Body.Private_package_constants"],[58,0,1,"Mode and Action constants","ADCA_UI_DESIGNER_Body.Mode_and_Action_constants"],[59,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_CRG"],[60,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_CRU"],[61,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_CRA"],[62,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_CAG"],[63,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_CAA"],[64,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_FLG"],[65,0,1,,"ADCA_UI_DESIGNER_Body.C_MODE_FLS"],[66,0,1,,"ADCA_UI_DESIGNER_Body.C_ACTION_CANCEL"],[67,0,1,,"ADCA_UI_DESIGNER_Body.C_ACTION_CREATE"],[68,0,1,,"ADCA_UI_DESIGNER_Body.C_ACTION_DELETE"],[70,0,1,,"ADCA_UI_DESIGNER_Body.C_ACTION_UPDATE"],[71,0,1,,"ADCA_UI_DESIGNER_Body.C_EXPORT_CRG"],[72,0,1,"Item and Region constants","ADCA_UI_DESIGNER_Body.Item_and_Region_constants"],[73,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CRG_APP_ID"],[74,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CRG_ID"],[75,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CRU_ID"],[76,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CRA_ID"],[77,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CAA_ID"],[78,0,1,,"ADCA_UI_DESIGNER_Body.C_ITEM_CRA_CAT_ID"],[79,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_RULES"],[80,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_HIERARCHY"],[81,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_HELP"],[82,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_CRG_FORM"],[83,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_CRU_FORM"],[84,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_CRA_FORM"],[85,0,1,,"ADCA_UI_DESIGNER_Body.C_REGION_CAA_FORM"],[86,0,3,"Type definitions","ADCA_UI_DESIGNER_Body.Type_definitions"],[87,0,4,"environment_rec","ADCA_UI_DESIGNER_Body.environment_rec"],[88,0,4,"form_item_list_tab","ADCA_UI_DESIGNER_Body.form_item_list_tab"],[89,0,3,"Private package variables","ADCA_UI_DESIGNER_Body.Private_package_variables"],[90,0,5,"State variables","ADCA_UI_DESIGNER_Body.State_variables"],[91,0,5,,"ADCA_UI_DESIGNER_Body.g_form_item_list"],[92,0,3,"Copy Session State methods","ADCA_UI_DESIGNER_Body.Copy_Session_State_methods"],[93,0,2,"copy_...","ADCA_UI_DESIGNER_Body.copy_..."],[94,0,3,"Private Methods","ADCA_UI_DESIGNER_Body.Private_Methods"],[95,0,2,"get_form_items","ADCA_UI_DESIGNER_Body.get_form_items"],[96,0,2,"assemble_action","ADCA_UI_DESIGNER_Body.assemble_action"],[97,0,1,"<span class=\"Qualifier\">assemble_action.</span>&#8203;C_ACTION_TEMPLATE","ADCA_UI_DESIGNER_Body.assemble_action.C_ACTION_TEMPLATE"],[98,0,2,"get_cra_sort_seq","ADCA_UI_DESIGNER_Body.get_cra_sort_seq"],[99,0,2,"get_cru_sort_seq","ADCA_UI_DESIGNER_Body.get_cru_sort_seq"],[100,0,2,"get_first_crg_for_app","ADCA_UI_DESIGNER_Body.get_first_crg_for_app"],[101,0,2,"maintain_actions","ADCA_UI_DESIGNER_Body.maintain_actions"],[102,0,2,"set_crg_id","ADCA_UI_DESIGNER_Body.set_crg_id"],[103,0,2,"set_id_values","ADCA_UI_DESIGNER_Body.set_id_values"],[104,0,2,"read_environment","ADCA_UI_DESIGNER_Body.read_environment"],[105,0,2,"validate_page","ADCA_UI_DESIGNER_Body.validate_page"],[106,0,2,"process_page","ADCA_UI_DESIGNER_Body.process_page"],[107,0,2,"set_cat_help_text","ADCA_UI_DESIGNER_Body.set_cat_help_text"],[108,0,2,"set_cra_param_settings","ADCA_UI_DESIGNER_Body.set_cra_param_settings"],[109,0,2,"show_form_caa","ADCA_UI_DESIGNER_Body.show_form_caa"],[110,0,2,"show_form_crg","ADCA_UI_DESIGNER_Body.show_form_crg"],[111,0,2,"show_form_cra","ADCA_UI_DESIGNER_Body.show_form_cra"],[112,0,2,"show_form_cru","ADCA_UI_DESIGNER_Body.show_form_cru"],[113,0,2,"show_form_fls","ADCA_UI_DESIGNER_Body.show_form_fls"],[114,0,2,"handle_dml","ADCA_UI_DESIGNER_Body.handle_dml"],[115,0,2,"maintain_visual_page_state","ADCA_UI_DESIGNER_Body.maintain_visual_page_state"],[116,0,2,"initialize","ADCA_UI_DESIGNER_Body.initialize"],[117,0,3,"Public Methods","ADCA_UI_DESIGNER_Body.Public_Methods"],[118,0,2,"get_lov_sql","ADCA_UI_DESIGNER_Body.get_lov_sql"],[119,0,2,"handle_activity","ADCA_UI_DESIGNER_Body.handle_activity"],[120,0,2,"handle_cat_changed","ADCA_UI_DESIGNER_Body.handle_cat_changed"],[121,0,2,"toggle_crg_active","ADCA_UI_DESIGNER_Body.toggle_crg_active"],[122,0,2,"validate_rule_condition","ADCA_UI_DESIGNER_Body.validate_rule_condition"],[123,0,2,"check_parameter_value","ADCA_UI_DESIGNER_Body.check_parameter_value"],[124,0,2,"support_flows","ADCA_UI_DESIGNER_Body.support_flows"]]);