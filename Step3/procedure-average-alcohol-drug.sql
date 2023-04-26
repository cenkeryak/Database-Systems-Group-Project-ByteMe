DELIMITER //
CREATE PROCEDURE get_avg_alcohol_drug (IN isoCode varchar(5))
BEGIN 
	SELECT C.isoCode, C.countryName, AD.Average_Alcohol, AD.Average_Drug
    FROM Average_AlcoholDrug AD, countries C
    WHERE C.isoCode = AD.isoCode AND AD.isoCode = isoCode;

    
END //
DELIMITER ;

CALL get_avg_alcohol_drug("TUR");
