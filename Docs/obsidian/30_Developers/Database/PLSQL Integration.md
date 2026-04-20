# PL/SQL Integration

This page explains how ADC can be used from PL/SQL code.

## Public Call Chain

In normal application code, PL/SQL does not usually call `ADC_API` directly.

The typical call chain is:

- application PL/SQL calls methods on type `ADC`
- `ADC` inherits the shipped methods from `ADC_BASIC`
- `ADC_BASIC` implements those methods via `ADC_API`

So `ADC_API` is the technical implementation layer behind the public PL/SQL type interface.

## Why This Matters

This makes it possible to use ADC deliberately from application-specific PL/SQL packages.

That is important for use cases where the final dynamic behavior is easier to compute procedurally than declaratively.

Examples:

- complex case distinctions
- deeper procedural branching
- logic that already exists in PL/SQL packages
- dynamic behavior depending on richer server-side state

## Mixed Declarative and Procedural Approach

ADC supports a mixed approach:

1. a rule identifies the situation at a high level
2. PL/SQL performs the deeper case distinction
3. methods on `ADC` are used to determine the resulting dynamic behavior

This means the rule layer stays declarative, but the final outcome may still be computed procedurally when that is clearer or more maintainable.

## Typical Methods Used From PL/SQL

Application PL/SQL may use methods on `ADC` such as:

- `execute_action(...)`
- `get_javascript_for_action(...)`
- `execute_command(...)`
- `register_error(...)`
- `set_value_from_statement(...)`
- `validate_page(...)`

These methods are inherited from `ADC_BASIC` and implemented there through `ADC_API`.

## Architectural Consequence

ADC is therefore not only a metadata-driven rule system. It is also a programmable dynamic-control interface for database-side application logic.

That is one of the main reasons ADC can handle more complex dynamic behavior than a purely client-oriented design.

## Related

- [[ADC vs ADC_BASIC]]
- [[Action Type Extensibility]]
- [[Database-Only Action Types]]
