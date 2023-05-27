create or replace package adca_ui_designer
  authid definer
as

  /** 
    Package: ADCA_UI_DESIGNER
      Maintain ADC rules via an APEX frontend.
      This package implements the methods required to maintain ADC rule groups via an APEX applications ADC designer.
      
      Flow: The ADC Designer is a one pager that allows to administer a complete set of ADC rules. Its design is 
      inspired by the APEX page designer and completely controled by ADC. No additional JavaScript libraries are required.
      
      The <splitter_plugin> used on the page is a plugin published by FOS.
      
      The ADC designer is controlled mainly by APEX Actions. They control the buttons on the page and are used for the
      sub menu in the hierarchy tree. This package controls the visible aspects of the APEX Actions as well as their
      behavior. The behavior is to inform ADC that they were invoked, but based on the environment, they pass different
      values back to the database that helps in deciding upon the next steps to perform.
      
      At the center of the logic is table <Tables.ADCA_UI_MAP_DESIGNER_ACTIONS>. It persists information required to calculate 
      the next status of the ADC Designer. 
      The persisted data is enriched with actual session data in view <Views.ADC_BL_DESIGNER_ACTIONS>. 
      This view is used as a decision table for the package, making the decision logic data driven.
      
      Based on the actual situation the ADC designer is in, a row of this view is selected. The attributes of this
      row are taken to calculate the action to perform and to decide opon the next status of the APEX Actions.
      
      Because of this architectur, this package is mainly focusing on putting together the code for the next cycle 
      of the APEX Actions and to collect the required data and pass it to the XAPI methods of <ADC_ADMIN>.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
   */
  
  
  /**
    Function: get_lov_sql
      Method to retrieve a select statement that reads values for a given
      Action Parameter of type SELECT_LIST
                
    Parameters:
      p_capt_id - Type of the Action Parameter
      p_crg_id - ID of the rule group. Is used to filter the LOV statement
    
    Returns:
      Select statement to be executed by the ADC_UI to retrieve values for an Action Parameter#
      of type SELECT_LIST
   */
  function get_lov_sql(
    p_capt_id in adc_action_param_types.capt_id%type,
    p_crg_id in adc_rule_groups.crg_id%type)
    return varchar2;
     
    
  /** 
    Procedure: handle_activity
      Handles selection changes in the hierarchy tree to control the visual appearance of the page.
      
      Is used to deduct the Rule Group ID (CRG) from the selected entry in the designer tree.
      It then sets the value and refreshes the rule group report if the value has changed.
      Plus, it analyzes which level has been selected and calls the respective SHOW_FORM method
   */
  procedure handle_activity;
  
  
  /**
    Procedure: handle_cat_changed
      Method is called if the user changes the Action Type of a Rule Action.
      
      It adjust the parameter settings of the CRA form accordingly
   */
  procedure handle_cat_changed;
    
    
  /** 
    Procedure: toggle_crg_active
      Is called to activate or deactivate a rule group
   */
  procedure toggle_crg_active;
    
    
  /** 
    Procedure: validate_rule_condition
      Method to check a technical rule condition
      
      Is used to validate only the rule condition dynamically if it is changed by the user
   */
  procedure validate_rule_condition;
  
  
  /**
    Procedure: check_parameter_value
      Checks a manually entered parameter value against its parameter type
      
      Is used to check whether an entered parameter value makes sense.
   */
  procedure check_parameter_value;
  
  
  /**
    Function: support_flows
      Method checks whether flows has to be supported by the designer
      
    Returns:
      C_TRUE, if Flows for APEX is installed and C_FALSE otherwise.
   */
  function support_flows
    return adc_util.flag_type;
  
end adca_ui_designer;
/