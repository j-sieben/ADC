# Page State

The page state is the normalized runtime state ADC evaluates when deciding which rule applies.

At runtime, ADC does not evaluate a rule only against the current values of page items. Instead, it builds a decision-table context that combines:

- the current values of all relevant page items
- metadata about the current event
- metadata about the current firing item
- a small set of predefined helper values

This combined state is then queried by the generated decision table for the current [[Rule Group]].

## What the Page State Contains

The page state contains the current values ADC knows for the relevant page items of the page.

On top of those page-item columns, ADC injects additional pseudo columns and helper columns into the generated decision table.

## Predefined Helper Columns

These columns are always available in the generated rule view:

- `c_true`
  Constant flag value for true.
- `c_false`
  Constant flag value for false.
- `p_event`
  The current event name as returned by `adc_api.get_event`.
- `p_event_data`
  The current event payload as returned by `adc_api.get_event_data`.
- `p_firing_item`
  The current firing item as returned by `adc_api.get_firing_item`.

ADC generates these values in the decision-table templates in [`ADC/core/scripts/utl_text_templates_ADC.sql`](../../../ADC/core/scripts/utl_text_templates_ADC.sql).

## Event-Derived Columns

ADC also generates event-specific columns from the registered event types. These are derived from `ADC_EVENT_TYPES.CET_COLUMN_NAME` and are written into the decision table in lowercase.

Examples present in the repository are:

- `selection_changed`
- `dialog_cancelled`
- `dialog_closed`
- `after_refresh`
- `change`
- `click`
- `command`
- `double_click`
- `enter`
- `initializing`
- `notification`

For standard events, these event columns are typically boolean flags represented as `c_true` or `c_false`.

Example:

- when the current event is `initialize`, the column `initializing` becomes `c_true`
- otherwise, `initializing` is `c_false`

This is why rule conditions such as `initializing = c_true` work.

## Firing-Item Columns

ADC also generates item-oriented pseudo columns that indicate whether a specific item is the current firing item.

Example:

- for a page item `P19_EMP_JOB_ID`, ADC can expose a corresponding flag column that becomes `c_true` when this item fired the current event and `c_false` otherwise

This allows conditions that distinguish not only by value, but also by which page item actually triggered the evaluation.

## Event Data Columns

Some events contribute structured data instead of just a boolean flag.

The clearest example is the `command` event:

- the generated `command` column can be filled from `adc_api.get_event_data('command')`

This allows rules to react not just to the existence of an event, but also to a command payload transported with that event.

More generally, `p_event_data` exposes the raw event payload, and ADC helper code can extract keys from JSON-style event data where appropriate.

## Why This Matters for Rule Conditions

The decision table is therefore broader than "all page items plus one event".

A technical condition can reference:

- page item values such as `P19_EMP_JOB_ID`
- helper constants such as `c_true` and `c_false`
- event flags such as `initializing`
- event metadata such as `p_event`
- event payload via `p_event_data`
- the firing item via `p_firing_item`

This is what makes conditions like these possible:

```sql
initializing = c_true
```

```sql
sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = c_true
```

```sql
p_firing_item = 'P19_EMP_JOB_ID'
```

## Practical Rule-Authoring Guidance

When writing or reading a technical condition, it helps to think in layers:

1. Which page item values matter?
2. Which event caused the evaluation?
3. Which item fired the event?
4. Is there additional event payload?
5. Do I need to compare against `c_true` or `c_false` rather than plain string literals?

That mental model usually makes ADC rule conditions easier to understand.

## Notes on Naming

- In the generated decision table, event column names are based on the configured `CET_COLUMN_NAME`.
- ADC lowers those names when generating the view, so conditions usually refer to lowercase names such as `initializing`.
- Some examples in older texts or discussions may use names like `c_clicked`. In the current metadata-driven decision-table model, the canonical event column is based on the configured event column name, for example `click`.

## Related

- [[../Glossary]]
- [[Rule Group]]
- [[Use Case]]
- [[Rule]]
