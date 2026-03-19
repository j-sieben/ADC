# ADC Project Overview

Last updated: 2026-03-19

## What this repository is

This repository contains the "APEX Dynamic Controller (ADC)".
It is primarily an Oracle APEX / PL/SQL project, not a typical application repository with a local runtime such as Node, Python, or Java.

ADC implements a metadata-driven dynamic controller for APEX pages:

- A Dynamic Action plugin integrates ADC into APEX pages.
- JavaScript on the client captures relevant page events and sends page state to the database.
- PL/SQL packages evaluate rules ("use cases") and return client-side actions.
- An APEX admin/designer application is included to maintain those rules declaratively.
- A sample application and unit test objects are included as optional components.

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
- `DOC`
  Generated and handwritten documentation, including Natural Docs output and conceptual markdown files.
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
- Core API exposure appears intentionally split between internal packages and extensible object types `adc_basic` and `adc`.
- Plugin static assets exist for at least APEX `20.2` and `24.1`.
- The current `24.1` JavaScript file set is intentionally compact: `utils.js`, `renderer.js`, `controller.js`, `actions.js`, plus minified variants.
- Shared runtime state and callback registration currently live inside `controller.js`; there are no standalone `state.js` or `callbacks.js` files anymore.
- Documentation in `DOC/` is split deliberately:
  - handwritten docs remain at the root of `DOC`
  - generated Natural Docs API output now lives in `DOC/api-doc`
  - developer-facing architecture notes now live in `DOC/developer`

## Working assumptions for future sessions

- Changes should be treated as database-source-first changes unless a task explicitly targets generated docs.
- `DOC/` likely contains generated output and concept docs; changes there should be deliberate.
- Existing local modifications were already present before analysis:
  - `ADC/core/views/adc_action_param_types_v.vw`
  - `ADC/plugin/files/adc_24_1/js/actions.js`
  - `.DS_Store` files

## Suggested next inspection targets

- `ADC/core/packages/adc_internal.pkb`
- `ADC/core/packages/adc_page_state.pkb`
- `ADC/core/packages/adc_response.pkb`
- `ADC/plugin/files/adc_24_1/js/controller.js`
- `ADC/plugin/files/adc_24_1/js/actions.js`
- `ADC/apex/apex_24_1/install.sql`
