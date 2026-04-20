# How to Debug an ADC Use Case End-to-End

This page describes a practical debugging path from page event to final ADC response.

ADC spans browser events, page-state collection, server-side rule evaluation, recursive response generation, and client-side execution. Debugging works best if these steps are inspected in order.

## 1. Start With the Use Case

Before looking at logs, identify:

- which page item or event starts the use case
- which rule group should react
- which visible outcome is expected

Without that framing, ADC can look more complex than it actually is.

## 2. Run the Page in APEX Debug Mode

Run the page with APEX debug enabled.

On the client side, ADC writes diagnostic information to `apex.debug`. On the database side, ADC uses PIT instrumentation. PIT's own session adapter detects the effective APEX debug context and switches PIT output accordingly.

## 3. Trigger the Event and Inspect the Browser Request

Open the browser developer tools and trigger the relevant event.

Inspect the ADC AJAX request and check:

- the firing item
- the event name
- the submitted page items
- any event data sent with the request

If the expected item or event is missing here, the problem is usually before rule evaluation.

## 4. Inspect the Returned ADC Response

Inspect the server response in the browser tools.

ADC returns an HTML script element. That response is both executable behavior and a debugging surface.

Depending on debug level and response size, the response can show:

- which rule was selected
- which rules were executed recursively
- recursion depth
- rule sort sequence and rule name
- firing item
- timing information

This is the fastest bridge from observed page behavior back to a concrete rule.

## 5. Correlate the Response With the Rule Definition

Use the rule information from the response to locate the originating rule in ADC metadata.

At this step, verify:

- the technical condition that matched
- whether another rule with a lower priority should have matched instead
- whether recursion is expected or accidental
- which actions belong to the selected rule

If the response identifies more than one executed rule, review the recursive chain instead of only the first match.

## 6. Decide Where the Real Complexity Lives

Once the rule is identified, ask which layer actually contains the problem:

- technical condition and decision-table logic
- action metadata
- PL/SQL executed by the rule
- client-side action execution
- renderer behavior

This prevents wasted debugging in the wrong layer.

## 7. Follow the Correct Branch

If the issue is in rule selection:

- review the decision table and the effective [[../50_Reference/glossary/Page State|Page State]]
- compare matching candidates and `sort_seq`

If the issue is in procedural behavior:

- inspect the package code behind the Professional Use path
- verify how `ADC`, `ADC_BASIC`, or wrapped action methods are used

If the issue is in the browser result:

- inspect the generated JavaScript
- follow the call into `adc.actions.*`
- continue into the renderer if the visual effect still looks wrong

## 8. Use the Existing Cross-Checks

ADC already gives several cross-check points:

- browser request
- browser response
- `apex.debug` output
- PIT-based database trace output
- rule identity and recursion markers in the response

Use them together. Looking at only one of them often hides the real cause.

## Common Failure Patterns

- the expected item is not observed because the rule does not reference it the way the runtime expects
- the technical condition is correct, but another rule wins because of `sort_seq`
- recursion is correct, but the developer only inspects the first rule and misses the later one
- the database result is right, but the client-side action or renderer makes the outcome look wrong
- too much logic was hidden in PL/SQL, so the visible rule no longer explains the failure clearly

## Related

- [[Debugging and Observability]]
- [[../40_Architecture/Request and Response Flow|Request and Response Flow]]
- [[../40_Architecture/How Decision Tables Work|How Decision Tables Work]]
- [[Database/PLSQL Integration|PL/SQL Integration]]
- [[JavaScript/JavaScript Runtime|JavaScript Runtime]]
