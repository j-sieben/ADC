# Action Type Extensibility

This page is the entry point for the database-side extension model of ADC.

ADC action types are not only a JavaScript concern. They are modeled in database metadata, resolved at runtime by database packages, and exposed to application PL/SQL through the public type interface.

## Read This Section In Order

- [[Database/Home|Database Development]]
- [[Database/Action Type Metadata|Action Type Metadata]]
- [[Database/Action Type Runtime Resolution|Action Type Runtime Resolution]]
- [[Database/Database-Only Action Types|Database-Only Action Types]]
- [[Database/PLSQL Integration|PL/SQL Integration]]
- [[Database/ADC vs ADC_BASIC|ADC vs ADC_BASIC]]

## Summary

The extension story of ADC is broader than “add some JavaScript”.

ADC is extensible because:

- metadata defines what an action type is
- parameter metadata defines how it is configured and validated
- runtime packages resolve metadata into executable behavior
- object types expose stable PL/SQL entry points
- `ADC` provides a protected extension seam beyond the shipped baseline

## Related

- [[Database/Home|Database Development]]
- [[JavaScript/Home|JavaScript Development]]
- [[Extending ADC]]
