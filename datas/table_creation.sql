
set global local_infile=true;
drop table if exists Suicide;
drop table if exists CountriesHaveFinancialStatus;
drop table if exists havingPeopleWithMentalDisorders;
drop table if exists AlcoholAndDrugDisorder;
drop table if exists CountriesPossessLifeParametrics;
drop table if exists Countries;
drop table if exists Continents;

/*
-- change base_path accordingly
SET @base_path = "C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\Step3\\datas - Copy";
SET @Continents_path = CONCAT(@base_path, "\\continents with continent_codes.csv");
SET @Countries_path = CONCAT(@base_path, "\\countries_continents.csv");
SET @LifeParametrics_path = CONCAT(@base_path, "\\life_parametrics.csv");
SET @AlcoholAndDrugDisorder_path = CONCAT(@base_path, "\\share-with-alcohol-vs-drug-use-disorder.csv");
SET @MentalHealth_path = CONCAT(@base_path, "\\prevalence by specific mental disorders and substance use disorder UPDATED.csv");
SET @FinancialStatus_path = CONCAT(@base_path, "\\financial-status.csv");
SET @SuicideDeath_path = CONCAT(@base_path, "\\suicide-death-rates.csv");

drop table if exists path;
create table path(col1 VARCHAR(500), primary key(col1));
insert into path (col1) Values (@Continents_path);
Select * from path;
*/

CREATE TABLE Continents (
	cName VARCHAR(30) NOT NULL,
	cCode VARCHAR(10),
	PRIMARY KEY (cCode)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\continents with continent_codes.csv'
INTO TABLE Continents
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(cName, cCode);

CREATE TABLE Countries (
	isoCode VARCHAR(10),
	countryName VARCHAR(50) NOT NULL,
	cCode VARCHAR(10) NOT NULL,
	PRIMARY KEY (isoCode),
	FOREIGN KEY (cCode) REFERENCES Continents(cCode)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\countries_continents.csv'
INTO TABLE Countries
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(isoCode, countryName, @skip, cCode);

CREATE TABLE CountriesPossessLifeParametrics (
    isoCode VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    lifeSatisfaction DOUBLE,
    lifeExpectancy DOUBLE,
    PRIMARY KEY (isoCode , year),
    FOREIGN KEY (isoCode)
        REFERENCES Countries (isoCode)
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\life_parametrics.csv'
INTO TABLE CountriesPossessLifeParametrics
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@skip, isoCode, year, @skip, lifeSatisfaction, lifeExpectancy);

CREATE TABLE havingPeopleWithMentalDisorders (
    isoCode VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    schizophreniaPrevalence DOUBLE,
    bipolarPrevalence DOUBLE,
    eatingDisorderPrevalence DOUBLE,
    anxietyPrevalence DOUBLE,
    drugUsePrevalence DOUBLE,
    depressiveDisordersPrevalence DOUBLE,
    alcoholUsePrevalence DOUBLE,
    mentalDisordersPrevalence DOUBLE,
    PRIMARY KEY (isoCode , year),
    FOREIGN KEY (isoCode)
        REFERENCES Countries (isoCode)
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\prevalence by specific mental disorders and substance use disorder UPDATED.csv'
INTO TABLE havingPeopleWithMentalDisorders
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(isoCode, year, schizophreniaPrevalence, bipolarPrevalence, eatingDisorderPrevalence, anxietyPrevalence, drugUsePrevalence, depressiveDisordersPrevalence, alcoholUsePrevalence, mentalDisordersPrevalence);

CREATE TABLE AlcoholAndDrugDisorder (
    isoCode VARCHAR(10) NOT NULL,
    year INTEGER NOT NULL,
    alcoholRate FLOAT,
    drugRate FLOAT,
    PRIMARY KEY (IsoCode , year),
    FOREIGN KEY (IsoCode)
        REFERENCES countries (isoCode)
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\Share-with-alcohol-vs-drug-use-disorder.csv'
INTO TABLE AlcoholAndDrugDisorder
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@skip, isoCode, year, alcoholRate, drugRate);

CREATE TABLE TemporaryFinancialStatus (
    name VARCHAR(50),
    year INT NOT NULL,
    giniCoefficient FLOAT,
    GDP FLOAT,
    PRIMARY KEY (name , year)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\financial-status.csv'
INTO TABLE TemporaryFinancialStatus
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(name, year, giniCoefficient, GDP);

ALTER TABLE TemporaryFinancialStatus ADD COLUMN isoCode VARCHAR(10);
UPDATE TemporaryFinancialStatus, Countries SET TemporaryFinancialStatus.isoCode = Countries.isoCode WHERE TemporaryFinancialStatus.name = Countries.countryName;
DELETE FROM TemporaryFinancialStatus WHERE isoCode IS NULL;
CREATE TABLE CountriesHaveFinancialStatus ( isoCode VARCHAR(10), year INT NOT NULL, GDP FLOAT, giniCoefficient FLOAT, PRIMARY KEY (isoCode, year), FOREIGN KEY (isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE );
INSERT INTO CountriesHaveFinancialStatus (isoCode, year, GDP, giniCoefficient) SELECT isoCode, year, GDP, giniCoefficient FROM TemporaryFinancialStatus;
DROP TABLE IF EXISTS TemporaryFinancialStatus;

CREATE TABLE Suicide (
    isoCode VARCHAR(10) NOT NULL,
    year INTEGER NOT NULL,
    rate FLOAT,
    share FLOAT,
    PRIMARY KEY (IsoCode , year),
    FOREIGN KEY (IsoCode)
        REFERENCES countries (isoCode)
        ON DELETE CASCADE
);

LOAD DATA LOCAL INFILE 'C:\\Users\\alpay\\Desktop\\Database-Systems-Group-Project-ByteMe-main\\datas\\suicide_data.csv'
INTO TABLE Suicide
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@skip, isoCode, year, rate, share);
