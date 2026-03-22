# Installation

ADC is intended to be installed into the APEX workspace schema. It can be installed in a full development setup or in a runtime-only setup for environments where the administration application is not needed.

## Prerequisites

ADC depends on a small set of companion utilities. These should be installed before ADC itself.

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

## Installation modes

### Full installation

Use the full installation on development systems.

This installs:

- the ADC database objects
- the Dynamic Action plugin
- the ADC administration application

Run:

- `adc.bat install`
- `./adc.sh install`

### Runtime-only installation

Use the runtime installation on systems where rules are executed but not maintained, for example test or production environments.

This installs the runtime objects and plugin, but omits the ADC administration application and its supporting APEX-side maintenance objects.

Run:

- `adc.bat runtime`
- `./adc.sh runtime`

## Rule deployment

Rules are typically maintained in a development environment and then transported to downstream environments.

ADC supports two deployment styles:

- rule groups can be exported as dedicated SQL scripts
- rule groups can be embedded into the exported APEX application as supporting objects

Which style is preferred depends on the delivery process of the project. ADC supports both, so teams can choose the variant that fits their release model best.

## Optional installations

### Sample application

The sample application is intended as a walkthrough and showcase for ADC usage.

Run:

- `adc.bat sample`
- `./adc.sh sample`

### Unit tests

Run:

- `adc.bat ut`
- `./adc.sh ut`

## Uninstall

Run:

- `adc.bat uninstall`
- `./adc.sh uninstall`

## Command overview

- `adc.bat install` / `./adc.sh install`
- `adc.bat runtime` / `./adc.sh runtime`
- `adc.bat sample` / `./adc.sh sample`
- `adc.bat ut` / `./adc.sh ut`
- `adc.bat uninstall` / `./adc.sh uninstall`
