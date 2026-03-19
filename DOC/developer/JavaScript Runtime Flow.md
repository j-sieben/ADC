# JavaScript Runtime Flow

Last updated: 2026-03-19

## Initialization

APEX renders the Dynamic Action plugin and calls the ADC JavaScript entry point.

The plugin configuration object contains:

- `ajaxIdentifier`
- bind-item metadata
- page items to submit
- renderer namespace
- initial JavaScript response
- additional observer items
- localized standard messages

`adc.init(...)` in `controller.js` reads this object and:

1. initializes shared runtime state
2. resolves the concrete renderer namespace
3. stores standard messages and page items
4. binds relevant page events
5. executes the initial JavaScript response returned by the server

## Event handling

When a monitored page event fires, the controller:

1. normalizes the triggering element
2. captures event data
3. updates `adc.state.currentEvent`
4. decides whether the event can run immediately or must be queued

Protected events use:

- an explicit ADC event queue
- a quarantine list to suppress duplicates while a protected event is in flight

## Request transport

The controller sends the normalized event to `apex.server.plugin(...)`.

Important request data includes:

- firing item ID
- event name
- event payload
- current `pageItems`

## Response handling

The server still returns executable JavaScript rather than a structured JSON command protocol.

The controller executes that payload by injecting a `<script>` block into the DOM and removing it immediately afterwards.

## Action execution

The returned script typically calls `adc.actions.*`.

`actions` then:

- interpret the requested ADC action
- update ADC-managed client state if needed
- call the renderer for UI work
- call the controller for transport- or event-related behavior

