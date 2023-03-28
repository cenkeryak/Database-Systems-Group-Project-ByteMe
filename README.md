# Database-Systems-Group-Project-ByteMe
CS306 Project Step 2 Document

Group Name: Byte Me

Group Members:

Alpay Naçar - 31133
Anıl Şen - 29556
Bahadır Yazıcı - 30643
Cenker Yakışır - 28831
Hasan Fırat Yılmaz - 29002

Github link: https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe


Entity 1. Continents

Initially, in the “countries_continents.csv” file, columns representing country name and iso code were dropped and later on through the deletion of duplicates on the rest of the continent name and continent code columns, “continents with continent_codes.csv” was formed. 
Then, in mySQL table for continents was created as shown below,

CREATE TABLE Continents ( 
cName VARCHAR(30) NOT NULL,
 cCode VARCHAR(10),
 PRIMARY KEY (cCode)
 );

After this, “continents with continent_codes.csv” is imported into the Continents table.

Each continent has to include at least a country as a result of the participation constraint.


Entity 2. Countries

“countries_continents.csv” file, after it’s continent name was excluded for importation, was ready to be imported into the Countries table as shown below,

CREATE TABLE Countries ( 
isoCode VARCHAR(10),
 countryName VARCHAR(50) NOT NULL,
 cCode VARCHAR(10) NOT NULL,
 PRIMARY KEY (isoCode),
 FOREIGN KEY (cCode) REFERENCES Continents(cCode)
 );

Here, the Include relationship is shown through the usage of foreign key referring to the cCode in Continents table, which represents countries’ respective continent codes.

Each country has at most one continent to be included by, according to the key constraint on Include relationship and every country has to be included by a continent due to participation constraint.


Entity 3.  Life Parametrics

Following the creation of the CountriesPossessLifeParametrics table, “life_parametrics.csv” was imported into it without its column representing country names.

