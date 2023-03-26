CREATE TABLE Countries (
isoCode VARCHAR(10),
countryName VARCHAR(50) NOT NULL,
cCode VARCHAR(10) NOT NULL,
PRIMARY KEY (isoCode),
FOREIGN KEY (cCode) REFERENCES Continents(cCode)
);
