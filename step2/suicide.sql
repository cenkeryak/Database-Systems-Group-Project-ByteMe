CREATE TABLE Suicide(
 IsoCode VARCHAR(10) NOT NULL,
 year INTEGER NOT NULL,
 rate float,
 share float,
 ratio float,
 PRIMARY KEY (IsoCode, year),
 FOREIGN KEY (IsoCode) REFERENCES countries(isoCode) ON DELETE CASCADE );
