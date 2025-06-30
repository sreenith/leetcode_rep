*&---------------------------------------------------------------------*
*& Report Z_LC_SORTED_SQUARE_ARRAY_ASCEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_sorted_square_array_ascen.
*⏱️ Time Complexity: O(n)
*- The array lt_values has n elements.
*- The main DO lv_len TIMES loop runs n times, and in each iteration, you're doing constant-time operations: comparison, squaring, appending → O(n)
*- The reverse step (WHILE index > 0) also runs once over n elements → another O(n)
*- Final LOOP AT lt_result for printing → O(n)
*✅ Total Time Complexity = O(n) + O(n) + O(n) = O(n)
*
*🧠 Space Complexity: O(n)
*- lt_final stores n squared values in descending order
*- lt_result stores the reversed version, again n values
*- Both are linear in size relative to input → O(n)
*There’s no extra recursion or nested loops, so your program maintains good space efficiency as well

TYPES: lty_i TYPE STANDARD TABLE OF i WITH EMPTY KEY .
DATA: lt_final  TYPE lty_i,
      lt_result TYPE lty_i.

DATA(lt_values) = VALUE lty_i( ( -6 ) ( -4 ) ( 0 ) ( 1 ) ( 2 ) ( 5 ) ( 7 ) ).

DATA(lv_len) = lines( lt_values ).
DATA(i) = 1.
DATA(j) = lv_len.

DO lv_len TIMES.
  DATA(lv_square) = 0.
  IF abs( lt_values[ i ] ) > abs( lt_values[ j ] ).
    lv_square = lt_values[ i ] * lt_values[ i ].
    i = i + 1.
  ELSE.
    lv_square = lt_values[ j ] * lt_values[ j ].
    j = j - 1.
  ENDIF.
  APPEND lv_square TO lt_final.
ENDDO.

" Now reverse the result to get ascending order
DATA(index) = lines( lt_final ).
WHILE index > 0.
  APPEND lt_final[ index ] TO lt_result.
  index = index - 1.
ENDWHILE.

LOOP AT lt_result INTO DATA(val).
  WRITE: / val.
ENDLOOP.
