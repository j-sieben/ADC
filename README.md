# APEX Dynamic Controller (ADC)

## Motivation

ADC is an implementation proposal for a dynamic controller for APEX applications. It extends and partially replaces the more static controller functionality of APEX by supporting controler activities on the rendered page dynamically.

"Static" in this context means the stored calculations, validations, processes and branches offered by APEX-IDE within the scope of the normal request-response lifecycle. Server side conditions and authorization schemes are also part of the static controler functionality.

"Dynamic" on the other hand refers to anything that is processed while the page is shown to the user. The only declarative option available for this functionality has been Dynamic Actions so far. DA were meant as a declarative wrapper around JavaScript code on the page to enable the developer to declaratively define common tasks such as hiding or showing page items. Another focus is partial page refresh for regions which support it or select lists and the like. It was not meant to form a fully functional controler though.

As form pages become complex, this becomes a severe drawback. The amount of DAs on the page quickly raises beyond easily manageable numbers. The resulting page faces the same problems as the well known "trigger hell" in PL/SQL database programming.

Using Dynamic Actions as a replacement for a dynamic controller breaches the architectural pattern because it implements decision logic in the view layer and does not cleanly separate this code from the view. It also requires new page items to be created solely for the purpose of storing temporary values (hidden page items) to offer an anchor for further DAs to react on their changes. Implementing the dynamic controller in JavaScript on the other hand seems to be a bad choice as this code would be too far away from the data it requires to take decisions and calculate the necessary next steps. Moreover, declarative facilitation no longer exists, leaving the developer alone with APEX's internals.

To overcome this, a different approach has to be chosen. Following the Model-View-Control paradigm, a component must be created that architecturally cleanly implements control over the dynamic processes of the page as a complete controller. As most validations and even conditions that have to be evaluated in response to the activity of the user require access to the data stored within the database, it is best to implement the controller in PL/SQL. This is in contrast to the existing Dynamic Actions which are implemented as code generators for JavaScript code basically.

## How it works



## ADC Sample Application

ADC ships with a sample application that shows you step by step how to use ADC from installing the plugin on the page up to the use of page commands. From the respective example pages you can directly navigate to the settings in ADC required to achieve the tasks. This will help you to get started quickly.

It is meant as a showcase application only and expects ADC to be installed on the system. It also is not all to cleanly coded as it create database tables within the worspace schema directly. It is assumed that this is OK for a sample application to make it easier to install it.

## Installation

To install ADC, see the instructions [here](https://github.com/j-sieben/ADC/blob/main/DOC/Installation.md).
