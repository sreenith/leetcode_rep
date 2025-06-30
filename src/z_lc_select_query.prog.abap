*&---------------------------------------------------------------------*
*& Report Z_LC_SELECT_QUERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_select_query.

*Given 2 tables, a manager table and an employee table, query to get all Managers who have at least one male & one female employee reporting to him.
*This is a very simple question to begin with. I will be using aggregation functions for calculating employees under a manager.

SELECT a~id,
       a~name,
       SUM( CASE WHEN b~gender = 'F' THEN 1 ELSE 0 END ) AS female,
       SUM( CASE WHEN b~gender = 'M' THEN 1 ELSE 0 END ) AS male
  FROM zmanager AS a
  INNER JOIN zemp_master AS b
  ON a~id = b~manager
  INTO TABLE @DATA(lt_manager)
  GROUP BY a~id, a~name
  HAVING SUM( CASE WHEN b~gender = 'F' THEN 1 ELSE 0 END ) > 1 AND SUM( CASE WHEN b~gender = 'M' THEN 1 ELSE 0 END ) > 1.


BREAK-POINT.
