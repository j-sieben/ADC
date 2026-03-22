# APEX Dynamic Controller (ADC)

ADC is a toolkit for APEX teams that want complex pages to stay understandable.

Its core promise is not that a page becomes more magical, but that it becomes easier to reason about. When a page grows many interdependent fields, regions, and validations, classic Dynamic Actions often spread the control flow across the page. ADC replaces that distributed behavior with a single dynamic controller that reacts to the current page state and applies declarative rules.

## The problem ADC addresses

APEX already offers a lot of dynamic behavior, and for small interactions that is usually enough. A field changes, another field is shown or hidden, a region is refreshed, and the job is done.

The difficulty starts when this behavior stops being local.

On complex forms, several things tend to happen at once:

- multiple items influence the same outcome
- the decision depends on database data
- the same rule affects visibility, validation, and values together
- one change triggers several follow-up changes
- the overall control flow becomes hard to trace

At that point, even a declarative approach can become difficult to maintain. The page may still work, but the path from cause to effect is no longer obvious.

ADC addresses exactly that situation.

## The basic idea

ADC turns the page into a *dynamic page*.

This means the page is still rendered by APEX, but its runtime control logic is delegated to ADC. The browser listens for relevant events, sends the current page state to the server, and the database decides what should happen next.

So instead of asking:

"Which Dynamic Action fires next?"

you can think in a different way:

"Given the current page state, which use case applies, and what actions follow from it?"

That shift in perspective is the real value of ADC.

## How a use case is expressed

ADC models dynamic behavior through rules.

A rule describes a use case in three layers:

- a human-readable description
- a technical condition
- one or more actions

The description is for people. The technical condition is what ADC evaluates. The actions are what ADC performs if the condition matches.

The important point about the technical condition is that it does not introduce a new proprietary rule language. It is written as a fragment in the style of the `WHERE` clause of a SQL query. In other words, if you already know how to express a condition in SQL, you already know the basic syntax ADC expects here.

Those actions can include both server-side and client-side effects. A rule can therefore validate data, calculate values, and update the page in one coherent step.

## A simple example

Imagine a parent select list and a child select list.

The child item should only be visible if child records exist for the selected parent value. If no child rows exist, the child item should disappear and a placeholder should be shown instead.

Without ADC, this often leads to several moving parts:

- a Dynamic Action for the parent item
- a server call to determine whether children exist
- a helper item or extra client logic to remember the outcome
- another Dynamic Action to react to that outcome
- a separate refresh of the child item

Each individual step may be simple, but the overall flow is fragmented.

With ADC, the same behavior reads more directly:

In ADC, the decision whether the selected parent has children can be expressed directly in the technical condition by calling a small helper function that returns whether child rows exist for the current parent value. That means the rule does not have to simulate this decision through helper items or several chained page events. The technical condition can ask the question directly, and the resulting rule can immediately control what the page should do next.

- if the selected parent has children, refresh and show the child item and hide the placeholder
- if the selected parent has no children, hide the child item, clear its value, and show the placeholder

The page still reacts dynamically, but the dynamic decision is expressed as a rule instead of being distributed across several page-level mechanisms.

## What happens on the page

Once the ADC plugin is present on a page, ADC determines which items matter for the current rule set and binds the relevant events for them.

When one of those events occurs, ADC collects the current values of the relevant page items together with event metadata such as:

- the firing item
- the firing event
- optional event payload

This information forms the *page state*.

The page state is then sent to the server, where ADC evaluates the matching rules for the page.

## What happens in the database

The database is where ADC decides what to do.

It evaluates the rule group of the current page against the incoming page state, chooses the rule that applies, executes any required PL/SQL work, and builds the browser-side response that should follow.

That response may:

- set or synchronize item values
- show errors and warnings
- refresh items or regions
- change visibility or enabled state
- trigger additional ADC-managed client behavior

If a rule changes the effective state in a way that should immediately trigger another rule, ADC can continue that evaluation recursively in the same roundtrip until the state is stable.

## Why this is useful

The main benefit of ADC is not that it removes all complexity. Complex forms remain complex. The benefit is that it gives that complexity a more coherent place to live.

Instead of scattering the logic across page-local JavaScript and several Dynamic Actions, ADC centralizes the decision process around:

- the current page state
- a declarative rule model
- a generic runtime on the page

This usually makes the behavior easier to inspect, easier to discuss, and easier to change later.

## What ADC gives you immediately

Even before a page has many business rules, ADC already changes the behavior of the page in useful ways.

Among other things, ADC can perform:

- dynamic mandatory checks
- type-aware validation for numbers and dates
- dynamic rendering of validation feedback

As rules are added, the same runtime can then grow into more advanced page control without requiring a different architectural approach.

## Tradeoffs

ADC is not free of tradeoffs, and it does not try to be.

The main tradeoff is that ADC deliberately accepts server roundtrips in exchange for keeping the decision logic in the database. For pages whose behavior depends heavily on data and validation logic, this is often a good trade. For pages that must stay entirely client-side, it may not be.

Another tradeoff is that rules are maintained outside the standard APEX page designer. ADC ships with its own administration application for that purpose. This adds a second working context, but it also provides a clearer home for dynamic rule maintenance.

## In one sentence

ADC is a way to give an APEX page a real dynamic controller: generic in the browser, declarative in metadata, and evaluated where the data and business logic already live.
