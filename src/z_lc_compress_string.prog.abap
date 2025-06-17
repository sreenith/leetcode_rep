*&---------------------------------------------------------------------*
*& Report Z_LC_COMPRESS_STRING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------*
REPORT z_lc_compress_string.

*aaaabbbcccccdee
DATA:lv_cstr  TYPE string,
     lv_curr  TYPE c,
     lv_count TYPE i VALUE 1,
     lv_next  TYPE c.

PARAMETERS: p_string TYPE string.


DATA(lv_strlen) = strlen( p_string ).


DO lv_strlen TIMES.

  DATA(lv_index) = sy-index - 1.


  lv_curr = p_string+lv_index(1).
  IF  sy-index LT lv_strlen .
    lv_next =  p_string+sy-index(1).
  ENDIF.
  IF lv_curr = lv_next.
    lv_count = lv_count + 1.
  ELSE.
    lv_cstr = | { lv_cstr }{ lv_count }{ lv_curr }|.
    lv_count = 1."RESET COUNT
    CLEAR:lv_next.
  ENDIF.


ENDDO.

WRITE:/  p_string.
WRITE:/  lv_cstr.
