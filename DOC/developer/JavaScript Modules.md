# JavaScript Modules

Last updated: 2026-03-19

## `utils.js`

Role:

- generic helper functions with low coupling

Notable responsibilities:

- `isEmpty(...)`
- `isNotEmpty(...)`
- `coalesce(...)`
- `hexToChar(...)`
- `getValueAsString(...)`
- `resolveNamespace(...)`
- `resolveRenderer(...)`
- `getStandardMessage(...)`

## `renderer.js`

Role:

- implement the renderer contract for ADC

Current structure:

- `de.condes.plugin.adc.base_renderer`
- `de.condes.plugin.adc.apex_theme_42`

The concrete Theme 42 renderer is created with `Object.create(base_renderer)`.

Design rule:

- renderer methods may use APEX-specific selectors and widget APIs
- renderer methods should not own ADC state transitions

## `controller.js`

Role:

- runtime orchestration hub

Important internal areas:

- plugin configuration
- shared `adc.state`
- callback registry
- event registry and binding helpers
- event queue
- transport
- current event context

## `actions.js`

Role:

- action facade used by server-generated ADC JavaScript

Design rule:

- `actions` should express intent, not widget implementation detail

Current hotspot:

Some report-selection and focus logic still contains APEX-specific selectors and widget calls. This is workable, but it is the main remaining place where the separation is not yet as clean as the target architecture wants it to be.

