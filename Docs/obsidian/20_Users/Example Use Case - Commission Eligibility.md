# Example Use Case - Commission Eligibility

This example shows how a concrete ADC use case is implemented from business description to technical condition and resulting reactions.

The example is taken from the sample application rule group for page 19 in [`ADC/sample_app/apex_24_1/scripts/merge_rule_group_sadc_valbulk.sql`](../../../ADC/sample_app/apex_24_1/scripts/merge_rule_group_sadc_valbulk.sql).

## Business Description

In business terms, the page should behave like this:

- if the selected job is eligible for commission, the field `EMP_COMMISSION_PCT` must be entered
- if the selected job is not eligible for commission, the field `EMP_COMMISSION_PCT` should not be required and should be cleared or disabled from active use

This is the level at which a business analyst, application owner, or developer would usually describe the use case first.

## Technical Condition

The sample application implements the decision with a helper function in `SADC_UI`:

- `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_TRUE`
- `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_FALSE`

The helper function is documented in [`ADC/sample_app/packages/sadc_ui.pks`](../../../ADC/sample_app/packages/sadc_ui.pks) as checking whether the supplied job is eligible for `commission_pct`.

An important aspect of this example is that the decision is made inside the database and can therefore be based directly on database data. In many real use cases, that is exactly what is required: the dynamic behavior depends not only on the current page items, but also on business data and logic that already live in the database.

This is where ADC differs fundamentally from a solution based on standard APEX Dynamic Actions. Dynamic Actions can react to browser-side events, but they do not offer the same natural way to evaluate declarative rule conditions directly against database-side data and logic as part of one coherent rule mechanism.

This is an important ADC pattern:

- the business rule stays readable
- the technical condition remains compact
- database knowledge can be hidden behind a helper function instead of being duplicated in many page-level Dynamic Actions

## Decision Table

The same use case can be expressed as a decision table.

| Situation                      | Technical condition                                  | Reaction                                                                                                                         |
| ------------------------------ | ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Page opens                     | `initializing = c_true`                              | Initialize mandatory markers and raise an item event for `P19_EMP_JOB_ID` so the actual commission rule is evaluated immediately |
| Job is commission-eligible     | `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_TRUE`  | Mark `P19_EMP_COMMISSION_PCT` as mandatory                                                                                       |
| Job is not commission-eligible | `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_FALSE` | Mark `P19_EMP_COMMISSION_PCT` as optional and reset its active value/state                                                       |

This is often the clearest bridge between business language and ADC implementation. The decision table makes it obvious that the free-text use case becomes one or more explicit rules.

## Mapping to ADC Rules

In the sample export, the use case is implemented as three rules.

## 1. Initialization Rule

Free-text name:

- `the page opens`

Technical condition:

```sql
initializing = c_true
```

Reactions:

- `IS_MANDATORY` on `DOCUMENT` with `.sadc-mandatory`: Make all items on the page with this css class mandatory
- `RAISE_ITEM_EVENT` on `P19_EMP_JOB_ID`: Evaluate the use cases for this item during page initialization so the commission field is immediately set to mandatory or optional based on the selected job.

Purpose:

This rule prepares the page and then forces ADC to evaluate the job-dependent rule immediately, even before the user changes the job field manually.

## 2. Positive Rule

Free-text name:

- `a commission-eligible job is selected`

Technical condition:

```sql
sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_TRUE
```

Reaction:

- `IS_MANDATORY` on `P19_EMP_COMMISSION_PCT`

Purpose:

If the selected job allows commission, the commission percentage becomes required input.

## 3. Negative Rule

Free-text name:

- `a job without commission eligibility is selected`

Technical condition:

```sql
sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_FALSE
```

Reactions:

- `IS_OPTIONAL` on `P19_EMP_COMMISSION_PCT`
- `SET_ITEM` on `P19_EMP_COMMISSION_PCT`

Purpose:

If the selected job does not allow commission, the field is downgraded from required input and its active content is synchronized back to a non-required state.

## Professional Use Variant

The same use case could also be modeled at a higher level of abstraction.

Instead of two separate declarative rules based on:

- `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_TRUE`
- `sadc_ui.is_comm_eligible(P19_EMP_JOB_ID) = C_FALSE`

the rule entry point could be reduced to the event itself:

```sql
p_firing_item = 'P19_EMP_JOB_ID'
```

That rule would then call a PL/SQL package method. Inside that method, the application would determine whether the selected job is commission-eligible and would use ADC through the public type interface to trigger the resulting actions that are declarative in the sample version.

In other words, the use case would still start in ADC, but the detailed case distinction would be implemented procedurally in PL/SQL instead of being expressed as two explicit rule rows.

Typical outcome logic inside that PL/SQL method would be:

- if the job is commission-eligible, mark `P19_EMP_COMMISSION_PCT` as mandatory
- otherwise, mark `P19_EMP_COMMISSION_PCT` as optional and clear or reset it

This is a good example of ADC's more professional usage model:

- the rule remains the stable entry point
- PL/SQL performs the deeper case distinction
- ADC is still used to calculate and emit the resulting dynamic behavior

The tradeoff is clear:

- advantage: the implementation can become more compact and can absorb more complex decision logic cleanly
- disadvantage: the rule set becomes less self-explanatory because part of the behavior is no longer visible directly in the decision table

This is one of ADC's core strengths. It supports different levels of abstraction. It does not force every use case to remain fully declarative, but it allows fully declarative modeling wherever that is the clearer option.

## Why This Example Works Well

This sample demonstrates four useful ADC ideas at once:

- a use case starts as a business-readable sentence
- the technical condition can stay short by using a helper function
- the rule logic is transparent as a decision table
- the outcome is modeled declaratively through explicit reactions instead of chained page-local Dynamic Actions

Compared with an implementation based on standard APEX Dynamic Actions, the ADC approach is therefore more direct because the condition is evaluated where the relevant data already lives. The result of that evaluation then drives the resulting page behavior declaratively. ADC also allows an item to switch between mandatory and optional states, which is not available as a built-in capability in standard APEX Dynamic Actions.

## Practical Reading Pattern

When documenting or reviewing ADC rules, this sequence works well:

1. Write the business description in plain language.
2. Identify the state that ADC must inspect.
3. Express the decision as one or more technical conditions.
4. Write the decision table.
5. Map each row to ADC reactions.

## Related Sources

- [`ADC/sample_app/apex_24_1/scripts/merge_rule_group_sadc_valbulk.sql`](../../../ADC/sample_app/apex_24_1/scripts/merge_rule_group_sadc_valbulk.sql)
- [`ADC/sample_app/packages/sadc_ui.pks`](../../../ADC/sample_app/packages/sadc_ui.pks)
- [[Working With ADC]]
- [[../50_Reference/Glossary|Glossary]]
