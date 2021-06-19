# APEX Dynamic Controller (ADC)

## Motivation

ADC is an implementation proposal for a dynamic controller for APEX applications. It extends and partially replaces the more static controller functionality of APEX by supporting controler activities on the rendered page dynamically.

"Static" in this context means the stored calculations, validations, processes and branches offered by APEX-IDE within the scope of the normal request-response lifecycle. Server side conditions and authorization schemes are also part of the static controler functionality.

"Dynamic" on the other hand refers to anything that is processed while the page is shown to the user. The only declarative option available for this functionality has been Dynamic Actions so far. DA were meant as a declarative wrapper around JavaScript code on the page to enable the developer to declaratively define common tasks such as hiding or showing page items. Another focus is partial page refresh for regions which support it or select lists and the like. It was not meant to form a fully functional controler though.

As form pages become complex, this becomes a severe drawback. The amount of DAs on the page quickly raises beyond easily manageable numbers. The resulting page faces the same problems as the well known "trigger hell" in PL/SQL database programming.

Using Dynamic Actions as a replacement for a dynamic controller breaches the architectural pattern because it implements decision logic in the view layer and does not cleanly separate this code from the view. It also requires new page to be created items solely for the purpose of storing temporary values (hidden page items) to offer an anchor for further DAs to react on their changes. Implementing the dynamic controller in JavaScript on the other hand seems to be a bad choice as this code would be too far away from the data it requires to take decisions and calculate the necessary next steps. Moreover, declarative facilitation no longer exists, leaving the developer alone with APEX's internals.

To overcome this, a different approach has to be chosen. Following the Model-View-Control paradigm, a component must be created that architecturally cleanly implements control over the dynamic processes of the page as a complete controller. As most validations and even conditions that have to be evaluated in response to the activity of the user require access to the data stored within the database, it is best to implement the controller in PL/SQL. This is in contrast to the existing Dynamic Actions which are implemented as code generators for JavaScript code basically.

## How it works

A dynamic controller has to react on user actions which boils down to reacting on JavaScript events. The APEX Dynamic Controller (ADC) solves this problem by instructing a static JavaScript component to register observers during page initialization to respond to relevant events. When such an event occurs, it responds by informing the ADC about the request. The request contains the current session state in terms of the values entered by the user, but also the firing item, the event and other metadata. As it is clearly defined what the observer has to do when it detects an event (inform ADC about it), there is no need for application specific JavaScript functionality anymore. The JavaScript componente of ADC therefore is implemented once and simply used on the page.

The event along with its metadata is passed to a generic rule machine that decides on the next steps to take. An APEX page may define as many rules, called "Use Case" in ADC, as necessary. Each use case refers to one or many actions to perform when the use case is chosen by the rule machine. Those actions are based on action types and can be declaratively parameterized, allowing for a rich set of dynamic functionality the controler can perform. A developer may even define her own action types, extending ADC effectively.

A main difference between ADC and Dynamic Actions is that an action is able to execute PL/SQL code within the database as well as collect JavaScript code to be performed on the application page in response to the dynamically raised event. Plus, if a code within the database changes the session state, ADC recursively calls the rule machine to evaluate the new session state against the defined use cases. Should another use case have to be executed, it will immediatley do so until no further session state change occurs. This way, a single round trip between the client and the database can perform multiple use cases.

Implementing the controller in PL/SQL has a number of further advantages:
-  it allows to utilize existing validation code
-  it supports PL/SQL based conditions
-  no second programming langauge is required
-  the code is implemented along with all other static processing or validation code, making it easier to control logic flow

ADC itself is implemented as a Dynamic Action Plugin. This is necessary as it needs to install a JavaScript component on the page and interact with it. Luckily, no parameterization is required to use ADC, it may even be installed once on page 0, making it available to all your APEX pages in one go. Even if you don't define any use case, the page already reacts differently when installing the plugin:
- Mandatory fields will be auto detected and validated dynamically. So if you leave a mandatory field with no content, an error will be shown immediately
- Number and date fields will be dynamically checked based on their format mask or the predefined default format mask of the application.

As you define use cases for a page, they get executed immediately. At most a reload of the APEX page is required to apply the newly defined use case. This makes it very easy to iteratively devlop use cases and test them.

## Components

ADC consits of different components which can be seperately installed.

### Plugin

The first component is the Dynamic Action Plugin that integrates ADC into the APEX cosmos. It consists of a package named `PLUGIN_ADC`, a plugin import file and some JavaScript files.

Whereas the package and the import file are standard APEX plugin components, it is necessary to understand the JavaScript files required for ADC. There are two JavaScript files, `sct.js` and `sctAPEX.js`. The first file implements the JavaScript counterpart of ADC on the page. This component is referenced by the plugin initialization code which tells the component to establish the required observers on the page. This component also reacts on events, collects the required event metadata and passes this as an AJAX request to the database package. In response to this request, the plugin renders the response and passes it back to the JavaScript component which in turn executes the JavaScript code contained in the response. This response may contain errors to be shown on the page as well as JavaScript instructions to chang the page state.

To change the page state, such as hiding a page item or disabling a button, code is required that might be specific to the APEX theme used or the APEX version in use. As an example, imagine an action that tells an Interactive Grid or an Interactive Report to hide the filter region. Based on the type of region and probably the theme and version, different JavaScript code may be required. To cater for this, `sct.js` only implements wrapper methods for the required activities on the page. The implementation is delegated to a namespace object that is implemented in `sctAPEX.js`. Which implementation is used is defined by a component setting for the ADC plugin. Here, you type in the namespace of the component that finally implements the required functionality. If you use the standard Universal Theme you may use this file and choose between namespace `de.condes.plugin.adc.apex_42_5_0` for theme 42, APEX version 5.0 or `de.condes.plugin.adc.apex_42_5_1` for theme 42, apex version 5.1 and later.
