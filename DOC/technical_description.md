# Technical Description

ADC gives an APEX page a dynamic controller without moving the decision logic into page-specific JavaScript.

At runtime, the browser observes relevant page events, collects the current page state, and sends that state to the ADC plugin AJAX endpoint. The database evaluates the matching rules for the page, executes the required server-side work, and returns the client-side actions that must now happen in the browser.

The browser then applies those actions to the page. In practice this means that the page reacts dynamically, while the rules that decide what should happen remain declarative and database-driven.

## The request-response model

The most important concept in ADC is the *page state*.

The page state is similar to APEX session state, but it is not the same thing. It contains the current values that are actually present on the page at the time of the event, together with metadata such as the firing item, the firing event, and optional event payload.

ADC uses that page state to decide which rule applies.

The overall flow is:

1. the plugin initializes on the page
2. ADC binds the events that are relevant for the page
3. a monitored event occurs
4. the current page state is normalized and sent to the server
5. the database evaluates the rule set
6. ADC executes the resulting client-side actions in the browser

If a rule changes the effective page state in a way that triggers another rule, ADC can continue that evaluation recursively within the same server roundtrip until the state is stable again.

## Plugin architecture

ADC is implemented as an APEX Dynamic Action plugin.

The current JavaScript runtime is intentionally split into four modules:

- `utils.js`
- `renderer.js`
- `controller.js`
- `actions.js`

### `utils.js`

`utils.js` contains low-level helper functions with little coupling to the rest of the runtime. Typical examples are emptiness checks, namespace resolution, renderer resolution, standard-message lookup, and value conversion helpers.

### `renderer.js`

`renderer.js` isolates APEX- and theme-specific behavior from the rest of the runtime.

It follows a base-renderer pattern:

- `de.condes.plugin.adc.base_renderer`
- a concrete renderer namespace, currently based on Theme 42

The renderer is responsible for DOM- and widget-specific behavior such as region handling, dialog behavior, error rendering, focus behavior, and UI enable/disable handling. It should not own ADC business state.

### `controller.js`

`controller.js` is the runtime owner on the page.

It initializes ADC, stores shared runtime state, binds events, normalizes event data, manages the ADC event queue, performs AJAX transport, and executes the JavaScript response returned by the server.

Shared runtime state lives in `adc.state`. This includes, among other things:

- the current event context
- queued and quarantined events
- page items to submit
- standard messages
- cached page state information

### `actions.js`

`actions.js` is the public client-side action facade used by ADC responses.

Server-generated JavaScript calls `adc.actions.*`. These actions then delegate runtime concerns to the controller and UI-specific work to the renderer. This keeps the client API stable while allowing the runtime and renderer to evolve separately.

## Initialization and transport

During plugin rendering, ADC prepares the initial client configuration and initialization response on the server.

That configuration contains, among other things:

- the AJAX identifier
- bind-item metadata
- the list of page items ADC must submit
- the renderer namespace
- the initial JavaScript response
- additional observer items
- localized standard messages

The initialization response is transported in encoded form and executed during `adc.init(...)` on page load.

For later page events, ADC uses `apex.server.plugin(...)` to send the normalized event state back to the plugin AJAX endpoint. The server returns executable JavaScript, which the controller injects into the DOM and removes immediately afterwards.

This script-based response model is an intentional part of the current architecture. It keeps the server in control of action sequencing and allows ADC to mix state synchronization, error handling, and action execution in one response.

## Database side

The database side of ADC is built around metadata and rule evaluation.

### `ADC_INTERNAL`

`ADC_INTERNAL` implements the runtime core. It reads settings for the current request, initializes response handling, evaluates the relevant rule group, coordinates recursion, and creates default metadata for a page the first time ADC encounters it.

### `ADC_API`

`ADC_API` exposes a programmatic API to work with ADC from PL/SQL code. Most application developers will only need it occasionally, but it forms the public PL/SQL integration surface.

### `ADC_ADMIN`

`ADC_ADMIN` is responsible for maintaining ADC metadata and for export functionality. The administration application uses this package, but batch-style or scripted workflows can use it as well.

### Response generation

ADC collects client-side actions and errors on the server and formats them into a JavaScript response. That response can:

- synchronize changed item values back to the page
- render errors and warnings
- register APEX actions during initialization
- execute the client-side consequences of the chosen rule

## Metadata and rule groups

ADC stores its declarative model in metadata tables and views.

The central unit is the rule group of an APEX page. A rule group contains the rules for that page, and each rule contains:

- a human-readable description
- a technical condition
- one or more actions

The technical condition is written so that it can be evaluated against the current page state. ADC also derives from those conditions which page items are relevant for observation and submission.

If ADC is run on a page for the first time and no rule group exists yet, ADC creates the initial rule group and default rule automatically. This keeps onboarding lightweight: installing the plugin on a page is enough to make that page known to ADC.

## Extensibility

ADC is extensible on both the database and browser side.

Developers may define additional action types on the metadata side. If those action types require browser functionality, they can be exposed through `adc.actions.*` and supported by the active renderer.

If a project needs renderer behavior that differs from the shipped renderer, a project-specific renderer namespace can be configured in the plugin settings. The intended approach is to inherit from the base renderer and override only the Theme- or APEX-specific behavior that actually differs.

## Operational notes

ADC is designed for pages where dynamic behavior depends on database-backed logic. In those scenarios, the server roundtrip is usually not overhead added by ADC so much as a roundtrip that would have been needed anyway for validation, lookup, or state calculation.

At the same time, ADC is not trying to eliminate every roundtrip. It is a deliberate tradeoff: push the decision logic to the database, keep the page runtime generic, and make the overall behavior easier to reason about than a large web of page-local Dynamic Actions.
