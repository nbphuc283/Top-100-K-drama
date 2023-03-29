/* Count the number of appearance of each actors */
WITH actor_split AS(
SELECT
	SPLIT_PART("Main Role"::TEXT, ', ', generate_series(1,10)) AS names
FROM top100_kdrama)
SELECT names, COUNT(names)
FROM actor_split
WHERE names != ''
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

/*
names        |count|
-------------+-----+
Lee Do Hyun  |    5|
Jung Kyung Ho|    5|
Song Joong Ki|    5|
Lee Jung Eun |    5|
Kim Ji Won   |    4|
Bae Doo Na   |    4|
Yoo Yeon Seok|    4|
Oh Na Ra     |    4|
Byun Yo Han  |    3|
Song Hye Kyo |    3|
Yeom Hye Ran |    3|
Kim Ji Hoon  |    3|
Heo Joon Ho  |    3|
Kim Sung Gyu |    3|
Kim Ok Bin   |    3|
Kim Hye Soo  |    3|
Son Seok Koo |    3|
Kim Dae Myung|    3|
Lee Sung Min |    3|
Yoo Joon Sang|    3|
*/

/* Count the number of genres */
WITH genre_split AS(
SELECT
	SPLIT_PART("genre"::TEXT, ', ', generate_series(1, 4)) AS genres
FROM top100_kdrama)
SELECT genres, COUNT(genres)
FROM genre_split
WHERE genres != ''
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

/*
genres       |count|
-------------+-----+
Drama        |   63|
Romance      |   45|
Thriller     |   33|
Mystery      |   31|
Comedy       |   28|
Life         |   22|
Action       |   21|
Melodrama    |   17|
Fantasy      |   15|
Historical   |   15|
Crime        |   12|
Psychological|   11|
Law          |   11|
Political    |   11|
Supernatural |    8|
Medical      |    7|
Horror       |    6|
Sci-Fi       |    5|
Youth        |    4|
Military     |    3|
*/

/* Count the number of tags */
WITH tags_split AS(
SELECT
	SPLIT_PART("tags"::TEXT, ', ', generate_series(1, 13)) AS tags
FROM top100_kdrama)
SELECT tags, COUNT(tags)
FROM tags_split
WHERE tags != ''
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

/*
tags                   |count|
-----------------------+-----+
Strong Female Lead     |   40|
Bromance               |   23|
Murder                 |   21|
Smart Female Lead      |   20|
Nice Male Lead         |   19|
Death                  |   16|
Smart Male Lead        |   16|
Investigation          |   15|
Character Development  |   13|
Power Struggle         |   13|
Revenge                |   13|
Suspense               |   13|
Strong Male Lead       |   12|
Multiple Mains         |   12|
Hardworking Female Lead|   12|
Corruption             |   12|
Multiple Couples       |   10|
Healing                |    9|
Hardworking Male Lead  |    9|
Trauma                 |    9|
*/

/* Number of watchers by year & days of week */
SELECT 
	CASE WHEN start_date = '10-Jun-17' THEN DATE_PART('Year', TO_DATE(start_date, 'DD-Mon-YY'))
		ELSE DATE_PART('Year', TO_DATE(start_date, 'MM/DD/YYYY'))
	END AS year, day_aired,
	SUM(TO_NUMBER(watchers, '99,999')) AS total_watchers, ROUND(SUM(score::numeric), 2) AS total_score
FROM top100_kdrama
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;

