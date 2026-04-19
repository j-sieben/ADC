# System Overview

ADC gives an APEX page a dynamic controller without moving the decision logic into page-specific JavaScript.

## End-to-End Picture

1. The ADC plugin initializes on the page.
2. The browser observes configured events.
3. ADC collects the current [[../50_Reference/glossary/Page State|page state]].
4. The page state is sent to the plugin AJAX endpoint.
5. PL/SQL packages evaluate the relevant [[../50_Reference/glossary/Rule Group|rule group]].
6. ADC returns browser-side actions.
7. The browser applies those actions to the page.

## Main Runtime Parts

- browser-side plugin runtime
- PL/SQL evaluation and response generation
- metadata model for rules and action types
- administration application for maintenance and export

## Core Database Packages

- `ADC_INTERNAL`
  Runtime core for request handling, rule evaluation, recursion, and default metadata creation.
- `ADC_API`
  Public PL/SQL integration surface.
- `ADC_ADMIN`
  Metadata maintenance and export functionality.

## Continue Reading

- [[How Decision Tables Work]]
- [[Request and Response Flow]]
- [[../30_Developers/Repository Map|Repository Map]]
- [[../50_Reference/Glossary|Glossary]]
