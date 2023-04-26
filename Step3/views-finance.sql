-- DROP VIEW IF EXISTS FinScores;
CREATE VIEW FinScores AS
SELECT Countries.countryName, ROUND(AVG(GDP*giniCoefficient),0) as fin
FROM CountriesHaveFinancialStatus fin_stat
JOIN Countries ON Countries.IsoCode = fin_stat.isoCode
GROUP BY Countries.isoCode;

-- DROP VIEW IF EXISTS BestFinCountries;
CREATE VIEW BestFinCountries AS
SELECT * FROM FinScores
ORDER BY fin DESC
LIMIT 20;

-- DROP VIEW IF EXISTS WorstFinCountries;
CREATE VIEW WorstFinCountries AS
SELECT * FROM FinScores
ORDER BY fin ASC
LIMIT 20;
