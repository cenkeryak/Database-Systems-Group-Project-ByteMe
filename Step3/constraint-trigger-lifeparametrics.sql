ALTER TABLE CountriesPossessLifeParametrics ADD CONSTRAINT check_lifeSat CHECK (lifeSatisfaction BETWEEN 0.0000 AND 10.0000);

#test value insertion, expected to have an error

INSERT INTO CountriesPossessLifeParametrics 
VALUES("TEST",2023,12,78);



DELIMITER //
CREATE TRIGGER fix_lifeSatInsert BEFORE INSERT ON CountriesPossessLifeParametrics 
FOR EACH ROW
BEGIN
    IF NEW.lifeSatisfaction < 0 THEN
		SET NEW.lifeSatisfaction=0;
        
    ELSEIF NEW.lifeSatisfaction > 10 THEN
        
       SET NEW.lifeSatisfaction=10;
    END IF;
END//
DELIMITER ;

#inserting value for lifeSatisfaction which is greater than 10
INSERT INTO CountriesPossessLifeParametrics 
VALUES("TUR",2023,12,78);

# as it can be seen, it is fixed to the value 10
select * from CountriesPossessLifeParametrics 
where isoCode="TUR" AND lifeSatisfaction=10;

# deleting value after the process not to give any harm to the original data
DELETE FROM CountriesPossessLifeParametrics 
where isoCode="TUR" AND lifeSatisfaction=10;






DELIMITER //
CREATE TRIGGER fix_lifeSatUpdate BEFORE UPDATE ON CountriesPossessLifeParametrics 
FOR EACH ROW
BEGIN
    IF NEW.lifeSatisfaction < 0 THEN
		SET NEW.lifeSatisfaction=0;
        
    ELSEIF NEW.lifeSatisfaction > 10 THEN
        
       SET NEW.lifeSatisfaction=10;
    END IF;
END//
DELIMITER ;

SELECT * from CountriesPossessLifeParametrics 
WHERE isoCode="TUR" AND year=2020;
#initial value was 4.74

UPDATE CountriesPossessLifeParametrics 
SET lifeSatisfaction=25
WHERE isoCode="TUR" AND year=2020;

# update value gets fixed to 10
SELECT * from CountriesPossessLifeParametrics 
WHERE isoCode="TUR" AND year=2020;

#updating back to its original value
UPDATE CountriesPossessLifeParametrics 
SET lifeSatisfaction=4.74
WHERE isoCode="TUR" AND year=2020;


