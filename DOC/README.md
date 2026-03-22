# ADC Documentation

This folder contains the handwritten project documentation for ADC as well as the generated API reference.

## Overview

- [`how_it_works.md`](./how_it_works.md)
  Conceptual introduction to ADC, the problem it addresses, and the mental model behind dynamic pages.
- [`technical_description.md`](./technical_description.md)
  Technical overview of the current ADC architecture and runtime behavior.
- [`Installation.md`](./Installation.md)
  Installation prerequisites, installation modes, and deployment notes.

## Developer docs

- [`developer/Home.md`](./developer/Home.md)
  Developer-facing notes for the current JavaScript architecture, runtime flow, and refactoring state.

## API reference

- [`api-doc/index.html`](./api-doc/index.html)
  Natural Docs output generated from the source code.

## Rebuilding the API docs

Use [`../build_natural_docs.bat`](../build_natural_docs.bat) on Windows to rebuild the Natural Docs output into `DOC/api-doc`.
