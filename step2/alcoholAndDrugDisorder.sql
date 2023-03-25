CREATE TABLE AlcoholAndDrugDisorder(
CountryIsoCode VARCHAR(10) NOT NULL,
 year INTEGER NOT NULL,
 alcoholRate float,
 drugRate float,
 PRIMARY KEY (CountryIsoCode, year),
 FOREIGN KEY (CountryIsoCode) REFERENCES countries(isoCode) ON DELETE CASCADE
 
);
