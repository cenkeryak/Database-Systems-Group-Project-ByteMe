CREATE VIEW lowExpAndLowSat AS
SELECT lp1.isoCode, AVG(lifeSatisfaction) AS avgLifeSatisfaction
FROM CountriesPossessLifeParametrics lp1
WHERE lp1.isoCode IN   (SELECT lp2.isoCode
				FROM CountriesPossessLifeParametrics lp2
				GROUP BY lp2.isoCode
				HAVING AVG(lifeExpectancy)<60)
GROUP BY lp1.isoCode
HAVING avgLifeSatisfaction < 4.5;




CREATE VIEW highExpAndHighSat AS
SELECT lp1.isoCode, AVG(lifeSatisfaction) AS avgLifeSatisfaction
FROM CountriesPossessLifeParametrics lp1
WHERE lp1.isoCode IN   (SELECT lp2.isoCode
				FROM CountriesPossessLifeParametrics lp2
				GROUP BY lp2.isoCode
				HAVING AVG(lifeExpectancy)>80)
GROUP BY lp1.isoCode
HAVING avgLifeSatisfaction > 6.5;
