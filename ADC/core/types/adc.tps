whenever sqlerror continue

create type adc under adc_basic(

  /**
    Type: ADC
      This type inherits from ADC_BASIC, exposing the system delivered action types
      via this type. It is meant as an empty hull for your custom action types you
      want to make available through PL/SQL.
      
      If you update ADC with a new version, type ADC_BASIC will be replaced, but this
      type not. So it even remains if ADC is deinstalled. This is by design in order
      to protect your custom extensions.

    Author::
      Juergen Sieben, ConDeS GmbH
   */
);
/

whenever sqlerror exit