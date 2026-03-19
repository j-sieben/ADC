# ADC Code Architecture Notes

Last updated: 2026-03-19

## Runtime chain

1. APEX renders the page and initializes the Dynamic Action plugin.
2. `de.condes.plugin.adc.init(this.action)` in `ADC/plugin/files/adc_24_1/js/controller.js`
   reads plugin attributes:
   - bind items/events
   - page items to submit
   - renderer namespace
   - initial JavaScript response
   - additional observed items
   - standard messages
3. `bindEvents()` attaches client-side listeners to relevant items.
4. On user interaction, `ctl.execute()` sends an AJAX plugin call via `apex.server.plugin(...)` with:
   - `x01` firing item
   - `x02` event
   - `x03` event data as JSON string
   - `pageItems` current page item list
5. PL/SQL plugin code delegates into `adc_internal.read_settings(...)` and then `adc_internal.process_request`.
6. `adc_internal.process_request` loads `adc_rule_groups.crg_decision_table` and recursively evaluates matching rules.
7. Each rule action may execute parameterized PL/SQL immediately and/or collect parameterized JavaScript into `adc_response`.
8. The final response is emitted as a `<script>` block and appended to the DOM by `executeCode(...)`, which executes and then removes it.

## Main PL/SQL responsibilities

### `adc_internal`

Central request orchestrator.

- Initializes request state in `read_settings`
- Creates initial rule group/rule on first use
- Reads the generated decision SQL from `adc_rule_groups.crg_decision_table`
- Selects and executes the first matching rule
- Prevents duplicate rule execution with an in-memory rule list
- Handles recursive re-evaluation via `adc_recursion_stack`
- Builds parameterized PL/SQL and JavaScript from action templates
- Registers APEX errors via `adc_response`

Important implementation detail:

- Action PL/SQL is executed dynamically via `execute immediate`
- The code is wrapped in `begin #CODE#; commit; end;`
- That means action templates are effectively executable metadata

### `adc_page_state`

Typed cache + synchronization layer between APEX session state and ADC request state.

- Converts and validates item values
- Tracks changed items to return to the client
- Stores values as string/number/date
- Maintains mandatory state dynamically
- Exposes JSON payloads for changed items / selected items

### `adc_response`

JavaScript response builder.

- Collects JavaScript snippets
- Deduplicates repeated snippets by hash
- Collects and serializes APEX errors
- Emits initialization and runtime response payloads
- Can reduce comment/debug output to stay under response size limits

## Main JavaScript responsibilities

### `controller.js`

Client-side transport/orchestration layer.

- Registers events on page items
- Normalizes triggering element IDs across APEX/widget variants
- Queues events to avoid overlapping handling
- Maintains a short quarantine lock for protected events like click/enter
- Sends AJAX requests to the plugin
- Executes returned script payloads
- Tracks page state to detect unsaved changes
- Owns `adc.state` and the callback registry

Important implementation detail:

- The server response is executed by appending raw HTML `<script>` to `body`
- The script node is removed immediately after execution

### `actions.js`

Client-side action library.

- Exposes higher-level UI behaviors used by server-returned JavaScript
- Contains report/region handling, dialogs, confirmation flows, refresh support, error/warning integration, and item/region state changes
- Delegates theme-specific rendering details into `adc.renderer`
- Still contains some report-specific APEX selectors and widget access that would ideally move further into the renderer

### `renderer.js`

Theme-/APEX-specific UI layer.

- Resolves region types and region-specific behavior
- Renders errors, dialogs, region content, labels, and wait state
- Uses a `base_renderer` plus concrete `apex_theme_42` object so future renderers can override only changed methods
- No longer mutates ADC state directly

### `utils.js`

Shared helper layer.

- Namespace and renderer resolution
- Standard-message lookup
- Generic string/value helpers

## Architectural strengths

- Clear separation between:
  - event capture (`controller.js`)
  - client actions (`actions.js`)
  - theme rendering (`renderer.js`)
  - request orchestration (`adc_internal`)
  - typed request cache (`adc_page_state`)
  - response assembly (`adc_response`)
- Metadata-driven action templates make the system highly extensible
- Recursive rule evaluation is implemented explicitly and not hidden in side effects
- There is an intentional extension seam through object types `adc_basic` and `adc`
- The current renderer model now supports a base object with targeted version-specific overrides

## Notable technical risks / maintenance hotspots

- Dynamic SQL / dynamic PL/SQL execution is core to the design. That is powerful, but correctness and escaping discipline matter everywhere.
- Action PL/SQL currently performs `commit` inside AJAX-driven dynamic execution. That simplifies state handling but couples rule execution tightly to transaction boundaries.
- The response still relies on executing returned script blocks rather than a structured JSON command protocol.
- Client code relies on low-level jQuery event internals in places (`$._data(...)`) to pause/restore handlers during refresh.
- `actions.js` still contains part of the report/widget integration that conceptually belongs closer to the renderer.
- The codebase is mature and coherent, but parts of the JS style are still API-fragile against future APEX/jQuery changes.

## Good next reading targets

- `ADC/plugin/packages/adc_plugin.pkb`
- `ADC/core/packages/adc_recursion_stack.pkb`
- `ADC/core/packages/adc_parameter.pkb`
- `ADC/plugin/files/adc_24_1/js/renderer.js`
- `ADC/plugin/files/adc_24_1/js/controller.js`
- `ADC/plugin/files/adc_24_1/js/actions.js`
- `ADC/apex/packages/adca_ui_designer.pkb`

## Documentation layout

- `DOC/api-doc`
  Generated Natural Docs API reference.
- `DOC/developer`
  Handwritten developer-facing architecture notes and onboarding material.
