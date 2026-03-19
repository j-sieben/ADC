# JavaScript Architecture

Last updated: 2026-03-19

## Purpose

The ADC JavaScript layer turns declarative server-side rule decisions into browser-side behavior inside Oracle APEX.

At runtime it does four things:

1. initialize the plugin from `adc_plugin.render`
2. observe configured page events
3. send normalized event state to the plugin AJAX endpoint
4. execute the returned ADC client actions

## Current structure

The current 24.1 file set is intentionally small:

- `utils.js`
- `renderer.js`
- `controller.js`
- `actions.js`

Shared runtime state and callback registration both live in `controller.js`.

## Layering

### `utils.js`

Low-level helpers:

- emptiness checks
- namespace resolution
- renderer resolution
- standard-message lookup
- string/value helpers

### `renderer.js`

The renderer isolates APEX- and theme-specific behavior.

Typical renderer responsibilities:

- region-type detection
- report and region DOM manipulation
- dialog rendering
- error markup rendering
- enable/disable visual behavior
- APEX widget-specific UI handling

The renderer should not own ADC business state.

### `controller.js`

The controller is the runtime owner.

It currently owns:

- plugin initialization
- ADC shared runtime state
- callback registry
- DOM event binding
- event normalization
- queueing and event quarantine
- AJAX transport
- script response execution
- page-state tracking support

If a behavior is neither action-specific nor renderer-specific, it usually belongs here.

### `actions.js`

`actions` is the high-level ADC client API.

It should stay as thin as possible:

- accept parameters from server-generated JavaScript
- decide what ADC behavior should happen
- delegate orchestration to `controller`
- delegate UI work to `renderer`

## Shared state

Shared runtime state lives in `adc.state`, which is initialized in `controller.js`.

Current examples:

- current event context
- queued events
- quarantine list
- managed error and warning collections
- page items to submit
- standard messages
- page state cache
- last triggering item
- last item values

## Public seams

The main public seams a developer should care about are:

- `adc.init(...)`
- `adc.actions.*`
- `adc.renderer.*`
- `adc.callbacks.register(name, fn)`

