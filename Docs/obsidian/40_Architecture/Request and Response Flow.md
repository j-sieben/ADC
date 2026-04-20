# Request and Response Flow

The most important runtime concept in ADC is the [[../50_Reference/glossary/Page State|page state]].

ADC does not observe every item on the page automatically. Instead, it derives the runtime flow from the configured rules.

## Preparation Before Runtime

Before ADC can react to page events, it determines which page items are relevant for the current rule group.

ADC extracts those relevant items from the technical conditions of the rules and from the metadata required to execute those rules safely. These relevant items are then used for two purposes:

- they become part of the decision-table context
- they are candidates for client-side observation on the page

This is why a technical condition does not only express logic. It also indirectly defines which page items ADC must pay attention to at runtime.

This also makes ADC easy to use in practice: define the use cases, add the technical conditions, and ADC can immediately derive which items it needs to observe at runtime. No separate page-level maintenance is required just to wire observation logic by hand.

## Binding Observers on the Page

When the plugin is initialized, ADC sends the client the list of items and events that must be observed.

For these relevant page items, ADC injects or binds observers on the page so that user interactions such as changing a value or clicking an element are reported back to ADC.

In practice, this means:

- relevant items are bound to the events ADC watches for them
- those events are normalized by the client runtime
- ADC does not need page-specific JavaScript for every individual rule

## Request Flow

1. `adc.init(...)` initializes the client runtime.
2. ADC binds the events relevant for the page.
3. A monitored event occurs on one of the relevant page items.
4. The controller normalizes the event and determines the current page state on the client.
5. ADC sends that page state and its event metadata to `apex.server.plugin(...)`.

## Server-Side Processing

On the server, ADC:

- reads the current page state
- reads request settings
- evaluates the matching rules
- executes required PL/SQL work
- collects client-side consequences
- prepares the response payload

The response generation can be recursive: If one action changes the effective state in a way that should trigger additional rule evaluation, ADC continues that processing step recursively until the state is stable or no further rule execution is needed.

During this process, ADC collects the resulting browser-side consequences and assembles them into an executable  JavaScript response snippet rather than a JSON command protocol.

## Response Flow

The client runtime injects the returned script into the DOM, executes it, and removes it immediately afterwards. Those scripts typically call `adc.actions.*`, which then delegate to the controller and renderer.

This means the browser does not decide locally which UI changes should happen next. The database computes the response, and the client executes that response.

For developers, this is also an important observation point. The response can be inspected directly in the browser developer tools, which makes it possible to see both the generated JavaScript and the trace information ADC embeds for debugging.

## Continue Reading

- [[How Decision Tables Work]]
- [[System Overview]]
- [[../30_Developers/Debugging and Observability|Debugging and Observability]]
- [[../30_Developers/JavaScript/JavaScript Runtime|JavaScript Runtime]]
- [[../50_Reference/Glossary|Glossary]]
