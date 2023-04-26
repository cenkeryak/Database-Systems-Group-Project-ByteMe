-- AVERAGE of years of Alcohol Prevelance of The Countries
Create View Average_Alcohol AS
Select A2.isoCode,avg(A2.alcoholRate) as average_alcohol
FROM alcoholanddrugdisorder A2
GROUP BY A2.isoCode;

-- AVERAGE of years of Drug Prevelance of The Countries
Create View Average_Drug AS
SELECT A1.isoCode,avg(A1.drugRate) as average_drug
FROM alcoholanddrugdisorder A1
GROUP BY A1.isoCode;

-- AVERAGE of years of Alcohol and Drug Prevelance of The Countries
Create View Average_AlcoholDrug AS
SELECT isoCode,Average_Alcohol,Average_Drug
FROM Average_Alcohol
NATURAL JOIN Average_Drug;

select * From Average_AlcoholDrug;
