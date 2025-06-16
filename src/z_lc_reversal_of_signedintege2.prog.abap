*&---------------------------------------------------------------------*
*& Report Z_LC_REVERSAL_OF_SIGNEDINTEGE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_reversal_of_signedintege2.

DATA: lv_upperbound TYPE i VALUE 2147483647, "edge case max
      lv_lowerbound TYPE i VALUE -2147483648. "edge case min
DATA: lv_last    TYPE i,
      lv_reverse TYPE i.

PARAMETERS: p_input TYPE i.


WHILE p_input > 0.

  lv_last = p_input MOD 10.

  IF lv_reverse > lv_upperbound / 10  OR ( lv_reverse =  lv_upperbound / 10 AND  lv_last > 7 ) .
    WRITE : / 'reverse is greater than upper bound of integer '.
    EXIT.
  ENDIF.

  IF lv_reverse < lv_lowerbound / 10  OR ( lv_reverse =  lv_lowerbound / 10 AND  lv_last < -8 ) .
    WRITE : / 'reverse is greater than lower bound of integer '.
    EXIT.
  ENDIF.

  lv_reverse = lv_reverse * 10 + p_input MOD 10.
  p_input =  p_input DIV 10.

ENDWHILE.

WRITE: lv_reverse.
