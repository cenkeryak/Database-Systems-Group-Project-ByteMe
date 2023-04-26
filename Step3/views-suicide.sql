CREATE VIEW HighSuicideRate AS
SELECT c.countryName, AVG(s.rate) as avg_suicide_rate
FROM Countries c
JOIN Suicide s ON c.isoCode = s.IsoCode
GROUP BY c.isoCode, c.countryName
ORDER BY avg_suicide_rate DESC
LIMIT 20;


CREATE VIEW LowSuicideRate AS
SELECT c.countryName, AVG(s.rate) as avg_suicide_rate
FROM Countries c
JOIN Suicide s ON c.isoCode = s.IsoCode
GROUP BY c.isoCode, c.countryName
ORDER BY avg_suicide_rate ASC
LIMIT 20;