/*
year  |day_aired               |total_watchers|total_score|
------+------------------------+--------------+-----------+
2023.0|Friday                  |         42651|      17.70|
2022.0|Saturday, Sunday        |        268904|      61.80|
2022.0|Monday, Tuesday         |        132259|      26.00|
2022.0|Friday, Saturday        |        126006|      34.90|
2022.0|Friday                  |        113347|      43.80|
2022.0|Wednesday, Thursday     |         71227|       9.00|
2022.0|Friday, Saturday, Sunday|         31307|       8.60|
2021.0|Friday, Saturday        |        208104|      44.00|
2021.0|Friday                  |        169727|      26.70|
2021.0|Monday, Tuesday         |        167327|      35.30|
2021.0|Saturday, Sunday        |        128474|      26.50|
2021.0|Wednesday, Thursday     |         86637|      17.40|
2021.0|Thursday                |         43574|       9.10|
2020.0|Saturday, Sunday        |        180911|      52.50|
2020.0|Monday, Tuesday         |        144088|      26.10|
2020.0|Friday                  |        111823|      17.60|
2020.0|Wednesday, Thursday     |         94811|       9.10|
2020.0|Thursday                |         81568|       9.10|
2019.0|Saturday, Sunday        |         97247|      34.70|
2019.0|Friday                  |         58560|       8.80|
2019.0|Friday, Saturday        |         46216|      17.40|
2019.0|Monday, Tuesday         |         22024|      17.30|
2019.0|Sunday, Saturday        |          1463|       9.00|
2018.0|Wednesday, Thursday     |        135635|      35.30|
2018.0|Saturday, Sunday        |        107794|      26.40|
2018.0|Friday, Saturday        |         60782|       8.90|
2018.0|Monday, Tuesday         |         59433|       8.60|
2017.0|Saturday, Sunday        |        114349|      26.00|
2017.0|Wednesday, Thursday     |        100471|      26.30|
2017.0|Friday, Saturday        |         95595|      26.00|
2017.0|Monday, Tuesday         |         27877|       8.70|
2016.0|Friday, Saturday        |         83830|      26.40|
2016.0|Monday, Tuesday         |         55652|      17.40|
2016.0|Wednesday, Thursday     |          3257|      17.40|
2015.0|Wednesday, Thursday     |         99839|       8.70|
2015.0|Friday, Saturday        |         85986|       9.10|
2015.0|Monday, Tuesday         |         22241|       8.80|
2014.0|Wednesday, Thursday     |         80709|       8.60|
2014.0|Friday, Saturday        |         29448|       8.70|
2014.0|Monday, Tuesday         |          1250|       8.90|
2013.0|Monday, Tuesday         |         61713|      17.20|
2012.0|Wednesday, Thursday     |         27881|       8.60|
2003.0|Monday, Tuesday         |         16545|       8.60|
*/

/* Number of watchers by year & number of episodes */
SELECT 
	CASE WHEN start_date = '10-Jun-17' THEN DATE_PART('Year', TO_DATE(start_date, 'DD-Mon-YY'))
		ELSE DATE_PART('Year', TO_DATE(start_date, 'MM/DD/YYYY'))
	END AS year, episodes,
	SUM(TO_NUMBER(watchers, '99,999')) AS total_watchers, ROUND(SUM(score::numeric), 2) AS total_score
FROM top100_kdrama
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;

/*
year  |episodes|total_watchers|total_score|
------+--------+--------------+-----------+
2023.0|      10|         22953|       8.70|
2023.0|       8|         19698|       9.00|
2022.0|      16|        344329|      70.10|
2022.0|      12|        168989|      43.30|
2022.0|      20|         86438|      17.80|
2022.0|       8|         72871|      18.00|
2022.0|      10|         55884|      17.60|
2022.0|       6|          9505|       8.60|
2022.0|      14|          5034|       8.70|
2021.0|      16|        343480|      61.20|
2021.0|      12|        181484|      35.80|
2021.0|       8|         65658|       8.70|
2021.0|      10|         64103|       9.20|
2021.0|      20|         46943|      17.80|
2021.0|       6|         39966|       8.80|
2021.0|      17|         31967|       8.80|
2021.0|      13|         30242|       8.70|
2020.0|      16|        280848|      52.80|
2020.0|      12|         96070|      17.70|
2020.0|      10|         75786|       8.70|
2020.0|      20|         66296|       9.00|
2020.0|      21|         46029|       8.70|
2020.0|       6|         36037|       8.90|
2020.0|     100|         12135|       8.60|
2019.0|       6|        100000|      26.20|
2019.0|      10|         54461|       8.70|
2019.0|      16|         37209|      34.90|
2019.0|      40|         25291|       8.70|
2019.0|      32|          8549|       8.70|
2018.0|      16|        146459|      35.50|
2018.0|      20|        120215|      17.50|
2018.0|      24|         61076|       8.90|
2018.0|      18|         20652|       8.70|
2018.0|      32|         15242|       8.60|
2017.0|      16|        210264|      43.80|
2017.0|      12|         37662|       8.60|
2017.0|      20|         33728|       8.60|
2017.0|      18|         27877|       8.70|
2017.0|      52|         27397|       8.60|
2017.0|      32|          1364|       8.70|
2016.0|      16|         87087|      43.80|
2016.0|      20|         55652|      17.40|
2015.0|      20|        185825|      17.80|
2015.0|      50|         22241|       8.80|
2014.0|      16|         80709|       8.60|
2014.0|      20|         30698|      17.60|
2013.0|      51|         38050|       8.60|
2013.0|      20|         23663|       8.60|
2012.0|      28|         27881|       8.60|
2003.0|      54|         16545|       8.60|
*/

