CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.

  DATA(lv_length) = STRLEN( input ).
  DATA lv_value TYPE I.
  
  TYPES: BEGIN OF ty_alphabet,
          letters TYPE STRING,
          value   TYPE I,
         END OF ty_alphabet.

  DATA lt_alphabet TYPE TABLE OF ty_alphabet.

  lt_alphabet = VALUE #(
    ( letters = 'AEIOULNRST' value = 1 )
    ( letters = 'DG'         value = 2 )
    ( letters = 'BCMP'       value = 3 )
    ( letters = 'FHVWY'      value = 4 )
    ( letters = 'K'          value = 5 )
    ( letters = 'JX'         value = 8 )
    ( letters = 'QZ'         value = 10 )
  ).
  
    DO lv_length TIMES.
      DATA(lv_offset) = sy-index - 1.
      DATA(lv_letter) = input+lv_offset(1).
      
      LOOP AT lt_alphabet INTO DATA(ls_alphabet).

        IF ls_alphabet-letters CS TO_UPPER( lv_letter ).
          lv_value = lv_value + ls_alphabet-value.
          EXIT.
        ENDIF.
        
      ENDLOOP.
      
    ENDDO.

    result = lv_value.
  ENDMETHOD.

ENDCLASS.
