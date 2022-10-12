# ADC
State Chart Toolkit is a toolkit aimed at APEX designers wanting to simplify the construction of complex forms.

ATTENTION: ADC is not intended to be used widely, rather it is a proof of concept. To use it in your projects, you need to be aware that its usage requires more effort to set up a working repository than for a normal plugin. If you expect ADC to simply be installed and it works, this is not possible due to the nature of the plugin and the lack of integration into the normal APEX API. So use it as a technology demonstration!

## The problem with complex forms
A complex form in APEX requires many JavaScript based interactions to be coded by an APEX developer. This is normally achieved by creating Dynamic Actions (DA) on the page. This declarative approach is best suited for minor to medium complex pages but it becomes a nightmare to maintain once many items are on the page or once a more sophisticated control over the page elements is required.

If many page items need to be deactivated, hidden, validated or refreshed based on the state of the items on the page, the necessary DA to achieve this overflow the page. While being declarative and easy to use one by one, the interaction and interdependecies between many DA on the page is hard to maintain, leading to a maintenance nightmare if requirements change.

Plus, it's by no means easy to decide which DA causes what behaviour on the page, nor is it easy to debug or test complex DA constructs

This all leads to the best practice to try and avoid overly complex forms in APEX and, should this not be possible, avoid DA in favour of a specialized JavaScript file implementing the necessary logic in JavaScript.

## The approach of State Chart Toolkit

Here, ADC steps in with a new approach. Rather than trying to control many DA on a page, all of them are replaced by a single DA, controlling a greater number of items in one go. Despite the DA approach of implementing logic outside the server in JavaScript, ADC implements the logic within the database, moving case trees to a SQL expression.

