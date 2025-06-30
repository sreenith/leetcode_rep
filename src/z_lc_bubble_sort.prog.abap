*&---------------------------------------------------------------------*
*& Report Z_LC_BUBBLE_SORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_bubble_sort.
*Time Complexity: O(n²)
*- The outer loop runs n times (DO lines TIMES).
*- The inner loop runs n-1 times (DO lines - 1 TIMES).
*- So in total: roughly n × (n - 1) comparisons → O(n²) time.
*There's no optimization for early exit if the array is already sorted, so it always runs the full set of iterations regardless of input order.
*
*🧠 Space Complexity: O(1)
*- You're sorting the array in-place, without allocating any new tables or significant structures.
*- The only extra variable is temp, a single i, which doesn't scale with input size.
*So: constant auxiliary space → O(1)
*
*If you're open to a gentle challenge—want to improve the code by skipping unnecessary iterations once the array is sorted? I’d be happy to help you implement the "early exit" optimization.


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
