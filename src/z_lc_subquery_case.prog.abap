*&---------------------------------------------------------------------*
*& Report Z_LC_SUBQUERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_subquery_case.
*Case 1

SELECT empid FROM zemp_master
  INTO TABLE @DATA(lt_empid)
  WHERE empid NOT IN ( SELECT empid FROM zemp_type WHERE emptype NE 'DEV' ).


*BREAK-POINT.
*Case 2
*Given a table which includes field firstname and lastname,
*query that returns the first and last name of each person in the table whose last name appears at least twice in the column “lastname”.
*I have tried to do this using subquery approach.

SELECT emp_name, lastname FROM zemp_master
INTO TABLE @DATA(lt1_)
WHERE lastname IN
 ( SELECT lastname FROM zemp_master
  GROUP BY lastname HAVING COUNT(*) > 1 ).

*BREAK-POINT.
*Case 3
*We have a employee table having employee id and details like department id salary of the employee and employee name
*,we have one more table for department master where department id and name is maintained,
* how to select the employee with highest salary for each department and select the data with department name ,
*employee name and the salary of the employee , write a code in sap abap using new abap syntax


TYPES: BEGIN OF ty_result,
         dept_name TYPE zdepartment-dept_name,
         emp_name  TYPE zemp_master-emp_name,
         salary    TYPE zemp_master-salary,
       END OF ty_result.

DATA: lt_result TYPE TABLE OF ty_result.

WITH +max_salaries AS (
  SELECT dept,
         MAX( salary ) AS salary
    FROM zemp_master
    GROUP BY dept
),
+top_earners AS (
  SELECT emp~emp_name,
         emp~salary,
         emp~dept
    FROM zemp_master AS emp
    INNER JOIN +max_salaries AS ms
      ON emp~dept = ms~dept
     AND emp~salary  = ms~salary
),
+final_result AS (
  SELECT dept~dept_name,
         top~emp_name,
         top~salary
    FROM +top_earners AS top
    INNER JOIN zdepartment AS dept
      ON top~dept = dept~dept
)
SELECT * FROM +final_result
INTO TABLE @lt_result.

cl_demo_output=>display( lt_result ).

*BREAK-POINT.
