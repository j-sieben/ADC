create or replace package body adca_ui
as

  /**
    Package: ADCA_UI Body
               Implementation of the GUI logic of the ADC APEX application
    
    Author::
      Juergen Sieben, ConDeS GmbH
  */


  /**
    Group: Private package constants
   */
  C_PAGE_PREFIX constant adc_util.ora_name_type := utl_apex.get_page_prefix;
  C_REGION_PREFIX constant adc_util.ora_name_type := replace(C_PAGE_PREFIX, 'P', 'R');
  C_PTI_PMG constant adc_util.ora_name_type := 'ADCA';
  C_ADC constant adc_util.ora_name_type := 'ADC';
  C_REGION_CAPT_STATIC_LIST_FORM constant adc_util.ora_name_type := C_REGION_PREFIX || 'EDIT_CAPT_STATIC_LIST_FORM';
  C_REGION_CAPT_SELECT_LIST constant adc_util.ora_name_type := C_REGION_PREFIX || 'EDIT_CAPT_SELECT_LIST'; 
  
  C_VISUAL_TYPE_SELECT constant adc_util.ora_name_type := 'SELECT_LIST';
  C_VISUAL_TYPE_STATIC constant adc_util.ora_name_type := 'STATIC_LIST';
    
  /**
    Group: Type definitions
   */
  
  /**
    Group: Private Methods
   */
  procedure copy_edit_cat(
    p_row out nocopy adca_ui_edit_cat%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cat');
    
    p_row.cat_id := adc_util.clean_adc_name(utl_apex.get_string('cat_id'));
    p_row.cat_catg_id := adc_util.clean_adc_name(utl_apex.get_string('cat_catg_id'));
    p_row.cat_caif_id := adc_util.clean_adc_name(utl_apex.get_string('cat_caif_id'));
    p_row.cat_cato_id := adc_util.clean_adc_name(utl_apex.get_string('cat_cato_id'));
    p_row.cat_name := utl_apex.get_string('cat_name');
    p_row.cat_display_name := utl_apex.get_string('cat_display_name');
    p_row.cat_description := utl_apex.get_string('cat_description');
    p_row.cat_pl_sql := utl_apex.get_string('cat_pl_sql');
    p_row.cat_js := utl_apex.get_string('cat_js');
    p_row.cat_is_editable := utl_apex.get_string('cat_is_editable');
    p_row.cat_raise_recursive := utl_apex.get_string('cat_raise_recursive');
    p_row.cat_active := utl_apex.get_string('cat_active');
    p_row.cap_capt_id_1 := utl_apex.get_string('cap_capt_id_1');
    p_row.cap_display_name_1 := utl_apex.get_string('cap_display_name_1');
    p_row.cap_description_1 := utl_apex.get_string('cap_description_1');
    p_row.cap_default_1 := utl_apex.get_string('cap_default_1');
    p_row.cap_mandatory_1 := utl_apex.get_string('cap_mandatory_1');
    p_row.cap_active_1 := utl_apex.get_string('cap_active_1');
    p_row.cap_capt_id_2 := utl_apex.get_string('cap_capt_id_2');
    p_row.cap_display_name_2 := utl_apex.get_string('cap_display_name_2');
    p_row.cap_description_2 := utl_apex.get_string('cap_description_2');
    p_row.cap_default_2 := utl_apex.get_string('cap_default_2');
    p_row.cap_mandatory_2 := utl_apex.get_string('cap_mandatory_2');
    p_row.cap_active_2 := utl_apex.get_string('cap_active_2');
    p_row.cap_capt_id_3 := utl_apex.get_string('cap_capt_id_3');
    p_row.cap_display_name_3 := utl_apex.get_string('cap_display_name_3');
    p_row.cap_description_3 := utl_apex.get_string('cap_description_3');
    p_row.cap_default_3 := utl_apex.get_string('cap_default_3');
    p_row.cap_mandatory_3 := utl_apex.get_string('cap_mandatory_3');
    p_row.cap_active_3 := utl_apex.get_string('cap_active_3');
    
    pit.leave_detailed;
  end copy_edit_cat;


  procedure copy_edit_cif(
    p_row out nocopy adc_action_item_focus_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cif');
  
    p_row.caif_id := adc_util.clean_adc_name(utl_apex.get_string('caif_id'));
    p_row.caif_name := utl_apex.get_string('caif_name');
    p_row.caif_description := utl_apex.get_string('caif_description');
    p_row.caif_item_types := utl_apex.get_string('caif_item_types');
    p_row.caif_actual_page_only := utl_apex.get_string('caif_actual_page_only');
    p_row.caif_active := utl_apex.get_string('caif_active');
    p_row.caif_default := utl_apex.get_string('caif_default');
  
    pit.leave_detailed;
  end copy_edit_cif;


  procedure copy_edit_cpit(
    p_row out nocopy adc_page_item_types_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cpit');
  
    p_row.cpit_id := adc_util.clean_adc_name(utl_apex.get_string('cpit_id'));
    p_row.cpit_name := utl_apex.get_string('cpit_name');
    p_row.cpit_cpitg_id := utl_apex.get_string('cpit_cpitg_id');
    p_row.cpit_has_value := utl_apex.get_string('cpit_has_value');
    p_row.cpit_include_in_view := utl_apex.get_string('cpit_include_in_view');
    p_row.cpit_cet_id := utl_apex.get_string('cpit_cet_id');
    p_row.cpit_col_template := utl_apex.get_string('cpit_col_template');
    p_row.cpit_init_template := utl_apex.get_string('cpit_init_template');
  
    pit.leave_detailed;
  end copy_edit_cpit;
  

  procedure copy_edit_catg(
    p_row out nocopy adc_action_type_groups_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_catg');
  
    p_row.catg_id := adc_util.clean_adc_name(utl_apex.get_string('catg_id'));
    p_row.catg_name := utl_apex.get_string('catg_name');
    p_row.catg_description := utl_apex.get_string('catg_description');
    p_row.catg_active := utl_apex.get_string('catg_active');
  
    pit.leave_detailed;
  end copy_edit_catg;
  
  
  procedure copy_edit_cato(
    p_row out nocopy adc_action_type_owners_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_cato');
  
    p_row.cato_id := utl_apex.get_string('cato_id');
    p_row.cato_description := utl_apex.get_string('cato_description');
    p_row.cato_active := coalesce(utl_apex.get_string('cato_active'), utl_apex.C_TRUE);
  
    pit.leave_detailed;
  end copy_edit_cato;
  
  
  procedure copy_edit_csm(
    p_row out nocopy adc_standard_messages_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_csm');
  
    p_row.csm_id := utl_apex.get_string('csm_id');
    p_row.csm_message := utl_apex.get_string('csm_message');
    p_row.csm_description := utl_apex.get_string('csm_description');
  
    pit.leave_detailed;
  end copy_edit_csm;
  

  procedure copy_edit_capt(
    p_row out nocopy adc_action_param_types_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_capt');
  
    p_row.capt_id := adc_util.clean_adc_name(utl_apex.get_string('capt_id'));
    p_row.capt_name := utl_apex.get_string('capt_name');
    p_row.capt_description := utl_apex.get_string('capt_description');
    p_row.capt_capvt_id := utl_apex.get_string('capt_capvt_id');
    p_row.capt_select_list_query := utl_apex.get_string('capt_select_list_query');
    p_row.capt_select_view_comment := utl_apex.get_string('capt_select_view_comment');
    p_row.capt_sort_seq := utl_apex.get_number('capt_sort_seq');
    p_row.capt_active := utl_apex.get_string('capt_active');
  
    pit.leave_detailed;
  end copy_edit_capt;
    

  procedure copy_edit_capt_static_list(
    p_row out nocopy adca_ui_edit_capt_static_list%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_capt_static_list');
  
    p_row.csl_capt_id := utl_apex.get_string('capt_id');
    p_row.csl_pti_id := p_row.csl_capt_id || '_' || adc_util.clean_adc_name(utl_apex.get_string('csl_pti_id'));
    p_row.csl_name := utl_apex.get_string('csl_name');
  
    pit.leave_detailed;
  end copy_edit_capt_static_list;
  
  
  /** 
    Procedure: copy_row_to_cat_record
      Helper method to cast the complex view <ADCA_UI_EDIT_CAT> to a record of type <ADC_ACTION_TYPES>%ROWTYPE
    
    Parameters:
      p_row - Instance of the collection
      p_rec - Output record
   */
  procedure copy_row_to_cat_record(
    p_row in adca_ui_edit_cat%rowtype,
    p_rec out nocopy adc_action_types_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_cat_record');
    
    p_rec.cat_id := p_row.cat_id;
    p_rec.cat_catg_id := p_row.cat_catg_id;
    p_rec.cat_caif_id := p_row.cat_caif_id;
    p_rec.cat_cato_id := p_row.cat_cato_id;
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
      Helper method to cast the complex view ADCA_UI_EDIT_CAT to three record instances of type adc_action_parameters_v%ROWTYPE
 
    Parameters:
      p_row - Record with the pivoted param_1 .. param_3 values
      p_rec - Output record
   */
  procedure copy_row_to_cap_records(
    p_row in adca_ui_edit_cat%rowtype,
    p_rec_1 out nocopy adc_action_parameters_v%rowtype,
    p_rec_2 out nocopy adc_action_parameters_v%rowtype,
    p_rec_3 out nocopy adc_action_parameters_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_cap_records');
    
    -- Parameter 1
    p_rec_1.cap_cat_id := p_row.cat_id;
    p_rec_1.cap_capt_id := p_row.cap_capt_id_1;
    p_rec_1.cap_display_name := p_row.cap_display_name_1;
    p_rec_1.cap_description := p_row.cap_description_1;
    p_rec_1.cap_default := p_row.cap_default_1;
    p_rec_1.cap_mandatory := p_row.cap_mandatory_1;
    p_rec_1.cap_active := p_row.cap_active_1;
    p_rec_1.cap_sort_seq := 1;
    -- Parameter 2
    p_rec_2.cap_cat_id := p_row.cat_id;
    p_rec_2.cap_capt_id := p_row.cap_capt_id_2;
    p_rec_2.cap_display_name := p_row.cap_display_name_2;
    p_rec_2.cap_description := p_row.cap_description_2;
    p_rec_2.cap_default := p_row.cap_default_2;
    p_rec_2.cap_mandatory := p_row.cap_mandatory_2;
    p_rec_2.cap_active := p_row.cap_active_2;
    p_rec_2.cap_sort_seq := 2;
    -- Parameter 3
    p_rec_3.cap_cat_id := p_row.cat_id;
    p_rec_3.cap_capt_id := p_row.cap_capt_id_3;
    p_rec_3.cap_display_name := p_row.cap_display_name_3;
    p_rec_3.cap_description := p_row.cap_description_3;
    p_rec_3.cap_default := p_row.cap_default_3;
    p_rec_3.cap_mandatory := p_row.cap_mandatory_3;
    p_rec_3.cap_active := p_row.cap_active_3;
    p_rec_3.cap_sort_seq := 3;
    
    pit.leave_detailed;
  end copy_row_to_cap_records;
  

  /* 
    Group: Public Methods
   */
  /** 
    Function: process_export_cat
      See <adca_ui.process_export_cat>
   */
  procedure process_export_cat
  as
    l_export_type pit_translatable_item_v.pti_id%type;
    l_zip_file blob;
    l_zip_file_name adc_util.sql_char := 'action_types.zip';
  begin
    pit.enter_mandatory;
    
    l_export_type := utl_apex.get_value('EXPORT_TYPE');
    utl_apex.assert(
      p_condition => l_export_type in (adc_admin.C_EXPORT_ALL, adc_admin.C_EXPORT_USER, adc_admin.C_EXPORT_SYSTEM), 
      p_message_name => msg.ADCA_UNKNOWN_ACTION,
      p_msg_args => msg_args(l_export_type));
    
    -- generate ZIP with the requested action types and download.
    l_zip_file := adc_admin.export_action_types(
                    p_mode => l_export_type);
    
    if l_zip_file is not null then
      utl_apex.download_blob(l_zip_file, l_zip_file_name);
    end if;
    
    pit.leave_mandatory;
  end process_export_cat;
  
    
  /** 
    Function: process_export_crg
      See <adca_ui.process_export_crg>
   */
  procedure process_export_crg
  as
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_app_alias adc_util.ora_name_type;
    l_mode adc_util.ora_name_type;
    l_zip_file_name adc_util.sql_char;
    l_zip_file blob;
    l_application_filename adc_util.ora_name_type := param.get_string('APPLICATION_FILENAME', C_ADC);
    l_dynamic_pages_filename adc_util.ora_name_type := param.get_string('DYNAMIC_PAGES_FILENAME', C_ADC);
  begin
    pit.enter_mandatory;

    l_crg_app_id := utl_apex.get_number('CRG_APP_ID');
    
    if utl_apex.get_boolean('INCLUDE_APP') then
      l_mode := adc_admin.C_APEX_APP;
      l_zip_file_name := replace(l_application_filename, '#APP_ID#', l_crg_app_id);
    else
      l_mode := adc_admin.C_APP_GROUPS;
      select alias
        into l_app_alias
        from apex_applications
       where application_id = l_crg_app_id;
      l_zip_file_name := replace(l_dynamic_pages_filename, '#APP_ALIAS#', l_app_alias);
    end if;

    -- generate ZIP with the requested rule group files and download.
    l_zip_file := adc_admin.export_rule_groups(
                    p_crg_app_id => l_crg_app_id,
                    p_mode => l_mode);
                    
    pit.leave_mandatory;
    
    utl_apex.download_blob(
      p_blob => l_zip_file, 
      p_file_name => l_zip_file_name);
  exception
    when others then
      pit.panic;
  end process_export_crg;
  
    
  /** 
    Function: get_export_type
      See <adca_ui.get_export_type>
   */
  function get_export_type
    return varchar2
  as
    l_export_type adc_util.ora_name_type;
  begin
    pit.enter_detailed;

    case when utl_apex.get_value('CRG_PAGE_ID') is not null then
      l_export_type := 'PAGE';
    when utl_apex.get_value('CRG_APP_ID') is not null then
      l_export_type := 'APP';
    else
      l_export_type := 'ALL_CGR';
    end case;

    pit.leave_detailed;
    return l_export_type;
  end get_export_type;
  
    
  /** 
    Function: validate_edit_cif
      See <adca_ui.validate_edit_cif>
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
    Procedure: process_edit_cif
      See <adca_ui.process_edit_cif>
   */
  procedure process_edit_cif
  as
    l_row adc_action_item_focus_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cif(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_item_focus(l_row);
    when utl_apex.deleting then
      adc_admin.delete_action_item_focus(l_row);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_cif;
  
  
  /** 
    Function: validate_edit_cpit
      See <adca_ui.validate_edit_cpit>
   */
  function validate_edit_cpit
    return boolean
  as
    l_row adc_page_item_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cpit(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_page_item_type(l_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ERROR_CODE', 'ASSIGNED_ITEM'));
      return true;
  end validate_edit_cpit;


  /** 
    Procedure: process_edit_cpit
      See <adca_ui.process_edit_cpit>
   */
  procedure process_edit_cpit
  as
    l_row adc_page_item_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cpit(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_page_item_type(l_row);
    when utl_apex.deleting then
      adc_admin.delete_page_item_type(l_row);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_cpit;
  
    
  /** 
    Function: validate_edit_cat
      See <adca_ui.validate_edit_cat>
   */
  function validate_edit_cat
    return boolean
  as
    l_row adca_ui_edit_cat%rowtype;
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
        'CAT_CATG_ID_MISSING', 'CAT_CATG_ID',
        'CAT_CAIF_ID_MISSING', 'CAT_CAIF_ID',
        'CAT_CATO_ID_MISSING', 'CAT_CATO_ID',
        'CAT_NAME_MISSING', 'CAT_NAME'));
    
    pit.leave_mandatory;
    return true;
  end validate_edit_cat;
  
    
  /** 
    Procedure: process_edit_cat
      See <adca_ui.process_edit_cat>
   */
  procedure process_edit_cat
  as
    l_row adca_ui_edit_cat%rowtype;
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

      if l_cap_rec_1.cap_capt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_1);
      else
        adc_admin.delete_action_parameter(l_cap_rec_1);
      end if;

      if l_cap_rec_2.cap_capt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_2);
      else
        adc_admin.delete_action_parameter(l_cap_rec_2);
      end if;

      if l_cap_rec_3.cap_capt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_3);
      else
        adc_admin.delete_action_parameter(l_cap_rec_3);
      end if;

    when utl_apex.deleting then
      adc_admin.delete_action_type(l_cat_rec);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_cat;
  
    
  /** 
    Function: validate_edit_catg
      See <adca_ui.validate_edit_catg>
   */
  function validate_edit_catg
    return boolean
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_catg(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_type_group(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when others then
      utl_apex.handle_bulk_errors(char_table(
        'CATG_ID_MISSING', 'CATG_ID',
        'CATG_NAME_MISSING', 'CATG_NAME'
        ));
      return true;
  end validate_edit_catg;
  
    
  /** 
    Procedure: process_edit_catg
      See <adca_ui.process_edit_catg>
   */
  procedure process_edit_catg
  as
    l_row adc_action_type_groups_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_catg(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type_group(l_row);
    when utl_apex.deleting then
      adc_admin.delete_action_type_group(l_row);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_catg;
  
    
  /** 
    Function: validate_edit_cato
      See <adca_ui.validate_edit_cato>
   */
  function validate_edit_cato
    return boolean
  as
    l_row adc_action_type_owners_v%rowtype;
  begin
    pit.enter_mandatory;
  
    copy_edit_cato(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_type_owner(l_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'CATO_ID_MISSING', 'CATO_ID'));
      return true;
  end validate_edit_cato;
  
    
  /** 
    Procedure: process_edit_cato
      See <adca_ui.process_edit_cato>
   */
  procedure process_edit_cato
  as
    l_row adc_action_type_owners_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cato(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type_owner(l_row);
    else
      adc_admin.delete_action_type_owner(l_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_cato;
  
    
  /** 
    Function: validate_edit_csm
      See <adca_ui.validate_edit_csm>
   */
  function validate_edit_csm
    return boolean
  as
    l_row adc_standard_messages_v%rowtype;
  begin
    pit.enter_mandatory;
  
    copy_edit_csm(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_standard_message(l_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'CSM_ID_MISSING', 'CSM_ID',
        'CSM_MESSAGE_MISSING', 'CSM_MESSAGE',
        msg.ADC_CSM_WRONG_PREFIX, 'CSM_ID'));
      return true;
  end validate_edit_csm;
  
    
  /** 
    Procedure: process_edit_csm
      See <adca_ui.process_edit_csm>
   */
  procedure process_edit_csm
  as
    l_row adc_standard_messages_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_csm(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_standard_message(l_row);
    else
      adc_admin.delete_standard_message(l_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_csm;
  
  
  /** 
    Function: handle_capvt_changed
      See <adca_ui.handle_capvt_changed>
   */
  procedure handle_capvt_changed
  as
    l_capt_capvt_id adc_action_param_types.capt_capvt_id%type;
    l_select_list_status adc_util.ora_name_type := adc.C_HIDE;
    l_static_list_status adc_util.ora_name_type := adc.C_HIDE;
  begin
    pit.enter_mandatory;
    
    l_capt_capvt_id := utl_apex.get_string('CAPT_CAPVT_ID');
    
    case l_capt_capvt_id
      when C_VISUAL_TYPE_SELECT then
        adc.refresh_item(C_REGION_CAPT_SELECT_LIST);
        l_select_list_status := adc.C_SHOW_ENABLE;
      when C_VISUAL_TYPE_STATIC then
        adc.set_item(
          p_cpi_id => 'P5_CAPT_SELECT_LIST_QUERY', 
          p_item_value => to_char(null));
        adc.refresh_item(C_REGION_CAPT_STATIC_LIST_FORM);
        l_static_list_status := adc.C_SHOW_ENABLE;
      else
        null;
    end case;
    
    adc.set_visual_state(
      p_cpi_id => C_REGION_CAPT_SELECT_LIST,
      p_visual_state => l_select_list_status);
    adc.set_visual_state(
      p_cpi_id => C_REGION_CAPT_STATIC_LIST_FORM,
      p_visual_state => l_static_list_status);
    
    pit.leave_mandatory;
  end handle_capvt_changed;
  
    
  /** 
    Function: validate_edit_capt
      See <adca_ui.validate_edit_capt>
   */
  function validate_edit_capt
    return boolean
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_capt(l_row);
    
    pit.start_message_collection;
    adc_admin.validate_action_param_type(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when others then
      utl_apex.handle_bulk_errors(char_table(
        'CAPT_ID_MISSING', 'CAPT_ID',
        'CAPT_NAME_MISSING', 'CAPT_NAME',
        'CAPT_CAPVT_ID_MISSING', 'CAPT_CAPVT_ID',
        'CAPVT_VIEW_STATEMENT_MISSING', 'CAPT_SELECT_LIST_QUERY'
        ));
      return true;
  end validate_edit_capt;
  
    
  /** 
    Function: process_edit_capt
      See <adca_ui.process_edit_capt>
   */
  procedure process_edit_capt
  as
    l_row adc_action_param_types_v%rowtype;
  begin
    pit.enter_mandatory;
        
    copy_edit_capt(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_param_type(l_row);
    when utl_apex.deleting then
      adc_admin.delete_action_param_type(l_row);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_capt;
  
    
  /** 
    Function: process_edit_capt_static_list
      See <adca_ui.process_edit_capt_static_list>
   */
  procedure process_edit_capt_static_list
  as
    l_row adca_ui_edit_capt_static_list%rowtype;
  begin
    pit.enter_mandatory;
        
    copy_edit_capt_static_list(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_translatable_item(
        p_pti_id => l_row.csl_pti_id,
        p_pti_pmg_name => C_ADC,
        p_pti_pml_name => pit.get_default_language,
        p_pti_name => l_row.csl_name);
    when utl_apex.deleting then
      pit_admin.delete_translatable_item(
        p_pti_id => l_row.csl_pti_id,
        p_pti_pmg_name => C_ADC);
    else
      adc.register_error(
        p_cpi_id => adc_util.C_NO_FIRING_ITEM, 
        p_message_name => msg.ADCA_UNKNOWN_ACTION,
        p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_capt_static_list;
  
  
  /** 
    Function: set_action_export_crg
      See <adca_ui.set_action_export_crg>
   */
  procedure set_action_export_crg
  as
    l_crg_app_id adc_rule_groups.crg_app_id%type;
    l_include_app adc_util.flag_type;
    l_action varchar2(100);
    
    C_SUCCESS_COMMAND constant varchar2(100) := q'^apex.submit('EXPORT_#TYPE#');^';
  begin
    pit.enter_mandatory;
    
    -- Initialization
    l_crg_app_id := utl_apex.get_number('CRG_APP_ID');
    l_include_app := utl_apex.get_string('INCLUDE_APP');
    
    l_action := replace(C_SUCCESS_COMMAND, '#TYPE#', case l_include_app when adc_util.C_TRUE then adc_admin.C_APEX_APP else adc_admin.C_APP_GROUPS end);
    
    -- harmonize apex action
    adc_apex_action.action_init('export-rule-group');

    if l_crg_app_id is not null then
      adc_apex_action.set_label(pit.get_trans_item_name(C_PTI_PMG, 'CRG_EXPORT_LABEL_APP', msg_args(to_char(l_crg_app_id))));
      adc_apex_action.set_disabled(false);
      adc_apex_action.set_action(l_action);
    else
      adc_apex_action.set_label(pit.get_trans_item_name(C_PTI_PMG, 'CRG_EXPORT_LABEL_NO_APP'));
      adc_apex_action.set_action(null);
      adc_apex_action.set_disabled(true);
    end if;
    
    adc_apex_action.register_action_script;

    pit.leave_mandatory;
  exception
    when others then
      adc.register_error('DOCUMENT', sqlerrm, pit_util.get_call_stack);
      pit.leave_mandatory;
  end set_action_export_crg;
  
  
  /** 
    Function: process_edit_cat_exclude
      See <adca_ui.process_edit_cat_exclude>
   */
  procedure process_edit_cat_exclude
  as
    l_exclude_list adc_util.max_char;
  begin
    pit.enter_mandatory;
    
    l_exclude_list := utl_apex.get_string('P16_ADC_ACTION_TYPES');
    param.set_string('ADC_EXCLUDE_ACTION_TYPES', C_ADC, l_exclude_list, 'ALLE');
  end process_edit_cat_exclude;

end adca_ui;
/