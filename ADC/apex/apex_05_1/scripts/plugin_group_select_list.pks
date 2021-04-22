create or replace package plugin_group_select_list
  authid definer
as

  function render(
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value in varchar2,
    p_is_readonly in boolean,
    p_is_printer_friendly in boolean)
    return apex_plugin.t_page_item_render_result;

end plugin_group_select_list;