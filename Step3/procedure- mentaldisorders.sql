-- The below procedure offers a search with the isoCode only and returns the isoCode, average, minimum and maximum
-- prevalences of value of inputted country. Thus offers to observe whether a significant change occured
-- or not in that country.
DELIMITER //
CREATE PROCEDURE get_minmaxavg_prevalence_country (IN isoCode varchar(10))
BEGIN 
	SELECT mdisorders.isoCode, MIN(mentalDisordersPrevalence), AVG(mentalDisordersPrevalence), MAX(mentalDisordersPrevalence)
    FROM havingpeoplewithmentaldisorders mdisorders
    WHERE mdisorders.isoCode = isoCode
    GROUP BY mdisorders.isoCode;
    
END //
DELIMITER ;

CALL get_minmaxavg_prevalence_country("TUR");