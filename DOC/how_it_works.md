# APEX Dynamic Controller (ADC)
ADC is a toolkit aimed at APEX designers wanting to simplify the construction of complex forms.

## The problem with complex forms
A complex form in APEX requires many JavaScript based interactions to be coded by an APEX developer. This is normally achieved by creating Dynamic Actions (DA) on the page. This declarative approach is best suited for minor to medium complex pages but it becomes a nightmare to maintain once many items are on the page or once a more sophisticated control over the page elements is required.

If many page items need to be deactivated, hidden, validated or refreshed based on the state of the items on the page, the necessary DA to achieve this overflow the page. While being declarative and easy to use one by one, the interaction and interdependecies between many DA on the page is hard to maintain, leading to a maintenance nightmare if requirements change.

Plus, it's by no means easy to decide which DA causes what behaviour on the page, nor is it easy to debug or test complex DA constructs

This all leads to the best practice to try and avoid overly complex forms in APEX and, should this not be possible, avoid DA in favour of a specialized JavaScript file implementing the necessary logic in JavaScript.

## The approach of ADC
Here, ADC steps in with a new approach. Rather than trying to control many DA on a page, all of them are replaced by a single DA, controlling a greater number of items in one go. Despite the DA approach of implementing logic outside the server in JavaScript, ADC implements the logic within the database, moving case trees to a SQL expression.

