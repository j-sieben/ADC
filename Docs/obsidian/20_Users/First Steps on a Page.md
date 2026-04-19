# First Steps on a Page

This page describes the first practical steps after ADC has been installed.

## 1. Add ADC to a Page

Add the ADC Dynamic Action plugin to the target page so ADC can observe relevant events and communicate with the server-side runtime. No administration is required to run this plugin.

## 2. Let ADC Discover the Page

When ADC runs on a page for the first time and no [[../50_Reference/glossary/Rule Group|rule group]] exists yet, ADC creates the initial rule group and a default rule automatically.

This is the first handoff from page-local configuration to ADC-managed behavior.

## 3. Maintain Rules

Use the ADC administration application to define:

- a human-readable rule description
- a technical condition
- one or more actions

The technical condition is expressed in a SQL-like style as a `where` condition. This means APEX and database developers can usually read and write the basic form without learning a proprietary rule language first.

## 4. Validate and Refine

Once rules exist, ADC can react to the current [[../50_Reference/glossary/Page State|page state]] by:

- showing or hiding items and regions
- changing mandatory or enabled state
- synchronizing values
- refreshing page components
- running PL/SQL-backed logic as part of the rule flow

## 5. Transport Rules

Rules are typically maintained in development and then moved downstream. ADC supports both dedicated SQL exports for rule groups and embedding rule content into exported APEX applications as supporting objects.

## Continue Reading

- [[Working With ADC]]
- [[../50_Reference/Installation and Operations|Installation and Operations]]
- [[../50_Reference/Glossary|Glossary]]
