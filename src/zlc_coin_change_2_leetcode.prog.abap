*&---------------------------------------------------------------------*
*& Report ZLC_COIN_CHANGE_2_LEETCODE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLC_COIN_CHANGE_2_LEETCODE.

*You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.
*Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.
*You may assume that you have an infinite number of each kind of coin.
*The answer is guaranteed to fit into a signed 32-bit integer.
*
*Example 1:
*
*Input: amount = 5, coins = [1,2,5]
*Output: 4
*Explanation: there are four ways to make up the amount:
*5=5
*5=2+2+1
*5=2+1+1+1
*5=1+1+1+1+1
*Example 2:
*
*Input: amount = 3, coins = [2]
*Output: 0
*Explanation: the amount of 3 cannot be made up just with coins of 2.
*Example 3:
*
*Input: amount = 10, coins = [10]
*Output: 1
TYPES: ty_amount     TYPE i,
       ty_coin_value TYPE i.

DATA: lt_coins     TYPE STANDARD TABLE OF ty_coin_value WITH EMPTY KEY,
      lv_amount    TYPE ty_amount VALUE 5,  " Change this as needed
      lt_dp        TYPE STANDARD TABLE OF i WITH EMPTY KEY,
      lv_result    TYPE i,
      lv_index     TYPE i,
      lv_coin      TYPE i.

" Fill the coin denominations
APPEND 1 TO lt_coins.
APPEND 2 TO lt_coins.
APPEND 5 TO lt_coins.

" Initialize DP array: dp[0] = 1, rest 0
DO lv_amount + 1 TIMES.
  APPEND 0 TO lt_dp.
ENDDO.
lt_dp[ 1 ] = 1.  " ABAP is 1-based by default

" Main DP logic
LOOP AT lt_coins INTO lv_coin.
  DO lv_amount TIMES.
    lv_index = sy-index.
    IF lv_index >= lv_coin.
      lt_dp[ lv_index + 1 ] = lt_dp[ lv_index + 1 ] + lt_dp[ lv_index + 1 - lv_coin ].
    ENDIF.
  ENDDO.
ENDLOOP.

lv_result = lt_dp[ lv_amount + 1 ].
WRITE: / 'Number of combinations:', lv_result.
