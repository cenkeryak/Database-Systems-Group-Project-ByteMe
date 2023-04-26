-- Countries with both gini and gdp better than the average
SELECT isoCode, ROUND(AVG(GDP),0), ROUND(AVG(giniCoefficient),2)
FROM CountriesHaveFinancialStatus
GROUP BY isoCode
HAVING AVG(GDP) > 
	(SELECT AVG(GDP) FROM CountriesHaveFinancialStatus)
INTERSECT		
SELECT isoCode, ROUND(AVG(GDP),0), ROUND(AVG(giniCoefficient),2)
FROM CountriesHaveFinancialStatus
GROUP BY isoCode
HAVING AVG(giniCoefficient) < 
	(SELECT AVG(giniCoefficient) FROM CountriesHaveFinancialStatus);
    
-- DROP VIEW IF EXISTS WorstFin;
CREATE VIEW WorstFin AS
SELECT * FROM FinScores
WHERE fin = (SELECT min(fin) FROM FinScores);

-- DROP VIEW IF EXISTS BestFin;
CREATE VIEW BestFin AS
SELECT * FROM FinScores
WHERE fin = (SELECT max(fin) FROM FinScores);
