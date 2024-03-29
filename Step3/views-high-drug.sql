Create View High_Drug_Rate AS
Select c.isoCode, c.countryName,avg(A2.drugRate) as average_drug
FROM alcoholanddrugdisorder A2, countries c
where c.isoCode = A2.isoCode
GROUP BY A2.isoCode
ORDER BY average_drug DESC
LIMIT 20;