/* Number of watchers by year & duration per episode in minutes */
SELECT 
	CASE WHEN start_date = '10-Jun-17' THEN DATE_PART('Year', TO_DATE(start_date, 'DD-Mon-YY'))
		ELSE DATE_PART('Year', TO_DATE(start_date, 'MM/DD/YYYY'))
	END AS year, duration,
	SUM(TO_NUMBER(watchers, '99,999')) AS total_watchers, ROUND(SUM(score::numeric), 2) AS total_score
FROM top100_kdrama
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;

/*
year  |duration|total_watchers|total_score|
------+--------+--------------+-----------+
2023.0|      52|         22953|       8.70|
2023.0|      55|         19698|       9.00|
2022.0|      60|        181937|      43.50|
2022.0|      75|        132959|      26.00|
2022.0|      70|         89154|      35.10|
2022.0|      77|         71227|       9.00|
2022.0|      80|         58576|       9.10|
2022.0|      71|         43057|       8.60|
2022.0|      50|         40456|       8.90|
2022.0|      81|         33116|       9.00|
2022.0|      40|         32415|       9.10|
2022.0|      67|         29182|       8.60|
2022.0|      62|         22768|       8.60|
2022.0|      55|          8203|       8.60|
2021.0|      65|        223462|      44.10|
2021.0|      75|        144245|      35.10|
2021.0|      80|        113923|      17.50|
2021.0|      50|        105624|      17.50|
2021.0|      60|         65303|       8.70|
2021.0|      52|         64103|       9.20|
2021.0|     100|         43574|       9.10|
2021.0|      70|         42475|       8.80|
2021.0|      85|          1134|       9.00|
2020.0|      70|        276213|      43.90|
2020.0|      90|         81568|       9.10|
2020.0|      52|         75786|       8.70|
2020.0|      75|         67803|      17.90|
2020.0|      85|         46029|       8.70|
2020.0|      45|         36037|       8.90|
2020.0|      62|         17630|       8.60|
2020.0|      35|         12135|       8.60|
2019.0|      51|         58560|       8.80|
2019.0|      60|         54461|       8.70|
2019.0|      35|         33840|      17.40|
2019.0|      81|         21972|       8.70|
2019.0|      62|         20925|       8.70|
2019.0|      80|         20814|      17.30|
2019.0|      74|         13475|       8.60|
2019.0|      85|          1463|       9.00|
2018.0|      65|         85499|      17.40|
2018.0|      75|         81434|      17.60|
2018.0|      80|         61076|       8.90|
2018.0|      77|         60644|       9.00|
2018.0|      67|         30765|       8.70|
2018.0|      63|         28984|       9.00|
2018.0|      30|         15242|       8.60|
2017.0|      70|        170869|      34.80|
2017.0|      92|         65379|       9.00|
2017.0|      64|         37763|       8.60|
2017.0|      60|         33728|       8.60|
2017.0|      66|         27397|       8.60|
2017.0|      67|          1792|       8.70|
2017.0|      30|          1364|       8.70|
2016.0|      75|         70090|       8.90|
2016.0|      60|         58909|      34.80|
2016.0|      70|         11811|       8.70|
2016.0|      82|          1929|       8.80|
2015.0|      62|         99839|       8.70|
2015.0|      95|         85986|       9.10|
2015.0|      60|         22241|       8.80|
2014.0|      60|         81959|      17.50|
2014.0|      80|         29448|       8.70|
2013.0|      65|         38050|       8.60|
2013.0|      60|         23663|       8.60|
2012.0|      65|         27881|       8.60|
2003.0|      65|         16545|       8.60|
*/