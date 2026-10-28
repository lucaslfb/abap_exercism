CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
  
    LOOP AT initial_numbers INTO DATA(ls_initial)
      GROUP BY ( group = ls_initial-group ) INTO DATA(ls_key).

      DATA(ls_result) = VALUE aggregated_data_type(
        group = ls_key-group
      ).

      LOOP AT GROUP ls_key INTO DATA(ls_member).

        IF ls_result-count = 0.
          ls_result-min = ls_member-number.
          ls_result-max = ls_member-number.
        ENDIF.

        ls_result-count = ls_result-count + 1. 
        ls_result-sum   = ls_result-sum   + ls_member-number.

        IF ls_member-number < ls_result-min.
          ls_result-min = ls_member-number.
        ENDIF.

        IF ls_member-number > ls_result-max.
          ls_result-max = ls_member-number.
        ENDIF.
      ENDLOOP.

      ls_result-average = CONV f(ls_result-sum) / ls_result-count.

      APPEND ls_result TO aggregated_data.
      
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
