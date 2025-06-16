*&---------------------------------------------------------------------*
*& Report Z_LC_REVERSAL_OF_SIGNEDINTEGER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_reversal_of_signedinteger.
*--------------------------------------------------------------------*
*Better code available in program Z_LC_REVERSAL_OF_SIGNEDINTEGE2
*--------------------------------------------------------------------*

PARAMETERS : p_int TYPE i. " Input integer to be reversed

DATA: lv_upperbound TYPE i VALUE 2147483647, "edge case max
      lv_lowerbound TYPE i VALUE -2147483648." edge case min

DATA: lv_last    TYPE i,
      lv_reverse TYPE i.

WHILE p_int > 0.

  lv_last = p_int MOD 10.

  IF lv_reverse > lv_upperbound / 10  OR ( lv_reverse =  lv_upperbound / 10 AND  lv_last > 7 ) .

    WRITE : / 'reverse is greater than upper bound of integer '.

    EXIT.
  ENDIF.

  IF lv_reverse < lv_lowerbound / 10  OR ( lv_reverse =  lv_lowerbound / 10 AND  lv_last < -8 ) .

    WRITE : / 'reverse is greater than lower bound of integer '.

    EXIT.
  ENDIF.

  lv_reverse = lv_reverse * 10 + lv_last .

  DATA: lv_dec  TYPE p DECIMALS 2,
        lv_char TYPE string,
        lv_intd TYPE string.

  lv_dec = p_int / 10. " division can result in automatic decimal conversion like in 123456/ 10 converted to 12346
*So use split to remove the decimal
  lv_char = lv_dec.
  SPLIT lv_char AT '.' INTO lv_char lv_intd.

  p_int = lv_char.

ENDWHILE.

WRITE : lv_reverse. " output for reversed integer
