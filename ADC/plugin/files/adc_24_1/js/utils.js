var de = de || {};
de.condes = de.condes ||{};
de.condes.plugin = de.condes.plugin ||{};
de.condes.plugin.adc = de.condes.plugin.adc ||{};

(function(adc){
  'use strict';

  adc.utils = adc.utils || {};

  /**
    Function: isEmpty
      Method checks whether pValue is empty-ish, meaning nor NULL, undefined
      or an empty string

    Parameter:
      pValue - value to check

    Returns:
      TRUE, if pValue is empty according to the above definition
   */
  adc.utils.isEmpty = function(pValue){
    if (typeof pValue == 'undefined' || pValue === '' || pValue === null){
        return true;
    } else if (typeof pValue == 'string' && pValue.trim().length == 0) {
        return true
    } else {
        return false;
    }
  }; // isEmpty


  /**
    Function: isNotEmpty
      Method checks whether pValue is not empty-ish, meaning nor NULL, undefined
      or an empty string

    Parameter:
      pValue - value to check

    Returns:
      TRUE, if pValue is not empty according to the above definition
   */
  adc.utils.isNotEmpty = function(pValue){
      return !adc.utils.isEmpty(pValue);
  } // isNotEmpty


  /**
    Function: coalesce
      Returns the first non empty value from the array instance passed in

    Parameter:
      pValues - Array with values to check

    Returns:
      The first non empty value. If all values are NULL the last element of pValues is returned
   */
  adc.utils.coalesce = function(pValues){
    if (pValues instanceof Array){
      for (let arg of pValues) {
        if (adc.utils.isNotEmpty(arg)) {
            return arg;
        }
      }
    }
    return pValues;
  } // colaesce


  /**
  Function: hexToChar
    Method to cast a hex-string representation created with UTL_RAW.CAST_TO_RAW back to String.
    
    ADC submits its response as a hex string to circumvent escaping issues between JSON, JavaScript and JavaScript containing JSON.
    As a consequence, the hex string must be converted back to a normal string in order to append it to the page.
    
  Parameter:
    pRawString - Hex-encoded string to convert back to a normal string.
    
  Returns:
    Converted String
  */
  adc.utils.hexToChar = function (pRawString) {
    var code = '';
    var hexString;

    if (pRawString) {
      hexString = pRawString.toString();
      for (let i = 0; i < hexString.length; i += 2) {
        code += String.fromCharCode(parseInt(hexString.substr(i, 2), 16));
      }
    }
    return code;
  }; // hexToChar


  /**
    Function: forEach
      Helper to identify page items to apply <pAction> to
      
    Parameters: 
      pSelector - jQuery selector to identify page items
      pAction - Action to execute on the found page items
   */
  adc.utils.forEach = function (pSelector, pAction){
    if (!($.isArray(pSelector) || pSelector.search(/[\.#\u0020:\[\]]+/) >= 0)){
      // passed ITEM is element name, extend by #.
      pSelector = `#${pSelector}`;
    }

    if (pSelector.match(/oj.*/)){
      // item is Oracle Jet item group, traverse up
      pSelector = $(`#${pSelector}`).closest('div.apex-item-group').attr('id');
    }
    $(pSelector).each(pAction);
  }; // forEach

}(de.condes.plugin.adc));