SELECT lp1.isoCode
FROM CountriesPossessLifeParametrics lp1
GROUP BY lp1.isoCode
HAVING AVG(lifeExpectancy)<60

INTERSECT 

SELECT lp2.isoCode
FROM CountriesPossessLifeParametrics lp2
GROUP BY lp2.isoCode
HAVING AVG(lifeSatisfaction)>6.5;







SELECT lp1.isoCode
FROM CountriesPossessLifeParametrics lp1
GROUP BY lp1.isoCode
HAVING AVG(lifeExpectancy)>80

INTERSECT 

SELECT lp2.isoCode
FROM CountriesPossessLifeParametrics lp2
GROUP BY lp2.isoCode
HAVING AVG(lifeSatisfaction)<4.5
