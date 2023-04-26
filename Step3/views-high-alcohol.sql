Create View High_Alcohol_Rate AS
Select c.isoCode,c.countryName,avg(A2.alcoholRate) as average_alcohol
FROM alcoholanddrugdisorder A2, countries c
where c.isoCode = A2.isoCode
GROUP BY A2.isoCode
ORDER BY average_alcohol DESC
LIMIT 20;
