# ADC Code Architecture Notes

Last updated: 2026-04-20

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
   - relevant observed items are derived from technical conditions and related metadata rather than configured separately on the page
   - when multiple rules match, rule priority is determined by sort sequence
7. Each rule action may execute parameterized PL/SQL immediately and/or collect parameterized JavaScript into `adc_response`.
8. The final response is emitted as a `<script>` block and appended to the DOM by `executeCode(...)`, which executes and then removes it.

## Usage model

ADC supports several usage levels that all share the same runtime chain:

- Basic Use
  Declarative rules evaluate against page state and mostly produce browser-side behavior.
- Advanced Use
  Declarative rules still drive the flow, but action execution can span both database-side and client-side work.
- Professional Use
  Rules can intentionally be broader entry points, while PL/SQL implements the detailed case distinction and uses the ADC type interface to determine the resulting dynamic behavior.
- Extensibility
  Projects can extend ADC with custom action types and project-specific methods on top of the shipped type hierarchy.

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
- Uses technical conditions and metadata context to determine which page-state columns and observed items are relevant

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
- Registers recursion origin and timing information
- Can embed trace comments that identify rule origin, recursion depth, sort sequence, rule name, and firing item

Important implementation detail:

- The response is also a debugging surface, not just an execution payload
- Depending on debug level and size limits, it can expose selected rule chain information directly in the returned script

## PL/SQL integration and type layering

ADC is not only a plugin plus internal packages. It also exposes a deliberate PL/SQL extension seam.

- application code should typically call methods on type `adc`
- `adc` inherits from `adc_basic`
- `adc_basic` contains the shipped object-type implementation
- `adc_basic` delegates its work to `adc_api`
- `adc_api` is the technical package interface over `adc_internal`

This matters because ADC can be used in two ways from PL/SQL:

- action types can execute predefined database-side behavior through metadata
- application packages can compute more complex procedural outcomes and then call ADC through the type interface

That second path is what the documentation now treats as "Professional Use".

## Action type model

Action types are primarily a database metadata concept.

- `adc_action_types` stores action-type identity plus executable PL/SQL and JavaScript templates
- parameter metadata defines input semantics, validation, and designer rendering
- runtime packages resolve those templates into concrete behavior during rule execution

Not every action type produces JavaScript. Some are effectively database-only actions that execute PL/SQL and contribute no browser-side code.

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
- The response can be inspected directly in browser developer tools, which is a key part of ADC observability

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
- Technical conditions serve two roles:
  - they express decision logic
  - they indirectly define which items ADC must observe at runtime
- The system supports multiple abstraction levels without forcing all behavior to remain purely declarative

## Observability and debugging

ADC has explicit observability hooks on both runtime sides.

- browser-side logging uses `apex.debug`
- database-side logging uses PIT instrumentation
- PIT, not ADC itself, detects the effective APEX debug context on the database side through its session adapter and adjusts PIT logging accordingly
- the response builder can include rule-origin and recursion trace information
- recursive processing is visible via recursion counters and rule-origin markers
- developers can correlate browser network traffic, returned script payloads, and server-side logs

This means the system is designed to be debugged through normal APEX/browser workflows rather than through a separate tracing subsystem.

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

- `Docs/api_doc`
  Generated Natural Docs API reference.
- `Docs/obsidian`
  Handwritten developer-facing architecture notes and onboarding material.
