CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    CONSTANTS:
      c_minutes_per_hour TYPE i VALUE 60,
      c_minutes_per_day  TYPE i VALUE 1440.
    DATA mv_clock_state  TYPE i.
        
ENDCLASS.


CLASS zcl_clock IMPLEMENTATION.

  METHOD add.
    me->mv_clock_state =
      ( me->mv_clock_state + minutes ) MOD c_minutes_per_day.
  ENDMETHOD.

  METHOD constructor.
    me->mv_clock_state =
      ( ( hours * c_minutes_per_hour ) + minutes )
      MOD c_minutes_per_day.
  ENDMETHOD.

  METHOD get.
    DATA: lv_hour   TYPE n LENGTH 2,
          lv_minute TYPE n LENGTH 2.
    
    lv_hour   = me->mv_clock_state DIV c_minutes_per_hour.
    lv_minute = me->mv_clock_state MOD c_minutes_per_hour.
    result    = |{ lv_hour }:{ lv_minute }|.
  ENDMETHOD.

  METHOD sub.
    me->mv_clock_state = 
      ( me->mv_clock_state - minutes ) MOD c_minutes_per_day.
  ENDMETHOD.
  
ENDCLASS.
