--DATASOURCE- https://www.kaggle.com/datasets/oindrilasen/la-airbnb-listings/discussion?resource=download

--QUESTION- You’re given a table of rental property searches by users. The table consists of search results and outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below:
--0 reviews: New
--1 to 5 reviews: Rising
--6 to 15 reviews: Trending Up
--16 to 40 reviews: Popular
--more than 40 reviews: Hot


WITH Hosts as 
(
   SELECT DISTINCT
      concat(price, room_type, host_since, zipcode, number_of_reviews) AS host_idd,
      number_of_reviews,
      price,
      CASE
         WHEN number_of_reviews = 0 THEN 'New' 
         WHEN number_of_reviews BETWEEN 1 and 5 THEN 'Rising' 
         WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up' 
         WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular' 
         WHEN number_of_reviews > 40 THEN 'Rising' 
         ELSE
            'No Category' 
      END HostPopularity 
   FROM
      FactAirBnB 
   GROUP BY
      concat(price, room_type, host_since, zipcode, number_of_reviews), number_of_reviews, price
)
SELECT
   HostPopularity,
   MIN(price) min_price,
   MAX(price) max_price,
   ROUND(AVG(price), 2) avg_price 
FROM
   Hosts 
GROUP BY
   HostPopularity
