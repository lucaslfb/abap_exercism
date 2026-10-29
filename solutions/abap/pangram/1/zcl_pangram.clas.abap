CLASS zcl_pangram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS is_pangram
      IMPORTING
        VALUE(sentence) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_pangram IMPLEMENTATION.
  METHOD is_pangram.
    DATA(lv_sentence) = TO_UPPER( sentence ).

    DATA(lt_alphabet) = VALUE string_table(
      ( `A` )
      ( `B` )
      ( `C` )
      ( `D` )
      ( `E` )
      ( `F` )
      ( `G` )
      ( `H` )
      ( `I` )
      ( `J` )
      ( `K` )
      ( `L` )
      ( `M` )
      ( `N` )
      ( `O` )
      ( `P` )
      ( `Q` )
      ( `R` )
      ( `S` )
      ( `T` )
      ( `U` )
      ( `V` )
      ( `W` )
      ( `X` )
      ( `Y` )
      ( `Z` )
    ).

    result = ABAP_TRUE.

    LOOP AT lt_alphabet INTO DATA(lv_letter).
    
      IF NOT CONTAINS(
        VAL = lv_sentence
        SUB = lv_letter
      ).
      
        result = ABAP_FALSE.

        IF result = ABAP_FALSE.
          RETURN.
        ENDIF.
        
      ENDIF.
      
    ENDLOOP.

  ENDMETHOD.


ENDCLASS.
