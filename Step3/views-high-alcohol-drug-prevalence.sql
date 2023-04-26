CREATE VIEW High_AlcoholDrug_Rate AS
SELECT Drug.isoCode, Drug.countryName, Alcohol.average_alcohol, Drug.average_drug
FROM High_Drug_Rate Drug
INNER JOIN High_Alcohol_Rate Alcohol ON Drug.isoCode = Alcohol.isoCode;
