# APEX Dynamic Controller (ADC)

## Motivation

ADC is an implementation proposal for a dynamic controller for APEX applications. It extends and partially replaces the more static controller functionality of APEX by supporting controler activities on the rendered page dynamically.

"Static" in this context means the stored calculations, validations, processes and branches offered by APEX-IDE within the scope of the normal request-response lifecycle. Server side conditions and authorization schemes are also part of the static controler functionality.

"Dynamic" on the other hand refers to anything that is processed while the page is shown to the user. The only declarative option available for this functionality has been Dynamic Actions so far. DA were meant as a declarative wrapper around JavaScript code on the page to enable the developer to declaratively define common tasks such as hiding or showing page items. Another focus is partial page refresh for regions which support it or select lists and the like. It was not meant to form a fully functional controler though.

As form pages become complex, this becomes a severe drawback. The amount of DAs on the page quickly raises beyond easily manageable numbers. The resulting page faces the same problems as the well known "trigger hell" in PL/SQL database programming.

Using Dynamic Actions as a replacement for a dynamic controller breaches the architectural pattern because it implements decision logic in the view layer and does not cleanly separate this code from the view. It also requires new page items to be created solely for the purpose of storing temporary values (hidden page items) to offer an anchor for further DAs to react on their changes. Implementing the dynamic controller in JavaScript on the other hand seems to be a bad choice as this code would be too far away from the data it requires to take decisions and calculate the necessary next steps. Moreover, declarative facilitation no longer exists, leaving the developer alone with APEX's internals.

To overcome this, a different approach has to be chosen. Following the Model-View-Control paradigm, a component must be created that architecturally cleanly implements control over the dynamic processes of the page as a complete controller. As most validations and even conditions that have to be evaluated in response to the activity of the user require access to the data stored within the database, it is best to implement the controller in PL/SQL. This is in contrast to the existing Dynamic Actions which are implemented as code generators for JavaScript code basically.

## How it works

A dynamic controller has to react on user actions which boils down to reacting on JavaScript events. The APEX Dynamic Controller (ADC) solves this problem by instructing a static JavaScript component to register observers during page initialization to respond to relevant events. When such an event occurs, it responds by informing the ADC about the request. The request contains the current page item values of all "relevant" page items, but also the firing item, the event and other metadata. This is referred to as the "Page State" of the page. As it is clearly defined what the observer has to do when it detects an event (inform ADC about it), there is no need for application specific JavaScript functionality anymore. The JavaScript componente of ADC therefore is implemented once and simply used on the page.

The event along with its metadata is passed to a generic rule machine that decides on the next steps to take. An APEX page may define as many rules, called "Use Case" in ADC, as necessary. Each use case refers to one or many actions to perform when the use case is dtected by the rule machine. Those actions are based on action types and can be declaratively parameterized, allowing for a rich set of dynamic functionality the controler can perform. A developer may even define her own action types, extending ADC effectively.

A main difference between ADC and Dynamic Actions is that an action is able to execute PL/SQL code within the database as well as collect JavaScript code to be performed on the application page in response to the dynamically raised event and even to decide upon whether a use case is present or not. Plus, if a code within the database changes the session state, ADC recursively calls the rule machine to evaluate the new session state against the defined use cases. Should another use case have to be executed, it will immediatley do so until no further session state change occurs. This way, a single round trip between the client and the database can perform multiple use cases.

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

Whereas the package and the import file are standard APEX plugin components, it is necessary to understand the JavaScript files required for ADC. There are three JavaScript files, `adc/js/controller.js`, `adc/js/actions.js` and `adc/js/renderer.js`. 

#### Controller.js
This file implements the core logic of adc. It forms the counterpart that the database functionality responds to. Upon initialization, this file registers all necessary event handlers as requested by the database. If any of these observers fires, this component collects all necessary data and sends it to the database. In response the database will deliver a `script` element containing all necessary JavaScript code to perform the required dynamic activity. The controller incorporates this response into the html code, effectively executing the code.

