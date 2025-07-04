*&---------------------------------------------------------------------*
*& Report ZLC_SLIDING_WINDOW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlc_sliding_window.
*we have a 3 characters a,b, c and we have a text abcdbcacdbac
*find the number of  combinations a b c in text
*like here index 1 - abc, index 5 bca, index 10 bac , write a abap program for this


PARAMETERS: p_text TYPE string DEFAULT 'abcdbcacdbac'.

DATA: lv_count  TYPE i VALUE 0,
      lv_substr TYPE string,
      lv_len    TYPE i.

lv_len = strlen( p_text ).

DO lv_len - 2 TIMES.
  DATA(lv_idx) = sy-index - 1.
  lv_substr = p_text+lv_idx(3). " Take 3-character substring

  IF lv_substr CS 'a' AND lv_substr CS 'b' AND lv_substr CS 'c'.
    lv_count = lv_count + 1.
    WRITE: / 'Match at index', sy-index, ':', lv_substr.
  ENDIF.
ENDDO.

WRITE: / 'Total combinations of a, b, c:', lv_count.




*
*PARAMETERS: p_text TYPE string DEFAULT 'abcdbcacdbac'.
*
*DATA: lv_len TYPE i,
*      lv_pos TYPE i,
*      lv_count TYPE i VALUE 0,
*      lv_char1 TYPE c LENGTH 1,
*      lv_char2 TYPE c LENGTH 1,
*      lv_char3 TYPE c LENGTH 1,
*      lv_triplet TYPE string.
*
*lv_len = strlen( p_text ).
*
*DO lv_len - 2 TIMES.
*  lv_pos = sy-index - 1.
*
*  " Access each character by index
*  lv_char1 = p_text+lv_pos(1).
*  lv_char2 = p_text+lv_pos+1(1).
*  lv_char3 = p_text+lv_pos+2(1).
*
*  " Count presence of a, b, c manually
*  DATA(na) = 0.
*  DATA(nb) = 0.
*  DATA(nc) = 0.
*
*  LOOP AT VALUE #( lv_char1 lv_char2 lv_char3 ) INTO DATA(ch).
*    IF ch = 'a'.
*      na = na + 1.
*    ELSEIF ch = 'b'.
*      nb = nb + 1.
*    ELSEIF ch = 'c'.
*      nc = nc + 1.
*    ENDIF.
*  ENDLOOP.
*
*  IF na = 1 AND nb = 1 AND nc = 1.
*    lv_count += 1.
*    WRITE: / 'Match at index', sy-index, '→', lv_char1, lv_char2, lv_char3.
*  ENDIF.
*
*ENDDO.
*
*WRITE: / 'Total combinations of a, b, c:', lv_count.
