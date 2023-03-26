CREATE TABLE havingPeopleWithMentalDisorders(
name VARCHAR(50),
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

