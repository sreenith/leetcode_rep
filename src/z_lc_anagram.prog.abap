*&---------------------------------------------------------------------*
*& Report Z_LC_ANAGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_anagram.
*⏱ Time Complexity:
*Let n be the length of the input strings (since both are equal if they proceed past the length check).
*- Main DO loop:
*- Runs n times
*- Each loop:
*- Two READ TABLE operations into a HASHED TABLE → average O(1) each
*- At most one INSERT per character if not already present → also O(1)
*- So, per iteration = constant work → O(1)
*✅ Total for loop: O(n)
*- Final DELETE and IS INITIAL check:
*- DELETE lt_dict WHERE val = 0 traverses the hash table → at most O(k)
*- k = number of unique characters, and since we're working with single characters, k ≤ 128 (ASCII) → treated as O(1)
*✅ Total Time Complexity: O(n)
*🧠 Space Complexity:
*- lt_dict holds up to k entries for each unique character across both strings
*→ Maximum k = 128 (if extended ASCII, 256; Unicode could be higher, but normally bounded)
*- Regardless of input size, this stays constant for small alphabet sizes
*✅ Total Space Complexity: O(k) → effectively O(1) for ASCI

TYPES : BEGIN OF ty_dict,
          let TYPE c,
          val TYPE i,
        END OF ty_dict.

DATA: lt_dict TYPE HASHED TABLE OF ty_dict WITH UNIQUE KEY let,
      ls_dict TYPE ty_dict.

PARAMETERS : p1 TYPE string OBLIGATORY,
             p2 TYPE string OBLIGATORY.


DATA(lv_lp1) = strlen( p1 ).
DATA(lv_lp2) = strlen( p2 ).

IF  lv_lp1 NE lv_lp2.
  WRITE :/ 'Not an anagram!'.
ELSE.

  DO lv_lp1 TIMES.

    DATA(lv_ind) = sy-index - 1.

    DATA(lv_char) = p1+lv_ind(1).

    READ TABLE lt_dict ASSIGNING FIELD-SYMBOL(<fs_dict>) WITH KEY let = lv_char.
    IF sy-subrc NE 0.
      CLEAR: ls_dict.
      ls_dict-let = lv_char.
      ls_dict-val = 1.
      INSERT ls_dict INTO TABLE lt_dict.

    ELSE.
      <fs_dict>-val =  <fs_dict>-val + 1 .

    ENDIF.

    DATA(lv_char2) = p2+lv_ind(1).

    READ TABLE lt_dict ASSIGNING <fs_dict> WITH KEY let = lv_char2.
    IF sy-subrc NE 0.
      CLEAR: ls_dict.
      ls_dict-let = lv_char2.
      ls_dict-val = -1.
      INSERT ls_dict INTO TABLE lt_dict.

    ELSE.
      <fs_dict>-val =  <fs_dict>-val - 1 .

    ENDIF.

  ENDDO.


  DELETE lt_dict WHERE val = 0.
  IF lt_dict IS INITIAL .
    WRITE: / 'Anagram found'.
  ELSE.
    WRITE: / 'Not an Anagram '.
  ENDIF.

ENDIF.
