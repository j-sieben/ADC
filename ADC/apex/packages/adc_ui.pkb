create or replace package body adc_ui
as

  /**
    Package: ADC_UI Body
               Implementation of the GUI logic of the ADC APEX application
    
    Author::
      Juergen Sieben, ConDeS GmbH
  */


  /**
    Group: Private package constants
   */
  C_PAGE_PREFIX constant adc_util.ora_name_type := utl_apex.get_page_prefix;
  C_REGION_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'R');
  C_BUTTON_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'B');
  C_PTI_PMG constant adc_util.ora_name_type := 'ADC_UI';
  C_ADC constant adc_util.ora_name_type := 'ADC';
  C_REGION_CPT_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'EDIT_CPT_FORM';
  C_REGION_CPT_STATIC_LIST_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'EDIT_CPT_STATIC_LIST_FORM';
  C_REGION_CPT_SELECT_LIST constant adc_util.ora_name_type := C_REGION_PREFIX || 'EDIT_CPT_SELECT_LIST'; 
  
  C_VISUAL_TYPE_SELECT constant adc_util.ora_name_type := 'SELECT_LIST';
  C_VISUAL_TYPE_STATIC constant adc_util.ora_name_type := 'STATIC_LIST';

  /**
    Group: Private package variables
   */
  /**
    Variables: State variables
      g_page_values - PL/SQL table to hold key value pairs for page items (key) and their values
  */
  g_page_values utl_apex.page_value_t;
    
  /**
    Group: Type definitions
   */
  
  /**
    Group: Private Methods
   */
  procedure copy_edit_cat(
    p_row in out nocopy adc_ui_edit_cat%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cat');
    
    g_page_values := utl_apex.get_page_values('EDIT_CAT_FORM');
    p_row.cat_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_ID'));
    p_row.cat_ctg_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_CTG_ID'));
    p_row.cat_cif_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_CIF_ID'));
    p_row.cat_name := utl_apex.get(g_page_values, 'CAT_NAME');
    p_row.cat_display_name := utl_apex.get(g_page_values, 'CAT_DISPLAY_NAME');
    p_row.cat_description := utl_apex.get(g_page_values, 'CAT_DESCRIPTION');
    p_row.cat_pl_sql := utl_apex.get(g_page_values, 'CAT_PL_SQL');
    p_row.cat_js := utl_apex.get(g_page_values, 'CAT_JS');
    p_row.cat_is_editable := utl_apex.get(g_page_values, 'CAT_IS_EDITABLE');
    p_row.cat_raise_recursive := utl_apex.get(g_page_values, 'CAT_RAISE_RECURSIVE');
    p_row.cat_active := utl_apex.get(g_page_values, 'CAT_ACTIVE');
    p_row.cap_cpt_id_1 := utl_apex.get(g_page_values, 'CAP_CPT_ID_1');
    p_row.cap_display_name_1 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_1');
    p_row.cap_description_1 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_1');
    p_row.cap_default_1 := utl_apex.get(g_page_values, 'CAP_DEFAULT_1');
    p_row.cap_mandatory_1 := utl_apex.get(g_page_values, 'CAP_MANDATORY_1');
    p_row.cap_active_1 := utl_apex.get(g_page_values, 'CAP_ACTIVE_1');
    p_row.cap_cpt_id_2 := utl_apex.get(g_page_values, 'CAP_CPT_ID_2');
    p_row.cap_display_name_2 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_2');
    p_row.cap_description_2 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_2');
    p_row.cap_default_2 := utl_apex.get(g_page_values, 'CAP_DEFAULT_2');
    p_row.cap_mandatory_2 := utl_apex.get(g_page_values, 'CAP_MANDATORY_2');
    p_row.cap_active_2 := utl_apex.get(g_page_values, 'CAP_ACTIVE_2');
    p_row.cap_cpt_id_3 := utl_apex.get(g_page_values, 'CAP_CPT_ID_3');
    p_row.cap_display_name_3 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_3');
    p_row.cap_description_3 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_3');
    p_row.cap_default_3 := utl_apex.get(g_page_values, 'CAP_DEFAULT_3');
    p_row.cap_mandatory_3 := utl_apex.get(g_page_values, 'CAP_MANDATORY_3');
    p_row.cap_active_3 := utl_apex.get(g_page_values, 'CAP_ACTIVE_3');
    
    pit.leave_detailed;
  end copy_edit_cat;


  procedure copy_edit_cif(
    p_row in out nocopy adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cif');
  
    g_page_values := utl_apex.get_page_values('EDIT_CIF_FORM');
    p_row.cif_id := utl_apex.get(g_page_values, 'cif_id');
    p_row.cif_name := utl_apex.get(g_page_values, 'cif_name');
    p_row.cif_description := utl_apex.get(g_page_values, 'cif_description');
    p_row.cif_item_types := utl_apex.get(g_page_values, 'cif_item_types');
    --p_row.cif_default := utl_apex.get(g_page_values, 'cif_default');
    p_row.cif_actual_page_only := utl_apex.get(g_page_values, 'cif_actual_page_only');
    p_row.cif_active := utl_apex.get(g_page_values, 'cif_active');
  
    pit.leave_detailed;
  end copy_edit_cif;
  

  procedure copy_edit_ctg(
    p_row in out nocopy adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_ctg');
  
    g_page_values := utl_apex.get_page_values('EDIT_CTG_FORM');
    p_row.ctg_id := utl_apex.get(g_page_values, 'ctg_id');
    p_row.ctg_name := utl_apex.get(g_page_values, 'ctg_name');
    p_row.ctg_description := utl_apex.get(g_page_values, 'ctg_description');
    p_row.ctg_active := utl_apex.get(g_page_values, 'ctg_active');
  
    pit.leave_detailed;
  end copy_edit_ctg;
  

  procedure copy_edit_cpt(
    p_row in out nocopy adc_action_param_types_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cpt');
  
    g_page_values := utl_apex.get_page_values(C_REGION_CPT_FORM);
    p_row.cpt_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'cpt_id'));
    p_row.cpt_name := utl_apex.get(g_page_values, 'cpt_name');
    p_row.cpt_description := utl_apex.get(g_page_values, 'cpt_description');
    p_row.cpt_cpv_id := utl_apex.get(g_page_values, 'cpt_cpv_id');
    p_row.cpt_select_list_query := utl_apex.get_string('cpt_select_list_query');
    p_row.cpt_select_view_comment := utl_apex.get_string('cpt_select_view_comment');
    p_row.cpt_sort_seq := utl_apex.get(g_page_values, 'cpt_sort_seq');
    p_row.cpt_active := utl_apex.get(g_page_values, 'cpt_active');
  
    pit.leave_detailed;
  end copy_edit_cpt;
    

  procedure copy_edit_cpt_static_list(
    p_row in out nocopy adc_ui_edit_cpt_static_list%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cpt_static_list');
  
    g_page_values := utl_apex.get_page_values(C_REGION_CPT_STATIC_LIST_FORM);
    p_row.csl_cpt_id := utl_apex.get_string('P5_CPT_ID');
    p_row.csl_pti_id := p_row.csl_cpt_id || '_' || adc_util.clean_adc_name(utl_apex.get(g_page_values, 'csl_pti_id'));
    p_row.csl_name := utl_apex.get(g_page_values, 'csl_name');
  
    pit.leave_detailed;
  end copy_edit_cpt_static_list;
  
  
  /** 
    Procedure: copy_row_to_cat_record
      Helper method to cast the complex view <ADC_UI_EDIT_CAT> to a record of type <ADC_ACTION_TYPES>%ROWTYPE
    
    Parameters:
      p_row - Instance of the collection
      p_rec - Output record
   */
  procedure copy_row_to_cat_record(
    p_row in adc_ui_edit_cat%rowtype,
    p_rec out nocopy adc_action_types_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_cat_record');
    
    p_rec.cat_id := p_row.cat_id;
    p_rec.cat_ctg_id := p_row.cat_ctg_id;
    p_rec.cat_cif_id := p_row.cat_cif_id;
    p_rec.cat_name := p_row.cat_name;
    p_rec.cat_display_name := p_row.cat_display_name;
    p_rec.cat_description := p_row.cat_description;
    p_rec.cat_pl_sql := p_row.cat_pl_sql;
    p_rec.cat_js := p_row.cat_js;
    p_rec.cat_is_editable := p_row.cat_is_editable;
    p_rec.cat_raise_recursive := p_row.cat_raise_recursive;
    p_rec.cat_active := p_row.cat_active;
    
    pit.leave_detailed;
  end copy_row_to_cat_record;
  
  
  /** 
    Procedure: copy_row_to_cap_records
      Helper method to cast the complex view ADC_UI_EDIT_CAT to three record instances of type adc_action_parameters_v%ROWTYPE
 
    Parameters:
      p_row - Record with the pivoted param_1 .. param_3 values
      p_rec - Output record
   */
  procedure copy_row_to_cap_records(
    p_row in adc_ui_edit_cat%rowtype,
    p_rec_1 out nocopy adc_action_parameters_v%rowtype,
    p_rec_2 out nocopy adc_action_parameters_v%rowtype,
    p_rec_3 out nocopy adc_action_parameters_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_cap_records');
    
    -- Parameter 1
    p_rec_1.cap_cat_id := p_row.cat_id;
    p_rec_1.cap_cpt_id := p_row.cap_cpt_id_1;
    p_rec_1.cap_display_name := p_row.cap_display_name_1;
    p_rec_1.cap_description := p_row.cap_description_1;
    p_rec_1.cap_default := p_row.cap_default_1;
    p_rec_1.cap_mandatory := p_row.cap_mandatory_1;
    p_rec_1.cap_active := p_row.cap_active_1;
    p_rec_1.cap_sort_seq := 1;
    -- Parameter 2
    p_rec_2.cap_cat_id := p_row.cat_id;
    p_rec_2.cap_cpt_id := p_row.cap_cpt_id_2;
    p_rec_2.cap_display_name := p_row.cap_display_name_2;
    p_rec_2.cap_description := p_row.cap_description_2;
    p_rec_2.cap_default := p_row.cap_default_2;
    p_rec_2.cap_mandatory := p_row.cap_mandatory_2;
    p_rec_2.cap_active := p_row.cap_active_2;
    p_rec_2.cap_sort_seq := 2;
    -- Parameter 3
    p_rec_3.cap_cat_id := p_row.cat_id;
    p_rec_3.cap_cpt_id := p_row.cap_cpt_id_3;
    p_rec_3.cap_display_name := p_row.cap_display_name_3;
    p_rec_3.cap_description := p_row.cap_description_3;
    p_rec_3.cap_default := p_row.cap_default_3;
    p_rec_3.cap_mandatory := p_row.cap_mandatory_3;
    p_rec_3.cap_active := p_row.cap_active_3;
    p_rec_3.cap_sort_seq := 3;
    
    pit.leave_detailed;
  end copy_row_to_cap_records;
  
  
  /**
    Procedure: initialize
      Method to initialize the ADC_UI package
      
      Initially collects the name of all ADC Desginer page items per
      form region and persists them in an internal data structure for
      convenient access when working with the page designer.
   */
  procedure initialize
  as
  begin
    null;
  end initialize;
  

  /* 
    Group: Public Methods
   */
   
  /** 
    Function: C_TRUE
      See <ADC_UI.C_TRUE>
   */
  function c_true
    return adc_util.flag_type
  as
  begin
    return adc_util.C_TRUE;
  end c_true;
  
    
  /** 
    Function: C_FALSE
      See <ADC_UI.C_FALSE>
   */
  function c_false
    return adc_util.flag_type
  as
  begin
    return adc_util.C_FALSE;
  end c_false;
  
    
  /** 
    Function: process_export_cat
      See <ADC_UI.process_export_cat>
   */
  procedure process_export_cat
  as
    l_export_type pit_translatable_item_v.pti_id%type;
    l_cat_is_editable adc_action_types.cat_is_editable%type;
    l_zip_file blob;
    l_zip_file_name adc_util.sql_char := 'action_types.zip';
    
    C_EXPORT_ALL constant pit_translatable_item_v.pti_id%type := 'CAT_EXPORT_ALL';
    C_EXPORT_USER constant pit_translatable_item_v.pti_id%type := 'CAT_EXPORT_USER';
    C_EXPORT_SYSTEM constant pit_translatable_item_v.pti_id%type := 'CAT_EXPORT_SYSTEM';
  begin
    pit.enter_mandatory;
    
    l_export_type := utl_apex.get_value('EXPORT_TYPE');
    
    case l_export_type
    when C_EXPORT_ALL then
      l_cat_is_editable := null;
    when C_EXPORT_USER then
      l_cat_is_editable := C_TRUE;
    when C_EXPORT_SYSTEM then
      l_cat_is_editable := C_FALSE;
    else
      null;
    end case;
    
    -- generate ZIP with the requested action types and download.
    l_zip_file := adc_admin.export_action_types(
                    p_cat_is_editable => l_cat_is_editable);
    utl_apex.download_blob(l_zip_file, l_zip_file_name);
    
    pit.leave_mandatory;
  end process_export_cat;
  
    
  /** 
    Function: process_export_cgr
      See <ADC_UI.process_export_cgr>
   */
  procedure process_export_cgr
  as
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
    l_mode adc_util.ora_name_type;
    l_zip_file_name adc_util.sql_char;
    l_zip_file blob;

    C_ZIP_CGR_FILE_NAME constant adc_util.ora_name_type := 'single_rule_group_#CGR_ID#.zip';
    C_ZIP_APEX_APP_NAME constant adc_util.ora_name_type := 'application_#APP_ID#.zip';
    C_ZIP_APP_RULES_NAME constant adc_util.ora_name_type := 'application_#APP_ID#_rule_groups.zip';
  begin
    pit.enter_mandatory;

    l_cgr_app_id := utl_apex.get_number('CGR_APP_ID');
    
    if utl_apex.get_string('INCLUDE_APP') = c_true then
      l_mode := adc_admin.C_APEX_APP;
      l_zip_file_name := replace(C_ZIP_APEX_APP_NAME, '#APP_ID#', l_cgr_app_id);
    else
      l_mode := adc_admin.c_APP_GROUPS;
      l_zip_file_name := replace(C_ZIP_APP_RULES_NAME, '#APP_ID#', l_cgr_app_id);
    end if;

    -- generate ZIP with the requested rule group files and download.
    l_zip_file := adc_admin.export_rule_groups(
                    p_cgr_app_id => l_cgr_app_id,
                    p_cgr_page_id => null,
                    p_mode => l_mode);
                    
    pit.leave_mandatory;
    
    utl_apex.download_blob(
      p_blob => l_zip_file, 
      p_file_name => l_zip_file_name);
  exception
    when others then
      pit.handle_exception(msg.SQL_ERROR, msg_args(substr(sqlerrm, 12)));
      raise;
  end process_export_cgr;
  
    
  /** 
    Function: get_export_type
      See <ADC_UI.get_export_type>
   */
  function get_export_type
    return varchar2
  as
    l_export_type adc_util.ora_name_type;
  begin
    pit.enter_detailed;

    case when utl_apex.get_value('CGR_PAGE_ID') is not null then
      l_export_type := 'PAGE';
    when utl_apex.get_value('CGR_APP_ID') is not null then
      l_export_type := 'APP';
    else
      l_export_type := 'ALL_CGR';
    end case;

    pit.leave_detailed;
    return l_export_type;
  end get_export_type;
  
    
  /** 
    Function: validate_edit_cif
      See <ADC_UI.validate_edit_cif>
   */
  function validate_edit_cif
    return boolean
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cif(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_item_focus(l_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ERROR_CODE', 'ASSIGNED_ITEM'));
      return true;
  end validate_edit_cif;
  
    
  /** 
    Function: process_edit_cif
      See <ADC_UI.process_edit_cif>
   */
  procedure process_edit_cif
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cif(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_item_focus(l_row);
    else
      adc_admin.delete_action_item_focus(l_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_cif;
  
    
  /** 
    Function: validate_edit_cat
      See <ADC_UI.validate_edit_cat>
   */
  function validate_edit_cat
    return boolean
  as
    l_row adc_ui_edit_cat%rowtype;
    l_cat_rec adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cat(l_row);

    pit.start_message_collection;
    copy_row_to_cat_record(l_row, l_cat_rec);
    adc_admin.validate_action_type(l_cat_rec);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'CAT_ID_MISSING', 'CAT_ID',
        'CAT_CTG_ID_MISSING', 'CAT_CTG_ID',
        'CAT_CIF_ID_MISSING', 'CAT_CIF_ID',
        'CAT_NAME_MISSING', 'CAT_NAME'));
    
    pit.leave_mandatory;
    return true;
  end validate_edit_cat;
  
    
  /** 
    Function: process_edit_cat
      See <ADC_UI.process_edit_cat>
   */
  procedure process_edit_cat
  as
    l_row adc_ui_edit_cat%rowtype;
    l_cat_rec adc_action_types_v%rowtype;
    l_cap_rec_1 adc_action_parameters_v%rowtype;
    l_cap_rec_2 adc_action_parameters_v%rowtype;
    l_cap_rec_3 adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cat(l_row);

    copy_row_to_cat_record(l_row, l_cat_rec);
    copy_row_to_cap_records(l_row, l_cap_rec_1, l_cap_rec_2, l_cap_rec_3);

    case
    when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type(l_cat_rec);
      
      adc_admin.delete_action_parameters(l_cat_rec.cat_id);

      if l_cap_rec_1.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_1);
      else
        adc_admin.delete_action_parameter(l_cap_rec_1);
      end if;

      if l_cap_rec_2.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_2);
      else
        adc_admin.delete_action_parameter(l_cap_rec_2);
      end if;

      if l_cap_rec_3.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_3);
      else
        adc_admin.delete_action_parameter(l_cap_rec_3);
      end if;

    when utl_apex.deleting then
      adc_admin.delete_action_type(l_cat_rec);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_cat;
  
    
  /** 
    Function: validate_edit_ctg
      See <ADC_UI.validate_edit_ctg>
   */
  function validate_edit_ctg
    return boolean
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_ctg(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_type_group(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when others then
      utl_apex.handle_bulk_errors(char_table(
        'CTG_ID_MISSING', 'CTG_ID',
        'CTG_NAME_MISSING', 'CTG_NAME'
        ));
      return true;
  end validate_edit_ctg;
  
    
  /** 
    Function: process_edit_ctg
      See <ADC_UI.process_edit_ctg>
   */
  procedure process_edit_ctg
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_ctg(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type_group(l_row);
    else
      adc_admin.delete_action_type_group(l_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_ctg;
  
  
  /** 
    Function: handle_cpv_changed
      See <ADC_UI.handle_cpv_changed>
   */
  procedure handle_cpv_changed
  as
    l_cpt_cpv_id adc_action_param_types.cpt_cpv_id%type;
    l_select_list_status adc_util.ora_name_type := adc.C_HIDE;
    l_static_list_status adc_util.ora_name_type := adc.C_HIDE;
  begin
    pit.enter_mandatory;
    
    l_cpt_cpv_id := utl_apex.get_string('CPT_CPV_ID');
    
    case l_cpt_cpv_id
      when C_VISUAL_TYPE_SELECT then
        adc.refresh_item(C_REGION_CPT_SELECT_LIST);
        l_select_list_status := adc.C_SHOW_ENABLE;
      when C_VISUAL_TYPE_STATIC then
        adc.set_item(
          p_cpi_id => 'P5_CPT_SELECT_LIST_QUERY', 
          p_item_value => to_char(null));
        adc.refresh_item(C_REGION_CPT_STATIC_LIST_FORM);
        l_static_list_status := adc.C_SHOW_ENABLE;
      else
        null;
    end case;
    
    adc.set_visual_state(
      p_cpi_id => C_REGION_CPT_SELECT_LIST,
      p_visual_state => l_select_list_status);
    adc.set_visual_state(
      p_cpi_id => C_REGION_CPT_STATIC_LIST_FORM,
      p_visual_state => l_static_list_status);
    
    pit.leave_mandatory;
  end handle_cpv_changed;
  
    
  /** 
    Function: validate_edit_cpt
      See <ADC_UI.validate_edit_cpt>
   */
  function validate_edit_cpt
    return boolean
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cpt(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_param_type(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when others then
      utl_apex.handle_bulk_errors(char_table(
        'CPT_ID_MISSING', 'CPT_ID',
        'CPT_NAME_MISSING', 'CPT_NAME',
        'CPT_CPV_ID_MISSING', 'CPT_CPV_ID',
        'CPV_VIEW_STATEMENT_MISSING', 'CPT_SELECT_LIST_QUERY'
        ));
      return true;
  end validate_edit_cpt;
  
    
  /** 
    Function: process_edit_cpt
      See <ADC_UI.process_edit_cpt>
   */
  procedure process_edit_cpt
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory;
        
    copy_edit_cpt(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_param_type(l_row);
    else
      adc_admin.delete_action_param_type(l_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_cpt;
  
    
  /** 
    Function: process_edit_cpt_static_list
      See <ADC_UI.process_edit_cpt_static_list>
   */
  procedure process_edit_cpt_static_list
  as
    l_row adc_ui_edit_cpt_static_list%rowtype;
  begin
    pit.enter_mandatory;
        
    copy_edit_cpt_static_list(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_translatable_item(
        p_pti_id => l_row.csl_pti_id,
        p_pti_pmg_name => C_ADC,
        p_pti_pml_name => pit.get_default_language,
        p_pti_name => l_row.csl_name);
    else
      pit_admin.delete_translatable_item(
        p_pti_id => l_row.csl_pti_id,
        p_pti_pmg_name => C_ADC);
    end case;
    
    pit.leave_mandatory;
  end process_edit_cpt_static_list;
  
  
  /** 
    Function: set_action_export_cgr
      See <ADC_UI.set_action_export_cgr>
   */
  procedure set_action_export_cgr
  as
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
    l_include_app adc_util.flag_type;
    l_action varchar2(100);
    
    C_SUCCESS_COMMAND constant varchar2(100) := q'^apex.submit('EXPORT_#TYPE#');^';
  begin
    pit.enter_mandatory;
    
    -- Initialization
    l_cgr_app_id := utl_apex.get_number('CGR_APP_ID');
    l_include_app := utl_apex.get_string('INCLUDE_APP');
    
    -- If select list values change, set dependent select lists to null and refresh
    if l_include_app = c_true then 
      l_action := adc_admin.C_APEX_APP;
    else
      l_action := adc_admin.C_APP_GROUPS;
    end if;
    l_action := replace(C_SUCCESS_COMMAND, '#TYPE#', l_action);
    
    -- harmonize apex action
    adc_apex_action.action_init('export-rule-group');

    if l_cgr_app_id is not null then
      adc_apex_action.set_label(pit.get_trans_item_name(C_PTI_PMG, 'CGR_EXPORT_LABEL_APP', msg_args(to_char(l_cgr_app_id))));
      adc_apex_action.set_disabled(false);
      adc_apex_action.set_action(l_action);
    else
      adc_apex_action.set_label(pit.get_trans_item_name(C_PTI_PMG, 'CGR_EXPORT_LABEL_NO_APP'));
      adc_apex_action.set_action(null);
      adc_apex_action.set_disabled(true);
    end if;
    
    adc.add_javascript(adc_apex_action.get_action_script);

    pit.leave_mandatory;
  exception
    when others then
      adc.register_error('DOCUMENT', sqlerrm, pit_util.get_call_stack);
      pit.leave_mandatory;
  end set_action_export_cgr;

begin
  initialize;
end adc_ui;
/
