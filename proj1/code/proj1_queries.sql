SELECT *
FROM (
	SELECT 
		 spl_2016.subject.subject AS SBJ, COUNT(*) AS CNT
	FROM
		spl_2016.subject
	GROUP BY SBJ
	ORDER BY CNT DESC
) all_subj_desc
WHERE CNT < 200;


SELECT 
    spl_2016.outraw.subj AS OUT_SBJ, COUNT(*) AS NUM
FROM
    spl_2016.outraw
GROUP BY OUT_SBJ
ORDER BY NUM DESC
LIMIT 100;


SELECT 
    DISTINCT(bibNumber), title, deweyClass
FROM
    spl_2016.outraw
WHERE
    title LIKE '%homosexual%'
	OR title LIKE '%lesbian%'
    OR title LIKE '%gay%'
    OR title LIKE '%bisexual%'
    OR title LIKE '%transgender%'
    OR title LIKE '%queer%'
ORDER BY bibNumber
LIMIT 1000;

SELECT 
    *
FROM(
	SELECT DISTINCT(bibNumber) AS distinct_bib, title, deweyClass, itemtype
    FROM
        spl_2016.outraw
    WHERE
        title LIKE '%homosexual%'
		OR title LIKE '%lesbian%'
		OR title LIKE '%gay%'
		OR title LIKE '%bisexual%'
		OR title LIKE '%transgender%'
		OR title LIKE '%queer%'
    ORDER BY bibNumber
) queer_titles
LEFT JOIN spl_2016.subject
ON distinct_bib = spl_2016.subject.bibNumber;

-- SELECT column_name
-- FROM table1
-- LEFT JOIN table2
-- ON table1.column_name=table2.column_name;


SELECT *
FROM(
	SELECT DISTINCT(bibNumber) AS distinct_bib, subject
	FROM
		spl_2016.subject
	WHERE
		spl_2016.subject.subject LIKE '%homosexual%'
		OR spl_2016.subject.subject LIKE '%lesbian%'
		OR spl_2016.subject.subject LIKE '%gay%'
		OR spl_2016.subject.subject LIKE '%bisexual%'
		OR spl_2016.subject.subject LIKE '%transgender%'
		OR spl_2016.subject.subject LIKE '%queer%'
	ORDER BY bibNumber
) bib_subj
LEFT JOIN (
	SELECT DISTINCT(bibNumber) AS out_bib, title, itemtype, deweyClass
	FROM
		spl_2016.outraw
)outraw_titles
ON distinct_bib = out_bib;


SELECT *
FROM(
	SELECT DISTINCT(bibNumber) AS distinct_bib, subject
	FROM
		spl_2016.subject
	WHERE
		spl_2016.subject.subject LIKE '%homosexual%'
		OR spl_2016.subject.subject LIKE '%lesbian%'
		OR spl_2016.subject.subject LIKE '%gay%'
		OR spl_2016.subject.subject LIKE '%bisexual%'
		OR spl_2016.subject.subject LIKE '%transgender%'
		OR spl_2016.subject.subject LIKE '%queer%'
	ORDER BY bibNumber
) bib_subj
INNER JOIN (
	SELECT DISTINCT(title), itemtype, deweyClass, bibNumber as out_bib
	FROM
		spl_2016.outraw
)outraw_titles
ON distinct_bib = out_bib;

# why does adding the out_bib column add rows too?
SELECT DISTINCT(title), deweyClass, out_bib
FROM (
	SELECT *
	FROM(
		SELECT DISTINCT(bibNumber) AS distinct_bib, subject
		FROM
			spl_2016.subject
		WHERE
			spl_2016.subject.subject LIKE '%homosexual%'
			OR spl_2016.subject.subject LIKE '%lesbian%'
			OR spl_2016.subject.subject LIKE '%gay%'
			OR spl_2016.subject.subject LIKE '%bisexual%'
			OR spl_2016.subject.subject LIKE '%transgender%'
			OR spl_2016.subject.subject LIKE '%queer%'
		ORDER BY bibNumber
	) bib_subj
	INNER JOIN (
		SELECT title, itemtype, deweyClass, bibNumber as out_bib
		FROM
			spl_2016.outraw
		WHERE deweyClass != ''
	)outraw_titles
	ON distinct_bib = out_bib
)inner_join_table
ORDER BY deweyClass;

SELECT DISTINCT(title), deweyClass
FROM (
	SELECT *
	FROM(
		SELECT DISTINCT(bibNumber) AS distinct_bib, subject
		FROM
			spl_2016.subject
		WHERE
			spl_2016.subject.subject LIKE '%homosexual%'
			OR spl_2016.subject.subject LIKE '%lesbian%'
			OR spl_2016.subject.subject LIKE '%gay%'
			OR spl_2016.subject.subject LIKE '%bisexual%'
			OR spl_2016.subject.subject LIKE '%transgender%'
			OR spl_2016.subject.subject LIKE '%queer%'
		ORDER BY bibNumber
	) bib_subj
	INNER JOIN (
		SELECT title, itemtype, deweyClass, bibNumber as out_bib
		FROM
			spl_2016.outraw
		WHERE deweyClass != ''
	)outraw_titles
	ON distinct_bib = out_bib
)inner_join_table
ORDER BY deweyClass;


SELECT 
    YEAR(cout) AS YR, COUNT(cout) AS NUM_CHECKOUT
FROM(
	SELECT *
		FROM(
			SELECT DISTINCT(bibNumber) AS distinct_bib, subject
			FROM
				spl_2016.subject
			WHERE
				spl_2016.subject.subject LIKE '%homosexual%'
				OR spl_2016.subject.subject LIKE '%lesbian%'
				OR spl_2016.subject.subject LIKE '%gay%'
				OR spl_2016.subject.subject LIKE '%bisexual%'
				OR spl_2016.subject.subject LIKE '%transgender%'
				OR spl_2016.subject.subject LIKE '%queer%'
			ORDER BY bibNumber
		) bib_subj
		INNER JOIN (
			SELECT title, itemtype, deweyClass, bibNumber as out_bib, cout
			FROM
				spl_2016.outraw
		)outraw_titles
		ON distinct_bib = out_bib
) inner_join_table
GROUP BY YR;

SELECT 
    YEAR(cout) AS YR, MONTH(cout) AS MO, COUNT(cout) AS NUM_CHECKOUT
FROM(
	SELECT *
		FROM(
			SELECT DISTINCT(bibNumber) AS distinct_bib, subject
			FROM
				spl_2016.subject
			WHERE
				spl_2016.subject.subject LIKE '%homosexual%'
				OR spl_2016.subject.subject LIKE '%lesbian%'
				OR spl_2016.subject.subject LIKE '%gay%'
				OR spl_2016.subject.subject LIKE '%bisexual%'
				OR spl_2016.subject.subject LIKE '%transgender%'
				OR spl_2016.subject.subject LIKE '%queer%'
			ORDER BY bibNumber
		) bib_subj
		INNER JOIN (
			SELECT title, itemtype, deweyClass, bibNumber as out_bib, cout
			FROM
				spl_2016.outraw
		)outraw_titles
		ON distinct_bib = out_bib
) inner_join_table
GROUP BY YR, MO