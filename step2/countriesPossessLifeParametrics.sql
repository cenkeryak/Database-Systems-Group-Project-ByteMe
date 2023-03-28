CREATE TABLE CountriesPossessLifeParametrics(
    isoCode VARCHAR(10) NOT NULL,
    year int NOT NULL,
    lifeSat DOUBLE,
    lifeSatisfaction DOUBLE,
    lifeExpectancy DOUBLE,
    PRIMARY KEY(isoCode,year),
    FOREIGN KEY(isoCode) REFERENCES Countries(isoCode) ON DELETE CASCADE
);
