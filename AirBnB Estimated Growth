DATASOURCE- https://www.kaggle.com/datasets/oindrilasen/la-airbnb-listings/discussion?resource=download

Download the file and migrate into SSMS with SQL Server 2019 Import and Export Data
Source- Excel
Destination- SQL Server Native Client 11
Select a DB and load.

QUESTION- Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. The rate of growth is calculated by taking ((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.


	
  ----Final calculation happens here
  SELECT YearExtracted, 
			Current_year_host,
			Prev_year_host,
			 Current_year_host - Prev_year_host  YearDifference,
			((ROUND ((Current_year_host - Prev_year_host),2))/(CAST( Prev_year_host AS int))) *100 AS Estimated_Growth
		                             
			FROM
--gives the previous year count with the sub-query
		( SELECT YearExtracted, Current_year_host,              
					LAG ( Current_year_host, 1) OVER 
					(ORDER BY YearExtracted) AS Prev_year_host

			FROM
      
 --Extracts Year from Host_since field
 --Counts #hosts grouped by year

		(SELECT YEAR(host_since) AS YearExtracted, 
				COUNT(Id) Current_year_host					
				FROM [dbo].[FactAirBnB]
				WHERE [host_since] IS NOT NULL
				GROUP BY YEAR (host_since)
				) G
				) G2
