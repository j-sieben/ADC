# Getting Started

This page is the primary developer entry point for the ADC repository.

## What This Repository Contains

ADC is primarily an Oracle APEX and PL/SQL project.

ADC combines:

- plugin code for browser-side integration
- PL/SQL packages for rule evaluation and response generation
- an APEX administration application for maintaining metadata
- a sample application
- unit-test objects and install scripts

## Recommended Reading Order

1. [[Repository Map]]
2. [[../40_Architecture/System Overview|System Overview]]
3. [[../40_Architecture/Request and Response Flow|Request and Response Flow]]
4. [[Database/Home|Database Development]]
5. [[Action Type Extensibility]]
6. [[JavaScript/Home|JavaScript Development]]
7. [[JavaScript/JavaScript Runtime|JavaScript Runtime]]
8. [[Debugging and Observability]]
9. [[How to Debug an ADC Use Case End-to-End]]
10. [[../50_Reference/Installation and Operations|Installation and Operations]]
11. [[../50_Reference/Glossary|Glossary]]

## Important Entry Points

- root [`README.md`](../../../README.md)
- shell installer [`ADC/adc.sh`](../../../ADC/adc.sh)
- Windows installer [`ADC/adc.bat`](../../../ADC/adc.bat)
- plugin package [`ADC/plugin/packages/adc_plugin.pks`](../../../ADC/plugin/packages/adc_plugin.pks)
- generated API reference [Natural Docs](../../api_doc/index.html)

## Working Assumption

Most feature work starts on the database side or in the plugin JavaScript runtime. Generated documentation under `Docs/api_doc` should normally be treated as output, not as handwritten source.
