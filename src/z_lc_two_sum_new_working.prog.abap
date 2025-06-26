*&---------------------------------------------------------------------*
*& Report Z_LC_TWO_SUM_NEW_WORKING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_two_sum_new_working.

*Time Complexity : O(Nlogn)
*Space complexity: O(1).

TYPES ty_array TYPE STANDARD TABLE OF i WITH EMPTY KEY.
CLASS lcl_two_sum DEFINITION.
  PUBLIC SECTION.
    METHODS: m_brute_force IMPORTING array TYPE ty_array target TYPE i RETURNING VALUE(x) TYPE ty_array.
    METHODS: m_two_pointer IMPORTING target TYPE i CHANGING array TYPE ty_array  RETURNING VALUE(x) TYPE ty_array.
ENDCLASS.

START-OF-SELECTION.
  DATA(lv_ref) = NEW lcl_two_sum( ).
  DATA(a) = VALUE ty_array( ( 2 ) ( 7 ) ( 11 ) ( 15 ) ).
  IF lv_ref IS NOT INITIAL.
*    DATA(indexs) = lv_ref->m_brute_force( EXPORTING array = a target = 9 ).
    DATA(indexs) = lv_ref->m_two_pointer(
      EXPORTING
        target = 9
      CHANGING
        array  = a
    ).


    WRITE : / indexs[ 1 ] , indexs[ 2 ].
  ENDIF.

CLASS lcl_two_sum IMPLEMENTATION.
  METHOD m_two_pointer.
    SORT array BY table_line.
    DATA(low) = 1.
    DATA(high) = lines( array ).
    WHILE low LT high.
      IF array[ low ] + array[ high ] GT target.
        high = high - 1.
      ELSEIF array[ low ] + array[ high ] LT target.
        low = low + 1.
      ELSE.
        APPEND low TO x.
        APPEND high TO x.
        RETURN.
      ENDIF.
    ENDWHILE.
    APPEND 0 TO x.
  ENDMETHOD.
  METHOD m_brute_force.
    DATA(i) = 1.
    WHILE i LE lines( array ).
      DATA(j) = i + 1.
      WHILE j LE lines( array ).
        IF array[ i ] + array[ j ] EQ target.
          APPEND i TO x.
          APPEND j TO x.
          RETURN.
        ENDIF.
        j = j + 1.
      ENDWHILE.
      i = i + 1.
    ENDWHILE.
    i = 0.
    APPEND  i TO x.
  ENDMETHOD.
ENDCLASS.
