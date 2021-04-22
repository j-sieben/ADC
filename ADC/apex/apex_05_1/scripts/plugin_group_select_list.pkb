create or replace package body plugin_group_select_list
as

  g_value_found boolean := false;

  procedure print_option(
    p_item in apex_plugin.t_page_item,
    p_display_value in varchar2,
    p_return_value in varchar2,
    p_compare_value in varchar2 )
  is
    l_is_selected boolean := false;
  begin
    if not g_value_found and apex_plugin_util.is_equal(p_return_value, p_compare_value) then
      g_value_found := true;
      l_is_selected := true;
    end if;
    -- add list entry
    apex_plugin_util.print_option(
      p_display_value => p_display_value,
      p_return_value => p_return_value,
      p_is_selected => l_is_selected,
      p_attributes => p_item.element_option_attributes);
  end print_option;


  function render(
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value in varchar2,
    p_is_readonly in boolean,
    p_is_printer_friendly in boolean)
    return apex_plugin.t_page_item_render_result
  is
    -- constants for accessing our l_column_value_list array
    c_display_column constant number := 1;
    c_return_column constant number := 2;
    c_group_column constant number := 3;

    -- value without the lov null value
    l_value varchar2(32767);
    l_name varchar2(30);
    l_display_value varchar2(32767);
    l_is_selected boolean := false;
    l_column_value_list wwv_flow_plugin_util.t_column_value_list;
    l_group_value varchar2(4000);
    l_last_group_value varchar2(4000);
    l_open_group boolean := false;
    l_result wwv_flow_plugin.t_page_item_render_result;

  begin
    -- Initialize
    g_value_found := false;
    l_value := case when p_value = p_item.lov_null_value then null else p_value end;

    -- During plug-in development it's very helpful to have some debug information
    if wwv_flow.g_debug then
      apex_plugin_util.debug_page_item(
        p_plugin => p_plugin,
        p_page_item => p_item,
        p_value => p_value,
        p_is_readonly => p_is_readonly,
        p_is_printer_friendly => p_is_printer_friendly);
    end if;

    -- Based on the flags we normally generate different HTML code, but that
    -- depends on the plug-in.
    if p_is_readonly or p_is_printer_friendly then
      apex_plugin_util.print_hidden_if_readonly (
        p_item_name           => p_item.name,
        p_value               => p_value,
        p_is_readonly         => p_is_readonly,
        p_is_printer_friendly => p_is_printer_friendly );

      -- get the display value
      l_display_value := apex_plugin_util.get_display_data (
                           p_sql_statement => p_item.lov_definition,
                           p_min_columns => 3, -- LOV requires 3 column
                           p_max_columns => 3,
                           p_component_name => p_item.name,
                           p_display_column_no => c_display_column,
                           p_search_column_no => c_return_column,
                           p_search_string => l_value,
                           p_display_extra => p_item.lov_display_extra );

      -- emit display span with the value
      apex_plugin_util.print_display_only (
        p_item_name        => p_item.name,
        p_display_value    => l_display_value,
        p_show_line_breaks => false,
        p_escape           => true,
        p_attributes       => p_item.element_attributes );
    else
      -- If a page item saves state, we have to call the get_input_name_for_page_item
      -- to render the internal hidden p_arg_names field. It will also return the
      -- HTML field name which we have to use when we render the HTML input field.
      l_name := apex_plugin.get_input_name_for_page_item(false);
      sys.htp.prn(
        '<select name="' || l_name || '" id="' || p_item.name || '" '
        || coalesce(p_item.element_attributes, 'class="group_selectlist"') || '>');

      -- add display null entry
      if p_item.lov_display_null then
        -- add list entry
        print_option(
          p_item => p_item,
          p_display_value => p_item.lov_null_text,
          p_return_value => p_item.lov_null_value,
          p_compare_value => nvl(l_value, p_item.lov_null_value));

        -- We have to tell the APEX JS framework which value should be considered as NULL
        if p_item.lov_null_value is not null then
          apex_javascript.add_onload_code(
            p_code => 'apex.widget.initPageItem('
                   || apex_javascript.add_value(p_item.name) || '{ '
                   || apex_javascript.add_attribute(
                        p_name => 'nullValue',
                        p_value => p_item.lov_null_value,
                        p_add_comma => false) || '});');
        end if;
      end if;

      -- get all values
      l_column_value_list := apex_plugin_util.get_data (
                               p_sql_statement => p_item.lov_definition,
                               p_min_columns => 3,
                               p_max_columns => 3,
                               p_component_name => p_item.name );

      -- loop through the result
      for i in 1 .. l_column_value_list(c_display_column).count loop
        l_group_value := l_column_value_list(c_group_column)(i);
        -- has the group changed?
        if (l_group_value <> l_last_group_value) or
           (l_group_value is null and l_last_group_value is not null) or
           (l_group_value is not null and l_last_group_value is null)
        then
          if l_open_group then
            sys.htp.p('</optgroup>');
            l_open_group := false;
          end if;
          if l_group_value is not null then
            sys.htp.p ('<optgroup label="'||sys.htf.escape_sc(l_group_value)||'">');
            l_open_group := true;
          end if;
          l_last_group_value := l_group_value;
        end if;
        -- add list entry
        print_option(
          p_item => p_item,
          p_display_value => l_column_value_list(c_display_column)(i),
          p_return_value => l_column_value_list(c_return_column )(i),
          p_compare_value => l_value);
      end loop;

      if l_open_group then
          sys.htp.p('</optgroup>');
      end if;
      -- Show at least the value if it hasn't been found in the database
      if not g_value_found and l_value is not null and p_item.lov_display_extra then
          print_option(
            p_item => p_item,
            p_display_value => l_value,
            p_return_value => l_value,
            p_compare_value => l_value );
      end if;
      -- close select list
      sys.htp.p('</select>');

      l_result.is_navigable := true;
    end if;
    return l_result;
  end render;

end plugin_group_select_list;