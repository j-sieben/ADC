# How Decision Tables Work

This note explains how ADC decision tables are used at runtime.

## Core Idea

ADC evaluates rules against the current [[../50_Reference/glossary/Page State|Page State]].

The page state is the runtime context that combines:

- the current values of relevant page items
- event metadata
- firing-item metadata
- predefined helper values such as `c_true` and `c_false`

## How Rule Matching Works

Each rule contains a technical condition.

A rule matches if its technical condition evaluates to `true` against the current page state.

This means ADC does not ask "which Dynamic Action should run next?" but instead:

- what is the current page state?
- which rule conditions are true for that state?

## What Happens If Multiple Rules Match

More than one rule may match the current page state.

In that case, ADC resolves the ambiguity by rule order:

- the rule with the lowest `sort_seq` wins

This makes rule priority explicit and deterministic.

## What Happens After a Rule Was Selected

Once the matching rule has been identified, ADC resolves that rule into its attached actions.

Those actions are then executed in action sort order.

In practice, this means:

1. ADC evaluates the decision table against the current page state.
2. ADC determines which rules match.
3. ADC selects the matching rule with the highest priority, meaning the lowest `sort_seq`.
4. ADC loads the actions linked to that rule.
5. ADC executes those actions in their defined order.

## Why This Matters

This model separates concerns cleanly:

- the decision table decides which rule applies
- the rule defines the business meaning of that situation
- the attached actions define the reaction

That makes ADC behavior easier to explain than a page flow distributed across many local Dynamic Actions.

## Related

- [[System Overview]]
- [[Request and Response Flow]]
- [[../50_Reference/glossary/Page State|Page State]]
- [[../50_Reference/glossary/Rule Group|Rule Group]]
- [[../50_Reference/glossary/Rule|Rule]]
