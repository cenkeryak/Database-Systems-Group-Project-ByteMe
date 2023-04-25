-- These statements display the isoCode, average drug use prevalence, and average mental disorders prevalence of the countries
-- where both drug use prevalence and mental disorders prevalence are greater than the average. 
-- Therefore, they help to identify whether there is a strong correlation between drug use and mental disorders or not.
SELECT isoCode, AVG(drugUsePrevalence), AVG(mentalDisordersPrevalence)
FROM havingpeoplewithmentaldisorders
GROUP BY isoCode
HAVING AVG(drugUsePrevalence) > 
	(SELECT AVG(drugUsePrevalence)
    FROM havingpeoplewithmentaldisorders)
INTERSECT		
SELECT isoCode, AVG(drugUsePrevalence), AVG(mentalDisordersPrevalence)
FROM havingpeoplewithmentaldisorders
GROUP BY isoCode
HAVING AVG(mentalDisordersPrevalence) > 
	(SELECT AVG(mentalDisordersPrevalence)
	FROM havingpeoplewithmentaldisorders);