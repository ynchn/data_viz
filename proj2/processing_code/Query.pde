/**
* 1st query
* check-out/check-in records of books containing keyword
*
SELECT *
FROM (
    SELECT DISTINCT(barcode), itemNumber, title, cout, cin, deweyClass, bibNumber, collcode, callNumber
    FROM spl_2016.inraw
    WHERE title LIKE '%macrame%'
    OR title LIKE '%friendship bracelet%'
    OR title LIKE '%crochet%'
    OR title LIKE '%amigurumi%'
) AS macrame_books
ORDER BY itemNumber, barcode, cout;
*/

/**
* 2nd query
* calculate the time between check-out and check-in dates
* tag each record with its book category
*
SELECT *
FROM
  (SELECT
    itemNumber, title, cout, cin, deweyClass,
    DATEDIFF(cin, cout) AS time_outside_lib,
    (CASE
      WHEN (title LIKE '%macrame%') THEN 'macrame'
      WHEN (title LIKE '%friendship bracelet%') THEN 'friendship bracelet'
      WHEN (title LIKE '%crochet%') THEN 'crochet'
      WHEN (title LIKE '%amigurumi%') THEN 'amigurumi'
    END) AS artform
  FROM
    spl_2016.inraw
  WHERE
    title LIKE '%macrame%'
    OR title LIKE '%friendship bracelet%'
    OR title LIKE '%crochet%'
    OR title LIKE '%amigurumi%') AS textile_art
ORDER BY artform, itemNumber, cout;
*/
