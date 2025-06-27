*&---------------------------------------------------------------------*
*& Report Z_LC_SUBQUERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lc_subquery.


*Given 2 tables, a manager table and an employee table, query to get all Managers who have at least one male & one female employee reporting to him.
*This is a very simple question to begin with. I will be using aggregation functions for calculating employees under a manager.

*SELECT a~id,
*       a~name,
*       SUM( CASE WHEN b~gender = 'F' THEN 1 ELSE 0 END ) AS female,
*       SUM( CASE WHEN b~gender = 'M' THEN 1 ELSE 0 END ) AS male
*  FROM zmanager AS a
*  INNER JOIN zemployee AS b
*  ON a~id = b~manager
*  INTO TABLE @DATA(lt_)
*  GROUP BY a~id, a~name.
*
*DELETE lt_ WHERE ( female < 1 OR male < 1 ).


*Given a table which includes field firstname and lastname,
*query that returns the first and last name of each person in the table whose last name appears at least twice in the column “lastname”.
*I have tried to do this using subquery approach.

*SELECT name, lastname FROM zemployee
*INTO TABLE @DATA(lt1_)
*WHERE lastname IN
* ( SELECT lastname FROM zemployee
*  GROUP BY lastname HAVING COUNT(*) > 1 ).

*--------------------------------------------------------------------*
*--------------------------------------------------------------------*

*  Correlated, non-scalar subquery:

*REPORT demo_select_subquery_1.

DATA: name_tab TYPE TABLE OF scarr-carrname,
      name     LIKE LINE OF name_tab.

SELECT  carrname
  INTO  TABLE name_tab
  FROM  scarr
  WHERE EXISTS ( SELECT  *
                   FROM  spfli
                   WHERE carrid   =  scarr~carrid AND
                         cityfrom = 'NEW YORK'        ).

LOOP AT name_tab INTO name.
  WRITE: / name.
ENDLOOP.

*This example selects all lines from database table SCARR for airlines that fly from New York.

*Example

*Scalar subquery:

*REPORT demo_select_subquery_2.

DATA: carr_id TYPE spfli-carrid VALUE 'LH',
      conn_id TYPE spfli-connid VALUE '0400'.

DATA: city  TYPE sgeocity-city,
      lati  TYPE p DECIMALS 2,
      longi TYPE p DECIMALS 2.

SELECT  SINGLE city latitude longitude
  INTO  (city, lati, longi)
  FROM  sgeocity
  WHERE city IN ( SELECT  cityfrom
                    FROM  spfli
                    WHERE carrid = carr_id AND
                          connid = conn_id      ).

WRITE: city, lati, longi.

*This example reads the latitude and longitude of the departure city of flight LH 402 from database table SGEOCITY.

*Example

*Scalar subquery:

*REPORT demo_select_subquery_3.

DATA: wa    TYPE sflight,
      plane LIKE wa-planetype,
      seats LIKE wa-seatsmax.

SELECT     carrid connid planetype seatsmax MAX( seatsocc )
  INTO     (wa-carrid, wa-connid, wa-planetype,
            wa-seatsmax, wa-seatsocc)
  FROM     sflight
  GROUP BY carrid connid planetype seatsmax
  ORDER BY carrid connid.

  WRITE: /  wa-carrid,
            wa-connid,
            wa-planetype,
            wa-seatsmax,
            wa-seatsocc.

  HIDE: wa-carrid, wa-connid, wa-seatsmax.

ENDSELECT.

AT LINE-SELECTION.

  WINDOW STARTING AT 45 3 ENDING AT 85 13.

  WRITE: 'Alternative Plane Types',
         'for', wa-carrid, wa-connid.

  ULINE.

  SELECT  planetype seatsmax
    INTO  (plane, seats)
    FROM  saplane AS plane
    WHERE seatsmax < wa-seatsmax AND
          seatsmax >= ALL ( SELECT  seatsocc
                              FROM  sflight
                              WHERE carrid = wa-carrid AND
                                    connid = wa-connid     )
    ORDER BY seatsmax.

    WRITE: / plane, seats.

  ENDSELECT.

*  The detail list displays all aircraft types that have fewer seats than the currently-allocated aircraft type,
*   but enough to carry all of the passengers currently booked on the flight.
