*&---------------------------------------------------------------------*
*& Report Z_LC_BINARY_TREE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_binary_tree.


TYPES: BEGIN OF ty_binarybtree,
         value TYPE i,
         left  TYPE REF TO data,
         right TYPE REF TO data,
       END OF ty_binarybtree.

TYPES: lty_i TYPE STANDARD TABLE OF i WITH EMPTY KEY .

DATA: btree TYPE ty_binarybtree.


START-OF-SELECTION.

  DATA(lt_values) = VALUE lty_i( ( 2 ) ( 1 ) ( 3 ) ( 6 ) ( 9 ) ( 5 ) ) .


  LOOP AT lt_values INTO DATA(ls_values).

    PERFORM add_value USING btree ls_values.

  ENDLOOP.


  SKIP.
  WRITE:/ 'Binary btree List '.
  WRITE:/ '======================'.
  SKIP.

  PERFORM print_value USING btree.




*&---------------------------------------------------------------------*
*& Form add_value
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> BTREE
*&      --> LS_VALUE
*&---------------------------------------------------------------------*
FORM add_value  USING   btree TYPE ty_binarybtree
                         val TYPE i.

  FIELD-SYMBOLS: <lbtree> TYPE ty_binarybtree.
  DATA: work TYPE ty_binarybtree.

  IF btree IS INITIAL.

    btree-value = val.
    CLEAR: btree-left, btree-right.
    CREATE DATA btree-left TYPE ty_binarybtree.
    CREATE DATA btree-right TYPE ty_binarybtree.

  ELSE.

    IF val LE btree-value.

      ASSIGN  btree-left->* TO <lbtree>.
      PERFORM add_value USING <lbtree> val .
    ELSE.
      ASSIGN  btree-right->* TO <lbtree>.
      PERFORM add_value USING <lbtree> val .

    ENDIF.




  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form print_value
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> BTREE
*&---------------------------------------------------------------------*
FORM print_value  USING  btree TYPE ty_binarybtree.

  FIELD-SYMBOLS: <bintree> TYPE any.

  IF btree IS NOT INITIAL.

    ASSIGN btree-left->* TO <bintree>.
    PERFORM print_value USING <bintree>.

    WRITE: btree-value.

    ASSIGN btree-right->* TO <bintree>.
    PERFORM print_value USING <bintree>.

  ENDIF.


ENDFORM.
