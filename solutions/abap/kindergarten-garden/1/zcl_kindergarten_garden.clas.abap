CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.

    DATA lv_offset TYPE i.
    DATA lv_letra  TYPE c LENGTH 1.
    
    SPLIT diagram AT '\n'
      INTO TABLE DATA(lt_rows).

    lv_offset = FIND(
      VAL = sy-abcde
      SUB = student(1)
    ) * 2.
    
    LOOP AT lt_rows INTO DATA(lv_row).
      DO 2 TIMES.
        lv_letra = lv_row+lv_offset(1).

        CASE lv_letra.
          WHEN 'G'. APPEND `grass`    TO results.
          WHEN 'C'. APPEND `clover`   TO results.
          WHEN 'R'. APPEND `radishes` TO results.
          WHEN 'V'. APPEND `violets`  TO results.
        ENDCASE.

        lv_offset = lv_offset + 1.
      ENDDO.

      lv_offset = lv_offset - 2.
    ENDLOOP.
    
  ENDMETHOD.

ENDCLASS.
