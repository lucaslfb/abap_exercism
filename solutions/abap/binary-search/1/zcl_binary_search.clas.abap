CLASS zcl_binary_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS binary_search
      IMPORTING
        val           TYPE i
        table         TYPE integertab
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_sy_itab_line_not_found.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_binary_search IMPLEMENTATION.

  METHOD binary_search.
    DATA(lt_num) = table.
  
    SORT lt_num.

    READ TABLE lt_num TRANSPORTING NO FIELDS WITH KEY table_line = val BINARY SEARCH.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_sy_itab_line_not_found..
    ENDIF.
    
    result = sy-tabix.
  ENDMETHOD.
ENDCLASS.