#### Actions.js
This file implements the client side functionality of the ADC action types delivered with ADC. The implementation is split into two parts: The generic part that is performed within this file and the theme-aware part which is implemented in `adc/js/renderer.js`. As it is possible to register a different render component with ADC, it is possible to implement a different render functionality for different themes or theme versions.

#### Renderer.js
This file contains the theme specific funcionality to implement the dynamic behavior for a given theme in a given version. This separation allows to split the core functionality of an action type from its theme specific functionality, making it easy to adopt ADC to a changed APEX theme or a new theme version.

If you have changed or extended theme 42, the best option would be to make a copy of `adc/js/renderer.js` and define you own namespace object for this copy. You can then overwrite or extend the existing functionality. This approach is advisable also if you plan to extend ADC with your own action types. If the newly created action types require JavaScript functionality, you can easily add them here and reference them from the action type definition.

Which namespace to use for rendering purposes can be parameterized as a component setting of the ADC plugin. Here, you enter your newly created namespace.

### Core database objects

Several packages are installed to implement ADC. 

#### `ADC_INTERNAL`

Package `ADC_INTERNAL` implements the core functionality. There is no requirement for any other package to directly work with this package. Therefore, access is limited to ADC packages only.

#### `ADC_API`
Package `ADC_API` implements an API to access ADC programmatically. You normally don't have to work with this package. For convenience, there is a type called `ADC` that is used to work with ADC from your own code. Please see there for more information.

#### `ADC_ADMIN`

Package `ADC_ADMIN` is used to maintain the ADC metadata. It offers methods to create new metadata entries or to export existing metadata. This is normally used by the ADC application (see below) but may be used directly by batch scripts as well.

#### Types `ADC_BASIC` and `ADC`

These types form the PL/SQL API for your own projects. You exclusive want to use type `ADC` which inherits any functionality from `ADC_BASIC`. Reason for these types is that you may want to extend type `ADC` with your own action types without affecting the predelivered actions types. That way, it is save to install a new version of ADC with new or changed functionality. It will replace `ADC_BASIC` with a new version leaving your etended copy of `ADC`untouched.

The approach of using types as a package replacement may sound a bit unusual but it adds a feature unavailable in PL/SQL: Inheritance. By inheriting type ADC from ADC_BASIC, it is possible to separate two layers of functionality into one final database object. Had I chosen a package and you'd add an extensiion to it, you would be unable to simply replace this package with a newer version as you would loose all your extensions. Merging those packages would be a real mess. Using the type approach, this all disappears. Never touch ADC_BASIC, but add you extensions into ADC and you're prepared for all new releases.

### Tables and Views

ADC requires tables to store the metadata at. These tables are named using the prefix `ADC`. Also, it installs a sequence and some views. You don't have to work with these objects directly, so it is best to leave them unchanged. The data model supports several languages. It does so by referencing table `PIT_TRANSLATABLE_ITEM`. Therefore, it is not very easy to manually add data to the tables. Use the `ADC_ADMIN` methods instead if you want to manually enter data.

### ADC application

To offer the declarative functionality, ADC ships with an APEX application that allows to create and maintain use cases. This application should be your main enterance point for use cases as it supports you in putting together the use case and their respective actions best. The ADC application on the other hand is required on development environments only and should not be installed on test or production environments. It is not required to export or import use cases, as these are integrated into the normal APEX application export file or can be downloaded and installed using distinct SQL installation files.

## ADC Sample Application

ADC ships with a sample application that shows you step by step how to use ADC from installing the plugin on the page up to the use of page commands. From the respective example pages you can directly navigate to the settings in ADC required to achieve the tasks. This will help you to get started quickly.

It is meant as a showcase application only and expects ADC to be installed on the system. It also is not all to cleanly coded as it create database tables within the worspace schema directly. It is assumed that this is OK for a sample application to make it easier to install it.

## Installation

To install ADC, see the instructions [here](https://github.com/j-sieben/ADC/blob/main/DOC/Installation.md).
