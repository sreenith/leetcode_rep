*&---------------------------------------------------------------------*
*& Report Z_LC_TWO_SUM_NEW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_LC_TWO_SUM_NEW.


*Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

*You may assume that each input would have exactly one solution, and you may not use the same element twice.

*You can return the answer in any order.

*Constraints:

*2 <= nums.length <= 104
*-109 <= nums[i] <= 109
*-109 <= target <= 109
*Only one valid answer exists.


*Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?


*Before jumping to any solution or try to go with  a heavy algorithm ,  first look for Brute force .
*If I see the problem statement , we need to find the two index position whose elements sum are equal to target .

*Constraints are : exactly one solution and you may  not use the same element twice.

*For example 1.

*nums = [2,7,11,15], target = 9
*step 1: 2 + 7 = 9
*only 2 and 7 two elements whose sum are 9 so return there index.
*In ABAP all the array or tables index start with 1.
*So for this scenario answer will be 1, 2 (Index)
*Let's Jump to Solution part .


*Time Complexity : O (N^2)
*Space Complexity : O(1)

TYPES ty_array TYPE STANDARD TABLE OF i WITH EMPTY KEY.
CLASS lcl_two_sum DEFINITION.
  PUBLIC SECTION.
    METHODS: m_brute_force IMPORTING array TYPE ty_array target TYPE i RETURNING VALUE(x) TYPE ty_array.
ENDCLASS.

START-OF-SELECTION.
  DATA(lv_ref) = NEW lcl_two_sum( ).
  DATA(a) = VALUE ty_array( ( 2 ) ( 7 ) ( 11 ) ( 15 ) ).
  IF lv_ref IS NOT INITIAL.
    DATA(indexs) = lv_ref->m_brute_force( EXPORTING array = a target = 9 ).

    WRITE : / indexs[ 1 ] , indexs[ 2 ].
  ENDIF.

CLASS lcl_two_sum IMPLEMENTATION.
  METHOD m_brute_force.
    DATA(i) = 1.
    WHILE i LE lines( array ).
      DATA(j) = i + 1.
      WHILE j LE lines( array ).
        IF array[ i ] + array[ j ] EQ target.
          APPEND i TO x.
          APPEND j TO x.
          RETURN.
        ENDIF.
        j = j + 1.
      ENDWHILE.
      i = i + 1.
    ENDWHILE.
    i = 0.
    APPEND  i TO x.
  ENDMETHOD.
ENDCLASS.
