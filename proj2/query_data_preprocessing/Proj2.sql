-- SELECT 
--     bibNumber, title, deweyClass
-- FROM
--     spl_2016.outraw
-- WHERE
--     title LIKE '%generative%'
-- LIMIT 1000;

-- SELECT *
-- FROM
--     spl_2016.outraw
-- WHERE
--     title LIKE '%generative%';
--     
SELECT *
FROM
    spl_2016.outraw
WHERE
    title LIKE '%craft%';
    
SELECT
	bibNumber, title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%craft%'
ORDER BY bibNumber;

# craft
# lots of irrelavant data
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%craft%'
ORDER BY deweyClass;

# macrame 8
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%macrame%'
) AS fb_titles
ORDER BY bibNumber;

# friendship bracelet 11
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%friendship bracelet%'
) AS fb_titles
ORDER BY bibNumber;

# crochet 553
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%crochet%'
) AS fb_titles
ORDER BY bibNumber;

# amigurumi 57
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%amigurumi%'
) AS fb_titles
ORDER BY bibNumber;

# knit
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%knit%'
) AS fb_titles
ORDER BY bibNumber;

# weave
SELECT *
FROM (
SELECT
	DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%weave%'
) AS fb_titles
ORDER BY bibNumber;

--
SELECT *
FROM (
    SELECT DISTINCT(barcode), itemNumber, title, cout, cin, deweyClass, bibNumber, collcode, callNumber
    FROM spl_2016.inraw
    WHERE title LIKE '%macrame%'
    OR title LIKE '%friendship bracelet%'
    OR title LIKE '%crochet%'
    OR title LIKE '%amigurumi%'
--     OR title LIKE '%knit%'
--     OR title LIKE '%weave%'
) AS macrame_books
ORDER BY itemNumber, barcode, cout;
--

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