# Declarative vs PL/SQL: Tradeoffs

ADC does not force a single modeling style.

Many use cases can be expressed fully declaratively through rules, technical conditions, and actions. Other use cases are easier to understand if the rule stays broad and the detailed case distinction is implemented in PL/SQL.

The important question is therefore not which style is "more correct". The real question is which style makes the use case clearer and easier to maintain.

## Stay Declarative When

Prefer a declarative rule model when:

- the use case can be read directly from the rule table
- the technical condition stays compact
- the resulting actions are explicit and easy to review
- the page behavior should be understandable without opening package code

This is usually the best choice for common visibility, mandatory-state, refresh, and straightforward validation behavior.

## Move to PL/SQL When

Prefer PL/SQL-backed Professional Use when:

- the final outcome depends on deeper business logic
- multiple detailed branches share the same event entry point
- the technical condition would become too indirect or repetitive
- the procedural version is easier to test, name, and reuse

In that model, ADC still provides the stable rule entry point, while PL/SQL calculates the resulting dynamic behavior through the ADC type interface.

## What You Gain From Declarative Rules

- rules are more self-explanatory
- the decision table remains visible in the ADC administration application
- reviews can focus on metadata first
- the path from business wording to technical rule is shorter

## What You Gain From PL/SQL

- complex case handling can be expressed more compactly
- business logic can stay close to existing database code
- repeated procedural logic can be encapsulated in packages
- broader use cases can be implemented without exploding the rule table

## What You Lose In Each Direction

If everything stays declarative:

- the rule table may grow wide and repetitive
- the same business distinction may appear in several technical conditions
- readability can drop once too many near-identical rules accumulate

If too much moves into PL/SQL:

- the visible rule set explains less by itself
- maintainers must jump between metadata and code more often
- simple use cases may become over-engineered

## A Good Team Convention

A pragmatic convention for ADC teams is:

1. model the first version declaratively
2. review whether the rule table still explains the use case clearly
3. move to PL/SQL only when it reduces real complexity rather than merely relocating it
4. document the chosen abstraction level for important use cases

## Example

The commission-eligibility example shows both styles:

- a declarative version with two explicit rules based on `sadc_ui.is_comm_eligible(...)`
- a Professional Use variant with a broader rule entry point and procedural case handling in PL/SQL

See:

- [[Example Use Case - Commission Eligibility]]
- [[../10_Overview/Choosing the Right ADC Level|Choosing the Right ADC Level]]
- [[../30_Developers/Database/PLSQL Integration|PL/SQL Integration]]

## Related

- [[Working With ADC]]
- [[../10_Overview/Choosing the Right ADC Level|Choosing the Right ADC Level]]
- [[../30_Developers/Action Type Extensibility|Action Type Extensibility]]
