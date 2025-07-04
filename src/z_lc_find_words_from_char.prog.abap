*&---------------------------------------------------------------------*
*& Report Z_LC_FIND_WORDS_FROM_CHAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_find_words_from_char.

*⏱ Time Complexity
*Let:
*- n = number of words (lt_words)
*- k = average word length
*- m = number of input characters in lt_chars
*Step-by-step:
*- Initialize lt_char_val with 26 alphabet entries:
*- DO 26 TIMES → O(1)
*- Build frequency table from lt_chars:
*- Loop over m elements → each READ is O(1) in a hashed table
*✅ Total: O(m)
*- Main word loop (LOOP AT lt_words):
*- Runs n times
*- Each iteration:
*- Copies the character frequency table → O(1) (fixed 26 entries)
*- Inner WHILE over each character in the word → O(k)
*- Each READ into lt_char_temp → O(1) ✅ Total: O(n × k)
*Overall:
*Total Time Complexity: O(m + n × k)
*(Most often dominated by n × k if m is small)

*🧠 Space Complexity
*- lt_char_val: Fixed 26-letter hash → O(1)
*- lt_char_temp: Copy of lt_char_val → still O(1)
*- lt_words: Input of n words with k characters each → O(n × k)
*- lt_chars: Input of m characters → O(m)
*Total Space Complexity: O(n × k + m)
*(Driven by input, not auxiliary structures)



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
*--------------------------------------------------------------------*

*TYPES: BEGIN OF ty_freq,
*         char TYPE c,
*         val  TYPE i,
*       END OF ty_freq.
*
*TYPES: tty_words TYPE STANDARD TABLE OF string WITH EMPTY KEY,
*       tty_chars TYPE STANDARD TABLE OF c WITH EMPTY KEY.
*
*DATA(lt_words) = VALUE tty_words( ( `coding` ) ( `apple`) ( `google`) ( `sreenith`) ( `pop`) ).
*DATA(lt_chars) = VALUE tty_chars( ( 'a' ) ( 'e') ( 'g') ( 'o') ( 'p') ( 'o') ( 'l') ( 'p') ( 'e') ( 'g') ).
*
*DATA: lt_freq TYPE HASHED TABLE OF ty_freq WITH UNIQUE KEY char,
*      ls_freq TYPE ty_freq.
*
*" Initialize frequency table
*LOOP AT lt_chars INTO DATA(ch).
*  READ TABLE lt_freq ASSIGNING FIELD-SYMBOL(<fs_freq>) WITH KEY char = ch.
*  IF sy-subrc = 0.
*    <fs_freq>-val += 1.
*  ELSE.
*    ls_freq-char = ch.
*    ls_freq-val = 1.
*    INSERT ls_freq INTO TABLE lt_freq.
*  ENDIF.
*ENDLOOP.
*
*" Process each word
*LOOP AT lt_words INTO DATA(word).
*  DATA word_freq TYPE HASHED TABLE OF ty_freq WITH UNIQUE KEY char.
*  CLEAR word_freq.
*
*  DATA is_valid TYPE abap_bool VALUE abap_true.
*
*  DO strlen( word ) TIMES.
*    DATA(lv_i) = sy-index - 1.
*    DATA(lv_char) = word+lv_i(1).
*
*    " Count character for this word
*    READ TABLE word_freq ASSIGNING FIELD-SYMBOL(<fs_w>) WITH KEY char = lv_char.
*    IF sy-subrc = 0.
*      <fs_w>-val += 1.
*    ELSE.
*      ls_freq-char = lv_char.
*      ls_freq-val = 1.
*      INSERT ls_freq INTO TABLE word_freq.
*    ENDIF.
*
*    " Compare with available character frequency
*    READ TABLE lt_freq INTO DATA(ls_avail) WITH KEY char = lv_char.
*    IF sy-subrc <> 0 OR ls_avail-val < word_freq[ KEY char = lv_char ]-val.
*      is_valid = abap_false.
*      EXIT.
*    ENDIF.
*  ENDDO.
*
*  IF is_valid = abap_true.
*    WRITE: / word.
*  ENDIF.
*ENDLOOP.
