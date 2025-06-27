*&---------------------------------------------------------------------*
*& Report ZLC_COIN_CHANGE_LEETCODE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlc_coin_change_leetcode.
*https://leetcode.com/problems/coin-change/description/
*You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.
*Return the fewest number of coins that you need to make up that amount.
*If that amount of money cannot be made up by any combination of the coins, return -1.
*You may assume that you have an infinite number of each kind of coin.

*
*Example 1:
*
*Input: coins = [1,2,5], amount = 11
*Output: 3
*Explanation: 11 = 5 + 5 + 1
*Example 2:
*
*Input: coins = [2], amount = 3
*Output: -1
*Example 3:
*
*Input: coins = [1], amount = 0
*Output: 0
*
*
*Constraints:
*
*1 <= coins.length <= 12
*1 <= coins[i] <= 231 - 1
*0 <= amount <= 104

TYPES: ty_coin  TYPE i,
       ty_coins TYPE STANDARD TABLE OF ty_coin WITH EMPTY KEY.

DATA: lt_coins     TYPE ty_coins,
      lv_amount    TYPE i VALUE 11,
      lv_result    TYPE i,
      lv_max_value TYPE i,
      lt_dp        TYPE STANDARD TABLE OF i WITH EMPTY KEY,
      lv_i         TYPE i,
      lv_j         TYPE i,
      lv_coin      TYPE i,
      lv_temp      TYPE i.

" Sample input: coins = [1,2,5], amount = 11

lt_coins = VALUE #( ( 5 ) ( 2 ) ( 1 ) ).
*lt_coins = VALUE #( ( 6 ) ( 2 ) ( 4 ) ).
lv_amount = 11.

lv_max_value = lv_amount + 1.

" Initialize DP table
lt_dp = VALUE #( FOR i = 0 UNTIL i > lv_amount ( COND i( WHEN i = 0 THEN 0 ELSE lv_max_value ) ) ).

" Dynamic Programming to build up the solution
LOOP AT lt_coins INTO lv_coin.
  DO lv_amount TIMES.
    lv_j = sy-index.
    IF lv_coin <= lv_j.
      READ TABLE lt_dp INDEX ( lv_j - lv_coin + 1 ) INTO lv_temp.
      IF sy-subrc = 0.
        lv_temp = lv_temp + 1.
        READ TABLE lt_dp INDEX lv_j + 1 INTO lv_i.
        IF lv_temp < lv_i.
          " Update with fewer coins
          lt_dp[ lv_j + 1 ] = lv_temp.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDDO.
ENDLOOP.

READ TABLE lt_dp INDEX lv_amount + 1 INTO lv_result.
IF lv_result > lv_amount.
  lv_result = -1.
ENDIF.

WRITE: / 'Minimum number of coins required:', lv_result.
