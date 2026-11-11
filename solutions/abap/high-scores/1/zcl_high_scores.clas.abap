CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD latest.
    result = scores_list[ lines( scores_list ) ].
  ENDMETHOD.

  METHOD personalbest.
    result = REDUCE i(
      INIT max = 0
      FOR  score IN scores_list
      NEXT max = nmax( val1 = max val2 = score )
    ).
  ENDMETHOD.

  METHOD personaltopthree.
    DATA(lt_scores_list) = scores_list.
    
    SORT lt_scores_list DESCENDING.
    
    LOOP AT lt_scores_list INTO DATA(lv_score) TO 3.
      APPEND lv_score TO result.
    ENDLOOP.
    
  ENDMETHOD.


ENDCLASS.
