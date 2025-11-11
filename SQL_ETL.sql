SELECT *
FROM netflix_raw


--FOREIGN CHARACTERS & DATA TYPE LIMITS
CREATE TABLE [dbo].[netflix_raw](
	[show_id] [varchar](10) PRIMARY KEY,
	[type] [varchar](10) NULL,
	[title] [nvarchar](200) NULL,
	[director] [varchar](250) NULL,
	[cast] [varchar](1000) NULL,
	[country] [varchar](150) NULL,
	[date_added] [varchar](20) NULL,
	[release_year] [int] NULL,
	[rating] [varchar](10) NULL,
	[duration] [varchar](10) NULL,
	[listed_in] [varchar](100) NULL,
	[description] [varchar](500) NULL
)

--REMOVE DUPLICATES
SELECT show_id, COUNT(*)
FROM netflix_raw
GROUP BY show_id
HAVING COUNT(*) > 1

SELECT * FROM netflix_raw
WHERE CONCAT(title, type) IN(
SELECT CONCAT(title, type)
FROM netflix_raw
GROUP BY title, type
HAVING COUNT(*) > 1
)
ORDER BY title

with cte as (
select * 
,ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
SELECT show_id, type, title, CAST(date_added as date) AS date_added, release_year, rating,
CASE WHEN duration IS NULL THEN rating ELSE duration END AS duration, description
INTO netflix_cleaned
FROM cte
WHERE rn=1


--NEW TABLE FOR director, cast, country, listed_in
SELECT show_id, TRIM(value) as director
INTO netflix_directors
FROM netflix_raw
CROSS APPLY string_split(director, ',')

SELECT show_id, TRIM(value) as country
INTO netflix_country
FROM netflix_raw
CROSS APPLY string_split(country, ',')

SELECT show_id, TRIM(value) as cast
INTO netflix_cast
FROM netflix_raw
CROSS APPLY string_split(cast, ',')

SELECT show_id, TRIM(value) as genre
INTO netflix_genre
FROM netflix_raw
CROSS APPLY string_split(listed_in, ',')


--DATA TYPE CONVERSIONS

--HANDLE MISSING VALUES
SELECT *
FROM netflix_raw
WHERE country IS NULL

SELECT *
FROM netflix_raw
WHERE director = 'Ahishor Solomon'

SELECT *
FROM netflix_country
WHERE show_id = 's1001'

INSERT INTO netflix_country
SELECT show_id, m.country
FROM netflix_raw nr
INNER JOIN(
SELECT director, country
FROM netflix_directors nd
INNER JOIN netflix_country nc
ON nd.show_id = nc.show_id
GROUP BY director, country
) m
ON nr.director = m.director
WHERE nr.country IS NULL

SELECT *
FROM netflix_raw
WHERE duration IS NULL

SELECT * FROM netflix_cleaned
