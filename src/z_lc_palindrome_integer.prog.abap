*&---------------------------------------------------------------------*
*& Report Z_LC_PALINDROME_INTEGER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_palindrome_integer.
*Time complexity O(n).
*Given an integer x, return true if x is palindrome integer.

*An integer is a palindrome when it reads the same backward as forward. For example, 121 is palindrome while 123 is not.

*DATA lv_num TYPE i  VALUE 1221.
PARAMETERS: lv_num TYPE i.

CLASS lcl_pali DEFINITION.
  PUBLIC SECTION.
    METHODS m_palicheck IMPORTING num TYPE i RETURNING VALUE(flag) TYPE boolean.
ENDCLASS.

START-OF-SELECTION.

  DATA(lv_ref) = NEW lcl_pali( ).
  IF lv_ref IS NOT INITIAL.
    DATA(x) = lv_ref->m_palicheck( EXPORTING num = lv_num ).
    IF x EQ abap_true .
      WRITE 'Number is Palindrome'.
    ELSE.
      WRITE 'Number is not Palindrome'.
    ENDIF.
  ENDIF.

CLASS lcl_pali IMPLEMENTATION.

  METHOD m_palicheck .
    IF num < 0.
      flag = abap_false.
      RETURN.
    ENDIF.
    DATA(reverse) = 0.
    DATA(n) = num.
    WHILE n > 0.
      reverse = reverse * 10 + n MOD 10.
      n = n / 10.
    ENDWHILE.
    IF reverse = num.
      flag = abap_true.
    ELSE.
      flag = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
