*&---------------------------------------------------------------------*
*& Report Z_LC_BUBBLE_SORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_bubble_sort.


TYPES: tt_input TYPE STANDARD TABLE OF i WITH EMPTY KEY .

DATA: lt_input TYPE tt_input.

lt_input = VALUE #( ( 2 ) ( 6 ) ( 4 ) ( 1 ) ( 7 ) ) .


DATA(lines) = lines( lt_input ).


DO lines TIMES.
  DO lines - 1  TIMES.

    IF lt_input[ sy-index ] > lt_input[ sy-index + 1 ] .

      DATA(temp) = lt_input[ sy-index ].
      lt_input[ sy-index ] = lt_input[ sy-index + 1 ].
      lt_input[ sy-index + 1 ] = temp.

    ENDIF.

  ENDDO.
ENDDO.


LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<lfs_input>).
  WRITE: / <lfs_input>.
ENDLOOP.
