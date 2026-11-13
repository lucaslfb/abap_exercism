CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA lv_erros TYPE i.
  
    IF STRLEN( first_strand ) <> STRLEN( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSE.
      DO STRLEN( first_strand ) TIMES.
        DATA(lv_offset)     = sy-index - 1.
        DATA(lv_first_dna)  = first_strand+lv_offset(1).
        DATA(lv_second_dna) = second_strand+lv_offset(1).

        IF lv_first_dna <> lv_second_dna.
          lv_erros += 1.
        ENDIF.
      ENDDO.
    ENDIF.
    result = lv_erros.
  ENDMETHOD.

ENDCLASS.
