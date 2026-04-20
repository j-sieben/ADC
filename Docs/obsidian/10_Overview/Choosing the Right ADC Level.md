# Choosing the Right ADC Level

ADC supports different abstraction levels. That is one of its strengths, but it also means teams need a simple way to decide how far they should go for a given use case.

This page is that decision aid.

## Basic Use

Choose Basic Use if the use case is still easy to read as explicit rules and the outcome is primarily page behavior.

Typical fits are:

- show or hide an item or region
- switch an item between mandatory and optional
- enable, disable, or refresh page elements
- validate values based on a small number of visible page-state conditions

Why this level works well:

- the rules remain self-explanatory
- the decision table stays close to the business wording
- the resulting behavior is easy to review in the ADC administration application

## Advanced Use

Choose Advanced Use if the rule is still best expressed declaratively, but the resulting behavior must not be limited to browser-side effects.

Typical fits are:

- a rule triggers both a page change and database-side processing
- a response must update state in the database before the client behavior is determined
- a use case combines validation, state synchronization, and UI feedback

Why this level works well:

- the rule remains visible and understandable as ADC metadata
- database-side work and browser-side behavior stay within one rule flow
- the team keeps a declarative model without forcing everything into JavaScript

## Professional Use

Choose Professional Use if the rule should remain the entry point, but the detailed case distinction is easier to implement procedurally in PL/SQL.

Typical fits are:

- the technical condition would otherwise become too broad or too hard to read
- several related cases share the same event entry point
- the final dynamic outcome depends on business logic that is clearer in PL/SQL than in several explicit rule rows
- a project wants to encapsulate repeated dynamic behavior behind package methods

Why this level works well:

- the page still enters ADC through a stable rule model
- application PL/SQL can calculate the final behavior in a controlled way
- the public ADC type interface allows procedural logic without bypassing ADC entirely

Tradeoff:

- the rule set becomes less self-explanatory because part of the use case is now hidden behind PL/SQL code

## Extensibility

Choose custom action types if the required behavior is reusable across several rules or several applications.

Typical fits are:

- the same technical action pattern appears repeatedly
- projects need their own higher-level dynamic primitives
- a standard action should be enriched by project-specific metadata and parameter semantics

Why this level works well:

- reuse moves into ADC itself instead of being copied across rule sets
- behavior can be standardized across projects
- configuration stays metadata-driven

## Practical Rule of Thumb

Use the lowest level that keeps the use case clear.

That usually means:

1. Start declaratively.
2. Stay declarative while the rule set is still readable.
3. Move detailed case distinction into PL/SQL when the declarative version becomes harder to understand than the procedural one.
4. Introduce custom action types when a behavior pattern repeats often enough to deserve its own reusable abstraction.

## Warning Signs

You are probably too low-level if:

- many rules differ only in small technical details
- the same action combinations are repeated again and again
- the decision table becomes long but no clearer

You are probably too high-level if:

- the visible rules no longer explain the page behavior on their own
- reviewers must always open PL/SQL code to understand a common use case
- different pages hide similar logic in package methods without a shared pattern

## Related

- [[What Is ADC]]
- [[../20_Users/Working With ADC|Working With ADC]]
- [[../20_Users/Declarative vs PL-SQL Tradeoffs|Declarative vs PL/SQL: Tradeoffs]]
- [[../20_Users/Example Use Case - Commission Eligibility|Example Use Case - Commission Eligibility]]
- [[../30_Developers/Action Type Extensibility|Action Type Extensibility]]
