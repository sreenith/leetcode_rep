*&---------------------------------------------------------------------*
*& Report Z_LC_RUNNING_SUM_1D_ARRAY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_running_sum_1d_array.

TYPES: lty_i TYPE STANDARD TABLE OF i WITH EMPTY KEY .


DATA(lt_values) = VALUE lty_i( ( 2 ) ( 1 ) ( 3 ) ( 6 ) ( 9 ) ( 5 ) ) .

DATA: sum TYPE i.

LOOP AT lt_values ASSIGNING FIELD-SYMBOL(<fs_data>).

  sum = sum + <fs_data>.

  <fs_data> = sum.

  WRITE: / <fs_data>.

ENDLOOP.
