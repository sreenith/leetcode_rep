*&---------------------------------------------------------------------*
*& Report Z_LC_MERGE_SORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_merge_sort.
*Divide and conquer approach is used in the merge sort array.
*By finding the midpoint of the array or the input we separate the array/input into two separate sub arrays.
* Taking the left sub array we call the same sub routine recursively , Take the right sub array we do the same, call the sub routine recursively.
*Finally at the end, Merge both the left and right sub arrays in to the final array by comparing both left and right sub arrays.
*Merge sort takes O(nlogn) time complexity, which is usually best kind of algorithm or one of the best kinds of algoirthm apart from the quick sort .


TYPES: lty_left TYPE STANDARD TABLE OF i WITH EMPTY KEY,
       lty_form TYPE STANDARD TABLE OF i.


DATA: ls_array TYPE i,
      ls_left  TYPE i,
      ls_right TYPE i.


DATA(lt_array) = VALUE lty_left( ( 3 ) ( 2 ) ( 7 ) ( 6 ) ( 1 ) ( 5 ) ).

PERFORM mergesort TABLES lt_array[].

LOOP AT lt_array INTO ls_array.

  WRITE: / ls_array.

ENDLOOP.
*&---------------------------------------------------------------------*
*& Form mergesort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LT_ARRAY
*&---------------------------------------------------------------------*
FORM mergesort  TABLES  lt_array TYPE STANDARD TABLE .



  DATA: lt_left  TYPE STANDARD TABLE OF i,
        lt_right TYPE STANDARD TABLE OF i.

  DATA(len_array) = lines( lt_array ).

  CHECK len_array > 1.

  DATA(mid_array) = len_array DIV 2.

  IF lt_array[] IS NOT INITIAL.

    INSERT LINES OF lt_array FROM 1 TO mid_array INTO TABLE lt_left.
    INSERT LINES OF lt_array FROM mid_array + 1 INTO TABLE lt_right.

  ENDIF.



  PERFORM mergesort TABLES lt_left.
  PERFORM mergesort TABLES lt_right.

  PERFORM merge TABLES lt_left lt_right lt_array.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form merge
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LT_LEFT
*&      --> LT_RIGHT
*&      --> LT_ARRAY
*&---------------------------------------------------------------------*
FORM merge  TABLES   lt_left TYPE lty_form
                     lt_right TYPE lty_form
                     lt_array TYPE lty_form.


  DATA:i TYPE i VALUE 1,
       j TYPE i VALUE 1,
       k TYPE i VALUE 1.

  DATA(ll) = lines( lt_left ).
  DATA(lr) = lines( lt_right ).

  WHILE ( i <= ll AND j <= lr ).


    IF lt_left[ i ] >= lt_right[ j ].

      lt_array[ k ] = lt_right[ j ].
      j = j + 1.
    ELSE.
      lt_array[ k ] = lt_left[ i ].
      i = i + 1.
    ENDIF.

    k = k + 1.

  ENDWHILE.


  LOOP AT lt_left INTO DATA(ls_left) FROM i.
    lt_array[ k ] = ls_left.

    k = k + 1.

  ENDLOOP.

  LOOP AT lt_right INTO DATA(ls_right) FROM j.
    lt_array[ k ] = ls_right.

    k = k + 1.

  ENDLOOP.

  CLEAR k.

ENDFORM.
