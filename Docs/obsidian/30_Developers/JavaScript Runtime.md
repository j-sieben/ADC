# JavaScript Runtime

The current ADC JavaScript runtime under `ADC/plugin/files/adc_24_1/js` is intentionally compact.

## Modules

- `utils.js`
- `renderer.js`
- `controller.js`
- `actions.js`

## Responsibilities

`utils.js` contains low-coupling helpers.

`renderer.js` isolates APEX- and theme-specific behavior behind a renderer model.

`controller.js` owns plugin initialization, shared runtime state, event handling, queueing, transport, and response execution.

`actions.js` is the public client-side action facade used by server-generated ADC responses.

## Architectural Rule of Thumb

If behavior is UI- or markup-specific, it usually belongs in the renderer.

If behavior is shared runtime orchestration, it usually belongs in the controller.

If behavior is an externally visible client action, it should enter through `actions.js`.

## Continue Reading

- [[Extending ADC]]
- [[JavaScript Modules]]
- [[Renderer Model]]
- [[JavaScript Risks and Follow-ups]]
- [[../40_Architecture/Request and Response Flow|Request and Response Flow]]
- [[../50_Reference/Glossary|Glossary]]
