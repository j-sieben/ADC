create or replace package body adc_ui
as

  C_CRA_COLLECTION constant adc_util.ora_name_type := 'ADC_UI_EDIT_CRA';
  C_CAA_COLLECTION constant adc_util.ora_name_type := 'ADC_UI_EDIT_CAA';
  
  C_PAGE_ADMIN_CGR constant binary_integer := 1;
  C_PAGE_EDIT_CGR constant binary_integer := 6;
  C_PAGE_EDIT_CRU constant binary_integer := 5;

  g_page_values utl_apex.page_value_t;
  g_collection_seq_id binary_integer;
  g_edit_caa_row adc_ui_edit_caa%rowtype;
  g_edit_cat_row adc_ui_edit_cat%rowtype;
  g_edit_cgr_row adc_rule_groups%rowtype;
  g_edit_cif_row adc_action_item_focus_v%rowtype;
  g_edit_cra_row adc_rule_actions%rowtype;
  g_edit_cru_row adc_rules%rowtype;
  g_edit_ctg_row adc_action_type_groups_v%rowtype;


  /** Helper to copy APEX session state values into type safe record structures
   * @usage  Is called to copy the actual session state values entered into a type safe record structure.
   *         Type casting is auto detected if APEX has knowledge of the type, fi by using a format mask.
   *         If this does not exist, it will try to find the type based on a fetch row process and a database column reference.
   */
  procedure copy_edit_cgr
  as
  begin
    pit.enter_detailed('copy_edit_cgr');
    
    g_page_values := utl_apex.get_page_values('EDIT_CGR_FORM');
    g_edit_cgr_row.cgr_id := to_number(utl_apex.get(g_page_values, 'CGR_ID'), '999990');
    g_edit_cgr_row.cgr_app_id := to_number(utl_apex.get(g_page_values, 'CGR_APP_ID'), 'fm9999999999990');
    g_edit_cgr_row.cgr_page_id := to_number(utl_apex.get(g_page_values, 'CGR_PAGE_ID'), 'fm9999999999990');
    g_edit_cgr_row.cgr_active := utl_apex.get(g_page_values, 'CGR_ACTIVE');
    g_edit_cgr_row.cgr_with_recursion := utl_apex.get(g_page_values, 'CGR_WITH_RECURSION');
    
    pit.leave_detailed;
  end copy_edit_cgr;


  procedure copy_edit_cru
  as
  begin
    pit.enter_detailed('copy_edit_cru');
    
    g_page_values := utl_apex.get_page_values('EDIT_CRU_FORM');
    g_edit_cru_row.cru_id := to_number(utl_apex.get(g_page_values, 'CRU_ID'), '999990');
    g_edit_cru_row.cru_cgr_id := to_number(utl_apex.get(g_page_values, 'CRU_CGR_ID'), '999990');
    g_edit_cru_row.cru_sort_seq := to_number(utl_apex.get(g_page_values, 'CRU_SORT_SEQ'), '999990');
    g_edit_cru_row.cru_name := utl_apex.get(g_page_values, 'CRU_NAME');
    g_edit_cru_row.cru_condition := utl_apex.get(g_page_values, 'CRU_CONDITION');
    g_edit_cru_row.cru_fire_on_page_load := utl_apex.get(g_page_values, 'CRU_FIRE_ON_PAGE_LOAD');
    g_edit_cru_row.cru_active := utl_apex.get(g_page_values, 'CRU_ACTIVE');

    pit.leave_detailed;
  end copy_edit_cru;


  procedure copy_edit_cra
  as
    l_param_name_1 adc_util.ora_name_type;
    l_param_name_2 adc_util.ora_name_type;
    l_param_name_3 adc_util.ora_name_type;
  begin
    pit.enter_detailed('copy_edit_cra');
    
    g_page_values := utl_apex.get_page_values('EDIT_CRA_FORM');
    g_collection_seq_id := to_number(utl_apex.get(g_page_values, 'SEQ_ID'), '999990');
    g_edit_cra_row.cra_id := to_number(utl_apex.get(g_page_values, 'CRA_ID'), '999990');
    g_edit_cra_row.cra_cgr_id := to_number(utl_apex.get(g_page_values, 'CRA_CGR_ID'), '999990');
    g_edit_cra_row.cra_cru_id := to_number(utl_apex.get(g_page_values, 'CRA_CRU_ID'), '999990');
    g_edit_cra_row.cra_sort_seq := to_number(utl_apex.get(g_page_values, 'CRA_SORT_SEQ'), '999990');
    g_edit_cra_row.cra_cpi_id := utl_apex.get(g_page_values, 'CRA_CPI_ID');
    g_edit_cra_row.cra_cat_id := utl_apex.get(g_page_values, 'CRA_CAT_ID');
    g_edit_cra_row.cra_active := utl_apex.get(g_page_values, 'CRA_ACTIVE');
    g_edit_cra_row.cra_on_error := utl_apex.get(g_page_values, 'CRA_ON_ERROR');
    g_edit_cra_row.cra_raise_recursive := utl_apex.get(g_page_values, 'CRA_RAISE_RECURSIVE');
    g_edit_cra_row.cra_comment := utl_apex.get(g_page_values, 'CRA_COMMENT');
    
    -- Get the required parameter field
    begin
      with data as (
           select cap_cat_id, cap_sort_seq, 
                  'CRA_PARAM_' ||
                  case cpt_item_type
                    when 'TEXT' then null
                    when 'SELECT_LIST' then 'LOV_'
                    when 'TEXT_AREA' then 'AREA_'
                  end || cap_sort_seq item_name
             from adc_action_parameters
             join adc_action_param_types
               on cap_cpt_id = cpt_id)
      select max(decode(cap_sort_seq, 1, item_name)) item_name_1,
             max(decode(cap_sort_seq, 2, item_name)) item_name_2,
             max(decode(cap_sort_seq, 3, item_name)) item_name_3
        into l_param_name_1, l_param_name_2, l_param_name_3
        from data
       where cap_cat_id = g_edit_cra_row.cra_cat_id
       group by cap_cat_id;
    exception
      when no_data_found then
        null; -- No parameter for action type, ignore
    end;
     
    g_edit_cra_row.cra_param_1 := case when l_param_name_1 is not null then utl_apex.get(g_page_values, l_param_name_1) end;
    g_edit_cra_row.cra_param_2 := case when l_param_name_2 is not null then utl_apex.get(g_page_values, l_param_name_2) end;
    g_edit_cra_row.cra_param_3 := case when l_param_name_3 is not null then utl_apex.get(g_page_values, l_param_name_3) end;    

    pit.leave_detailed;
  end copy_edit_cra;


  procedure copy_edit_caa
  as
  begin
    pit.enter_detailed('copy_edit_caa');
    
    g_page_values := utl_apex.get_page_values('EDIT_CAA_FORM');
    g_edit_caa_row.seq_id := to_number(utl_apex.get(g_page_values, 'SEQ_ID'), 'fm9999999999999990d999999999');
    g_edit_caa_row.caa_id := to_number(utl_apex.get(g_page_values, 'CAA_ID'), 'fm9999999999990d99999999');
    g_edit_caa_row.caa_cgr_id := to_number(utl_apex.get(g_page_values, 'CAA_CGR_ID'), 'fm9999999999990d99999999');
    g_edit_caa_row.caa_cty_id := utl_apex.get(g_page_values, 'CAA_CTY_ID');
    g_edit_caa_row.caa_name := utl_apex.get(g_page_values, 'CAA_NAME');
    g_edit_caa_row.caa_label := utl_apex.get(g_page_values, 'CAA_LABEL');
    g_edit_caa_row.caa_context_label := utl_apex.get(g_page_values, 'CAA_CONTEXT_LABEL');
    g_edit_caa_row.caa_icon := utl_apex.get(g_page_values, 'CAA_ICON');
    g_edit_caa_row.caa_icon_type := utl_apex.get(g_page_values, 'CAA_ICON_TYPE');
    g_edit_caa_row.caa_title := utl_apex.get(g_page_values, 'CAA_TITLE');
    g_edit_caa_row.caa_shortcut := utl_apex.get(g_page_values, 'CAA_SHORTCUT');
    g_edit_caa_row.caa_initially_disabled := utl_apex.get(g_page_values, 'CAA_INITIALLY_DISABLED');
    g_edit_caa_row.caa_initially_hidden := utl_apex.get(g_page_values, 'CAA_INITIALLY_HIDDEN');
    g_edit_caa_row.caa_href := utl_apex.get(g_page_values, 'CAA_HREF');
    g_edit_caa_row.caa_action := utl_apex.get(g_page_values, 'CAA_ACTION');
    g_edit_caa_row.caa_on_label := utl_apex.get(g_page_values, 'CAA_ON_LABEL');
    g_edit_caa_row.caa_off_label := utl_apex.get(g_page_values, 'CAA_OFF_LABEL');
    g_edit_caa_row.caa_get := utl_apex.get(g_page_values, 'CAA_GET');
    g_edit_caa_row.caa_set := utl_apex.get(g_page_values, 'CAA_SET');
    g_edit_caa_row.caa_choices := utl_apex.get(g_page_values, 'CAA_CHOICES');
    g_edit_caa_row.caa_label_classes := utl_apex.get(g_page_values, 'CAA_LABEL_CLASSES');
    g_edit_caa_row.caa_label_start_classes := utl_apex.get(g_page_values, 'CAA_LABEL_START_CLASSES');
    g_edit_caa_row.caa_label_end_classes := utl_apex.get(g_page_values, 'CAA_LABEL_END_CLASSES');
    g_edit_caa_row.caa_item_wrap_class := utl_apex.get(g_page_values, 'CAA_ITEM_WRAP_CLASS');
    g_edit_caa_row.caa_cai_list := utl_apex.get(g_page_values, 'CAA_CAI_LIST');
    
    pit.leave_detailed;
  end copy_edit_caa;


  procedure copy_edit_cat
  as
  begin
    pit.enter_detailed('copy_edit_cat');
    
    g_page_values := utl_apex.get_page_values('EDIT_CAT_FORM');
    g_edit_cat_row.cat_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_ID'));
    g_edit_cat_row.cat_ctg_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_CTG_ID'));
    g_edit_cat_row.cat_cif_id := adc_util.clean_adc_name(utl_apex.get(g_page_values, 'CAT_CIF_ID'));
    g_edit_cat_row.cat_name := utl_apex.get(g_page_values, 'CAT_NAME');
    g_edit_cat_row.cat_display_name := utl_apex.get(g_page_values, 'CAT_DISPLAY_NAME');
    g_edit_cat_row.cat_description := utl_apex.get(g_page_values, 'CAT_DESCRIPTION');
    g_edit_cat_row.cat_pl_sql := utl_apex.get(g_page_values, 'CAT_PL_SQL');
    g_edit_cat_row.cat_js := utl_apex.get(g_page_values, 'CAT_JS');
    g_edit_cat_row.cat_is_editable := utl_apex.get(g_page_values, 'CAT_IS_EDITABLE');
    g_edit_cat_row.cat_raise_recursive := utl_apex.get(g_page_values, 'CAT_RAISE_RECURSIVE');
    g_edit_cat_row.cat_active := utl_apex.get(g_page_values, 'CAT_ACTIVE');
    g_edit_cat_row.cap_cpt_id_1 := utl_apex.get(g_page_values, 'CAP_CPT_ID_1');
    g_edit_cat_row.cap_display_name_1 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_1');
    g_edit_cat_row.cap_description_1 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_1');
    g_edit_cat_row.cap_default_1 := utl_apex.get(g_page_values, 'CAP_DEFAULT_1');
    g_edit_cat_row.cap_mandatory_1 := utl_apex.get(g_page_values, 'CAP_MANDATORY_1');
    g_edit_cat_row.cap_active_1 := utl_apex.get(g_page_values, 'CAP_ACTIVE_1');
    g_edit_cat_row.cap_cpt_id_2 := utl_apex.get(g_page_values, 'CAP_CPT_ID_2');
    g_edit_cat_row.cap_display_name_2 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_2');
    g_edit_cat_row.cap_description_2 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_2');
    g_edit_cat_row.cap_default_2 := utl_apex.get(g_page_values, 'CAP_DEFAULT_2');
    g_edit_cat_row.cap_mandatory_2 := utl_apex.get(g_page_values, 'CAP_MANDATORY_2');
    g_edit_cat_row.cap_active_2 := utl_apex.get(g_page_values, 'CAP_ACTIVE_2');
    g_edit_cat_row.cap_cpt_id_3 := utl_apex.get(g_page_values, 'CAP_CPT_ID_3');
    g_edit_cat_row.cap_display_name_3 := utl_apex.get(g_page_values, 'CAP_DISPLAY_NAME_3');
    g_edit_cat_row.cap_description_3 := utl_apex.get(g_page_values, 'CAP_DESCRIPTION_3');
    g_edit_cat_row.cap_default_3 := utl_apex.get(g_page_values, 'CAP_DEFAULT_3');
    g_edit_cat_row.cap_mandatory_3 := utl_apex.get(g_page_values, 'CAP_MANDATORY_3');
    g_edit_cat_row.cap_active_3 := utl_apex.get(g_page_values, 'CAP_ACTIVE_3');
    
    pit.leave_detailed;
  end copy_edit_cat;


  procedure copy_edit_cif
  as
  begin
    pit.enter_detailed('copy_edit_cif');
  
    g_page_values := utl_apex.get_page_values('EDIT_CIF_FORM');
    g_edit_cif_row.cif_id := utl_apex.get(g_page_values, 'cif_id');
    g_edit_cif_row.cif_name := utl_apex.get(g_page_values, 'cif_name');
    g_edit_cif_row.cif_description := utl_apex.get(g_page_values, 'cif_description');
    g_edit_cif_row.cif_item_types := utl_apex.get(g_page_values, 'cif_item_types');
    g_edit_cif_row.cif_actual_page_only := utl_apex.get(g_page_values, 'cif_actual_page_only');
    g_edit_cif_row.cif_active := utl_apex.get(g_page_values, 'cif_active');
  
    pit.leave_detailed;
  end copy_edit_cif;
  

  procedure copy_edit_ctg
  as
  begin
    pit.enter_detailed('copy_edit_ctg');
  
    g_page_values := utl_apex.get_page_values('EDIT_CTG_FORM');
    g_edit_ctg_row.ctg_id := utl_apex.get(g_page_values, 'ctg_id');
    g_edit_ctg_row.ctg_name := utl_apex.get(g_page_values, 'ctg_name');
    g_edit_ctg_row.ctg_description := utl_apex.get(g_page_values, 'ctg_description');
    g_edit_ctg_row.ctg_active := utl_apex.get(g_page_values, 'ctg_active');
  
    pit.leave_detailed;
  end copy_edit_ctg;


  /** Helper method to cast the collection type of the CAA collection to a record
   *  of type adc_apex_actions_v%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_caa_record(
    p_row in adc_ui_edit_caa%rowtype,
    p_rec out nocopy adc_apex_actions_v%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_caa_record');
    
    p_rec.caa_id := p_row.caa_id;
    p_rec.caa_cgr_id := p_row.caa_cgr_id;
    p_rec.caa_cty_id := p_row.caa_cty_id;
    p_rec.caa_name := p_row.caa_name;
    p_rec.caa_label := p_row.caa_label;
    p_rec.caa_context_label := p_row.caa_context_label;
    p_rec.caa_icon := p_row.caa_icon;
    p_rec.caa_icon_type := p_row.caa_icon_type;
    p_rec.caa_title := p_row.caa_title;
    p_rec.caa_shortcut := p_row.caa_shortcut;
    p_rec.caa_initially_disabled := p_row.caa_initially_disabled;
    p_rec.caa_initially_hidden := p_row.caa_initially_hidden;
    -- ACTION
    p_rec.caa_href := p_row.caa_href;
    p_rec.caa_action := p_row.caa_action;
    -- TOGGLE
    p_rec.caa_on_label := p_row.caa_on_label;
    p_rec.caa_off_label := p_row.caa_off_label;
    -- TOGGLE | RADIO_GROUP
    p_rec.caa_get := p_row.caa_get;
    p_rec.caa_set := p_row.caa_set;
    -- RADIO_GROUP
    p_rec.caa_choices := p_row.caa_choices;
    p_rec.caa_label_classes := p_row.caa_label_classes;
    p_rec.caa_label_start_classes := p_row.caa_label_start_classes;
    p_rec.caa_label_end_classes := p_row.caa_label_end_classes;
    p_rec.caa_item_wrap_class := p_row.caa_item_wrap_class;
    
    pit.leave_detailed;
  end copy_row_to_caa_record;


  /** Helper method to cast the collection type of the SRA collection to a record
   *  of type adc_rule_actions%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_cra_record(
    p_row in adc_ui_edit_cra%rowtype,
    p_rec out nocopy adc_rule_actions%rowtype)
  as
  begin
    pit.enter_detailed('copy_row_to_cra_record');
    
    p_rec.cra_id := p_row.cra_id;
    p_rec.cra_cru_id := coalesce(p_row.cra_cru_id, g_edit_cru_row.cru_id);
    p_rec.cra_cgr_id := p_row.cra_cgr_id;
    p_rec.cra_cpi_id := p_row.cra_cpi_id;
    p_rec.cra_cat_id := p_row.cra_cat_id;
    p_rec.cra_sort_seq := p_row.cra_sort_seq;
    p_rec.cra_param_1 := p_row.cra_param_1;
    p_rec.cra_param_2 := p_row.cra_param_2;
    p_rec.cra_param_3 := p_row.cra_param_3;
    p_rec.cra_on_error := p_row.cra_on_error;
    p_rec.cra_raise_recursive := p_row.cra_raise_recursive;
    p_rec.cra_active := p_row.cra_active;
    p_rec.cra_comment := p_row.cra_comment;
    
    pit.leave_detailed;
  end copy_row_to_cra_record;
  
  
  /** Helper method to cast the complex view ADC_UI_EDIT_CAT to a record
   *  of type ADC_ACTION_TYPE%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
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
  
  
  /** Helper method to cast the complex view ADC_UI_EDIT_CAT to three record
   *  instances of type adc_action_parameters_v%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
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
  

  /* INTERFACE */
  function c_true
    return adc_util.flag_type
  as
  begin
    return adc_util.C_TRUE;
  end c_true;
  
    
  function c_false
    return adc_util.flag_type
  as
  begin
    return adc_util.C_FALSE;
  end c_false;
  
  
  function get_help_websheet_id
    return pls_integer
  as
  begin
    return utl_apex.get_help_websheet_id;
  end get_help_websheet_id;
  
  
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
  
  
  procedure process_export_cgr
  as
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
    l_cgr_page_id adc_rule_groups.cgr_page_id%type;
    l_cgr_id adc_rule_groups.cgr_id%type;
    l_mode adc_util.ora_name_type;
    l_zip_file_name adc_util.sql_char;
    l_zip_file blob;

    C_ZIP_CGR_FILE_NAME constant adc_util.ora_name_type := 'single_rule_group_#CGR_ID#.zip';
    C_ZIP_PAGE_RULES_NAME constant adc_util.ora_name_type := 'app_#APP_ID#_page_#PAGE_ID#_rule_groups.zip';
    C_ZIP_APP_RULES_NAME constant adc_util.ora_name_type := 'application_#APP_ID#_rule_groups.zip';
    C_ZIP_ALL_RULES_NAME constant adc_util.ora_name_type := 'all_rule_groups.zip';
  begin
    pit.enter_mandatory;

    l_cgr_app_id := utl_apex.get_number('CGR_APP_ID');
    l_cgr_page_id := utl_apex.get_number('CGR_PAGE_ID');
    l_cgr_id := utl_apex.get_number('CGR_ID');

    -- map request to export mode and set zip file name accordingly
    case when utl_apex.request_is('EXPORT_PAGE') then
      l_mode := adc_admin.C_PAGE_GROUPS;
      l_zip_file_name := replace(C_ZIP_PAGE_RULES_NAME, '#APP_ID#', l_cgr_app_id);
      l_zip_file_name := replace(C_ZIP_PAGE_RULES_NAME, '#PAGE_ID#', l_cgr_page_id);
    when utl_apex.request_is('EXPORT_APP') then
      l_mode := adc_admin.C_APP_GROUPS;
      l_zip_file_name := replace(C_ZIP_APP_RULES_NAME, '#APP_ID#', l_cgr_app_id);
    else
      l_mode := adc_admin.C_ALL_GROUPS;
      l_zip_file_name := C_ZIP_ALL_RULES_NAME;
    end case;

    -- generate ZIP with the requested rule group files and download.
    l_zip_file := adc_admin.export_rule_groups(
                    p_cgr_app_id => l_cgr_app_id,
                    p_cgr_page_id => l_cgr_page_id,
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


  procedure initialize_cra_collection
  as
    cursor cra_cur(p_cru_id in adc_rules.cru_id%type) is
      select *
        from adc_rule_actions
       where cra_cru_id = p_cru_id;
    l_cru_id adc_rules.cru_id%type;
  begin
    pit.enter_optional;
    
    -- Initialization
    l_cru_id := utl_apex.get_number('CRU_ID');
    apex_collection.create_or_truncate_collection(C_CRA_COLLECTION);
    
    for sra in cra_cur(l_cru_id) loop
      apex_collection.add_member(
        p_collection_name => c_cra_collection,
        p_n001 => sra.cra_id,
        p_n002 => sra.cra_cgr_id,
        p_n003 => sra.cra_cru_id,
        p_c001 => sra.cra_cpi_id,
        p_c002 => sra.cra_cat_id,
        p_n004 => sra.cra_sort_seq,
        p_c003 => sra.cra_param_1,
        p_c004 => sra.cra_param_2,
        p_c005 => sra.cra_param_3,
        p_c006 => sra.cra_comment,
        p_c007 => sra.cra_on_error,
        p_c008 => sra.cra_raise_recursive,
        p_c009 => sra.cra_active,
        p_generate_md5 => C_FALSE);
    end loop;

    pit.leave_optional;
  end initialize_cra_collection;


  procedure initialize_caa_collection
  as
    cursor caa_cur(p_cgr_id in adc_rule_groups.cgr_id%type) is
      select saa.*, sai.caa_cai_list
        from adc_apex_actions_v saa
        left join (
             select cai_caa_id, listagg(cai_cpi_id, ':') within group (order by cai_cpi_id) caa_cai_list
               from adc_apex_action_items
              group by cai_caa_id) sai
          on caa_id = cai_caa_id
       where caa_cgr_id = p_cgr_id;
    l_cgr_id adc_rule_groups.cgr_id%type;
  begin
    pit.enter_optional;
    
    -- Initialization
    l_cgr_id := utl_apex.get_number('CGR_ID');
    apex_collection.create_or_truncate_collection(C_CAA_COLLECTION);
    
    for saa in caa_cur(l_cgr_id) loop
      apex_collection.add_member(
        p_collection_name => C_CAA_COLLECTION,
        p_n001 => saa.caa_id,
        p_n002 => saa.caa_cgr_id,
        p_c001 => saa.caa_cty_id,
        p_c002 => saa.caa_name,
        p_c003 => saa.caa_label,
        p_c004 => saa.caa_context_label,
        p_c005 => saa.caa_icon,
        p_c006 => saa.caa_icon_type,
        p_c007 => saa.caa_title,
        p_c008 => saa.caa_shortcut,
        p_c009 => saa.caa_initially_disabled,
        p_c010 => saa.caa_initially_hidden,
        p_c011 => saa.caa_href,
        p_c012 => saa.caa_action,
        p_c013 => saa.caa_on_label,
        p_c014 => saa.caa_off_label,
        p_c015 => saa.caa_get,
        p_c016 => saa.caa_set,
        p_c017 => saa.caa_choices,
        p_c018 => saa.caa_label_classes,
        p_c019 => saa.caa_label_start_classes,
        p_c020 => saa.caa_label_end_classes,
        p_c021 => saa.caa_item_wrap_class,
        p_c022 => saa.caa_cai_list,
        p_generate_md5 => C_FALSE);
    end loop;

    pit.leave_optional;
  end initialize_caa_collection;


  /* Methods to maintain user entries on APEX pages */
  function validate_edit_cgr
    return boolean
  as
    l_exists binary_integer;
  begin
    pit.enter_mandatory;
    
    copy_edit_cgr;

    pit.start_message_collection;
    adc_admin.validate_rule_group(g_edit_cgr_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'CGR_APP_ID_MISSING', 'CGR_APP_ID',
        'CGR_PAGE_ID_MISSING', 'CGR_PAGE_ID',
        'ADC_CGR_MUST_BE_UNIQUE', 'CGR_PAGE_ID'));
        
    pit.leave_mandatory;
    return true;
  end validate_edit_cgr;
  
  
  /** Helper to extract apex actions maintenace from PROCESS_EDIT_CGR
   * %usage  APEX Actions are maintained using the collection API to allow for
   *         creation of APEX actions while the rule group does not yet exist (is created)
   *         This method harmonizes the entered APEX actions with the underlying table
   */
  procedure maintain_apex_actions
  as
    cursor missing_caa_cur (p_cgr_id in adc_rule_groups.cgr_id%TYPE) is
      select caa_id
        from adc_apex_actions
       where caa_cgr_id = p_cgr_id
         and caa_id not in (
             select caa_id
               from adc_ui_edit_caa);
               
    cursor caa_cur is
      select *
        from adc_ui_edit_caa;
        
    cursor existing_cai_cur(p_caa_id in adc_ui_edit_caa.caa_id%type) is
      select cai_caa_id
        from adc_apex_action_items
       where cai_caa_id = p_caa_id;
                
    cursor cai_cur (
      p_caa_id in adc_ui_edit_caa.caa_id%type,
      p_caa_cai_list in varchar2) 
    is
      select caa_id cai_caa_id, caa_cgr_id cai_cpi_cgr_id, column_value cai_cpi_id
        from adc_ui_edit_caa saa
       cross join table(utl_text.string_to_table(p_caa_cai_list))
       where caa_id = p_caa_id;
    l_caa_rec adc_apex_actions_v%rowtype;
    l_cai_rec adc_apex_action_items%rowtype;
  begin
    pit.enter_mandatory;
    
    -- Remove deleted apex actions
    for saa in missing_caa_cur(g_edit_cgr_row.cgr_id) loop
      adc_admin.delete_apex_action(saa.caa_id);
    end loop;
    
    -- Add list of apex actions
    for saa in caa_cur loop
      copy_row_to_caa_record(saa, l_caa_rec);
      adc_admin.merge_apex_action(l_caa_rec);

      -- Copy data from Collection and merge into ADC_APEX_ACTION_ITEM
      for sai in existing_cai_cur(saa.caa_id) loop
        adc_admin.delete_apex_action_item(sai.cai_caa_id);
      end loop;
      
      for sai in cai_cur(saa.caa_id, saa.caa_cai_list) loop
        -- Copy row to record locally
        l_cai_rec.cai_caa_id := sai.cai_caa_id;
        l_cai_rec.cai_cpi_cgr_id := sai.cai_cpi_cgr_id;
        l_cai_rec.cai_cpi_id := sai.cai_cpi_id;
        
        adc_admin.merge_apex_action_item(l_cai_rec);
      end loop;
    end loop;
    
    pit.leave_mandatory;
  end maintain_apex_actions;


  procedure process_edit_cgr
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_cgr;

    case when utl_apex.inserting then
      adc_admin.merge_rule_group(g_edit_cgr_row);
    when utl_apex.updating then
      adc_admin.merge_rule_group(g_edit_cgr_row);
      -- APEX actions can be created after creation of the rule group only
      maintain_apex_actions;
    when utl_apex.deleting then
      adc_admin.delete_rule_group(g_edit_cgr_row);
    else
      pit.error(msg.UTL_INVALID_REQUEST, msg_args(utl_apex.get_request));
    end case;
    
    adc_admin.propagate_rule_change(g_edit_cgr_row.cgr_id);

    pit.leave_mandatory;
  end process_edit_cgr;
  
  
  function validate_edit_cif
    return boolean
  as
  begin
    pit.enter_mandatory;
  
    copy_edit_cif;
    
    pit.start_message_collection;
    adc_admin.validate_action_item_focus(g_edit_cif_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ERROR_CODE', 'ASSIGNED_ITEM'));
      return true;
  end validate_edit_cif;
  
  
  procedure process_edit_cif
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_cif;
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_item_focus(g_edit_cif_row);
    else
      adc_admin.delete_action_item_focus(g_edit_cif_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_cif;


  function validate_edit_cru
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_cru;

    pit.start_message_collection;
    adc_admin.validate_rule(g_edit_cru_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'SQL_ERROR', 'CRU_CONDITION',
        'CRU_CONDITION_MISSING', 'CRU_CONDITION',
        'CRU_CGR_ID_MISSING', 'CRU_CGR_ID',
        'CRU_NAME_MISSING', 'CRU_NAME'));
        
    pit.leave_mandatory;
    return true;
  end validate_edit_cru;


  procedure validate_rule_condition
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_cru;

    pit.start_message_collection;
    adc_admin.validate_rule_condition(g_edit_cru_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      adc.handle_bulk_errors(char_table(
        'SQL_ERROR', 'CRU_CONDITION',
        'CRU_CONDITION_MISSING', 'CRU_CONDITION'));
        
    pit.leave_mandatory;
  end validate_rule_condition;
  
  
  /** Helper method to extract rule action maintenace from EDIT_CRU
   * %usage  Rule Actions are maintained using the collection API to allow for
   *         creation of rule actions while the rule does not yet exist (is created)
   *         This method harmonizes the entered rule actions with the underlying table
   */
  procedure maintain_rule_action
  as
    cursor missing_cra_cur is
      select cra_id
        from adc_rule_actions
       where cra_cru_id = g_edit_cru_row.cru_id
         and cra_id not in (
             select cra_id
               from adc_ui_edit_cra);
               
    cursor cra_cur is
      select *
        from adc_ui_edit_cra;
    l_cra_rec adc_rule_actions%rowtype;
  begin
    pit.enter_mandatory;
    
    for sra in missing_cra_cur loop
      adc_admin.delete_rule_action(sra.cra_id);
    end loop;
    
    for sra in cra_cur loop
      copy_row_to_cra_record(sra, l_cra_rec);
      adc_admin.merge_rule_action(l_cra_rec);
    end loop;
    
    pit.leave_mandatory;
  end maintain_rule_action;


  procedure process_edit_cru
  as
  begin
    pit.enter_mandatory;
    
    -- Initialization
    copy_edit_cru;
    
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_rule(g_edit_cru_row);
      maintain_rule_action;      
    when utl_apex.deleting then
      adc_admin.delete_rule(g_edit_cru_row.cru_id);
    else
      utl_apex.unhandled_request;
    end case;
    
    adc_admin.propagate_rule_change(g_edit_cru_row.cru_cgr_id);
    
    pit.leave_mandatory;
  end process_edit_cru;


  procedure configure_edit_cra
  as
    C_SET_CAT_HELP constant varchar2(100) := q'^$('^R11_CAT_HELP .t-Region-body').html('#HELP_TEXT#');^';
    
    cursor action_type_cur(p_cat_id in adc_action_types.cat_id%type) is
      with params as(
             select C_TRUE c_active,
                    p_cat_id cat_id
               from dual)
      select /*+ no_merge (p) */
             sat.cat_id, cat_cif_id, 
             cpt_id, cpt_item_type,
             cap_sort_seq, cap_mandatory, cap_default,
             coalesce(cap_display_name, cpt_name) cpt_name,
             'P11_CRA_PARAM_' || 
             case cpt_item_type
               when 'SELECT_LIST' then 'LOV_'
               when 'TEXT_AREA' then 'AREA_'
             end || cap_sort_seq cap_page_item
        from adc_action_types_v sat
        join params p
          on sat.cat_id = p.cat_id
         and cat_active = p.c_active
        left join adc_action_parameters_v
          on sat.cat_id = cap_cat_id
         and p.c_active = cap_active
        left join adc_action_param_types_v
          on cap_cpt_id = cpt_id
         and p.c_active = cpt_active
       where cap_sort_seq is not null
       order by cat_id, cap_sort_seq;
       
    l_item_id adc_util.ora_name_type;
    l_help_text adc_util.max_char;
    l_cat_id adc_action_types.cat_id%type;
    l_mandatory_message adc_util.max_char;
    
    C_PARAM_SELECTOR varchar2(100 byte) := '.adc-hide';
  begin
    pit.enter_mandatory;
    
    -- Initialize
    l_cat_id := utl_apex.get_string('CRA_CAT_ID');  
    l_mandatory_message := pit.get_message_text(msg.ADC_ITEM_IS_MANDATORY);
    adc.hide_item(p_jquery_selector => C_PARAM_SELECTOR);
    adc.set_optional(C_PARAM_SELECTOR);
    
    -- Set list of page items
    adc.refresh_item(
      p_cpi_id => 'P11_CRA_CPI_ID',
      p_set_item => adc_util.C_TRUE);

    -- Generate Help text for action type
    select trim('''' from apex_escape.js_literal(help_text))
      into l_help_text
      from adc_bl_cat_help
     where cat_id = l_cat_id;
    adc.add_javascript(replace(C_SET_CAT_HELP, '#HELP_TEXT#', l_help_text));

    -- Adjust Parameter settings to show only required parameters in the correct format
    for param in action_type_cur(l_cat_id) loop
      -- Show parameter region
      adc.show_item('R11_PARAMETER_' || param.cap_sort_seq);       
      
      -- Set parameter label and mandatory state
      adc.set_item_label(param.cap_page_item, param.cpt_name);
      if param.cap_mandatory = adc_util.C_TRUE then
        adc.set_mandatory(
          p_cpi_id => param.cap_page_item,
          p_msg_text => replace(l_mandatory_message, '#LABEL#', param.cpt_name));
      else
        adc.show_item(param.cap_page_item);
      end if;

      -- Refresh if parameter is a list item
      if param.cpt_item_type = 'SELECT_LIST' then
        adc.set_item('P11_LOV_PARAM_' || param.cap_sort_seq, param.cpt_id);
        adc.refresh_item(
          p_cpi_id => param.cap_page_item, 
          p_item_value => param.cap_default,
          p_set_item => adc_util.C_TRUE);
      end if;
      
    end loop;

    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      -- no help found, generate generic help text
      adc.add_javascript(replace(C_SET_CAT_HELP, '#HELP_TEXT#', trim('''' from apex_escape.js_literal(adc_util.get_trans_item_name('CRA_NO_HELP')))));
      
      pit.leave_mandatory;
  end configure_edit_cra;


  function validate_edit_cra
    return boolean
  as
    l_error varchar2(4000);
  begin
    pit.enter_mandatory;
    copy_edit_cra;

    pit.start_message_collection;
    adc_admin.validate_rule_action(g_edit_cra_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'CRA_CRU_ID_MISSING', 'CRA_CRU_ID',
        'CRA_CGR_ID_MISSING', 'CRA_CGR_ID',
        'CRA_CPI_ID_MISSING', 'CRA_CPI_ID',
        'CRA_CAT_ID_MISSING', 'CRA_CAT_ID'));
        
    pit.leave_mandatory;
    return true;
  end validate_edit_cra;


  procedure process_edit_cra
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_cra;
    
    case
    when utl_apex.INSERTING then
      apex_collection.add_member(
        p_collection_name => C_CRA_COLLECTION,
        p_n001 => g_edit_cra_row.cra_id,
        p_n002 => g_edit_cra_row.cra_cgr_id,
        p_n003 => g_edit_cra_row.cra_cru_id,
        p_c001 => g_edit_cra_row.cra_cpi_id,
        p_c002 => g_edit_cra_row.cra_cat_id,
        p_n004 => g_edit_cra_row.cra_sort_seq,
        p_c003 => g_edit_cra_row.cra_param_1,
        p_c004 => g_edit_cra_row.cra_param_2,
        p_c005 => g_edit_cra_row.cra_param_3,
        p_c006 => g_edit_cra_row.cra_comment,
        p_c007 => g_edit_cra_row.cra_on_error,
        p_c008 => g_edit_cra_row.cra_raise_recursive,
        p_c009 => g_edit_cra_row.cra_active,
        p_generate_md5 => C_FALSE);
    when utl_apex.updating then
      apex_collection.update_member(
        p_seq => g_collection_seq_id,
        p_collection_name => C_CRA_COLLECTION,
        p_n001 => g_edit_cra_row.cra_id,
        p_n002 => g_edit_cra_row.cra_cgr_id,
        p_n003 => g_edit_cra_row.cra_cru_id,
        p_c001 => g_edit_cra_row.cra_cpi_id,
        p_c002 => g_edit_cra_row.cra_cat_id,
        p_n004 => g_edit_cra_row.cra_sort_seq,
        p_c003 => g_edit_cra_row.cra_param_1,
        p_c004 => g_edit_cra_row.cra_param_2,
        p_c005 => g_edit_cra_row.cra_param_3,
        p_c006 => g_edit_cra_row.cra_comment,
        p_c007 => g_edit_cra_row.cra_on_error,
        p_c008 => g_edit_cra_row.cra_raise_recursive,
        p_c009 => g_edit_cra_row.cra_active);
    when utl_apex.deleting then
      apex_collection.delete_member(
        p_seq => g_collection_seq_id,
        p_collection_name => C_CRA_COLLECTION);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_cra;


  function validate_edit_cat
    return boolean
  as
    l_cat_rec adc_action_types_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cat;

    pit.start_message_collection;
    copy_row_to_cat_record(g_edit_cat_row, l_cat_rec);
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


  procedure process_edit_cat
  as
    l_cat_rec adc_action_types_v%rowtype;
    l_cap_rec_1 adc_action_parameters_v%rowtype;
    l_cap_rec_2 adc_action_parameters_v%rowtype;
    l_cap_rec_3 adc_action_parameters_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_cat;

    copy_row_to_cat_record(g_edit_cat_row, l_cat_rec);
    copy_row_to_cap_records(g_edit_cat_row, l_cap_rec_1, l_cap_rec_2, l_cap_rec_3);

    case
    when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type(l_cat_rec);

      if l_cap_rec_1.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_1);
      end if;

      if l_cap_rec_2.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_2);
      end if;

      if l_cap_rec_3.cap_cpt_id is not null then
        adc_admin.merge_action_parameter(l_cap_rec_3);
      end if;

    when utl_apex.deleting then
      adc_admin.delete_action_type(l_cat_rec);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_cat;


  procedure print_cat_help
  as
    l_help_text clob;
    l_cat_id utl_apex.ora_name_type;
  begin
    pit.enter_mandatory;
    
    l_cat_id := utl_apex.get_value('CAT_ID');

    select help_text
      into l_help_text
      from adc_bl_cat_help
     where cat_id = l_cat_id;

    htp.p(l_help_text);
    
    pit.enter_mandatory;
  exception
    when NO_DATA_FOUND then
      -- No CAT_ID given (fi upon creation), ignore
      pit.enter_mandatory;
  end print_cat_help;


  function validate_edit_caa
    return boolean
  as
    l_caa_rec adc_apex_actions_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_caa;
    
    copy_row_to_caa_record(g_edit_caa_row, l_caa_rec);
    
    pit.start_message_collection;
    adc_admin.validate_apex_action(l_caa_rec);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        -- TODO: Error code mapping
        ));

      pit.leave_mandatory;
      return true;
  end validate_edit_caa;


  procedure process_edit_caa
  as
    l_caa_rec adc_apex_actions_v%rowtype;
    l_caa_cai_list char_table;
  begin
    pit.enter_mandatory;
    
    copy_edit_caa;
    copy_row_to_caa_record(g_edit_caa_row, l_caa_rec);
    -- cast item list to CHAR_TABLE
    utl_text.string_to_table(g_edit_caa_row.caa_cai_list, l_caa_cai_list);
    
    case
    when utl_apex.inserting then
      g_edit_caa_row.caa_id := coalesce(g_edit_caa_row.caa_id, adc_seq.nextval);
      apex_collection.add_member(
        p_collection_name => C_CAA_COLLECTION,
        p_n001 => g_edit_caa_row.caa_id,
        p_n002 => g_edit_caa_row.caa_cgr_id,
        p_c001 => g_edit_caa_row.caa_cty_id,
        p_c002 => g_edit_caa_row.caa_name,
        p_c003 => g_edit_caa_row.caa_label,
        p_c004 => g_edit_caa_row.caa_context_label,
        p_c005 => g_edit_caa_row.caa_icon,
        p_c006 => g_edit_caa_row.caa_icon_type,
        p_c007 => g_edit_caa_row.caa_title,
        p_c008 => g_edit_caa_row.caa_shortcut,
        p_c009 => g_edit_caa_row.caa_initially_disabled,
        p_c010 => g_edit_caa_row.caa_initially_hidden,
        p_c011 => g_edit_caa_row.caa_href,
        p_c012 => g_edit_caa_row.caa_action,
        p_c013 => g_edit_caa_row.caa_on_label,
        p_c014 => g_edit_caa_row.caa_off_label,
        p_c015 => g_edit_caa_row.caa_get,
        p_c016 => g_edit_caa_row.caa_set,
        p_c017 => g_edit_caa_row.caa_choices,
        p_c018 => g_edit_caa_row.caa_label_classes,
        p_c019 => g_edit_caa_row.caa_label_start_classes,
        p_c020 => g_edit_caa_row.caa_label_end_classes,
        p_c021 => g_edit_caa_row.caa_item_wrap_class,
        p_c022 => g_edit_caa_row.caa_cai_list,
        p_generate_md5 => C_FALSE);
    when utl_apex.updating then
      apex_collection.update_member(
        p_seq => g_edit_caa_row.seq_id,
        p_collection_name => C_CAA_COLLECTION,
        p_n001 => g_edit_caa_row.caa_id,
        p_n002 => g_edit_caa_row.caa_cgr_id,
        p_c001 => g_edit_caa_row.caa_cty_id,
        p_c002 => g_edit_caa_row.caa_name,
        p_c003 => g_edit_caa_row.caa_label,
        p_c004 => g_edit_caa_row.caa_context_label,
        p_c005 => g_edit_caa_row.caa_icon,
        p_c006 => g_edit_caa_row.caa_icon_type,
        p_c007 => g_edit_caa_row.caa_title,
        p_c008 => g_edit_caa_row.caa_shortcut,
        p_c009 => g_edit_caa_row.caa_initially_disabled,
        p_c010 => g_edit_caa_row.caa_initially_hidden,
        p_c011 => g_edit_caa_row.caa_href,
        p_c012 => g_edit_caa_row.caa_action,
        p_c013 => g_edit_caa_row.caa_on_label,
        p_c014 => g_edit_caa_row.caa_off_label,
        p_c015 => g_edit_caa_row.caa_get,
        p_c016 => g_edit_caa_row.caa_set,
        p_c017 => g_edit_caa_row.caa_choices,
        p_c018 => g_edit_caa_row.caa_label_classes,
        p_c019 => g_edit_caa_row.caa_label_start_classes,
        p_c020 => g_edit_caa_row.caa_label_end_classes,
        p_c021 => g_edit_caa_row.caa_item_wrap_class,
        p_c022 => g_edit_caa_row.caa_cai_list);
    when utl_apex.deleting then
      apex_collection.delete_member(
        p_seq => g_edit_caa_row.seq_id,
        p_collection_name => C_CAA_COLLECTION);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_caa;
  
    
  function validate_edit_ctg
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_ctg;
    
    pit.start_message_collection;
    adc_admin.validate_action_type_group(g_edit_ctg_row);
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
  
  
  procedure process_edit_ctg
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_ctg;
    case when utl_apex.inserting or utl_apex.updating then
      adc_admin.merge_action_type_group(g_edit_ctg_row);
    else
      adc_admin.delete_action_type_group(g_edit_ctg_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_ctg;


  function get_cru_sort_seq
    return number
  as
    l_cru_sort_seq adc_rules.cru_sort_seq%type;
    l_cgr_id adc_rule_groups.cgr_id%type;
  begin
    pit.enter_mandatory;
    
    l_cgr_id := utl_apex.get_number('CRU_CGR_ID');

    select coalesce(max(trunc(cru_sort_seq, -1)) + 10, 10)
      into l_cru_sort_seq
      from adc_rules
     where cru_cgr_id = l_cgr_id;

    pit.leave_mandatory;
    return l_cru_sort_seq;
  end get_cru_sort_seq;


  function get_cra_sort_seq
    return number
  as
    l_cra_sort_seq adc_rule_actions.cra_sort_seq%type;
    l_cru_id adc_rules.cru_id%type;
    l_cra_id adc_rule_actions.cra_id%type;
  begin
    pit.enter_mandatory;
    
    l_cru_id := utl_apex.get_number('CRA_CRU_ID');
    l_cra_id := utl_apex.get_number('CRA_ID');

    begin
      select cra_sort_seq
        into l_cra_sort_seq
        from adc_ui_edit_cra
       where cra_id = l_cra_id;
    exception
      when NO_DATA_FOUND then
        select coalesce(max(trunc(cra_sort_seq, -1)) + 10, 10)
          into l_cra_sort_seq
          from adc_ui_edit_cra
         where cra_cru_id = l_cru_id;
    end;

    pit.leave_mandatory;
    return l_cra_sort_seq;
  end get_cra_sort_seq;


  procedure get_action_type_help
  as
    l_help_text adc_util.max_char;
    l_not_editable adc_util.ora_name_type;
  begin
    pit.enter_mandatory;
    
    l_not_editable := adc_util.get_trans_item_name('CAT_NOT_EDITABLE');

    with params as(
           select uttm_text template, uttm_mode
             from utl_text_templates
            where uttm_type = adc_util.C_ADC
              and uttm_name = 'ACTION_TYPE_HELP')
    select utl_text.generate_text(cursor(
             select template,
                    utl_text.generate_text(cursor(
                      select p.template,
                             cat_name, cat_description,
                             case cat_is_editable when C_FALSE then l_not_editable end cat_is_editable
                         from adc_action_types_v
                        cross join params p
                        where uttm_mode = 'HELP'
                        order by cat_name), adc_util.C_CR) help_list
               from dual)
           )
      into l_help_text
      from params
     where uttm_mode = 'FRAME';
     
    htp.p(l_help_text);

    pit.leave_mandatory;
  end get_action_type_help;
  
  
  procedure set_cgr_id
  as
    l_cgr_id adc_rule_groups.cgr_id%type;
  begin
    select cgr_id
      into l_cgr_id
      from adc_rule_groups
     where cgr_app_id = utl_apex.get_number('CGR_APP_ID')
       and cgr_page_id = utl_apex.get_number('CGR_PAGE_ID');
       
    adc.set_item('P1_CGR_ID', l_cgr_id);
  end set_cgr_id;
  

  /* APEX-Aktionen */
  procedure set_action_admin_cgr
  as
    l_cgr_app_id adc_rule_groups.cgr_app_id%type;
    l_cgr_page_id adc_rule_groups.cgr_page_id%type;
    l_cgr_id adc_rule_groups.cgr_id%type;
    l_javascript adc_util.max_char;
  begin
    pit.enter_optional;

    l_cgr_app_id := utl_apex.get_number('CGR_APP_ID');
    l_cgr_page_id := utl_apex.get_number('CGR_PAGE_ID');
    l_cgr_id := utl_apex.get_number('CGR_ID');
    
    -- Action CREATE_RULE_GROUP
    adc_apex_action.action_init('create-rulegroup');
    l_javascript := utl_apex.get_page_url(
                      p_page => 'EDIT_CGR',
                      p_param_items => 'P6_CGR_APP_ID:P6_CGR_PAGE_ID',
                      p_value_items => 'P1_CGR_APP_ID:P1_CGR_PAGE_ID',
                      p_triggering_element => 'R1_RULE_GROUP',
                      p_clear_cache => C_PAGE_EDIT_CGR);
    adc_apex_action.set_action(l_javascript);
    adc.add_javascript(adc_apex_action.get_action_script);

    -- Action CREATE_RULE
    adc_apex_action.action_init('create-rule');
    
    if l_cgr_id is not null then
      l_javascript := utl_apex.get_page_url(
                        p_page => 'EDIT_SRU',
                        p_param_items => 'P5_CRU_CGR_ID',
                        p_value_items => 'P1_CGR_ID',
                        p_triggering_element => 'R1_RULE_OVERVIEW',
                        p_clear_cache => C_PAGE_EDIT_CRU);
      adc_apex_action.set_href(l_javascript);
      adc_apex_action.set_disabled(false);
    else
      adc_apex_action.set_disabled(true);
    end if;

    adc.add_javascript(adc_apex_action.get_action_script);

    -- Action EXPORT_RULEGROUP
    adc_apex_action.action_init('export-rulegroup');
    
    -- It is possible that an SGR was selected without defining the application page.
    -- In this case, determine the PAGE_ID before exporting, so that the export dialog works correctly.
    if l_cgr_id is not null and l_cgr_page_id is null then
      select cgr_page_id
        into l_cgr_page_id
        from adc_rule_groups
       where cgr_id = l_cgr_id;
      utl_apex.set_value('P1_CGR_PAGE_ID', l_cgr_page_id);
    end if;

    l_javascript := utl_apex.get_page_url(
                      p_page => 'EXPORT_CGR',
                      p_param_items => 'P8_CGR_APP_ID:P8_CGR_PAGE_ID',
                      p_value_items => 'P1_CGR_APP_ID:P1_CGR_PAGE_ID',
                      p_triggering_element => 'B1_EXPORT_CGR');

    adc_apex_action.set_action(l_javascript);
    adc.add_javascript(adc_apex_action.get_action_script);

    pit.leave_optional;
  end set_action_admin_cgr;


  procedure set_action_edit_cgr
  as
    l_javascript adc_util.max_char;
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_cgr;


  procedure set_action_export_cgr
  as
    l_cgr_app_id utl_apex.item_rec;
    l_cgr_page_id utl_apex.item_rec;
    l_cgr_id utl_apex.item_rec;
    l_export_type utl_apex.item_rec;
    l_action varchar2(100);
    
    C_SUCCESS_COMMAND constant varchar2(100) := q'^apex.submit('EXPORT_#TYPE#');^';
  begin
    pit.enter_optional;
    
    -- Initialization
    l_cgr_app_id := utl_apex.get_page_element('CGR_APP_ID');
    l_cgr_page_id := utl_apex.get_page_element('CGR_PAGE_ID');
    l_cgr_id  := utl_apex.get_page_element('CGR_ID');
    l_export_type := utl_apex.get_page_element('EXPORT_TYPE');
    l_action := replace(C_SUCCESS_COMMAND, '#TYPE#', l_export_type.item_value);
    
    -- If select list values change, set dependent select lists to null and refresh
    case adc_api.get_firing_item
      when l_cgr_app_id.item_name then 
        -- application Id changed, reset and refresh page and sgr select lists
        l_cgr_page_id.item_value := null;
        adc.set_item(l_cgr_page_id.item_name, null);
        adc.refresh_item(l_cgr_page_id.item_name);
        
        l_cgr_id.item_value := null;
        adc.set_item(l_cgr_id.item_name, null);
        adc.refresh_item(l_cgr_id.item_name);   
      when l_cgr_page_id.item_name then
        -- page id changed, only reset and refresh sgr select list
        l_cgr_id.item_value := null;
        adc.set_item(l_cgr_id.item_name, null); 
        adc.refresh_item(l_cgr_id.item_name);
      else
        null;
    end case;
    
    -- Show/Hide items based on export type
    adc.show_hide_item('.adc-ui-export-' || lower(l_export_type.item_value), '.adc-ui-hide');

    -- harmonize apex action
    adc_apex_action.action_init('export-rulegroup');

    case l_export_type.item_value
      when 'PAGE' then
        if l_cgr_page_id.item_value is not null then
          adc_apex_action.set_label(adc_util.get_trans_item_name('CGR_EXPORT_LABEL_PAGE', msg_args(l_cgr_page_id.item_value)));
          adc_apex_action.set_disabled(false);
          adc_apex_action.set_action(l_action);
        else
          adc_apex_action.set_label(adc_util.get_trans_item_name('SELECT_PAGE'));
          adc_apex_action.set_disabled(true);
        end if;
      when 'APP' then
        if l_cgr_app_id.item_value is not null then
          adc_apex_action.set_label(adc_util.get_trans_item_name('CGR_EXPORT_LABEL_APP', msg_args(l_cgr_app_id.item_value)));
          adc_apex_action.set_disabled(false);
          adc_apex_action.set_action(l_action);
        else
          adc_apex_action.set_label(adc_util.get_trans_item_name('SELECT_APP'));
          adc_apex_action.set_disabled(true);
        end if;
      when 'ALL_CGR' then
        adc_apex_action.set_label(adc_util.get_trans_item_name('CGR_EXPORT_LABEL_ALL'));
        adc_apex_action.set_disabled(false);
        adc_apex_action.set_action(l_action);
      else
        adc_apex_action.set_action(null);
        adc_apex_action.set_disabled(true);
    end case;
    
    adc.add_javascript(adc_apex_action.get_action_script);

    pit.leave_optional;
  exception
    when others then
      adc.register_error('DOCUMENT', sqlerrm, pit_util.get_call_stack);

      pit.leave_optional;
  end set_action_export_cgr;


  procedure set_action_edit_cru
  as
    l_javascript adc_util.max_char;
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_cru;

end adc_ui;
/