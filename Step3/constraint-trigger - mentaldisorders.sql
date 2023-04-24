-- Putting some constraints on the table
ALTER TABLE havingpeoplewithmentaldisorders 
ADD CONSTRAINT check_generalprevalence 
CHECK (mentalDisordersPrevalence BETWEEN 0.0 AND 25.0);

-- Testing whether constraints really limits the insertion or not
INSERT INTO havingpeoplewithmentaldisorders
VALUES ("AFG", 2030,0,0,0,0,0,0,0, 45);
-- OUTPUT: Error Code: 3819. Check constraint 'check_generalprevalence' is violated.


-- Creating a trigger so that inserted values must conform with the constraint.
DELIMITER //
CREATE TRIGGER fix_general_prevalence 
BEFORE INSERT ON havingpeoplewithmentaldisorders
FOR EACH ROW 
BEGIN 
	IF NEW.mentalDisordersPrevalence < 0 THEN
		SET NEW.mentalDisordersPrevalence = 0;
	ELSEIF NEW.mentalDisordersPrevalence > 25.0 THEN
		SET NEW.mentalDisordersPrevalence = 25;
	END IF;
END //
DELIMITER ;

-- Testing an insertion which would trigger the insertion trigger
INSERT INTO havingpeoplewithmentaldisorders
VALUES ("AFG", 2030,0,0,0,0,0,0,0, 45);

-- Examining whether trigger is working
SELECT isoCode, year, mentalDisordersPrevalence
FROM havingpeoplewithmentaldisorders
WHERE isoCode = "AFG" AND year = 2030;

-- Removing the value after the process not to give any harm to the original data
DELETE FROM havingpeoplewithmentaldisorders
WHERE isoCode = "AFG" AND year = 2030;

-- Same trigger with the different implementation (before update on)
DELIMITER //
CREATE TRIGGER fix_general_prevalenceUPDATE 
BEFORE UPDATE ON havingpeoplewithmentaldisorders
FOR EACH ROW 
BEGIN 
	IF NEW.mentalDisordersPrevalence < 0 THEN
		SET NEW.mentalDisordersPrevalence = 0;
	ELSEIF NEW.mentalDisordersPrevalence > 25.0 THEN
		SET NEW.mentalDisordersPrevalence = 24.9;
	END IF;
END //
DELIMITER ;

-- Testing an update which would trigger the insertion trigger (previous prevalence is 16.66)
UPDATE havingpeoplewithmentaldisorders
SET mentalDisordersPrevalence = 40
WHERE isoCode = "AFG" AND year = "1990";

-- Examining whether trigger is working
SELECT isoCode, year, mentalDisordersPrevalence
FROM havingpeoplewithmentaldisorders
WHERE isoCode = "AFG" AND year = 1990;

-- Setting the value to its original value after the process not to give any harm to the original data
UPDATE havingpeoplewithmentaldisorders
SET mentalDisordersPrevalence = 16.66
WHERE isoCode = "AFG" AND year = 1990;
