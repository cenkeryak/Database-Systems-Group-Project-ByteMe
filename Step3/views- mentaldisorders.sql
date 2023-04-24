-- Getting view of the prevalences which are greater than the average prevalence. 
CREATE VIEW prevalence_mental_disorders AS 
SELECT mdisorder.isoCode, mdisorder.year, mdisorder.mentalDisordersPrevalence
FROM havingpeoplewithmentaldisorders mdisorder
WHERE  mentalDisordersPrevalence > (SELECT AVG(mdisorder2.mentalDisordersPrevalence)
									FROM havingpeoplewithmentaldisorders mdisorder2);