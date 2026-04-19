# Installation and Operations

ADC is intended to be installed into the APEX workspace schema.

## Prerequisites

ADC depends on these companion utilities:

- `PIT`
- `UTL_TEXT`
- `UTL_APEX`

The install scripts under `ADC/install_scripts` check these prerequisites before installation.

### PIT

ADC uses PIT for logging, messaging, and parts of the runtime infrastructure.

Repository:
[https://github.com/j-sieben/PIT](https://github.com/j-sieben/PIT)

PIT can be installed directly into the workspace schema or into a shared utility schema. If it is installed outside the workspace schema, the required client installation for the workspace schema must also be executed.

### UTL_TEXT

ADC uses `UTL_TEXT` for text generation tasks, including response and export generation.

Repository:
[https://github.com/j-sieben/UTL_TEXT](https://github.com/j-sieben/UTL_TEXT)

As with PIT, `UTL_TEXT` may live in the workspace schema or in a shared utility schema, provided the workspace schema has the required client-side access.

### UTL_APEX

ADC uses `UTL_APEX` for APEX-specific helper functionality.

Repository:
[https://github.com/j-sieben/UTL_APEX](https://github.com/j-sieben/UTL_APEX)

`UTL_APEX` is an APEX-focused utility and is normally installed into the workspace schema directly.

## Main Commands

Run these commands from the `ADC/` directory:

- `./adc.sh install`
- `./adc.sh runtime`
- `./adc.sh sample`
- `./adc.sh ut`
- `./adc.sh uninstall`

Windows equivalents:

- `adc.bat install`
- `adc.bat runtime`
- `adc.bat sample`
- `adc.bat ut`
- `adc.bat uninstall`

## Installation Modes

`install`
Installs core objects, plugin, and ADC administration application.

`runtime`
Installs core objects and plugin, but omits the administration application. Rules can be imported but not generated. This is useful for production environments.

`sample`
Installs the sample application.

`ut`
Installs unit-test objects.

`uninstall`
Removes ADC, including the administration application.

## Rule Deployment

Rules are typically maintained in a development environment and then transported to downstream environments.

ADC supports two deployment styles:

- rule groups can be exported as dedicated SQL scripts
- rule groups can be embedded into the exported APEX application as supporting objects

Which style is preferred depends on the delivery process of the project. ADC supports both, so teams can choose the variant that fits their release model best.

## Optional Installations

### Sample Application

The sample application is intended as a walkthrough and showcase for ADC usage.

### Unit Tests

The `ut` installation path installs the database unit-test objects used for verification work.

## Operational Guidance

- Maintain rules in development first.
- Transport rules through dedicated SQL export files or supporting objects in APEX exports.
- Treat generated API documentation under `Docs/api_doc` as build output.

## Continue Reading

- [[Glossary]]
- [[../20_Users/First Steps on a Page|First Steps on a Page]]
- [[../30_Developers/Getting Started|Getting Started]]
