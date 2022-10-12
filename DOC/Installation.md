# Installation

ADC is planned to be installed into the APEX workspace schema directly, as all dependencies are to APEX only. It can be installed either completely or in a runtime only manner. If you install the runtime version, no ADC administration application is installed.

## Prerequisites
Installation of ADC requires some prerequisites to be met. Make sure that all prerequisites are met before installing ADC. You may want to check those in the given order in this document.

### PIT

ADC is based on PIT. You can get a copy of PIT [here](https://github.com/j-sieben/PIT). To install PIT, you can either install it directly into the APEX workspace schema or in a different utilities schema. Depending on this decision, it is either sufficient to just run `install.bat/sh` or to run this script and afterwards run install_client.bat/sh for each schema you want to have access to PIT. As a minimum, run this script for your APEX Workspace schema.

Please make a decision on the datatype for boolean flags you want to use. As per default, this will be `char (1 byte)` with the values `Y|N`. You may change that in file `PIT/PIT/init/settings.sql`. Just apply these settings according to your taste, they will be passed to all other utilities.

### UTL_TEXT

ADC makes heavy use of the code generator inside UTL_TEXT. You can get a copy of UTL_TEXT [here](https://github.com/j-sieben/UTL_TEXT). To install UTL_TEXT, you can either install it directly into the APEX workspace schema or in a different utilities schema. Depending on this decision, it is either sufficient to just run `install.bat/sh` or to run this script and afterwards run install_client.bat/sh for each schema you want to have access to UTL_TEXT. As a minimum, run this script for your APEX Workspace schema.

### UTL_APEX

UTL_APEX is a collection of common APEX utilities I utilize in my projects. You can get a copy of UTL_APEX [here](https://github.com/j-sieben/UTL_APEX). As it is an APEX only utility, it is installed into the APEX Workspace schema directly, just as ADC.

## Full Installation of ADC

If you have installed the required utilities, installing ADC is a simple as calling `install.bat/sh`. If you run this script, all necessary database objects and an ADC administration application are installed into the workspace you specify. If you ran this script, you're good to go.

## Runtime Only Installation of ADC

In a production environment, there is no need for an administrative ADC application. Therefore it is advised to run `install_runtime.bat/sh` on those machines. It will not install the APEX application and its supporting database objects.

Any rules you create will be exported and imported using a built in scripting mechanism. So you create the business rules on the development machine, export them using the ADC application and run the resulting scripts on the production machine after having installed the target APEX application.

## Installing the ADC sample application

To install the sample application, simply run the `install_sample.bat/sh` script.

## Removing ADC

To uninstall ADC, simply call the `uninstall.bat` script.
