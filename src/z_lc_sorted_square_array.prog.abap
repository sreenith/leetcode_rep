*&---------------------------------------------------------------------*
*& Report Z_LC_SORTED_SQUARE_ARRAY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_sorted_square_array.

*Given an array of integers A sorted in non-decreasing order, return an array of the squares of each number, also in sorted non-decreasing order.

*Example 1:
*Input: [-4,-1,0,3,10]
*Output: [0,1,9,16,100]

*Example 2:
*Input: [-7,-3,2,3,11]
*Output: [4,9,9,49,121]

*Approach:
*Two pointers will be used from the end of the array and beginning of the array.
*Compare the absolute value of the negative value with the positive value from the end of the array.
*Whichever is greater would be placed in a final array after multiplying with its own number (for squaring it)
*Incrementing the starting index  or Decrementing the index from the end  based on which value has been taken for inserting in to the final array


TYPES: lty_i TYPE STANDARD TABLE OF i WITH EMPTY KEY .
DATA: lt_final TYPE lty_i.

DATA(lt_values) = VALUE lty_i( ( -6 ) ( -4 ) ( 0 ) ( 1 ) ( 2 ) ( 5 ) ( 7 ) ) .

DATA(lv_len) = lines( lt_values ).

DATA(i) = 1.
DATA(j) = lv_len.

DO lv_len TIMES.

  DATA(k)  = sy-index.

  IF abs( lt_values[ i ] ) >= lt_values[ j ].

    APPEND lt_values[ i ] TO lt_final.
    i = i + 1.
  ELSE.
    APPEND lt_values[ j ] TO lt_final.

    j = j - 1.

  ENDIF.

  lt_final[ k ] = lt_final[ k ] * lt_final[ k ].

  WRITE: / lt_final[ k ] .

ENDDO.
