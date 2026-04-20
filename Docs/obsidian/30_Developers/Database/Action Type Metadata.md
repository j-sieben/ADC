# Action Type Metadata

This page explains how ADC action types are modeled in database metadata.

## Core Tables

The central metadata tables are:

- `ADC_ACTION_TYPES`
- `ADC_ACTION_PARAMETERS`
- `ADC_ACTION_PARAM_TYPES`
- `ADC_ACTION_PARAM_VISUAL_TYPES`
- `ADC_ACTION_TYPE_GROUPS`
- `ADC_ACTION_TYPE_OWNERS`

## `ADC_ACTION_TYPES`

`ADC_ACTION_TYPES` is the key table for action-type definitions.

An action type stores:

- `cat_id`
  The technical key of the action type.
- `cat_catg_id`
  The action type group used in the UI.
- `cat_caif_id`
  The allowed focus or item scope for the action.
- `cat_cato_id`
  The action type owner. The default owner is `ADC`.
- `cat_pl_sql`
  A PL/SQL pattern to execute on the server.
- `cat_js`
  A JavaScript pattern to execute on the client.
- `cat_is_editable`
  Whether the action type may be edited in the UI.
- `cat_raise_recursive`
  Whether the action type may trigger recursion.
- `cat_active`
  Whether the action type is active.

This means ADC stores executable behavior in metadata, not only labels and UI texts.

## Parameters

`ADC_ACTION_PARAMETERS` links an action type to up to three parameter slots.

Each parameter references a reusable entry in `ADC_ACTION_PARAM_TYPES`, which defines:

- the parameter type ID
- translated name and description
- the visual type used in the ADC UI
- an optional LOV query for list-based parameters

So an action type does not merely have three free-form strings. Its parameters are typed, validated, and rendered according to metadata.

## UI Semantics

`ADC_ACTION_PARAM_VISUAL_TYPES` defines how a parameter type is displayed in the ADC designer.

Examples include:

- text input
- text area
- select list
- static list
- switch

This separates runtime behavior from designer UI concerns.

## Grouping and Ownership

`ADC_ACTION_TYPE_GROUPS` groups action types in the UI.

`ADC_ACTION_TYPE_OWNERS` separates system-delivered action types from user-defined owner schemes.

This allows ADC to distinguish:

- shipped action types under owner `ADC`
- project-specific or user-defined extensions under other owners

## Maintenance Packages

`ADC_ADMIN` is the central package for maintaining this metadata.

It exposes merge and validation procedures for:

- action type groups
- action type owners
- action parameter visual types
- action parameter types
- action types
- action parameters

`ADC_PARAMETER` complements this model by validating and evaluating parameter values.

## Related

- [[Action Type Extensibility]]
- [[Action Type Runtime Resolution]]
- [[Database-Only Action Types]]
