CLASS zcl_space_age DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES age_in_years TYPE p LENGTH 3 DECIMALS 2.
    METHODS age
      IMPORTING
        planet        TYPE string
        seconds       TYPE i
      RETURNING
        VALUE(result) TYPE age_in_years
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_space_age IMPLEMENTATION.
  METHOD age.
    DATA lv_orbital_per TYPE DECFLOAT34.
    DATA lv_earth_sec   TYPE DECFLOAT34 VALUE '31557600'.
  
    CASE planet.
      WHEN 'Mercury'.
        lv_orbital_per = '0.2408467'.
      WHEN 'Venus'.
        lv_orbital_per = '0.61519726'.
      WHEN 'Earth'.
        lv_orbital_per = '1.0'.
      WHEN 'Mars'.
        lv_orbital_per = '1.8808158'.
      WHEN 'Jupiter'.
        lv_orbital_per = '11.862615'.
      WHEN 'Saturn'.
        lv_orbital_per = '29.447498'.
      WHEN 'Uranus'.
        lv_orbital_per = '84.016846'.
      WHEN 'Neptune'.
        lv_orbital_per = '164.79132'.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDCASE.

    DATA(lv_period_calc) = ( seconds / ( lv_earth_sec * lv_orbital_per ) ).

    result = lv_period_calc.
    
  ENDMETHOD.


ENDCLASS.
