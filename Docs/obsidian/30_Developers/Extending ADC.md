# Extending ADC

ADC is extensible on both the database and browser side.

## Common Extension Cases

### Add a new client action

Start in `actions.js`.

Preferred split:

- action entry point in `actions.js`
- runtime mechanics in `controller.js`
- UI and markup-specific behavior in `renderer.js`

### Add a new callback

Register a named callback through `adc.callbacks.register(name, fn)` instead of introducing free-form code strings.

### Add shared runtime state

Only add new data to `adc.state` in `controller.js` if it is genuinely shared runtime state.

### Support a new APEX version

Prefer a new concrete renderer namespace that inherits from the base renderer and overrides only incompatible behavior.

## Continue Reading

- [[JavaScript Runtime]]
- [[../40_Architecture/System Overview|System Overview]]
- [[../50_Reference/Glossary|Glossary]]
