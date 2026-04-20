# Working With ADC

This page is the practical user-oriented entry point for ADC.

## Typical Workflow

1. Install ADC into the target workspace schema.
2. Import or install the ADC plugin.
3. Add the plugin to an APEX page.
4. Let ADC create the initial [[../50_Reference/glossary/Rule Group|rule group]] for that page.
5. Maintain rules and action types in the ADC administration application.
6. Transport rules to downstream environments.

## What Changes for an APEX Team

With ADC, dynamic page behavior is no longer primarily modeled through many local Dynamic Actions. Instead, the page becomes a consumer of declarative rules maintained in ADC.

That means:

- page events are still raised in the browser
- decisions are evaluated against the current page state in the database
- the resulting actions are rendered back on the page

## Levels of Use

ADC supports different levels of use, but the detailed decision guidance lives on a separate page:

- [[../10_Overview/Choosing the Right ADC Level|Choosing the Right ADC Level]]
- [[Declarative vs PL-SQL Tradeoffs|Declarative vs PL/SQL: Tradeoffs]]

## Good Fits for ADC

- forms with many interdependent items
- pages where visibility, validation, and values depend on shared state
- applications where business rules already live close to the database

## Less Ideal Fits

- pages that must stay almost entirely client-side
- very small isolated interactions that standard Dynamic Actions already handle clearly

## Continue Reading

- [[First Steps on a Page]]
- [[Example Use Case - Commission Eligibility]]
- [[Declarative vs PL-SQL Tradeoffs|Declarative vs PL/SQL: Tradeoffs]]
- [[../10_Overview/Choosing the Right ADC Level|Choosing the Right ADC Level]]
- [[../50_Reference/Installation and Operations|Installation and Operations]]
- [[../50_Reference/Glossary|Glossary]]
