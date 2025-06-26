*&---------------------------------------------------------------------*
*& Report Z_LC_PALINDROME_PERMUTATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_palindrome_permutation.


CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    TYPES: tt_array TYPE STANDARD TABLE OF c WITH DEFAULT KEY.
    DATA: mt_array   TYPE tt_array,
          mt_permute TYPE SORTED TABLE OF string WITH UNIQUE DEFAULT KEY.
    METHODS: string_to_array IMPORTING str             TYPE string
                             RETURNING VALUE(rt_array) TYPE tt_array,
      array_to_string    IMPORTING im_array      TYPE tt_array
                         RETURNING VALUE(rv_str) TYPE string,
      calc_permutations IMPORTING im_str TYPE string
                                  left   TYPE i
                                  right  TYPE i,
      check_palindrome IMPORTING im_str                  TYPE string
                       RETURNING VALUE(rv_is_palindrome) TYPE boolean,
      swap IMPORTING im_str        TYPE string
                     start_index   TYPE i
                     target_index  TYPE i
           RETURNING VALUE(rv_str) TYPE string.


ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD string_to_array.
    DATA: lv_index TYPE i.
    DATA: lt_str TYPE TABLE OF c.
    DATA: lv_length TYPE i.

    lv_length = strlen( str ).

    WHILE lv_index < strlen( str ).

      DATA(lv_char) = str+lv_index(1).
      APPEND lv_char TO lt_str.
      ADD 1 TO lv_index.
    ENDWHILE.

    rt_array = lt_str.
  ENDMETHOD.

  METHOD calc_permutations.

    IF left = right.
      IF check_palindrome( im_str ) IS NOT INITIAL.
        INSERT im_str INTO TABLE mt_permute.
      ENDIF.
    ELSE.
      DATA(i) = left.
      WHILE i <= right.

        DATA(lv_str) = swap( EXPORTING im_str       = im_str
                                       start_index  = left
                                       target_index = i ).
        DATA(lv_left) = left + 1.
        calc_permutations( EXPORTING im_str = lv_str
                                     left   = lv_left
                                     right  = right ).
        i =  i + 1.
      ENDWHILE.
    ENDIF.

  ENDMETHOD.

  METHOD check_palindrome.
    DATA: lv_reverse TYPE string.

    lv_reverse = reverse( im_str ).

    IF to_lower( im_str ) = to_lower( lv_reverse ).
      rv_is_palindrome = abap_true.
    ELSE.
      rv_is_palindrome = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD array_to_string.
    LOOP AT im_array INTO DATA(lv_char).
      rv_str = rv_str && lv_char.
    ENDLOOP.
  ENDMETHOD.

  METHOD swap.
    DATA: lv_temp TYPE c.
    DATA: lt_str TYPE TABLE OF c.

    lt_str = string_to_array( im_str ).
    lv_temp = lt_str[ start_index ].
    lt_str[ start_index ] = lt_str[ target_index ].
    lt_str[ target_index ] = lv_temp.

    rv_str = array_to_string( lt_str ).

  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA: lv_str TYPE string VALUE 'carerac'.
  DATA: lt_str TYPE TABLE OF c.
  DATA: lo_obj TYPE REF TO lcl_main.
  DATA: lv_last TYPE c.

  CREATE OBJECT lo_obj.

  lt_str = lo_obj->string_to_array( lv_str ).
  DATA(lv_len) = strlen( lv_str ).

  lo_obj->calc_permutations( EXPORTING im_str = lv_str
                                       left   = 1
                                       right  = lv_len ).

  BREAK-POINT.
