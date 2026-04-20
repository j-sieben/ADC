# ADC vs ADC_BASIC

This page explains the PL/SQL type layering of `ADC_BASIC` and `ADC`.

## `ADC_BASIC`

`ADC_BASIC` is the system-delivered object type.

It contains:

- SQL-callable constants
- wrappers around `ADC_API`
- shipped methods for predefined ADC behavior

Its role is to expose standard ADC functionality in a stable PL/SQL form.

## `ADC`

`ADC` is defined as a subtype under `ADC_BASIC`.

In the shipped repository it is intentionally almost empty.

Its purpose is to serve as the custom extension shell for project-specific functionality.

## Design Intention

The upgrade strategy is deliberate:

- `ADC_BASIC` may be replaced by an ADC upgrade
- `ADC` should remain
- custom methods can be added to `ADC` without losing the inherited system methods

So the inheritance strategy is:

- shipped functionality lives in `ADC_BASIC`
- project-specific extensions live in `ADC`

This protects custom extensions across ADC updates.

## Practical Consequence

When application PL/SQL uses ADC, it typically addresses `ADC`.

That gives application code:

- the shipped methods inherited from `ADC_BASIC`
- room for custom project-specific methods in `ADC`

This is the main PL/SQL extension seam of ADC.

## Related

- [[PLSQL Integration]]
- [[Action Type Extensibility]]
