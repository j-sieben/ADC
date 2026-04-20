# ADC Project Overview

Last updated: 2026-04-20

## What this repository is

This repository contains the "APEX Dynamic Controller (ADC)".
It is primarily an Oracle APEX / PL/SQL project, not a typical application repository with a local runtime such as Node, Python, or Java.

ADC implements a metadata-driven dynamic controller for APEX pages:

- A Dynamic Action plugin integrates ADC into APEX pages.
- JavaScript on the client captures relevant page events and sends page state to the database.
- PL/SQL packages evaluate rules ("use cases") and return client-side actions.
- Actions are not limited to browser behavior; ADC can execute database-side work and client-side work within the same rule flow.
- An APEX admin/designer application is included to maintain those rules declaratively.
- A sample application and unit test objects are included as optional components.

ADC supports multiple abstraction levels:

- Basic Use
  Declarative rules produce dynamic client-side behavior through JavaScript.
- Advanced Use
  Declarative rules remain central, but resulting actions may execute both in the database and on the page.
- Professional Use
  Rules can act as broader entry points while detailed case logic is implemented procedurally in PL/SQL through the public ADC type interface.
- Extensibility
  Projects can define their own action types and add project-specific PL/SQL methods.

## Top-level structure

- `ADC/core`
  Core database objects: tables, views, sequences, packages, types, messages, version-specific install fragments.
- `ADC/plugin`
  Dynamic Action plugin package and static files (JavaScript/CSS, zipped plugin assets).
- `ADC/apex`
  APEX admin/designer application packages, scripts, tables, views, and version-specific install files.
- `ADC/sample_app`
  Sample application plus helper package/scripts.
- `ADC/unit_test`
  Database unit test packages and helper SQL types/tables.
- `ADC/install_scripts`
  Orchestration scripts for core/runtime/sample/unit test installation and uninstall.
- `ADC/tools`
  Reusable SQL*Plus helper scripts for object creation, recompilation, environment setup, and script execution.
- `Docs`
  Handwritten project documentation in Obsidian structure plus generated Natural Docs API output.
- `ND`
  Natural Docs working data.

## Key entry points

- `README.md`
  Functional overview and motivation.
- `ADC/install.sh`
  Interactive shell installer for core + APEX admin application.
- `ADC/install_runtime.sh`
  Runtime-focused install path.
- `ADC/core/install.sql`
  Builds core schema objects and seeds metadata/messages/action types.
- `ADC/plugin/packages/adc_plugin.pks`
  Plugin surface with `render` and `ajax`.

## Installation flow observed

The normal shell installer asks for:

- schema owner
- password
- database service / PDB
- APEX workspace
- optional admin application ID

Then it runs:

- `install_scripts/install_core.sql`
- `install_scripts/install_apex.sql`

`install_core.sql` in turn installs:

- core schema objects
- plugin objects
- seeded metadata/messages/templates
- version-specific APEX fragments

## Important implementation observations

- The repository is SQL*Plus-driven. Installation and object creation are assembled from many smaller scripts in `ADC/tools`.
- Core PL/SQL packages include `adc_internal`, `adc_api`, `adc_admin`, `adc_page_state`, `adc_response`, and others.
- Core API exposure is intentionally layered:
  - application PL/SQL typically works through type `adc`
  - `adc` inherits from `adc_basic`
  - `adc_basic` implements its methods through `adc_api`
  - `adc_api` wraps `adc_internal` and forms the technical package boundary
- Plugin static assets exist for at least APEX `20.2` and `24.1`.
- The current `24.1` JavaScript file set is intentionally compact: `utils.js`, `renderer.js`, `controller.js`, `actions.js`, plus minified variants.
- Shared runtime state and callback registration currently live inside `controller.js`; there are no standalone `state.js` or `callbacks.js` files anymore.
- Action types are a database metadata feature, not just a JavaScript feature:
  - `adc_action_types` stores executable PL/SQL and JavaScript templates
  - parameter metadata controls configuration and validation
  - some action types are database-only and use no JavaScript at all
- ADC extracts observed page items from technical conditions and related metadata, so rule configuration indirectly defines which items are watched at runtime.
- Documentation in `Docs/` is split deliberately:
  - handwritten docs live in `Docs/obsidian`
  - generated Natural Docs API output lives in `Docs/api_doc`
- Observability is a first-class runtime concern:
  - the browser can inspect ADC request/response payloads directly
  - the response may include rule origin, recursion depth, firing item, and timing data
  - database-side instrumentation uses PIT
  - PIT's own session adapter determines whether APEX debug is active and switches PIT output accordingly
  - client-side instrumentation uses `apex.debug`

## Working assumptions for future sessions

- Changes should be treated as database-source-first changes unless a task explicitly targets generated docs.
- `Docs/` contains both handwritten documentation and generated API output; changes there should be deliberate.
- Existing local modifications were already present before analysis:
  - `ADC/core/views/adc_action_param_types_v.vw`
  - `ADC/plugin/files/adc_24_1/js/actions.js`
  - `.DS_Store` files

## Suggested next inspection targets

- `ADC/core/packages/adc_internal.pkb`
- `ADC/core/packages/adc_page_state.pkb`
- `ADC/core/packages/adc_response.pkb`
- `ADC/core/packages/adc_api.pkb`
- `ADC/core/types/adc_basic.tpb`
- `ADC/core/types/adc.tpb`
- `ADC/plugin/files/adc_24_1/js/controller.js`
- `ADC/plugin/files/adc_24_1/js/actions.js`
- `ADC/apex/apex_24_1/install.sql`
