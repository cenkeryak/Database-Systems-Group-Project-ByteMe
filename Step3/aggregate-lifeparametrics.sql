CREATE VIEW  countries_with_avgLifeExp AS
SELECT isoCode,AVG(lifeExpectancy) as avgLifeExp from CountriesPossessLifeParametrics 
GROUP BY isoCode;


SELECT isoCode, avgLifeExp FROM countries_with_avgLifeExp
WHERE avgLifeExp IN
	(SELECT  MIN(avgLifeExp)
 	FROM countries_with_avgLifeExp exp1
WHERE exp1.isoCode IN 	

		(SELECT exp2.isoCode  
FROM CountriesPossessLifeParametrics exp2
		GROUP BY exp2.isoCode
		HAVING COUNT(year)>10));

                    
                    
SELECT isoCode, avgLifeExp FROM countries_with_avgLifeExp
WHERE avgLifeExp in

	(SELECT  MAX(avgLifeExp)
FROM countries_with_avgLifeExp exp1
	WHERE exp1.isoCode in 	

		(SELECT exp2.isoCode  
        		FROM CountriesPossessLifeParametrics exp2
		GROUP BY exp2.isoCode
		HAVING COUNT(year)>10));
