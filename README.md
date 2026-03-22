# APEX Dynamic Controller (ADC)

ADC is a toolkit for Oracle APEX projects that need more dynamic behavior on a page than classic Dynamic Actions can comfortably provide.

The central idea is simple: keep the decision logic close to the data. Instead of distributing dynamic page behavior across many Dynamic Actions and custom JavaScript snippets, ADC evaluates declarative rules in the database and turns the result into browser-side actions on the page.

This makes ADC especially useful for complex forms where visibility, mandatory state, validation, refresh behavior, and follow-up actions depend on the current state of several page items at once.

## What ADC does

ADC is delivered as a Dynamic Action plugin. Once the plugin is present on a page, ADC can:

- observe relevant page events
- collect the current page state
- evaluate matching rules in the database
- execute the resulting client-side actions on the page

Rules are maintained declaratively in the ADC administration application. A rule describes when a certain use case applies and which actions should follow from it.

Typical examples are:

- show or hide items, buttons, and regions
- switch items between enabled, disabled, mandatory, and optional
- refresh items and regions
- validate values dynamically
- execute PL/SQL as part of rule processing

ADC also performs some useful checks automatically, such as dynamic mandatory checks and type-aware validation for number and date items.

## Why ADC exists

Dynamic Actions are very effective for isolated page interactions. They become harder to reason about once many items influence one another and behavior starts to spread across several Dynamic Actions, helper items, and page-specific JavaScript.

ADC addresses that situation by giving the page a dynamic controller with a clear split of responsibilities:

- the browser observes events and renders the outcome
- the database evaluates the rules
- the ADC metadata defines which behavior belongs to which use case

This keeps the dynamic control flow more explicit and usually easier to maintain over time.

## Main components

ADC consists of three major parts:

- the Dynamic Action plugin that runs on APEX pages
- the database objects that evaluate rules and build responses
- the ADC administration application used to maintain rules and action types

On the client side, the current JavaScript runtime is organized into four modules:

- `utils.js`
- `renderer.js`
- `controller.js`
- `actions.js`

The renderer isolates APEX- and theme-specific behavior. The controller owns runtime state, event handling, queueing, and transport. Actions form the public client API used by server-generated ADC responses.

## Documentation

Documentation is split into three parts:

- Conceptual and installation documents in [`DOC/`](./DOC/README.md)
- Developer-facing architecture notes in [`DOC/developer/`](./DOC/developer/Home.md)
- Generated API reference in [`DOC/api-doc/`](./DOC/api-doc/index.html)

## Installation

Installation notes and prerequisites are documented in [`DOC/Installation.md`](./DOC/Installation.md).

## Sample application

ADC ships with a sample application that demonstrates typical usage patterns. It is intended as a learning and showcase application and assumes that ADC is already installed in the workspace schema.
