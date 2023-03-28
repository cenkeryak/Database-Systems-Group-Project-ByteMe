CREATE TABLE TemporaryFinancialStatus (
    name VARCHAR(50),
    year INT NOT NULL,
    giniCoefficient FLOAT,
    GDP FLOAT,
    PRIMARY KEY (name, year)
);

-- import data using table data import wizard

ALTER TABLE TemporaryFinancialStatus
ADD COLUMN isoCode VARCHAR(10);

UPDATE TemporaryFinancialStatus, Countries
SET TemporaryFinancialStatus.isoCode = Countries.isoCode
WHERE TemporaryFinancialStatus.name = Countries.countryName;

CREATE TABLE CountriesHaveFinancialStatus (
    isoCode VARCHAR(10),
    year INT NOT NULL,
    GDP FLOAT,
    giniCoefficient FLOAT,
    PRIMARY KEY (isoCode, year),
    FOREIGN KEY (isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE
);

INSERT INTO CountriesHaveFinancialStatus (isoCode, year, GDP, giniCoefficient)
SELECT isoCode, year, GDP, giniCoefficient
FROM TemporaryFinancialStatus;

DROP TABLE TemporaryFinancialStatus;