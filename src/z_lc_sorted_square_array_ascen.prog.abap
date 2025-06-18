*&---------------------------------------------------------------------*
*& Report Z_LC_SORTED_SQUARE_ARRAY_ASCEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_sorted_square_array_ascen.

*TYPES: lty_i TYPE STANDARD TABLE OF  i WITH EMPTY KEY  .
*DATA: lt_final TYPE lty_i.
*
*DATA(lt_values) = VALUE lty_i( ( -6 ) ( -4 ) ( 0 ) ( 1 ) ( 2 ) ( 5 ) ( 7 ) ) .
*
*DATA(lv_len) = lines( lt_values ).
*
*DATA(i) = 1.
*DATA(j) = lv_len.
*
*DO lv_len TIMES.
*
*  DATA(k)  = sy-index.
*
*  IF abs( lt_values[ i ] ) >= lt_values[ j ].
*
*    APPEND lt_values[ i ] TO lt_final.
*    i = i + 1.
*  ELSE.
*    APPEND lt_values[ j ] TO lt_final.
*
*    j = j - 1.
*
*  ENDIF.
*
*  lt_final[ k ] = lt_final[ k ] * lt_final[ k ].
*
*  WRITE: / lt_final[ k ] .
*
*ENDDO.
