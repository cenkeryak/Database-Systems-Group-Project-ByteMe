DELIMITER //
CREATE PROCEDURE get_country_avg(IN isoCode varchar(10)) 
BEGIN

SELECT lp.isoCode, COUNT(year) as numberOfYearData, AVG(lifeSatisfaction) as avgLifeSatisfaction, AVG(lifeExpectancy) as avgLifeExpectancy
    
FROM CountriesPossessLifeParametrics lp
	WHERE lp.isoCode=isoCode
    	GROUP BY lp.isoCode;


END //
DELIMITER ;


CALL get_country_avg("USA");
CALL get_country_avg("TUR");


