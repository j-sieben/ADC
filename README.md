# APEX Dynamic Controller (ADC)

## Motivation

ADC is an implementation proposal for a dynamic controller for APEX applications. It extends and partially replaces the more static controller functionality of APEX by supporting controler activities on the rendered page dynamically.

"Static" in this context means the stored calculations, validations, processes and branches offered by APEX-IDE within the scope of the normal request-response lifecycle. Server side conditions and authorization schemes are also part of the static controler functionality.

"Dynamic" on the other hand refers to anything that is processed while the page is shown to the user. The only declarative option available for this functionality has been Dynamic Actions so far. DA were meant as a declarative wrapper around JavaScript code on the page to enable the developer to declaratively define common tasks such as hiding or showing page items. Another focus is partial page refresh for regions which support it or select lists and the like. It was not meant to form a fully functional controler though.

As form pages become complex, this becomes a severe drawback. The amount of DAs on the page quickly raises beyond easily manageable numbers. The resulting page faces the same problems as the well known "trigger hell" in PL/SQL database programming.

Using Dynamic Actions as a replacement for a dynamic controller breaches the architectural pattern because it implements decision logic in the view layer and does not cleanly separate this code from the view. It also requires new page items to be created solely for the purpose of storing temporary values (hidden page items) to offer an anchor for further DAs to react on their changes. Implementing the dynamic controller in JavaScript on the other hand seems to be a bad choice as this code would be too far away from the data it requires to take decisions and calculate the necessary next steps. Moreover, declarative facilitation no longer exists, leaving the developer alone with APEX's internals.

To overcome this, a different approach has to be chosen. Following the Model-View-Control paradigm, a component must be created that architecturally cleanly implements control over the dynamic processes of the page as a complete controller. As most validations and even conditions that have to be evaluated in response to the activity of the user require access to the data stored within the database, it is best to implement the controller in PL/SQL. This is in contrast to the existing Dynamic Actions which are implemented as code generators for JavaScript code basically.

## How it works

ADC is implemented as a Dynamic Action Plugin. It can be installed on page 0 if you want to utilize it on every AEPX page. As usual, you can limit the usage by adding a server side condition. As an alternative, you can install the plugin on any page you want to upgrade it with.

Once the page with ADC is run, it detects that no use cases are defined for that page. It then creates a new emtpy set of use cases, also called rules in ADC. The idea is to create new use cases as you need them. As soon as you created a new use case, it will work immediately after the page is reloaded. Use cases are defined in a separate APEX applciation that ships with ADC. It allows to create use cases for any application in your workspace that has ADC implemented.

A use case follows a very simple principle: If the user does XYZ, ADC should do ABC. A basic use case could be like this: "If the user selects a job that is commission eligible, make page item `P1_COMMISSION_PCT` a mandatory field.". In ADC, you split this use case up into three parts:

- A free text description of the use case: (If the user) selects a job that is commission eligible
- A technical term that allows the database to recognize the action the user has taken. Say, you have a function that checks wether a job is commission eligible which returns `1` if this is the case and `0` otherwise, the technical condition could be written as: `my_pkg.check_job_is_comm_eligible(P1_JOB_ID) = 1`.
Notice that a PL/SQL function may be used directly and that `P1_JOB_ID` does not require apostrophes. This is because the code is evaluated within the database where PL/SQL is available and that the page state is offered as a column value of the same name. Should this function return `1`, this use case can be executed.
- A list of actions to take. In the ADC application, defining the actions to take is very similar to defining actions in a Dynamic Action: You choose the desired action (or as many as you like) from a list of predefined action types and parameterize it. This way, the whole process remains declarative with only minimal complexity.

The term Page State is used here in distinction to the term Session State that is known from APEX. It differs in that it contains information about the actual event that occurred and by the fact that the page item values it contains are taken from the actual page. The session state on the other hand is maintained automatically by APEX during the response phase but not dynamically, unless you tell APEX to take the actual values with it when performing a Dynamic Action or a partial page refresh. ADC takes away the burdon of defining this explicitly. It "knows" which page items are relevant for the evaluation of the use cases and takes their respective value with it. Also, the page state contains this information in the correct format, so a date field is of type `DATE` and a number field is of type `NUMBER`.

As a side effect of this, ADC automatically checks conversion errors and reports them as errors on the page without further ado. Also, all mandatory items are dynamically checked after their value has changed. So checking these is done automatically and does not require any programming.

# ADC Sample Application

ADC ships with a sample application that shows you step by step how to use ADC from installing the plugin on the page up to the use of page commands. From the respective example pages you can directly navigate to the settings in ADC required to achieve the tasks. This will help you to get started quickly.

It is meant as a showcase application only and expects ADC to be installed on the system. It also is not all to cleanly coded as it create database tables within the worspace schema directly. It is assumed that this is OK for a sample application to make it easier to install it.

## Installation

To install ADC, see the instructions [here](https://github.com/j-sieben/ADC/blob/main/DOC/Installation.md).
