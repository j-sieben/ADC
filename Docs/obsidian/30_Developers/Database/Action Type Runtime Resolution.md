# Action Type Runtime Resolution

This page explains how ADC resolves an action type at runtime.

## From Rule Action to Action Type

At runtime, ADC does not execute an action type directly from the `ADC_RULE_ACTIONS` row.

Instead:

1. the rule action provides the selected action type via `cra_cat_id`
2. the rule action also provides the concrete parameter values in `cra_param_1` to `cra_param_3`
3. ADC loads the matching action type metadata
4. ADC loads the parameter type metadata for the used parameter slots
5. ADC evaluates the action template into executable behavior

## `ADC_INTERNAL.evaluate_action_type(...)`

The key runtime method is `ADC_INTERNAL.evaluate_action_type(...)`.

It reads:

- `cat_pl_sql`
- `cat_js`
- the parameter types for the three parameter positions

The rule action contributes the actual parameter values, while the action type metadata contributes the executable patterns and typing information.

## Execution Paths

From there, ADC takes one or both paths:

- `ADC_INTERNAL.get_javascript_for_action(...)`
  Resolves the JavaScript portion of an action type.
- `ADC_INTERNAL.execute_action(...)`
  Resolves the PL/SQL portion and executes it, while also collecting JavaScript into the response if needed.

This means an action type may be:

- JavaScript-only
- PL/SQL-only
- a combination of both

## Runtime Chain

The runtime sequence is:

1. a rule matches the current page state
2. ADC selects the linked rule actions
3. each rule action references an action type
4. ADC resolves the action type metadata
5. ADC evaluates parameter values according to parameter type
6. ADC executes PL/SQL and or appends JavaScript to the response

## Why Parameter Types Matter

`ADC_PARAMETER` is involved because parameter values are not always used literally.

Depending on parameter type, ADC may:

- validate the value when the action is defined
- convert or evaluate the value at runtime
- resolve dynamic expressions, SQL, functions, or selectors

That is why action-type extensibility depends not only on `ADC_ACTION_TYPES`, but also on the parameter type layer.

## Related

- [[Action Type Metadata]]
- [[Database-Only Action Types]]
- [[PLSQL Integration]]
