
SELECT lp1.isoCode, AVG(lifeSatisfaction) AS avgLifeSatisfaction
FROM CountriesPossessLifeParametrics lp1
WHERE lp1.isoCode IN (SELECT lp2.isoCode
				FROM CountriesPossessLifeParametrics lp2
				GROUP BY lp2.isoCode
				HAVING AVG(lifeExpectancy)<60)
GROUP BY lp1.isoCode
HAVING avgLifeSatisfaction < 4.5;


SELECT lp1.isoCode, AVG(lifeSatisfaction) AS avgLifeSatisfaction
FROM CountriesPossessLifeParametrics lp1
WHERE EXISTS  (SELECT lp2.isoCode
				FROM CountriesPossessLifeParametrics lp2
               			 WHERE lp2.isoCode=lp1.isoCode
				GROUP BY lp2.isoCode
				HAVING AVG(lifeExpectancy)<60)
GROUP BY lp1.isoCode
HAVING avgLifeSatisfaction < 4.5;
