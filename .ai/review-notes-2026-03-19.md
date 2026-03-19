# Review Notes 2026-03-19

## Installation

Fixed:

- `ADC/install_scripts/uninstall_core.sql`
  - used `@tools/init_apex.sql ADC` although the called script expects APEX-specific positional parameters
  - now uses `@tools/init.sql`
- `ADC/uninstall.sh`
  - removed invalid trailing `pause` / `EOF`
  - added `set -euo pipefail`
- `ADC/install_runtime.sh`
  - removed invalid trailing `pause` / `EOF`
  - added `set -euo pipefail`
- `ADC/install_sample.sh`
  - removed invalid trailing `pause` / `EOF`
  - added `set -euo pipefail`
- `ADC/install_ut.sh`
  - removed invalid trailing `pause` / `EOF`
  - replaced pipe-based invocation with direct `sqlplus ... @install_scripts/install_ut.sql`
  - added `set -euo pipefail`
- `ADC/tools/init_apex.sql`
  - corrected error text `APC` -> `ADC`
- `ADC/unit_test/uninstall.sql`
  - corrected typo `UT_ADC_RECURSION_STAXCK` -> `UT_ADC_RECURSION_STACK`

Remaining concerns:

- shell wrappers still pass credentials directly on the `sqlplus` command line
- install / uninstall flows rely heavily on SQL*Plus substitution variables and silent environment assumptions
- APEX version mapping currently supports only `20.2` and `24.1`

## JavaScript architecture

Observed coupling:

- `controller.js` depends on `actions`, `renderer`, and `utils`
- `actions.js` depends back on `controller`, `renderer`, and `utils`
- `renderer.js` depends on `controller` and `utils`
- `renderer.clearErrors()` mutates `gErrors` / `gWarnings` that are declared in `actions.js`

That means the conceptual separation exists, but the implementation is not strictly layered. It is closer to a mutually dependent namespace cluster than to clean modules.

Key modernization targets:

1. Remove dynamic execution hotspots
   - `eval(...)` for renderer lookup
   - `new Function(...)` for event callbacks
   - raw `<script>` DOM execution where avoidable
2. Break cyclic dependencies
   - move shared state into a dedicated state/service module
   - expose narrow interfaces instead of cross-calling globals
3. Replace jQuery-internal event manipulation
   - current code uses `$._data(...)` and manual handler surgery
4. Introduce explicit response protocol
   - prefer structured JSON commands over JavaScript snippets
5. Preserve APEX compatibility first
   - avoid a "rewrite first" approach

## Recommended refactoring order

1. Stabilize installation and smoke-test install/uninstall paths
2. Isolate JS shared state and error store
3. Replace renderer lookup and dynamic callback creation with explicit registries
4. Introduce typed response objects alongside existing script responses
5. Migrate one action family at a time from script snippets to command handling
6. Remove jQuery only after transport, state, and rendering seams are explicit
