*&---------------------------------------------------------------------*
*& Report Z_LC_FIND_WORDS_FROM_CHAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_find_words_from_char.



TYPES: tty_words TYPE STANDARD TABLE OF string WITH EMPTY KEY,
       tty_chars TYPE STANDARD TABLE OF c WITH EMPTY KEY.

DATA(lt_words) = VALUE tty_words( ( `coding` ) ( `apple`) ( `google`) ( `sreenith`) ( `pop`) ).
DATA(lt_chars) = VALUE tty_chars( ( 'a' ) ( 'e') ( 'g') ( 'o') ( 'p') ( 'o') ( 'l') ( 'p') ( 'e') ( 'g') ).


TYPES: BEGIN OF ty_str,
         char TYPE c,
         val  TYPE i,
       END OF ty_str.


DATA: lt_char_val  TYPE HASHED TABLE OF ty_str WITH UNIQUE KEY char,
      ls_char_val  TYPE ty_str,
      lt_char_temp TYPE HASHED TABLE OF ty_str WITH UNIQUE KEY char.


TRANSLATE sy-abcde TO LOWER CASE.

DATA(j) = 0.

DO 26 TIMES.

  ls_char_val-char = sy-abcde+j(1).
  ls_char_val-val  = 0.

  INSERT ls_char_val INTO TABLE lt_char_val.
  j = j + 1.
ENDDO.

LOOP AT lt_chars INTO DATA(ls_chars).

  READ TABLE lt_char_val ASSIGNING FIELD-SYMBOL(<lfs_char_val>) WITH KEY char = ls_chars.
  IF sy-subrc = 0.
    <lfs_char_val>-val = <lfs_char_val>-val + 1.
  ENDIF.

ENDLOOP.


LOOP AT lt_words ASSIGNING FIELD-SYMBOL(<lfs_words>).

  DATA(i) = 0.

  DATA(lv_counter) = 0.
  DATA(lv_strlen) = strlen( <lfs_words> ).

  CLEAR: lt_char_temp[].

  lt_char_temp[] = lt_char_val[].

  WHILE i < lv_strlen .

    DATA(lv_char) = <lfs_words>+i(1).

    READ TABLE lt_char_temp WITH KEY char = lv_char ASSIGNING FIELD-SYMBOL(<lfs_temp>).
    IF sy-subrc = 0 AND <lfs_temp>-val > 0 .

      <lfs_temp>-val  = <lfs_temp>-val - 1.
      lv_counter = lv_counter + 1.
    ELSE.
      EXIT.
    ENDIF.

    i = i + 1.
  ENDWHILE.

  IF lv_counter  = lv_strlen.
    WRITE : <lfs_words>.
  ENDIF.
ENDLOOP.
