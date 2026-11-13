CLASS zcl_protein_translation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS proteins
      IMPORTING
        strand        TYPE string
      RETURNING
        VALUE(result) TYPE string_table
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_protein_translation IMPLEMENTATION.
  METHOD proteins.
    TYPES:
      BEGIN OF ty_codons,
        codons     TYPE string_table,
        amino_acid TYPE string,
      END OF ty_codons.

    DATA lt_codons TYPE STANDARD TABLE OF ty_codons WITH EMPTY KEY.

    DATA(lv_offset) = 0.

    lt_codons = VALUE #(
      ( codons     = VALUE #( ( `AUG` ) )
        amino_acid = `Methionine` )
      ( codons     = VALUE #( ( `UUU` ) ( `UUC` ) )
        amino_acid = `Phenylalanine` )
      ( codons     = VALUE #( ( `UUA` ) ( `UUG` ) )
        amino_acid = `Leucine` )
      ( codons     = VALUE #( ( `UCU` ) ( `UCC` ) 
                              ( `UCA` ) ( `UCG` ) )
        amino_acid = `Serine` )
      ( codons     = VALUE #( ( `UAU` ) ( `UAC` ) )
        amino_acid = `Tyrosine` )
      ( codons     = VALUE #( ( `UGU` ) ( `UGC` ) )
        amino_acid = `Cysteine` )
      ( codons     = VALUE #( ( `UGG` ) )
        amino_acid = `Tryptophan` )
      ( codons     = VALUE #( ( `UAA` ) ( `UAG` )
                              ( `UGA` ) )
        amino_acid = `STOP` )
    ).

    DO STRLEN( strand ) / 3 TIMES.

      DATA(lv_codon) = substring(
        val = strand
        off = lv_offset
        len = 3 ).

      DATA(lv_found) = abap_false.

      LOOP AT lt_codons INTO DATA(ls_codon).
      
        READ TABLE ls_codon-codons TRANSPORTING NO FIELDS
          WITH KEY table_line = lv_codon.

        IF sy-subrc = 0.
          lv_found = abap_true.
          
          IF ls_codon-amino_acid = `STOP`.
            RETURN.

          ENDIF.
        
          APPEND ls_codon-amino_acid TO result.
          EXIT.

        ENDIF.

      ENDLOOP.

      IF lv_found = abap_false.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.

      lv_offset += 3.
      
    ENDDO.

    IF STRLEN( strand ) MOD 3 <> 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
  
      
  ENDMETHOD.
ENDCLASS.
