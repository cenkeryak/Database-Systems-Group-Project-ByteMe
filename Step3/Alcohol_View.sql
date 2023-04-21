CREATE VIEW High_Alcohol_Rate AS
SELECT CountryIsoCode,year,alcoholRate
FROM alcoholanddrugdisorder
WHERE alcoholRate > 3;

