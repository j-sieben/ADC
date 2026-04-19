# What Is ADC

ADC, the APEX Dynamic Controller, is a toolkit for Oracle APEX projects that need dynamic page behavior without spreading the control logic across many individual Dynamic Actions and page-specific JavaScript fragments.

Its central idea is simple: keep the decision logic close to the data. The browser captures relevant page events, sends the current [[../50_Reference/glossary/Page State|page state]] to the server, and ADC evaluates declarative rules in the database to determine what should happen next on the page.

## What ADC Does

ADC is delivered as a Dynamic Action plugin. Once the plugin is present on a page, ADC can:

- observe relevant page events
- collect the current page state
- evaluate matching rules in the database
- execute resulting client-side actions on the page

Rules are maintained declaratively in the ADC administration application. A rule describes a [[../50_Reference/glossary/Use Case|use case]], its technical condition, and the actions that should follow.

## Main Components

- the Dynamic Action plugin running on APEX pages
- the database objects that evaluate rules and build responses
- the ADC administration application used to maintain rules and action types
- the sample application used for learning and demonstration

## Immediate Benefits

Even before a page accumulates many business-specific rules, ADC already improves page behavior in useful ways.

Among other things, ADC can provide:

- dynamic mandatory checks
- type-aware validation for number and date items
- dynamic rendering of validation feedback

As rules are added, the same runtime can then grow into more advanced page control without requiring a different architectural approach.

## Continue Reading

- [[Why ADC Exists]]
- [[../20_Users/Working With ADC|Working With ADC]]
- [[../40_Architecture/System Overview|System Overview]]
- [[../50_Reference/Glossary|Glossary]]