The basic principle is already known as a [Decision Table](https://en.wikipedia.org/wiki/Decision_table) pattern. But ADC is not an implementation of that pattern in PL/SQL or SQL but lends some basic ideas of this pattern to allow for a meta data driven approach to controling complex state on an APEX page.

To achive this, ADC introduces the concept of *Rule Groups* which collect as many *Rules* as you like in an ordered fashion. Each rule on the other hand is composed of a condition, written in SQL syntax (as if it were part of a `where`-clause) and a collection of *Actions*. These actions get executed in the order that is defined within the rule. Each action on the other hand has a PL/SQL- and JavaScript branch allowing for simultaneous execution of server side and client side code with one action.

To make it easier for a developer to create actions, an action is a reference to an *Action Type* that defines the actions to take.

## Example

Imagine a rule set that executes a very simple task: Based on the value of a *Selection List* in APEX, it decides whether to show or not to show a child *Select List* item. Problem is that the decision is based on a database query: if child records exist, the page refreshes and shows the child item, otherwise it shows a placeholder item indicating that no child records exist. This item is to be rendered as a *Display Only* item. To make things more interesting, no submit of the page is allowed, anything happens on a single page life cycle.

### The APEX approach

To decide whether to show or hide the child item or its placeholder item, a DA has to be created that fires if the parent select list item changes. It reads the new value, goes to the database ands find out whether a child record exists. This decision is stored in a hidden element on the page (you can't declaratively execute other JavaScript tasks based on the outcome of an action within a DA). As soon as this hidden element changes, a second DA fires to find out which child item to show or hidde. Plus, it needs to refresh the child select list if a child record was found.

The latter is not required to be coded by a DA because you might define the parent select list for the child select list. If the parent changes, the child select list gets refreshed. The other DA to adjust visibility of the elements are required in any case.

Although this is not overly complex, you see that the following extras are required:

- A hidden element to retrieve the information whether child records exist or not
- A roundtrip to the server to find out whether child records exist or not
- A roundtrip to the server to refresh the child select list.
- Two DA to control the flow

Also, keep in mind that the child select list will refresh anyway, regardless of whether child records exist or not. Even if you optimize refresh this will only avoid a roundtrip if the parent select list changes to NULL.

### The ADC approach

In ADC, you define a rule group using a dedicated APEX application. You define the Application- and Page ID the rule group references and give it a descriptive name.

Next, you define two rules for this rule group: `<item> has children` and `<item> has no children`. As a rule to decide whether the parent item has children or not, you create a small function, taking the parent items actual value und retrieving `Y` or `N` to indicate whether child records exist. Image a function called `has_children(p_parent_id)` for that. Based on this function, you define the rules condition to be `has_children(item) = 'Y'` and `has_children(item) = 'N'` respectively.

The column `item` in the example are column names derived from the item name on the page. So fi, if the page item is called `P1_PARENT`, a column named `p1_parent` is provided with the item's actual content as its column value.

As actions for rule *<item> has children* you define that three things are going to happen:

- `<child_item>` shall refresh
- `<child_item>` shall show
- `<placeholder_item>` shall hide

And the second rule reads:

- `<placeholder_item>` shall show
- `<child_item>` shall be set to NULL and hidden

That's all there is to it. No hidden element on the page, no sepcialized DA anymore. If you run the page, you will see that the items behave as expected.

## How it works

### On the APEX page

On every page you want ADC to take control for, you implement a single DA per rule group you define for that page. This DA fires on `Page Load` and does not require any parameterization beside the name of the rule group it belongs to. No event handlers, no additional JavaScript code is required on the page.

If the DA initializes, it is told which elements to bind by the database. Plus, it is told which element values the database is interested in. On any occurence of a change event on any bound element, all actual element values of all fields of interest are sent to the database plus the name of the triggering element. After initialization, the plugin fires one time to allow the database to initialize the state of the elements based on the actual content of the items (Keep in mind that the session state might be out of sync when initially showing the page. A default value for an item is known to the browser but not to the session state, for example).

### Upon PAGE LOAD event

The plugin does its best to read the default values of the relevant page items during the render phase. If it is succesful in reading the default values, all initial rules are applied before the page shows for the first time, leading to immediate initialization of the form according to the initalization rules. no additional roundtrip is required.

### Upon occurence of a relevant event
If an event is raised (`change` event on items of interes or `click` event of bound buttons), the firing element is defined and all relevant field values are collected and sent to the session state. Based on that information, the database limits the rules that get evaluated in order to calculate the response.

### At the database

The request is evaluated by the rules within the database to decide upon the next actions to take. It will perform all PL/SQL actions defined for the chosen rule. After that, and probably based on the outcome of this execution, JavaScript actions are defined, bundled in a `<script>` tag and resent to the plugin. Plus, all element values calculated or changed at the database are sent to the plugin again, refreshing the values shown at the client.

Any error that occurred during execution is collected at an error object and passed to the plugin. The plugin renders all errors according to the standard AEPX behaviour at the notification box and besides the page item.

The rules are evaluated using plain SQL. To allow for this, all rules get converted to a view that is stored within the database. As an example of the SQL created, review the following query the plugin created based on the rule of our example (code is for database version 12c, 11g is supported as well):

```
  with session_state as(
       select ':' || adc_admin.get_firing_item || ':' firing_item,
              to_number(v('P1_PARENT'), '9990') P1_PARENT
         from dual)
select /*+ NO_MERGE(s) */ 
       r.cru_id, r.cru_name, r.cru_firing_items,
       r.cra_cpi_id, r.cra_cat_id, r.cra_attribute
  from adc_bl_rules r
  join session_state s
    on instr(r.cru_firing_items, s.firing_item) > 0
 where (r.cru_id = 98 and (has_children(p1_parent) = 'Y'))
    or (r.cru_id = 99 and (has_children(p1_parent) = 'N'))
 order by r.cru_sort_seq
 fetch first 1 row only
```

All rule conditions entered were converted to the `where` clause of this view. Based on the item values, one or more conditions may apply. Now the first matching condition (based on a `SORT_SEQ` column for each rule) is retrieved along with all defined actions connected to this rule. Should PL/SQL actions be defined for the matching rule, they are executed and the result is persisted at the session state. This puts the session state into a central communication position, allowing for simple API access and maintaining security and session awareness.

### Processing the response

This request is answered as follows:

```
<script id="RULE_20">
  de.condes.plugin.adc.setRuleName('Parent has no children')
  de.condes.plugin.adc.setItemValues({"item":[{"id":"P1_CHILD","value":""}]})
  de.condes.plugin.adc.setErrors({"count":0,"errors":[]})
  apex.item('P1_CHILD').hide();
  apex.item('P1_PLACEHOLDER').show();
</script>
```

The answer tells us that

- Rule `Parent has no children` has been chosen for the reply. The rule is referenced by `RULE_<sort_seq>`, not their ID. This makes it easier to spot the rule. Additionally, the rule name is provided to enable the plugin to show the rule name on the package if required.
- Item `P1_CHILD` is set to `NULL`
- No errors have ocurred
- Item `P1_CHILD`gets hidden and item `P1_PLACEHOLDER` gets shown

The plugin executes the script by appending it to the document. It will be deleted immediately afterwards.
If a request comes in, all item values the plugin is interested in were sent to the session state of APEX already. Therefore, it's easy for the database part to get access to the element values in SQL. These values are collected in a dedicated view and presented as columns for the view.


## Advantages of this approach

Some important advanteges are realized using this approach:

### Easier logic control
As all decision logic is maintained in a single table within the database, it's easier to control complex logic and to see interdependencies. To make maintenance even easier, the plugin ships with a small APEX application allowing to review, create and change the rules.

The plugin may be triggered by `change` events of page items as well as `click` events on page buttons. At the moment, only buttons and regions with a static ID are seen by the plugin, so you need to set this attribute if you want the plugin to control the button or region. Declaratively, you are allowed to

- set values of page items
- refresh page items such as select lists as well as regions such as reports
- control visibility of page items, buttons and regions

### Better execution control
A rule is checked only if the triggering element is referenced within the rule condition. This way, only conditions that may potentially change the outcome of that rule are executed. This avoids unwanted side effects of existing rules.

### No unrequired DA activities
Nor is it required to create PL/SQL actions with a `NULL` action in order to pass an element value to the database, nor do you need any hidden helper fields on the page to store temporary information. Roundtrips to the database are limited to a total of one per plugin call. Almost no additional roundtrip is required. Additional roundtrips may occur if you want to stick to some declarative functionality APEX exposes, such as when you trigger the `apexrefresh` event. This, in turn, may cause a roundtrip to the database to refresh a report or a select list.

### Better logic control
Any call to the plugin results in a response from the database that includes the name of the rule that has been chosen for the given state. Plus, in the request (`post`) to the database, you see each item value that got sent to the database. With this information, it's very easy to follow the logic stream and pin down potential logic flaws.

### Automatic type detection
If you compare values entered on the page, it's hard to do so because you need to treat date values different than number values and these different to string values. Based on the fact, that each page item is allowed to have a format mask to define the item's appearance on the page, ADC converts the item value to the respective data type using this format mask. In order to make this work, you have to set the format mask of the respective page items. If the format mask is null, the element will be treated as string.

## Downsides of this approach
There are some disadvantages you should be aware of before taking ADC into account for your page

### Rules are maintained outside the APEX IDE
As I'm not an APEX team member, I obviously have no possibility to include ADC into the APEX-IDE. Therefore, a separate APEX application ships with ADC to enable developers to create and maintain rules. This is a disadvantage because developing in more than one IDE is somewhat boring.

### Export of rules is possible, but not with the application itself
The second disadvantage is closely related to the first downside. If you export a rule set, this then is not incorporated into the »normal« application export created by APEX. You can insert the export into the normal export file or install the rules after having imported the APEX application. But when importing the rules separate from the application, it must be ensured that the ADC import is aware of the application and workspace ID the application is imported to. This is solvable but not really user friendly.

### Roundtrips to the database server are required per change
ADC requires a roundtrip to the database every time a relevant event occurs on the page. This may or may not be a disadvantage. Some events may only result in JavaScript actions to be taken on page, such as hiding or showing items on the page. In this case, the need for a roundtrip to the server adds complexity and consumes time. In most cases though, a roundtrip to the database is required anyway, fi to check values against the database, validate input, refresh items or other examples. In all these cases, the amount of roundtrips required to change the page values may be reduced by ADC as it allows you to do any of the required actions within the database in one roundtrip. Overall, it balances out, keeping in mind that ADC is designed to control complex forms where roundtrips to the server are more likely than on trivial forms.

Another point to keep in mind is the fact that due to the roundtrip ADC is able to utilize the sheer power of SQL to do their computing which in many cases may be at least not slower than working clientside with roundtrips to gather certain information from the database. But if your application cannot afford connecting the database per relevant event, ADC might not be for you.
