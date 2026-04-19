# JavaScript Risks and Follow-ups

This page collects the current architectural hotspots of the JavaScript runtime.

## Stabilized Recently

- renderer namespace resolution no longer uses `eval(...)`
- callback handling no longer uses `new Function(...)`
- shared runtime state and callback registry were simplified back into `controller.js`
- the jQuery `body` queue was replaced with an explicit ADC event queue
- renderer no longer mutates ADC state directly
- `renderer` now supports a base-renderer inheritance pattern

## Remaining Architectural Hotspots

### Script Response Execution

The server still returns executable JavaScript that is injected into the DOM.

### APEX-Specific Logic Still Present in `actions.js`

The biggest remaining cleanliness issue is report integration and focus behavior in `actions.js`.

Examples:

- interactive report selectors
- interactive grid widget access
- tree view widget access
- region focus heuristics

### jQuery-Internal Dependencies

`controller.js` still uses low-level jQuery event internals in some binding flows, especially around button rebinding.

## Sensible Next Refactoring Steps

1. continue moving report-specific DOM and widget logic from `actions.js` into `renderer.js`
2. document the renderer contract more explicitly in code
3. decide whether the long-term target remains script responses or evolves toward JSON commands
4. reduce jQuery-internal usage where possible without destabilizing APEX compatibility

## Related

- [[JavaScript Runtime]]
- [[JavaScript Modules]]
- [[Renderer Model]]
