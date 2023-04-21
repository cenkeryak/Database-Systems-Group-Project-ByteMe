CREATE VIEW High_AlcoholDrug_Rate AS
SELECT Drug.CountryIsoCode,Drug.year,Alcohol.alcoholRate,Drug.drugRate
FROM High_Drug_Rate Drug
INNER JOIN High_Alcohol_Rate Alcohol ON Drug.CountryIsoCode = Alcohol.CountryIsoCode;

SELECT * from High_AlcoholDrug_Rate