*&---------------------------------------------------------------------*
*& Report Z_LC_TWO_SUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_two_sum.
*Two sum works for Unsorted and Sorted arrays without any explicit sort

TYPES: BEGIN OF ty_hash,
         key TYPE i,
       END OF ty_hash.


DATA: gt_values TYPE STANDARD TABLE OF i,
      gs_values TYPE i,
      gt_hash   TYPE HASHED TABLE OF ty_hash WITH UNIQUE KEY key,
      gs_hash   TYPE ty_hash.


DATA(target) = 9.

*gt_values = VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ( 6 ) ).
gt_values = VALUE #( ( 3 ) ( 6 ) ( 1 ) ( 4 ) ( 5 ) ( 2 ) ).

LOOP AT gt_values INTO gs_values.

  DATA(complement) = target - gs_values.

  READ TABLE gt_hash INTO gs_hash WITH KEY  key = complement .

  IF sy-subrc NE 0.

    gs_hash-key = gs_values.

    INSERT gs_hash INTO TABLE gt_hash.
  ELSE.

    WRITE:/ gs_values , gs_hash-key.

  ENDIF.


ENDLOOP.
