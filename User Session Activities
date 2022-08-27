--SOURCE- https://datalemur.com
--Assume you are given the table below containing information on user session activity. 
--Write a query that ranks users according to their total session durations (in minutes) by descending order 
--for each session type between the start date (2022-01-01) and end date (2022-02-01). 
--Output the user id, session type, and the ranking of the total session duration.


--SAMPLE OF DATA N THE TABLE
--session_id	user_id	session_type	duration	start_date
--6368	111	like	3	12/25/2021 12:00:00
--1742	111	retweet	6	01/02/2022 12:00:00
--8464	222	reply	8	01/16/2022 12:00:00
--7153	111	retweet	5	01/28/2022 12:00:00
--3252	333	reply	15	01/10/2022 12:00:00


--USING DENSE RANK w/ PARTITION BY

SELECT user_id, session_type,
DENSE_RANK() OVER (PARTITION BY session_type ORDER BY SUM(duration) DESC) ranking
FROM sessions
WHERE start_date >= '2022-01-01' 
AND start_date <= '2022-02-02'
GROUP BY user_id, session_type
ORDER BY session_type, ranking

--USING CTE
WITH user_duration AS (
  SELECT 
    user_id, 
    session_type, 
    SUM(duration) AS total_duration 
  FROM 
    sessions 
  WHERE 
    start_date >= '2022-01-01' 
    AND start_date <= '2022-02-01' 
  GROUP BY 
    user_id,
    session_type
) 

SELECT 
  user_id, 
  session_type, 
  RANK() OVER (
    PARTITION BY session_type 
    ORDER BY total_duration DESC
  ) AS ranking 
FROM 
  user_duration 
ORDER BY 
  session_type, 
  ranking;
