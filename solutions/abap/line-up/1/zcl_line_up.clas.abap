CLASS zcl_line_up DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS format IMPORTING name          TYPE string
                             number        TYPE i
                   RETURNING VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_line_up IMPLEMENTATION.
  METHOD format.
    DATA lv_ord_number TYPE STRING.

    IF number MOD 10 = 1 and number MOD 100 <> 11.
      lv_ord_number = |{ number }st|.
    ELSEIF number MOD 10 = 2 and number MOD 100 <> 12.
      lv_ord_number = |{ number }nd|.
    ELSEIF number MOD 10 = 3 and number MOD 100 <> 13.
      lv_ord_number = |{ number }rd|.
    ELSE.
      lv_ord_number = |{ number }th|.
    ENDIF.

    result = |{ name }, you are the { lv_ord_number } customer we serve today. Thank you!|.
  ENDMETHOD.
ENDCLASS.
