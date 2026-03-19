var de = de || {};
de.condes = de.condes ||{};
de.condes.plugin = de.condes.plugin ||{};
de.condes.plugin.adc = de.condes.plugin.adc ||{};

(function(adc){
    "use strict";

    adc.utils = adc.utils ||{};
    let util = adc.utils;


    util.isEmpty = function(pValue){
        if (typeof pValue == 'undefined' || pValue === '' || pValue === null){
            return true;
        } else if (typeof pValue == 'string' &&pValue.trim().length == 0) {
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
   * Decode a base64-encoded UTF-8 ADC response back to a normal string.
   *
   * @param {string} pRawString Base64-encoded UTF-8 string.
   * @returns {string} Decoded string.
   */
  util.base64ToUtf8 = function(pRawString){
    let binaryString;
    let bytes;

    if (!pRawString){
      return '';
    }

    binaryString = window.atob(pRawString.toString());
    bytes = Uint8Array.from(binaryString, function(pChar) {
      return pChar.charCodeAt(0);
    });

    if (typeof TextDecoder !== 'undefined'){
      return new TextDecoder('utf-8').decode(bytes);
    }

    return decodeURIComponent(Array.prototype.map.call(bytes, function(pByte) {
      return `%${pByte.toString(16).padStart(2, '0')}`;
    }).join(''));
  }; // base64ToUtf8

  /**
   * Read an APEX item value and normalize array values to a string.
   *
   * @param {string} pItem APEX item ID.
   * @returns {string|*} Item value normalized for comparison.
   */
  util.getValueAsString = function(pItem){
    let itemValue = apex.item(pItem).getValue();
    if(Array.isArray(itemValue)){
        itemValue = itemValue.toString();
    }
    return itemValue;
  };

  /**
   * Resolve a dot-separated namespace path against a root object.
   *
   * @param {string} pPath Namespace path.
   * @param {Object} [pRoot] Root object, defaults to `window`.
   * @returns {*|null} Resolved object or `null`.
   */
  util.resolveNamespace = function(pPath, pRoot){
    const path = (pPath || '').trim();
    let context = pRoot || window;

    if (util.isEmpty(path)){
      return null;
    }

    return path.split('.').reduce(function(pResult, pSegment){
      if (pResult && pSegment in pResult){
        return pResult[pSegment];
      }
      return null;
    }, context);
  };

  /**
   * Resolve the configured ADC renderer namespace.
   *
   * @param {string} pPath Renderer namespace path.
   * @returns {Object} Renderer object.
   * @throws {Error} If the namespace cannot be resolved.
   */
  util.resolveRenderer = function(pPath){
    const renderer = util.resolveNamespace(pPath, window);

    if (!renderer){
      throw new Error(`ADC renderer namespace not found: ${pPath}`);
    }

    return renderer;
  };

  /**
   * Read a localized standard message from ADC state.
   *
   * @param {string} pMessageId Message key.
   * @returns {string|undefined}
   */
  util.getStandardMessage = function(pMessageId){
    return adc.state.standardMessages[pMessageId];
  };

}(de.condes.plugin.adc));
