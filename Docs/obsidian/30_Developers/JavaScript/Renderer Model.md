# Renderer Model

This page explains the renderer abstraction used by the ADC JavaScript runtime.

## Why a Renderer Exists

ADC wants to let developers declare dynamic behavior without tying that behavior directly to one APEX markup version.

That is why renderer behavior is selected by namespace and not hard-coded into the controller.

## Current Selection Mechanism

The current flow is:

1. `adc_plugin.render` writes the configured renderer namespace into the plugin configuration object.
2. `controller.js` reads the configured renderer namespace.
3. `adc.utils.resolveRenderer(...)` resolves the namespace object.
4. `adc.renderer` points to the resolved renderer implementation.

## Base Renderer Pattern

The current implementation uses a base renderer plus a concrete renderer:

- `de.condes.plugin.adc.base_renderer`
- `de.condes.plugin.adc.apex_theme_42`

`apex_theme_42` inherits from `base_renderer` using `Object.create(...)`.

This gives:

- shared default behavior
- small version-specific overrides
- no additional build model
- no need for class hierarchies

## What Belongs in the Base Renderer

Good base-renderer candidates:

- dialog wrappers
- generic error rendering orchestration
- generic enable/disable visual behavior
- common wait spinner behavior
- common message handling

## What Belongs in a Concrete Renderer

Good override candidates:

- region-type detection
- APEX-markup-specific selectors
- report filter panel handling
- region header and content DOM manipulation
- widget-specific focus behavior

## Supporting a New APEX Version

If ADC needs to support a new APEX version, use this sequence:

1. Copy the current concrete renderer namespace pattern, not the full ADC stack.
2. Create a new renderer namespace for the target version.
3. Let the new renderer inherit from `de.condes.plugin.adc.base_renderer`.
4. Start with no overrides and test the main UI flows.
5. Override only the methods that break because markup, selectors, or widget APIs changed.
6. Configure the plugin to use the new renderer namespace.
7. Keep action semantics in `actions.js` unchanged unless the change is not renderer-related.

## Checklist for a New Renderer

- Check region detection in `getRegionType(...)`.
- Check report selection behavior for Classic Report, Interactive Report, Interactive Grid, and Tree.
- Check report filter panel hiding.
- Check region header and content manipulation.
- Check item enable/disable behavior.
- Check error rendering and warning styling.
- Check dialog rendering and focus return behavior.
- Check selectors that refer to Theme 42 markup directly.

## Rule of Thumb

If the breakage is caused by changed APEX markup or widget behavior, fix it in the concrete renderer.

If the breakage is caused by ADC runtime behavior, request transport, event handling, or shared state, fix it in `controller.js` or `actions.js` instead.

## Related

- [[JavaScript Runtime]]
- [[JavaScript Modules]]
- [[Extending ADC]]
