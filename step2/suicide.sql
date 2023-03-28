CREATE TABLE Suicide(
 IsoCode VARCHAR(10) NOT NULL,
 year INTEGER NOT NULL,
 rate FLOAT,
 share FLOAT,
 ratio FLOAT,
 PRIMARY KEY (IsoCode, year),
 FOREIGN KEY (IsoCode) REFERENCES countries(isoCode) ON DELETE CASCADE );
