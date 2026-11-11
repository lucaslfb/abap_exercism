CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.
  METHOD value.
    DATA lv_resistor TYPE i.
  
    DATA(lt_colors) = VALUE string_table(
      ( `black` )
      ( `brown` )
      ( `red` )
      ( `orange` )
      ( `yellow` )
      ( `green` )
      ( `blue` )
      ( `violet` )
      ( `grey` )
      ( `white` )
    ).

    LOOP AT colors INTO DATA(lv_color) TO 2.
      DATA(lv_index) = sy-tabix.
      
      READ TABLE lt_colors TRANSPORTING NO FIELDS
        WITH KEY table_line = lv_color.
  
      IF sy-subrc = 0.
        IF lv_index = 1.
          lv_resistor = ( sy-tabix - 1 ) * 10.
        ELSE.
          lv_resistor = lv_resistor + sy-tabix - 1.
        ENDIF.
          
      ENDIF.

    ENDLOOP.

    result = lv_resistor.

  ENDMETHOD.
ENDCLASS.
