create or replace package splitter_plugin
  authid definer
as

  /**
    Package: SPLITTER_PLUGIN
      Package to maintain a splitter oriented APEX page.
      
      This package implements the splitter plugin as provided by APEX
      in the page designer, but enhanced and without the requirement
      to grant access to an APEX internal package.
      
      I just extracted the render and ajax method into this package and 
      adopted it to my coding style (optically).
               
    Author::
      FOS = FOEX Open Source (fos.world), by FOEX GmbH, Austria (www.foex.at)
      
      <On GitHub: https://github.com/foex-open-source/fos-splitter>
   */

  /**
    Function: render
      Implementation of the render interface of an APEX region plugin
   */
  function render(
    p_region apex_plugin.t_region,
    p_plugin apex_plugin.t_plugin,
    p_is_printer_friendly boolean)
  return apex_plugin.t_region_render_result;


  /**
    Function: ajax
      Implementation of the ajax interface of an APEX region plugin
   */
  function ajax(
    p_region apex_plugin.t_region,
    p_plugin apex_plugin.t_plugin)
  return apex_plugin.t_region_ajax_result;

end splitter_plugin;
/