The basic principle is already known as a [Decision Table](https://en.wikipedia.org/wiki/Decision_table) pattern. But ADC is not an implementation of that pattern in PL/SQL or SQL but lends some basic ideas of this pattern to allow for a meta data driven approach to controling complex state on an APEX page.

I like to describe an APEX application page that is controlled by ADC a *Dynamic Page* as opposed to a normal APEX page that is static by design. On a dynamic page *use cases* can be defined with a somewhat special meaning: They represent an action the application user performs to achieve a change of the page status.
Each use case in this regard is composed of a technical condition, written in SQL syntax (as if it were part of a `where`-clause) to describe, when a given use case has been requested. If a specific use case has been detected all *actions* defined for that use case get executed. Each action on the other hand has a PL/SQL- and JavaScript branch allowing for simultaneous execution of server side and client side code with one action.

ADC ships with a list of predefined action types you can choose from, but it's also simple to add your own action types, extending the functionality of ADC.

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

To make an APEX page a dynamic page, all you have to do is install the ADC plugin on that page and run the page. Installing is possible even on page 0 to make ADC available for any page of your application. Although no use cases have been defined yet for that page, it already behaves differently:

- all mandatory items are checked live and dynamically
- all number or date items are checked for valid numbers or dates live and dynamically

This all comes in for free. But to continue with our example, we need to define use cases for the page: `<item> has children` and `<item> has no children`. In order to decide whether the parent item has children or not, you create a small function, taking the parent items actual value und retrieving `Y` or `N` to indicate whether child records exist. Image a function called `has_children(p_parent_id)` for that. Based on this function, you define the use cases technical condition to be `has_children(item) = 'Y'` and `has_children(item) = 'N'` respectively.

The column `item` in the example are column names derived from the item name on the page. So fi, if the page item is called `P1_PARENT`, a column named `p1_parent` is provided with the item's actual content as its column value.

As actions for rule *<item> has children* you define that three things are going to happen:

- refresh `<child_item>`
- show `<child_item>`
- hide `<placeholder_item>`

And the second rule reads:

- show `<placeholder_item>`
- set `<child_item>` to NULL and hide it

That's all there is to it. No hidden element on the page, no sepcialized DA anymore. If you run the page, you will see that the items behave as expected.

## How it works

### On the APEX page

As stated, you need to run the ADC plugin on any page you want to control by ADC. It sounds unbelievable, but it's true: There is no configuration or administration required, even if you add use cases to the page. No need to bind event handlers or anything alike, it simply and immediately works.

If the DA initializes, it installs event handler on any page item ADC is interested in. As we have the technical conditions at the use cases, ADC can find out which page items are refeferenced by a technical condition. As only these page items can cause a use case to be performed, this tells ADC indirectly what page items it needs to observer. So creating the technical condition also administers the plugin on the page.
  
If an event handler of any of the monitored page items fires, all actual element values of all fields of interest are sent to the database plus the name of the triggering element. This is called the *Page State* in ADC terms. It is similar to the session state but it contains the actual values of the page plus the additional, event related information.

### Upon PAGE LOAD event

The plugin does its best to read the default values of the relevant page items during the render phase. If it is succesful in reading the default values, all initial rules are applied before the page shows for the first time, leading to immediate initialization of the form according to the initalization rules. no additional roundtrip is required.

### Upon occurence of a relevant event
If an event is raised (`change` event on items of interes or `click` event of bound buttons), the firing element is defined and all relevant field values are collected and sent to the session state. Based on that information, the database limits the rules that get evaluated in order to calculate the response.

### At the database

The request is evaluated based on the technical conditions within the database to decide upon the next actions to take. It will perform all PL/SQL actions defined for the chosen rule. After that, and probably based on the outcome of this execution, JavaScript actions are defined, bundled in a `<script>` tag and resent to the plugin. Plus, all element values calculated or changed at the database are sent to the plugin again, refreshing the values shown at the client.

Any error that occurred during execution is collected at an error object and passed to the plugin. The plugin renders all errors according to the standard AEPX behaviour at the notification box and besides the page item.

The rules are evaluated using plain SQL. To allow for this, all rules get converted to a decision table that is stored within the meta data tables of ADC. As an example of the SQL created, review the following query the plugin created based on the rule of our example (code is for database version 12c, 11g is supported as well):

```
  with session_state as(
       select adc_admin.get_firing_item firing_item,
              adc_api.get_number('P1_PARENT') P1_PARENT
         from dual)
select /*+ NO_MERGE(s) */ 
       r.cru_id, r.cru_name, r.cru_firing_items,
       r.cra_cpi_id, r.cra_cat_id, r.cra_attribute
  from adc_bl_rules r
  join session_state s
    on instr(r.cru_firing_items, s.firing_item) > 0
 where (r.cru_id = 98 and (has_children(p1_parent) = adc_util.C_TRUE))
    or (r.cru_id = 99 and (has_children(p1_parent) = adc_util.C_FALSE))
 order by r.cru_sort_seq
 fetch first 1 row only
```

All rule conditions entered were converted to the `where` clause of this view. Based on the item values, one or more conditions may apply. Now the first matching condition (based on a `SORT_SEQ` column for each rule) is retrieved along with all defined actions connected to this rule. Should PL/SQL actions be defined for the matching rule, they are executed and the result is persisted at the page state. This puts the page state into a central communication position, allowing for simple API access and maintaining security and session awareness.

### Processing the response

This request is answered as follows:

```
<script id="RULE_20">
  /** Total duration: 1hsec*/
  de.condes.plugin.adc.actions.setItemValues({"item":[{"id":"P1_CHILD","value":""}]})
  de.condes.plugin.adc.actions.setErrors({"count":0,"errors":[]})
  
  // Recursion 1, Run 1: Rule 20 (Parent has no children), Auslösendes Element: "P1_CHILD", Dauer: 1hsec
  apex.item('P1_CHILD').hide();
  apex.item('P1_PLACEHOLDER').show();
</script>
```

The answer tells us that

- Item `P1_CHILD` is set to `NULL`
- No errors have ocurred
- Rule `Parent has no children` has been chosen for the reply. The rule is referenced by `RULE <sort_seq>`, not their ID. This makes it easier to spot the rule. Additionally, the rule name is provided to enable the plugin to show the rule name on the package if required.
- Item `P1_CHILD`gets hidden and item `P1_PLACEHOLDER` gets shown

The plugin executes the script by appending it to the document. It will be deleted immediately afterwards.
If a request comes in, all item values the plugin is interested in were sent as part of the page state of APEX already. Therefore, it's easy for the database part to get access to the element values in SQL. These values are collected in a dedicated view and presented as columns for the view.
  
### Recursive use case evaluation
It is possible that a use case changes the page state for one or many page items. This could lead to another use case to be executed. ADC takes this into account within the database and within only one roundtrip. If a use case changes a page item which causes another use case to be executed, ADC will do so until all changes are dealt with. This leads to a simpler rule setup.

## Advantages of this approach

Some important advanteges are realized using this approach:

### Easier logic control
As all decision logic is maintained in a single table within the database, it's easier to control complex logic and to see interdependencies. To make maintenance even easier, the plugin ships with a an APEX application allowing to review, create and change the use cases and their actions.

The plugin may be triggered by `change` events of page items as well as `click` events on page buttons. Only buttons and regions with a static ID are visible for the plugin, so you need to set this attribute if you want the plugin to control the button or region. Declaratively, you are allowed to

- set values of page items
- dynamically validate page item values
- automatically and dynamically validate mandatory items and number or date values
- refresh page items such as select lists as well as regions such as reports
- control visibility of page items, buttons and regions

### Better execution control
A rule is checked only if the triggering element is referenced within the rule condition. This way, only conditions that may potentially change the outcome of that rule are executed. This avoids unwanted side effects of existing rules.

### No unrequired DA activities
Nor is it required to create PL/SQL actions with a `NULL` action in order to pass an element value to the database, nor do you need any hidden helper fields on the page to store temporary information. Roundtrips to the database are limited to a total of one per plugin call. Almost no additional roundtrip is required. Additional roundtrips may occur if you want to stick to some declarative functionality APEX exposes, such as when you trigger the `apexrefresh` event. This, in turn, may cause a roundtrip to the database to refresh a report or a select list.

### Better logic control
Any call to the plugin results in a response from the database that includes the name of the rule that has been chosen for the given state. Plus, in the request to the database, you see each item value that got sent to the database. With this information, it's very easy to follow the logic stream and pin down potential logic flaws.

### Automatic type detection
If you compare values entered on the page, it's hard to do so because you need to treat date values different than number values and these different to string values. Based on the fact, that each page item is allowed to have a format mask to define the item's appearance on the page, ADC converts the item value to the respective data type using this format mask. Whether a page item is a number or date is either detected based on meta data of APEX (such as with a page item in a form region) or based on a format mask you apply to the given page item. If neither of this is possible, the page item is treated as string.

## Downsides of this approach
There are some disadvantages you should be aware of before taking ADC into account for your page

### Rules are maintained outside the APEX IDE
As I'm not an APEX team member, I obviously have no possibility to include ADC into the APEX-IDE. Therefore, a separate APEX application ships with ADC to enable developers to create and maintain rules. This is a disadvantage because developing in more than one IDE is somewhat boring.

### Export of rules is possible, but not with the application itself
The second disadvantage is closely related to the first downside. If you export a rule set, this then is not incorporated into the »normal« application export created by APEX. You can choose to do so when exporting the dynamic pages of an application. The dynamic pages are incorporated into the export files, but as additional scripts which do not get installed automatically but must be installed manually.
As an alternative, you may export all dynamic pages as script files, collected in a zip archive. Running thos scripts after having installed the application is a convenient way to add the dynamic control to the application, but it requires some extra effort.

### Roundtrips to the database server are required per change
ADC requires a roundtrip to the database every time a relevant event occurs on the page. This may or may not be a disadvantage. Some events may only result in JavaScript actions to be taken on page, such as hiding or showing items on the page. In this case, the need for a roundtrip to the server adds complexity and consumes time. In most cases though, a roundtrip to the database is required anyway, fi to check values against the database, validate input, refresh items or other examples. In all these cases, the amount of roundtrips required to change the page values may be reduced by ADC as it allows you to do any of the required actions within the database in one roundtrip. Overall, it balances out, keeping in mind that ADC is designed to control complex forms where roundtrips to the server are more likely than on trivial forms.

Another point to keep in mind is the fact that due to the roundtrip ADC is able to utilize the sheer power of SQL to do their computing which in many cases may be at least not slower than working clientside with roundtrips to gather certain information from the database. But if your application cannot afford connecting the database per relevant event, ADC might not be for you.
