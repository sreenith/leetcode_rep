*&---------------------------------------------------------------------*
*& Report Z_LC_ANAGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_anagram.

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
