*&---------------------------------------------------------------------*
*& Report Z_LC_POWER_OF_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_power_of_2.

DATA: num TYPE i VALUE 1.

PARAMETERS: p_input TYPE i.


WHILE p_input > num .


  num = num * 2.


ENDWHILE.

IF p_input  = num.

  WRITE: / 'Power of two'.
ELSE.
  WRITE: / 'Not a Power of two'.
ENDIF.
