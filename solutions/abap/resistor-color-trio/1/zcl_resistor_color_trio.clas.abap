CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.
  METHOD label.
    DATA lv_resistor TYPE i.
    DATA(lt_colors) = VALUE string_table(
      (`black`)
      (`brown`)
      (`red`)
      (`orange`)
      (`yellow`)
      (`green`)
      (`blue`)
      (`violet`)
      (`grey`)
      (`white`)
    ).

    LOOP AT colors INTO DATA(lv_color) TO 3.
      DATA(lv_index) = sy-tabix.

      READ TABLE lt_colors TRANSPORTING NO FIELDS
        WITH KEY table_line = lv_color.

      IF sy-subrc = 0.
        IF lv_index = 1 AND LINES( colors ) > 1.
          lv_resistor = ( sy-tabix - 1 ) * 10.
        ELSEIF lv_index = 3.
          lv_resistor = lv_resistor * ( 10 ** ( sy-tabix - 1 ) ).
        ELSE.
          lv_resistor = lv_resistor + sy-tabix - 1.
        ENDIF.
        
      ENDIF.
      
    ENDLOOP.

    IF lv_resistor >= 1000000000.
      result = |{ ( lv_resistor / 1000000000 ) } gigaohms|.
    ELSEIF lv_resistor >= 1000000.
      result = |{ ( lv_resistor / 1000000 ) } megaohms|.
    ELSEIF lv_resistor >= 1000.
      result = |{ ( lv_resistor / 1000 ) } kiloohms|.
    ELSE.
      result = |{ lv_resistor } ohms|.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
