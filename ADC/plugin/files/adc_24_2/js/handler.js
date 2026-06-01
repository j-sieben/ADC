var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.adc = de.condes.plugin.adc || {};


/**
 * @namespace de.condes.plugin.adc.handler
 * @since 5.1
 * @description
 * Client-side ADC push transport handlers.
 *
 * Responsibilities:
 * - initialize browser push transports
 * - normalize incoming message payloads
 * - isolate transport error handling from the public action facade
 */
(function(adc){
  "use strict";

  const C_FILE_NAME = 'adc.js.handler.js';
  const C_TRANSPORT_SSE = 'sse';
  const C_TRANSPORT_WEBSOCKET = 'websocket';

  adc.handler = adc.handler || {};
  const handler = adc.handler;
  const connections = {};
  let isPageUnloading = false;

  const closeConnection = function(pKey, pSilent) {
    const connection = connections[pKey];

    if (connection && typeof connection.close === 'function') {
      try {
        connection.close();
        if (!pSilent) {
          apex.debug.info(`${C_FILE_NAME} - Closed existing ${pKey} connection before reinitializing`);
        }
      }
      catch (error) {
        if (!pSilent) {
          apex.debug.warn(`${C_FILE_NAME} - Existing ${pKey} connection could not be closed cleanly`, error);
        }
      }
    }

    delete connections[pKey];
  };

  const closeConnectionsBeforePageUnload = function() {
    isPageUnloading = true;
    Object.keys(connections).forEach(function(pKey) {
      closeConnection(pKey, true);
    });
  };

  window.addEventListener('beforeunload', closeConnectionsBeforePageUnload);
  window.addEventListener('pagehide', closeConnectionsBeforePageUnload);

  const createConnectionKey = function(pTransport, pOptions) {
    return [
      pTransport,
      pOptions.url || '',
      pOptions.room || '',
      pOptions.clientId || ''
    ].join(':');
  };

  const createUrl = function(pTransport, pOptions) {
    const url = new URL(pOptions.url, window.location.href);

    url.searchParams.set('id', pOptions.clientId);
    url.searchParams.set('rooms', pOptions.room);

    if (pTransport === C_TRANSPORT_WEBSOCKET) {
      if (url.protocol === 'http:') {
        url.protocol = 'ws:';
      }
      else if (url.protocol === 'https:') {
        url.protocol = 'wss:';
      }
    }

    return url.toString();
  };

  const isValidOptions = function(pTransport, pOptions) {
    if (!pOptions || adc.utils.isEmpty(pOptions.url)) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} initialization skipped: missing URL`);
      return false;
    }

    if (adc.utils.isEmpty(pOptions.room)) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} initialization skipped: missing room`);
      return false;
    }

    if (adc.utils.isEmpty(pOptions.clientId)) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} initialization skipped: missing client id`);
      return false;
    }

    if (typeof pOptions.callback !== 'function') {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} initialization skipped: missing callback`);
      return false;
    }

    return true;
  };

  const resolveOptions = function(pTransport, pOptions) {
    const options = {
      room: pOptions.room,
      url: pOptions.url,
      callback: pOptions.callback
    };

    try {
      options.clientId = (typeof pOptions.clientId === 'function')
        ? pOptions.clientId()
        : pOptions.clientId;
    }
    catch (error) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} client id could not be resolved`, error);
      return null;
    }

    if (adc.utils.isEmpty(options.clientId)) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} initialization skipped: missing client id`);
      return null;
    }

    return options;
  };

  const parseMessage = function(pTransport, pEvent) {
    try {
      return JSON.parse(pEvent.data);
    }
    catch (error) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} message could not be parsed`, {
        error: error,
        data: pEvent.data
      });
      return null;
    }
  };

  const dispatchMessage = function(pTransport, pEvent, pCallback) {
    const message = parseMessage(pTransport, pEvent);

    if (message === null) {
      return;
    }

    apex.debug.info(`${C_FILE_NAME} - ${pTransport} message received`, message);

    try {
      pCallback(message);
    }
    catch (error) {
      apex.debug.error(`${C_FILE_NAME} - ${pTransport} message callback failed`, error);
    }
  };

  /**
   * Open a websocket and forward incoming messages to the supplied callback.
   *
   * @param {Object} pOptions Connection options.
   * @param {string} pOptions.room Room identifier.
   * @param {string} pOptions.url Websocket endpoint URL.
   * @param {string|function} pOptions.clientId Client/session identifier or resolver.
   * @param {function} pOptions.callback Message callback.
   * @returns {WebSocket|null} Opened websocket or `null` when initialization failed.
   */
  handler.initWebsocket = function(pOptions) {
    let socket;
    let key;

    if (typeof WebSocket === 'undefined') {
      apex.debug.error(`${C_FILE_NAME} - Websocket initialization skipped: browser does not support WebSocket`);
      return null;
    }

    if (!isValidOptions(C_TRANSPORT_WEBSOCKET, pOptions)) {
      return null;
    }

    pOptions = resolveOptions(C_TRANSPORT_WEBSOCKET, pOptions);
    if (!pOptions) {
      return null;
    }

    key = createConnectionKey(C_TRANSPORT_WEBSOCKET, pOptions);
    closeConnection(key);

    try {
      socket = new WebSocket(createUrl(C_TRANSPORT_WEBSOCKET, pOptions));
    }
    catch (error) {
      apex.debug.error(`${C_FILE_NAME} - Websocket connection could not be created`, error);
      return null;
    }

    connections[key] = socket;

    socket.onopen = function() {
      apex.debug.info(`${C_FILE_NAME} - Websocket connection established`);
    };

    socket.onclose = function(pEvent) {
      if (connections[key] === socket) {
        delete connections[key];
      }
      const closeDetails = {
        code: pEvent.code,
        reason: pEvent.reason,
        wasClean: pEvent.wasClean
      };

      if (pEvent.wasClean) {
        apex.debug.info(`${C_FILE_NAME} - Websocket connection terminated`, closeDetails);
      }
      else {
        apex.debug.warn(`${C_FILE_NAME} - Websocket connection terminated`, closeDetails);
      }
    };

    socket.onerror = function(pEvent) {
      apex.debug.error(`${C_FILE_NAME} - Websocket error`, pEvent);
    };

    socket.onmessage = function(pEvent) {
      dispatchMessage(C_TRANSPORT_WEBSOCKET, pEvent, pOptions.callback);
    };

    return socket;
  };

  /**
   * Subscribe to a server-sent events endpoint.
   *
   * @param {Object} pOptions Connection options.
   * @param {string} pOptions.room Room identifier.
   * @param {string} pOptions.url SSE endpoint URL.
   * @param {string|function} pOptions.clientId Client identifier or resolver.
   * @param {function} pOptions.callback Message callback.
   * @returns {EventSource|null} Opened event source or `null` when initialization failed.
   */
  handler.initServerSentEvents = function(pOptions) {
    let eventSource;
    let key;

    if (typeof EventSource === 'undefined') {
      apex.debug.warn(`${C_FILE_NAME} - SSE initialization skipped: browser does not support EventSource`);
      return null;
    }

    if (!isValidOptions(C_TRANSPORT_SSE, pOptions)) {
      return null;
    }

    pOptions = resolveOptions(C_TRANSPORT_SSE, pOptions);
    if (!pOptions) {
      return null;
    }

    key = createConnectionKey(C_TRANSPORT_SSE, pOptions);
    closeConnection(key);

    try {
      eventSource = new EventSource(createUrl(C_TRANSPORT_SSE, pOptions));
    }
    catch (error) {
      apex.debug.error(`${C_FILE_NAME} - SSE connection could not be created`, error);
      return null;
    }

    connections[key] = eventSource;

    eventSource.onmessage = function(pEvent) {
      dispatchMessage(C_TRANSPORT_SSE, pEvent, pOptions.callback);
    };

    eventSource.onerror = function(pEvent) {
      if (isPageUnloading || eventSource.readyState === EventSource.CLOSED) {
        return;
      }

      apex.debug.error(`${C_FILE_NAME} - SSE error`, pEvent);
    };

    eventSource.onopen = function() {
      apex.debug.info(`${C_FILE_NAME} - SSE connection established`);
    };

    return eventSource;
  };

}(de.condes.plugin.adc));
