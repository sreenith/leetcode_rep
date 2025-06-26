*&---------------------------------------------------------------------*
*& Report Z_LC_REMOVE_NTH_NODE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_remove_nth_node.
*Given the head of a linked list, remove the nth node from the end of the list and return its head.

*Constraints:

*The number of nodes in the list is sz.
*1 <= sz <= 30
*0 <= Node.val <= 100
*1 <= n <= sz

*Follow up: Could you do this in one pass?

*Time Complexity : T(n)

TYPES: BEGIN OF ty_node ,
         val  TYPE i,
         next TYPE REF TO data,
       END OF ty_node.
DATA root TYPE REF TO ty_node.
DATA temp TYPE REF TO ty_node.
TYPES ty_array TYPE STANDARD TABLE OF i WITH EMPTY KEY.

DATA(a) = VALUE ty_array( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ).
DATA(n) = 3.
CLASS lcl_ll DEFINITION .
  PUBLIC SECTION .
    METHODS: m_build_ll IMPORTING data TYPE i CHANGING head TYPE REF TO ty_node.
    METHODS: m_traverse_ll IMPORTING head TYPE REF TO ty_node RETURNING VALUE(x) TYPE i.
    METHODS: m_delete_node IMPORTING place TYPE i  head TYPE REF TO ty_node RETURNING VALUE(new) TYPE REF TO ty_node.
ENDCLASS.


START-OF-SELECTION.
  DATA(lv_ref) = NEW lcl_ll( ).
  IF lv_ref IS NOT INITIAL.
    LOOP AT a INTO DATA(ls).
      lv_ref->m_build_ll( EXPORTING data = ls CHANGING head = root ).
    ENDLOOP.
    DATA(l) = lv_ref->m_traverse_ll( EXPORTING head = root ).

    temp = lv_ref->m_delete_node( EXPORTING place = ( l - n )  head = root ).
    WRITE: /.

    DATA(dl) = lv_ref->m_traverse_ll( EXPORTING head = temp ).

  ENDIF.
CLASS lcl_ll IMPLEMENTATION.
  METHOD m_build_ll.
    DATA p TYPE REF TO ty_node.

    IF head IS INITIAL.

      CREATE DATA head.
      head->val = data.
      temp = head.
    ELSE.
      CREATE DATA p.
      p->val = data.
      temp->next = p.
      temp = p.
    ENDIF.
  ENDMETHOD.
  METHOD m_traverse_ll .
    temp = head.
    WHILE temp IS NOT INITIAL.
      x = x + 1.
      WRITE: temp->val , '->'.
      temp ?= temp->next.
    ENDWHILE.
  ENDMETHOD.
  METHOD m_delete_node.
    DATA p TYPE REF TO ty_node.
    DATA node_h TYPE REF TO ty_node.
    DATA node TYPE REF TO ty_node.
    FIELD-SYMBOLS <fs> TYPE ty_node.
    DATA(pi) = place.
    node_h = head.
    node = node_h.

    "Edge case check
    IF place < - 1.
      new = node_h.
      RETURN.
    ENDIF.
    IF place < 2.
*      p = node_h.
      node_h ?= node_h->next.
*      free p.
      new = node_h.
      RETURN.
    ENDIF.

    "Normal Scenarios
    WHILE pi > 1.
      node ?= node->next.
      pi = pi - 1.
    ENDWHILE.
    ASSIGN node->next->* TO <fs>.
    IF <fs> IS ASSIGNED.
      node->next = <fs>-next.
    ENDIF.
    new = node_h.
    FREE: p , node,node_h,<fs>.
  ENDMETHOD.
ENDCLASS.
