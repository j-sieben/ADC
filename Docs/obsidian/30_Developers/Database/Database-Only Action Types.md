# Database-Only Action Types

One of the distinctive strengths of ADC is that an action type does not have to produce JavaScript at all.

An action type may be:

- JavaScript-only
- PL/SQL-only
- a combination of both

This means ADC can perform not only browser-side reactions, but also server-side behavior directly in the database as part of rule execution.

## Example: `PLSQL_CODE`

A clear system-delivered example is `PLSQL_CODE`.

Its metadata definition uses:

- `cat_id = 'PLSQL_CODE'`
- `cat_pl_sql = q'{adc_api.execute_plsql(q'[#PARAM_1#]');}'`
- `cat_js = q'{}'`

So the action type has:

- a server-side implementation
- no client-side JavaScript payload

Its parameter metadata assigns one required parameter of type `PROCEDURE`, so the action expects executable PL/SQL code as its payload.

## Runtime Flow

When a rule action references `PLSQL_CODE`:

1. the rule action supplies the concrete parameter value in `cra_param_1`
2. `ADC_INTERNAL.evaluate_action_type(...)` loads the metadata
3. ADC sees that `cat_pl_sql` is filled while `cat_js` is empty
4. `ADC_INTERNAL.execute_action(...)` parameterizes the PL/SQL template
5. the generated PL/SQL calls `adc_api.execute_plsql(...)`
6. `ADC_API.execute_plsql(...)` delegates to `ADC_ACTIONS.execute_plsql(...)`
7. `ADC_ACTIONS.execute_plsql(...)` executes the block directly in the database

The action is therefore fully resolved and executed on the server side.

## Why This Matters

This expands ADC beyond browser orchestration.

A rule can react to page state not only by changing the UI, but also by:

- changing session state
- calculating values from SQL
- invoking procedural PL/SQL logic
- registering errors
- triggering further server-side processing

## Other PL/SQL-Only System Actions

The repository contains several other system action types with `cat_pl_sql` but no `cat_js`, for example:

- `EXECUTE_COMMAND`
- `RAISE_ITEM_EVENT`
- `REMEMBER_PAGE_STATE`
- `SEND_VALIDATE_PAGE`
- `SET_ELEMENT_FROM_STMT`
- `SHOW_ERROR`
- `STOP_RULE`
- `XOR`

These examples show that ADC action types are not limited to client-side effects. Many of them are database-side control operations.

## Related

- [[Action Type Runtime Resolution]]
- [[PLSQL Integration]]
- [[Action Type Metadata]]
