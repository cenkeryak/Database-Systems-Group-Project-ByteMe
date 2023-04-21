CREATE VIEW High_Drug_Rate AS
SELECT CountryIsoCode,year,drugRate
FROM alcoholanddrugdisorder
WHERE drugrate > 1;

Select * from High_Drug_Rate;