CLASS zcl_nucleotide_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF count_by_nucleotide,
        nucleotide TYPE c LENGTH 1,
        count      TYPE i,
      END OF count_by_nucleotide,
      ty_nucleotide_counts TYPE STANDARD TABLE OF count_by_nucleotide WITH KEY nucleotide.
    METHODS nucleotide_counts
      IMPORTING
        strand        TYPE string
      RETURNING
        VALUE(result) TYPE ty_nucleotide_counts
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_nucleotide_count IMPLEMENTATION.
  METHOD nucleotide_counts.

    IF to_upper( strand ) CN 'ACGT'.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    
    DATA(lv_qtd_a) = count( val = to_upper( strand ) sub = 'A' ).
    DATA(lv_qtd_c) = count( val = to_upper( strand ) sub = 'C' ).
    DATA(lv_qtd_g) = count( val = to_upper( strand ) sub = 'G' ).
    DATA(lv_qtd_t) = count( val = to_upper( strand ) sub = 'T' ).
    
    result = VALUE #(
      ( nucleotide = 'A' count = lv_qtd_a )
      ( nucleotide = 'C' count = lv_qtd_c )
      ( nucleotide = 'G' count = lv_qtd_g )
      ( nucleotide = 'T' count = lv_qtd_t )
    ).
    
  ENDMETHOD.


ENDCLASS.
