*&---------------------------------------------------------------------*
*& Report Z_LC_COMPRESS_STRING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------*
REPORT z_lc_compress_string.
*⏱ Time Complexity: O(n)
*- The loop runs once for each character of the input string → DO strlen( p_string ) TIMES → O(n)
*- Each iteration performs only constant-time operations: character access, comparison, and string appending
*- Appending to lv_cstr is handled by ABAP’s string concatenation, which has amortized linear performance, but since we only perform at most n such appends, the overall work remains linear
*✅ Final time complexity: O(n), where n is the length of the input string
*
*🧠 Space Complexity: O(n)
*- lv_cstr stores the compressed result. In the worst case (no repeated characters, like abcdef), the compressed string grows nearly double: 2n
*- Apart from a few scalar variables (lv_curr, lv_next, etc.), there’s no additional memory overhead
*✅ Final space complexity: O(n)

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
