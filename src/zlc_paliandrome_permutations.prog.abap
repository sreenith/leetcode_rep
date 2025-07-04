*&---------------------------------------------------------------------*
*& Report ZLC_PALIANDROME_PERMUTATIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlc_paliandrome_permutations.
*⏱ Time Complexity
*- Character frequency counting (DO strlen( p_input )):
*- Each iteration: READ and potentially INSERT into a hashed table → O(1) per operation
*- For input string of length n → O(n) total
*- Odd frequency check (LOOP AT lt_freq):
*- At most k iterations, where k is the number of unique characters (bounded, ≤ 128 for ASCII)
*✅ Total Time Complexity: O(n)

*🧠 Space Complexity
*- lt_freq: Stores each unique character and its count → at most O(k) space
*- Scalar variables and field symbols don’t scale with input → negligible
*✅ Total Space Complexity: O(k)
*➡️ With English letters or ASCII input, this is effectively O(1)

*Given a string as an input parameter to a program, write code to identify if any permutations of the string is Palindrome or not.
*For exmaple:
*Given Input: aab
*Output: True (aba)
*
*Given Input: abc
*Output: False

DATA: lv_char      TYPE c LENGTH 1,
      lv_count     TYPE i,
      lv_index     TYPE sy-index,
      lv_odd_count TYPE i VALUE 0.

TYPES: BEGIN OF ty_freq,
         char  TYPE c LENGTH 1,
         count TYPE i,
       END OF ty_freq.

DATA: lt_freq TYPE HASHED TABLE OF ty_freq
                WITH UNIQUE KEY char,
      ls_freq TYPE ty_freq.


PARAMETERS p_input TYPE string.

* Count frequency of each character
DO strlen( p_input ) TIMES.
  lv_index = sy-index - 1 .
  lv_char = p_input+lv_index(1).

  READ TABLE lt_freq ASSIGNING FIELD-SYMBOL(<lfs_freq>) WITH KEY char = lv_char. "BINARY SEARCH.
  IF sy-subrc = 0.
    <lfs_freq>-count = <lfs_freq>-count + 1.

  ELSE.
    CLEAR ls_freq.
    ls_freq-char = lv_char.
    ls_freq-count = 1.
    INSERT ls_freq INTO TABLE lt_freq.
  ENDIF.
ENDDO.

* Check number of characters with odd frequency
LOOP AT lt_freq INTO ls_freq.
  IF ls_freq-count MOD 2 <> 0.
    lv_odd_count = lv_odd_count + 1.
  ENDIF.
ENDLOOP.

IF lv_odd_count <= 1.
  WRITE: / 'True - A palindrome permutation exists.'.
ELSE.
  WRITE: / 'False - No palindrome permutation possible.'.
ENDIF.
