# Debugging and Observability

ADC is designed so that its runtime behavior can be inspected during development.

This matters because ADC evaluates rules in the database, may recurse, and then emits the resulting client-side behavior as JavaScript. Without traceability, that would be difficult to understand. ADC therefore exposes its work at several levels.

## Browser-Level Observation

The ADC response can always be inspected in the browser developer tools.

At runtime, ADC sends the current page state to the server and receives an HTML script element as the response. The client appends that script to the DOM, executes it, and removes it again.

This means developers can inspect:

- the AJAX request sent by ADC
- the returned response payload
- the JavaScript that ADC generated for the current rule evaluation

This is often the fastest way to understand what ADC decided for a given event.

## What the Response Contains

The response is not only executable code. In debug-friendly form it also documents where that code came from.

Depending on debug level and response size, the generated script can include:

- the selected rule
- the rules executed during recursive processing
- the recursion depth
- the rule sort sequence and rule name
- the firing item that caused the evaluation
- timing information

This makes it possible to follow the rule chain from browser response back to the originating ADC rule.

## APEX Debug and ADC Instrumentation

ADC participates in the surrounding debug context, but an important part of the database-side behavior comes from PIT itself.

When APEX runs in debug mode, ADC exposes more diagnostic detail on both sides of the runtime boundary:

- on the database side, ADC uses PIT-based instrumentation
- on the client side, ADC writes to `apex.debug`

On the database side, the actual switch into debug behavior is governed by PIT. PIT uses its own session adapter logic to determine the current application user and whether APEX is running in debug mode. If APEX debug is active, PIT switches to the corresponding debug output level and provides the additional information ADC emits through PIT.

Because the ADC code base is instrumented throughout, its internal processing becomes part of the normal debugging workflow instead of requiring a separate tracing mechanism.

## Server-Side Traceability

On the database side, ADC collects diagnostic information while evaluating rules and building the response.

Important aspects are:

- recursive rule execution is registered explicitly
- the response builder distinguishes different JavaScript debug levels
- comments and origin markers can be embedded into the generated response
- PIT log level influences how much detail remains in the final response

This means debugging is not limited to the final outcome. The path that produced that outcome can also be traced.

## Client-Side Traceability

On the browser side, the JavaScript runtime logs important runtime steps through `apex.debug`.

Examples include:

- ADC initialization
- event detection and normalization
- which page items are submitted
- request dispatch to the plugin endpoint
- response handling
- renderer- and action-level behavior

This helps correlate what happened in the page with what the database evaluated.

## Practical Workflow

In practice, a useful debugging workflow is:

1. Run the APEX page in debug mode.
2. Trigger the relevant page event.
3. Inspect the ADC request and response in the browser developer tools.
4. Use the rule information in the response to identify the originating rule.
5. Correlate the browser output with the APEX and PIT debug information.

## Related

- [[../40_Architecture/Request and Response Flow|Request and Response Flow]]
- [[Database/Home|Database Development]]
- [[JavaScript/Home|JavaScript Development]]