CREATE TABLE CountriesPossessLifeParametrics( 
 isoCode VARCHAR(10) NOT NULL,
 year int NOT NULL,
 lifeSat DOUBLE,
 lifeSatisfaction DOUBLE,
 lifeExpectancy DOUBLE,
 PRIMARY KEY(isoCode,year), 
 FOREIGN KEY(isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE );

Due to having issues in truncating decimal values in life satisfaction value in Excel, there were two columns related to the same attribute; lifeSat and lifeSatisfaction. To cope with, the below statement is implemented to drop the column lifeSat, which has the untruncated version of decimals.

ALTER TABLE countriesPossessLifeParametrics DROP COLUMN lifeSat;

Furthermore, the Possess relationship was achieved onto one table as a result of the one-to-many relationship through the unique identifiers, isoCode and year pairs.

As a result of the features of being a weak entity for this entity, each life parametric has at most one country to be possessed, indicating a key constraint. And every life parametric has to be possessed by a country, due to the participation constraint.


Entity 4.  Mental Health

Following the creation of the havingPeopleWithMentalDisorders table, “prevalence by specific mental disorders and substance use disorder UPDATED.csv” was imported into it.

CREATE TABLE havingPeopleWithMentalDisorders(
isoCode VARCHAR(10) NOT NULL,
year int NOT NULL,
schizophreniaPrevalence DOUBLE,
bipolarPrevalence DOUBLE,
eatingDisorderPrevalence DOUBLE,
anxietyPrevalence DOUBLE,
drugUsePrevalence DOUBLE,
depressiveDisordersPrevalence DOUBLE,
alcoholUsePrevalence DOUBLE,
mentalDisordersPrevalence DOUBLE,
PRIMARY KEY (isoCode, year),
FOREIGN KEY (isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE
);

First of all, the column that contains country names is removed from the CSV file due to the redundancy it causes. Moreover, some rows in the "prevalence of mental health disorders" excel file didn't have iso_code values, like the "AFRICAN REGION" row, which didn't have any iso_code. We removed those rows. In addition to that, some countries that were in the "prevalence of mental health disorders" file didn't exist in the "countries_continents" file. We removed the rows with data from those countries to avoid conflicts with the foreign key constraint.


Entity 5.  Alcohol and Drug Disorder

 “Share-with-alcohol-vs-drug-use-disorder.csv” file is imported into the AlcoholAndDrugDisorder table.

 CREATE TABLE AlcoholAndDrugDisorder(
  isoCode VARCHAR(10) NOT NULL,
 year INTEGER NOT NULL,
 alcoholRate float,
 drugRate float,
 PRIMARY KEY (CountryIsoCode, year),
 FOREIGN KEY (CountryIsoCode) REFERENCES countries(isoCode) ON DELETE CASCADE );

Some rows of csv files didn’t have ISO code because they don’t have their own ISO Code. For example “Western Pacific Region” does not have ISO code. Therefore, we removed these rows from the dataset before importing it to the table.


Entity 6.  Financial Status

In my excel file, there are country names in place of iso codes. In the table, instead of country names, there should be iso codes corresponding to those country names. To handle this issue, firstly created a temporary table with name and year as the primary keys.

CREATE TABLE TemporaryFinancialStatus (
    name VARCHAR(50),
    year INT NOT NULL,
    giniCoefficient FLOAT,
    GDP FLOAT,
    PRIMARY KEY (name, year)
);

Following the creation of the CountriesHaveFinancialStatus table, “financial-status.csv” was imported into it.

Then, added an isoCode column to that temporary table.

ALTER TABLE TemporaryFinancialStatus
ADD COLUMN isoCode VARCHAR(10);

To fill this new column, Countries entity was used. For every country name, corresponding isoCode was written on that line, by looking at the Countries table.

UPDATE TemporaryFinancialStatus, Countries
SET TemporaryFinancialStatus.isoCode = Countries.isoCode
WHERE TemporaryFinancialStatus.name = Countries.countryName;

Then, we create our main table for financial status weak entity.

CREATE TABLE CountriesHaveFinancialStatus (
    isoCode VARCHAR(10),
    year INT NOT NULL,
    GDP FLOAT,
    giniCoefficient FLOAT,
    PRIMARY KEY (isoCode, year),
    FOREIGN KEY (isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE
);

After that, I inserted the data from the temporary table into our main table.

INSERT INTO CountriesHaveFinancialStatus (isoCode, year, GDP, giniCoefficient)
SELECT isoCode, year, GDP, giniCoefficient
FROM TemporaryFinancialStatus;

At the end, I dropped the temporary table.

DROP TABLE TemporaryFinancialStatus;

In conclusion, Have relationship and financial status of the countries was achieved on one table as a result of key constraint of one-to-many relationship. isoCode (foreign key reference from the Countries table) and year attributes are used as primary keys. This table also includes gdp and gini attributes. Additionally, there is a participation constraint for financial status entity, this is one of the reasons why this entity is a weak entity.


Entity 7.  Suicide

Following the creation of the Suicide table, “suicide_final.csv”(UPDATED) was imported into it.
The reason behind updating the file was that encoding of it was not compatible with MYSQL.

CREATE TABLE Suicide(
 isoCode VARCHAR(10) NOT NULL,
 year INTEGER NOT NULL,
 rate float,
 share float,
 ratio float,
 PRIMARY KEY (IsoCode, year),
 FOREIGN KEY (IsoCode) REFERENCES countries(isoCode) ON DELETE CASCADE );

Some of the rows were specified as the regions of the world did not possess an ISO code. Thus those rows were removed from the .csv file, before importing it. Since the data set consists of three particular data imports, some of the tuples were missing the intended attributes. For this reason those cells were completed with “NULL” values.

Furthermore, one of the factors that makes the suicide entity weak is that there is a participation constraint. Since each tuple has to be linked with a country and year, there is a key constraint.
