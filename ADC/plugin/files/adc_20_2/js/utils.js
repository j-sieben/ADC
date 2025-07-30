var de = de || {};
de.condes = de.condes ||{};
de.condes.plugin = de.condes.plugin ||{};
de.condes.plugin.adc = de.condes.plugin.adc ||{};

(function(adc){

    adc.utils = adc.utils ||{};
    let util = adc.utils;


    util.isEmpty = function(pValue){
        if (typeof pValue == 'undefined' || pValue === '' || pValue === null){
            return true;
        } else if (typeof pValue == 'string' && pValue.trim().length == 0) {
            return true
        } else {
            return false;
        }
    }; // isEmpty

    util.isNotEmpty = function(pValue){
        return !util.isEmpty(pValue);
    } // isNotEmpty

    util.coalesce = function(pValues){
        if (pValues instanceof Array){
            for (let arg of pValues) {
                if (util.isNotEmpty(arg)) {
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
    util.hexToChar = function (pRawString) {
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

}(de.condes.plugin.adc));