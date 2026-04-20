# Why ADC Exists

Classic APEX Dynamic Actions are effective for isolated interactions. They become harder to reason about when multiple page items influence one another, decisions depend on database state, and one change triggers several follow-up effects.

ADC addresses that situation by introducing a dynamic controller with a clearer split of responsibilities:

- the browser observes events and renders results
- the database evaluates the rules
- ADC metadata defines which behavior belongs to which use case
- PL/SQL may refine or determine the final behavior for more complex use cases

This does not remove complexity from complex forms. It gives that complexity a more coherent place to live.

## Tradeoffs

ADC deliberately accepts server roundtrips in exchange for keeping the decision logic in the database. That is usually a good fit for pages whose behavior already depends on validation, lookups, or business logic in the database.

ADC also introduces a second working context beyond the APEX page designer: the ADC administration application where rules and metadata are maintained.

## Continue Reading

- [[What Is ADC]]
- [[../40_Architecture/System Overview|System Overview]]
- [[../50_Reference/Glossary|Glossary]]
