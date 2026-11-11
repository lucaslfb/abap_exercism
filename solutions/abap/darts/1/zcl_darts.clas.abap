CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_darts IMPLEMENTATION.
  METHOD score.
    DATA(lv_r) = ( x ** 2 ) + ( y ** 2 ).

    IF lv_r <= 1 .
      result = 10.
    ELSEIF lv_r <= 5 ** 2.
      result = 5.
    ELSEIF lv_r <= 10 ** 2.
      result = 1.
    ELSE.
      result = 0.
    ENDIF.
    
  ENDMETHOD.


ENDCLASS.
