# JavaScript Extension Guide

Last updated: 2026-03-19

## If you add a new ADC action

Start in `actions.js`.

Preferred split:

- action entry point in `actions.js`
- runtime mechanics in `controller.js`
- UI and markup-specific work in `renderer.js`

## If you add a new browser callback

Do not introduce free-form code strings.

Register a named callback through:

- `adc.callbacks.register(name, fn)`

Then reference the callback by name from ADC configuration.

## If you need new shared runtime data

Add it to `adc.state` in `controller.js` only if it is genuinely shared runtime state.

## If you add a renderer for a new APEX version

Do not copy the full renderer unless necessary.

Preferred pattern:

1. create a new namespace object
2. inherit from `base_renderer`
3. override only incompatible methods
4. configure the plugin to use the new namespace

